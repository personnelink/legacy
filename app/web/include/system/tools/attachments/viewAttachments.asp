<%
session("add_css") = "./viewAttachments.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/system/tools/attachments/viewAttachments.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%
dim page_title

'if len(session("insertInfo")) > 0 then
'	response.write(decorateTop("doneInsertingApp", "marLR10", "Applicants Attachments"))
'	response.write(session("insertInfo"))
'	response.write(decorateBottom())
'	session("insertInfo") = ""
'end if
dim qs_cmd, qs_id, qs_dsn, qs_site_id
qs_cmd=lcase(request.QueryString("attachment"))
if len(qs_cmd) > 0 then
	'applicant or customer
	select case left(qs_cmd, 1)
	case "a"
		sgOptionApplicant = "true"
	case "c"
		sgOptionCustomer = "true"
	end select

	'dsn
	select case right(qs_cmd, 3)
	case "per"
		tempsdsn = "per"
	case "bur"
		tempsdsn = "bur"
	case "boi"
		tempsdsn = "boi"
	case "ida"
		tempsdsn = "ida"
	case "poc"
		tempsdsn = "poc"
    case "ore"
		tempsdsn = "ore"
    case "ppi"
		tempsdsn = "ppi"
    case "wyo"
		tempsdsn = "wyo"
	end select

	'id
	search_for = mid(qs_cmd, 2, len(qs_cmd) -4 )
end if

if len(tempsdsn) = 0 then
	tempsdsn = request.form("tempsdsn")
	if len(tempsdsn) = 0 then
		tempsdsn = session("location")
		if len(tempsdsn) = 0 then
			tempsdsn = "boi"
		end if
	end if
end if

checkedText = "checked=""checked"" autocomplete=""off"""
sgOptionCustomer = request.form("sgOptionCustomer")
sgOptionApplicant = request.form("sgOptionApplicant")

if len(search_for) = 0 then
	search_for = request.form("search_for")
end if

if len(search_for) > 0 then
	page_title = "Like:&nbsp;&nbsp;" & search_for
elseif len(page_title) = 0 then
	page_title = "View Attachments"
end if

