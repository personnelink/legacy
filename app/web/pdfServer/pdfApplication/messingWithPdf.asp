<%Option Explicit%>
<!-- Revised: 2009.07.05 -->
<% Session("additionalStyling") = "submitapplication.asp.css" %>

<!-- #INCLUDE VIRTUAL='/include/master/masterPageTop.asp' -->
    <!-- Revised: 3.13.2009 -->
    <!-- Revised: 2.9.2009 -->
	
<script type="text/javascript" src="/include/js/submitapplication.js"></script>

<%

'Response.Write(decorateTop("PDFdone", "", "Success!"))

Public Function PCase(strInput)
	Dim iPosition  ' Our current position in the string (First character = 1)
	Dim iSpace     ' The position of the next space after our iPosition
	Dim strOutput  ' Our temporary string used to build the function's output

	iPosition = 1
	Do While InStr(iPosition, strInput, " ", 1) <> 0
		iSpace = InStr(iPosition, strInput, " ", 1)
		strOutput = strOutput & UCase(Mid(strInput, iPosition, 1))
		strOutput = strOutput & LCase(Mid(strInput, iPosition + 1, iSpace - iPosition))
		iPosition = iSpace + 1
	Loop
	strOutput = strOutput & UCase(Mid(strInput, iPosition, 1))
	strOutput = strOutput & LCase(Mid(strInput, iPosition + 1))
	PCase = strOutput
End Function
' ------------------------------------------------------------------
'  StripCharacters
' ------------------------------------------------------------------
Function StripCharacters (TextString)
	Dim RegularExpression
	If Len(TextString) > 0 Then
		Set RegularExpression = New RegExp
		RegularExpression.Pattern = "[<>']"
		RegularExpression.Global = True
		If VarType(TextString) = 8 Then
			StripCharacters = RegularExpression.Replace(TextString, "")
		End If
	End If
End Function
		Dim FilenameWithPath, Path, FileName, hrefLink
		Dim PDF, Doc, Font

		Set PDF = Server.CreateObject("Persits.PDF")

		' Open an existing form
		Set Doc = PDF.OpenDocument( Server.MapPath( "EmploymentApplication.pdf" ) )

		' Create font object
		Set Font = Doc.Fonts("Helvetica-Bold")

		' Remove XFA support from it
		Doc.Form.RemoveXFA

		'Response.Write(Doc)
		'Response.end

		
		'FilenameWithPath = "generated/CITY=" & city & "." & appState & "_" & zipcode & "_IDENT=" & Request.QueryString("appID") & ".pdf"
		'FileName = Doc.Save(Server.MapPath(FilenameWithPath), true)
		'hrefLink = Replace(FilenameWithPath, " ", "%20")
		
		Set Doc = Nothing
		Set Pdf = Nothing
	'Response.Redirect(FilenameWithPath)
%>

<!-- #INCLUDE VIRTUAL='/include/master/pageFooter.asp' -->
