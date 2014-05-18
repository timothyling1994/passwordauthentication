VERSION 5.00
Begin VB.Form frmSplash 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   4875
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   9105
   Icon            =   "frmSplash.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4875
   ScaleWidth      =   9105
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox Picture1 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      FillColor       =   &H00FFFFFF&
      Height          =   3960
      Left            =   0
      Picture         =   "frmSplash.frx":0CCA
      ScaleHeight     =   3960
      ScaleWidth      =   9000
      TabIndex        =   6
      Top             =   120
      Width           =   9000
   End
   Begin VB.PictureBox Picture2 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   4575
      Left            =   0
      ScaleHeight     =   4575
      ScaleWidth      =   9015
      TabIndex        =   1
      Top             =   120
      Width           =   9015
      Begin VB.CommandButton cmdOK 
         Caption         =   "&Ok"
         Default         =   -1  'True
         Height          =   495
         Left            =   7440
         TabIndex        =   0
         Top             =   3360
         Width           =   1332
      End
      Begin VB.Label Labels 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "Copyright 2008,Thinkify LLC.  All rights reserved."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   1170
         Index           =   3
         Left            =   1560
         TabIndex        =   5
         Top             =   1440
         Width           =   5955
      End
      Begin VB.Label Labels 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         Caption         =   "Copyright 2008,Thinkify LLC.  All rights reserved."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   450
         Index           =   2
         Left            =   1560
         TabIndex        =   4
         Top             =   2640
         Width           =   5955
      End
      Begin VB.Label Labels 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         BackColor       =   &H00FFFFFF&
         Caption         =   "Program Title"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   540
         Index           =   0
         Left            =   1560
         TabIndex        =   3
         Top             =   240
         Width           =   5955
      End
      Begin VB.Label Labels 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         BackColor       =   &H00FFFFFF&
         Caption         =   "Version Number"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   18
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   405
         Index           =   1
         Left            =   1560
         TabIndex        =   2
         Top             =   840
         Width           =   5955
      End
   End
   Begin VB.Timer Timer1 
      Interval        =   2000
      Left            =   0
      Top             =   120
   End
End
Attribute VB_Name = "frmSplash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Private Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Private Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lpFileName As String) As Long

Private Function GetFromIni(Filename As String, Section As String, Key As String) As String
 Dim strReturn As String
 
 strReturn = String$(255, " ")  'Pad the string first!

 Call GetPrivateProfileString(Section, Key, "0", strReturn, 255, Filename)
 
 strReturn = Trim(strReturn)
   
 GetFromIni = Left(strReturn, Len(strReturn) - 1)

End Function

Private Sub cmdOK_Click()
 
 WritePrivateProfileString "UpdateInformation", "Description", """" & App.ProductName & """", App.Path & "\" & "UpdateInfo.ini"
 WritePrivateProfileString "UpdateInformation", "ExeLocation", """" & App.EXEName & ".exe" & """", App.Path & "\" & "UpdateInfo.ini"
 WritePrivateProfileString "UpdateInformation", "CurrentVersion", """" & App.Major & "." & App.Minor & "." & App.Revision & """", App.Path & "\" & "UpdateInfo.ini"
 'WritePrivateProfileString "UpdateInformation", "UpdateDir", """" & "H:\Alien Software Updates\" & App.ProductName & "\" & """", App.Path & "\" & "UpdateInfo.ini"
 'WritePrivateProfileString "UpdateInformation", "Updater", """" & "AutoUpdate.cmd" & """", App.Path & "\" & "UpdateInfo.ini"
 
 Unload Me
 
End Sub

Private Sub Form_Load()
 Me.Caption = "About " & App.ProductName
 Labels(0).Caption = App.ProductName
 Labels(1).Caption = "Version " & App.Major & "." & App.Minor & "." & App.Revision
 Labels(2).Caption = App.LegalCopyright
 Labels(3).Caption = App.FileDescription
End Sub

Private Sub Timer1_Timer()
 cmdOK_Click
Picture1.Visible = False
End Sub
