<%

function doCapturePage()

	dim url_to_import 
		url_to_import = getParameter("url")
		
	if len(url_to_import) = 0 then 'assume testing
		url_to_import = "https://www.personnelinc.com/include/system/tools/job_orders/?token=squirly@personnel.com&secret=K0r7m5"
	end if	
	

		
	dim file_name
		file_name = getParameter("fn") 'file name

		if len(file_name) = 0 then 'assume testing
		file_name = "foobar.pdf"
	end if		

	dim Pdf
	Set Pdf = Server.CreateObject("Persits.Pdf")
	
	dim Doc
	Set Doc = Pdf.CreateDocument

	Doc.ImportFromUrl url_to_import, "scale=0.8; media=4;"

		Response.Buffer = true
		Response.Clear()
		Response.ContentType = "application/pdf"
		Response.AddHeader "Content-Type", "application/pdf"
		Response.AddHeader "Content-Disposition", "attachment;filename=""" & "job order file name" & ".pdf"""
		Response.BinaryWrite Doc.SaveToMemory
		Set Doc = Nothing
		Set Pdf = Nothing
		Session("noHeaders") = false
		Response.End

	
	'Dim Filename
	'Filename = Doc.Save( Server.MapPath(file_name), False )


end function
%>