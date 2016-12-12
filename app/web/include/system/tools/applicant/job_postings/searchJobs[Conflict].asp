<%
dim isservice
if request.querystring("isservice")= "true" then
	isservice = true
	session("no_header") = true
	session("no_cache") = true

else
	session("window_page_title") = "Current Job Opportunities - Personnel Plus"
	session("add_css") = "./searchJobs.css" 
	session("no_cache") = true
end if

const abstract_length = 300 'how long should a short abstract be...
%>

<!-- #INCLUDE FILE='searchJobs.doStuff.asp' -->

<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->

<script type="text/javascript" src="jobSearch.js"></script>
<!-- Created: 12.15.2008 -->
  <%
	''Response.Buffer = true
	'dim objXMLHTTP, jobOrders
	'Set jobOrders = Server.CreateObject("MSXML2.ServerXMLHTTP")
	'jobOrders.Open "GET", "http://192.168.0.8/include/system/tools/pushTemps/showJobs.asp", false
	'jobOrders.Send
	'Response.write jobOrders.responseText
	'Set jobOrders = Nothing

dim thisConnection, getCustomers_cmd, Customers, selectedID, customerID

dim QueryText, Location, queryCache_cmd, getUnFilledJobs_cmd, getWebDescription_cmd, getWebDescription, Jobs, WebDescription

QueryText = "SELECT Orders.Reference, Orders.WorkSite2, Orders.JobDescription, Orders.JobChangedDate, Orders.WC1Pay, Orders.InvoiceFormat, " &_
	"OtherOrders.Def1, OtherOrders.Def2 " &_
	"FROM Orders LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference " &_
	"WHERE (((Orders.JobStatus)<2) AND ((Orders.InvoiceFormat)<>'H') AND ((Orders.InvoiceFormat)<>'B')) " &_
	"ORDER BY LEFT(Orders.WorkSite2, 4) ASC, Orders.JobChangedDate DESC;"

		
Set getUnFilledJobs_cmd = Server.CreateObject("ADODB.Command")
Location = Split("BOI BUR POC PER IDA", " ")

dim trailing_space

dim strCompAndRef, lnkJobDetails, strBranch, strBuffer, strDate, intDateDiff
if not isservice then 
	response.write decorateTop("", "marLRB10", "")
end if

For i = Lbound(Location) To Ubound(Location) ' Cycle through Temps DNSLess Connections

	'separate sites and display header for each branch
	if not isservice then
		select case Location(i)
			case "POC"
				response.write "<h4 class=""jobarea"">Bannock County and Surrounding Areas</h4>"
				
			case "BUR"
				response.write "<h4 class=""jobarea"">Cassia County and Surrounding Areas</h4>"
				
			case "BOI"
				response.write "<h4 class=""jobarea"">Treasure Valley and Surrounding Areas</h4>"
				
			case "PER"
				response.write "<h4 class=""jobarea"">Magic Valley and Surrounding Areas</h4>"

			case "IDA"
				response.write "<h4 class=""jobarea"">Idaho Agricultural Jobs</h4>"

		end select
	end if
	
	on error resume next
	
	With getUnFilledJobs_cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(Location(i)))
		.CommandText = QueryText
	End With
	
	Set Job = getUnFilledJobs_cmd.Execute
	Do Until Job.eof
		
		WebTitle = Job("Def2")
		if len(WebTitle & "") > 0 then

			JobID = Location(i) & Job("Reference")

			WebDescription = Job("Def1")
			if len(WebDescription & "") > 0 then
				WebDescription = ClearHTMLTags(WebDescription, 0)
				WebDescription = RemoveEntersAndSpaces(WebDescription)
			Else
				WebDescription = "Contact your local office for more information"
			end if
			
			if Len(WebDescription) > abstract_length then
				trailing_space = instr(abstract_length, WebDescription, " ")
				if trailing_space > 0 then
					WebDescription = left(WebDescription, trailing_space) & "..."
				else
					WebDescription = ClearHTMLTags(left(WebDescription, abstract_length), 0) & "..."
				end if
			else
				WebDescription = ClearHTMLTags(WebDescription, 0)
			end if
			
		
			JobPay = Job("WC1Pay")
			if not isnull(JobPay) then
				if CInt(JobPay) = 0 then
					JobPay = "&nbsp;-&nbsp;D.O.E."
				Else
					JobPay = "&nbsp;-&nbsp;$" & TwoDecimals(JobPay) & " Per Hour"
				end if
			else
				JobPay = "&nbsp;-&nbsp;D.O.E."
			end if
				
			strCompAndRef = JobID
			if isservice then
				lnkJobDetails = "https://www.personnelinc.com/include/system/tools/applicant/job_postings/details/?site=" & getCompanyNumber(Left(strCompAndRef, 3)) & "&id=" & Right(strCompAndRef, Len(strCompAndRef)-3)
			else
				lnkJobDetails = "details/?site=" & getCompanyNumber(Left(strCompAndRef, 3)) & "&id=" & Right(strCompAndRef, Len(strCompAndRef)-3)
			end if
			
			dateCache = Job("JobChangedDate")
			strDate = CStr(Month(dateCache) & "/" & Day(dateCache) & "/" & Year(dateCache))
			intDateDiff = DateDiff("d",strDate, Date())
			if strDate = CStr(Date()) then 
				strDate = "Posted Today"
			elseif intDateDiff < 2 then
				strDate = "Posted Yesterday"
			elseif intDateDiff < 6 then
				strDate = "Posted " & intDateDiff & " days ago"
			elseif intDateDiff = 7 then
				strDate = "Posted a week ago"
			else
				strDate = "Posted " & strDate
			end if
			
			%>
			<div class='jobdetails'>
				<p class="description"><a href="<%=lnkJobDetails%>"><%=WebTitle%></a></p>
				<p class="attributes"><span class="company">Personnel Plus, Inc</span>&nbsp;-&nbsp;<span class="location"><%=Job("WorkSite2")%></span>
				&nbsp;-&nbsp;<span class="jobid"><%=strCompAndRef%></span>&nbsp;-&nbsp;<span class="posted"><%=strDate%><%=JobPay%></span></p>
				<p class="details"><%=WebDescription%></p>
			</div>
			<%
			
			response.Flush()
		
		end if
		Job.Movenext
	loop
	
	on error goto 0
	
Next

Set Job = Nothing
Set getUnFilledJobs_cmd = Nothing

if not isservice then
	response.write decorateBottom()
%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
<%
else
%>
<!-- #INCLUDE VIRTUAL='/include/core/dispose_service_session.asp' -->
<%
end if
%>
	