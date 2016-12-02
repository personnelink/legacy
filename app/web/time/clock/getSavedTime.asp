<%
Response.Expires = -1
Response.ExpiresAbsolute = Now() -1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"

session("no_cache") = true %>

<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%
dim userID, imageIcon

userID = Replace(Trim(Request.Querystring("id")), "'", "")
imageIcon = "<li><img src=" & Chr(34) & "/include/system/tools/timecards/images/savedTime.png" & Chr(34) & "/></li>"
imageInternalIcon = "<li><img src=" & Chr(34) & "/include/system/tools/timecards/images/savedInternalTime.png" & Chr(34) & "/></li>"

Set getTimecards_cmd = Server.CreateObject ("ADODB.Command")
With getTimecards_cmd
	.ActiveConnection = MySql
	.CommandText = "SELECT timecardID, weekending, placementID, tempsID FROM tbl_timecards WHERE userID='" & userID & "' AND (status='o' or status='r') Order By weekending DESC"
	.Prepared = true
End With
Set Timecards = getTimecards_cmd.Execute

Set getPlacementDetail_cmd = Server.CreateObject("ADODB.Command")

Response.write "<ul class='dashboard'>"

if Timecards.eof then response.write "No timecards found. Select a current or past placement to get started."
do while not Timecards.eof
	'Retrieve placement detail

	if len(Timecards("tempsID") & "") > 0 then
		With getPlacementDetail_cmd
		.ActiveConnection = dsnLessTemps(CInt(Timecards("tempsID")))
		.CommandText = "SELECT WorkCodes.Description, Customers.CustomerName, Placements.PlacementID " &_
			"FROM (WorkCodes INNER JOIN Placements ON WorkCodes.WorkCode = Placements.WorkCode) INNER JOIN Customers ON Placements.Customer = Customers.Customer " &_
			"WHERE ((Placements.PlacementID=" & Timecards("placementID") & "));"
		.Prepared = true
		End With
		Set Placements = getPlacementDetail_cmd.Execute
		
		if Not Placements.eof then
			Response.write "<li><a href='timecardEmp.asp?timecardID=" & Timecards("timecardID") & "'><ul>" & imageIcon
			Response.write "<li>" & Timecards("weekending") & "</li><li>" & Placements("CustomerName") & "</li><li>" & Placements("Description") & "</li></ul></a></li>"
		end if
	Else
		Response.write "<li><a href='timecardEmp.asp?timecardID=" & Timecards("timecardID") & "'><ul>" & imageInternalIcon
		Response.write "<li>" & Timecards("weekending") & "</li><li>Personnel Plus</li><li>Internal Employee</li></ul></a></li>"
	end if
		
	Timecards.Movenext
loop
Response.write "</ul>"
	
Set getTimecards_cmd = Nothing
Set Timecards = Nothing
Set getPlacementDetail_cmd = Nothing
Set Placements = Nothing

%>
