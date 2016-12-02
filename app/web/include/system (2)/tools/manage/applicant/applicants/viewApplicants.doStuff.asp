<%
dim fromDate, toDate
fromDate = Request.QueryString("fromDate") 
if isDate(fromDate) = false then 
	fromDate = request.form("fromDate") 
	if isDate(fromDate) = false then fromDate = CStr(Date() - 365) 
end if

toDate = Request.QueryString("toDate") 
if isDate(toDate) = false then 
	toDate = request.form("toDate") 
	if isDate(toDate) = false then toDate = CStr(Date() + 1)
end if


dim whichCompany
whichCompany = Request.QueryString("whichCompany")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if


dim likeName
likeName = Replace(Request.QueryString("likeName"), "'", "''")
if len(likeName) = 0 then 
	likeName = request.form("likeName") 
end if

dim sSearchString
if len(likeName) > 0 then
	'decide to search as social or like a name'
	select case isnumeric(likeName)
	case true
		if len(likeName) = 9 then
			sSearchString = "(Applicants.SSNumber='" & likeName & "') AND "
		elseif len(likeName) > 0 then
			sSearchString = "(Applicants.SSNumber LIKE '%" & likeName & "' " &_
				"OR Applicants.SSNumber LIKE '" & likeName & "%' " &_
				"OR Applicants.ApplicantId=" & likeName  & ") AND "
		end if
	case false
		sSearchString = "([lastnameFirst] LIKE '%" & likeName & "%') AND "
	end select
end if

SQL = "SELECT Applicants.ApplicantId, LastnameFirst, Applicants.Telephone, Applicants.[2ndTelephone], " &_
"[City] +  ', ' + [State] + ' '" & " + [Zip] AS CityLine, Notes, " &_
"Applicants.EntryDate, Applicants.AppChangedDate, EmailAddress as email " &_
	"FROM Applicants INNER JOIN NotesApplicants ON Applicants.ApplicantID = NotesApplicants.ApplicantId "  &_
	"WHERE " & sSearchString & "EntryDate>='" & fromDate &_
	"' AND EntryDate<='" & toDate & "' " &_
	"ORDER BY EntryDate DESC;"
'print SQL
''break SQL

Set Applicants = Server.CreateObject ("ADODB.RecordSet")
Applicants.CursorLocation = 3 ' adUseClient
Applicants.Open SQL, dsnLessTemps(getTempsDSN(whichCompany))

dim linkInvoice, inIDA, inPER, inBUR, inBOI, inAtLeastOne, inSystem, notInSystem, rowEmphasis
dim ModifiedTime, InsertedTime, Updated

dim applicationLink, etnry_date
dim addressLine, userAddressId, lnkName

sub showApplicantsTable ()
		' Position recordset to the correct page
		if Not Applicants.eof then Applicants.AbsolutePage = nPage
		
		Response.write "<div id='appResults'><table class='onlineApps'><tr>" &_
			"<th class=''>Date</th>" &_
			"<th class=''>Name</th>" &_
			"<th class=''>Contact</th>" &_
			"<th class=''>Note</th></tr>"
			
		inSystem = "class=" & Chr(34) & "inSystem" & Chr(34) & " "
		notInSystem = "class=" & Chr(34) & "notInSystem" & Chr(34) & " "
	
		emailLink = "/include/system/tools/images/email.gif"
		noEmailLink = "/include/system/tools/images/noEmail.gif"

		updatedLink = "/include/system/tools/images/updated.gif"
		notUpdatedLink = "/include/system/tools/images/notUpdated.gif"

		if Applicants.eof then response.write "No Items found."

