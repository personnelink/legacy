<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%
dim customer, getApplicants_cmd, Applicants, selectedID, applicantID

customer = Replace(Trim(Request.QueryString("customer")), "'", "")
jobStatus = Replace(Trim(Request.QueryString("status")), "'", "")

if jobStatus = 0 then
	imageIcon = "<li><img src=" & Chr(34) & "/include/system/tools/timecards/images/currentPlacements.png" & Chr(34) & "/></li>"
Else
	imageIcon = "<li><img src=" & Chr(34) & "/include/system/tools/timecards/images/pastPlacements.png" & Chr(34) & "/></li>"
end if

Response.write "<ul class='dashboard'>"
if Request.QueryString("isint") = "true" AND jobStatus = 0 then
	Response.write "<li><a href='timecardEmp.asp?timecardID={new}&placementID=0'><ul>"
	Response.write "<li><img src=" & Chr(34) & "/include/system/tools/timecards/images/internalEmployee.png" & Chr(34) & "/></li>"
	Response.write "<li>Personnel Plus</li><li>Internal Employee</li>"
	Response.write "</ul></a></li>"
end if

Set getOrders = Server.CreateObject ("ADODB.Connection")
For Each item In dsnLessTemps
	IF len(item & "") > 0 then
		getOrders_sql = "SELECT WorkCodes.Description, Orders.JobNumber, Orders.JobDescription, Orders.WorkSite1, Orders.WorkSite2 " &_
				"FROM (Orders INNER JOIN WorkCodes ON WorkCodes.WorkCode = Orders.WorkCode1) " &_
				"WHERE Orders.Customer='" & customer & "' AND Orders.JobStatus=" & jobStatus & ";"
		print getOrders_sql
		
		getOrders.Open item
		Set Orders = getOrders.Execute(getOrders_sql)
			
		do while not Orders.eof
			Response.write "<li><a href='timecardEmp.asp?timecardid={new}&companyid=" & Mid(item, 5, 3) & "&joborderid=" & Orders("JobNumber") & "'><ul>" & imageIcon
			Response.write "<li>" & Orders("JobDescription") & "</li><li>" & Orders("Description") & "</li>"
			Response.write "</ul></a></li>"
			Orders.Movenext
		loop
		getOrders.Close
	end if
Next

Set getOrders_cmd = Nothing
Set Orders = Nothing

Response.write "</ul>"

%>
