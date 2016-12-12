<%Option Explicit%>
<%
session("required_user_level") = 4 'userLevelEnrolled
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_headless_user_service.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/tools/timecards/group/timecard.classes.asp' -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html  lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"><meta http-equiv="X-UA-Compatible" content="IE=8" />
<script type="text/javascript" src="/include/js/jQuery-1.10.2.min.js"></script><meta name="url" content="https://www.personnelinc.com"><meta name="description" content="Personnel Plus is Your Total Staffing Solution. Time reporting">
<meta name="robots" content="index,follow"><meta name="apple-mobile-web-app-capable" content="yes"><link rel="shortcut icon" type="image/x-icon" href="/include/style/images/navigation/pplusicon.gif"><title>Personnel Plus - Your Total Staffing Solution!</title><link href="/time/clock/timeclock.css" rel="stylesheet" type="text/css"></head>

<body>

<script type="text/javascript" src="/include/js/jQuery-1.10.2.min.js"></script>
<script type="text/javascript" src="/time/clock/timeclock.001.js"></script><div id="topleftscrew">

</div>

<%

'Global Variables Begin
dim use_qs
	if request.querystring("use_qs") = "1" then
		use_qs = true
	else
		use_qs = false
	end if

dim customerid, customer
customerid = getParameter("customer")
customer = customerid

dim applicantid
applicantid = getParameter("applicantid")

dim placementid
placementid = getParameter("id")

dim siteid
siteid = g_strSite

if vartype(siteid) = 0 then
	siteid = getParameter("site")
end if

dim g_strSite
dim qsSite : qsSite = getParameter("site")
	if not isnumeric(qsSite) then
		g_strSite = getSiteNumber(qsSite)
	else
		g_strSite = cdbl(qsSite)
	end if

	
dim creatorid
	creatorid = lookupCreatorId (applicantid, getTempsSiteId(siteid))
	
dim time_clock_session
set time_clock_session = new cTimeClockSession
with time_clock_session
	.search      =  getParameter("q")
	.applicantid = applicantid
	.customer    = customer
	.site        = qsSite
	.creatorid   = creatorid
end with

'print "applicantid: " & time_clock_session.applicantid

'Global Variable End
time_clock_session.placementid = placementid

' session("time_clock") = time_clock_session
time_clock_session.CheckIfClockedIn

	dim today, weekEndingDate
	weekEndingDate = getWeekending(today)
	
	dim MySqlFriendlyDate
	MySqlFriendlyDate = Year(weekEndingDate) & "/" & Month(weekEndingDate) & "/" & Day(weekEndingDate)
	
if time_clock_session.applicantid <> "NaN" then
	if time_clock_session.ClockedIn then
		'clocked in, present option to clock-out [and present time clocked in and sort by highest detail id, in-case of multiple clock-ins]
		'print "clocking out"
		'doClockOut //system will run clock out later on this page
	else
		'not clocked in, get cost-centers present option to clock in
		'print "clocking in"
		
		response.redirect("cost_centers/?" & Request.QueryString)
		
		' doClockIn
	end if
end if

function doClockIn


	'get summaryid
	'if no summary, create summary and get lastindex as summaryid
	'insert time_detail record
	
	
	dim summaryid
	'summaryid = getParameter("summaryid")
	'
	'need to figure out summary id...
	'thinking if empty summary id exists [with no weekending] then commandeer the highest id and set the weekending, rerun query
	'
	'* scratch that, if now summary id exists with the current weeks weekending date then create a new summary for the current weekending date
	


	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"SELECT time_summary.id FROM pplusvms.time_summary " &_
				"WHERE (placementid='" & placementid & "' AND site='" & g_strSite & "' AND weekending='" & MySqlFriendlyDate & "');"
	end with
	
	dim rs
	set rs = cmd.Execute()
	
	if not rs.eof then
		'existing time summary exists
		'
		summaryid = rs("id")
	else
		'time summary for week doesn't exist, create one
		'
				
		' get temps details from placementid

		with cmd
		.ActiveConnection = dsnLessTemps(g_strSite)
		
		.CommandText = "" &_
			"SELECT Orders.Customer, Orders.JobNumber, Orders.Reference, Orders.JobDescription, Placements.EmployeeNumber, " &_
			"Placements.WorkCode, Placements.RegPayRate, Placements.RegBillRate, Placements.OvertimePayRate, Placements.OvertimeBillRate, WorkCodes.Description " &_
			"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
			"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
			"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
			"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
			"WHERE Placements.PlacementID=" & placementid
		end with
