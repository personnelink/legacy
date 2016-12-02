<%
'---- CursorTypeEnum Values ----
Const adOpenForwardOnly = 0
Const adOpenKeyset = 1
Const adOpenDynamic = 2
Const adOpenStatic = 3

'---- CursorOptionEnum Values ----
Const adHoldRecords = &H00000100
Const adMovePrevious = &H00000200
Const adAddNew = &H01000400
Const adDelete = &H01000800
Const adUpdate = &H01008000
Const adBookmark = &H00002000
Const adApproxPosition = &H00004000
Const adUpdateBatch = &H00010000
Const adResync = &H00020000
Const adNotify = &H00040000

'---- LockTypeEnum Values ----
Const adLockReadOnly = 1
Const adLockPessimistic = 2
Const adLockOptimistic = 3
Const adLockBatchOptimistic = 4
' ------------------------------------------------------------------
'  Database Connection
' ------------------------------------------------------------------
Set Connect = Server.CreateObject("ADODB.Connection")
'Connect.Open "DBQ=\jobdata\ppi.mdb;Driver={Microsoft Access Driver (*.mdb)};"
'Connect.Open "DBQ=\jobdata\ppi.mdb;Driver={Microsoft Access Driver (*.mdb)};"
'accessdb=server.mappath("\lweb\jobdata\ppi.mdb")
accessdb=Server.MapPath("\lweb\jobdata\ppi.mdb")
set Connect = server.createobject("ADODB.Connection")
Connect.open "PROVIDER=MICROSOFT.JET.OLEDB.4.0;DATA SOURCE=" & accessdb & ""

' ------------------------------------------------------------------
'  ConvertString
' ------------------------------------------------------------------
Public Function ConvertString(strIn) 
	' convert "'" in strings to "''"
	Dim intPos, strOut
	strOut = ""
	intPos = InStr(strIn, "'")
	Do Until intPos = 0
		strOut = strOut + Mid(strIn, 1, intPos) + "'"
		strIn = Mid(strIn, intPos + 1)
		intPos = InStr(strIn, "'")
	Loop
	strOut = strOut & strIn
	ConvertString = strOut
End Function
' ------------------------------------------------------------------
'  PCase
' ------------------------------------------------------------------
Public Function PCase(strInput)
	Dim iPosition  ' Our current position in the string (First character = 1)
	Dim iSpace     ' The position of the next space after our iPosition
	Dim strOutput  ' Our temporary string used to build the function's output

	' Set our position variable to the start of the string.
	iPosition = 1
	
	' We loop through the string checking for spaces.
	' If there are unhandled spaces left, we handle them...
	Do While InStr(iPosition, strInput, " ", 1) <> 0
		' To begin with, we find the position of the offending space.
		iSpace = InStr(iPosition, strInput, " ", 1)
		
		' We uppercase (and append to our output) the first character after
		' the space which was handled by the previous run through the loop.
		strOutput = strOutput & UCase(Mid(strInput, iPosition, 1))
		
		' We lowercase (and append to our output) the rest of the string
		' up to and including the current space.
		strOutput = strOutput & LCase(Mid(strInput, iPosition + 1, iSpace - iPosition))

		' Note:
		' The above line is something you may wish to change to not convert
		' everything to lowercase.  Currently things like "McCarthy" end up
		' as "Mccarthy", but if you do change it, it won't fix things like
		' ALL CAPS.  I don't see an easy compromise so I simply did it the
		' way I'd expect it to work and the way the VB command
		' StrConv(string, vbProperCase) works.  Any other functionality is
		' left "as an exercise for the reader!"
		
		' Set our location to start looking for spaces to the
		' position immediately after the last space.
		iPosition = iSpace + 1
	Loop

	' Because we loop until there are no more spaces, it leaves us
	' with the last word uncapitalized so we handle that here.
	' This also takes care of capitalizing single word strings.
	' It's the same as the two lines inside the loop except the
	' second line LCase's to the end and not to the next space.
	strOutput = strOutput & UCase(Mid(strInput, iPosition, 1))
	strOutput = strOutput & LCase(Mid(strInput, iPosition + 1))

	' That's it - Set our return value and exit
	PCase = strOutput
End Function
' ------------------------------------------------------------------
'  StripCharacters
' ------------------------------------------------------------------
Function StripCharacters (s)

	Dim re

	Set re = New RegExp
	re.Pattern = "[<>'$]"
	re.Global = True
	
	StripCharacters = re.Replace(s, "")

End Function

%>