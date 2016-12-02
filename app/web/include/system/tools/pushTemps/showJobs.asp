
<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%
Response.Expires = -1
Response.ExpiresAbsolute = Now() -1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
dim thisConnection, getCustomers_cmd, Customers, selectedID, customerID

dim QueryText, Location(3), queryCache_cmd, getUnFilledJobs_cmd, getWebDescription_cmd, getWebDescription, Jobs, WebDescription

QueryText = "SELECT Orders.Reference, Orders.WorkSite2, Orders.JobDescription, Orders.JobChangedDate, Orders.WC1Pay, Orders.InvoiceFormat, " &_
	"OtherOrders.Def1, OtherOrders.Def2 " &_
	"FROM Orders LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference " &_
	"WHERE (((Orders.JobStatus)<2) AND ((Orders.InvoiceFormat)<>'H') AND ((Orders.InvoiceFormat)<>'B')) " &_
	"ORDER BY Orders.JobChangedDate DESC;"

Set queryCache_cmd = Server.CreateObject("ADODB.Connection")
queryCache_cmd.Open MySql
		
Set getUnFilledJobs_cmd = Server.CreateObject("ADODB.Command")
ThisSession = Session.SessionID
Location(0) = "PER"
Location(1) = "BUR"
Location(2) = "BOI"
'Location(3) = "IDA"

For i = 0 To 2 ' Cycle through Temps DNSLess Connections
	With getUnFilledJobs_cmd
		.ActiveConnection = dsnLessTemps(i)
		.CommandText = QueryText
	End With
	Set Jobs = getUnFilledJobs_cmd.Execute
	Do Until Jobs.eof
		dateCache = Jobs("JobChangedDate")
		JobID = Location(i) & Jobs("Reference")
		
		WebDescription = Jobs("Def1")
		if len(WebDescription & "") > 0 then
			WebDescription = Replace(WebDescription, "'", "''")
		Else
			WebDescription = "Contact your local office for more information"
		end if
		
		WebTitle = Jobs("Def2")
		if len(WebTitle & "") > 0 then
			WebTitle = Replace(WebTitle & "", "'", "''")
			
			sqlCacheJobs = "INSERT INTO qry_jobs (session, location, description, date, jobid, details, pay) VALUES (" &_
				ThisSession & ", '" &_
				Replace(Jobs("WorkSite2") & "", "'", "''") & "', '" &_
				WebTitle & "', '" &_
				Year(dateCache) & "/" & Month(dateCache) & "/" & Day(dateCache) & "', '" &_
				JobID & "', '" &_
				WebDescription & "', '" &_
				Jobs("WC1Pay") & "')"
			queryCache_cmd.Execute(sqlCacheJobs)
		end if
		Jobs.Movenext
	loop
Next	
Set Jobs = Nothing
Set getUnFilledJobs_cmd = Nothing

Set queryCache = queryCache_cmd.Execute("Select * FROM qry_jobs WHERE session='" & ThisSession & "' ORDER By date DESC")
do while not queryCache.eof
	JobPay = queryCache("pay")
	if CInt(JobPay) = 0 then
		JobPay = "D.O.E."
	Else
		JobPay = "$" & TwoDecimals(JobPay)
	end if
		

	id = id + 1
	response.write decorateTop("", "marLRB10", "")
	Response.write "<table class='jobPost'>"
	response.write "<tr><th class='description'>Description</th><th class='posted'>Posted</th><th class='location'>Location</th><th class='startpay'>Start Pay</th><th class='jobid'>Job ID</th></tr>"
	Response.write "<tr>"
	Response.write "<td class='description'>" & queryCache("description") & "</td>"
	Response.write "<td class='posted'>" & queryCache("date") & "</td>"
	Response.write "<td class='location'>" & queryCache("location") & "</td>"
	Response.write "<td class='startpay'>" & JobPay & "</td>"
	Response.write "<td class='jobid'>" & queryCache("jobid") & "</td></tr>"
	Response.write "<tr>"
	Response.write "<td colspan=5 class='jobdescription'>" & queryCache("details") & "</td></tr>"
	Response.write "<tr>"
	Response.write "<td id=""apply_ways"" colspan=5>" &_
		"<a id=""apply_for_job"" href='/include/system/tools/applicant/application/?jobid=" & queryCache("jobid") & "'>Apply for this job</a>" &_
		"<a id=""send_resume"" href='/include/system/tools/applicant/resume/?jobid=" & queryCache("jobid") & "'>Send an updated resume</a>" &_
		"</td></tr>"
	Response.write "</table>"
	response.write decorateBottom()
	response.Flush()
	
	queryCache.MoveNext
loop

Set queryCache = Nothing
queryCache_cmd.Execute("DELETE FROM qry_jobs WHERE session='" & ThisSession & "'")
queryCache_cmd.Close
Set queryCache_cmd = Nothing

%>
