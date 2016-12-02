<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<%
session("add_css") = "reports.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/followActivities.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%

leftSideMenu = "<p><strong>Include the following activities:</strong></p>"

dim whichCompany
whichCompany = Request.QueryString("whichCompany")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if

const sys_unknown_1 = 0
const sys_unknown_2 = 1
const sys_placement = 2
const sys_joborder = 3
const sys_customer = 4
const sys_employee = 5
const sys_applicant = 6

const act_interview = 7
const act_other = 8
const act_placement = 9
const act_marketing = 10
const act_arrivalcall = 11
const act_sentresume = 12
const act_unemployment = 13
const act_csorder = 14
const act_collection = 15
const act_terminated = 16
const act_jocorrespond = 17
const act_clientqa = 18
const act_available = 19
const act_rates = 20
const act_workcomp = 21

const act_start = 7
const act_stop = 21
const sys_start = 0
const sys_stop = 6

const act_id = 0
const description = 1
const selected = 2

dim include_these(21, 2)

include_these(sys_unknown_1, act_id) = -7
include_these(sys_unknown_2, act_id) = -6
include_these(sys_placement, act_id) = -5
include_these(sys_joborder, act_id) = -4
include_these(sys_customer, act_id) = -3
include_these(sys_employee, act_id) = -2
include_these(sys_applicant, act_id) = -1
include_these(act_interview, act_id) = 0
include_these(act_other, act_id) = 3
include_these(act_placement, act_id) = 4
include_these(act_marketing, act_id) = 5
include_these(act_arrivalcall, act_id) = 6
include_these(act_sentresume, act_id) = 7
include_these(act_unemployment, act_id) = 8
include_these(act_csorder, act_id) = 9
include_these(act_collection, act_id) = 11
include_these(act_terminated, act_id) = 12
include_these(act_jocorrespond, act_id) = 13
include_these(act_clientqa, act_id) = 14
include_these(act_available, act_id) = 15
include_these(act_rates, act_id) = 16
include_these(act_workcomp, act_id) = 17

include_these(sys_unknown_1, description) = "Tracking-7"
include_these(sys_unknown_2, description) = "Tracking-6"
include_these(sys_placement, description) = "Placement"
include_these(sys_joborder, description) = "Job Order"
include_these(sys_customer, description) = "Customer"
include_these(sys_employee, description) = "Employee"
include_these(sys_applicant, description) = "Applicant"
include_these(act_interview, description) = "Interview"
include_these(act_other, description) = "Other"
include_these(act_placement, description) = "Placement"
include_these(act_marketing, description) = "Marketing"
include_these(act_arrivalcall, description) = "Arrival Call"
include_these(act_sentresume, description) = "Sent Resume"
include_these(act_unemployment, description) = "Unemployment"
include_these(act_csorder, description) = "Child Support"
include_these(act_collection, description) = "Collection"
include_these(act_terminated, description) = "Terminated"
include_these(act_jocorrespond, description) = "Correspondance"
include_these(act_clientqa, description) = "Client Q/A"
include_these(act_available, description) = "Availability"
include_these(act_rates, description) = "Rates"
include_these(act_workcomp, description) = "Workcomp"

'load collection from querystring, if none load from form
dim i, make_torf
for i = sys_start to act_stop

	include_these(i, selected) = cbool(Request.QueryString("activity_" & include_these(i, act_id)))
	
	if include_these(i, selected) = false then
		include_these(i, selected) = cbool(Request.form("activity_" & include_these(i, act_id)))
	end if

	' while we are at it build the sql selection criteria '
	dim include_what, init_yet, init_done
	init_yet = len(include_what)

	if include_these(i, selected) = true then
		include_what = include_what & "Appointments.ApptTypeCode=" & include_these(i, act_id) & " "
	end if

	if init_yet = 0 and len(include_what) > 0 then
		include_what = "WHERE (" & include_what & "OR "
		init_done = true
	elseif init_done = true and include_these(i, selected) = true then
		include_what = include_what & "OR "
	end if		
next

'if something was selected then remove trailing "OR "'
init_done = len(include_what)
if init_done > 0 then include_what = trim(left(include_what, init_done - 3)) & ") "

'init checked text string blob
const checkedText = "checked=""checked"""

'init date selection'
dim act_when, act_all, act_past, act_future
select case request.querystring("act_when")
case "all"
	act_all= " " & checkedText
	act_when = "all"
case "past"
	act_past = " " & checkedText
	act_when = "past"
case "future"
	act_future = " " & checkedText
	act_when = "future"
case else
	select case request.form("act_when")
	case "all"
		act_all= " " & checkedText
		act_when = "all"
	case "past"
		act_past = " " & checkedText
		act_when = "past"
	case "future"
		act_future = " " & checkedText
		act_when = "future"
	case else
		act_all= " " & checkedText
		act_when = "all"
	end select
end select

if len(include_what) = 0 then
	include_what = "WHERE "
