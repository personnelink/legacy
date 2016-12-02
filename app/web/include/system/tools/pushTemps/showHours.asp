<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%
dim thisConnection, getCustomers_cmd, Customers, selectedID, customerID

dim QueryText, Location(3), queryCache_cmd, getUnFilledJobs_cmd, getWebDescription_cmd, getWebDescription, Jobs, WebDescription

dim rsQuery, WhatYear
rsQuery = request.serverVariables("QUERY_STRING")
WhatYear = Request.QueryString("WhichYear")
response.write "WhatYear : " & WhatYear
if len(WhatYear) = 0 then
	WhatYear = Right(Cstr(Date), 4)
end if

if WhatYear then
	rsQuery = Replace(rsQuery, "Year=" & WhatYear & "&", "")
end if


QueryText = "SELECT DatePart(""ww"",[WorkDate]) AS WeekEndingDate, HistoryDetail.WorkDate, Right(HistoryDetail.WorkDate,4) AS WorkYear, " &_
	"Sum(HistoryDetail.Quantity) AS SumOfQuantity " &_
	"FROM HistoryDetail " &_
	"WHERE Right(HistoryDetail.WorkDate, 4) = """ & WhatYear & """ " &_ 
	"GROUP BY DatePart(""ww"",[WorkDate]), Right(HistoryDetail.WorkDate, 4), WorkDate " &_ 
	"ORDER BY HistoryDetail.WorkDate DESC;"

'Break QueryText

Set TwinHours = Server.CreateObject("ADODB.RecordSet")
TwinHours.CursorLocation = 3 ' adUseClient
TwinHours.Open QueryText, dsnLessTemps(PER)

Set BurleyHours = Server.CreateObject("ADODB.RecordSet")
BurleyHours.CursorLocation = 3 ' adUseClient
BurleyHours.Open QueryText, dsnLessTemps(BUR)

Set BoiseHours = Server.CreateObject("ADODB.RecordSet")
BoiseHours.CursorLocation = 3 ' adUseClient
BoiseHours.Open QueryText, dsnLessTemps(BOI)

Set IDaHours = Server.CreateObject("ADODB.RecordSet")
IDaHours.CursorLocation = 3 ' adUseClient
IDaHours.Open QueryText, dsnLessTemps(IDA)
	

	Set WorkYears = Server.CreateObject("ADODB.RecordSet")
	sqlWorkYears = "SELECT Right([HistoryDetail].[WorkDate],4) AS WorkYear " &_
		"FROM HistoryDetail " &_
		"GROUP BY Right([HistoryDetail].[WorkDate],4);"
	
	WorkYears.CursorLocation = 3 ' adUseClient
	WorkYears.Open sqlWorkYears, dsnLessTemps(PER)

	if Not WorkYears.Eof then
		response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
		response.write "<A HREF=""branchHours.asp?Year=" & WorkYears("WorkYear") & """>First</A>"
	end if
	
	dim CurrentWorkYear
	do while not WorkYears.Eof
		CurrentWorkYear = WorkYears("WorkYear")
		response.write "<A HREF=""?Year="& CurrentWorkYear & "&" & """>&nbsp;"
		if WhatYear = CurrentWorkYear then
			response.write "<span style=""color:red"">" & CurrentWorkYear & "</span>"
		Else
			response.write CurrentWorkYear
		end if
		response.write "&nbsp;</A>"
		WorkYears.MoveNext
	loop
	response.write "<A HREF=""?Page=" & nPageCount & """>Last</A>"
	response.write("</div>")

	' Position recordset to the correct page
	TwinHours.AbsolutePage = 1
	BurleyHours.AbsolutePage = 1
	BoiseHours.AbsolutePage = 1
	IDaHours.AbsolutePage = 1

	response.write "<table class=""branchHours marLRB10"">" &_
		"<tr>" &_
		"<th colspan=""3"">Twin Falls</th>" &_
		"<th colspan=""3"">Burley</th>" &_
		"<th colspan=""3"">Boise/Nampa</th>" &_
		"<th colspan=""3"">ID Dept. of Ag.</th>" &_
		"</tr>" &_
		"<tr>" &_
		"<th>Week</th>" &_
		"<th>Hours</th>" &_
		"<th></th>" &_
		"<th>Week</th>" &_
		"<th>Hours</th>" &_
		"<th></th>" &_
		"<th>Week</th>" &_
		"<th>Hours</th>" &_
		"<th></th>" &_
		"<th>Week</th>" &_
		"<th>Hours</th>" &_
		"<th></th>" &_
		"</tr><tr>"
	
	dim HoursBucket(53,1,3), HighestWeek, CurrentWeek, CurrentYear, NextYear, HowManyWeeks
	
	const Twin = 0 : const Burley = 1 : const Boise = 2 : const IdaAg = 3
	const WeekOf = 0 : const Hours4Week = 1

	do while not TwinHours.eof
		CurrentWeek = CInt(TwinHours("WeekEndingDate"))
		HoursBucket(CurrentWeek, WeekOf, Twin) = TwinHours("WorkDate")
		HoursBucket(CurrentWeek, Hours4Week, Twin) = HoursBucket(CurrentWeek, Hours4Week, Twin) + CDbl(TwinHours("SumOfQuantity"))
		TwinHours.Movenext
	loop
	
	do while not BurleyHours.eof
		CurrentWeek = CInt(BurleyHours("WeekEndingDate"))
		HoursBucket(CurrentWeek, WeekOf, Burley) = BurleyHours("WorkDate")
		HoursBucket(CurrentWeek, Hours4Week, Burley) = HoursBucket(CurrentWeek, Hours4Week, Burley) + CDbl(BurleyHours("SumOfQuantity"))
		BurleyHours.Movenext
	loop

	do while not BoiseHours.eof
		CurrentWeek = CInt(BoiseHours("WeekEndingDate"))
		HoursBucket(CurrentWeek, WeekOf, Boise) = BoiseHours("WorkDate")
		HoursBucket(CurrentWeek, Hours4Week, Boise) = HoursBucket(CurrentWeek, Hours4Week, Boise) + CDbl(BoiseHours("SumOfQuantity"))
		BoiseHours.Movenext
	loop

	do while not IdaHours.eof
		CurrentWeek = CInt(IdaHours("WeekEndingDate"))
		HoursBucket(CurrentWeek, WeekOf, IdaAg) = IdaHours("WorkDate")
		HoursBucket(CurrentWeek, Hours4Week, IdaAg) = HoursBucket(CurrentWeek, Hours4Week, IdaAg) + CDbl(IdaHours("SumOfQuantity"))
		IDaHours.Movenext
	loop
		
