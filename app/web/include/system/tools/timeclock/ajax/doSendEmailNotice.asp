<%

'dry testing code, remove for production
'

REM dim MySqlFriendlyDate, customerid
REM customerid="JERCHE"
REM MySqlFriendlyDate="2014-8-26"
REM applicantid = 29944
REM placementid = 36065

REM sendEmployeeTimeSummaryEmail()

public function sendEmployeeTimeSummaryEmail(MySqlFriendlyDate)

end function

public function futureSendEmployeeTimeSummaryEmail(MySqlFriendlyDate)
	' retrieve employee's un-submitted time summaries
	'
	dim customer
		customer = customerid
		
	dim mySqlFromDate
	dim mySqlToDate

	mySqlToDate = MySqlFriendlyDate

	Dim sql
	sql = "" & _
		"SELECT " & _
			"`weekending`, " & _
			"`created`, " & _
			"`site`, " & _
			"`customer`, " & _
			"`placementid`, " & _
			"`creatorid`, " & _
			"`workday`, " & _
			"`id`, " & _
			"TIME_FORMAT(timein, '%T') AS timein, " & _
			"TIME_FORMAT(timeout, '%T') AS timeout, " & _
			"`t`.`lastName`, " & _
			"`t`.`firstName`, " & _
			" `hours` " & _
		"FROM " & _
			"(SELECT `time_summary`.`weekending`, `time_detail`.`created`, `time_summary`.`site`, " & _
	"`time_summary`.`customer`, `time_summary`.`placementid`, `time_summary`.`creatorid`, " & _
	"`time_detail`.`workday`, `time_detail`.`id`, " & _
	"`time_detail`.`timein`, `time_detail`.`timeout`, `tbl_users`.`lastName`, " & _
	"`tbl_users`.`firstName`, " & _
	"`time_detail`.`timetotal` as hours " & _
"FROM time_summary " & _
"RIGHT JOIN time_detail ON time_summary.id=time_detail.summaryid " & _
"LEFT JOIN tbl_users ON time_detail.creatorid=tbl_users.userid " & _
	"WHERE `time_summary`.`customer` like " & insert_string(customer) & "AND (ISNULL(`time_detail`.`timeout`) AND " &_
	"ISNULL(`time_detail`.`timein`) " & _
	"AND `time_summary`.`weekending` < '" & mySqlToDate & "') AND `time_summary`.`placementid` = '" & placementid & "' " & _
			"UNION ALL " &_
			"SELECT " & _
				"`time_summary`.`weekending`, " & _
				"`time_detail`.`created`, " & _
				"`time_summary`.`site`, " & _
				"`time_summary`.`customer`, " & _
				"`time_summary`.`placementid`, " & _
				"`time_summary`.`creatorid`, " & _
				"`time_detail`.`workday`, " & _
				"`time_detail`.`id`, " & _
				"`time_detail`.`timein`, " & _
				"`time_detail`.`timeout`, " & _
				"`tbl_users`.`lastName`, " & _
				"`tbl_users`.`firstName`, " & _
				"(ABS(TIME_TO_SEC(TIMEDIFF(`time_detail`.`timeout`, `time_detail`.`timein`)))/60)/60 as hours " & _
				"" & _
			"FROM time_summary " & _
				"RIGHT JOIN time_detail " & _
					"ON time_summary.id=time_detail.summaryid " & _
				"LEFT JOIN tbl_users " & _
					"ON time_detail.creatorid=tbl_users.userid " & _
					"WHERE `time_summary`.`customer` like " & insert_string(customer) & " AND (`time_detail`.`timeout` > `time_detail`.`timein`  AND " & _
						"`time_summary`.`weekending` < '" & mySqlToDate & "') AND `time_summary`.`placementid` = '" & placementid & "' " & _
			"UNION ALL " & _
			"SELECT " & _
				"`time_summary`.`weekending`, " & _
				"`time_detail`.`created`, " & _
				"`time_summary`.`site`, " & _
				"`time_summary`.`customer`, " & _
				"`time_summary`.`placementid`, " & _
				"`time_summary`.`creatorid`, " & _
				"`time_detail`.`workday`, " & _
				"`time_detail`.`id`, " & _
				"`time_detail`.`timein`, " & _
				"`time_detail`.`timeout`, " & _
				"`tbl_users`.`lastName`, " & _
				"`tbl_users`.`firstName`, " & _
				"(ABS(TIME_TO_SEC(TIMEDIFF(`time_detail`.`timeout`, `time_detail`.`timein`)))/60)/60 as hours " & _
				"" & _
			"FROM time_summary " & _
				"RIGHT JOIN time_detail " & _
					"ON time_summary.id=time_detail.summaryid " & _
				"LEFT JOIN tbl_users " & _
					"ON time_detail.creatorid=tbl_users.userid " & _
				"WHERE `time_summary`.`customer` like " & insert_string(customer) & " AND (`time_detail`.`timeout` < `time_detail`.`timein`  AND " & _
						"`time_summary`.`weekending` < '" & mySqlToDate & "') AND `time_summary`.`placementid` = '" & placementid & "') AS t " & _
				"ORDER By t.customer, t.site, t.weekending desc, t.lastName, t.firstName, t.created;"

				
				'print sql