else
	include_what = include_what & "AND "
end if

dim order_this_way

if include_what <> "WHERE " then
	select case act_when
	case "past"
		include_what = include_what & "Appointments.AppDate <= #" & date() & "#"
		order_this_way = "ORDER BY Appointments.AppDate DESC;"

	case "future"
		include_what = include_what & "Appointments.AppDate >= #" & date() & "#"
		order_this_way = "ORDER BY Appointments.AppDate ASC;"

	case "all"
		include_what = left(include_what, init_done - 3) 'remove trailing "AND "'
		order_this_way = "ORDER BY Appointments.AppDate DESC;"

	end select
else
	include_what = ""
end if

dim the_query
the_query = Request.QueryString("query")



%>
<%=decorateTop("track_activities", "notToShort marLR10", "Activity Tracks")%>
<div id="whoseHereList">

<form id="activity_form" name="activity_form" action="<%=aspPageName%>" method="get">
  <p>
	<%=objCompanySelector(whichCompany, false, "javascript:document.activity_form.submit();")%>
   	<a style="float:right;" class="squarebutton" href="#" onclick="act_refresh();" style="margin:.25em 1em .25em"><span>Refresh View</span></a>

  </p>

	<div id="what_activities" class="navPageRecords">

		<p><strong>Include the following activities:</strong></p>
		<ul class="what_activities"> <%
			for i = act_start to act_stop
				response.write "<li><label><input type=""checkbox"" name=""activity_" & include_these(i, act_id) & """ " &_
					"value=""1"" "
				if include_these(i, selected) = true then Response.write(checkedText)
				
				response.Write " id=""activity_" & include_these(i, act_id) & """/>" & include_these(i, description) &_
					"</label></li>"
			next
			%>
		</ul>
		<p><strong>Include the following system activities:</strong></p>
		<ul class="what_activities"> <%
			for i = sys_start to sys_stop
				response.write "<li><label><input type=""checkbox"" name=""activity_" & include_these(i, act_id) & """ " &_
					"value=""1"" "
				if include_these(i, selected) = true then Response.write(checkedText)
				
				response.Write " id=""activity_" & include_these(i, act_id) & """/>" & include_these(i, description) &_
					"</label></li>"
			next
			%>
		</ul>
	  
		 </div>
  
	<ul id="which_dates" class="what_activities">
		<li><strong>Include what dates:</strong></li>
		<li><label><input type="radio" id="act_when_all" name="act_when" value="all"<%=act_all%>>All dates</label></li>
		<li><label><input type="radio" id="act_when_past" name="act_when" value="past"<%=act_past%>>Past dates</label></li>
		<li><label><input type="radio" id="act_when_future" name="act_when" value="future"<%=act_future%>>Future dates</label></li>
	</ul>
