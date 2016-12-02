<%
dim whichCompany
whichCompany = Request.QueryString("whichCompany")

if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if

dim thisCustomer
thisCustomer = Request.QueryString("WhichCustomer")
thisCustomer = Replace(thisCustomer, "'", "''")

dim whichOrder
whichOrder = Request.QueryString("whichOrder")
if len(whichOrder) = 0 then
	whichOrder = request.form("whichOrder")
end if

dim thisOrder
thisOrder = whichOrder

dim whichApplicant
whichApplicant = Request.QueryString("whichApplicant")
if len(whichApplicant) = 0 then
	whichApplicant = request.form("whichApplicant")
end if

dim prospecting
prospecting = cbool(Request.QueryString("prospecting"))

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

const sys_unknown_1 = 0
const sys_unknown_2 = 1
const sys_placement = 2
const sys_joborder = 3
const sys_customer = 4
const sys_employee = 5
const sys_applicant = 6

const act_interview = 7
const act_other = 8
const act_qa = 9
const act_marketing = 10
const act_arrivalcall = 11
const act_sentresume = 12
const act_unemployment = 13
const act_csorder = 14
const act_collection = 15
const act_separation = 16
const act_jocorrespond = 17
const act_clientqa = 18
const act_available = 19
const act_rates = 20
const act_workcomp = 21
const act_accident = 22

const act_start = 7
const act_stop = 22
const sys_start = 0
const sys_stop = 6

const act_id = 0
const description = 1
const selected = 2

dim include_these(22, 2)

include_these(sys_unknown_1, act_id) = -7
include_these(sys_unknown_2, act_id) = -6
include_these(sys_placement, act_id) = -5
include_these(sys_joborder, act_id) = -4
include_these(sys_customer, act_id) = -3
include_these(sys_employee, act_id) = -2
include_these(sys_applicant, act_id) = -1
include_these(act_interview, act_id) = 0
include_these(act_other, act_id) = 3
include_these(act_qa, act_id) = 6
include_these(act_marketing, act_id) = 5
include_these(act_arrivalcall, act_id) = 4
include_these(act_sentresume, act_id) = 7
include_these(act_unemployment, act_id) = 8
include_these(act_csorder, act_id) = 9
include_these(act_collection, act_id) = 11
include_these(act_separation, act_id) = 12
include_these(act_jocorrespond, act_id) = 13
include_these(act_clientqa, act_id) = 14
include_these(act_available, act_id) = 15
include_these(act_rates, act_id) = 16
include_these(act_workcomp, act_id) = 17
include_these(act_accident, act_id) = 18

include_these(sys_unknown_1, description) = "Tracking-7"
include_these(sys_unknown_2, description) = "Tracking-6"
include_these(sys_placement, description) = "Placement"
include_these(sys_joborder, description) = "Job Order"
include_these(sys_customer, description) = "Customer"
include_these(sys_employee, description) = "Employee"
include_these(sys_applicant, description) = "Applicant"
include_these(act_interview, description) = "Interviews"
include_these(act_other, description) = "Other"
include_these(act_qa, description) = "Placed Follow/Ups"
include_these(act_marketing, description) = "Marketing"
include_these(act_arrivalcall, description) = "Arrival Calls"
include_these(act_sentresume, description) = "Sent Resumes"
include_these(act_unemployment, description) = "Unemployment"
include_these(act_csorder, description) = "Child Support"
include_these(act_collection, description) = "Collections"
include_these(act_separation, description) = "Separations"
include_these(act_jocorrespond, description) = "Correspondance"
include_these(act_clientqa, description) = "Client Q/A"
include_these(act_available, description) = "Availability"
include_these(act_rates, description) = "Rates"
include_these(act_workcomp, description) = "Workcomp"
include_these(act_accident, description) = "Accidents"

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
dim act_when, act_all, act_past, act_future, act_custom, show_date_form

show_date_form = "hide" 'default flag for date entry form
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
case "custom"
	act_custom = " " & checkedText
	act_when = "custom"
	show_date_form = "show"
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
	case "custom"
		act_custom = " " & checkedText
		act_when = "custom"
		show_date_form = "show"
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
		include_what = include_what & "Appointments.AppDate <= '" & date() & "'"
		order_this_way = "ORDER BY Appointments.AppDate DESC;"

	case "future"
		include_what = include_what & "Appointments.AppDate >= '" & date() & "'"
		order_this_way = "ORDER BY Appointments.AppDate ASC;"

	case "custom"
		include_what = include_what &_
			"(Appointments.AppDate >= '" & fromDate & "' AND " &_
			"Appointments.AppDate <= '" & toDate & "')"
		order_this_way = "ORDER BY Appointments.AppDate DESC;"

	case "all"
		include_what = left(include_what, init_done - 3) 'remove trailing "AND "'
		order_this_way = "ORDER BY Appointments.AppDate DESC;"

	end select