' print cmd.CommandText

		
		set rs = cmd.Execute()

		if not rs.eof then

			cmd.ActiveConnection = MySql
			cmd.CommandText = "" &_
				"INSERT INTO time_summary " &_
				"(workcode, wc_description, employeenumber, department, costcenter, cc_description, regpay, regbill, otpay, otbill, placementid, customer, site, weekending, createdby, creatorid, foruserid) " &_
				"VALUES " &_
				"(" & insert_string(rs("WorkCode")) & ", " &_
					insert_string(rs("Description")) & ", " &_
					insert_string(rs("EmployeeNumber")) & ", " &_
					insert_number(rs("JobNumber")) & ", " &_
					insert_number(rs("Reference")) & ", " &_
					insert_string(rs("JobDescription")) & ", " &_
					insert_string(rs("RegPayRate")) & ", " &_
					insert_string(rs("RegBillRate")) & ", " &_
					insert_string(rs("OvertimePayRate")) & ", " &_
					insert_string(rs("OvertimeBillRate")) & ", " &_
					 placementid & ", " & insert_string(customerid) & ", " & getTempsSiteId(siteid)  & ", '" & MySqlFriendlyDate & "', 'T', '" & creatorid & "', '" & creatorid & "');SELECT last_insert_id();"
		'print cmd.CommandText
		
		set rs = cmd.execute.nextrecordset
		
			summaryid = rs(0)
		
		end if
		
		
	end if
	
	
	
	
	with cmd
		.CommandText = "" &_
			"INSERT INTO time_detail (summaryid, workday, timein, creatorid, createdby) " &_
				"VALUES (" & summaryid & ", " & today & ", now(), " & creatorid & ", 'T');"
	end with
	
	set rs = cmd.execute()
	
	set cmd = nothing
	set rs = nothing
	
	dim confirmationHTML
		confirmationHTML = "" &_
		
			"<div style=""border:1px solid #73a54c;background-color:#5cbb15;float:left;clear:both;margin:0.8em 0 0;padding:0.2em 0.2em;"">" &_
				"<table style=""width:25em;"">" &_
				"<tr><td colspan=""2""></td></tr>" &_
				"<tr>" &_
					"<td colspan=""2""><span style=""color:white; font-weight:bold;"">You have successfully clocked <em>in</em> at " & time & "<br><br></span></td>" &_
				"</tr>" &_
				"<tr><td colspan=""2""></td></tr>" &_
				"<tr><td colspan=""2""></td></tr>" &_
				"</table>" &_
			"</div>"
			
	response.write confirmationHTML
	
	call sendEmailNotice("in", confirmationHTML, time)
	

end function

