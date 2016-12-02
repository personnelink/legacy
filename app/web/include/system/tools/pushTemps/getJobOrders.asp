<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%
dim thisConnection, getCustomers_cmd, Customers, selectedID, customerID

Select Case Replace(Trim(Request.QueryString("companyid")), "'", "")
Case "PER"
	thisConnection = dsnLessTemps(PER)
Case "BUR"
	thisConnection = dsnLessTemps(BUR)
Case "BOI"
	thisConnection = dsnLessTemps(BOI)
Case Else
	Response.End()
End Select

Set getWorkCodeDescription_cmd = Server.CreateObject("ADODB.Command")
With getWorkCodeDescription_cmd
	.ActiveConnection = thisConnection
End With

Set getWebDescription_cmd = Server.CreateObject("ADODB.Command")
With getWebDescription_cmd
	.ActiveConnection = thisConnection
End With
		
Set getJobInformation_cmd = Server.CreateObject ("ADODB.Command")
With getJobInformation_cmd
	.ActiveConnection = thisConnection
	.CommandText = "SELECT StartDate, Customer, WorkSite2, WC1Pay, WorkCode1, Reference " &_
		"FROM Orders WHERE (JobStatus<2) AND WC1Pay > 0 ORDER BY StartDate Desc;"
	.Prepared = true
End With
Set JobInformation = getJobInformation_cmd.Execute	
Response.write "<table style='width:100%'><tr><th>Start Date</th><th>Customer</th><th>Location</th><th>Pay</th><th>Category</th><th>Comments</th></tr>"
do while not JobInformation.eof
		
	Response.write "<tr><td>" & JobInformation("StartDate") & "</td>"
	Response.write "<td>" & JobInformation("Customer") & "</td>"
	Response.write "<td>" & JobInformation("WorkSite2") & "</td>"
	Response.write "<td>$" & TwoDecimals(JobInformation("WC1Pay")) & "</td>"
	
	getWorkCodeDescription_cmd.CommandText = "Select Description FROM WorkCodes Where WorkCode='" & JobInformation("WorkCode1") & "'"
	Set WorkCodeDescription = getWorkCodeDescription_cmd.Execute
	Response.write "<td>" & WorkCodeDescription("Description") & "</td>"

	getWebDescription_cmd.CommandText = "Select Def2 FROM OtherOrders Where Reference=" & JobInformation("Reference")
	Set WebDescription = getWebDescription_cmd.Execute

	Response.write "<td>"
	if Not WebDescription.eof then Response.write "<table style='width:25em'><tr><td>" & WebDescription("Def2") & "</td></tr></table>"
	Response.write "</td></tr>"
	
	JobInformation.MoveNext
loop
Response.write "</table>"
Set JobInformation = Nothing

%>