Dim cmd
	set cmd = server.CreateObject("ADODB.Command")

	with cmd
		.ActiveConnection = MySql
		.CommandText = sql
	end with

Dim rs
	set rs = cmd.execute()
	
' dim rsPlacements
	' cmd.CommandText = "" & _
		' "SELECT DISTINCT placementid " & _
			' "FROM time_summary " & _
				' "RIGHT JOIN time_detail " & _
					' "ON time_summary.id=time_detail.summaryid " & _
				' "LEFT JOIN tbl_users " & _
					' "ON time_detail.creatorid=tbl_users.userid " & _
					' "WHERE (`time_detail`.`timeout` > `time_detail`.`timein` " & _
									' "OR `time_detail`.`timeout` > `time_detail`.`timein`) " & _
									' "AND `time_summary`.`customer` like " & insert_string(customer) & ";"

	' set rsPlacements = cmd.execute()

' dim strPlacements, strBuffer
' do until rsPlacements.eof
	' strBuffer = rsPlacements("placementid")
	' if len(strBuffer) > 0 then
		' strPlacements = strPlacements & strBuffer & ","
	' end if
	' rsPlacements.movenext
' loop

' strPlacements = left(strPlacements, len(strPlacements)-1) ' remove trailing comma
dim fromDate, toDate
dim Placements
	set Placements = new cPlacements
	with Placements
		.ItemsPerPage = 1500
		.Page = Request.QueryString("WhichPage")
		' .Company = Request.QueryString("whichCompany")
		' .Customer = Request.QueryString("WhichCustomer")
		'.Order = GetParameter("id")
		.Applicant = Request.QueryString("whichApplicant")
		.FromDate = fromDate
		.ToDate = toDate
		.LoadPlacements(placementid)
	end with
	
	
	dim BillRate, CostCenter, Department, WCDescription
	set BillRate = Server.CreateObject ("Scripting.Dictionary")
	set CostCenter = Server.CreateObject ("Scripting.Dictionary")
	set Department = Server.CreateObject ("Scripting.Dictionary")
	set WCDescription = Server.CreateObject ("Scripting.Dictionary")

	