else
	include_what = ""
end if


'add "Customer" WHERE condition to sql blob

if len(thisCustomer) > 0 and thisCustomer <> "@ALL" then
	dim strProspectingSwap
	if prospecting then
		strProspectingSwap = " Customers.CustomerType=""P"" AND"
	end if
	
	dim swapThis
	if len(thisOrder) > 0 and thisOrder <> "@ALL" then
		swapThis = "WHERE Appointments.Reference=" & thisOrder & " AND" & strProspectingSwap & " ("
	else
		swapThis = "WHERE Appointments.Customer=""" & thisCustomer & """ AND" & strProspectingSwap & " ("
	end if
	
	if len(include_what) > 0 then
		include_what = Replace(include_what, "WHERE (", swapThis)
	else
		include_what = swapThis
	end if
elseif prospecting then
	include_what = "WHERE Customers.CustomerType=""P"""
end if	

dim the_query
the_query = Request.QueryString("query")


'makes the selection guide left menu
function makeSideMenu ()
	dim strTmp
	
	strTmp = "<div id=""what_activities"" class=""navPageRecords"">" &_
			"<p><strong>Include these:</strong></p>" &_
			"<ul class=""what_activities"">"

	for i = act_start to act_stop
		if include_these(i, selected) = true then
			strTmp = strTmp & "<li><label><input type=""checkbox"" name=""activity_" &_
				include_these(i, act_id) & """ " &_
				"value=""1"" " & checkedText
		else
			strTmp = strTmp & "<li><label><input type=""checkbox"" name=""activity_" &_
				include_these(i, act_id) & """ " &_
				"value=""1"" "
		end if
		
		strTmp = strTmp & " id=""activity_" & include_these(i, act_id) & """/>" & include_these(i, description) &_
			"</label></li>"
	next
	strTmp = strTmp &_	
		"</ul>" &_
		"<p><strong>System activities:</strong></p>" &_
		"<ul class=""what_activities"">"
		
			for i = sys_start to sys_stop
				if include_these(i, selected) = true then
					strTmp = strTmp & "<li><label><input type=""checkbox"" name=""activity_" &_
						include_these(i, act_id) & """ " &_
						"value=""1"" "
				else
					strTmp = strTmp & "<li><label><input type=""checkbox"" name=""activity_" &_
						include_these(i, act_id) & """ " &_
						"value=""1"" "
				end if
				
				strTmp = strTmp & " id=""activity_" & include_these(i, act_id) & """/>" & include_these(i, description) &_
					"</label></li>"
			next
			
		if prospecting then
			strTmp = strTmp &_
				"</ul>" &_
				"<p><strong>Prospecting?</strong></p>" &_
				"<ul class=""what_activities"">"&_		
				"<li><label><input type=""checkbox"" name=""prospecting"" " &_
				" id=""prospecting"" value='1' checked=""checked"" />Show Prospects" &_
				"</label></li></ul>" &_
				"</div></form>"
		else
			strTmp = strTmp &_
				"</ul>" &_
				"<p><strong>Prospecting?</strong></p>" &_
				"<ul class=""what_activities"">"&_		
				"<li><label><input type=""checkbox"" name=""prospecting"" " &_
				" id=""prospecting"" value='1'/>Show Prospects" &_
				"</label></li></ul>" &_
				"</div></form>"
		end if


	makeSideMenu = strTmp
end function

