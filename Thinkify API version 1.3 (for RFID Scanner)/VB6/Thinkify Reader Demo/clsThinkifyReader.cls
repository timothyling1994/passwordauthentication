VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsThinkifyReader"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'Reader Needs a comport
Dim WithEvents myComPort As MSComm
Attribute myComPort.VB_VarHelpID = -1
Dim WithEvents myTimer As Timer
Attribute myTimer.VB_VarHelpID = -1


Dim RXBuffer As String
Dim ReaderReply As String

Dim bReading As Boolean
Dim bTagSeen As Boolean

Dim bReaderReady As Boolean
Dim bMsgPending As Boolean

Dim tStart As Long

Public Event TagUpdated(tagid As String, count As Long, TagListIndex As Integer)
Public Event TagAdded(tagid As String, TagListIndex As Integer)

Public Event CommandSent(message As String)
Public Event ReplyReceived(message As String)
Public Event dataReceived(message As String)

Private Const cMsgTerm = "READY>"

Public Property Get reading() As Boolean
    reading = bReading
End Property

Public Property Let reading(newval As Boolean)
    
    If newval = False Then
      sendReceive ("")
    Else
      send ("t6") 'Let's use a fixed q inventory for starters...
    End If

    bReading = newval
    
End Property

Public Sub setEPCMask(ptr As String, dataLen As String, m As String)
    Dim mask_cmd As String
    
    If m = "-1" Then
      'clear the masks...
      mask_cmd = "mr"
      execute (mask_cmd)
    Else
      ptr = Replace(ptr, " ", "")
      mask_cmd = "M01001" + dataLen + ptr + m
      execute (mask_cmd)
    End If
   
End Sub



Public Sub send(data As String)
    RXBuffer = ""
    ReaderReply = ""
    bReaderReady = False
    myComPort.Output = data & vbCrLf
    RaiseEvent CommandSent(data)
End Sub

Public Function receive() As String
    Dim t As clsTimer
    
    Set t = New clsTimer
    t.TimeOutValue = 1000
    t.Start
    
    While (bReaderReady = False) And t.TimedOut = False
        DoEvents
    Wend
    
    If t.TimedOut Then
        Debug.Print "Com Timeout!"
        receive = "Error: Comm Timeout."
    Else
        RaiseEvent ReplyReceived(ReaderReply)
        receive = ReaderReply
    End If
        
End Function


Public Function sendReceive(data As String) As String
    If bMsgPending Then
        Debug.Print "Reentrance Problem in Send-Receive"
    Else
        bMsgPending = True
        send (data)
        sendReceive = receive
        bMsgPending = False
    End If
End Function

Public Function execute(data As String) As String
    Dim reply As String
    
    If reading Then
       reading = False
       sendReceive (data)
       reading = True
    Else
       reply = sendReceive(data)
    End If
    
    execute = reply
    
End Function


Private Sub ProcessTagList(thisTag As tagListElement)
    Dim i As Integer
    Dim j As Integer
    
    bTagSeen = True
    
    Dim totalCount As Single
    
    For i = 0 To UBound(TagList)
        If TagList(i).epc = thisTag.epc Then
        
          TagList(i).count = TagList(i).count + thisTag.count
          
          TagList(i).rssi = thisTag.rssi
          
          For j = 0 To 3
            If thisTag.xrdata(j) <> "" Then TagList(i).xrdata(j) = thisTag.xrdata(j)
          Next j
          
          RaiseEvent TagUpdated(TagList(i).epc, TagList(i).count, i)
          
          GoTo breakout
          
        End If
        
    Next i

breakout:

    Dim bNewTag As Boolean
    
    If i = UBound(TagList) + 1 Then
      
      bNewTag = True
      
      Dim tagListLength As Integer
      
      tagListLength = UBound(TagList) + 1
      
      ReDim Preserve TagList(tagListLength)
      
      TagList(tagListLength).epc = thisTag.epc
      TagList(tagListLength).count = thisTag.count
      TagList(tagListLength).rssi = thisTag.rssi
      For j = 0 To 3
        TagList(tagListLength).xrdata(j) = thisTag.xrdata(j)
      Next j
             
      RaiseEvent TagAdded(TagList(tagListLength).epc, tagListLength)

      
    End If
    
End Sub

'Take a line of text from the reader and construct a taglistelement
'We expect each line to contain the elements returned from a T6 inventory.
Private Function createTagListElement(strData) As tagListElement

    Dim tle As tagListElement
    Dim TagData

    If InStr(strData, "TAG") Then
        
        'looks like a taglist entry. clean it up...
        strData = Right(strData, Len(strData) - InStr(strData, "="))
        strData = Replace(strData, vbCr, "")
        strData = Replace(strData, vbLf, "")
        
        '
        TagData = Split(strData, " ")
        
        If UBound(TagData) <> 6 Then
            'we've got a problem.
            Debug.Print UBound(TagData)
            TagData(0) = Trim(TagData(0))
            
            'tle.epc = Right(TagData(0), Len(TagData(0)) - 4)
            'createTagListElement = tle
            Exit Function
        End If
        
        TagData(0) = Trim(TagData(0))
        tle.epc = Right(TagData(0), Len(TagData(0)) - 4)
        tle.frequency = CSng(TagData(1)) / 1000
        tle.count = 1
        
        'calculate the RSSI from the i and q magnitudes
        Dim high_rssi As Single
        Dim delta_rssi As Single
        Dim imag As Single
        Dim qmag As Single
        
        imag = CSng("&H" & TagData(3))
        qmag = CSng("&H" & TagData(4))
        
        If imag > qmag Then
         high_rssi = imag
        Else
         high_rssi = qmag
        End If
         
        delta_rssi = Abs(imag - qmag)
    
        tle.rssi = 2 * high_rssi + 10 * Log(1 + 10 ^ (-delta_rssi / 10))
        
        
    End If
    
    createTagListElement = tle
        
