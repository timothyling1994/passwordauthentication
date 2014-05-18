Attribute VB_Name = "utilityFunctions"


Public Declare Function GetTickCount Lib "kernel32" () As Long


'A little function to reformat strings, showing cr/lf symbols.
Public Function strDump(str As String)

    Dim i As Integer
    Dim retval As String
    Dim thisChar As String
    
    For i = 1 To Len(str)
        thisChar = Mid(str, i, 1)
        If thisChar = vbLf Then
          retval = retval & "[LF]"
        ElseIf thisChar = vbCr Then
           retval = retval1 & "[CR]"
        Else
          retval = retval & "[" & Mid(str, i, 1) & "]"
        End If
    Next i
    
    strDump = retval
     
End Function