do while not ( Applicants.Eof Or Applicants.AbsolutePage <> nPage )
	
		if Applicants.eof then
			Applicants.Close
			' Clean up
			' Do the no results HTML here
			response.write "No Items found."
				' Done
			Response.End 
		end if

		
			appID = Applicants.Fields.Item("ApplicantID")

			ModifiedTime = Applicants.Fields.Item("AppChangedDate")

			if is_service then
				applicationLink = "/include/system/tools/whoseHere.asp?where=" & whichCompany & "&who=" & CStr(appID)
			else
				applicationLink = "/include/system/tools/activity/forms/maintainApplicant.asp?where=" & whichCompany & "&who=" & CStr(appID)
			end if

			if i > 0 then
				ShadeData = "FFFFFF"
				i = 0
			Else
				ShadeData = "EFF5FA"
				i = 1
			end if
			
			entry_date = FormatDateTime(Applicants.Fields.Item("EntryDate"), 2)
			addressLine = Applicants.Fields.Item("Notes")
			addressLine = filterNotes(addressLine, entry_date)


			ssn = formatPhone(Applicants.Fields.Item("2ndTelephone"))
			if len(ssn) > 0 and instr(lcase(ssn), "na") = 0 then
				ssn = formatPhone(Applicants.Fields.Item("Telephone")) & " or " & ssn
			else
				ssn = formatPhone(Applicants.Fields.Item("Telephone"))
			end if
			ssn = replace(ssn, "(", "")
			ssn = replace(ssn, ")", "-")
			
			form_link = "<a href='" & applicationLink & "&amp;action=review'>"
			applicantEmail = Applicants.fields.item("email")
			if len(applicantEmail) > 0 then
				lnkName = Updated & "<a href=" & Chr(34) & "mailto:" & applicantEmail & Chr(34) & "><img src=" &_
					Chr(34) & emailLink & Chr(34) & "></a>" & form_link & Applicants.Fields.Item("lastnameFirst")
			Else
				lnkName = Updated & "<img src=" & Chr(34) & noEmailLink & Chr(34) & ">" &_
					form_link & Applicants.Fields.Item("lastnameFirst")
			end if

			'if Applications("submitted") = "n" then rowEmphasis = rowEmphasis & " notSubmitted"
			Response.write "<tr style='background-color:#" & ShadeData & "'>"
			Response.write "<td class='entry_date " & rowEmphasis & "'>" & form_link & entry_date & "</a></td>"
			Response.write "<td class='lnkName " & rowEmphasis & "'>" & lnkName & "</a></td>"
			Response.write "<td class='contact " & rowEmphasis & "'>" & form_link & ssn & "</a></td>"
			Response.write "<td class='shortnote " & rowEmphasis & "'>" & form_link & addressLine & "</a></td></tr>"
	'		inBOI = "" : inBUR = "" : inPER = "" : inIDA = "" : 
			Applicants.MoveNext
			
		loop
		Response.write "</table></div>"
		Set Applications = nothing
		'Set getApplications_cmd = Nothing
		'Database.Close
	'end if

end sub

