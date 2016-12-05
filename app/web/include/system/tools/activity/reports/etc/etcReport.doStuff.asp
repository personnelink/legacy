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
if len(thisCustomer) = 0 then
	thisCustomer = "@ALL" 'default
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

'init checked text string blob
const checkedText = "checked=""checked"""

'init date selection'
dim etc_when, etc_all, etc_past, etc_future, etc_custom, show_date_form

show_date_form = "hide" 'default flag for date entry form
select case request.querystring("etc_when")
case "all"
	etc_all= " " & checkedText
	etc_when = "all"
case "past"
	etc_past = " " & checkedText
	etc_when = "past"
case "future"
	etc_future = " " & checkedText
	etc_when = "future"
case "custom"
	etc_custom = " " & checkedText
	etc_when = "custom"
	show_date_form = "show"
case else
	select case request.form("etc_when")
	case "all"
		etc_all= " " & checkedText
		etc_when = "all"
	case "past"
		etc_past = " " & checkedText
		etc_when = "past"
	case "future"
		etc_future = " " & checkedText
		etc_when = "future"
	case "custom"
		etc_custom = " " & checkedText
		etc_when = "custom"
		show_date_form = "show"
	case else
		etc_all= " " & checkedText
		etc_when = "all"
	end select
end select

dim order_this_way
if include_what <> "WHERE " then
	select case etc_when
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
		'include_what = left(include_what, init_done - 3) 'remove trailing "AND "'
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

			sqlWhichCustomer = "SELECT DISTINCT Orders.Customer, Customers.CustomerName " &_
				"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
				"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
				"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
				"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
				"WHERE  (Placements.PlacementStatus=3 AND Placements.NeedFinalTime='TRUE' OR Placements.PlacementStatus=0) " &_
				" ORDER BY Orders.Customer"

		WhichCustomer.CursorLocation = 3 ' adUseClient
		WhichCustomer.Open sqlWhichCustomer, thisConnection
		
		dim CurrentCustomer, strDisplayText
		response.write "<div id=""topPageRecordsByCust"" class=""altNavPageRecords navPageRecords""><strong>Select Customer: </strong>" &_
			"<input name=""WhichCustomer"" id=""WhichCustomer"" type=""hidden"" value=""" & thisCustomer & """>" &_
			"<input name=""enteredby"" id=""enteredby"" type=""hidden"" value=""" & showEnteredBy & """>" &_
			"<input name=""assignedto"" id=""assignedto"" type=""hidden"" value=""" & showAssignedTo & """>" &_
			
			"<br><div id=""scrollCustomers"">"

			CurrentCustomer = "@ALL"
			response.write "<A HREF=""#"" onclick=""etc_refresh_customer('" & CurrentCustomer & "')"">&nbsp;"
			if thisCustomer = CurrentCustomer then
				response.write "<span style=""color:red"">" & CurrentCustomer & "</span>"
			Else
				response.write CurrentCustomer
			end if
			response.write "&nbsp;</A>"
			
		do while not WhichCustomer.Eof
			on error resume next
			CurrentCustomer = WhichCustomer("Customer")
			strDisplayText = Replace(WhichCustomer("CustomerName"), "&", "&amp;")
			strDisplayText = Replace(strDisplayText, " ", "&nbsp;")
			
			response.write "<A HREF=""#"" onclick=""etc_refresh_customer('" & CurrentCustomer & "')"">&nbsp;"
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
		on error goto 0
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
		sqlWhichOrder = "SELECT Orders.Reference, Orders.JobDescription " &_
				"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
				"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
				"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
				"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
				"WHERE  (Placements.PlacementStatus=3 AND Placements.NeedFinalTime='TRUE' OR Placements.PlacementStatus=0) " &_
				"AND (Orders.Customer='" & thisCustomer & "') " &_
				"ORDER BY Orders.Customer, Applicants.LastnameFirst"
		
		rsWhichOrder.CursorLocation = 3 ' adUseClient
		rsWhichOrder.Open sqlWhichOrder, thisConnection
		
		dim CurrentOrder
		response.write "<div id=""topPageRecordsByOrder"" class=""altNavPageRecords navPageRecords""><strong>Job Orders: </strong>" &_
			"<input name=""WhichOrder"" id=""WhichOrder"" type=""hidden"" value=""" & thisOrder & """>" &_
			
			"<br><div id=""scrollCustomers"">"
			CurrentOrder = "@ALL"
			response.write "<A HREF=""#"" onclick=""etc_refresh_order('" & CurrentOrder & "')"">&nbsp;"
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
			
			response.write "<A HREF=""#"" onclick=""etc_refresh_order('" & CurrentOrder & "')"">&nbsp;"

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

	nPage = CInt(whichPage & "")
	nItemsPerPage = 900
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
	"<A HREF=""#"" onclick=""etc_refresh_page('1');"">First</A>"

	For i = startPage to stopPage
		holdNavRecords = holdNavRecords &_
			"<A HREF=""#"" onclick=""etc_refresh_page('" & i & "');"">&nbsp;"
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
		"<A HREF=""#"" onclick=""etc_refresh_page('" & nPageCount & "');"">Last</A>" &_
		"</div>"
	
	if len(holdNavRecords) > 0 then navRecordsByPage = holdNavRecords
end function

'build left side menu'
'leftSideMenu = makeSideMenu ()

'some presentation related variables
dim nPage, nItemsPerPage, nPageCount

dim phoneApplicant, phoneCustomer, phoneOrder, contactOrder, contactCustomer
dim applicantid, lastnameFirst, maintain_link, resourcelink

'setup connection details'
if len(whichCompany & "") > 0 then

	thisConnection = dsnLessTemps(getTempsDSN(whichCompany))
			
	'Set getDailySignIn_cmd = Server.CreateObject ("ADODB.Command")
	Set rsWhoseHere = Server.CreateObject ("ADODB.RecordSet")
	With rsWhoseHere
		'.ActiveConnection = thisConnection
		.CursorLocation = 3 ' adUseClient
		dim sqlCommandText
		sqlCommandText = "SELECT Orders.Customer, Orders.Reference, Placements.EmployeeNumber, Placements.StartDate, " &_
				"Placements.PStopDate, Customers.CustomerName, Applicants.LastnameFirst, Orders.JobNumber, " &_
				"Placements.WorkCode, Placements.RegPayRate, Placements.RegBillRate, Placements.PlacementStatus, " &_
				"Placements.PlacementID, Placements.NeedFinalTime, WorkCodes.Description " &_
				"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
				"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
				"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
				"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
				"WHERE  (Placements.PlacementStatus=3 AND Placements.NeedFinalTime='TRUE' OR Placements.PlacementStatus=0) " &_
				" ORDER BY Orders.Customer, Applicants.LastnameFirst"
				
				'include_what &_
				'order_this_way

		'.Prepared = true
		'break sqlCommandText
		'Response.End()
		.Open sqlCommandText, thisConnection
	End With
end if

function main_header (CustomerCode, CustomerName)
	dim strHeader : strHeader = ""
	strHeader = strHeader &_
		"<div class=""groupheader"">" &_
			"<span class=""CustomerCode"">" & CustomerCode & "</span>" &_
			"<span class=""CustomerName"">" & CustomerName & "</span>" &_
		"</div>"
		
	main_header = strHeader
end function

function group_header ()
	dim strResponse : strResponse = ""

	strResponse = strResponse &_
			"<table class=""etcdetails"">" &_
			"<tr class=""etcHeader"">" &_
				"<th class=""lastnamefirst"">&nbsp;</th>" &_
				"<th class=""EmployeeNumber"">Empl#</th>" &_
				"<th class=""JobNumber"">JO#/<br />Ref#</th>" &_
				"<th class=""PlacementStatus"">S</th>" &_
				"<th class=""WCDescription"">Description</th>" &_
				"<th class=""StartDate"">Started</th>" &_
				"<th class=""PStopDate"">Ending</th>" &_
				"<th class=""WorkCode"">Work Code</th>" &_
				"<th class=""RegPayRate"">Pay</th>" &_
				"<th class=""RegBillRate"">Bill</th>" &_
			"</tr>"

			'"<th class=""Reference"">Ref#</th>" &_

	group_header = strResponse
end function
function group_details (PlacementId, lastnamefirst, EmployeeNumber, JobNumber, Reference, PlacementStatus, WCDescription, StartDate, PStopDate, WorkCode, RegPayRate, RegBillRate)
	dim objChangePlacement: objChangePlacement = ""
		if PlacementStatus = "3" then
		 	 objChangePlacement = objChangePlacement &_
				"<span class=""OpenPlacement"" " &_
					"id=""Placement" & PlacementId & """ " &_
					"onclick=""placement.open('" & PlacementId & "', '" & whichCompany & "')"">" &_
				"</span>"
		else
		 	 objChangePlacement = objChangePlacement &_
				"<span class=""ClosePlacement"" " &_
					"id=""Placement" & PlacementId & """ " &_
					"onclick=""placement.close('" & PlacementId & "', '" & whichCompany & "')"">" &_
				"</span>"
		end if
			
			
				
	dim strResponse : strResponse = ""
		strResponse = strResponse &_
			"<tr>" &_
				"<td class=""lastnamefirst""><div>" & objChangePlacement & lastnamefirst & "</div></td>" &_
				"<td class=""EmployeeNumber"">" & EmployeeNumber & "</td>" &_
				"<td class=""JobNumber"">" & JobNumber & "/" & Reference & "</td>" &_
				"<td class=""WCDescription""><div>" & WCDescription & "</div></td>" &_
				"<td class=""StartDate"">" & StartDate & "</td>" &_
				"<td class=""PStopDate"">" & PStopDate & "</td>" &_
				"<td class=""WorkCode"">" & WorkCode & "</td>" &_
				"<td class=""RegPayRate alignR"">$" & RegPayRate & "</td>" &_
				"<td class=""RegBillRate alignR"">$" & RegBillRate & "</td>" &_
				"<td class=""PlacementStatus alignR""><input id=""chkbox_" & PlacementId & """ type=""checkbox"" value="""" data-customer=""" & CustomerCode &  """ onclick=""timecard.received('" & PlacementId & "', '" & whichCompany & "');"" /></td>" &_
			"</tr>"
			'"<td class=""Reference"">"  & "</td>" &_
	group_details = strResponse
end function

function group_details_received (PlacementId, lastnamefirst, EmployeeNumber, JobNumber, Reference, PlacementStatus, WCDescription, StartDate, PStopDate, WorkCode, RegPayRate, RegBillRate)
	dim objChangePlacement: objChangePlacement = ""
		if PlacementStatus = "3" then
		 	 objChangePlacement = objChangePlacement &_
				"<span class=""OpenPlacement"" " &_
					"id=""Placement" & PlacementId & """ " &_
					"onclick=""placement.open('" & PlacementId & "', '" & whichCompany & "')"">" &_
				"</span>"
		else
		 	 objChangePlacement = objChangePlacement &_
				"<span class=""ClosePlacement"" " &_
					"id=""Placement" & PlacementId & """ " &_
					"onclick=""placement.close('" & PlacementId & "', '" & whichCompany & "')"">" &_
				"</span>"
		end if
			
			
				
	dim strResponse : strResponse = ""
		strResponse = strResponse &_
			"<tr style=""font-color:red;"">" &_
				"<td class=""lastnamefirst""><div>" & objChangePlacement & lastnamefirst & "</div></td>" &_
				"<td class=""EmployeeNumber"">" & EmployeeNumber & "</td>" &_
				"<td class=""JobNumber"">" & JobNumber & "/" & Reference & "</td>" &_
				"<td class=""WCDescription""><div>" & WCDescription & "</div></td>" &_
				"<td class=""StartDate"">" & StartDate & "</td>" &_
				"<td class=""PStopDate"">" & PStopDate & "</td>" &_
				"<td class=""WorkCode"">" & WorkCode & "</td>" &_
				"<td class=""RegPayRate alignR"">$" & RegPayRate & "</td>" &_
				"<td class=""RegBillRate alignR"">$" & RegBillRate & "</td>" &_
				"<td class=""PlacementStatus alignR""><input type=""checkbox"" value="""& time_received & """ checked=""checked"" onclick=""timecard.received('" & PlacementId & "', '" & whichCompany & "');"" /></td>" &_
			"</tr>"
			'"<td class=""Reference"">"  & "</td>" &_
	group_details_received = strResponse
end function




function group_footer ()
	group_footer = "</table>"
end function


dim rs_received, cmd_received
set cmd_received = server.createObject("adodb.command")
cmd_received.ActiveConnection = MySql

sub showActivityStream (rs)

dim manage_customer_lnk
manage_customer_form = "/include/system/tools/manage/customer/?"

resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"

' Position recordset to the correct page
	if not rs.eof then rs.AbsolutePage = nPage

	'tableHeader = "<table class='etcTable' style='width:100%'><tr><td>"

		dim previousCode : previousCode = ""
		dim chkSpace : chkSpace = 0
		dim time_received
		
		dim CustomerCode : CustomerCode = "" 'Customer
		dim CustomerName : CustomerName = "" 'CustomerName
		dim Reference : Reference = 0
		dim EmployeeNumber : EmployeeNumber = ""
		dim StartDate : StartDate = "" 'Placement.StartDate
		dim PStopDate : PStopDate = "" 'Placements.PStopDate
		dim PlacementId : PlacementId = 0
		dim LastnameFirst : LastnameFirst = "" 'Applicants..LastnameFirst
		dim JobNumber : jobnumber = 0 'Orders.JobNumber
		dim workcode : workcode = "" 'WorkCode
		dim RegPayRate : RegPayRate = ""
		dim RegBillRate : RegBillRate = ""
		dim PlacementStatus : PlacementStatus = ""
		dim NeedFinalTime : NeedFinalTime = ""
		dim WCDescription : WCDescription = "" 'WorkCodes.Description 
		
		do while not ( rs.Eof Or rs.AbsolutePage <> nPage )
			if rs.eof then
				rs.Close
				' Clean up
				' Do the no results HTML here
				response.write "No Items found."
				' Done
				Response.End 
			end if
			
			CustomerCode = rs("Customer") 'Customer
			CustomerName = rs("CustomerName") 'CustomerName
			Reference = rs("Reference")
			EmployeeNumber = rs("EmployeeNumber") 
			StartDate = rs("StartDate") 'Placement.StartDate
			PStopDate = rs("PStopDate") 'Placements.PStopDate
			PlacementId = rs("PlacementID")
			LastnameFirst = rs("LastnameFirst") 'Applicants..LastnameFirst
			JobNumber = rs("JobNumber") 'Orders.JobNumber
			WorkCode = rs("WorkCode") 'WorkCode
			RegPayRate = TwoDecimals(rs("RegPayRate"))
			RegBillRate = TwoDecimals(rs("RegBillRate"))
			PlacementStatus = rs("PlacementStatus")
			NeedFinalTime = rs("NeedFinalTime")
			WCDescription = rs("Description") 'WorkCodes.Description 
			
			chkSpace = instr(PStopDate, " ")
			if chkSpace > 0 then
				PStopDate = left(PStopDate, chkSpace - 1)
			end if
			
			if previousCode <> CustomerCode then
				if previousCode <> "" then
					response.write group_footer
				end if
				
				response.write main_header(CustomerCode, CustomerName) 'classes: CustomerCode, CustomerName
			
				response.write group_header
				
				previousCode = CustomerCode
			end if


			time_received = check_if_received(placementid)
			if time_received > 0 then
				response.write group_details_received (PlacementId, LastnameFirst, EmployeeNumber, JobNumber, Reference, PlacementStatus, WCDescription, StartDate, PStopDate, WorkCode, RegPayRate, RegBillRate)

			else
				response.write group_details(PlacementId, LastnameFirst, EmployeeNumber, JobNumber, Reference, PlacementStatus, WCDescription, StartDate, PStopDate, WorkCode, RegPayRate, RegBillRate)
			end if
			
			rs.MoveNext
		loop
		
		Response.write group_footer
end sub

function check_if_received(placementid)

	on error resume next

	cmd_received.CommandText = "" &_
		"SELECT exp_tot FROM time_summary WHERE received='1' AND createdby='P' AND placementid='" & placementid & "';"
	
	set rs_received = cmd_received.execute()
	
	if not rs_received.eof then
		
		check_if_received = cdbl(rs_received("exp_tot"))
		
	else
		check_if_received = 0
	end if

	on error goto 0
	
end function


function getWeekending(today, customer)
	
	'print "cust: " & customer
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		
		.CommandText = "" &_
			"Select weekends FROM tbl_companies WHERE INSTR(Customer, '" & customer & "') > 0;"
	end with
	
	dim rs
	set rs = cmd.Execute()

	dim weekEndsOn

	if not rs.eof then 
		weekEndsOn = cint(rs("weekends"))
	else
		weekEndsOn = 1
	end if
	
	today = Weekday(Date)
	
	'print "today: " & today
	'print "week ends on: " & WeekEndsOn
	
	if today > WeekEndsOn then

		getWeekending = DateAdd("d", 7 - (today - WeekEndsOn), Date)
		
	elseif today < WeekEndsOn then

		getWeekending = DateAdd("d", (WeekEndsOn - today), Date)
		
	elseif today = WeekEndsOn then
		getWeekending = Date
	else
		getWeekending = DateAdd("d", 7 - (WeekEndsOn - today), Date)
	end if
	
end function

%>
