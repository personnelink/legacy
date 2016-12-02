<%
session("no_cache") = true
session("required_user_level") = 1024 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->
<%
dim thisConnection, getCustomers_cmd, Customers, selectedID, customerID, shading, lastnamefirst
dim QueryText, location, queryCache_cmd, getUnFilledJobs_cmd, getWebDescription_cmd, getWebDescription, Jobs, WebDescription
dim i, dayTimeInfo, WeekTimeInfo, dayTimeTotal(6), dayOtherTime(6), dayOtherTimeType(6), TimecardInfo
dim applicantid

const inTime = 0, luoutTime = 1, luinTime = 2, outTime = 3, regularTime = 4, otherTime = 5, otherTypeTime = 6
dim getCompanyRecord, CompanyRecord, Customer, Weekends, Site
Set getCompanyRecord = Server.CreateObject("ADODB.Command")
With getCompanyRecord
	.ActiveConnection = MySql
	dim qs_customer_code
	qs_customer_code = Replace(Request.QueryString("customer"), "'", "''")
	.CommandText = "SELECT * FROM tbl_companies WHERE Customer='" & qs_customer_code & "'"
End With
Set CompanyRecord = getCompanyRecord.Execute

if Not CompanyRecord.eof then
	Customer = CompanyRecord("Customer")
	Weekends = CompanyRecord("weekends")
	Site = CompanyRecord("site")

else
	response.write "<p id=""code_not_set"">Customer account code " &_
		qs_customer_code &_
		" has not been associated yet.<br><br>Associations can be managed using the " &_
		"<a href=""/include/system/tools/manage/customer/associations/"">Manage Customer Associations</a> tool.<br><br></p>"
end if

set CompanyRecord = Nothing
set getCompanyRecord = Nothing

dim customer_condition, masquerade_as

