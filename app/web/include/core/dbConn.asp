<%
' ------------------------------------------------------------------
'  Database Connection
' ------------------------------------------------------------------
Set Connect = Server.CreateObject("ADODB.Connection")
accessdb=server.mappath("/include/database/pplusVMS.mdb")
set Connect = server.createobject("ADODB.Connection")
Connect.open "PROVIDER=MICROSOFT.JET.OLEDB.4.0;DATA SOURCE=" & accessdb & ""

' ------------------------------------------------------------------
'  ConvertString
' ------------------------------------------------------------------
Public Function ConvertString(strIn) 
	' convert "'" in strings to "''"
	dim intPos, strOut
	strOut = ""
	intPos = InStr(strIn, "'")
	Do Until intPos = 0
		strOut = strOut + Mid(strIn, 1, intPos) + "'"
		strIn = Mid(strIn, intPos + 1)
		intPos = InStr(strIn, "'")
	loop
	strOut = strOut & strIn
	ConvertString = strOut
End Function
' ------------------------------------------------------------------
'  PCase
' ------------------------------------------------------------------
Public Function PCase(strInput)
	dim iPosition  ' Our current position in the string (First character = 1)
	dim iSpace     ' The position of the next space after our iPosition
	dim strOutput  ' Our temporary string used to build the function's output

	' Set our position variable to the start of the string.
	iPosition = 1
	
	' We loop through the string checking for spaces.
	' if there are unhandled spaces left, we handle them...
	do while InStr(iPosition, strInput, " ", 1) <> 0
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
	loop

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

	dim re

	Set re = New RegExp
	re.Pattern = "[<>'$]"
	re.Global = true
	
	StripCharacters = re.Replace(s, "")

End Function

%>