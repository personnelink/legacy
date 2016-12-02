<!-- #include virtual='/include/system/tools/timecards/group/timecard.classes.asp' -->
<%

	'search by customer if internal staff otherwise force to customers cust code
	'
	dim searchbox
	if userLevelRequired(userLevelPPlusStaff) then
		searchbox = request.querystring("searchbox")
		if len(searchbox) = 0 then searchbox = "%"
	elseif userLevelRequired(userLevelSupervisor) then
		searchbox = g_company_custcode.CustomerCode
	end if

	dim customer
		customer = searchbox
		
	dim mySqlFromDate
	dim mySqlToDate

	mySqlFromDate = DatePart("yyyy", fromDate) & "/" & DatePart("m", fromDate) & "/" & DatePart("d", fromDate)
	mySqlToDate = DatePart("yyyy", toDate) & "/" & DatePart("m", toDate) & "/" & DatePart("d", toDate)

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
			"`tbl_supervisors`.`lastName` AS sLastName, " & _
			"`tbl_supervisors`.`firstName` AS sFirstName, " & _
			" `hours` " & _
		"FROM " & _
			"(SELECT `time_summary`.`weekending`, `time_detail`.`created`, `time_summary`.`site`, " & _
	"`time_summary`.`customer`, `time_summary`.`placementid`, `time_summary`.`creatorid`, " & _
	"`time_summary`.`time_detail`.`workday`, `time_detail`.`id`, " & _
	"`time_detail`.`timein`, `time_detail`.`timeout`, `tbl_users`.`lastName`, " & _
	"`tbl_users`.`firstName`, " & _
	"`time_detail`.`timetotal` as hours " & _
"FROM time_summary " & _
"RIGHT JOIN time_detail ON time_summary.id=time_detail.summaryid " & _
"LEFT JOIN tbl_users ON time_detail.creatorid=tbl_users.userid " & _
	"WHERE `time_summary`.`customer` like " & insert_string(customer) & "AND (ISNULL(`time_detail`.`timeout`) AND " &_
	"ISNULL(`time_detail`.`timein`) " & _
	"AND `time_summary`.`weekending` >= '" & mySqlFromDate & _
	"' AND `time_summary`.`weekending` <= '" & mySqlToDate & "') " & _
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
						"`time_summary`.`weekending` >= '" & mySqlFromDate & _
						"' AND `time_summary`.`weekending` <= '" & mySqlToDate & "') " & _
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
						"`time_summary`.`weekending` >= '" & mySqlFromDate & _
						"' AND `time_summary`.`weekending` <= '" & mySqlToDate & "')) AS t LEFT JOIN tbl_users AS tbl_supervisors ON t.approverid = tbl_supervisors.userid " & _
				"GROUP By t.weekending desc, t.lastName, t.firstName, t.created " & _
				"ORDER By t.weekending desc, t.created, t.lastName, t.firstName;"

				
				print sql
Dim cmd
	set cmd = server.CreateObject("ADODB.Command")

	with cmd
		.ActiveConnection = MySql
		.CommandText = sql
	end with

Dim rs
	set rs = cmd.execute()
	
dim rsPlacements
	cmd.CommandText = "" & _
		"SELECT DISTINCT placementid " & _
			"FROM time_summary " & _
				"RIGHT JOIN time_detail " & _
					"ON time_summary.id=time_detail.summaryid " & _
				"LEFT JOIN tbl_users " & _
					"ON time_detail.creatorid=tbl_users.userid " & _
					"WHERE `time_detail`.`timeout` > `time_detail`.`timein` " & _
									"OR `time_detail`.`timeout` > `time_detail`.`timein`;"

	set rsPlacements = cmd.execute()

dim strPlacements, strBuffer
do until rsPlacements.eof
	strBuffer = rsPlacements("placementid")
	if len(strBuffer) > 0 then
		strPlacements = strPlacements & strBuffer & ","
	end if
	rsPlacements.movenext
loop

strPlacements = left(strPlacements, len(strPlacements)-1) ' remove trailing comma

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
		.LoadArchivePlacements(strPlacements)
	end with
	
	
	dim BillRate, CostCenter, Department
	set BillRate = Server.CreateObject ("Scripting.Dictionary")
	set CostCenter = Server.CreateObject ("Scripting.Dictionary")
	set Department = Server.CreateObject ("Scripting.Dictionary")

	
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
		
		REM setCustomer_cmd.CommandText = "UPDATE time_summary SET customer=" & insert_string(Placement.CustomerCode) & _
						REM "WHERE placementid=" & Placement.PlacementId
		REM setCustomer_cmd.execute()

	next
	
	REM set setCustomer_cmd = nothing

Function WeekDayLabel(daynumber)

    Select Case daynumber

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

    End Select

End Function
%>