dim nPage
nPage = CInt(Request.QueryString("Page"))
function navRecordsByPage(rs)

	nItemsPerPage = 50
	if not rs.eof then rs.PageSize = nItemsPerPage
	nPageCount = rs.PageCount

	if nPage < 1 Or nPage > nPageCount then
		nPage = 1
	end if
	
	rsQuery = request.serverVariables("QUERY_STRING")
	queryPageNumber = Request.QueryString("Page")
	if queryPageNumber then
		rsQuery = Replace(rsQuery, "Page=" & queryPageNumber & "&", "")
	end if


	response.write "<div id=""topPageRecords"" class=""navPageRecords"">" &_
				"<input name=""WhichPage"" id=""WhichPage"" type=""hidden"" value="""" />"

	response.write "<A HREF=""#"" onclick=""act_refresh_page('1');"">First</A>"
	For i = 1 to nPageCount
		response.write "<A HREF=""#"" onclick=""act_refresh_page('" & i & "');"">&nbsp;"
		if i = nPage then
			response.write "<span style=""color:red"">" & i & "</span>"
		Else
			response.write i
		end if
		response.write "&nbsp;</A>"
			nav_break = nav_break + 1
			if nPageCount > 35 and nav_break > 22 then
				nav_break = 0
				response.write "<br>"
			end if

	Next
	response.write "<A HREF=""#"" onclick=""act_refresh_page('" & whichCompany & "');"">Last</A>"
	response.write("</div>")
end function
 
function ifNotServiceShow (show_what)
	if is_service <> true then
		select case show_what
		case "topnav"
			ifNotServiceShow = decorateTop("AccountActivity", "marLRB10", "Applicants")
		case "navbottom"
			ifNotServiceShow = decorateBottom()
		case "bottom"
			noSocial = true
			server.transfer "/include/core/pageFooter.do.asp"
		end select
	end if
end function

function filterNotes(note, entry_date)
	dim strFiltering
	dim i, iAsc
	for i = 1 to len(note)
		iAsc = asc(mid(note, i)) 
		if (iAsc > 47 and iAsc <58) or (iAsc >64 and iAsc < 123) then
			strFiltering = strFiltering & Chr(iAsc)
		end if
	next
	
	strFiltering = lcase(note)
	strFiltering = replace(strFiltering, vbCrLf, "")
	strFiltering = replace(strFiltering, vbCr, "")
	strFiltering = replace(strFiltering, vbLf, "")
	strFiltering = replace(strFiltering, "	", "")
	strFiltering = replace(strFiltering, Chr(13), "")

	strFiltering = replace(strFiltering, "applied in declo", "")
	strFiltering = replace(strFiltering, "applied in hailey", "")
	strFiltering = replace(strFiltering, "applied in malta", "")
	strFiltering = replace(strFiltering, "applied in oakley", "")
	strFiltering = replace(strFiltering, "applied in paul", "")
	strFiltering = replace(strFiltering, "applied in heyburn", "")
	strFiltering = replace(strFiltering, "applied in rupert", "")
	strFiltering = replace(strFiltering, "applied in burley", "")
	strFiltering = replace(strFiltering, "applied in buhl", "")
	strFiltering = replace(strFiltering, "applied in jerome", "")
	strFiltering = replace(strFiltering, "applied in twin falls", "")
	strFiltering = replace(strFiltering, "applied in garden city", "")
	strFiltering = replace(strFiltering, "applied in nampa", "")
	strFiltering = replace(strFiltering, "applied in boise", "")
	strFiltering = replace(strFiltering, "applied in caldwell", "")
	strFiltering = replace(strFiltering, "seeking work type:", "")

	strFiltering = replace(strFiltering, "rtf1", "")
	strFiltering = replace(strFiltering, "f0", "")
	strFiltering = replace(strFiltering, "f1", "")
	strFiltering = replace(strFiltering, "fswiss", "")
	strFiltering = replace(strFiltering, "fcharset0", "")
	strFiltering = replace(strFiltering, "lang1033", "")
	strFiltering = replace(strFiltering, "ms sans serif", "")
	strFiltering = replace(strFiltering, "ansi", "")
	strFiltering = replace(strFiltering, "def", "")
	strFiltering = replace(strFiltering, "fonttbl", "")
	strFiltering = replace(strFiltering, "fs17", "")
	strFiltering = replace(strFiltering, "viewkind4", "")
	strFiltering = replace(strFiltering, "uc1", "")
	strFiltering = replace(strFiltering, "\pard", "")
	strFiltering = replace(strFiltering, "cpg1252", "")
	strFiltering = replace(strFiltering, "\par", "")
	strFiltering = replace(strFiltering, "\tab", "")
	strFiltering = replace(strFiltering, "", "")
	strFiltering = replace(strFiltering, "-", " ")
	strFiltering = replace(strFiltering, "{", " ")
	strFiltering = replace(strFiltering, "}", " ")
	strFiltering = replace(strFiltering, ":", " ")
	strFiltering = replace(strFiltering, ";", " ")
	strFiltering = replace(strFiltering, "\", " ")

	dim altEntryDate
	altEntryDate = replace(entry_date, "/201", "/1")
	strFiltering = replace(strFiltering, entry_date, "")
	strFiltering = replace(strFiltering, altEntryDate, "")

	strFiltering = replace(strFiltering, ">", " ")
	strFiltering = replace(strFiltering, ".", " ")
	strFiltering = replace(strFiltering, "  ", " ")
	strFiltering = replace(strFiltering, " 00/", ".00/")
	strFiltering = replace(strFiltering, "valid id", " valid id")
	strFiltering = replace(strFiltering, " 00 ", ".00 ")
	strFiltering = replace(strFiltering, " 50 ", ".50 ")
	strFiltering = replace(strFiltering, " 55 ", ".55 ")
	strFiltering = replace(strFiltering, " 25 ", ".25 ")


	strFiltering = replace(strFiltering, "minimum wage accepted", "Min-Wage: ")
	strFiltering = replace(strFiltering, "valid id and/or dl", "")

	strFiltering = replace(strFiltering, "shift ", "")

	strFiltering = replace(strFiltering, "worked for other temp services", "")
	strFiltering = replace(strFiltering, "services if yes, list services", "")
	strFiltering = replace(strFiltering, "commute distance", "")
	strFiltering = replace(strFiltering, "if yes, list services", "")
	strFiltering = replace(strFiltering, "interviewed by", "")
	strFiltering = replace(strFiltering, "work history", "")
	strFiltering = replace(strFiltering, "", "")
	strFiltering = replace(strFiltering, "", "")
	strFiltering = replace(strFiltering, "", "")

''	strFiltering = replace(strFiltering, "type commute", "")
''	strFiltering = replace(strFiltering, "distance worked for ", "")
	strFiltering = replace(strFiltering, "transportation type", "")
	

''	strFiltering = replace(strFiltering, "valid id and/or dltransportation typecommute distance", "")


	strFiltering = pcase(strFiltering)
	
	strFiltering = replace(strFiltering, "No Felonies or Case History E Verify Complete", "No Felonies, Complete")
	strFiltering = replace(strFiltering, "Felonies and Case History", "")
	strFiltering = replace(strFiltering, "E Verify Complete", "")
	strFiltering = replace(strFiltering, "Felonies", "")
	strFiltering = replace(strFiltering, "Mc ", "")
	strFiltering = replace(strFiltering, "Case History", "")
	strFiltering = replace(strFiltering, "", "")

	strFiltering = replace(strFiltering, "And", "and")
	strFiltering = replace(strFiltering, "For", "for")
	strFiltering = replace(strFiltering, "Dl ", "DL ")
	strFiltering = replace(strFiltering, "H&r ", "H&R")
	strFiltering = replace(strFiltering, "Sor", "SOR")
	strFiltering = replace(strFiltering, "Idc", "IDC")
	strFiltering = replace(strFiltering, "Or ", "or ")
	strFiltering = replace(strFiltering, "Idc", "IDC")
	strFiltering = replace(strFiltering, "Pd ", "PD ")
	strFiltering = replace(strFiltering, "Dwp", "DWP")
	strFiltering = replace(strFiltering, "Aes", "AES")
	strFiltering = replace(strFiltering, "Was ", "was ")
	strFiltering = replace(strFiltering, "On ", "on ")
	strFiltering = replace(strFiltering, "Id Repose", "ID Repose")
	
	filterNotes = strFiltering
end function


%>