</form>
  <%
	if len(whichCompany & "") > 0 and len(include_what) > 0 then
		thisConnection = dsnLessTemps(getTempsDSN(whichCompany))
				
		'Set getDailySignIn_cmd = Server.CreateObject ("ADODB.Command")
		Set WhoseHere = Server.CreateObject ("ADODB.RecordSet")

		With WhoseHere
			'.ActiveConnection = thisConnection
			.CursorLocation = 3 ' adUseClient
			dim sqlCommandText
			sqlCommandText = "SELECT Appointments.AppDate, Appointments.Reference, Appointments.Customer, Appointments.Comment, " &_
				"Customers.Contact, Customers.Phone, Applicants.LastnameFirst, Applicants.Telephone, Orders.WorkSite3, Orders.JobSupervisor, " &_
				"Customers.CustomerName, Orders.JobDescription, Applicants.ApplicantID, Appointments.EnteredBy, " &_
				"Dispositions.Disposition, ApptTypes.ApptType, Appointments.AssignedTo " &_
				"FROM Dispositions INNER JOIN (ApptTypes INNER JOIN (((Appointments " &_
				"LEFT JOIN Applicants ON Appointments.ApplicantId = Applicants.ApplicantID) " &_
				"LEFT JOIN Customers ON Appointments.Customer = Customers.Customer) " &_
				"LEFT JOIN Orders ON Appointments.Reference = Orders.Reference) " &_
				"ON ApptTypes.ApptTypeCode = Appointments.ApptTypeCode) " &_
				"ON Dispositions.DispTypeCode = Appointments.DispTypeCode " &_
				include_what &_
				order_this_way

			'.Prepared = true
			'break sqlCommandText
			'Response.End()
			.Open sqlCommandText, thisConnection
		End With
		'Set WhoseHere = getDailySignIn_cmd.Execute	
		
		
	dim nPage, nItemsPerPage, nPageCount
	
	nPage = CInt(Request.QueryString("Page"))
	nItemsPerPage = 20
	WhoseHere.PageSize = nItemsPerPage
	nPageCount = WhoseHere.PageCount

	if nPage < 1 Or nPage > nPageCount then
		nPage = 1
	end if
	
	rsQuery = request.serverVariables("QUERY_STRING")
	queryPageNumber = Request.QueryString("Page")
	if queryPageNumber then
		rsQuery = Replace(rsQuery, "Page=" & queryPageNumber & "&", "")
	end if


	response.write("<div id=""topPageRecords"" class=""navPageRecords"">")

	response.write "<A HREF=""" & aspPageName & "?Page=1&whichCompany=" & whichCompany & """>First</A>"
	For i = 1 to nPageCount
		response.write "<A HREF=""" & aspPageName & "?Page="& i & "&whichCompany=" & whichCompany & """>&nbsp;"
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
	response.write "<A HREF=""" & aspPageName & "?Page=" & nPageCount & "&whichCompany=" & whichCompany & """>Last</A>"
	response.write("</div>")

	' Position recordset to the correct page
	if not WhoseHere.eof then WhoseHere.AbsolutePage = nPage

		tableHeader = "<table class='placementTbl' style='width:100%'><tr>" &_
				"<th class=""dateAndTime"">Date & Time</th>" &_
				"<th class=""customer"">Applicant</th>" &_
				"<th class=""reason"">Reason</th>" &_
				"<th class=""""></th>" &_
				"<th class=""user"">Entered By</th>" &_
			"</tr><tr>" &_
				"<th></th>" &_
				"<th colspan=""3""></th>" &_
				"<th></th>" &_
			"</tr>"
		
		
		dim phoneApplicant, phoneCustomer, phoneOrder, contactOrder, contactCustomer
		dim applicantid, lastnameFirst, maintain_link, resourcelink
		
		resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"
		
		do while not ( WhoseHere.Eof Or WhoseHere.AbsolutePage <> nPage )
				if WhoseHere.eof then
					WhoseHere.Close
					' Clean up
					' Do the no results HTML here
					response.write "No Items found."
						' Done
					Response.End 
				end if
				
			CommentBlob = WhoseHere("Comment")
			if len(CommentBlob) = 0 then
				CommentBlob = "{none}"
			end if

			phoneApplicant = WhoseHere("TelePhone")
			phoneCustomer = WhoseHere("Phone")
			phoneOrder = WhoseHere("WorkSite3")

			applicantid = WhoseHere("ApplicantID")
			lastnameFirst = WhoseHere("LastnameFirst")
			maintain_link = "<a href=""" & resourcelink & "who=" & applicantid & "&where=" & whichCompany & """>" &_
				applicantid & " : " & lastnameFirst
				
			tableRecord = "<tr>" &_
				"<td>" & WhoseHere("AppDate") & "</td>" &_
			"<td>" & maintain_link & "</td>" &_
			 "<td>" & WhoseHere("ApptType") & "</td>" &_
			"<td></td>" &_
			"<td>" & WhoseHere("EnteredBy") & "</td>" &_
			"</tr><tr>" &_
				"<th></th>" &_
				"<td>" & FormatPhone(phoneApplicant) & "</td>" &_
				"<td></td>" &_
				"<td></td>" &_
				"<td></td>" &_
			"</tr><tr>" &_
				"<th>Customer</th>" &_
				"<th>Job Order</th>" &_
				"<th>Status</th>" &_
				"<th></th>" &_
				"<th>Assigned To</th>" &_
			"</tr><tr>" &_
				"<td>" & WhoseHere("Customer") & " : " & WhoseHere("CustomerName") & "</td>" &_
				"<td>" & WhoseHere("Reference") & " : " & WhoseHere("JobDescription") & "</td>" &_
				"<td colspan=""2"">" & WhoseHere("Disposition") & "</td>" &_
				"<td>" & WhoseHere("AssignedTo") & "</td>" &_
			"</tr><tr>" &_
				"<td>" & WhoseHere("Contact") & " : " & FormatPhone(phoneCustomer) & "</td>" &_
				"<td>" & WhoseHere("JobSupervisor") & " : " & FormatPhone(phoneOrder) & "</td>" &_
			"</tr><tr><td colspan=""5"">&nbsp;</td>" &_
			"</tr><tr>" &_
				"<td colspan=""4""><b>Memo</b> : " & CommentBlob & "</td>" &_
			"</tr>"
			
			Response.write tableHeader
			Response.write tableRecord
			Response.write "</table>"




			WhoseHere.MoveNext
		loop
		Response.write "</table>"
		Set WhoseHere = nothing
		response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
		response.write "<A HREF=""" & aspPageName & "?Page=1&whichCompany=" & whichCompany & """>First</A>"
		nav_break = 0
		For i = 1 to nPageCount
			response.write "<A HREF=""" & aspPageName & "?Page="& i & "&whichCompany=" & whichCompany & """>&nbsp;"
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
		response.write "<A HREF=""" & aspPageName & "?Page=" & nPageCount & "&whichCompany=" & whichCompany & """>Last</A>"
		response.write("</div>")
	end if
%>
</div>Hello
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