function doClockOut


	'print "clocking out... "
	
	'get summaryid
	'if no summary, create summary and get lastindex as summaryid
	'insert time_detail record
	
	
	dim summaryid
	'summaryid = getParameter("summaryid")
	'
	'need to figure out summary id...
	'thinking if empty summary id exists [with no weekending] then commandeer the highest id and set the weekending, rerun query
	'
	'* scratch that, if now summary id exists with the current weeks weekending date then create a new summary for the current weekending date
	
	'dim time_clock_session : time_clock_session = session("time_clock")

	
	'print time_clock_session.weekEndingDate
	
	dim cmd
		set cmd = server.CreateObject("ADODB.Command")
	
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"SELECT time_summary.id FROM pplusvms.time_summary " &_
				"WHERE (placementid='" & time_clock_session.placementid & "' AND site='" & g_strSite & "' AND weekending='" & MySqlFriendlyDate & "');"
	end with
	
	set rs = cmd.Execute()
	
	if not rs.eof then
		summaryid = rs("id")
		
		'print "summary id: " & summaryid

	else
	
		
		' get temps details from placementid
		
		with cmd
			.ActiveConnection = dsnLessTemps(g_strSite)
			
			.CommandText = "" &_
				"SELECT Orders.Customer, Orders.JobNumber, Orders.Reference, Orders.JobDescription, Placements.EmployeeNumber, " &_
				"Placements.WorkCode, Placements.RegPayRate, Placements.RegBillRate, Placements.OvertimePayRate, Placements.OvertimeBillRate, WorkCodes.Description " &_
				"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
				"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
				"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
				"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
				"WHERE Placements.PlacementID=" & placementid
		end with

		dim rs
		set rs = cmd.Execute()

		if not rs.eof then

	
			cmd.ActiveConnection = MySql
			cmd.CommandText = "" &_
				"INSERT INTO time_summary " &_
				"(workcode, wc_description, employeenumber, department, costcenter, cc_description, regpay, regbill, otpay, otbill, placementid, customer, site, weekending, createdby, creatorid) " &_
				"VALUES " &_
				"(" & insert_string(rs("WorkCode")) & ", " &_
					insert_string(rs("Description")) & ", " &_
					insert_string(rs("EmployeeNumber")) & ", " &_
					insert_number(rs("JobNumber")) & ", " &_
					insert_number(rs("Reference")) & ", " &_
					insert_string(rs("JobDescription")) & ", " &_
					insert_string(rs("RegPayRate")) & ", " &_
					insert_string(rs("RegBillRate")) & ", " &_
					insert_string(rs("OvertimePayRate")) & ", " &_
					insert_string(rs("OvertimeBillRate")) & ", " &_
					 placementid & ", " & insert_string(customerid) & ", " & getTempsSiteId(siteid)  & ", '" & MySqlFriendlyDate & "', 'T', '" & creatorid & "');SELECT last_insert_id();"
			set rs = cmd.execute.nextrecordset
			
			summaryid = rs(0)
			
		end if

	end if

	cmd.CommandText = "" &_
		"SELECT id, timein, timeout FROM time_detail " &_
			"WHERE summaryid=" & summaryid & " AND (timeout IS NULL AND timein IS NOT NULL) AND time_detail.created >= NOW() - INTERVAL 1 DAY;"
			'"WHERE summaryid=" & summaryid & " AND (timeout IS NULL AND timein IS NOT NULL);"
			'"WHERE summaryid=" & summaryid & " AND (timeout IS NULL AND timein IS NOT NULL) AND workday=" & today & ";"

	set rs = cmd.execute()
	
	'print cmd.CommandText
	
	if rs.eof then
		'no timedetail today, select previous summaries that may still be clocked in and clock them out
		
		cmd.CommandText = "" &_
			"SELECT time_detail.summaryid, time_detail.timein, time_detail.timeout, time_summary.placementid, time_summary.site, " &_
				"time_detail.workday, time_detail.creatorid, time_detail.id " &_
					"FROM pplusvms.time_detail " &_
					"LEFT JOIN pplusvms.time_summary on time_summary.id = time_detail.summaryid " &_
			"WHERE (placementid=" & time_clock_session.placementid & " AND site=" & g_strSite & " AND time_detail.creatorid=" & time_clock_session.creatorid & ") " &_
				"AND (time_detail.timein IS NOT NULL AND time_detail.timeout IS NULL) ORDER By time_detail.id desc;"
			
		'print cmd.CommandText
		
		set rs = cmd.execute()
		
		do until rs.eof
			'print "iterating: " & rs("summaryid")
			
			cmd.CommandText = "" &_
				"UPDATE time_detail SET modified=now(), timeout=now() " &_
				"WHERE (summaryid=" & rs("summaryid") & " AND (timeout IS NULL AND timein IS NOT NULL)) AND created >= NOW() - INTERVAL 15 HOUR;"
			
			rs.movenext
			
			cmd.execute()
		loop
		

	else
		cmd.CommandText = "" &_
			"UPDATE time_detail SET modified=now(), timeout=now() " &_
				"WHERE (summaryid=" & summaryid & " AND (timeout IS NULL AND timein IS NOT NULL)) AND created >= NOW() - INTERVAL 15 HOUR;"
				'"WHERE summaryid=" & summaryid & " AND (timeout IS NULL AND timein IS NOT NULL);"
				'"WHERE summaryid=" & summaryid & " AND (timeout IS NULL AND timein IS NOT NULL) AND workday=" & today & ";"
	end if

	set rs = cmd.execute()
	
	REM cmd.CommandText = "" &_
			REM "UPDATE time_detail " &_
			REM "SET timetotal=(" &_
				REM "SELECT TIME_TO_SEC(TIMEDIFF(Time_Format(time_detail.timeout, '%H:%i'), Time_Format(time_detail.timein, '%H:%i')))/60)/60 " &_
				REM "WHERE summaryid=" & summaryid & " AND (timeout IS NOT NULL AND timein IS NOT NULL);"
				
	REM set rs = cmd.execute()
	
	set cmd = nothing
	set rs = nothing
	
	dim confirmationHTML
	
	confirmationHTML = "" &_
				"<div style=""border:1px solid #73a54c;background-color:#f74a46;float:left;clear:both;margin:0.8em 0 0;padding:0.2em 0.2em;"">" &_
					"<table style=""width:25em;"">" &_
					"<tr><td colspan=""2""></td></tr>" &_
					"<tr>" &_
						"<td colspan=""2""><span style=""color:white; font-weight:bold;"">You have successfully clocked <em>out</em> at " & time & "</span></td>" &_
					"</tr>" &_
					"<tr><td colspan=""2""></td></tr>" &_
					"<tr><td colspan=""2""></td></tr>" &_
					"</table>" & _
				"</div>"
	
	response.write confirmationHTML
	response.flush()
	
	call sendEmailNotice("out", confirmationHTML, time)
	
	'send email for previous weeks unapproved and pending time
		'
	'sendEmployeeTimeSummaryEmail(MySqlFriendlyDate)


