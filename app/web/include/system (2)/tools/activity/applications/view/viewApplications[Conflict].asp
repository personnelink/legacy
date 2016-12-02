<%
dim isservice
if request.querystring("isservice")= "true" then
	isservice = true
	session("no_header") = true
else
	session("add_css") = "./viewApplications.007.css"
	session("required_user_level") = 4096 'userLevelPPlusStaff
	session("window_page_title") = "Search Applications - Personnel Plus"
end if

qsAppId = cdbl(request.querystring("appid"))
if qsAppId > 0 then getThisApp = qsAppId
	
%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/tools/activity/common_activity.inc' -->
<%

if not isservice then %>
<script type="text/javascript" src="viewApplications.js"></script>
<%
end if

'suppress place holders
if not isservice then
	dim page_title

	dim insertInfo
	insertInfo = get_session("insertInfo")
	if len(insertInfo) > 0 then
		'legacy, non-ajax mode
		dim name_length, name_start, start_txt, end_txt 'detect and set page_title if an update
		start_txt = "<th>Applicant Name:&nbsp;</th><td>"
		end_txt = "</td></tr><tr><th>"
		name_start = instr(insertInfo, start_txt)
		if name_start > 0 then
			name_start = name_start + len(start_txt) 'offset for search txt
			name_length =  instr(name_start, insertInfo, end_txt) - name_start
			if instr(insertInfo, "already exists in system") > 0 then
				page_title = "Update:&nbsp;" & mid(insertInfo, name_start, name_length) & "?"
			else
				page_title = mid(insertInfo, name_start, name_length) & " - Enrolled"
			end if
		end if
				
		response.write(decorateTop("doneInsertingApp", "marLRB10", "Applicants Application Insertion"))
		response.write(insertInfo)
		response.write(decorateBottom())
		insertInfo = set_session("insertInfo", "")
	else
		'ajax recipient container
		response.write(decorateTop("doneInsertingApp", "marLRB10 hide", "Applicants Application Insertion"))
		response.write("<div id=""whatWasInserted""></div>")
		response.write(decorateBottom())			
	end if
end if

dim fromDate, toDate
fromDate = Request.QueryString("fromDate") 
if isDate(fromDate) = false then 
	fromDate = request.form("fromDate") 
	if isDate(fromDate) = false then fromDate = CStr(Date() - 4) 
end if

toDate = Request.QueryString("toDate") 
if isDate(toDate) = false then 
	toDate = request.form("toDate") 
	if isDate(toDate) = false then toDate = CStr(Date() + 1)
end if

dim likeName
likeName = Replace(Request.QueryString("likeName"), "'", "''")
if len(likeName) = 0 then 
	likeName = request.form("likeName") 
end if

dim expand_srch, checkedText
checkedText = " checked=""checked"" autocomplete=""off"""
if request("expand_srch") = "expand" then
	expand_srch = true
end if

dim updates_only, qs_updates_only
qs_updates_only = Replace(Request.QueryString("updates"), "'", "''")
if qs_updates_only = "" then
	if request("updates_only") = "updates" then
		updates_only = true
	end if
else
	updates_only = cbool(qs_updates_only)
end if

dim incomplete_only, qs_incomplete_only
qs_incomplete_only = Replace(Request.QueryString("incomplete"), "'", "''")
if qs_incomplete_only = "" then
	if request("incomplete_only") = "incompletes" then
		incomplete_only = true
	end if
else
	incomplete_only = cbool(qs_incomplete_only)
end if

if not isservice then

	if len(likeName) > 0 then
		page_title = "Apps like:&nbsp;&nbsp;" & likeName & ", " & fromDate & " - " & toDate
	elseif len(page_title) = 0 then
		page_title = "View Employment Applications"
	end if
%>