function navChooseCustomer (whichCompany)
	if len(whichCompany & "") > 0 then
		Select Case whichCompany
		Case "BUR"
			thisConnection = dsnLessTemps(BUR)
		Case "PER"
			thisConnection = dsnLessTemps(PER)
		Case "BOI"
			thisConnection = dsnLessTemps(BOI)
		Case "IDA"
			thisConnection = dsnLessTemps(IDA)
		End Select
		
		Set WhichCustomer = Server.CreateObject("ADODB.RecordSet")

		if prospecting then
			sqlWhichCustomer = "SELECT DISTINCT Orders.Customer, Customers.CustomerName FROM (Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) " &_
				"AND (Customers.Customer = Orders.Customer)) " &_
				"LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference WHERE (((Customers.CustomerType)=""P"")) " &_
				"ORDER BY Customers.CustomerName;"
		else		

			sqlWhichCustomer = "SELECT DISTINCT Orders.Customer, Customers.CustomerName FROM (Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) " &_
				"AND (Customers.Customer = Orders.Customer)) " &_
				"LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference WHERE (((Orders.JobStatus)=3)) " &_
				"ORDER BY Customers.CustomerName;"
		end if
				
		WhichCustomer.CursorLocation = 3 ' adUseClient
		WhichCustomer.Open sqlWhichCustomer, thisConnection
		
		dim CurrentCustomer, strDisplayText
		response.write "<div id=""topPageRecordsByCust"" class=""altNavPageRecords navPageRecords""><strong>Select Customer: </strong>" &_
			"<input name=""WhichCustomer"" id=""WhichCustomer"" type=""hidden"" value=""" & thisCustomer & """>" &_
			
			"<br><div id=""scrollCustomers"">"

			CurrentCustomer = "@ALL"
			response.write "<A HREF=""#"" onclick=""act_refresh_customer('" & CurrentCustomer & "')"">&nbsp;"
			if thisCustomer = CurrentCustomer then
				response.write "<span style=""color:red"">" & CurrentCustomer & "</span>"
			Else
				response.write CurrentCustomer
			end if
			response.write "&nbsp;</A>"
			
		do while not WhichCustomer.Eof
			CurrentCustomer = WhichCustomer("Customer")

			strDisplayText = Replace(WhichCustomer("CustomerName"), "&", "&amp;")
			strDisplayText = Replace(strDisplayText, " ", "&nbsp;")
			
			response.write "<A HREF=""#"" onclick=""act_refresh_customer('" & CurrentCustomer & "')"">&nbsp;"
			if thisCustomer = CurrentCustomer then
				response.write "<span style=""color:red"">" & strDisplayText & "</span>"
			Else
				response.write strDisplayText
			end if
			response.write "&nbsp;</A>"
			WhichCustomer.MoveNext
	
			linkNumber = linkNumber + 1
			if linkNumber > 10 and Not WhichCustomer.Eof then
				linkNumber = 0
				response.write "<br>"
			end if
		loop
		response.write("</div></div>")

		WhichCustomer.Close
		Set WhichCustomer = Nothing

	end if
end function

function navChooseJobOrder (thisOrder)
	dim strDisplayText

	if len(whichCompany & "") > 0 then
		Select Case whichCompany
		Case "BUR"
			thisConnection = dsnLessTemps(BUR)
		Case "PER"
			thisConnection = dsnLessTemps(PER)
		Case "BOI"
			thisConnection = dsnLessTemps(BOI)
		End Select

			
		Set rsWhichOrder = Server.CreateObject("ADODB.RecordSet")
		sqlWhichOrder = "SELECT DISTINCT Orders.Customer, Orders.JobDescription, Orders.Reference FROM (Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) " &_
			"AND (Customers.Customer = Orders.Customer)) " &_
			"LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference WHERE Orders.Customer='" & thisCustomer & "' " &_
			"ORDER BY Orders.JobDescription;"
		
		rsWhichOrder.CursorLocation = 3 ' adUseClient
		rsWhichOrder.Open sqlWhichOrder, thisConnection
		
		dim CurrentOrder
		response.write "<div id=""topPageRecordsByOrder"" class=""altNavPageRecords navPageRecords""><strong>Job Orders: </strong>" &_
			"<input name=""WhichOrder"" id=""WhichOrder"" type=""hidden"" value=""" & thisOrder & """>" &_
			
			"<br><div id=""scrollCustomers"">"
			CurrentOrder = "@ALL"
			response.write "<A HREF=""#"" onclick=""act_refresh_order('" & CurrentOrder & "')"">&nbsp;"
			if thisOrder = CurrentOrder or thisOrder = "" then
				response.write "<span style=""color:red"">" & CurrentOrder & "</span>"
			Else
				response.write CurrentOrder
			end if
			response.write "&nbsp;</A>"
			
		do while not rsWhichOrder.Eof
			CurrentOrder = rsWhichOrder("Reference")
			strDisplayText = Replace(rsWhichOrder("JobDescription"), "&", "&amp;")
			strDisplayText = Replace(strDisplayText, " ", "&nbsp;")
			
			response.write "<A HREF=""#"" onclick=""act_refresh_order('" & CurrentOrder & "')"">&nbsp;"

			if trim(thisOrder) = trim(CurrentOrder) then
				response.write "<span style=""color:red"">" & strDisplayText & "</span>"
			Else
				response.write strDisplayText
			end if
			response.write "&nbsp;</A>"
			rsWhichOrder.MoveNext
	
			linkNumber = linkNumber + 1
			if linkNumber > 10 and Not rsWhichOrder.Eof then
				linkNumber = 0
				response.write "<br>"
			end if
		loop
		response.write("</div></div>")

		rsWhichOrder.Close
		Set rsWhichOrder = Nothing

	end if
end function

function navRecordsByPage(rs)
	nPage = CInt(Request.QueryString("Page"))
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


function status_row (strScheduledDate, strEnteredDate, strStatus, strReason, strAssignedTo, strEnteredBy)
	'header row'
	response.write "<table class=""status_row""><tr>" &_
		"<th class=""alignc"">Scheduled</th>" &_
		"<th>Entered</th>" &_
		"<th>Status</th>" &_
		"<th>Reason</th>" &_
		"<th>For</th>" &_
		"<th>Entered</th>" &_
		"</tr>"	

	response.write "<tr>" &_
		"<td>" & strScheduledDate & "</td>" &_
		"<td>" & strEnteredDate & "</td>" &_
		"<td>" & strStatus & "</td>" &_
		"<td>" & strReason & "</td>" &_
		"<td>" & strAssignedTo & "</td>" &_
		"<td>" & strEnteredBy & "</td>" &_
		"</tr></table>"		
end function

function memo_row (strActivityBlob)
	'memo [activity] row'
	response.write "<table style='width:100%'><tr>" &_
		"<td><strong>Activity&nbsp;:&nbsp;</strong><br>" & strActivityBlob & "</td>" &_
		"</tr></table>"	

end function

function details_row (strCusCode, strCustomerName, strJobReference, strJobDescript, strCustContact, strCustPhone, strJobSuper, strJobPhone, strApplPhone, strApplicantName, intApplicantId)

	response.write "<table class=""details_row""><tr>" &_
				"<td class=""details_firsttwo""><strong>Customer</strong>&nbsp;" &_
					strCusCode & "</td>" &_
				"<td class=""details_firsttwo""><strong>Job Order</strong>&nbsp;" & strJobReference & "</td>" &_
				"<td class=""details_last""><strong>Applicant</strong>&nbsp;" & intApplicantId & "</td>" &_
			"</tr></table><table class=""details_row_details""><tr>" &_
				"<td class=""details_firsttwo"">" & strCustomerName & "</td>" &_
				"<td class=""details_firsttwo"">" & strJobDescript & "</td>" &_
				"<td class=""details_last"">" & strApplicantName & "</td>" &_
			"</tr><tr>" &_
				"<td>" & strCustContact & " - " & FormatPhone(strCustPhone) & "</td>" &_
				"<td>" & strJobSuper & " - " & FormatPhone(strJobPhone) & "</td>" &_
				"<td>" & FormatPhone(strApplPhone) & "</td>" &_
			"</tr></table>"
end function

sub showActivityStream (rs)

dim manage_customer_lnk
manage_customer_form = "/include/system/tools/manage/customer/?"

resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"

' Position recordset to the correct page
	if not rs.eof then rs.AbsolutePage = nPage

	tableHeader = "<table class='placementTbl' style='width:100%'><tr><td>"

		dim mngCustomer

		
		do while not ( rs.Eof Or rs.AbsolutePage <> nPage )
				if rs.eof then
					rs.Close
					' Clean up
					' Do the no results HTML here
					response.write "No Items found."
					' Done
					Response.End 
				end if
				
			CommentBlob = rs("Comment")
			if len(CommentBlob) = 0 then
				CommentBlob = "{none}"
			end if

			phoneApplicant = rs("TelePhone")
			phoneCustomer = rs("Phone")
			phoneOrder = rs("WorkSite3")

			applicantid = rs("ApplicantID")
			lastnameFirst = rs("LastnameFirst")
			maintain_link = "<a href=""" & resourcelink & "who=" & applicantid & "&where=" & whichCompany & """>" &_
				lastnameFirst & "</a>"
			
			mngCustomer = rs("Customer")
			mngCustomerName = rs("CustomerName")

			maintain_customer = 	"<a href=""" & manage_customer_form & "cust=" & mngCustomer & "&where=" & whichCompany & "&action=review"">" &_
				mngCustomerName & "</a>"


			Response.write tableHeader
			response.write details_row(mngCustomer, maintain_customer, rs("Reference"), rs("JobDescription"), rs("Contact"), phoneCustomer, rs("JobSupervisor"), phoneOrder, phoneApplicant, maintain_link, applicantid) & "</td>"
			response.write "</td></tr><tr><td>"
			response.write memo_row(CommentBlob)
			response.write "</td></tr><tr><td>"
			response.write status_row(rs("AppDate"), rs("Entered"), rs("Disposition"), rs("ApptType"), rs("AssignedTo"), rs("EnteredBy"))
			response.write "</td></tr></table>"


			rs.MoveNext
		loop
		Response.write "</table>"
