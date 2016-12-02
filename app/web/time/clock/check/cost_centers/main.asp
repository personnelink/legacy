<%Option Explicit%>
<%
session("required_user_level") = 4 'userLevelEnrolled
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_headless_user_service.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/tools/timecards/group/timecard.classes.asp' -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html  lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"><meta http-equiv="X-UA-Compatible" content="IE=8" /><script type="text/javascript" src="/include/js/jQuery-1.10.2.min.js"></script><meta name="url" content="https://www.personnelinc.com"><meta name="description" content="Personnel Plus is Your Total Staffing Solution. Time reporting"><meta name="robots" content="index,follow"><meta name="apple-mobile-web-app-capable" content="yes"><link rel="shortcut icon" type="image/x-icon" href="/include/style/images/navigation/pplusicon.gif"><title>Personnel Plus - Your Total Staffing Solution!</title><link href="/time/clock/timeclock.css" rel="stylesheet" type="text/css"></head>

<body>
<script type="text/javascript" src="/time/clock/timeclock.001.js"></script><div id="topleftscrew">

</div>
<%


dim use_qs
	if request.querystring("use_qs") = "1" then
		use_qs = true
	else
		use_qs = false
	end if
	
function getParameter(p_name)
	if use_qs then
		getParameter = request.querystring(p_name)
	else
		getParameter = request.form(p_name)
	end if
end function


'Global Variables Begin
dim customerid, customer
customerid = getParameter("customer")
customer = customerid

dim placementid
placementid = getParameter("id")

dim siteid
siteid = g_strSite

if vartype(siteid) = 0 then
	siteid = getParameter("site")
end if

dim applicantid
	applicantid = getParameter("applicantid")


dim g_strSite
dim qsSite : qsSite = getParameter("site")
	if not isnumeric(qsSite) then
		g_strSite = getSiteNumber(qsSite)
	else
		g_strSite = cdbl(qsSite)
	end if

public function doGetCostCenters()
	
	'on error resume next
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		if isnumeric(siteid) then
			.ActiveConnection = dsnLessTemps(cint(siteid))
		else
			.ActiveConnection = dsnLessTemps(getTempsDSN(siteid))
		end if

		.CommandText = "" &_
				"SELECT Applicants.ApplicantID, Placements.PlacementID, Orders.Customer, Orders.Reference, Placements.CurrentReviewScore, " &_
				"Placements.AverageReviewScore, Placements.EmployeeNumber, Placements.WorkCode, WorkCodes.Description, " &_
				"Orders.JobNumber, Orders.JobDescription " &_
				"FROM WorkCodes RIGHT JOIN " &_
				"(Orders RIGHT JOIN (Applicants LEFT JOIN Placements ON Applicants.ApplicantID = Placements.ApplicantId) " &_
				"ON Orders.Reference = Placements.Reference) ON WorkCodes.WorkCode = Placements.WorkCode " &_
				"WHERE (Applicants.ApplicantID=" & applicantid & " AND Orders.Customer='" & customerid &"') AND PlacementStatus = 0;"
		.Prepared = true
	end with
	
	'print cmd.CommandText
	dim rs
	set rs =cmd.execute()
	if err.Number = 0 then 

   %>
   <table style="width:25em;">
		<tr><td colspan="2"><span style="color:white; font-weight:bold;border-bottom:1px solid #8da0d9;">Optional: Alternate Departments or Cost Centers</span></td></tr></table>
   <%	
	dim costCenterPid, defaultCostCenter, defaultCCText
	
	defaultCostCenter = 0
	
	if not rs.eof then
		dim firstPlacementId
			firstPlacementId = rs("PlacementID")
		do until rs.eof
			costCenterPid = rs("PlacementID")
			
			if defaultCostCenter = 0 then
				defaultCCText = " defaultCostCenter"			
			else
				defaultCCText = ""
			end if
			
			defaultCostCenter = defaultCostCenter + 1
			
			%>
			<div class="cost_center_button">
					<span class="cost_center<%=defaultCCText%>" onclick="cost_centers.get_actions('<%=costCenterPid%>', '<%=applicantid%>', '<%=siteid%>', '<%=customerid%>')" style="vertical-align:middle;padding:1.2em 0;color:white;display:block;height:2.4em;font-weight:normal;font-family:arial;">
					<%=rs("Reference")%>:<%=rs("PlacementID")%>&nbsp;&nbsp;<%=rs("JobDescription")%>&nbsp;/&nbsp;<%=rs("Description")%>
					</span>
			</div><%
			
			rs.movenext
		loop
		
		
		response.write "<!-- first placement id=[" & firstPlacementId & "] -->"
	end if
	
	else %>
	
		<div style="border:1px solid #65539f;background-color:#65539f;float:left;clear:both;margin:0.8em 0 0;padding:0.2em 0.2em">
			<table style="width:25em;">
			<tr><td colspan="2"></td></tr>
			<tr>
				<td colspan="2"><span style="color:white; font-weight:bold;">Error #<%=err.Number%>: Card swipe processing error <br><br></span></td>
			</tr>
			<tr><td colspan="2"></td></tr>
			<tr><td colspan="2"></td></tr>
			</table>
		</div><%

	end if


	rs. close
	set rs = nothing
	set cmd = nothing
		

end function

public function removeTimeSummary()
	dim placementid
	placementid = getParameter("id")
	
	dim siteid
	siteid = getTempsDSN(g_strSite)
	
	dim summaryid
	summaryid = getParameter("summary")
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"DELETE FROM time_summary " &_
			"WHERE (placementid=" & placementid & ") AND (site=" & siteid & ") AND (id=" & summaryid & ")"
			
		.Execute()
	end with

	with cmd
		.CommandText = "" &_
			"DELETE FROM time_detail " &_
			"WHERE (summaryid=" & summaryid & ")"
		.Execute()
	end with

	set cmd = nothing
	response.write placementid & ":" & g_strSite
end function


%>


<script type="text/javascript" src="timeclock.001.js"></script>
<div id="user_info_div"><%=getUserDetail%></div>

<div id="innertube">
<div id="clock_action_results" class=""><%=doGetCostCenters%></div>

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

<%

public function getUserDetail()
	'on error resume next
	dim tempsCode : tempsCode = qsSite
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
				"SELECT tbl_users.userID, tbl_users.applicationID, CONCAT(tbl_users.firstName, "" "", tbl_users.lastName) AS ApplicantName, tbl_users.EmpCode,  " &_
				"tbl_applications.in" & tempsCode & " AS ApplicantId, tbl_applications.ssn " &_
				"FROM pplusvms.tbl_users  " &_
				"INNER JOIN pplusvms.tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID " &_
				"WHERE  tbl_applications.in" & tempsCode & "='" & applicantid & "'"

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
		set fs=nothing
	%>
			<img style="float:right;margin-left:0.2em;" src="<%=photolnk%>">
			<div style="float:left;">
			<div style="font-size:105%; width:10em;text-align:right;padding-right:0.2em;">
			<%=rs("ApplicantName")%><span style="display:block;font-size:60%;color:white;">
			<%="***-**-" & right(rs("ssn"), 4)%><br>
			<i>Personnel Plus</i></span></div></div>
	<%
		end if
		
		rs.close
		set rs = nothing
	end if
	set cmd = nothing
		

end function

%>
