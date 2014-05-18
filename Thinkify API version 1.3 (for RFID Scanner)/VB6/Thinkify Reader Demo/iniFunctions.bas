Attribute VB_Name = "IniFunctions"
'Functions for reading / writing data to and from .ini files.
Option Explicit

Public Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lpFileName As String) As Long
Public Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long

'Grab data out of a .ini file.
'we can use mulit-line data by substituting the <vbcrlf> token for a real crlf on the read.
Public Function GetFromIni(Filename As String, Section As String, Key As String) As String
 Dim strReturn As String
 Dim stringSize As Integer
 
 stringSize = 2047
    
 strReturn = String$(stringSize, " ")  'Pad the string
 Call GetPrivateProfileString(Section, Key, "0", strReturn, stringSize, Filename)
 
 strReturn = Replace(strReturn, "<vbcrlf>", vbCrLf)
 strReturn = Trim(strReturn)
 GetFromIni = Left(strReturn, Len(strReturn) - 1)

End Function


'Use the GetFromIni function to create an array of data.
'Our convention will be to have an ini file constructed like this:
'[section]
'maxindex = X
'0=asdfasdf
'1=asdfa safasd as
'2=asfcxasdf
'...
'X=asdfa
'
'If maxindex is missing as a key, the function will exit and return nil.
'Care should be taken to ensure sufficent keys are present.
Public Function GetArrayFromIni(Filename As String, Section As String)

    Dim Data() As String
    Dim maxIndex As Integer
    Dim i As Integer
        
    maxIndex = GetFromIni(Filename, Section, "maxindex")
        
    For i = 0 To maxIndex
        ReDim Preserve Data(i) As String
        Data(i) = GetFromIni(Filename, Section, str(i))
    Next i
    
    GetArrayFromIni = Data
    
End Function