if g_company_custcode.CustomerCode = "PERSON" then
	Customer = Request.QueryString("customer")
	if Customer = "ALL" then
		customer_condition = "JobStatus<4;"
	else
		customer_condition = "JobStatus<4 AND (Customer=""" & Customer & """);"
	end if
	
	Site = getTempsDSN(Request.QueryString("company"))

	masquerade_as = Request.QueryString("masquerade")
	if len(masquerade_as) > 0 and masquerade_as <> "ALL"then
		customer_condition = "JobStatus<4 AND (Customer=""" & masquerade_as & """);"
	end if
else
	customer_condition = "JobStatus<4 AND (Customer=""" & Customer & """);"
end if
	
sqlGetOrders = "SELECT Customer, PurchaseOrder, JobNumber, JobDescription, WorkSite1, WorkSite2, Reference " &_
	"FROM Orders " &_
	"WHERE " & customer_condition

Set getOrders_cmd = Server.CreateObject("ADODB.Command")
Set getPlacements_cmd = Server.CreateObject("ADODB.Command")
Set getTimecards_cmd = Server.CreateObject("ADODB.Command")
getTimecards_cmd.ActiveConnection = MySql

getPlacements_cmd.ActiveConnection = dsnLessTemps(Site)
ThisSession = Session.SessionID

	'getOpenJobOrders_cmd.Open dsnLessTemps(location)
	With getOrders_cmd
		.ActiveConnection = dsnLessTemps(Site)
		.CommandText = sqlGetOrders
	End With
	Set Orders = getOrders_cmd.Execute
	Do Until Orders.eof

		sqlGetPlacements = "SELECT Placements.Reference, Placements.PlacementID, Applicants.ApplicantID, " &_
			"Placements.EmployeeNumber, Applicants.LastnameFirst, Applicants.EmailAddress, " &_
			"Placements.RegPayRate " &_
			"FROM Applicants INNER JOIN Placements ON Applicants.ApplicantID = Placements.ApplicantId " &_
			"WHERE (Placements.Reference=" & Orders("Reference") & ") AND Placements.PlacementStatus<2 " &_
			"ORDER By Placements.EmployeeNumber ASC;"
	
		'break sqlGetPlacements
		
		getPlacements_cmd.CommandText = sqlGetPlacements

		dim strJobOrderDescript
		dim OrderJobReference
		dim OrderJobNumber
		Set Placements = getPlacements_cmd.Execute
			if Not Placements.eof then
				OrderJobReference = Orders("Reference")
				OrderJobNumber = Orders("JobNumber")
				strJobOrderDescript = Orders("JobDescription")
				response.write "<table class='JobOrderDetails'>" &_
						"<tr>" &_
							"<th class=""jobdescription"">Description</th>" &_
							"<th class=""jobnumber"">Job#</th>" &_
							"<th class=""jobreference"">Ref#</th>" &_
							"<th class=""jobworksite"">Work Site</th>" &_
						"</tr>" &_
						"<tr>" &_
							"<td>" &_
							"<input class=""JobOrderDescription"" type=""text"" name=""Order" & OrderJobReference & """ value=""" & strJobOrderDescript & """ />" &_
							"<input name=""Order" & OrderJobReference & ".Ref"" type=""hidden"" value=""" & strJobOrderDescript & """ /></td>" &_
							"<td>" & OrderJobNumber & "</td>" &_
							"<td>" & OrderJobReference & "</td>" &_
							"<td>" & Orders("WorkSite1") & "<br />" & Orders("WorkSite2") & "</td>" &_
						"</tr>" &_
						"</table>"
			
				Response.write "<table class='JobPlacements'><tr>"
				response.write "<th class='lf'>Employee</th>"
				response.write "<th>Pay</th>"
				response.write "<th class='we'>Week Ending</th>"
				
				For i = 1 To 7
					whatDay = Weekends + i
					if whatDay > 7 then whatDay = whatDay - 7
					response.write "<th class='dow'>" & Left(WeekdayName(whatDay), 3) & "</th>"
				Next
				
				response.write "<th class='wt'>Total</th>"
				response.write "<th class='comment'>Comments</th></tr>"
			
				Do Until Placements.eof
					'Placement detail
	
					'Timecard operations
					PlacementID = Placements("PlacementID")
					lastnamefirst = Placements("LastnameFirst")
					getTimecards_cmd.CommandText = "SELECT timecardID, weekending, comments, timeinfo " &_
						"FROM tbl_timecards " &_
						"WHERE placementID=" & PlacementID & " " &_
						"ORDER By weekending;"
					Set Timecards = getTimecards_cmd.Execute
					Do
						if Not Timecards.eof then
							comment = Timecards("comments")
							WeekEnding = Timecards("weekending")
							TimeInfo = Timecards("timeinfo")
							insertTimeSpace
							Timecards.Movenext
						end if
					loop Until Timecards.eof	
					WeekEnding = getWeekendDate(Date)
					insertTimeSpace
					Placements.Movenext
				loop
			Response.write "</table>"
			response.Flush()
		end if		
		Orders.Movenext
	loop
Set Orders = Nothing
Set Placements = Nothing
Set Timecards = Nothing

Set getOrders_cmd = Nothing
Set getPlacements_cmd = Nothing
Set getTimecards_cmd = Nothing

Sub insertTimeSpace
	dim displayname, maintain_link
	const resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"

	if len(TimeInfo & "") > 0 then
		totalOfDays = 0
		WeekTimeInfo = Split(TimeInfo, ";")
		For i = 0 to 6
			dayTimeTotal(i) = 0
			dayTimeInfo = Split(WeekTimeInfo(i), ",")
			valTimeIn = CLng(dayTimeInfo(inTime))
			valTimeOut = CLng(dayTimeInfo(outTime))
			lunchIn = CLng(dayTimeInfo(luinTime))
			lunchOut = CLng(dayTimeInfo(luoutTime))
			valTimeRegular = CLng("0" & dayTimeInfo(regularTime))
			
			dayTimeTotal(i) = (valTimeOut - valTimeIn) - (lunchIn - lunchOut)
			if dayTimeTotal(i) < valTimeRegular then dayTimeTotal(i) = valTimeRegular
			dayOtherTime(i) = dayTimeInfo(otherTime) 'Needs place added in table
			dayOtherTimeType(i) = dayTimeInfo(otherTypeTime) 'Needs place added in table
			totalOfDays = totalOfDays + dayTimeTotal(i)
		Next
		Erase WeekTimeInfo
		Erase DayTimeInfo
 	end if
	
	'Shade every other row
	if shading = "odd" then
		shading = "even"
	Else
		shading = "odd"
	end if

	maintain_link = "<a href=""" & resourcelink & "who=" & applicantid & "&where=" & whichCompany & """>" &_
					applicantid & " : " & lastnamefirst
					
	response.write "<tr class=""" & shading & """>" &_
				"<td class='lastnamefirst'>" & maintain_link & "</td>" &_
				"<td class=''>$" & TwoDecimals(Placements("RegPayRate")) & "</td>" &_
				"<td class=''><input type='text' class='weekending' name='" & PlacementID & ".weekending' value='" & WeekEnding & "'></td>" &_
				"<td class='dayofweek'><input type='text' class='' name='" & PlacementID & ".day.1' value='" & dayTimeTotal(0) & "'></td>" &_
				"<td class='dayofweek'><input type='text' class='' name='" & PlacementID & ".day.2' value='" & dayTimeTotal(1) & "'></td>" &_
				"<td class='dayofweek'><input type='text' class='' name='" & PlacementID & ".day.3' value='" & dayTimeTotal(2) & "'></td>" &_
				"<td class='dayofweek'><input type='text' class='' name='" & PlacementID & ".day.4' value='" & dayTimeTotal(3) & "'></td>" &_
				"<td class='dayofweek'><input type='text' class='' name='" & PlacementID & ".day.5' value='" & dayTimeTotal(4) & "'></td>" &_
				"<td class='dayofweek'><input type='text' class='' name='" & PlacementID & ".day.6' value='" & dayTimeTotal(5) & "'></td>" &_
				"<td class='dayofweek'><input type='text' class='' name='" & PlacementID & ".day.7' value='" & dayTimeTotal(6) & "'></td>" &_
				"<td class=''><input type='text' class='weektotal' name='" & PlacementID & ".total' value='" & totalOfDays & "'></td>" &_
				"<td class=''><textarea class='comment' name='" & PlacementID & ".comments'>" & comment & "</textarea></td>" &_
				"</tr>"
	
	
	TimeInfo = ""
	Erase dayTimeTotal
	totalOfDays = ""

	comment = ""
End Sub

Function getWeekendDate (DateSeed)
	'Today
	Select Case Weekday(DateSeed)
	Case vbMonday
		Today = 0
	Case vbTuesday  
		Today = 1
	Case vbWednesday  
		Today = 2
	Case vbThursday  
		Today = 3
	Case vbFriday  
		Today = 4
	Case vbSaturday  
		Today = 5
	Case vbSunday 
		Today = 6
	End Select
	
	'Company Weekending Date
	Select Case Weekends
	Case vbMonday
		WeekendsOn = 0
	Case vbTuesday  
		WeekendsOn = 1
	Case vbWednesday  
		WeekendsOn = 2
	Case vbThursday  
		WeekendsOn = 3
	Case vbFriday  
		WeekendsOn = 4
	Case vbSaturday  
		WeekendsOn = 5
	Case vbSunday 
		WeekendsOn = 6
	End Select
	
	if Today > WeekendsOn then
		getWeekendDate = DateAdd("d", WeekendsOn + (7 - Today), DateSeed)
	Else
		getWeekendDate = DateAdd("d", WeekendsOn - Today, DateSeed)
	end if
End Function
%>