<%=decorateTop("AccountActivity", "marLRB10", "Employment Applications")%>
<div id="accountActivityDetail" class="pad10">

    <form id="viewActivityForm" name="viewActivityForm" action="viewApplications.asp" method="get">
        <table id="formOptions">
            <tr>
                <td>
                    <label style="float: left; clear: left" for="fromDate">From </label>
                    <input style="float: left; clear: left" name="fromDate" id="fromDate" type="text" value="<%=fromDate%>" onkeypress="return submitenter(this,event)">
                </td>
                <td>
                    <label for="toDate" style="float: left; clear: left">To </label>
                    <input name="toDate" id="toDate" type="text" value="<%=toDate%>" onkeypress="return submitenter(this,event)">
                </td>
                <td>

                    <div class="changeView">

                        <a class="squarebutton" href="#" style="float: none" onclick="javascript:document.viewActivityForm.submit();"><span style="text-align: center">Search </span></a>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <label style="float: left; clear: left" for="likeName">Search</label>
                    <input style="float: left; clear: left" name="likeName" id="likeName" type="text" value="<%=likeName%>" onkeypress="return submitenter(this,event)"><br />
            </tr>
            <tr>
                <td colspan="1">
                    <label id="updates_only_lbl" for="updates_only">
                        <input style="border: none;" type="checkbox" name="updates_only" id="updates_only" value="updates"
                            <% if updates_only then response.write checkedText %> />
                        Only show updated applications
                    </label>
                    <label id="incomplete_only_lbl" for="incomplete_only">
                        <input style="border: none;" type="checkbox" name="incomplete_only" id="incomplete_only" value="incompletes"
                            <% if incomplete_only then response.write checkedText %> />
                        Only show incomplete applications
                    </label>
				</td>
                <td colspan="2">
                    <label id="expand_srch_lbl" for="expand_srch">
                        <input style="border: none;" type="checkbox" name="expand_srch" id="expand_srch" value="expand"
                            <% if expand_srch then response.write checkedText %> />
                        Include skills, additional info and job history
                    </label>
                </td>
 
			</tr>
        </table>
        <input id="page_title" name="page_title" type="hidden" class="hidden" value="<%=page_title%>">
    </form>
    <%