leftSideMenu = "" &_
	"<form id=""viewActivityForm"" name=""viewActivityForm"" action="""" method=""post"" class="""">" &_
	"<div id=""searchGuide"">" &_
	"<strong>Include</strong>:" &_
	"<ul class=""guide"">" &_
	"<li class=""label_checkbox_pair""><input type=""radio"" value=""boi"" name=""tempsdsn"" boiTempsDSN />BOI</li>" &_
	"<li class=""label_checkbox_pair""><input type=""radio"" value=""per"" name=""tempsdsn"" perTempsDSN />PER</li>" &_
	"<li class=""label_checkbox_pair""><input type=""radio"" value=""bur"" name=""tempsdsn"" burTempsDSN />BUR</li>" &_
	"<li class=""label_checkbox_pair""><input type=""radio"" value=""poc"" name=""tempsdsn"" pocTempsDSN />POC</li>" &_
	"<li class=""label_checkbox_pair""><input type=""radio"" value=""ida"" name=""tempsdsn"" idaTempsDSN />IDA</li>" &_
    "<li class=""label_checkbox_pair""><input type=""radio"" value=""ore"" name=""tempsdsn"" oreTempsDSN />ORE</li>" &_
    "<li class=""label_checkbox_pair""><input type=""radio"" value=""ppi"" name=""tempsdsn"" ppiTempsDSN />PPI</li>" &_
    "<li class=""label_checkbox_pair""><input type=""radio"" value=""wyo"" name=""tempsdsn"" wyoTempsDSN />WYO</li>" &_
	"</ul>" &_
	"<strong>Include</strong>:" &_
	"<ul class=""guide"">" &_
	"<li class=""label_checkbox_pair""><input type=""checkbox"" name=""customer"" value=""true"" sgOptionCustomerSpaceHolder />Customer</li>" &_
	"</ul>" &_

	"{optional}" &_
	"<ul class=""guide"">" &_
		  "<label style=""float:left; clear:left"" for=""search_for"">SSN, Name or Id: </label>" &_
		 " <input  style=""float:left;width:10.6em;"" name=""search_for"" id=""search_for"" type=""text"" value=""" & search_for & """ onkeydown=""if (event.keyCode == 13) { search_attached(); return false; }"">" &_

	"</ul>	" &_
	"<div class=""changeView"">" &_
	"<div class=""user_prompt""></div>" &_
	" <a class=""squarebutton"" href=""#"" style=""float:left;"" onclick=""search_attached();""><span style=""text-align:center""> Search </span></a>" &_
	"</div></div>" &_
	"<input id=""page_title"" name=""page_title"" type=""hidden"" class=""hidden"" value=""" & page_title & """>" &_
	"<input id=""page"" name=""page"" type=""hidden"" value=""" & request.form("page") & """ />" &_
	"</form>"

	if lcase(tempsdsn) = "boi" then
		leftSideMenu = replace(leftSideMenu, "boiTempsDSN", checkedText)
	else
		leftSideMenu = replace(leftSideMenu, "boiTempsDSN", "")
	end if

	if lcase(tempsdsn) = "per" then
		leftSideMenu = replace(leftSideMenu, "perTempsDSN", checkedText)
	else
		leftSideMenu = replace(leftSideMenu, "perTempsDSN", "")
	end if

	if lcase(tempsdsn) = "bur" then
		leftSideMenu = replace(leftSideMenu, "burTempsDSN", checkedText)
	else
		leftSideMenu = replace(leftSideMenu, "burTempsDSN", "")
	end if

	if lcase(tempsdsn) = "poc" then
		leftSideMenu = replace(leftSideMenu, "pocTempsDSN", checkedText)
	else
		leftSideMenu = replace(leftSideMenu, "pocTempsDSN", "")
	end if

	if lcase(tempsdsn) = "ida" then
		leftSideMenu = replace(leftSideMenu, "idaTempsDSN", checkedText)
	else
		leftSideMenu = replace(leftSideMenu, "idaTempsDSN", "")
	end if

    if lcase(tempsdsn) = "ore" then
		leftSideMenu = replace(leftSideMenu, "oreTempsDSN", checkedText)
	else
		leftSideMenu = replace(leftSideMenu, "oreTempsDSN", "")
	end if

    if lcase(tempsdsn) = "ppi" then
		leftSideMenu = replace(leftSideMenu, "ppiTempsDSN", checkedText)
	else
		leftSideMenu = replace(leftSideMenu, "ppiTempsDSN", "")
	end if

    if lcase(tempsdsn) = "ore" then
		leftSideMenu = replace(leftSideMenu, "oreTempsDSN", checkedText)
	else
		leftSideMenu = replace(leftSideMenu, "oreTempsDSN", "")
	end if

	if sgOptionCustomer = "true" then
		leftSideMenu = replace(leftSideMenu, "sgOptionCustomerSpaceHolder", checkedText)
	else
		leftSideMenu = replace(leftSideMenu, "sgOptionCustomerSpaceHolder", "")
	end if

%>
<%=decorateTop("AccountActivity", "notToShort marLRB10", "View Attachments")%>
<div id="accountActivityDetail" class="pad10">

    <%
	dim whichCompany, linkInvoice, inIDA, inPER, inBUR, inBOI, inAtLeastOne, inSystem, notInSystem, rowEmphasis
	dim ModifiedTime, InsertedTime, Updated
	dim name_link, id_link

	dim applicationLink, get_attached_lnk

		dim where_ifs, ifApplicantId, ifLastnameFirst

		if len(search_for) > 0 then
			search_for = replace(search_for, "'", "''")
		end if

		if isnumeric(search_for) then
			if len(search_for) = 9 then
				sGuideString = "Applicants.SSNumber='" & search_for & "'"
			elseif len(search_for) > 0 then
				sGuideString = "Applicants.SSNumber LIKE '%" & search_for & "' " &_
					"OR Applicants.SSNumber LIKE '" & search_for & "%' " &_
					"OR Applicants.ApplicantId=" & search_for  & " "
			end if
		elseif len(search_for) > 0 then
			sGuideString = "Applicants.LastnameFirst LIKE '" & search_for & "%' " &_
				"OR Applicants.LastnameFirst LIKE '%" & search_for & "' "
		end if

		'if len(ifLastnameFirst) > 0 and len(where_ifs) >0 then
		'	sGuideString = where_ifs & " OR
		'end if

		'if len(searchSocial) > 0 then
		'	if len(searchLastnameFirst) > 0 then
		'		sGuideString = sGuideString & "AND Applicants.SSNumber LIKE '%" & searchSocial & "%' "
		'	Else
		'		sGuideString = "WHERE Applicants.SSNumber LIKE '%" & searchSocial & "%' "
		'	end if
		'end if

		'response.write sGuideString
		'Response.End()

		if len(sGuideString) > 0 then
			sGuideString = "WHERE " & sGuideString
			SQL = "SELECT Applicants.LastnameFirst, Applicants.Address, Applicants.City, Applicants.State, " &_
			"Applicants.Zip, Attachments.DescriptionOfFile, Attachments.Customer, Attachments.FileName, " &_
			"Attachments.ApplicantId, Attachments.FileId, Applicants.SSNumber, Attachments.[On] AS AttachedDate " &_
			"FROM Applicants LEFT JOIN Attachments ON Applicants.ApplicantId = Attachments.ApplicantId " &_
			sGuideString  &_
			"ORDER BY Applicants.LastnameFirst, Attachments.DescriptionOfFile;"

			Set Attachments = Server.CreateObject ("ADODB.RecordSet")
			Attachments.CursorLocation = 3 ' adUseClient

			Select Case tempsdsn
			Case "boi"
				Attachments.Open SQL, dsnLessTemps(BOI)
				qs_site_id = BOI

			Case "per"
				Attachments.Open SQL, dsnLessTemps(PER)
				qs_site_id = PER

			Case "bur"
				Attachments.Open SQL, dsnLessTemps(BUR)
				qs_site_id = BUR

			Case "poc"
				Attachments.Open SQL, dsnLessTemps(POC)
				qs_site_id = POC

			Case "ida"
				Attachments.Open SQL, dsnLessTemps(IDA)
				qs_site_id = IDA

            Case "ore"
				Attachments.Open SQL, dsnLessTemps(ORE)
				qs_site_id = ORE

            Case "ppi"
				Attachments.Open SQL, dsnLessTemps(PPI)
				qs_site_id = PPI

            Case "wyo"
				Attachments.Open SQL, dsnLessTemps(WYO)
				qs_site_id = WYO

			Case Else
				Attachments.Open SQL, dsnLessTemps(PER)
				qs_site_id = PER

			End Select

			dim addressLine, userAddressId, getUserAddress, lnkName, ApplicantId, FileId
			'Database.Open MySql

			dim chkPage
				chkPage = request.form("page")
			if len(chkPage) > 0 then
				nPage = cint(chkPage)
			else
				nPage = 1
			end if

			nItemsPerPage = 125
			Attachments.PageSize = nItemsPerPage
			nPageCount = Attachments.PageCount

			if nPage < 1 Or nPage > nPageCount then
				nPage = 1
			end if
			' Position recordset to the correct page

			if Not Attachments.eof then Attachments.AbsolutePage = nPage

			Response.write "<div id='attachments'><table class='fileAttachments'>"

			response.write "<tr><td colspan=6>"
			response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
			response.write "<A HREF=""#"" onclick=""select_page('1')'"" >First</A>"
				For i = 1 to nPageCount
					response.write "<A HREF=""#"" onclick=""select_page('" & i & "');"">&nbsp;"
					if i = nPage then
						response.write "<span style=""color:red"">" & i & "</span>"
					Else
						response.write i
					end if
					response.write "&nbsp;</A>"
				Next
			response.write "<A HREF=""#"" onclick=""select_page('" & nPageCount& "');"">Last</A>"
			response.write("</div>")
			response.write "</td></tr>"

			response.write "<tr>" &_
					"<th>Id</th>" &_
					"<th>Lastname, First</th>" &_
					"<th>Address</th>" &_
					"<th>Attachment</th></th>"	&_
					"<th>Date</th></th>"	&_
					"<th class='manage_attached'><a class=""newAttachment"" " & "href='" & FileName & "'>&nbsp;</a></tr>"

				inSystem = "class=" & Chr(34) & "inSystem" & Chr(34) & " "
				notInSystem = "class=" & Chr(34) & "notInSystem" & Chr(34) & " "

				emailLink = "/include/system/tools/images/email.gif"
				noEmailLink = "/include/system/tools/images/noEmail.gif"

				updatedLink = "/include/system/tools/images/updated.gif"
				notUpdatedLink = "/include/system/tools/images/notUpdated.gif"

	if Attachments.eof then
		dim foundNoOne
			foundNoOne = "<div id=""nothingfound"">&nbsp;<div>&nbsp;</div></div>"
		'Clean up
		' Do the no results HTML here
		response.write "we couldn't find anyone"

	else
		do while not ( Attachments.Eof Or Attachments.AbsolutePage <> nPage )

					LastnameFirst = Attachments.Fields.Item("LastnameFirst")
					attDate = Attachments.Fields.Item("AttachedDate")
						attDate = DatePart("yyyy", attDate) & "." & padding(DatePart("m", attDate)) & "." & padding(DatePart("d", attDate))
					attAddress = Attachments.Fields.Item("Address")
					attCity = Attachments.Fields.Item("City")
					attState = Attachments.Fields.Item("State")
					DescriptionOfFile = Attachments.Fields.Item("DescriptionOfFile")
					Customer = Attachments.Fields.Item("Customer")
					FileName = "file:///" & Attachments.Fields.Item("FileName")
					ApplicantId = Attachments.Fields.Item("ApplicantId")
					FileId = Attachments.Fields.Item("FileId")

					'applicationLink = "\\personnelplus.net.\attachments" & CStr(appID)
					if i > 0 then
						ShadeData = "sh"
						i = 0
					Else
						ShadeData = "sl"
						i = 1
					end if

					name_link = "<a href=""/include/system/tools/activity/forms/maintainApplicant.asp?where=" & tempsdsn & "&who=" & ApplicantId & """>" & lastNameFirst & "</a>"
					id_link = "<a href=""/include/system/tools/activity/forms/maintainApplicant.asp?where=" & tempsdsn & "&who=" & ApplicantId & """>" & ApplicantId & "</a>"
					get_attached_lnk = "/include/system/services/sendPDF.asp?site=" & qs_site_id & "&id=" & FileId & "&cat=attachment"

					Response.write "<tr id='r" & i & "-" & fileid & "' class='" & ShadeData & " br'>" &_
						"<td class=''>" & id_link & "&nbsp;</td>" &_
						"<td class='nl'>" & name_link & "</td>" &_
						"<td class='ad'>" & attCity & ", " & attState & " " & attZip & "</td>" &_
						"<td class=''><a " & "href='" & FileName & "'>" & DescriptionOfFile & "</a></td>" &_
						"<td>" & attDate & "</td>" &_
							"<td class='attachment_options'>" &_
						"<a class=""editAttachment"" onclick=""javascript:replace_attached('" & FileId & "', '" & session_id & "', '" & tempsdsn & "', 'r" & i & "-" & fileid & "');"">&nbsp;</a>" &_
						"<a class=""getAttachment"" href=""" & get_attached_lnk & """>&nbsp;</a>" &_
						"<a class=""delAttachment"" onclick=""javascript:delete_attached('" & FileId & "', '" & session_id & "', '" & tempsdsn & "', 'r" & i & "-" & fileid & "');"">&nbsp;</a>" &_
							"</td>" &_
						"</tr>"

					Attachments.MoveNext
					'userAddressId = Attachments."addressID")
					'if len(userAddressId) > 0 then
						'Set getUserAddress = Database.Execute("SELECT city, state, zip FROM tbl_addresses WHERE addressID=" & userAddressID)
						'addressLine = PCase(getUserAddress.Fields.Item("city")) & ", " & UCase(getUserAddress.Fields.Item("state")) & " " & getUserAddress.Fields.Item("zip")
					'Else
						'addressLine = PCase(Attachments.Fields.Item("city")) & ", " & UCase(Attachments.Fields.Item("appState")) & " " & Attachments.Fields.Item("zipcode")
					'end if
					'Set getUserAddress = Nothing

					'form_link = "<a href='" & applicationLink & "&amp;action=review'>"
					'applicantEmail = Attachments."email")
					'if len(applicantEmail) > 0 then
					'	lnkName = Updated & "<a href=" & Chr(34) & "mailto:" & applicantEmail & Chr(34) & "><img src=" &_
					'		Chr(34) & emailLink & Chr(34) & "></a>" & form_link & Attachments.Fields.Item("lastName") & ", " & Attachments.Fields.Item("firstName")
					'Else
					'	lnkName = Updated & "<img src=" & Chr(34) & noEmailLink & Chr(34) & ">" &_
					'		form_link & Attachments.Fields.Item("lastName") & ", " & Attachments.Fields.Item("firstName")
					'end if

		loop
	end if

			response.write "<tr><td colspan=6>"
			response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
			response.write "<A HREF=""#"" onclick=""select_page('1')'"" >First</A>"
				For i = 1 to nPageCount
					response.write "<A HREF=""#"" onclick=""select_page('" & i & "');"">&nbsp;"
					if i = nPage then
						response.write "<span style=""color:red"">" & i & "</span>"
					Else
						response.write i
					end if
					response.write "&nbsp;</A>"
				Next
			response.write "<A HREF=""#"" onclick=""select_page('" & nPageCount& "');"">Last</A>"
			response.write("</div>")
			response.write "</td></tr>"
			Response.write "</table></div></div>"

			response.write foundNoOne

			Attachments.Close
			Set Attachments = nothing
			'Set getAttachments.cmd = Nothing
		'end if
		else
			response.write"<div id=""getstarted""><div><i>enter part or all of the applicant's name, id or ssn to get started...</i></div>" &_
				"<div style=""clear:both;margin-top:0.8em;""><input  style=""float:left;width:16em;"" name=""search_for_first"" id=""search_for_first"" type=""text"" value=""" & search_for & """ onkeydown=""if (event.keyCode == 13) { seed_search(this.value); return false; }""></div>" &_
				"<div>&nbsp;</div></div></div>"
		end if

function padding(value)
	dim padWith
	if len(value) = 1 then
		padWith = "0"
	else
		padWith = ""
	end if
	padding = padWith & value
end function

noSocial = true %>
    <%=decorateBottom()%>
    <!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->