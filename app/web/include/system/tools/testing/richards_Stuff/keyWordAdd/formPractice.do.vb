<!-- #include virtual='/include/system/tools/timecards/group/timecard.classes.asp' -->
<%

Dim sql
	sql = "" &_
		"SELECT " &_
			"`created`, " &_
			"`placementid`, " &_
			"`creatorid`, " &_
			"`workday`, " &_
			"`timein`, " &_
			"`timeout`, " &_
			"`lastName`, " &_
			"`firstName`, " &_
			" `hours` " &_
		"FROM " &_
			"(SELECT " &_
				"`time_summary_archive`.`created`, " &_
				"`time_summary_archive`.`placementid`, " &_
				"`time_summary_archive`.`creatorid`, " &_
				"`time_detail_archive`.`workday`, " &_
				"`time_detail_archive`.`timein`, " &_
				"`time_detail_archive`.`timeout`, " &_
				"`tbl_users`.`lastName`, " &_
				"`tbl_users`.`firstName`, " &_
				"(ABS(TIME_TO_SEC(TIMEDIFF(`time_detail_archive`.`timeout`, `time_detail_archive`.`timein`)))/60)/60 as hours " &_
				"" &_
			"FROM time_summary_archive " &_
				"RIGHT JOIN time_detail_archive " &_
					"ON time_summary_archive.id=time_detail_archive.summaryid " &_
				"LEFT JOIN tbl_users " &_
					"ON time_detail_archive.creatorid=tbl_users.userid " &_
					"WHERE `time_detail_archive`.`timeout` > `time_detail_archive`.`timein` " &_
			"UNION ALL " &_
			"SELECT " &_
				"`time_summary_archive`.`created`, " &_
				"`time_summary_archive`.`placementid`, " &_
				"`time_summary_archive`.`creatorid`, " &_
				"`time_detail_archive`.`workday`, " &_
				"`time_detail_archive`.`timein`, " &_
				"`time_detail_archive`.`timeout`, " &_
				"`tbl_users`.`lastName`, " &_
				"`tbl_users`.`firstName`, " &_
				"(ABS(TIME_TO_SEC(TIMEDIFF(`time_detail_archive`.`timeout`, `time_detail_archive`.`timein`)))/60)/60 as hours " &_
				"" &_
			"FROM time_summary_archive " &_
				"RIGHT JOIN time_detail_archive " &_
					"ON time_summary_archive.id=time_detail_archive.summaryid " &_
				"LEFT JOIN tbl_users " &_
					"ON time_detail_archive.creatorid=tbl_users.userid " &_
				"WHERE `time_detail_archive`.`timeout` > `time_detail_archive`.`timein`) AS t " &_
				"ORDER By t.lastName, t.firstName, t.created;"


Dim cmd
	set cmd = server.CreateObject("ADODB.Command")

	with cmd
		.ActiveConnection = MySql
		.CommandText = sql
	end with

Dim rs
	set rs = cmd.execute()
	
dim rsPlacements
	cmd.CommandText = "" &_
		"SELECT DISTINCT placementid " &_
			"FROM time_summary_archive " &_
				"RIGHT JOIN time_detail_archive " &_
					"ON time_summary_archive.id=time_detail_archive.summaryid " &_
				"LEFT JOIN tbl_users " &_
					"ON time_detail_archive.creatorid=tbl_users.userid " &_
					"WHERE `time_detail_archive`.`timeout` > `time_detail_archive`.`timein` " &_
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
	
	
	dim BillRate, CostCenter, CustomerCode, Department
	set BillRate = Server.CreateObject ("Scripting.Dictionary")
	set CostCenter = Server.CreateObject ("Scripting.Dictionary")
	set CustomerCode = Server.CreateObject ("Scripting.Dictionary")
	set Department = Server.CreateObject ("Scripting.Dictionary")

	dim Placement
	for each Placement in Placements.Placements.Items
		BillRate.Add Placement.PlacementId, Placement.RegBillRate
		CostCenter.Add Placement.PlacementId, Placement.WCDescription
		CustomerCode.Add Placement.PlacementId, Placement.CustomerCode
		Department.Add Placement.PlacementId, Placement.JobNumber
	next
	
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