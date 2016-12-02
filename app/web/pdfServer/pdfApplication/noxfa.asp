<%Option Explicit%>
    <!-- Revised: 12.26.2008 -->
	
<%
		Dim PDF, Doc, Font, field, FilenameWithPath, Path, FileName

' Application
		Set PDF = Server.CreateObject("Persits.PDF")

		' Open an existing form
		Set Doc = PDF.OpenDocument( Server.MapPath( "i-9.pdf" ) )

		' Create font object
		Set Font = Doc.Fonts("Tahoma")

		' Remove XFA support from it
		Doc.Form.RemoveXFA

		FilenameWithPath = "generated/Application-NoXFA.pdf"
		Path = Server.MapPath(FilenameWithPath)
		FileName = Doc.Save(Path, true)
		Set Doc = Nothing
		Set Pdf = Nothing

		
	%>
