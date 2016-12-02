<%Option Explicit%>
<%
session("required_user_level") = 4 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_headless_user_service.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/tools/timecards/group/timecard.classes.asp' -->

<!-- #include file='doLookUpUser.asp' -->
<!-- #include file='doGetCostCenters.asp' -->
<!-- #include file='doGetTimeclock.asp' -->
<!-- #include file='doSendEmailNotice.asp' -->
<!-- #include file='doSyncPlacements.asp' -->

<%
'-----------------------------------------------------------------
' parameters:
'	do     = view
'	id     = customer code
'	site   = temps site id
'	status = job order status
'
'-----------------------------------------------------------------
'flag to toggle using querystring or form post data
'
'
' * 2014.4.10 
'		- Added attribute in detail and summary tables to track what type of system created entry, '		 human or machine and address 16 hour max time before missed 'clock-out'
'			* added attribute 'createdby' used to track if records were created by time clock (T) '		 		or entered by person (H), and leaves room for additional types later if needed. This '			   used for "missed swipe" noticed to employees / supervisors
'
'
' * 2014.3.28 - Corrected issue with site id not being set from card correctly for sites outside PER
'

dim use_qs
if request.querystring("use_qs") = "1" then
	use_qs = true
else
	use_qs = false
end if

dim applicantid
applicantid = getParameter("applicantid")

dim customerid, customer
customerid = getParameter("customer")
customer = customerid

	
dim siteid
siteid = g_strSite

if vartype(siteid) = 0 then
	siteid = getParameter("site")
end if

dim tempsCode
if isnumeric(siteid) then
	tempsCode = getTempsCompCode(siteid)
elseif len(siteid) = 3 then
	tempsCode = siteid
end if

dim placementid
placementid = getParameter("id")

'retrieve site id and make sure it's numeric
dim g_strSite
dim qsSite : qsSite = getParameter("site")
	if not isnumeric(qsSite) then
		g_strSite = getSiteNumber(qsSite)
	else
		g_strSite = cdbl(qsSite)
	end if

dim creatorid
	creatorid = lookupCreatorId (applicantid, getTempsSiteId(siteid))

dim which_method
which_method = getParameter("do")
select case which_method
	case "getuserdetail"
		getUserDetail
	case "getcostcenters"
		doGetCostCenters
	case "gettimeclock"
		doGetTimeclock
	case "doclockin"
		doClockIn
	case "doclockout"
		doClockOut
	case "syncplacements"
		doSyncPlacements
	case else
		break "[here]: " & which_method
end select

public function doView ()
	'what job order status?
	dim intJobStatus
	Select Case request.querystring("status")
		Case "0"
			intJobStatus = "0"

		Case "1"
			intJobStatus = "1"

		Case "2"
			intJobStatus = "2"

		Case "3"
			intJobStatus = "3"

		Case "4"
			intJobStatus = "4"

		Case Else
			exit function

	End Select

	dim Customers
	set Customers = new cCustomers
	' Customers.ItemsPerPage = 20
	' Customers.Page = CInt(Request.QueryString("Page"))
	Customers.GetAllCustomers(intJobStatus)

	dim LightOrDark : LightOrDark = "light" 'toggle light or dark row shadding

	for each Customer in Customers.Customer.Items

	select case EvenOrOdd
		case "dark"
			LightOrDark = "light"
		case else
			LightOrDark = "dark"
	end select
	%>

	<div class="customer <%=LightOrDark%>" onclick="orders.get('')">
		<span class="custcode"><%=Customer.Customer%></span>
		<span class="custname"><%=Customer.CustomerName%></span>
		<div id="<%=Customer.Customer & intJobStatus%>" class="orders hide"></div>
	</div>
	
	<%

	next
end function