REM Dim setCustomer_cmd


	REM 'temporary code to patch in customer code to database
	REM ' 2014.04.07
	REM set setCustomer_cmd = server.CreateObject("ADODB.Command")
	REM with setCustomer_cmd
		REM .ActiveConnection = MySql
	REM end with
	
	
	dim Placement
	for each Placement in Placements.Placements.Items
		BillRate.Add Placement.PlacementId, Placement.RegBillRate
		CostCenter.Add Placement.PlacementId, Placement.WCDescription
		Department.Add Placement.PlacementId, Placement.WCDescription
		
		REM 'temp code to update customer in new table attribute
		REM ' 2014.04.07
		REM setCustomer_cmd.CommandText = "UPDATE time_summary SET customer=" & insert_string(Placement.CustomerCode) & _
						REM "WHERE placementid=" & Placement.PlacementId
		REM setCustomer_cmd.execute()
		
		REM setCustomer_cmd.CommandText = "UPDATE time_summary_archive SET customer=" & insert_string(Placement.CustomerCode) & _
						REM "WHERE placementid=" & Placement.PlacementId
		REM setCustomer_cmd.execute()

	next
	
	REM set setCustomer_cmd = nothing
	
	Dim sqlrealtionID, rsrelationID, addressID, userID, companyID
	
	'Store date into Database	
	' * retrieve employee time summary notice email template
	'
	Database.Open MySql
	Set dbQuery = Database.Execute("Select * From email_templates Where template='employeeTimeApprove'")
	dim MessageBody, MessageTemplate, newRow, tableData
	
	MessageTemplate = split(dbQuery("body"), "<tr>")
	
	const msgHeader = 1
	const msgRow    = 2
	const msgFooter = 3
	
	dim strDeadline
		
	do while not rs.eof
		newRow = MessageTemplate(msgRow)
		' MessageBody = Replace(MessageBody, "%companyname%", Request.Form("companyname"))
		newRow = Replace(newRow, "%department%", CostCenter(rs("placementid")))
		newRow = Replace(newRow, "%customer%", rs("customer"))
		newRow = Replace(newRow, "%workdate%", rs("workday"))
		newRow = Replace(newRow, "%timein%", rs("timein"))
		newRow = Replace(newRow, "%timeout%", rs("timeout"))
		newRow = Replace(newRow, "%actreg%", rs("hours"))
		newRow = Replace(newRow, "%totalpayhrs%", rs("hours"))
		
		tableData = tableData & newRow
		
		
		rs.movenext
	loop
	
	dim strDeadliner : strDeadliner = "Monday at 5pm"
	
	MessageBody = MessageTemplate(0) & MessageTemplate(msgHeader) & tableData & MessageTemplate(msgFooter)
	dim nr
	for nr = msgFooter + 1 to ubound(MessageTemplate)
		MessageBody = MessageBody & MessageTemplate(nr)
	next
	
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"SELECT tbl_users.firstName, tbl_users.lastName, tbl_users.userPhone, tbl_users.userSPhone, " &_
				"tbl_users.userName, tbl_users.userEmail, tbl_users.userAlternateEmail " &_
			"FROM tbl_users " &_
				"RIGHT JOIN tbl_applications ON tbl_users.applicationID=tbl_applications.applicationID " &_
			"WHERE tbl_applications.in" & getTempsCompCode(g_strSite) & "='" & applicantid & "';"
		
	end with
	
	dim empinfo
	set rs = cmd.Execute()
	if not rs.eof then

		dim employeeName : employeeName = rs("firstName") & " " & rs("lastName")
		
		
		dim SendTo
		'SendTo = employeeName & "<" & rs("userEmail") & ">"
		SendTo = employeeName & "<richardksizemore@gmail.com>" 'for testing so all go to Richard for now
		'SendTo = SendTo & employeeName & "<jpeterson@personnel.com>" 'for testing so all go to Richard for now

		
		SendEmail SendTo, time_summary_email, replace(dbQuery("subject"), "%deadline%", strDeadline), MessageBody & "<send_as_html>", ""
		Set dbQuery = Nothing
	end if
	
	Database.Close

end function


function WeekDayLabel(daynumber)

    select case daynumber

        Case 1
            WeekDayLabel = "Sun"

        Case 2
            WeekDayLabel = "Mon"

        Case 3
            WeekDayLabel = "Tue"

        Case 4
            WeekDayLabel = "Wed"

        Case 5
            WeekDayLabel = "Thu"

        Case 6
            WeekDayLabel = "Fri"

        Case 7
            WeekDayLabel = "Sat"

    end select

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
	firstStyle = "border:1px solid #73a54c;background-color:#f74a46;float:left;clear:both;margin:0.8em 0 0;padding:0.2em 0.2em;box-shadow: 10px 10px 5px #888888;"
	secondStyle = "color:white; font-weight:bold;"
	
	dim newFirst
		newFirst = "border:1px solid #73a54c;background-color:#f74a46;margin:0.8em 0 0;padding:0.2em 0.2em;box-shadow: 10px 10px 5px #888888;"
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