'presentation layer
for i = 53 to 1 step -1
	response.write "<tr>" 'new row
	
	response.write "<td class=""twinfalls""> " & HoursBucket(i, WeekOf, Twin) & "</td>" &_
		"<td class=""alignR twinfalls"">" & TwoDecimals(HoursBucket(i, Hours4Week, Twin)) & "</td>" &_
		"<td class=""twinfalls"">&nbsp;</td>"	
	HoursBucket(i, 1, Twin) = 0

	response.write "<td class=""burley"">" & HoursBucket(i, WeekOf, Burley) & "</td>" &_
		"<td class=""alignR burley"">" & TwoDecimals(HoursBucket(i, Hours4Week, Burley)) & "</td>" &_
		"<td class=""burley"">&nbsp;</td>"

	HoursBucket(w, Hours4Week, Burley) = 0

	response.write "<td class=""boise"">" & HoursBucket(i, WeekOf, Boise) & "</td>" &_
		"<td class=""alignR boise"">" & TwoDecimals(HoursBucket(i, Hours4Week, Boise)) & "</td>" &_
		"<td class=""boise"">&nbsp;</td>"
	HoursBucket(i, Hours4Week, Boise) = 0

	response.write "<td class=""ida"">" & HoursBucket(i, WeekOf, IdaAg) & "</td>" &_
		"<td class=""alignR ida"">" & TwoDecimals(HoursBucket(i, Hours4Week, IdaAg)) & "</td>" &_
		"<td class=""ida"">&nbsp;</td>"
	HoursBucket(i, Hours4Week, IdaAg) = 0
next
	
Set TwinHours = Nothing
Set BurleyHours = Nothing
Set BoiseHours = Nothing
Set IDaHours = Nothing
Set getTwinHours = Nothing
Set getBurleyHours = Nothing
Set getBoiseHours = Nothing
Set getIDaHours = Nothing

response.write "</table>"
%>
