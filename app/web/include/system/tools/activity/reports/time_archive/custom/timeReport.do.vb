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
			"`summaryid`, " & _
			"`weekending`, " & _
			"`created`, " & _
			"`site`, " & _
			"`customer`, " & _
			"`placementid`, " & _
			"`department`, " & _
			"`costcenter`, " & _
			"`cc_description`, " & _
			"`foruserid`, " & _
			"`approverid`, " & _
			"`workday`, " & _
			"`id`, " & _
			"TIME_FORMAT(timein, '%T') AS timein, " & _
			"TIME_FORMAT(timeout, '%T') AS timeout, " & _
			"`tbl_users`.`lastName`, " & _
			"`tbl_users`.`firstName`, " & _
			"`tbl_supervisors`.`lastName` AS sLastName, " & _
			"`tbl_supervisors`.`firstName` AS sFirstName, " & _
			" `hours` " & _
		"FROM " & _
			"(SELECT `time_summary_archive`.`id` AS summaryid, `time_summary_archive`.`weekending`, `time_detail_archive`.`created`, `time_summary_archive`.`site`, " & _
	"`time_summary_archive`.`customer`, `time_summary_archive`.`placementid`, `time_summary_archive`.`department`, `time_summary_archive`.`costcenter`, `time_summary_archive`.`cc_description`, `time_summary_archive`.`foruserid`, " & _
	"`time_summary_archive`.`approverid`, `time_detail_archive`.`workday`, `time_detail_archive`.`id`, " & _
	"`time_detail_archive`.`timein`, `time_detail_archive`.`timeout`, " & _
	"`time_detail_archive`.`timetotal` as hours " & _
"FROM time_summary_archive " & _
"RIGHT JOIN time_detail_archive ON time_summary_archive.id=time_detail_archive.summaryid " & _
"" & _
	"WHERE `time_summary_archive`.`customer` like " & insert_string(customer) & "AND (ISNULL(`time_detail_archive`.`timeout`) AND " &_
	"ISNULL(`time_detail_archive`.`timein`) " & _
	"AND `time_summary_archive`.`weekending` >= '" & mySqlFromDate & _
	"' AND `time_summary_archive`.`weekending` <= '" & mySqlToDate & "') " & _
			"UNION ALL " &_
			"SELECT " & _
				"`time_summary_archive`.`id` AS summaryid, " & _
				"`time_summary_archive`.`weekending`, " & _
				"`time_detail_archive`.`created`, " & _
				"`time_summary_archive`.`site`, " & _
				"`time_summary_archive`.`customer`, " & _
				"`time_summary_archive`.`placementid`, " & _
				"`time_summary_archive`.`department`, " & _
				"`time_summary_archive`.`costcenter`, " & _
				"`time_summary_archive`.`cc_description`, " & _
				"`time_summary_archive`.`foruserid`, " & _
				"`time_summary_archive`.`approverid`, " & _
				"`time_detail_archive`.`workday`, " & _
				"`time_detail_archive`.`id`, " & _
				"`time_detail_archive`.`timein`, " & _
				"`time_detail_archive`.`timeout`, " & _
				"(ABS(TIME_TO_SEC(TIMEDIFF(`time_detail_archive`.`timeout`, `time_detail_archive`.`timein`)))/60)/60 as hours " & _
				"" & _
			"FROM time_summary_archive " & _
				"RIGHT JOIN time_detail_archive " & _
					"ON time_summary_archive.id=time_detail_archive.summaryid " & _
				"" & _
					"WHERE `time_summary_archive`.`customer` like " & insert_string(customer) & " AND (`time_detail_archive`.`timeout` > `time_detail_archive`.`timein`  AND " & _
						"`time_summary_archive`.`weekending` >= '" & mySqlFromDate & _
						"' AND `time_summary_archive`.`weekending` <= '" & mySqlToDate & "') " & _
			"UNION ALL " & _
			"SELECT " & _
				"`time_summary_archive`.`id` AS summaryid, " & _
				"`time_summary_archive`.`weekending`, " & _
				"`time_detail_archive`.`created`, " & _
				"`time_summary_archive`.`site`, " & _
				"`time_summary_archive`.`customer`, " & _
				"`time_summary_archive`.`placementid`, " & _
				"`time_summary_archive`.`department`, " & _
				"`time_summary_archive`.`costcenter`, " & _
				"`time_summary_archive`.`cc_description`, " & _
				"`time_summary_archive`.`foruserid`, " & _
				"`time_summary_archive`.`approverid`, " & _
				"`time_detail_archive`.`workday`, " & _
				"`time_detail_archive`.`id`, " & _
				"`time_detail_archive`.`timein`, " & _
				"`time_detail_archive`.`timeout`, " & _

				"(ABS(TIME_TO_SEC(TIMEDIFF(`time_detail_archive`.`timeout`, `time_detail_archive`.`timein`)))/60)/60 as hours " & _
				"" & _
			"FROM time_summary_archive " & _
				"RIGHT JOIN time_detail_archive " & _
					"ON time_summary_archive.id=time_detail_archive.summaryid " & _
				"" & _
				"WHERE `time_summary_archive`.`customer` like " & insert_string(customer) & " AND (`time_detail_archive`.`timeout` < `time_detail_archive`.`timein`  AND " & _
						"`time_summary_archive`.`weekending` >= '" & mySqlFromDate & _
						"' AND `time_summary_archive`.`weekending` <= '" & mySqlToDate & "')) AS t LEFT JOIN tbl_users AS tbl_supervisors ON t.approverid = tbl_supervisors.userid " & _
					"LEFT JOIN tbl_users ON t.foruserid = tbl_users.userid " & _
				
				"ORDER By t.customer, t.site, t.weekending desc, t.department, t.costcenter, tbl_users.lastName, tbl_users.firstName, t.created, t.approverid;"

				REM "`tbl_users`.`lastName`, " & _
				REM "`tbl_users`.`firstName`, " & _			
				
				'print sql
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
			"FROM time_summary_archive " & _
				"RIGHT JOIN time_detail_archive " & _
					"ON time_summary_archive.id=time_detail_archive.summaryid " & _
				"LEFT JOIN tbl_users " & _
					"ON time_summary_archive.foruserid=tbl_users.userid " & _
					"WHERE `time_detail_archive`.`timeout` > `time_detail_archive`.`timein` " & _
									"OR `time_detail_archive`.`timeout` > `time_detail_archive`.`timein`;"

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
		.LoadPlacements(strPlacements)
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
		
		REM setCustomer_cmd.CommandText = "UPDATE time_summary_archive SET customer=" & insert_string(Placement.CustomerCode) & _
						REM "WHERE placementid=" & Placement.PlacementId
		REM setCustomer_cmd.execute()

	next
	
	REM set setCustomer_cmd = nothing
	
	
	
	