end function

function getWeekending(today)
	
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
	weekEndsOn = cint(rs("weekends"))
	
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

<!--
			<div style="heigh:3em; width:26em; color:white; font-weight:bold;font-family:arial;">Choose Action</div>	

				<div style="border:1px solid #73a54c;background-color:#f74a46;float:right;">
					<a href="javascript:;" onclick="timeclock.clockout('<%=placementid%>','<%=g_strSite%>', '<%=customer%>', '<%=applicantid%>');" style="color:white;font-weight:bold;font-family:arial;text-decoration:none;">
						<div style="width:12em;height:5em;text-align:center; padding:auto 0; vertical-align: middle;">
							<p style="position:relative; top:25%">Clock Out</p>
						</div>
					</a>
				</div>	
-->

<%
				
				
%>

<div id="user_info_div"><%=getUserDetail%></div>

<div id="innertube">
<div id="clock_action_results">
<div style="vertical-align:bottom;min-height:3em; width:27em; color:white; font-weight:normal;font-family:arial;font-size:110%;"><p style="text-shadow: 2px 4px 3px rgba(0,0,0,0.3);text-shadow: horizontal-offset vertical-offset blur color;">Hours subject to pre-approved shift. <br /><br /><i>All over-time hours must be approved in advance.</i></p></div>


<%=doClockOut%>

</div>

	<div id="readerror"><div style="border:1px solid #65539f;background-color:#65539f;float:left;clear:both;margin:0.8em 0 0;padding:0.2em 0.2em">
		<table style="width:25em;">
		<tr><td colspan="2"></td></tr>
		<tr>
			<td colspan="2"><span style="color:white; font-weight:bold;">Card swipe read error, please try again. <br><br></span></td>
		</tr>
		<tr><td colspan="2"></td></tr>
		<tr><td colspan="2"></td></tr>
		</table>
	</div></div>

</div>

<a href="javascript:;" onclick="javascript:(function(){var e=document.createElement('script');e.type='text/javascript';e.src='jKeyboard.js.php';document.getElementsByTagName('head')[0].appendChild(e);})();"><div id="personnelinc"><img src="personnelinc.png"></div>
<div id="clock"><span id="time_span">time</span><span id="date_span">date</span><span id="linkurl">www.personnelinc.com</span></div></a>
<embed src="clock_in.wav" autostart="false" width="0" height="0" id="clock_in_sound"
enablejavascript="true">
<embed src="clock_out.wav" autostart="false" width="0" height="0" id="clock_out_sound"
enablejavascript="true">