end if

	dim whichCompany, linkInvoice, inIDA, inPER, inBUR, inBOI, inPPI, inPOC, inAtLeastOne, inSystem, notInSystem, rowEmphasis
	dim ModifiedTime, InsertedTime, Updated
	
	dim applicationLink, interviewLink, ajaxlink
	
	'whichCompany = "IDA"
	'if len(whichCompanyID & "") > 0 then
		'whichCompanyID = "((HistoryDetail.Customer)='" & whichCompanyID & "') AND "
	'end if
	
	'if len(whichCompany & "") > 0 then
		'Select Case whichCompany
		'Case "IDA"
			'thisConnection = TempsPlus(IDA)
		'End Select
		dim sSearchString
		if len(likeName) > 0 then
			if expand_srch then
				'sSearchString = "(MATCH(tbl_applications_srch.additionalInfo) AGAINST('" & likeName & "')) AND "
			else
				select case isnumeric(likeName)
				case true
					if len(likeName) = 9 then
						sSearchString = "(tbl_applications.ssn='" & likeName & "') AND "
					else
						sSearchString = "(tbl_applications.ssn LIKE '%" & likeName & "' " &_
							"OR ssn LIKE '" & likeName & "%') AND "
					end if
				case false
					sSearchString = "((CONCAT(tbl_applications.lastName, ', ', tbl_applications.firstName)) LIKE '%" & likeName & "%') AND "
				end select
			end if
		end if
				
		fromMySqlFriendlyDate = Year(fromDate) & "/" & Month(fromDate) & "/" & Day(fromDate)
		toMySqlFriendlyDate = Year(toDate) & "/" & Month(toDate) & "/" & Day(toDate) + 1

		Set Applications = Server.CreateObject ("ADODB.RecordSet")
		Applications.CursorLocation = 3 ' adUseClient
		
		dim baseSQL
		baseSQL = "SELECT DISTINCT tbl_users.addressID, tbl_applications.applicationId, tbl_applications.interviewID, tbl_applications.email, tbl_applications.lastName, " &_
				"tbl_applications.firstName, tbl_addresses.city, tbl_addresses.state, tbl_addresses.zip, tbl_applications.ssn, tbl_applications.modifiedDate, " &_
				"tbl_applications.inPER, tbl_applications.inIDA, tbl_applications.inPPI, tbl_applications.inPOC, tbl_applications.inBOI, tbl_applications.inBUR, " &_
				"tbl_applications.lastInserted, tbl_applications.submitted, tbl_applications.mainPhone, tbl_applications.altPhone " &_
				"FROM (tbl_users RIGHT JOIN tbl_applications ON tbl_users.applicationId = tbl_applications.applicationId) " &_
				"LEFT JOIN tbl_addresses ON tbl_users.addressID = tbl_addresses.addressID "
		
		
		'slightly slower query joined for full text search
		if expand_srch then
			'sure table exists
			SQL = "SELECT `table_name` " &_
					"FROM `information_schema`.`TABLES` " &_
					"WHERE table_schema = ""pplusvms"" " &_
					"AND table_name = ""txt_srch"""

			Applications.Open SQL, MySql

			if Applications.eof then 
				Applications.close
				'create temporary table
				SQL = "CREATE TABLE `pplusvms`.`txt_srch` (" &_
					  "`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " &_
					  "`session_id` VARCHAR(38), " &_
					  "`hit_id` INTEGER UNSIGNED, " &_
					  "PRIMARY KEY (`id`) " &_
					") " &_
					"ENGINE = InnoDB " &_
					"COMMENT = 'Temporary Table for text seaches';" 
				
				Applications.Open SQL, MySql
			else
				Applications.close
			end if

			SQL = "" &_
				"INSERT INTO txt_srch (hit_id, session_id) " &_
				"SELECT applicationID, '" & session_id & "' AS session_id " &_
				"FROM  tbl_applications_srch " &_
				"WHERE MATCH(additionalInfo, jobDutiesOne, " &_
					"jobReasonOne, jobDutiesTwo, " &_
					"jobReasonTwo, jobDutiesThree, " &_
					"jobReasonThree) " &_
					"AGAINST('" & likeName & "');"

'					"AGAINST('" & likeName & "' WITH QUERY EXPANSION);"
			
			Applications.Open SQL, MySql
			
			SQL = "" &_
				"INSERT INTO txt_srch (hit_id, session_id) " &_
				"SELECT applicationID, '" & session_id & "' AS session_id " &_
				"FROM  tbl_interviews " &_
				"WHERE MATCH(employment_gaps, more_skills, work_history, kind_of_work, certifications) " &_
					"AGAINST('" & likeName & "');"

