VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTimer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Private Declare Function GetTickCount Lib "kernel32" () As Long

Dim T1 As Long
Dim T2 As Long
Dim lTimeout As Long

Public Event TimeOut()


Public Sub Start()

    T1 = GetTickCount
    
End Sub

Public Function ElapsedTime() As Long
    
    T2 = GetTickCount
    ElapsedTime = T2 - T1
    
    If ElapsedTime > lTimeout Then RaiseEvent TimeOut
    
End Function

Public Property Get TimeOutValue() As Long

    TimeOutValue = lTimeout
    
End Property

Public Property Let TimeOutValue(t As Long)

    lTimeout = t
    
End Property

Public Function TimedOut() As Boolean
    TimedOut = (ElapsedTime >= lTimeout)
End Function