end sub


'build left side menu'
leftSideMenu = makeSideMenu ()

'some presentation related variables
dim nPage, nItemsPerPage, nPageCount

dim phoneApplicant, phoneCustomer, phoneOrder, contactOrder, contactCustomer
dim applicantid, lastnameFirst, maintain_link, resourcelink


'setup connection details'
if len(whichCompany & "") > 0 and len(include_what) > 0 then
	thisConnection = dsnLessTemps(getTempsDSN(whichCompany))
			
	'Set getDailySignIn_cmd = Server.CreateObject ("ADODB.Command")
	Set rsWhoseHere = Server.CreateObject ("ADODB.RecordSet")
	With rsWhoseHere
		'.ActiveConnection = thisConnection
		.CursorLocation = 3 ' adUseClient
		dim sqlCommandText
		select case prospecting
		case true
			sqlCommandText = "SELECT Appointments.AppDate, Appointments.Reference, Appointments.Customer, Appointments.Comment, " &_
				"Customers.Contact, Customers.Phone, Applicants.LastnameFirst, Applicants.Telephone, Orders.WorkSite3, Orders.JobSupervisor, " &_
				"Customers.CustomerName, Orders.JobDescription, Applicants.ApplicantID, Appointments.Entered, Appointments.EnteredBy, " &_
				"Appointments.AssignedTo, ApptTypes.ApptType, Dispositions.Disposition " &_
				"FROM Dispositions " &_
				"RIGHT JOIN (ApptTypes RIGHT JOIN (((Appointments LEFT JOIN Applicants ON Appointments.ApplicantId = Applicants.ApplicantID) " &_
				"RIGHT JOIN Customers ON Appointments.Customer = Customers.Customer) LEFT JOIN Orders ON Appointments.Reference = Orders.Reference) " &_
				"ON ApptTypes.ApptTypeCode = Appointments.ApptTypeCode) ON Dispositions.DispTypeCode = Appointments.DispTypeCode " &_
				include_what &_
				order_this_way
			
		case else
		
			sqlCommandText = "SELECT Appointments.AppDate, Appointments.Reference, Appointments.Customer, Appointments.Comment, " &_
				"Customers.Contact, Customers.Phone, Applicants.LastnameFirst, Applicants.Telephone, Orders.WorkSite3, Orders.JobSupervisor, " &_
				"Customers.CustomerName, Orders.JobDescription, Applicants.ApplicantID, Appointments.Entered, " &_
				"Appointments.EnteredBy, Dispositions.Disposition, ApptTypes.ApptType, Appointments.AssignedTo " &_
				"FROM Dispositions INNER JOIN (ApptTypes INNER JOIN (((Appointments " &_
				"LEFT JOIN Applicants ON Appointments.ApplicantId = Applicants.ApplicantID) " &_
				"LEFT JOIN Customers ON Appointments.Customer = Customers.Customer) " &_
				"LEFT JOIN Orders ON Appointments.Reference = Orders.Reference) " &_
				"ON ApptTypes.ApptTypeCode = Appointments.ApptTypeCode) " &_
				"ON Dispositions.DispTypeCode = Appointments.DispTypeCode " &_
				include_what &_
				order_this_way
		end select

		'.Prepared = true
		'break sqlCommandText
		'Response.End()
		.Open sqlCommandText, thisConnection
	End With
	'Set rsWhoseHere = getDailySignIn_cmd.Execute	

end if

%>
