VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Begin VB.Form frmThinkifyReader 
   BackColor       =   &H00000000&
   Caption         =   "&H8000000F&"
   ClientHeight    =   9855
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   13215
   Icon            =   "thinkifyreader.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   9855
   ScaleWidth      =   13215
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer Timer1 
      Interval        =   50
      Left            =   10560
      Top             =   120
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   9840
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      CommPort        =   3
      DTREnable       =   -1  'True
      InputLen        =   1
      RThreshold      =   1
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   7815
      Left            =   360
      TabIndex        =   0
      Top             =   1080
      Width           =   12615
      _ExtentX        =   22251
      _ExtentY        =   13785
      _Version        =   393216
      Style           =   1
      Tabs            =   2
      TabHeight       =   882
      BackColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Tag List"
      TabPicture(0)   =   "thinkifyreader.frx":64A2
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "lblCount"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "cmdClear"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "Command1"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "List1"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "Picture1"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).ControlCount=   5
      TabCaption(1)   =   "Command Line Interface"
      TabPicture(1)   =   "thinkifyreader.frx":64BE
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "ctlSendReceive1"
      Tab(1).ControlCount=   1
      Begin VB.PictureBox Picture1 
         AutoSize        =   -1  'True
         BorderStyle     =   0  'None
         Height          =   3000
         Left            =   10440
         Picture         =   "thinkifyreader.frx":64DA
         ScaleHeight     =   200
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   82
         TabIndex        =   7
         Top             =   4560
         Width           =   1230
      End
      Begin VB.ListBox List1 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   18
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   5730
         Left            =   240
         Sorted          =   -1  'True
         TabIndex        =   5
         Top             =   840
         Width           =   9015
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Read Tags"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   18
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Left            =   9960
         TabIndex        =   3
         Top             =   960
         Width           =   2175
      End
      Begin VB.CommandButton cmdClear 
         Caption         =   "Clear List"
         Height          =   495
         Left            =   1080
         TabIndex        =   2
         Top             =   6960
         Width           =   7815
      End
      Begin Thinkify.ctlSendReceive ctlSendReceive1 
         Height          =   6615
         Left            =   -74760
         TabIndex        =   1
         Top             =   840
         Width           =   11655
         _extentx        =   20558
         _extenty        =   11668
      End
      Begin VB.Label lblCount 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Tags: 0"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   555
         Left            =   10200
         TabIndex        =   4
         Top             =   3120
         Width           =   1635
      End
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "...by Thinkify "
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   585
      Left            =   9960
      TabIndex        =   9
      Top             =   9000
      Width           =   2925
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "TR200 "
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   585
      Left            =   1080
      TabIndex        =   8
      Top             =   240
      Width           =   1500
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "The           RFID Reader "
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C0C0C0&
      Height          =   585
      Left            =   240
      TabIndex        =   6
      Top             =   240
      Width           =   5340
   End
End
Attribute VB_Name = "frmThinkifyReader"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim RXBuffer As String
Dim ReaderReply As String

Dim bReading As Boolean
Dim bTagSeen As Boolean

Dim bReaderReady As Boolean
Dim bMsgPending As Boolean

Dim tStart As Long

Public Event tagUpdated(tagid As String, count As Long, TagListIndex As Integer)
Public Event tagAdded(tagid As String, TagListIndex As Integer)
Public Event TagListCleared()

Public Event CommandSent(message As String)
Public Event ReplyReceived(message As String)

Private Const cMsgTerm = "READY>"

Private Sub send(Data As String)
        
    RXBuffer = ""
    ReaderReply = ""
    bReaderReady = False
    MSComm1.Output = Data & vbCrLf
    
    RaiseEvent CommandSent(Data)
    
End Sub

Private Function receive() As String
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


Private Function sendreceive(Data As String) As String
    If bMsgPending Then
        Debug.Print "Reentrance Problem in Send-Receive"
    Else
        bMsgPending = True
        send (Data)
        sendreceive = receive
        bMsgPending = False
    End If
End Function


Private Sub process_tag_list(tagid)
    Dim i As Integer
    
    bTagSeen = True
    
    Dim totalCount As Single
    
    For i = 0 To UBound(taglist)
        If taglist(i).id = tagid Then
        
          taglist(i).count = taglist(i).count + 1
          
          RaiseEvent tagUpdated(taglist(i).id, taglist(i).count, i)
          
          GoTo breakout
          
        End If
        
        
    Next i