<%
public function getUserDetail()
	'on error resume next

	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
				"SELECT tbl_users.userID, tbl_users.applicationID, CONCAT(tbl_users.firstName, "" "", tbl_users.lastName) AS ApplicantName, tbl_users.EmpCode,  " &_
				"tbl_applications.in" &getTempsCompCode(siteid) & " AS ApplicantId, tbl_applications.ssn " &_
				"FROM pplusvms.tbl_users  " &_
				"INNER JOIN pplusvms.tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID " &_
				"WHERE  tbl_applications.in" & getTempsCompCode(siteid) & "='" & applicantid & "'"

	end with
	
	
if applicantid <> "NaN" and applicantid > 0 then 
		
	dim rs
	set rs =cmd.execute()

		if not rs.eof then
			
			dim photolnk, compcode
			compcode = getTempsCompCode(siteid)
			
			'print "\\personnelplus.net.\web\vms\include\system\tools\timeclock\photoid\" & compcode & "\" & applicantid & "\photo.jpg"
			
			dim fs
			set fs=Server.CreateObject("Scripting.FileSystemObject")
			if fs.FileExists("\\personnelplus.net.\web\vms\include\system\tools\timeclock\photoid\" & compcode & "\" & applicantid & "\photo.jpg") then
			  photolnk = "/include/system/tools/timeclock/photoid/" & compcode & "/" & applicantid & "/photo.jpg"
			 else
			  photolnk = "/include/system/tools/timeclock/photoid/profile-pic-generic.jpg"
			end if
			%>
			  <img style="float:right;margin-left:0.2em;" src="<%=photolnk%>">
			  <div style="float:left;">
			  <div style="font-size:105%; width:10em;text-align:right;padding-right:0.2em;">
			  <%=rs("ApplicantName")%><span style="display:block;font-size:60%;color:white;">
			  <%="***-**-" & right(rs("ssn"), 4)%><br>
			  <i>Personnel Plus</i></span></div></div>
			<%
			
			rs.close
			
		end if
end if
set cmd = nothing
set rs = nothing
end function


function getParameter(p_name)
	if use_qs then
		getParameter = request.querystring(p_name)
	else
		getParameter = request.form(p_name)
	end if
end function


function lookupCreatorId (applicantid, site)
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"SELECT tbl_users.userID, tbl_applications.in" & getTempsCompCode(site) & " FROM pplusvms.tbl_applications " &_
				"INNER JOIN tbl_users on tbl_applications.applicationID=tbl_users.applicationID " &_
				"WHERE tbl_applications.in" & getTempsCompCode(site) & "=" & applicantid & ";"
	end with
	
	dim rs
	set rs = cmd.Execute()
	
	
	if not rs.eof then
		lookupCreatorId = rs("userID")
	else
		lookupCreatorId = false
	end if

end function


public function sendEmailNotice(clockDirection, htmlbody, time)

	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"SELECT tbl_users.firstName, tbl_users.lastName, tbl_users.userPhone, tbl_users.userSPhone, " &_
				"tbl_users.userName, tbl_users.userEmail, tbl_users.userAlternateEmail " &_
			"FROM tbl_users " &_
				"RIGHT JOIN tbl_applications ON tbl_users.applicationID=tbl_applications.applicationID " &_
			"WHERE tbl_applications.in" & getTempsCompCode(g_strSite) & "='" & applicantid & "';"
		
	end with
	
		
	dim indenter : indenter = "<br>----&nbsp;"
	
	dim rs, empinfo
	set rs = cmd.Execute()
	if not rs.eof then

		dim employeeName : employeeName = rs("firstName") & " " & rs("lastName")

		empinfo = "" &_
				"<br>" &_
				"<em><strong>Contact info for " & employeeName & "</strong></em>: " & indenter &_
				"Applicant Number: " & applicantid & indenter &_
				"Email Address: " & rs("userEmail") & indenter &_
				"Alternate Email: " & rs("userAlternateEmail") & indenter &_
				"Primary Phone: " & FormatPhone(rs("userPhone")) & indenter &_
				"Alternate Phone: " & FormatPhone(rs("userSPhone")) &_
				"<br>------------------------------------------------------<br>"
	end if	

	with cmd
		if isnumeric(g_strSite) then
			.ActiveConnection = dsnLessTemps(cint(g_strSite))
		else
			.ActiveConnection = dsnLessTemps(getTempsDSN(g_strSite))
		end if

		.CommandText = "" &_
				"SELECT Placements.PlacementID, Orders.Customer, Orders.Reference, Placements.CurrentReviewScore, " &_
				"Placements.AverageReviewScore, Placements.EmployeeNumber, Placements.WorkCode, WorkCodes.Description, " &_
				"Orders.JobNumber, Orders.JobDescription " &_
				"FROM WorkCodes RIGHT JOIN " &_
				"(Orders RIGHT JOIN (Applicants LEFT JOIN Placements ON Applicants.ApplicantID = Placements.ApplicantId) " &_
				"ON Orders.Reference = Placements.Reference) ON WorkCodes.WorkCode = Placements.WorkCode " &_
				"WHERE (Applicants.ApplicantID=" & applicantid & " AND Orders.Customer='" & customerid &"') AND PlacementStatus = 0;"
		.Prepared = true
	end with
	
	'print cmd.CommandText

	set rs = cmd.execute()
	
	dim jobref 'for escaping the branch emails for interals (currently all internal are placed in Twin)
	jobref = rs("Reference")
	
	dim jobinfo
	
	dim customercode : customercode = rs("Customer")
	
	if not rs.eof then
	jobinfo = "" &_
			"<em><strong>Some info about their placement:</strong></em>" & indenter &_
			"Customer Code: " & customercode & indenter &_
			"Order Description: " & rs("JobDescription") & indenter &_
			"Department#: " & rs("JobNumber") & ", Reference#: " & jobref & indenter &_
			"Current Review Score: " & rs("CurrentReviewScore") & indenter &_
			"Average Review Score: " & rs("AverageReviewScore") & indenter &_
			"Employee Number: " & rs("EmployeeNumber") & indenter &_
			"Work Code: " & rs("WorkCode") & indenter &_
			"Work Code Description: " & rs("Description") &_
			"<br>"
	end if	


	'create email to internal
	dim sendToEmail
	select case g_strSite
		case PER
			sendToEmail = "twin@personnel.com"
		case BUR
			sendToEmail = "burley@personnel.com"
		case BOI
			sendToEmail = "boise@personnel.com;nampa@personne.com"
		case POC
			sendToEmail = "pocatello@personnel.com;burley@personnel.com"
		case WYO
			sendToEmail = "wyoming@personnel.com"
	end select
	
	
	REM select case jobref 'add branch email if internal
		REM case 1914
			REM sendToEmail = "twin@personnel.com;burley@personnel.com;boise@personnel.com;nampa@personnel.com"
		
		REM case 4768
			REM sendToEmail = "twin@personnel.com;burley@personnel.com;boise@personnel.com;nampa@personnel.com"
		
		REM case 4756 
			REM sendToEmail = "twin@personnel.com;burley@personnel.com;boise@personnel.com;nampa@personnel.com"
	
		REM case 3983 
			REM sendToEmail = "twin@personnel.com;burley@personnel.com;boise@personnel.com;nampa@personnel.com"
	
	REM end select

	dim eSubject : eSubject = employeeName & " has successfully clocked " & clockDirection & " @ " & time

	
	dim  firstStyle, secondStyle
	firstStyle = "border:1px solid #73a54c;background-color:#f74a46;float:left;clear:both;margin:0.8em 0 0;padding:0.2em 0.2em;"
	secondStyle = "color:white; font-weight:bold;"
	
	dim newFirst
		newFirst = "border:1px solid #73a54c;background-color:#f74a46;margin:0.8em 0 0;padding:0.2em 0.2em;"
	dim newSecond
		
	select case clockDirection
		case "in"
			newSecond = "color:darkgreen; font-weight:bold;"
		case "out"
			newSecond = "color:red; font-weight:bold;"
	end select
	
	dim eBody 
	
	eBody = htmlbody
	eBody = replace(eBody, "You have", employeeName & " has")
	
	eBody = replace(eBody, firstStyle, newFirst)
	eBody = replace(eBody, secondStyle, newSecond)
	
	eBody = eBody & empinfo & jobinfo & "<br><br>Use this link to manage this company: https://www.personnelinc.com/include/system/tools/timecards/group/?customer=" & customercode & "&site=" & g_strSite 
	
	Call SendEmail ("Employee Time-clock Activity<" & sendToEmail & ">;", timeclock_email, eSubject, "<send_as_html>" & eBody, "")

	set rs = nothing
	set cmd = nothing
	
end function

%>




