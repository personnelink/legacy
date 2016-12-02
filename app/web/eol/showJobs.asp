<!-- #INCLUDE VIRTUAL='/include/global_declarations.asp' -->
<%
Dim thisConnection, getCustomers_cmd, Customers, selectedID, customerID

Dim QueryText, Location(3), queryCache_cmd, getUnFilledJobs_cmd, getWebDescription_cmd, getWebDescription, Jobs, WebDescription

QueryText = "SELECT Orders.Reference,  Orders.WorkSite2, Orders.JobDescription, Orders.JobChangedDate, Orders.WC1Pay " &_
	"FROM Orders INNER JOIN WorkCodes ON Orders.WorkCode1 = WorkCodes.WorkCode " &_
	"WHERE (((Orders.JobStatus)<2)) AND Orders.WC1Pay>0 " &_
	"ORDER BY JobChangedDate Desc;"

Set getWebDescription_cmd = Server.CreateObject("ADODB.Connection")
Set queryCache_cmd = Server.CreateObject("ADODB.Connection")
queryCache_cmd.Open MySql
		
Set getUnFilledJobs_cmd = Server.CreateObject("ADODB.Command")
ThisSession = Session.SessionID
Location(0) = "TWI"
Location(1) = "BUR"
Location(2) = "BOI"
'Location(3) = "IDA"

For i = 0 To 2 ' Cycle through Temps DNSLess Connections
	getWebDescription_cmd.Open dsnLessTemps(i)
	With getUnFilledJobs_cmd
		.ActiveConnection = dsnLessTemps(i)
		.CommandText = QueryText
	End With
	Set Jobs = getUnFilledJobs_cmd.Execute
	Do Until Jobs.EOF
		dateCache = Jobs("JobChangedDate")
		JobID = Jobs("Reference")
		Set getWebDescription = getWebDescription_cmd.Execute("SELECT Def1 FROM OtherOrders WHERE Reference=" & JobID)
		JobID = Location(i) & String(6-Len(JobID), "0") & JobID
		If Not getWebDescription.EOF Then
			WebDescription = Replace(getWebDescription("Def1"), "'", "''")
		Else
			WebDescription = "Contact your local office for more information"
		End If
		
		sqlCacheJobs = "INSERT INTO qry_jobs (session, location, description, date, jobid, details, pay) VALUES (" &_
			ThisSession & ", '" &_
			Replace(Jobs("WorkSite2"), "'", "''") & "', '" &_
			Replace(Jobs("JobDescription"), "'", "''") & "', '" &_
			Year(dateCache) & "/" & Month(dateCache) & "/" & Day(dateCache) & "', '" &_
			JobID & "', '" &_
			WebDescription & "', '" &_
			Jobs("WC1Pay") & "')"

		queryCache_cmd.Execute(sqlCacheJobs)
		Jobs.Movenext
	Loop
	getWebDescription_cmd.Close
Next	
Set Jobs = Nothing
Set getUnFilledJobs_cmd = Nothing

Response.write "<table style='width:100%'>"
Set queryCache = queryCache_cmd.Execute("Select * FROM qry_jobs WHERE session='" & ThisSession & "' ORDER By date DESC")
Do While Not queryCache.EOF
	id = id + 1	
	Response.Write "<tr><th>" & id & ")&nbsp;&nbsp;</th><th>Description</th><th>Posted</th><th>Location</th><th>Start Pay</th><th>Job ID</th></tr>"
	Response.write "<tr><td>&nbsp;</td>"
	Response.write "<td>" & queryCache("description") & "</td>"
	Response.write "<td>" & queryCache("date") & "</td>"
	Response.write "<td>" & queryCache("location") & "</td>"
	Response.write "<td>$" & TwoDecimals(queryCache("pay")) & "</td>"
	Response.write "<td>" & queryCache("jobid") & "</td></tr>"
	Response.write "<tr><td></td>"
	Response.write "<td colspan=5 style='padding:0.2em 0 1.4em;'>" & queryCache("details") & "</td></tr>"
	queryCache.MoveNext
Loop
Response.write "</table>"
Set queryCache = Nothing
queryCache_cmd.Execute("DELETE FROM qry_jobs WHERE session='" & ThisSession & "'")
queryCache_cmd.Close
Set queryCache_cmd = Nothing

%>