End Function


Private Sub processData()
    
    Dim ThisLine As String
    Dim TagData
    Dim tagid
    Dim rssi
    Dim thisTag As tagListElement
    Static lastTag As tagListElement
    
    
    'process completed lines of data...
    
    'check for terminator
    If InStr(RXBuffer, cMsgTerm) Then
        RXBuffer = Left(RXBuffer, InStr(RXBuffer, cMsgTerm) - 1)
        bReaderReady = True
    End If
    
    While InStr(RXBuffer, vbLf)
        
        ThisLine = Left(RXBuffer, InStr(RXBuffer, vbLf))
        ThisLine = Replace(ThisLine, vbLf, vbCrLf)
    
        'We're in send-receive mode...
        If bReading = False Then
        
            RaiseEvent dataReceived(ThisLine)
            ReaderReply = ReaderReply & ThisLine
        
        End If
        
        If InStr(ThisLine, "TAG=") Then
            
            thisTag = createTagListElement(ThisLine)

            Call ProcessTagList(thisTag) '.epc, thisTag.rssi)
            
            lastTag = thisTag
            
        End If
            
        If InStr(ThisLine, "XRD") Then
            Dim strData As String
            strData = ThisLine
            strData = Right(strData, Len(strData) - InStr(strData, "="))
            strData = Replace(strData, vbCr, "")
            strData = Replace(strData, vbLf, "")
            'If strData <> "RESPONSE FAILURE" Then
              If InStr(ThisLine, "XRD0") Then
                lastTag.xrdata(0) = strData
              End If
              If InStr(ThisLine, "XRD1") Then
                lastTag.xrdata(1) = strData
              End If
              If InStr(ThisLine, "XRD2") Then
                lastTag.xrdata(2) = strData
              End If
              If InStr(ThisLine, "XRD3") Then
                lastTag.xrdata(3) = strData
              End If
            'End If
            Call ProcessTagList(lastTag)
        End If
        
            
        RXBuffer = Right(RXBuffer, Len(RXBuffer) - InStr(RXBuffer, vbLf))
    
    Wend


End Sub


Private Function probeComPorts() As Integer
  Dim i As Integer
    
  With myComPort
    
    On Error Resume Next
    
    For i = 1 To 8
    
        If .PortOpen = True Then .PortOpen = False
        .CommPort = i
        .PortOpen = True
        If .PortOpen Then
         Debug.Print "Port Found! on Com" & i
         Debug.Print "Checking for Reader..."
         If InStr(sendReceive("v"), "Error") = 0 Then
          probeComPorts = i
          Exit Function
        End If
                
        Else
         Debug.Print "No port found on Com" & i
        End If
    
    Next i
    
    
  End With

End Function


Private Sub myTimer_Timer()
  If myComPort.InBufferCount > 0 Then
     RXBuffer = RXBuffer & myComPort.Input
     processData
  End If
End Sub


Public Sub setControls(aComPort As MSComm, aTimer As Timer)
  Set myComPort = aComPort
   ' 115200 baud, no parity, 8 data, and 1 stop bit.
   myComPort.Settings = "115200,N,8,1"
   ' Tell the control to read entire buffer when Input
   ' is used.
   myComPort.InputLen = 0
   ' Generate events on single characters
   myComPort.RThreshold = 1
    
  
  Set myTimer = aTimer
  myTimer.Interval = 50
  myTimer.Enabled = True
  
End Sub

Public Function Connect() As Boolean
  RXBuffer = ""
  Dim ComPort As Integer
  
  ComPort = probeComPorts
  
  If ComPort = 0 Then
    Connect = False
    Exit Function
  End If

  With myComPort
    If .PortOpen = True Then .PortOpen = False
    .CommPort = ComPort
    .PortOpen = True
  End With
  
  Connect = True
  
End Function


Public Function program_epc(newepc As String) As Boolean
    Dim sr As String
    Dim epc_words As Integer
    Dim retvalue As Boolean

    'our reader has the option to do multiple write operations at once...
    'kinda cool, but I'm going to limit it to one in this function...
    
    'Strip spaces...
    newepc = Replace(newepc, " ", "")
    
    epc_words = Len(newepc) / 4
    
    'Enable the write descriptor = 2 to allow change of pc word.
    sr = execute("xw021" & Trim(str(epc_words)) & "02" & newepc)

    
    'make up to three attempts
    sr = execute("t65")
    
    If InStr(sr, "XWR0=SUCCESS") Then
        retvalue = True
    Else
        retvalue = False
    End If
    
    'Disable programming.
    sr = execute("xw00")
    
    program_epc = retvalue
    
  
End Function



Public Function program_user(pointer As String, userdata As String) As Boolean
    Dim sr As String
    Dim user_words As Integer
    Dim retvalue As Boolean

    'our reader has the option to do multiple write operations at once...
    'kinda cool, but I'm going to limit it to one in this function...
    
    'Strip spaces...
    userdata = Replace(userdata, " ", "")
    
    user_words = Len(userdata) / 4
    
    'Enable the write descriptor = 2 to allow change of pc word.
    sr = execute("xw013" & Trim(str(user_words)) & Trim(pointer) & userdata)

    
    'make up to three attempts
    sr = execute("t63")
    
    If InStr(sr, "XWR0=SUCCESS") Then
        retvalue = True
    Else
        retvalue = False
    End If
    
    'Disable programming.
    sr = execute("xw00")
    
    program_user = retvalue
    
  
End Function