'					"AGAINST('" & likeName & "' WITH QUERY EXPANSION);"
			'print SQL
			
			Applications.Open SQL, MySql

			'search as if mining for keywords
			SQL = baseSQL &_
				"INNER JOIN txt_srch ON tbl_applications.applicationID = txt_srch.hit_id "  &_
				"WHERE " & sSearchString & "tbl_applications.modifiedDate>='" & fromMySqlFriendlyDate &_
				"' AND tbl_applications.modifiedDate<='" & toMySqlFriendlyDate & "' " &_
				"ORDER BY tbl_applications.modifiedDate DESC;"

		elseif updates_only then	'search for updates only
			SQL = baseSQL &_
				"WHERE DATEDIFF(tbl_applications.modifiedDate, tbl_applications.lastInserted) > 0 " &_
				"ORDER BY tbl_applications.modifiedDate DESC;"
				
		elseif incomplete_only then	'search for incomplete apps only
			SQL = baseSQL &_
				"WHERE (tbl_applications.submitted = 'n') AND " & sSearchString & "tbl_applications.modifiedDate>='" & fromMySqlFriendlyDate &_
				"' AND tbl_applications.modifiedDate<='" & toMySqlFriendlyDate & "' " &_
				"ORDER BY tbl_applications.modifiedDate DESC;"
				
		elseif getThisApp > 0 then	
			SQL = baseSQL &_
				"WHERE tbl_applications.applicationId=" & getThisApp
				
			'break SQL	
		else 	'search as if lastname, first
			SQL = baseSQL &_
				"WHERE " & sSearchString & "tbl_applications.modifiedDate>='" & fromMySqlFriendlyDate &_
				"' AND tbl_applications.modifiedDate<='" & toMySqlFriendlyDate & "' " &_
				"ORDER BY tbl_applications.modifiedDate DESC;"
		end if
		
		response.flush
		
		'print SQL
		
		Applications.Open SQL, MySql
		
		dim addressLine, userAddressId, lnkName, interviewed, mainphone, altphone
		Database.Open MySql
		
		nPage = CInt(Request.QueryString("Page"))
		nItemsPerPage = 50
		if not Applications.eof then Applications.PageSize = nItemsPerPage
		nPageCount = Applications.PageCount

		if nPage < 1 Or nPage > nPageCount then
			nPage = 1
		end if
		
		dim maxPages, slidePages
		
		const StartSlide = 32 ' when to start sliding
		const StopSlide = 112 'when to stop sliding and show the smallests amount
		const SlideRange = 8 'the most pages to show minus this = smallest number to show aka the slide
		const TopPages = 25 'the most records to show

		if nPage <= StartSlide then
			maxPages = TopPages
		elseif nPage > StartSlide and nPage < StopSlide then
			maxPages = TopPages - (SlideRange - Cint(SlideRange * ((StopSlide - nPage)/(StopSlide - StartSlide))))
		else
			maxPages = TopPages - SlideRange
		end if
		slidePages = cint((maxPages/2)+0.5)
		
		'check if we need to slide page navigation "window"
		if global_debug then
			output_debug("* navRecordsByPage(): nPageCount: " & nPageCount & " *")
			output_debug("* navRecordsByPage(): nPage: " & nPage & " *")
		end if
		
		dim startPage, stopPage
		if nPageCount > maxPages then
			startPage = nPage - slidePages
			stopPage = nPage + slidePages
			
			'check if startPages is less than 1
			if startPage < 1 then
				startPage = 1
				stopPage = maxPages
			end if
			'check if stopPages is greater than total pages
			if stopPage > nPageCount then
				stopPage = nPageCount
				startPage = nPageCount - slidePages
			end if
		else
			startPage = 1
			stopPage = nPageCount
		end if

		'if service suppress not nav records
		if not isservice then
			
			'Deprecated? 2010.05.17
			'
			'rsQuery = request.serverVariables("QUERY_STRING")
			'queryPageNumber = Request.QueryString("Page")
			'if queryPageNumber then
			'	rsQuery = Replace(rsQuery, "Page=" & queryPageNumber & "&", "")
			'end if
			
			qryOptions = "&fromDate=" & fromDate &_
				"&toDate=" & toDate &_
				"&updates=" & updates_only &_
				"&incomplete=" & incomplete_only &_
				"&mining=" & expand_srch
			
			'print qryOptions
			
			
			response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
			response.write "<A HREF=""/include/system/tools/activity/applications/view/?Page=1&" & qryOptions & """>First</A>"
			For i = startPage to stopPage
				response.write "<A HREF=""/include/system/tools/activity/applications/view/?Page="& i & qryOptions & """>&nbsp;"
				if i = nPage then
					response.write "<span style=""color:red"">" & i & "</span>"
				Else
					if (i = stopPage and i < nPageCount) or (i = startPage and i > 1) then
						response.write "..."
					else
						response.write i
					end if
				end if
				response.write "&nbsp;</A>"
			Next
			response.write "<A HREF=""/include/system/tools/activity/applications/view/?Page=" & nPageCount & qryOptions & """>Last</A>"
			response.write("</div>")
		
			' Position recordset to the correct page
			if Not Applications.eof then Applications.AbsolutePage = nPage
		
		end if

		'if service suppress table header
		if not isservice then 
			Response.write "<div id='appResults'><table class='onlineApps' id=""applications""><tr>" &_
				"<th class='appCompanies' colspan='6'>Enroll Into</th>" &_
				"<th class='appName'>Name</th>" &_
				"<th class='appSSN'>&nbsp;</th>" &_
				"<th class='appLocation'>Location</th>" &_
				"<th class='appPhone'>Phone</th>" &_
				"<th class='appDate'>Date</th></tr>"
		end if
				
		inSystem = "class=" & Chr(34) & "inSystem" & Chr(34) & " "
		notInSystem = "class=" & Chr(34) & "notInSystem" & Chr(34) & " "
	
		emailLink = "/include/system/tools/images/email.gif"
		noEmailLink = "/include/system/tools/images/noEmail.gif"

		updatedLink = "/include/system/tools/images/updated.gif"
		notUpdatedLink = "/include/system/tools/images/notUpdated.gif"

		if Applications.eof then response.write "No Items found."

do while not ( Applications.Eof Or Applications.AbsolutePage <> nPage )

		if Applications.eof then
			Applications.Close
			' Clean up
			' Do the no results HTML here
			response.write "No Items found."
				' Done
			Response.End 
		end if

		
			appID = Applications.Fields.Item("applicationId")
			ssn = Applications.Fields.Item("ssn")
			inAtLeastOne = false : rowEmphasis = ""
			
			inIDA = notInSystem
			inBOI = notInSystem
			inPER = notInSystem
			inBUR = notInSystem
			inBUR = notInSystem
			inPOC = notInSystem
			inPPI = notInSystem
			
			if Not VarType(Applications("inIDA")) = 1 then
				inIDA = inSystem
				inAtLeastOne = true
			end if
			
			if Not VarType(Applications("inPER")) = 1 then
				inPER = inSystem
				inAtLeastOne = true
			end if

			if Not VarType(Applications("inBOI")) = 1 then
				inBOI = inSystem
				inAtLeastOne = true
			end if
			
			if Not VarType(Applications("inBUR")) = 1 then
				inBUR = inSystem
				inAtLeastOne = true
			end if
			
			if Not VarType(Applications("inPOC")) = 1 then
				inBUR = inSystem
				inAtLeastOne = true
			end if
			
			if Not VarType(Applications("inPPI")) = 1 then
				inBUR = inSystem
				inAtLeastOne = true
			end if
			
			if inAtLeastOne = false then
				rowEmphasis = " notInSystem"
			end if
			
			ModifiedTime = Applications.Fields.Item("modifiedDate")
			InsertedTime = Applications.Fields.Item("lastInserted")
			if  DateDiff("n", InsertedTime, ModifiedTime) > 0 then
				rowEmphasis = " notInSystem"
				'Updated = "<img src=" & Chr(34) & updatedLink & Chr(34) & ">"
				
				'pre-ajax
				'Updated = "<a href=""/pdfServer/pdfApplication/createApplication.asp?appID=" & CStr(appID) & "&action=inject&update=1""><span class=""updated"">&nbsp;</span></a>"
				
				Updated = "<a href=""/pdfServer/pdfApplication/createApplication.asp?appID=" & CStr(appID) & "&action=inject&update=1""><span class=""updated"">&nbsp;</span></a>"
			Else
				'pre ajax
				'Updated = "<span class=""notupdated"">&nbsp;</span>"
				
				Updated = "<span class=""notupdated"">&nbsp;</span>"
				
				'Updated = "<img src=" & Chr(34) & notUpdatedLink & Chr(34) & ">"
			end if
			
			applicationLink = "/pdfServer/pdfApplication/createApplication.asp?appID=" & CStr(appID)
			ajaxlink = "javascript:;"" onclick=""action.inject('appID=" & CStr(appID)
			
			if i > 0 then
				ShadeData = "FFFFFF"
				i = 0
			Else
				ShadeData = "EFF5FA"
				i = 1
			end if

			mainphone = Applications.Fields.Item("mainPhone")
			altphone = Applications.Fields.Item("altPhone")
			if len(altphone) > 0 then mainphone = mainphone & ",<br />"
			
			addressLine = PCase(Applications.Fields.Item("city")) & ", " & UCase(Applications.Fields.Item("state")) & " " & Applications.Fields.Item("zip")
			
			form_link = "<a href='" & applicationLink & "&amp;action=review'>"
			applicantEmail = Applications("email")
			
			if not isservice then
				Response.write "<tr id=""row" & CStr(appID) & """ style='background-color:#" & ShadeData & "'>"
			end if
			
			
			if Applications("submitted") = "n" then
			
				if len(applicantEmail) > 0 then
					lnkName = Updated & "<a href=" & Chr(34) & "mailto:" & applicantEmail & """><img src=" &_
						Chr(34) & emailLink & Chr(34) & "></a>" & Applications.Fields.Item("lastName") & ", " & Applications.Fields.Item("firstName") 
				Else
					lnkName = Updated & "<img src=" & Chr(34) & noEmailLink & """>" &_
						Applications.Fields.Item("lastName") & ", " & Applications.Fields.Item("firstName")
				end if
				

				ssn4 = "<span class=""incomplete"">&nbsp;</span>"
				interviewLink = ""
				rowEmphasis = " notDoneYet"

				Response.write "<td class='appCompany small" & rowEmphasis & "'>Boi</td>"
				Response.write "<td class='appCompany small" & rowEmphasis & "'>PPI</td>"
				Response.write "<td class='appCompany small" & rowEmphasis & "'>Per</td>"
				Response.write "<td class='appCompany small" & rowEmphasis & "'>Bur</td>"
				Response.write "<td class='appCompany small" & rowEmphasis & "'>Poc</td>"
				Response.write "<td class='appCompany small" & rowEmphasis & "'>IDA</td>"
				Response.write "<td class='appName " & rowEmphasis & "'><span class=""noneofit""></span>" & lnkName & "</td>"
				Response.write "<td class='appSSN'>" & ssn4 & "</td>"
				Response.write "<td class='appLocation" & rowEmphasis & "'><div class='' style='white-space:nowrap; overflow:hidden; width:10em;'>" & addressLine & "</div></td>"
				Response.write "<td class='appPhone " & rowEmphasis & "'>" & mainphone & altphone & "</td>"
				Response.write "<td class='appDate " & rowEmphasis & "'>" &_			
					"" &_
					FormatDateTime(Applications.Fields.Item("modifiedDate"), 2) & "&nbsp;" & "</td>"

			else
			
				if len(applicantEmail) > 0 then
					lnkName = Updated & "<a href=" & Chr(34) & "mailto:" & applicantEmail & Chr(34) & "><img src=" &_
						Chr(34) & emailLink & Chr(34) & "></a>" & form_link & Applications.Fields.Item("lastName") & ", " & Applications.Fields.Item("firstName") 
				Else
					lnkName = Updated & "<img src=" & Chr(34) & noEmailLink & Chr(34) & ">" &_
						form_link & Applications.Fields.Item("lastName") & ", " & Applications.Fields.Item("firstName")
				end if
				
				interviewed = Applications.Fields.Item("interviewID")
				if isnull(interviewed) then 'They've had an interview already
					interviewLink = "<a class=""interview"" href=""/include/system/tools/applicant/interview/?app_id=" & CStr(appID) & """>&nbsp;</a>"
				else 'They haven't been interviewed yet
					interviewLink = "<a class=""interviewed"" href=""/include/system/tools/applicant/interview/?app_id=" & CStr(appID) & """>&nbsp;</a>"
				end if
				'ssn4 = form_link & Right(ssn, 4)
				if inAtLeastOne then
					ssn4 = "<span class=""enrolled"">&nbsp;</span>"
				else
					ssn4 = "<span class=""appcompleted"">&nbsp;</span>"
				end if
				
				Response.write "<td class='appCompany small'><a " & inBOI & "href=""" & ajaxlink & "&amp;action=inject&amp;company=BOI')"">Boi</a></td>"
				Response.write "<td class='appCompany small'><a " & inPPI & "href=""" & ajaxlink & "&amp;action=inject&amp;company=PPI')"">PPI</a></td>"
				Response.write "<td class='appCompany small'><a " & inPER & "href=""" & ajaxlink & "&amp;action=inject&amp;company=PER')"">Per</a></td>"
				Response.write "<td class='appCompany small'><a " & inBUR & "href=""" & ajaxlink & "&amp;action=inject&amp;company=BUR')"">Bur</a></td>"
				Response.write "<td class='appCompany small'><a " & inPOC & "href=""" & ajaxlink & "&amp;action=inject&amp;company=POC')"">Poc</a></td>"
				Response.write "<td class='appCompany small'><a " & inIDA & "href=""" & ajaxlink & "&amp;action=inject&amp;company=IDA')"">IDA</a>&nbsp;</td>"
				Response.write "<td class='appName " & rowEmphasis & "'>" &_			
					"<a class=""allofit"" href='" & applicationLink & "&amp;action=review&amp;giveme=justapp'>&nbsp;</a>" & lnkName & "</a>" & interviewLink & "</td>"
				Response.write "<td class='appSSN" & rowEmphasis & "'>" & ssn4 & "</a></td>"
				Response.write "<td class='appLocation" & rowEmphasis & "'><div class=' croplocation' style=''>" & form_link & addressLine & "</a></div></td>"
				Response.write "<td class='appPhone " & rowEmphasis & "'>" & form_link & mainphone & altphone & "</a></td>"
				Response.write "<td class='appDate " & rowEmphasis & "'>" &_			
					"" &_
					form_link & FormatDateTime(Applications.Fields.Item("modifiedDate"), 2) & "</a>&nbsp;" &_
					"</td>"

			end if
			
			
			'<a href='" & applicationLink & "&amp;action=review&amp;giveme=mostofit'>&nbsp;</a>
			
				
			if not isservice then response.write "</tr>"
			inBOI = "" : inBUR = "" : inPER = "" : inIDA = "" : 
			Applications.MoveNext
			
		loop
		
		'if running as service disable closing table
		if not isservice then Response.write "</table></div>"
		
		'drop temp search bindings for this session, if used
		if instr(SQL, "txt_srch ON") > 0 then
			Applications.close
				'create temporary table
			SQL = "DELETE FROM txt_srch WHERE session_id=""" & session_id & """;"

			Applications.Open SQL, MySql
		end if
		
		Set Applications = nothing
		'Set getApplications_cmd = Nothing
		Database.Close
	'end if
	
	'disable page nave response if service
	if not isservice then
		response.write "<div id=""topPageRecords"" class=""navPageRecords"">"
		response.write "<A HREF=""/include/system/tools/activity/applications/view/?Page=1" & qryOptions & """>First</A>"
			For i = 1 to nPageCount
				response.write "<A HREF=""/include/system/tools/activity/applications/view/?Page="& i & qryOptions & """>&nbsp;"
				if i = nPage then
					response.write "<span style=""color:red"">" & i & "</span>"
				Else
					response.write i
				end if
				response.write "&nbsp;</A>"
			Next
		response.write "<A HREF=""/include/system/tools/activity/applications/view/?Page=" & nPageCount & qryOptions & """>Last</A>"
		response.write("</div></div>")

noSocial = true %>
<%=decorateBottom()%>
</div>


<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->

<% end if %>
