<%
'a little preample ... adjust required_user_level based on category of pdf being requested

dim setThisLevel : setThisLevel = 4096 'userLevelPPlusStaff
dim strPDFcat : strPDFcat = request.queryString("cat")
dim this_path

select case strPDFcat
case "inv" 'invoice, customer level
	this_path = "\\personnelplus.net.\attached\invoices\"
	setThisLevel = 256

case "time" 'invoice, customer level
	this_path = "\\personnelplus.net.\net_docs\timecards\"
	setThisLevel = 256

case "attachment" 'get attachment and stream it
	this_path = "\\personnelplus.net.\attached\"
	setThisLevel = 4096

case "w2"
	setUserLevel = 16 'userLevelAssigned
	session("required_user_level") = userLevelSupervisor
case else
	strPDFcat = ""
end select

session("required_user_level") = setUserLevel
session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->
<%
	

	dim this_site : this_site = getTempsCompCode(request.QueryString("site"))

	dim this_cust : this_cust = get_customer(replace(request.QueryString("simulate_customer"), "'", "''"), replace(request.QueryString("customer"), "'", "''"))
	function get_customer(simCustomer, thisCustomer)
		if len(simCustomer & "") > 0 and user_level => userLevelPPlusStaff then
			get_customer = simCustomer
		elseif thisCustomer = g_company_custcode.CustomerCode then
			get_customer = thisCustomer
		elseif len(thisCustomer & "") > 0 and user_level => userLevelPPlusStaff then
			get_customer = thisCustomer
		elseif instr(g_company_custcode.CustomerCode, thisCustomer) > 0 then
			get_customer = thisCustomer
		else
			get_customer = null
		end if
	end function	

	dim which_item
	which_item = request.QueryString("id")
	if isnumeric(which_item) then
		which_item = cdbl(which_item)
	end if

	dim PDF :	Set PDF = Server.CreateObject("Persits.PDF")

	dim this_file
	dim strFileName
	select case strPDFcat
		case "inv"
			this_path = replace(this_path, "\attached\invoices\", "\attached\" & this_site & "\invoices\")
			this_file = this_path & this_site & " " &_
				"Customer=" & ucase(this_cust) & " " &_
				"Invoice=" & which_item &_
				".pdf"
			strFileName = "Invoice-#" & which_item & ".pdf"
		case "attachment"
			dim Attachments
			Set Attachments = Server.CreateObject ("ADODB.RecordSet")
				SQL = "SELECT Attachments.FileName " &_
					"FROM Attachments " &_
					"WHERE FileId=" & request.queryString("id")
					
			select case request.queryString("site")
			case "0"
				this_path = "\\personnelplus.net.\attached\per\"
				Attachments.Open SQL, dsnLessTemps(PER)
			case "1"
				this_path = "\\personnelplus.net.\attached\bur\"
				Attachments.Open SQL, dsnLessTemps(BUR)
			case "2"
				this_path = "\\personnelplus.net.\attached\boi\"
				Attachments.Open SQL, dsnLessTemps(BOI)
			case "3"
				this_path = "\\personnelplus.net.\attached\ida\"
				Attachments.Open SQL, dsnLessTemps(IDA)
			case "4"
				this_path = "\\personnelplus.net.\attached\twi\"
				Attachments.Open SQL, dsnLessTemps(TWI)
			case "5"
				this_path = "\\personnelplus.net.\attached\ppi\"
				Attachments.Open SQL, dsnLessTemps(PPI)
			case "6"
				this_path = "\\personnelplus.net.\attached\bly\"
				Attachments.Open SQL, dsnLessTemps(BLY)
			case "7"
				this_path = "\\personnelplus.net.\attached\bse\"
				Attachments.Open SQL, dsnLessTemps(BSE)
			end select

			if not Attachments.eof then
				this_file = Attachments("FileName")
				strFileName = ucase(replace(lcase(this_file), this_path, ""))
				strFileName = replace(strFileName, ".PDF", ".pdf")
				strFileName = replace(strFileName, "APPLICANTID", "ApplicantId")

			end if
	
	end select
		
	'print this_file
	if len(trim(this_file)) > 0 then
		dim objFSO : Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
		If objFSO.FileExists(this_file) Then
			dim objFile
			Set objFile = objFSO.GetFile(this_file)
			dim intFileSize
			intFileSize = objFile.Size
			Set objFile = Nothing

			Response.ContentType = "application/pdf"
			Response.AddHeader "Content-Type", "application/pdf"
			' Response.AddHeader "Content-Disposition","attachment; filename=" & strFileName
			Response.AddHeader "Content-Disposition","inline;filename=" & strFileName
			Response.AddHeader "Content-Length", intFileSize

			dim objStream
			Set objStream = Server.CreateObject("ADODB.Stream")
			objStream.Open
			objStream.Type = 1 'adTypeBinary
			objStream.LoadFromFile this_file
			Do While Not objStream.EOS And Response.IsClientConnected
				Response.BinaryWrite objStream.Read(1024)
				Response.Flush()
			Loop
			objStream.Close
			Set objStream = Nothing
		Else
			Response.write "Error finding file."
		End if
		Set objFSO = Nothing

'		dim doc : Set doc = Pdf.OpenDocumentBinary(thisPathAndFile)
'		Response.Buffer = true
'		Response.Clear()
'		Response.ContentType = "application/pdf"
'		Response.AddHeader "Content-Type", "application/pdf"
'		Response.AddHeader "Content-Disposition", "attachment;filename=" & Chr(34)&  lastName & ", " & firstName & ".pdf" & Chr(34)
'		Response.BinaryWrite doc.SaveToMemory
'		Set doc = Nothing
'		Set pdf = Nothing
'		Session("noHeaders") = false
'		Response.End

	end if


	' Open an existing form
', Doc, field, Page
''	Set Doc = PDF.OpenDocument(this_file)
		
'	' Remove XFA support from it
'	Doc.Form.RemoveXFA



	session("no_header") = false
%>