breakout:

    Dim bNewTag As Boolean
    
    If i = UBound(taglist) + 1 Then
      
      bNewTag = True
      
      ReDim Preserve taglist(UBound(taglist) + 1)
      
      taglist(UBound(taglist)).id = tagid
      taglist(UBound(taglist)).count = 1
      
      
      RaiseEvent tagAdded(taglist(UBound(taglist)).id, UBound(taglist))

      
    End If
    
    
    Dim strTaglist As String
    List1.clear
    
    For i = 1 To UBound(taglist)
        
        strTaglist = strTaglist & taglist(i).id & vbTab & taglist(i).count & vbCrLf
        
        List1.AddItem taglist(i).id & vbTab & taglist(i).count
        
        totalCount = totalCount + taglist(i).count
     
    Next i
    
    Dim strCountCaption As String
    strCountCaption = "Tags: " & UBound(taglist) & vbCrLf & "Count: " & totalCount
    lblCount.Caption = strCountCaption
  

End Sub



Private Sub process_data()
    
    Dim ThisLine As String
    Dim TagData
    Dim tagid
    
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
           
            ctlSendReceive1.AppendText ThisLine

            ReaderReply = ReaderReply & ThisLine
            
        End If
        
        If InStr(ThisLine, "TAG") Then
            
            ThisLine = Right(ThisLine, Len(ThisLine) - InStr(ThisLine, "="))
            
            ThisLine = Replace(ThisLine, vbCrLf, "")
            
            TagData = Split(ThisLine, " ")
            
            If UBound(TagData) <> 7 Then
                Debug.Print UBound(TagData)
            End If
            
            tagid = TagData(0)
            
            process_tag_list (tagid)
            
        End If
            
        RXBuffer = Right(RXBuffer, Len(RXBuffer) - InStr(RXBuffer, vbLf))
    
    Wend


End Sub

Public Sub ClearTaglist()
  ReDim taglist(0) As tag_list_element
  List1.clear
  lblCount.Caption = "Tags: 0" & vbCrLf & "Count: 0"
  RaiseEvent TagListCleared

End Sub

Private Sub cmdClear_Click()
    ClearTaglist
    
End Sub


Public Sub StartReading()
    bReading = True
    Command1.Caption = "STOP"
    tStart = GetTickCount
    
    'Tell the reader to start reading tags with the current parameters.
    send ("t6")

End Sub

Public Sub StopReading()
  
    bReading = False
    Command1.Caption = "Read Tags"
    'Sending a character in an inventory loop will stop reading.
    send (" ")

End Sub

Private Sub Command1_Click()
  If bReading Then
    StopReading
  Else
    StartReading
  End If
End Sub

Private Sub ctlSendReceive1_SendString(s As String)
  send (s)
End Sub

Private Sub DemoForm_clear()
 cmdClear_Click
End Sub

Private Sub DemoForm_readeractivate()
  Command1_Click
End Sub

Private Sub DemoForm_readerdeactivate()
  Command1_Click
End Sub

Private Function ProbeComPorts() As Integer
  Dim i As Integer
  
  
  With MSComm1
     
   ' 115200 baud, no parity, 8 data, and 1 stop bit.
   .Settings = "115200,N,8,1"
   ' Tell the control to read entire buffer when Input
   ' is used.
   .InputLen = 0
   ' Open the port.
    .RThreshold = 1
    
    On Error Resume Next
    
    For i = 1 To 8
    
        If .PortOpen = True Then .PortOpen = False
        .CommPort = i
        .PortOpen = True
        If .PortOpen Then
         Debug.Print "Port Found! on Com" & i
         Debug.Print "Checking for Reader..."
         If InStr(sendreceive("v"), "Error") = 0 Then
          ProbeComPorts = i
          Exit Function
        End If
                
        Else
         Debug.Print "No port found on Com" & i
        End If
    
    Next i
    
    
  End With


End Function


Private Sub Form_Load()
  RXBuffer = ""

  Dim ComPort As Integer
  
  ComPort = ProbeComPorts
  
  If ComPort = 0 Then
    MsgBox "No Thinkify reader found! Please check connections and restart. Click OK to exit.", vbCritical
    EndProgram = True
    Unload Me
    
  End If

    
  With MSComm1
    If .PortOpen = True Then .PortOpen = False
    
    .CommPort = ComPort
   ' 115200 baud, no parity, 8 data, and 1 stop bit.
   .Settings = "115200,N,8,1"
   ' Tell the control to read entire buffer when Input
   ' is used.
   .InputLen = 0
   ' Open the port.
    .RThreshold = 1
    .PortOpen = True
  End With
  
  ReDim taglist(0) As tag_list_element
  
  bReading = False
  
  Me.Caption = App.ProductName & "  Version " & App.Major & "." & App.Minor & "." & App.Revision
  
  
End Sub

Private Sub Form_Unload(Cancel As Integer)
 End
End Sub


Private Sub DataReceived(Data As String)
      RXBuffer = RXBuffer & Data
      process_data
End Sub

Private Sub Timer1_Timer()

  Dim strTemp As String

  If MSComm1.InBufferCount > 0 Then
     strTemp = MSComm1.Input
     DataReceived (strTemp)
  End If

End Sub
