<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%
dim imageIcon

companyID = Replace(Trim(Request.Querystring("id")), "'", "")
'imageIcon = "<li><img src=""/include/system/tools/timecards/images/savedTime.png""/></li>"
imageIcon = ""
imageInternalIcon = "<li><img src=" & Chr(34) & "/include/system/tools/timecards/images/savedInternalTime.png" & Chr(34) & "/></li>"

Set getTimecards_cmd = Server.CreateObject ("ADODB.Command")
With getTimecards_cmd
	.ActiveConnection = MySql
	.CommandText = "SELECT DISTINCT tbl_timecards.weekending FROM tbl_timecards " &_
		"WHERE tbl_timecards.companyID=" & companyID & " ORDER By weekending DESC"
	.Prepared = true
End With
'break getTimecards_cmd.CommandText

Set Timecards = getTimecards_cmd.Execute

Response.write "<ul class='weekending'>"

if Timecards.eof then response.write "No saved timecards found."
dim weekending
do while not Timecards.eof
	weekending = Timecards("weekending")
	Response.write "<li><a href='/include/system/tools/timecards/showTimeDetail.asp?week=" & weekending &_
		"'><span>" & right(weekending, 4) & "</span><br />" & left(weekending, len(weekending)-5) & "</a></li>"
	Timecards.Movenext
loop
Response.write "</ul>"
	
Set getTimecards_cmd = Nothing
Set Timecards = Nothing

%>
