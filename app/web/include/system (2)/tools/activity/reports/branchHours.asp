<%
 session("add_css") = "reports.css"
session("window_page_title") = "Branch Hours - Personnel Plus"
 %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/jobSearch.js"></script>
<%
if userLevelRequired(userLevelPPlusStaff) = true then

	const begin_year = 1997
	
	Response.Flush
	dim WhichYear
	WhichYear = Request.QueryString("WhichYear")
	WhichYear = Replace(WhichYear, "'", "''")
	if len(WhichYear) = 0 then
		WhichYear = Right(Cstr(Date), 4)
	end if

	' Set WorkYears = Server.CreateObject("ADODB.RecordSet")
	' sqlWorkYears = "SELECT Right([HistoryDetail].[WorkDate],4) AS WorkYear " &_
		' "FROM HistoryDetail " &_
		' "WHERE WorkDate > #1/1/1900# " &_
		' "GROUP BY Right([HistoryDetail].[WorkDate],4);"

	'print sqlWorkYears
	
	' WorkYears.CursorLocation = 3 ' adUseClient
	' WorkYears.Open sqlWorkYears, dsnLessTemps(PER)

'	if Not WorkYears.Eof then
		response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
		response.write "<span>Year:</span>"
'	end if

	dim CurrentWorkYear
	for CurrentWorkYear = begin_year to Year(now)
	
		'CurrentWorkYear = WorkYears("WorkYear")
		response.write "<A HREF=""?WhichYear="& CurrentWorkYear & """>&nbsp;"
		if WhichYear = cstr(CurrentWorkYear) then
			response.write "<span style=""color:red"">" & CurrentWorkYear & "</span>"
		Else
			response.write CurrentWorkYear
		end if
		response.write "&nbsp;</A>"
		'WorkYears.MoveNext
	
		linkNumber = linkNumber + 1
		if linkNumber > 21 then
			linkNumber = 0
			response.write "<br>"
		end if
	next
	response.write("</div>")

	dim thisConnection, getCustomers_cmd, Customers, selectedID, customerID
	dim QueryText, Location(3), queryCache_cmd, getUnFilledJobs_cmd, getWebDescription_cmd, getWebDescription, Jobs, WebDescription
	QueryText = "SELECT DatePart(""ww"",WorkDate) AS WeekEndingDate, HistoryDetail.[WorkDate], DatePart(""yyyy"", HistoryDetail.[WorkDate]) AS WorkYear, " &_
		"Sum(HistoryDetail.[Quantity]) AS SumOfQuantity " &_
		"FROM HistoryDetail " &_
		"WHERE DatePart(""yyyy"", HistoryDetail.[WorkDate]) = '" & WhichYear & "' " &_
		"GROUP BY DatePart(""ww"",[WorkDate]), DatePart(""yyyy"", HistoryDetail.[WorkDate]), WorkDate " &_
		"ORDER BY HistoryDetail.[WorkDate] DESC;"
print QueryText
	Set TwinHours = Server.CreateObject("ADODB.RecordSet")
	TwinHours.CursorLocation = 3 ' adUseClient
	TwinHours.Open QueryText, dsnLessTemps(PER)

	Set BurleyHours = Server.CreateObject("ADODB.RecordSet")
	BurleyHours.CursorLocation = 3 ' adUseClient
	BurleyHours.Open QueryText, dsnLessTemps(BUR)

    Set POcHours = Server.CreateObject("ADODB.RecordSet")
	POcHours.CursorLocation = 3 ' adUseClient
	POcHours.Open QueryText, dsnLessTemps(POC)

	Set BoiseHours = Server.CreateObject("ADODB.RecordSet")
	BoiseHours.CursorLocation = 3 ' adUseClient
	BoiseHours.Open QueryText, dsnLessTemps(BOI)

	Set PPiHours = Server.CreateObject("ADODB.RecordSet")
	PPiHours.CursorLocation = 3 ' adUseClient
	PPiHours.Open QueryText, dsnLessTemps(PPI)

	Set IDaHours = Server.CreateObject("ADODB.RecordSet")
	IDaHours.CursorLocation = 3 ' adUseClient
	IDaHours.Open QueryText, dsnLessTemps(IDA)

	' Position recordset to the correct page
	if Not TwinHours.Eof then TwinHours.AbsolutePage = 1
	if Not BurleyHours.Eof then BurleyHours.AbsolutePage = 1
    if Not POcHours.Eof then POcHours.AbsolutePage = 1
	if Not BoiseHours.Eof then BoiseHours.AbsolutePage = 1
	if Not PPiHours.Eof then PPiHours.AbsolutePage = 1
	if Not IDaHours.Eof then IDaHours.AbsolutePage = 1

	response.write "<table class=""branchHours marLRB10"">" &_
		"<tr>" &_
		"<th colspan=""3"">Twin Falls</th>" &_
		"<th colspan=""3"">Burley</th>" &_
        "<th colspan=""3"">Pocatello</th>" &_
		"<th colspan=""3"">Boise/Nampa</th>" &_
		"<th colspan=""3"">PPI</th>" &_
		"<th colspan=""3"">ID Dept. of Ag.</th>" &_
		"<th colspan=""3"">Company Wide</th>" &_
		"</tr>" &_
		"<tr>" &_
		"<th class=""Week"">Week</th>" &_
		"<th class=""Hours"">Hours</th>" &_
		"<th></th>" &_
		"<th class=""Week"">Week</th>" &_
		"<th class=""Hours"">Hours</th>" &_
		"<th></th>" &_
		"<th class=""Week"">Week</th>" &_
		"<th class=""Hours"">Hours</th>" &_
		"<th></th>" &_
		"<th class=""Week"">Week</th>" &_
		"<th class=""Hours"">Hours</th>" &_
		"<th></th>" &_
		"<th class=""Week"">Week</th>" &_
		"<th class=""Hours"">Hours</th>" &_
		"<th></th>" &_
		"<th class=""Week"">Week</th>" &_
		"<th class=""Hours"">Hours</th>" &_
		"<th></th>" &_
		"</tr>"

	dim HoursBucket(54,1,6), HighestWeek, CurrentWeek, CurrentYear, NextYear, HowManyWeeks, TempDate

	const Twin = 0 : const Burley = 1 : const Poki = 2 : const Boise = 3 : const PPinc = 4: const IdaAg = 5: : const GTotal = 6
	const WeekOf = 0 : const Hours4Week = 1
	const GrandTotal = 54

	do while not TwinHours.eof
		CurrentWeek = CInt(TwinHours("WeekEndingDate"))

		TempDate = CDate("01/01/" & WhichYear) - WeekDay("01/01/" & WhichYear, vbMonday)
		TempDate = TempDate + 7 * CurrentWeek - 1

		iSum = CDbl(TwinHours("SumOfQuantity"))
		HoursBucket(CurrentWeek, WeekOf, Twin) = TempDate
		HoursBucket(CurrentWeek, Hours4Week, Twin) = HoursBucket(CurrentWeek, Hours4Week, Twin) + iSum
		HoursBucket(GrandTotal, Hours4Week, Twin) = HoursBucket(GrandTotal, Hours4Week, Twin) + iSum
		TwinHours.Movenext
	loop

	do while not BurleyHours.eof
		CurrentWeek = CInt(BurleyHours("WeekEndingDate"))

		TempDate = CDate("01/01/" & WhichYear) - WeekDay("01/01/" & WhichYear, vbMonday)
		TempDate = TempDate + 7 * CurrentWeek - 1

		iSum = CDbl(BurleyHours("SumOfQuantity"))
		HoursBucket(CurrentWeek, WeekOf, Burley) = TempDate
		HoursBucket(CurrentWeek, Hours4Week, Burley) = HoursBucket(CurrentWeek, Hours4Week, Burley) + iSum
		HoursBucket(GrandTotal, Hours4Week, Burley) = HoursBucket(GrandTotal, Hours4Week, Burley) + iSum
		BurleyHours.Movenext
	loop

    do while not POcHours.eof
		CurrentWeek = CInt(POcHours("WeekEndingDate"))

		TempDate = CDate("01/01/" & WhichYear) - WeekDay("01/01/" & WhichYear, vbMonday)
		TempDate = TempDate + 7 * CurrentWeek - 1

		iSum = CDbl(POcHours("SumOfQuantity"))
		HoursBucket(CurrentWeek, WeekOf, Poki) = TempDate
		HoursBucket(CurrentWeek, Hours4Week, Poki) = HoursBucket(CurrentWeek, Hours4Week, Poki) + iSum
		HoursBucket(GrandTotal, Hours4Week, Poki) = HoursBucket(GrandTotal, Hours4Week, Poki) + iSum
		POcHours.Movenext
	loop

	do while not BoiseHours.eof
		CurrentWeek = CInt(BoiseHours("WeekEndingDate"))

		TempDate = CDate("01/01/" & WhichYear) - WeekDay("01/01/" & WhichYear, vbMonday)
		TempDate = TempDate + 7 * CurrentWeek - 1

		iSum = CDbl(BoiseHours("SumOfQuantity"))
		HoursBucket(CurrentWeek, WeekOf, Boise) = TempDate
		HoursBucket(CurrentWeek, Hours4Week, Boise) = HoursBucket(CurrentWeek, Hours4Week, Boise) + iSum
		HoursBucket(GrandTotal, Hours4Week, Boise) = HoursBucket(GrandTotal, Hours4Week, Boise) + iSum
		BoiseHours.Movenext
	loop

	do while not PPiHours.eof
		CurrentWeek = CInt(PPiHours("WeekEndingDate"))

		TempDate = CDate("01/01/" & WhichYear) - WeekDay("01/01/" & WhichYear, vbMonday)
		TempDate = TempDate + 7 * CurrentWeek - 1

		iSum = CDbl(PPiHours("SumOfQuantity"))
		HoursBucket(CurrentWeek, WeekOf, PPinc) = TempDate
		HoursBucket(CurrentWeek, Hours4Week, PPinc) = HoursBucket(CurrentWeek, Hours4Week, PPinc) + iSum
		HoursBucket(GrandTotal, Hours4Week, PPinc) = HoursBucket(GrandTotal, Hours4Week, PPinc) + iSum
		PPiHours.Movenext
	loop

	do while not IdaHours.eof
		CurrentWeek = CInt(IdaHours("WeekEndingDate"))

        TempDate = CDate("01/01/" & WhichYear) - WeekDay("01/01/" & WhichYear, vbMonday)
		TempDate = TempDate + 7 * CurrentWeek - 1

		iSum = CDbl(IdaHours("SumOfQuantity"))
        HoursBucket(CurrentWeek, WeekOf, IdaAg) = TempDate
		HoursBucket(CurrentWeek, Hours4Week, IdaAg) = HoursBucket(CurrentWeek, Hours4Week, IdaAg) + iSum
		HoursBucket(GrandTotal, Hours4Week, IdaAg) = HoursBucket(GrandTotal, Hours4Week, IdaAg) + iSum
		IDaHours.Movenext
	loop

	HoursBucket(GrandTotal, Hours4Week, GTotal) = HoursBucket(GrandTotal, Hours4Week, Twin) + HoursBucket(GrandTotal, Hours4Week, Burley) + HoursBucket(GrandTotal, Hours4Week, Poki) + HoursBucket(GrandTotal, Hours4Week, Boise) + HoursBucket(GrandTotal, Hours4Week, PPinc) + HoursBucket(GrandTotal, Hours4Week, IdaAg)

	'Begin Presentation Layer
	for i = 1 to 53
		if Background = "YellowZ" then
			Background = "DarkYellowZ"
			BackgroundNeighbor = "DarkWhiteZ"
		Else
			Background = "YellowZ"
			BackgroundNeighbor = "WhiteZ"
		end if

		HoursBucket(i, Hours4Week, GTotal) = HoursBucket(i, Hours4Week, Twin) + HoursBucket(i, Hours4Week, Burley) + HoursBucket(i, Hours4Week, Poki) + HoursBucket(i, Hours4Week, Boise) + HoursBucket(i, Hours4Week, PPinc) + HoursBucket(i, Hours4Week, IdaAg)

		TempDate = CDate("01/01/" & WhichYear) - WeekDay("01/01/" & WhichYear, vbMonday)
		TempDate = TempDate + 7 * i - 1

		response.write "<tr class=""" & Background & """>" &_
			"<td class=""Week"">" & TempDate & "</td>" &_
			"<td class=""Hours"">" & TwoDecimals(HoursBucket(i, Hours4Week, Twin)) & "</td>" &_
			"<td class=""" & BackgroundNeighbor & """>&nbsp;</td>" &_

			"<td class=""Week"">" & "</td>" &_
			"<td class=""Hours"">" & TwoDecimals(HoursBucket(i, Hours4Week, Burley)) & "</td>" &_
			"<td class=""" & BackgroundNeighbor & """>&nbsp;</td>" &_

            "<td class=""Week"">" & "</td>" &_
			"<td class=""Hours"">" & TwoDecimals(HoursBucket(i, Hours4Week, Poki)) & "</td>" &_
			"<td class=""" & BackgroundNeighbor & """>&nbsp;</td>" &_

			"<td class=""Week"">" & "</td>" &_
			"<td class=""Hours"">" & TwoDecimals(HoursBucket(i, Hours4Week, Boise)) & "</td>" &_
			"<td class=""" & BackgroundNeighbor & """>&nbsp;</td>" &_

			"<td class=""Week"">" & "</td>" &_
			"<td class=""Hours"">" & TwoDecimals(HoursBucket(i, Hours4Week, PPinc)) & "</td>" &_
			"<td class=""" & BackgroundNeighbor & """>&nbsp;</td>" &_

			"<td class=""Week"">" & "</td>" &_
			"<td class=""Hours"">" & TwoDecimals(HoursBucket(i, Hours4Week, IdaAg)) & "</td>" &_
			"<td class=""" & BackgroundNeighbor & """>&nbsp;</td>" &_

			"<td class=""Week"">" & "</td>" &_
			"<td class=""Hours"">" & TwoDecimals(HoursBucket(i, Hours4Week, GTotal)) & "</td>" &_
			"<td class=""" & BackgroundNeighbor & """>&nbsp;</td>" &_

			"</tr>"

		'Empty Buckets
		HoursBucket(i, Hours4Week, Twin) = 0
		HoursBucket(i, Hours4Week, Burley) = 0
        HoursBucket(i, Hours4Week, Poki) = 0
		HoursBucket(i, Hours4Week, Boise) = 0
		HoursBucket(i, Hours4Week, PPinc) = 0
		HoursBucket(i, Hours4Week, IdaAg) = 0
		HoursBucket(i, Hours4Week, GTotal) = 0
	next

	response.write "<tr class=""DarkWhiteZ"">" 'totals

	response.write "<th>Total Hours</th>" &_
		"<td class=""Hours"">" & TwoDecimals(HoursBucket(GrandTotal, Hours4Week, Twin)) & "</td>" &_
		"<td>&nbsp;</td>"
	HoursBucket(i, Hours4Week, Twin) = 0

	response.write "<td>&nbsp;</td>" &_
		"<td class=""Hours"">" & TwoDecimals(HoursBucket(GrandTotal, Hours4Week, Burley)) & "</td>" &_
		"<td>&nbsp;</td>"
    HoursBucket(i, Hours4Week, Burley) = 0

    response.write "<td>&nbsp;</td>" &_
		"<td class=""Hours"">" & TwoDecimals(HoursBucket(GrandTotal, Hours4Week, Poki)) & "</td>" &_
		"<td>&nbsp;</td>"
    HoursBucket(i, Hours4Week, Poki) = 0

	response.write "<td></td>" &_
		"<td class=""Hours"">" & TwoDecimals(HoursBucket(GrandTotal, Hours4Week, Boise)) & "</td>" &_
		"<td>&nbsp;</td>"
	HoursBucket(i, Hours4Week, Boise) = 0

	response.write "<td></td>" &_
		"<td class=""Hours"">" & TwoDecimals(HoursBucket(GrandTotal, Hours4Week, PPinc)) & "</td>" &_
		"<td>&nbsp;</td>"
	HoursBucket(i, Hours4Week, PPinc) = 0

	response.write "<td></td>" &_
		"<td class=""Hours"">" & TwoDecimals(HoursBucket(GrandTotal, Hours4Week, IdaAg)) & "</td>" &_
		"<td>&nbsp;</td>"
	HoursBucket(i, Hours4Week, IdaAg) = 0

	response.write "<td></td>" &_
		"<td class=""Hours"">" & TwoDecimals(HoursBucket(GrandTotal, Hours4Week, GTotal)) & "</td>" &_
		"<td>&nbsp;</td>"
	HoursBucket(i, Hours4Week, GTotal) = 0

Set TwinHours = Nothing
Set BurleyHours = Nothing
Set POcHours = Nothing
Set BoiseHours = Nothing
Set IDaHours = Nothing
Set getTwinHours = Nothing
Set getBurleyHours = Nothing
Set getBoiseHours = Nothing
Set getIDaHours = Nothing

response.write "</table>"

end if
%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->