public function updateTimeDetail()
	dim inputid     : inputid = getParameter("id")
	dim parameters  : parameters  = split(inputid, "_")
	dim column      : column      = parameters(0)
	dim placementid : placementid = parameters(1)
	dim summaryid   : summaryid   = parameters(2)
	dim detailid    : detailid    = parameters(3)
	dim dayid       : dayid       = parameters(4)
	dim siteid      : siteid      = getTempsDSN(g_strSite)
	dim value       : value       = cdbl(getParameter("t"))
	
	dim oldDayId
	if len(dayid) > 1 then
		oldDayId = left(dayid ,1)
		dayid    = right(dayid, 1)
	else
		oldDayId = dayid
	end if
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = MySql
	
	dim newSum
	dim sqlNewSum
		sqlNewSum = "" &_
			"SELECT IFNULL(SUM(timetotal),0) AS totalhours " &_
			"FROM time_detail " &_
			"WHERE (workday=" & dayid & ") AND (summaryid=" & summaryid & ")"
			
	select case column
	case "in", "out" 
		dim paramTimeDiff
		value = (value*60)*60
		
		select case column
		case "in"
			paramTimeDiff = "timeout, SEC_TO_TIME(" & value & ")"
		case "out"
			paramTimeDiff = "SEC_TO_TIME(" & value & "), timein"
		end select
				
		with cmd
			' .CommandText = "" &_
				' "UPDATE time_detail " &_
				' "SET time" & column & "=SEC_TO_TIME(" & value & "), " &_
				' "timetotal=(" &_
					' "SELECT (TIME_TO_SEC(TIMEDIFF(" & paramTimeDiff & "))/60)/60 " &_
					' ") " &_
				' "WHERE (summaryid=" & summaryid & ") AND (id=" & detailid & ")"
				.CommandText = "" &_
				"UPDATE time_detail " &_
				"SET time" & column & "=SEC_TO_TIME(" & value & ") " &_
				"WHERE (summaryid=" & summaryid & ") AND (id=" & detailid & ")"
			.Execute()
			.CommandText = sqlNewSum
		end with
		
	case "total"
		with cmd
			.CommandText = "" &_
				"UPDATE time_detail " &_
				"SET timetotal=" & value & ", timein=null, timeout=null " &_
				"WHERE (summaryid=" & summaryid & ") AND (id=" & detailid & ")"
			.Execute()
			.CommandText = sqlNewSum
		end with
		
	case "type"
		with cmd
			.CommandText = "" &_
				"UPDATE time_detail " &_
				"SET workday=" & value & " " &_
				"WHERE (summaryid=" & summaryid & ") AND (id=" & detailid & ")"
			.Execute()
			.CommandText = sqlNewSum
		end with
	
	case "workday"
		with cmd
			.CommandText = "" &_
				"UPDATE time_detail " &_
				"SET workday=" & value & " " &_
				"WHERE (summaryid=" & summaryid & ") AND (id=" & detailid & ")"

			.Execute()
			.CommandText = sqlNewSum
		end with
	end select
	
	dim howManyUpdates
	if column = "workday" then
		howManyUpdates = 2
	else
		howManyUpdates = 1
	end if
	
	dim eachUpdate
	for eachUpdate = 1 to howManyUpdates
		
		if eachUpdate > 1 then
			sqlNewSum = replace(sqlNewSum, "WHERE (workday=" & dayid & ")", "WHERE (workday=" & oldDayId & ")")
			dayid = oldDayId
			cmd.CommandText = sqlNewSum
		end if
		
		'get total of new line and update summary table
		select case column
		case "in", "out", "total", "workday", "oldworkday"
			dim rs

			set rs = cmd.Execute()
			if not rs.eof then newSum = rs("totalhours")
			with cmd	
				.CommandText = "" &_
					"UPDATE time_summary " &_
					"SET time_summary.d" & dayid & "=" & newSum & " " &_
					"WHERE id=" & summaryid & ";"
					
				'print cmd.CommandText
				.Execute()
			end with
			set rs = nothing
		end select
	next
	set cmd = nothing

	response.write "[" & column & "," & placementid & "," & summaryid & "," & detailid & "," & dayid & "," & newSum & "]"

end function

function getParameter(p_name)
	if use_qs then
		getParameter = request.querystring(p_name)
	else
		getParameter = request.form(p_name)
	end if
end function







%>
