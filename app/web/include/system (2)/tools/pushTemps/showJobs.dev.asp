
<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%
Response.Expires = -1
Response.ExpiresAbsolute = Now() -1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
dim thisConnection, getCustomers_cmd, Customers, selectedID, customerID

dim QueryText, Location(3), queryCache_cmd, getUnFilledJobs_cmd, getWebDescription_cmd, getWebDescription, Jobs, WebDescription

dim stuff_to_select, joined_with, that_matches_this

dim tempsdsnpath
	tempsdsnpath = "\\personnelplus.net.\tplus\web.services\"

stuff_to_select = "SELECT Orders.Reference, Orders.WorkSite2, Orders.JobDescription, Orders.JobChangedDate, " &_
				"Orders.WC1Pay, Orders.InvoiceFormat, OtherOrders.Def1, OtherOrders.Def2 "
						 
joined_with = ";pwd=onlyme].[Orders] LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference "

that_matches_this = "WHERE (((Orders.JobStatus)<2) AND ((Orders.InvoiceFormat)<>'H') AND ((Orders.InvoiceFormat)<>'B')) "

QueryText = stuff_to_select & "FROM  [" & tempsdsnpath & "TempsPER.mdb" & joined_with & that_matches_this &_
			"UNION " &_ 
			stuff_to_select & "FROM  [" & tempsdsnpath & "TempsBUR.mdb" & joined_with & that_matches_this &_
			"UNION " &_
			stuff_to_select & "FROM  [" & tempsdsnpath & "TempsBOI.mdb" & joined_with & that_matches_this &_
			"ORDER BY Orders.JobChangedDate DESC;"

'Set queryCache_cmd = Server.CreateObject("ADODB.Connection")
'queryCache_cmd.Open MySql
		
Set getUnFilledJobs_cmd = Server.CreateObject("ADODB.Command")
ThisSession = Session.SessionID
Location(0) = "PER"
Location(1) = "BUR"
Location(2) = "BOI"
'Location(3) = "IDA"

'For i = 0 To 2 ' Cycle through Temps DNSLess Connections
	With getUnFilledJobs_cmd
		.ActiveConnection = dsnLessTemps(0)
		.CommandText = QueryText
	End With
	'break QueryText
	
	Set Jobs = getUnFilledJobs_cmd.Execute
	Do Until Jobs.eof
		dateCache = Jobs("JobChangedDate")
		JobID = Location(i) & Jobs("Reference")
		
		WebDescription = Jobs("Def1")
		if len(WebDescription & "") = 0 then
			WebDescription = "Contact your local office for more information"
		end if
		
		WebTitle = Jobs("Def2")
		if len(WebTitle & "") > 0 then
	
		
			id = id + 1
			response.write decorateTop("", "marLRB10", "")
			
			response.write "<table class='jobPost'>" &_
				"<tr><th class='description'>Description</th><th class='posted'>Posted</th><th class='location'>Location</th><th class='startpay'>Start Pay</th><th class='jobid'>Job ID</th></tr>" &_
				"<tr>" &_
				"<td class='description'>" & WebTitle & "</td>" &_
				"<td class='posted'>" & dateCache & "</td>" &_
				"<td class='location'>" & Jobs("WorkSite2") & "</td>" &_
				"<td class='startpay'>" & Jobs("WC1Pay") & "</td>" &_
				"<td class='jobid'>" & JobID & "</td></tr>" &_
				"<tr>" &_
				"<td colspan=5 class='jobdescription'>" & WebDescription & "</td></tr>" &_
				"<tr>" &_
				"<td colspan=4></td><td class='jobid'><a href='/include/system/tools/submitapplication.asp?jobid=" & JobID & "'>Apply for this job.</a></td></tr>" &_
				"</table>"
			response.write decorateBottom()
			response.Flush()
		end if
		Jobs.Movenext
	loop
'Next	
Set Jobs = Nothing
Set getUnFilledJobs_cmd = Nothing

%>
