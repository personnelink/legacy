<%
Response.Expires = -1
Response.ExpiresAbsolute = Now() -1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>

<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%
dim empcode, getApplicants_cmd, Applicants, selectedID, applicantID

empcode = Replace(Trim(Request.QueryString("empcode")), "'", "")
placedStatus = Replace(Trim(Request.QueryString("status")), "'", "")

'if placedStatus = 0 then
'	imageIcon = "<li><img src=" & Chr(34) & "/include/system/tools/timecards/images/currentPlacements.png" & Chr(34) & "/></li>"
'Else
'	imageIcon = "<li><img src=" & Chr(34) & "/include/system/tools/timecards/images/pastPlacements.png" & Chr(34) & "/></li>"
'end if

Response.write "<ul class='dashboard'>"
'if Request.QueryString("isint") = "true" AND placedStatus = 0 then
	Response.write "<li><a href='timecardEmp.asp?timecardID={new}&placementID=0'><ul>"
	Response.write "<li><img src=" & Chr(34) & "/include/system/tools/timecards/images/internalEmployee.png" & Chr(34) & "/></li>"
	Response.write "<li>Create</li><li>New Timecard</li>"
	Response.write "</ul></a></li>"
'end if

'Set getPlacements = Server.CreateObject ("ADODB.Connection")
'For Each item In dsnLessTemps
'	IF len(item & "") > 0 then
'		getPlacements_sql = "SELECT WorkCodes.Description, Customers.CustomerName,  Placements.PlacementID " &_
'				"FROM (WorkCodes INNER JOIN Placements ON WorkCodes.WorkCode = Placements.WorkCode) INNER JOIN Customers ON Placements.Customer = Customers.Customer " &_
'				"WHERE ((Placements.PlacementStatus=" & placedStatus & " AND Placements.EmployeeNumber='" & empcode & "'));"
'		getPlacements.Open item
'		Set Placements = getPlacements.Execute(getPlacements_sql)
'			
'		do while not Placements.eof
'			Response.write "<li><a href='timecardEmp.asp?timecardid={new}&companyid=" & Mid(item, 5, 3) & "&placementID=" & Placements("PlacementID") & "'><ul>" & imageIcon
'			Response.write "<li>" & Placements("CustomerName") & "</li><li>" & Placements("Description") & "</li>"
'			Response.write "</ul></a></li>"
'			Placements.Movenext
'		loop
'		getPlacements.Close
'	end if
'Next
'Set getPlacements_cmd = Nothing
'Set Placements = Nothing

Response.write "</ul>"
%>
