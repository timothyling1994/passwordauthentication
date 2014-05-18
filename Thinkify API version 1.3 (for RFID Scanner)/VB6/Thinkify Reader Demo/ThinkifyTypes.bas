Attribute VB_Name = "ThinkifyTypes"
'A couple of shared data structures

'Tag lists can hold lots of different information.
'Right now we're holding the ID, read count and peak signal strength.
Public Type tagListElement
    epc As String
    frequency As Single
    count As Long
    rssi As Single
    xrdata(3) As String
End Type

'Global structure for tags.
Global TagList() As tagListElement