Dim g_nPersonId : g_nPersonId = -1
Class cPerson
  Private m_nId
  Private m_sName
  Private m_dtBirth
  Private m_dWage
  Public Function init( sName, dtBirth, dWage )
    Set init    = Me
    g_nPersonId = g_nPersonId + 1
    m_nId       = g_nPersonId
    Name        = sName
    Birth       = dtBirth
    Wage        = dWage
  End Function  
  Public Property Let Name(  sName   ) : m_sName   = sName     : End Property
  Public Property Let Birth( dtBirth ) : m_dtBirth = dtBirth   : End Property
  Public Property Let Wage(  dWage   ) : m_dWage   = dWage     : End Property
  Public Property Get Id()             : Id        = m_nId     : End Property
  Public Property Get Name()           : Name      = m_sName   : End Property
  Public Property Get Birth()          : m_dtBirth = m_dtBirth : End Property
  Public Property Get Wage()           : m_dWage   = m_dWage   : End Property
  Public Function Data()
    Data = Array( m_nId, m_sName, m_dtBirth, m_dWage )
  End Function  
End Class ' cPerson

  REM Dim oAdam : Set oAdam = New cPerson.init( "Adam", #1/5/2001#, 1234.56 )
  REM Dim oEve  : Set oEve  = New cPerson.init( "Eve" , #1/6/2001#, 6543.21 )
  REM Dim oPerson
  REM For Each oPerson In Array( oAdam, oEve )
      REM print Join( oPerson.Data(), " - " )
  REM Next   


	
Function ConvertHoursIntoDecimal(D)
	Dim TB
    if len(D) > 0 then
		TB = Split(D, ":")
		ConvertHoursIntoDecimal = TB(0) + ((TB(1) * 100) / 60) / 100
	end if
End Function

  
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
		
		Case 8 'correct for calling scripts that don't account for Sun being lower than Sat'
            WeekDayLabel = "Sun"

    End Select

End Function
%>