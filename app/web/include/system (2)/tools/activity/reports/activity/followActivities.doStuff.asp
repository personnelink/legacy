<%
dim SimulateSite, qsSimSite
qsSimSite = Request.QueryString("simulate_site")
if len(qsSimSite) = 0 then
	SimulateSite = "" 'default
elseif user_level => userLevelPPlusStaff then
	if isNumeric(qsSimSite) then
		SimulateSite = getTempsCompCode(qsSimSite)
	else
		SimulateSite = replace(qsSimSite, "'", "''")
	end if
end if

dim whichCompany
if len(SimulateSite) = 0 then
	whichCompany = Request.QueryString("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = request.form("whichCompany")
		if len(whichCompany) = 0 then
			whichCompany = session("location")
		end if
	end if
else
	whichCompany = SimulateSite
end if

dim onlyactive
select case request.querystring("onlyactive")
	case 0
		onlyactive = false
	case 1
		onlyactive = true
	case else
		onlyactive = true
end select
	
dim SimulateCustomer
SimulateCustomer = Request.QueryString("simulate_customer")
if len(SimulateCustomer) = 0 then
	SimulateCustomer = "" 'default
elseif user_level => userLevelPPlusStaff then
	SimulateCustomer = Replace(SimulateCustomer, "'", "''")
end if


dim ThisSecurityLevel, qsSecurity
qsSecurity = Request.QueryString("simulate_security")
if len(SimulateCustomer) > 0 then
	if len(qsSecurity) = 0 then
		ThisSecurityLevel = userLevelSupervisor 'default
	else
		ThisSecurityLevel = cint(qsSecurity)
	end if
else
	ThisSecurityLevel = user_level
end if

dim thisCustomer
if len(SimulateCustomer) > 0 then
	thisCustomer = SimulateCustomer
elseif ThisSecurityLevel => userLevelPPlusStaff then
	thisCustomer = Request.QueryString("WhichCustomer")
	if len(thisCustomer) = 0 then
		thisCustomer = "@ALL" 'default
	end if
else
	thisCustomer = g_company_custcode.CustomerCode
end if
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

dim whichPage
whichPage = Trim(Replace(Request.QueryString("WhichPage"), ",", ""))
if len(whichPage) = 0 then
	whichPage = request.form("WhichPage")
	if len(whichPage) = 0 then
		whichPage = "1" 'default
	end if
end if

' floating and or sliding side menu
'
dim htmlDivMenu : htmlDivMenu = ""

'set default prespecting behavior to True if not specified as false in querystring
dim prospecting, qs_prospecting
if Request.QueryString("prospecting") = "0" then
	prospecting = false
else
	prospecting = true
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
const act_interviewed = 23

const act_start = 7
const act_stop = 23
const sys_start = 0
const sys_stop = 6

const act_id = 0
const description = 1
const selected = 2
const security = 3

dim include_these(23, 3)

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
include_these(act_interviewed, act_id) = 19

include_these(sys_unknown_1, description) = "Tracking-7"
include_these(sys_unknown_2, description) = "Tracking-6"
include_these(sys_placement, description) = "Placement"
include_these(sys_joborder, description) = "Job Order"
include_these(sys_customer, description) = "Customer"
include_these(sys_employee, description) = "Employee"
include_these(sys_applicant, description) = "Applicant"
include_these(act_interview, description) = "Interviews"
include_these(act_other, description) = "Other"
include_these(act_qa, description) = "Placements"
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
include_these(act_interviewed, description) = "Interviewed"

include_these(sys_unknown_1, security) = userLevelPPlusStaff
include_these(sys_unknown_2, security) = userLevelPPlusStaff
include_these(sys_placement, security) = userLevelPPlusStaff
include_these(sys_joborder, security) = userLevelPPlusStaff
include_these(sys_customer, security) = userLevelPPlusStaff
include_these(sys_employee, security) = userLevelPPlusStaff
include_these(sys_applicant, security) = userLevelPPlusStaff
include_these(act_interview, security) = userLevelSupervisor
include_these(act_other, security) = userLevelPPlusStaff
include_these(act_qa, security) = userLevelSupervisor
include_these(act_marketing, security) = userLevelPPlusStaff
include_these(act_arrivalcall, security) = userLevelSupervisor
include_these(act_sentresume, security) = userLevelSupervisor
include_these(act_unemployment, security) = userLevelPPlusStaff
include_these(act_csorder, security) = userLevelPPlusStaff
include_these(act_collection, security) = userLevelPPlusStaff
include_these(act_separation, security) = userLevelPPlusStaff
include_these(act_jocorrespond, security) = userLevelSupervisor
include_these(act_clientqa, security) = userLevelSupervisor
include_these(act_available, security) = userLevelSupervisor
include_these(act_rates, security) = userLevelSupervisor
include_these(act_workcomp, security) = userLevelPPlusStaff
include_these(act_accident, security) = userLevelSupervisor
include_these(act_interviewed, security) = userLevelSupervisor

'load collection from querystring, if none load from form
dim i, make_torf, qsBuffer
for i = sys_start to act_stop
	
	include_these(i, selected) = cbool(Request.form("activity_" & include_these(i, act_id)))
	
	if include_these(i, selected) = false then
		qsBuffer = Request.QueryString("activity_" & include_these(i, act_id))
		include_these(i, selected) = cbool(qsBuffer)
	end if

	' while we are at it build the sql selection criteria '
	dim include_what, init_yet, init_done
	init_yet = len(include_what)

	if ThisSecurityLevel => include_these(i, security) then 
		if include_these(i, selected) = true then
			include_what = include_what & "Appointments.ApptTypeCode=" & include_these(i, act_id) & " "
		end if

		if init_yet = 0 and len(include_what) > 0 then
			include_what = "WHERE (" & include_what & "OR "
			init_done = true
		elseif init_done = true and include_these(i, selected) = true then
			include_what = include_what & "OR "
		end if		
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

'add "Customer" and "Prospecting" WHERE condition to sql blob
if len(thisCustomer) > 0 and thisCustomer <> "@ALL" then
	dim strProspectingSwap

	if not prospecting then
		strProspectingSwap = " Customers.CustomerType<> 'P' AND"
	end if
	
	dim swapThis
	if len(thisOrder) > 0 and thisOrder <> "@ALL" then
		swapThis = "WHERE Appointments.Reference=" & thisOrder & " AND" & strProspectingSwap & " ("
	else
		swapThis = "WHERE Appointments.Customer='" & thisCustomer & "' AND" & strProspectingSwap & " ("
	end if
	
	if len(include_what) > 0 then
		include_what = Replace(include_what, "WHERE (", swapThis)
	else
		include_what = swapThis
	end if

elseif not prospecting then
    
    if instr(include_what, "WHERE") > 0 then
        include_what = replace(include_what, "WHERE ",  "WHERE Customers.CustomerType<> 'P' AND (") & ")"
    else
        include_what = "WHERE Customers.CustomerType<> 'P'"
    end if

end if	

dim showAssignedTo
showAssignedTo = Request.QueryString("assignedto")
if len(showAssignedTo) = 0 then
	showAssignedTo = request.form("asignedto")
end if

dim showEnteredBy
showEnteredBy = Request.QueryString("enteredby")
if len(showEnteredBy) = 0 then
	showEnteredBy = request.form("enteredby")
end if

if len(showAssignedTo) > 0 then
	showAssignedTo = Replace(showAssignedTo, "'", "")
	showAssignedTo = Ucase(Replace(showAssignedTo, """", ""))
	
	if len(include_what) > 0 then
		if instr(include_what, "WHERE ") > 0 then
			include_what = Replace(include_what, "WHERE ", "WHERE (EnteredBy='" & showAssignedTo & "') AND ")
		end if
	else
		include_what = "WHERE EnteredBy='" & showAssignedTo & "'"
	end if
end if

if len(showEnteredBy) > 0 then
	showEnteredBy = Replace(showEnteredBy, "'", "")
	showEnteredBy = Ucase(Replace(showEnteredBy, """", ""))
	
	if len(include_what) > 0 then
		if instr(include_what, "WHERE ") > 0 then
			include_what = Replace(include_what, "WHERE ", "WHERE (EnteredBy='" & showEnteredBy & "') AND ")
		end if
	else
		include_what = "WHERE EnteredBy='" & showEnteredBy & "'"
	end if
end if

dim the_query : the_query = Request.QueryString("query")

'makes the selection guide left menu
function makeSideMenu ()
	dim strTmp
	
	strTmp = "<div id=""more_filtering_options"">" &_
				"<div id=""show_what_activities""><p><strong>Show filtering for Activities to include in report</strong></p></div>" &_
				"<div id=""what_activities"" class=""navPageRecords hide"">" &_
					"<p id=""hide_what_activities""><strong>Hide filtering for Activities to include in report</strong></p>" &_
					"<div id=""nonsystem"">" &_
					"<ul  class=""what_activities"">" &_
					"<li><label onclick=""choose.all();""><input id=""chooseall"" class=""noBorder"" type=""checkbox"">Select All</label></li>"

	for i = act_start to act_stop
		if ThisSecurityLevel => include_these(i, security) then
			if include_these(i, selected) = true then
				strTmp = strTmp & "<li><label><input class=""noBorder"" type=""checkbox"" name=""activity_" &_
					include_these(i, act_id) & """ " &_
					"value=""1"" " & checkedText
			else
				strTmp = strTmp & "<li><label><input class=""noBorder"" type=""checkbox"" name=""activity_" &_
					include_these(i, act_id) & """ " &_
					"value=""1"" "
			end if
			
			strTmp = strTmp & " id=""activity_" & include_these(i, act_id) & """/>" & include_these(i, description) &_
				"</label></li>"
		end if
	next
	strTmp = strTmp & "" &_
			"<li><label onclick=""choose.none();""><input id=""choosenone"" class=""noBorder"" type=""checkbox"">Select None</label></li>"
	
	if ThisSecurityLevel => userLevelPPlusStaff then
		strTmp = strTmp &_	
			"</ul></div>" &_
			"<div id=""show_system_activities"">" &_
				"<p><strong>Show some additional system specific activities filters</strong></p></div>" &_
			"<div id=""system_specific_activities"" class=""hide"">" &_
			"<p id=""hide_system_activities""><strong>Hide additional system specific activities filters</strong></p>" &_
			"<div id=""system_activities""><ul class=""what_activities alignL"">"
			
				for i = sys_start to sys_stop
					if ThisSecurityLevel => include_these(i, security) then
						if include_these(i, selected) = true then
							strTmp = strTmp & "<li><label><input class=""noBorder"" type=""checkbox"" name=""activity_" &_
								include_these(i, act_id) & """ " &_
								"value=""1"" " & checkedText
						else
							strTmp = strTmp & "<li><label><input class=""noBorder"" type=""checkbox"" name=""activity_" &_
								include_these(i, act_id) & """ " &_
								"value=""1"" "
						end if
						
						strTmp = strTmp & " id=""activity_" & include_these(i, act_id) & """/>" & include_these(i, description) &_
							"</label></li>"
					end if
				next
			if ThisSecurityLevel => userLevelPPlusStaff then			
				if prospecting then
					strTmp = strTmp &_
						"</ul></div>" &_
						"<p style=""width:30em;""><strong>Include prospecting customer records?</strong></p><div>" &_
						"<p style=""width:40em;"">"&_		
						"<label><input class=""noBorder"" type=""radio"" name=""prospecting"" " &_
						" id=""prospecting_false"" value='1' checked=""checked"" onclick=""act_refresh();"" />Include Prospects" &_
						"</label>&nbsp;&nbsp;&nbsp;<label><input class=""noBorder"" type=""radio"" name=""prospecting"" " &_
						" id=""prospecting_true"" value='0' onclick=""act_refresh();"" />Exclude Prospects" &_
						"</label></p></div>" &_
						"</div>"
				else
					strTmp = strTmp &_
						"</ul></div>" &_
						"<p><strong>Prospecting?</strong></p>" &_
						"<ul id=""prospectingLst"" class=""what_activities"">"&_		
						"<li ><label><input class=""noBorder"" type=""radio"" name=""prospecting"" " &_
						" id=""prospecting_false"" value='1' onclick=""act_refresh();""/>Include Prospects" &_
						"</label></li><li><label><input class=""noBorder"" type=""radio"" name=""prospecting"" " &_
						" id=""prospecting_exclude"" value=""0"" checked=""checked"" onclick=""act_refresh();""/>Exclude Prospects" &_
						"</label></li></ul>" &_
						"</div>"
				end if
			end if
	end if
	
	''htmlDivMenu = replace(replace(strTmp, "</form>", ""), "what_activities", "floating_what_activities")
	htmlDivMenu = strTmp
	
	makeSideMenu = strTmp
end function

'deprecated with AJAX and customer lookup service
REM function navChooseCustomer (whichCompany)
	REM if ThisSecurityLevel => userLevelPPlusStaff then
		REM if len(whichCompany & "") > 0 then
			REM Select Case whichCompany
			REM Case "BUR"
				REM thisConnection = dsnLessTemps(BUR)
			REM Case "PER"
				REM thisConnection = dsnLessTemps(PER)
			REM Case "BOI"
				REM thisConnection = dsnLessTemps(BOI)
			REM Case "IDA"
				REM thisConnection = dsnLessTemps(IDA)
			REM End Select
			
			REM 'Set WhichCustomer = Server.CreateObject("ADODB.RecordSet")

			REM REM if not prospecting then
				REM REM sqlWhichCustomer = "" &_
					REM REM "SELECT DISTINCT Orders.Customer, Customers.CustomerName " &_
					REM REM "FROM ((Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) " &_
					REM REM "AND (Customers.Customer = Orders.Customer)) " &_
					REM REM "LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference) " &_
					REM REM "INNER JOIN Appointments ON Customers.Customer = Appointments.Customer " &_
					REM REM "WHERE (((Orders.JobStatus)<4) AND ((Customers.CustomerType)<>""P"" Or (Customers.CustomerType)<>""H"")) " &_
					REM REM "ORDER BY Customers.CustomerName;"
			REM REM else		
				REM REM sqlWhichCustomer = "" &_
					REM REM "SELECT DISTINCT Orders.Customer, Customers.CustomerName " &_
					REM REM "FROM ((Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) " &_
					REM REM "AND (Customers.Customer = Orders.Customer)) " &_
					REM REM "LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference) " &_
					REM REM "INNER JOIN Appointments ON Customers.Customer = Appointments.Customer " &_
					REM REM "WHERE ((Customers.CustomerType)<>""H"") " &_
					REM REM "ORDER BY Customers.CustomerName;"
			REM REM end if
			
			REM REM WhichCustomer.CursorLocation = 3 ' adUseClient
			REM REM WhichCustomer.Open sqlWhichCustomer, thisConnection
			
			REM dim CurrentCustomer, strDisplayText
			REM response.write "<div id=""topPageRecordsByCust"" class=""altNavPageRecords navPageRecords""><strong>Select Customer: </strong>" &_
				REM "<input name=""WhichCustomer"" id=""WhichCustomer"" type=""text"" value=""" & thisCustomer & """>" &_
				REM "<br><div id=""scrollCustomers"">"

				REM CurrentCustomer = "@ALL"

				REM if thisCustomer = CurrentCustomer then
					REM response.write "<span style=""color:red"">" & CurrentCustomer & "</span>"
				REM Else
					REM response.write CurrentCustomer
				REM end if
				REM response.write "</A>"
				
			REM REM do while not WhichCustomer.Eof
				REM REM CurrentCustomer = WhichCustomer("Customer")

				REM REM strDisplayText = Replace(WhichCustomer("CustomerName"), "&", "&amp;")
				REM REM strDisplayText = Replace(strDisplayText, " ", "&nbsp;")
				
				REM REM response.write "<A HREF=""#"" onclick=""arc('" & CurrentCustomer & "')"">"
				REM REM if thisCustomer = CurrentCustomer then
					REM REM response.write "<span style=""color:red"">" & strDisplayText & "</span>"
				REM REM Else
					REM REM response.write strDisplayText
				REM REM end if
				REM REM response.write "</A>"
				REM REM WhichCustomer.MoveNext
		
				REM REM linkNumber = linkNumber + 1
				REM REM if linkNumber > 10 and Not WhichCustomer.Eof then
					REM REM linkNumber = 0
					REM REM response.write "<br>"
				REM REM end if
			REM REM loop
			REM response.write "</div></div>"
			REM response.flush()
			
			REM REM WhichCustomer.Close
			REM REM Set WhichCustomer = Nothing

		REM end if
	REM end if
REM end function

'deprecated with AJAX and customer lookup service
REM function navChooseJobOrder (thisOrder)
	REM dim strDisplayText

	REM if len(whichCompany & "") > 0 then
		REM Select Case whichCompany
		REM Case "BUR"
			REM thisConnection = dsnLessTemps(BUR)
		REM Case "PER"
			REM thisConnection = dsnLessTemps(PER)
		REM Case "BOI"
			REM thisConnection = dsnLessTemps(BOI)
		REM End Select

			
		REM Set rsWhichOrder = Server.CreateObject("ADODB.RecordSet")
		REM sqlWhichOrder = "SELECT DISTINCT Orders.Customer, Orders.JobDescription, Orders.Reference FROM (Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) " &_
			REM "AND (Customers.Customer = Orders.Customer)) " &_
			REM "LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference WHERE Orders.Customer='" & thisCustomer & "' " &_
			REM "ORDER BY Orders.JobDescription;"
		
		REM rsWhichOrder.CursorLocation = 3 ' adUseClient
		REM rsWhichOrder.Open sqlWhichOrder, thisConnection
		
		REM dim CurrentOrder
		REM response.write "<div id=""topPageRecordsByOrder"" class=""altNavPageRecords navPageRecords""><strong>Job Orders: </strong>" &_
			 REM &_
			
			REM "<br><div id=""scrollCustomers"">"
			REM CurrentOrder = "@ALL"
			REM response.write "<A HREF=""#"" onclick=""act_refresh_order('" & CurrentOrder & "')"">&nbsp;"
			REM if thisOrder = CurrentOrder or thisOrder = "" then
				REM response.write "<span style=""color:red"">" & CurrentOrder & "</span>"
			REM Else
				REM response.write CurrentOrder
			REM end if
			REM response.write "&nbsp;</A>"
			
		REM do while not rsWhichOrder.Eof
			REM CurrentOrder = rsWhichOrder("Reference")
			REM strDisplayText = Replace(rsWhichOrder("JobDescription"), "&", "&amp;")
			REM strDisplayText = Replace(strDisplayText, " ", "&nbsp;")
			
			REM response.write "<A HREF=""#"" onclick=""act_refresh_order('" & CurrentOrder & "')"">&nbsp;"

			REM if trim(thisOrder) = trim(CurrentOrder) then
				REM response.write "<span style=""color:red"">" & strDisplayText & "</span>"
			REM Else
				REM response.write strDisplayText
			REM end if
			REM response.write "&nbsp;</A>"
			REM rsWhichOrder.MoveNext
	
			REM linkNumber = linkNumber + 1
			REM if linkNumber > 10 and Not rsWhichOrder.Eof then
				REM linkNumber = 0
				REM response.write "<br>"
			REM end if
		REM loop
		REM response.write("</div></div>")

		REM rsWhichOrder.Close
		REM Set rsWhichOrder = Nothing
		REM response.flush()
	REM end if
REM end function

function navRecordsByPage(rs)

	nPage = CInt(whichPage & "")
	nItemsPerPage = 50
	if not rs.eof then rs.PageSize = nItemsPerPage
	nPageCount = rs.PageCount

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

	

	rsQuery = request.serverVariables("QUERY_STRING")

	queryPageNumber = whichPage
	if queryPageNumber then
		rsQuery = Replace(rsQuery, "WhichPage=" & queryPageNumber & "&", "")
		rsQuery = Replace(rsQuery, "WhichPage=" & queryPageNumber, "")
		rsQuery = Replace(rsQuery, "WhichPage=", "")
	end if

	dim holdNavRecords : holdNavRecords = ""
	
	holdNavRecords = "<div id=""topPageRecords"" class=""navPageRecords"">" &_
			"<input name=""WhichPage"" id=""WhichPage"" type=""hidden"" value="""" />"

	holdNavRecords = holdNavRecords &_
	"<A HREF=""#"" onclick=""act_refresh_page('1');"">First</A>"

	For i = startPage to stopPage
		holdNavRecords = holdNavRecords &_
			"<A HREF=""#"" onclick=""act_refresh_page('" & i & "');"">&nbsp;"
		if i = nPage then
			holdNavRecords = holdNavRecords &_
				"<span style=""color:red"">" & i & "</span>"
		Else
			if (i = stopPage and i < nPageCount) or (i = startPage and i > 1) then
				holdNavRecords = holdNavRecords & "..."
			else
				holdNavRecords = holdNavRecords & i
			end if
		end if
			holdNavRecords = holdNavRecords &_
				"&nbsp;</A>"
	Next
	holdNavRecords = holdNavRecords &_
		"<A HREF=""#"" onclick=""act_refresh_page('" & nPageCount & "');"">Last</A>" &_
		"</div>"
	
	if len(holdNavRecords) > 0 then navRecordsByPage = holdNavRecords
end function

function reformatDateAndTime(p_strScheduledDate)
	dim p_minutes, p_hours
		
		p_hours = DatePart("h", p_strScheduledDate)
		if len(p_hours) = 1 then p_hours = "0" & p_hours

		p_minutes = DatePart("n", p_strScheduledDate)
		if len(p_minutes) = 1 then p_minutes = "0" & p_minutes


	reformatDateAndTime = "" &_
			DatePart("yyyy", p_strScheduledDate) & "." &_
			DatePart("m", p_strScheduledDate) & "." &_
			DatePart("d", p_strScheduledDate) & " " &_
			p_hours &  ":" & p_minutes
			
end function

function status_row (tableId, strScheduledDate, strEnteredDate, strStatus, strReason, intApptTypeCode, strAssignedTo, strEnteredBy, intDispTypeCode)
	dim htmlSetDisposition 
		htmlSetDisposition = mkDispControl(tableId, intDispTypeCode, strStatus)

	if len(strScheduledDate) > 0 then
		strScheduledDate = reformatDateAndTime(strScheduledDate)
	end if
	
	if len(strEnteredDate) > 0 then
		strEnteredDate = reformatDateAndTime(strEnteredDate)
	end if
	
	dim strResponse : strResponse = ""
	strResponse = strResponse &_
	"<div class="""" id=""full_status_row_" & tableId & """>" &_
	 "<table class=""status_row""><tr class=""nohover"">" &_
		"<th class=""scheduled alignl"">Scheduled</td>" &_
		"<td><div contenteditable=""true"">" & strScheduledDate & "</div></td>" &_
		"<th class=""entereddate"">Entered</td>" &_
		"<td>" & strEnteredDate & "</td>" &_
		"<th class=""status"">Status</td>" &_
		"<td>" & htmlSetDisposition & "</td>" &_
		"<th class=""reason"">Reason</td>" &_
		"<td>" & strReason & "</td>" &_
		"<th class=""assigned"">For</td>" &_
		"<td>" & strAssignedTo & "</td>" &_
		"<th class=""entered"">Entered</td>" &_
		"<td>" & strEnteredBy & "</td>" &_
		"</tr>"	&_
		"</table>" &_
		"<input type=""hidden"" id=""AppTypeCode" & tableId & """ value=""" & intApptTypeCode & """ /></div>"


	status_row = strResponse
end function

function memo_row (strActivityBlob)
	memo_row = "<table style='width:100%'><tr>" & "<td><div contenteditable=""true"">" & strActivityBlob & "</div></td>" & "</tr></table>"	
end function

function details_row (tableId, map_customer, map_worksite, map_applicant, strCusCode, strCustomerType, strCustomerClass, strCustomerName, strJobReference, strJobDescript, strCustContact, strCustPhone, strJobSuper, strJobPhone, strApplPhone, strApplicantName, intApplicantId)
	dim strClassification
	if len(strCustomerType) > 0 then
		select case lcase(strCustomerType)
		case "a"
			strClassification = "<i>, Active</i>"
		case "p"
			strClassification = "<i>, Prospect</i>"
		
		case "i"
			strClassification = "<i>, Inactive</i>"
		
		case "p"
			strClassification = "<i style=""color:red"">, High-Risk!</i>"
		case else
			strClassification = "<i>, " & strCustomerType & "</i>"
		end select
	end if
	
	if len(strCustomerClass) > 0 then
		strClassification = strClassification & "<i>, Class - " & strCustomerClass & "</i>"
	end if
		
	dim strResponse : strResponse = ""
	dim tableHeader : tableHeader = "<table id=""placement_table_" & tableId & """ class='generalTable' style='width:100%'><tr><td>"
	strResponse = strResponse & tableHeader &_
		"<div class="""" id=""full_detail_row_" & tableId & """>" &_
		"<table class=""details_row""><tr>" &_
			"<th class=""customer""><strong>Customer</strong>&nbsp;" & strCusCode & strClassification & "</th>" &_
			"<th class=""joborder""><strong>Job Order</strong>&nbsp;" & strJobReference & "</th>" &_
			"<th class=""applicant""><strong>Applicant</strong>&nbsp;" & intApplicantId & "</th>" &_
		"</tr></table><table class=""details_row_details""><tr>" &_
			"<td class=""customer"">" & map_customer &  "&nbsp;" & strCustomerName & "</td>" &_
			"<td class=""joborder"">" &  map_worksite & "&nbsp;" & strJobDescript & "</td>" &_
			"<td class=""applicant"">" &  map_applicant & "&nbsp;" & strApplicantName & "</td>" &_
		"</tr><tr>" &_
			"<td>" & strCustContact & " - " & FormatPhone(strCustPhone) & "</td>" &_
			"<td>" & strJobSuper & " - " & FormatPhone(strJobPhone) & "</td>" &_
			"<td>" & FormatPhone(strApplPhone) & "</td>" &_
		"</tr></table></div>"
			
	details_row = strResponse
	
end function

sub showActivityStream (rs)

dim map_customer 'CustomerAddress, CustomerCityline
dim new_customer_route
dim map_customer_route 'CustomerAddress, CustomerCityline
dim map_applicant 'ApplicantAddress, ApplicantCityline
dim new_applicant_route
dim map_applicant_route 'ApplicantAddress, ApplicantCityline
dim map_worksite 'WorksiteAddress, WorksiteCityline
dim new_worksite_route
dim map_worksite_route

dim manage_customer_lnk
manage_customer_form = "/include/system/tools/manage/customer/?"

resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"

' Position recordset to the correct page
	if not rs.eof then rs.AbsolutePage = nPage

	tableHeader = "<table class='placementTbl' style='width:100%'><tr><td>"

		dim mngCustomer
		dim tableId : tableId = 0

		
		do while not ( rs.Eof Or rs.AbsolutePage <> nPage )
				if rs.eof then
					rs.Close
					' Clean up
					' Do the no results HTML here
					response.write "No Items found."
					' Done
					Response.End 
				end if
			tableId = rs("Id")			
			CommentBlob = rs("Comment")
			if len(CommentBlob) = 0 then
				CommentBlob = "{none}"
			end if
			
			new_customer_route = filterAddress(replace(rs("CustomerAddress") & "+" & rs("CustomerCityline"), " ", "+"))
			if len(new_customer_route) > 1 then 
				map_customer = "<a href=""https://maps.google.com/maps?daddr=" & new_customer_route & """ target=""_blank""><span class=""mapit"">&nbsp;</span></a>"
			else
				map_customer = "<span class=""nomapofit"">&nbsp;</span>"
			end if
			if len(map_customer_route) > 0 then 
				if instr(map_customer_route, new_customer_route) = 0 then
					map_customer_route = map_customer_route & "+to:" & new_customer_route & ";"
				else
					'no action needed, route already in route string
				end if
			else
				map_customer_route = "daddr=<" & new_customer_route & ">"
			end if
			
			new_applicant_route = filterAddress(replace(rs("ApplicantsAddress") & "+" & rs("ApplicantsCityline"), " ", "+"))
			if len(new_applicant_route) > 1 then 
				map_applicant = "<a href=""https://maps.google.com/maps?daddr=" & new_applicant_route & """ target=""_blank""><span class=""mapit"">&nbsp;</span></a>"
			else
				map_applicant = "<span class=""nomapofit"">&nbsp;</span>"
			end if
			
			if len(map_applicant_route) > 0 then 
				if instr(map_applicant_route, new_applicant_route) = 0 then
					map_applicant_route = map_applicant_route & "+to:" & new_applicant_route & ""
				else
					'no action needed, route already in route string
				end if
			else
				map_applicant_route = "daddr=" & new_applicant_route & ""
			end if

			new_worksite_route = filterAddress(replace(rs("WorksiteAddress") & "+" & rs("WorksiteCityline"), " ", "+") )
			if len(new_worksite_route) > 1 then 
				map_worksite = "<a href=""https://maps.google.com/maps?daddr=" & new_worksite_route & """ target=""_blank""><span class=""mapit"">&nbsp;</span></a>"
			else
				map_worksite = "<span class=""nomapofit"">&nbsp;</span>"
			end if

			if len(map_worksite_route) > 0 then 
				if instr(map_worksite_route, new_worksite_route) = 0 then
					map_worksite_route = map_worksite_route & "+to:" & new_worksite_route & ""
				else
					'no action needed, route already in route string
				end if
			else
				map_worksite_route = "daddr=" & new_worksite_route & ""
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

				
			'Response.write tableHeader
			response.write details_row(tableId, map_customer, map_worksite, map_applicant, mngCustomer, rs("CustomerType"), rs("CustomerClass"), maintain_customer, rs("Reference"), rs("JobDescription"), rs("Contact"), phoneCustomer, rs("JobSupervisor"), phoneOrder, phoneApplicant, maintain_link, applicantid) & "</td>"
			response.write "</td></tr><tr><td>"
			response.write memo_row(CommentBlob)
			response.write "</td></tr></table><table id=""status_row_" & tableId & """ style=""width:100%""><tr><td>"
			response.write status_row(tableId, rs("AppDate"), rs("Entered"), rs("Disposition"), rs("ApptType"), rs("ApptTypeCode"), rs("AssignedTo"), rs("EnteredBy"), rs("DispTypeCode"))
			response.write "</td></tr></table>"


			rs.MoveNext

		loop
		Response.write "</table>"
		
		'print "Len Customer before: " & len(map_customer_route) & ", Len After: " & Len(filterAddress(map_customer_route))
		
		map_customer_route = "<a href=""https://maps.google.com/maps?" & filterAddress(map_customer_route) & """ target=""_blank""><span class=""mapit"">&nbsp;</span>Map Customers</a>"
		map_applicant_route = "<a href=""https://maps.google.com/maps?" & filterAddress(map_applicant_route) & """ target=""_blank""><span class=""mapit"">&nbsp</span>Map Applicants</a>"
		map_worksite_route = "<a href=""https://maps.google.com/maps?" & filterAddress(map_worksite_route) & """ target=""_blank""><span class=""mapit"">&nbsp</span>Map Worksites</a>"
		
		response.write "<table class='placementTbl' style='width:100%'><tr><th>" & map_customer_route & "</th><th>" & map_worksite_route & "</th><th>" & map_applicant_route & "</th></table>"
			
end sub

function filterAddress(address)
	dim address_buffer
	
	if len(address) > 0 then
		address_buffer = replace(address, "+++", "+")
		do until instr(address_buffer, "++") = 0
			address_buffer = replace(address_buffer, "++", "+")
		loop
	else
		address_buffer = ""'
	end if
	
	filterAddress = address_buffer
end function

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
			sqlCommandText = "SELECT Appointments.Id, Appointments.AppDate, Appointments.Reference, Appointments.Customer, Appointments.Comment, " &_
				"Customers.Address AS CustomerAddress, Customers.Cityline AS CustomerCityline, Applicants.Address AS ApplicantsAddress, " &_
				"Applicants.City, Applicants.State, Applicants.Zip AS ApplicantsCityline, Orders.WorkSite1 AS WorksiteAddress, Orders.Worksite2 as WorksiteCityline, " &_
				"Customers.Contact, Customers.Phone, Applicants.LastnameFirst, Applicants.Telephone, Orders.WorkSite3, Orders.JobSupervisor, Appointments.ApptTypeCode, " &_
				"Customers.CustomerName, Orders.JobDescription, Applicants.ApplicantID, Appointments.Entered, Appointments.EnteredBy, Appointments.DispTypeCode, " &_
				"Appointments.AssignedTo, ApptTypes.ApptType, Dispositions.Disposition, Customers.CustomerType, Customers.TermsCode AS CustomerClass " &_
				"FROM Dispositions " &_
				"RIGHT JOIN (ApptTypes RIGHT JOIN (((Appointments LEFT JOIN Applicants ON Appointments.ApplicantId = Applicants.ApplicantID) " &_
				"LEFT JOIN Customers ON Appointments.Customer = Customers.Customer) LEFT JOIN Orders ON Appointments.Reference = Orders.Reference) " &_
				"ON ApptTypes.ApptTypeCode = Appointments.ApptTypeCode) ON Dispositions.DispTypeCode = Appointments.DispTypeCode " &_
				include_what & " " &_
				order_this_way

			' salvaged below query, with the flopped customer relationship, because it could be useful later as what it ends up doing is returning
			' only those applicants that were interviewed and that were placed with a customer
			'
			' sqlCommandText = "SELECT Appointments.Id, Appointments.AppDate, Appointments.Reference, Appointments.Customer, Appointments.Comment, " &_
				' "Customers.Address AS CustomerAddress, Customers.Cityline AS CustomerCityline, Applicants.Address AS ApplicantsAddress, " &_
				' "Applicants.City & ""+"" & Applicants.State & ""+"" & Applicants.Zip AS ApplicantsCityline, Orders.WorkSite1 AS WorksiteAddress, Orders.Worksite2 as WorksiteCityline, " &_
				' "Customers.Contact, Customers.Phone, Applicants.LastnameFirst, Applicants.Telephone, Orders.WorkSite3, Orders.JobSupervisor, Appointments.ApptTypeCode, " &_
				' "Customers.CustomerName, Orders.JobDescription, Applicants.ApplicantID, Appointments.Entered, Appointments.EnteredBy, Appointments.DispTypeCode, " &_
				' "Appointments.AssignedTo, ApptTypes.ApptType, Dispositions.Disposition, Customers.CustomerType, Customers.TermsCode AS CustomerClass " &_
				' "FROM Dispositions " &_
				' "RIGHT JOIN (ApptTypes RIGHT JOIN (((Appointments LEFT JOIN Applicants ON Appointments.ApplicantId = Applicants.ApplicantID) " &_
				' "RIGHT JOIN Customers ON Appointments.Customer = Customers.Customer) LEFT JOIN Orders ON Appointments.Reference = Orders.Reference) " &_
				' "ON ApptTypes.ApptTypeCode = Appointments.ApptTypeCode) ON Dispositions.DispTypeCode = Appointments.DispTypeCode " &_
				' include_what & " " &_
				' order_this_way

				
		case else
			sqlCommandText = "SELECT Appointments.Id, Appointments.AppDate, Appointments.Reference, Appointments.Customer, Appointments.Comment, " &_
				"Customers.Address AS CustomerAddress, Customers.Cityline AS CustomerCityline, Applicants.Address AS ApplicantsAddress, " &_
				"Applicants.City, Applicants.State, Applicants.Zip AS ApplicantsCityline, Orders.WorkSite1 AS WorksiteAddress, Orders.Worksite2 as WorksiteCityline, " &_
				"Customers.Contact, Customers.Phone, Applicants.LastnameFirst, Applicants.Telephone, Orders.WorkSite3, Orders.JobSupervisor, " &_
				"Customers.CustomerName, Orders.JobDescription, Applicants.ApplicantID, Appointments.Entered, Appointments.DispTypeCode, Appointments.ApptTypeCode, " &_
				"Appointments.EnteredBy, Dispositions.Disposition, ApptTypes.ApptType, Appointments.AssignedTo, Customers.CustomerType, Customers.TermsCode AS CustomerClass " &_
				"FROM Dispositions INNER JOIN (ApptTypes INNER JOIN (((Appointments " &_
				"LEFT JOIN Applicants ON Appointments.ApplicantId = Applicants.ApplicantID) " &_
				"LEFT JOIN Customers ON Appointments.Customer = Customers.Customer) " &_
				"LEFT JOIN Orders ON Appointments.Reference = Orders.Reference) " &_
				"ON ApptTypes.ApptTypeCode = Appointments.ApptTypeCode) " &_
				"ON Dispositions.DispTypeCode = Appointments.DispTypeCode " &_
				include_what & " " &_
				order_this_way

		end select
		
		'print sqlCommandText
		
		'.Prepared = true
		'break sqlCommandText
		'Response.End()
		.Open sqlCommandText, thisConnection
	End With
	'Set rsWhoseHere = getDailySignIn_cmd.Execute	

end if


function mkDispControl(m_id, m_DispTypeCode, m_Disposition)
	if m_DispTypeCode => 0 then
		dim ChangeDisposition, CurrentDisposition(4)
			select case m_DispTypeCode
				case 0
					CurrentDisposition(0) = " selected=""selected"""
				case 1
					CurrentDisposition(1) = " selected=""selected"""
				case 2
					CurrentDisposition(2) = " selected=""selected"""
				case 3
					CurrentDisposition(3) = " selected=""selected"""
				case 4
					CurrentDisposition(4) = " selected=""selected"""
			end select
			
			ChangeDisposition = "" &_
				"<span id=""disposition" & m_id & """ class=""disposition"" onclick=""dispositions.show('" & m_id & "')"">" &_
					m_Disposition &_
				"<span class=""idle"" id=""loader" & m_id & """></span></span>" &_
				"<span id=""setdisposition" & m_id & """ class=""hide"">" &_
					"<select class=""setdispo"" name=""setdisp" & m_id & """ id=""setdisp" & m_id & """ onblur=""dispositions.hide('" & m_id & "')"" onchange=""dispositions.set('" & m_id & "')"">" &_
						"<option value=""0""" & CurrentDisposition(0) & ">Active</option>" &_
						"<option value=""1""" & CurrentDisposition(1) & ">We Re-scheduled</option>" &_
						"<option value=""2""" & CurrentDisposition(2) & ">Applicant Re-scheduled</option>" &_
						"<option value=""3""" & CurrentDisposition(3) & ">Took Place</option>" &_
						"<option value=""4""" & CurrentDisposition(4) & ">No Show</option>" &_
					"</select>" &_
				"</span>"
	else
		ChangeDisposition = "N/A"
	end if
	
	mkDispControl = ChangeDisposition

end function


%>
