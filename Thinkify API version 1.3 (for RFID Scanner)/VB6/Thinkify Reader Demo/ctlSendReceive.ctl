VERSION 5.00
Begin VB.UserControl ctlSendReceive 
   BackStyle       =   0  'Transparent
   ClientHeight    =   5790
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6990
   ScaleHeight     =   5790
   ScaleWidth      =   6990
   Begin VB.CommandButton cmdClearText 
      Caption         =   "Clear Text"
      BeginProperty Font 
         Name            =   "Microsoft Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   120
      TabIndex        =   3
      ToolTipText     =   "Clear the receive buffer."
      Top             =   5040
      Width           =   6615
   End
   Begin VB.ComboBox cmbSend 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   390
      Left            =   120
      TabIndex        =   2
      ToolTipText     =   "Type commands here. Hit Enter to send."
      Top             =   4440
      Width           =   4935
   End
   Begin VB.CommandButton cmdSend 
      Caption         =   "Send"
      BeginProperty Font 
         Name            =   "Microsoft Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   5160
      TabIndex        =   1
      ToolTipText     =   "Click to send a command."
      Top             =   4440
      Width           =   1575
   End
   Begin VB.TextBox txtReceive 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4215
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   120
      Width           =   6615
   End
End
Attribute VB_Name = "ctlSendReceive"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private bMonitorComm As Boolean
Public Event SendString(s As String)

Public Property Let MonitorComm(b As Boolean)
  bMonitorComm = b
End Property

Public Property Get MonitorComm() As Boolean
  MonitorComm = bMonitorComm
End Property

Public Sub AppendText(s As String)
  txtReceive.text = txtReceive.text & s '& vbCrLf
  txtReceive.SelStart = Len(txtReceive.text)
End Sub

Public Property Let text(t As String)
 ' Debug.Print Asc(Mid(t, 1, 1))
  t = Replace(t, Chr(0), "")
  txtReceive.text = t
  txtReceive.SelStart = Len(txtReceive.text)
End Property

Public Property Get text() As String
  
  text = txtReceive.text

End Property

Private Sub cmbSend_KeyPress(KeyAscii As Integer)
  If KeyAscii = 2 Then
    RaiseEvent SendString(Chr(2))
  End If
  
End Sub

Private Sub cmbSend_KeyUp(KeyCode As Integer, Shift As Integer)
  
  If KeyCode = 13 Then
   Call cmdSend_Click
  End If
  
End Sub

Private Sub cmdClearText_Click()
  txtReceive.text = ""
End Sub

Private Sub cmdSend_Click()

  RaiseEvent SendString(CStr(cmbSend))
  
  
  Dim itemFound As Boolean
  Dim i As Integer
  
  
  For i = 0 To cmbSend.ListCount - 1
   If cmbSend.text = cmbSend.List(i) Then itemFound = True
  Next i
  
  If Not itemFound Then
  cmbSend.AddItem (cmbSend.text)
  End If
  
  
End Sub


Private Sub UserControl_Initialize()
  bMonitorComm = True
End Sub

Private Sub UserControl_Resize()
  txtReceive.Left = 10
  cmbSend.Left = 10
  cmdClearText.Left = 10
  
  txtReceive.Top = 0
  txtReceive.Width = UserControl.Width - txtReceive.Left * 2
  
  cmbSend.Width = txtReceive.Width - cmdSend.Width - cmbSend.Left * 2
    
  txtReceive.Height = UserControl.Height - cmdSend.Height * 2 - 10
  
  cmbSend.Top = txtReceive.Height + 10
  cmdSend.Top = txtReceive.Height + 10
  cmdSend.Left = cmbSend.Left + cmbSend.Width + 10
  
  cmdClearText.Width = UserControl.Width - 20
  cmdClearText.Top = cmdSend.Top + cmdSend.Height + 5
    
End Sub
