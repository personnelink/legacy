<!-- #include virtual='/include/system/tools/timecards/group/timecard.classes.asp' -->
<%

Dim mySqlFromDate
Dim mySqlToDate

mySqlFromDate = DatePart("yyyy", fromDate) & "/" & DatePart("m", fromDate) & "/" & DatePart("d", fromDate)
mySqlToDate = DatePart("yyyy", toDate) & "/" & DatePart("m", toDate) & "/" & DatePart("d", toDate)

Dim sql
	sql = "" & _

"select t.* from ( " & _
"SELECT HistoryDetail.Billrate, Sum(HistoryDetail.Quantity) AS SumOfQuantity, Applicants.LastnameFirst, HistoryDetail.Type, HistoryDetail.Payrate,  0 AS SumOfTypeA " & _
"FROM HistoryDetail LEFT JOIN Applicants ON HistoryDetail.[AppId] = Applicants.[ApplicantID] " & _
"WHERE ((([HistoryDetail].[Type]='C' Or [HistoryDetail].[Type]='T')=False) AND ((HistoryDetail.InvoiceDate) Between '" & fromDate & "' And '" & toDate & "')) AND ((HistoryDetail.Type='R' Or HistoryDetail.Type='O')) " & _
"GROUP By LastnameFirst, Billrate, Type, Payrate " & _
"UNION  " & _
"SELECT Sum(CheckHistory.TypeA) AS Billrate, 1 AS SumOfQuantity, Applicants.LastnameFirst, 4 AS Type, Sum(CheckHistory.TypeA) AS Payrate, 0 AS SumOfTypeA " & _
"FROM Applicants LEFT JOIN CheckHistory ON Applicants.ApplicantID = CheckHistory.ApplicantId " & _
"WHERE (((CheckHistory.CheckDate) Between '" & fromDate & "' And '" & toDate & "')) AND CheckHistory.TypeA > 0 " & _
"GROUP By LastnameFirst " & _
") as t " & _
"ORDER By t.LastnameFirst asc, t.Type Desc, t.Payrate asc;"
print sql
REM "SELECT HistoryDetail.Billrate, SUM(HistoryDetail.Quantity) AS SumOfQuantity, Applicants.LastnameFirst, HistoryDetail.Type, HistoryDetail.Payrate " & _
REM "FROM HistoryDetail LEFT JOIN Applicants ON HistoryDetail.[AppId] = Applicants.[ApplicantID] " & _
REM "WHERE ((([HistoryDetail].[Type]='C' Or [HistoryDetail].[Type]='T')=False)) AND ([HistoryDetail].[InvoiceDate] BETWEEN #" & fromDate & "# AND #" & toDate & "#) " & _
REM "GROUP BY Applicants.LastnameFirst, HistoryDetail.Payrate, HistoryDetail.Billrate, HistoryDetail.Type;"

REM Dim sql
REM sql = "" & _
REM "select lastnamefirst, applicantid, count(week) as [Number of Weeks Worked] " & _
REM "from (select datepart(""yyyy"",checkdate) , datepart(""ww"",checkdate) as week, " & _
REM "applicants.applicantid, applicants.lastnamefirst " & _
REM "from checkhistory left join applicants on applicants.applicantid=checkhistory.applicantid " & _
REM "where checkhistory.applicantid in (select distinct appid from historydetail where historydetail.workdate between #" & fromDate & "# and #" & toDate & "#) " & _
REM "group by datepart(""yyyy"",checkdate) , datepart(""ww"",checkdate), checkhistory.applicantid, applicants.applicantid, applicants.lastnamefirst) group by lastnamefirst, applicantid"

Dim cmd
	set cmd = server.CreateObject("ADODB.Command")

	with cmd
		.ActiveConnection = dsnLessTemps(IDA)
		.CommandText = sql
	end with

Dim rs
	set rs = cmd.execute()

REM dim rsPlacements
REM cmd.CommandText = "" & _
REM "SELECT DISTINCT placementid " & _
REM "FROM time_summary_archive " & _
REM "RIGHT JOIN time_detail_archive " & _
REM "ON time_summary_archive.id=time_detail_archive.summaryid " & _
REM "LEFT JOIN tbl_users " & _
REM "ON time_detail_archive.creatorid=tbl_users.userid " & _
REM "WHERE `time_detail_archive`.`timeout` > `time_detail_archive`.`timein` " & _
REM "OR `time_detail_archive`.`timeout` > `time_detail_archive`.`timein`;"

REM set rsPlacements = cmd.execute()

REM dim strPlacements, strBuffer
REM do until rsPlacements.eof
REM strBuffer = rsPlacements("placementid")
REM if len(strBuffer) > 0 then
REM strPlacements = strPlacements & strBuffer & ","
REM end if
REM rsPlacements.movenext
REM loop

REM strPlacements = left(strPlacements, len(strPlacements)-1) ' remove trailing comma

REM dim Placements
REM set Placements = new cPlacements
REM with Placements
REM .ItemsPerPage = 1500
REM .Page = Request.QueryString("WhichPage")
REM ' .Company = Request.QueryString("whichCompany")
REM ' .Customer = Request.QueryString("WhichCustomer")
REM '.Order = GetParameter("id")
REM .Applicant = Request.QueryString("whichApplicant")
REM .FromDate = fromDate
REM .ToDate = toDate
REM .LoadPlacements(strPlacements)
REM end with

REM dim BillRate, CostCenter, CustomerCode, Department
REM set BillRate = Server.CreateObject ("Scripting.Dictionary")
REM set CostCenter = Server.CreateObject ("Scripting.Dictionary")
REM set CustomerCode = Server.CreateObject ("Scripting.Dictionary")
REM set Department = Server.CreateObject ("Scripting.Dictionary")

REM dim Placement
REM for each Placement in Placements.Placements.Items
REM BillRate.Add Placement.PlacementId, Placement.RegBillRate
REM CostCenter.Add Placement.PlacementId, Placement.WCDescription
REM CustomerCode.Add Placement.PlacementId, Placement.CustomerCode
REM Department.Add Placement.PlacementId, Placement.WCDescription
REM next

REM Function WeekDayLabel(daynumber)

REM Select Case daynumber

REM Case 1
REM WeekDayLabel = "Sun"

REM Case 2
REM WeekDayLabel = "Mon"

REM Case 3
REM WeekDayLabel = "Tue"

REM Case 4
REM WeekDayLabel = "Wed"

REM Case 5
REM WeekDayLabel = "Thu"

REM Case 6
REM WeekDayLabel = "Fri"

REM Case 7
REM WeekDayLabel = "Sat"

REM End Select

REM End Function

Function HoursType(hType)

    Select Case lcase(hType)
        Case "r"
            HoursType = "Regular"
        Case "o"
            HoursType = "Overtime"
        Case "4"
            HoursType = "Mileage"
        Case Else
            HoursType = ""

    End Select

End Function

%>