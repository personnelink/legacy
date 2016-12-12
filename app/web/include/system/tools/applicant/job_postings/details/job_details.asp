<%Option Explicit%>
<%
session("window_page_title") = "Personnel Plus - Current Job Opportunity"
session("add_css") = "./job_details.css" 
session("no_cache") = true
session("htmltag") = "itemscope itemtype=""http://schema.org/Blog"""

%>
<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->

<!-- #INCLUDE FILE='job_details.doStuff.asp' -->

<script type="text/javascript" src="job_details.js"></script>

<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<%

dim thisConnection, getCustomers_cmd, Customers, selectedID, customerID

dim Location, queryCache_cmd, getUnFilledJobs_cmd, getWebDescription_cmd, getWebDescription, WebDescription

		
dim whichJob, intJob
intJob = request.QueryString("id")
if len(intJob) > 0 then whichJob = Cint(intJob)

dim QueryText
QueryText = "SELECT Orders.Reference, Orders.WorkSite2, Orders.JobDescription, Orders.JobChangedDate, " &_
	"Orders.WC1Pay, Orders.InvoiceFormat, " &_
	"OtherOrders.Def1, OtherOrders.Def2 " &_
	"FROM Orders LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference " &_
	"WHERE Orders.Reference=" & whichJob & " " &_
	"ORDER BY Orders.JobChangedDate DESC;"

dim whichSite, intSite
intSite = request.QueryString("site")
if len(intSite) > 0 then whichSite = Cint(intSite)

dim jobdetails_cmd
Set jobdetails_cmd = Server.CreateObject("ADODB.Command")
With jobdetails_cmd
	.ActiveConnection = dsnLessTemps(whichSite)
	.CommandText = QueryText
End With

Dim JobDetail
Set JobDetail = jobdetails_cmd.Execute
if Not JobDetail.eof then
	dim dateCache
	dateCache = JobDetail("JobChangedDate")
	
	Dim CompoundId
	CompoundId = getCompCode(whichSite) & JobDetail("Reference")
	
	WebDescription = JobDetail("Def1")
	if len(WebDescription & "") > 0 then
		if WebDescription = ClearHTMLTags(WebDescription, 0) then
			WebDescription = "<pre>" & WebDescription & "</pre>"
		end if
		WebDescription = Replace(WebDescription, "'", "''")
	Else
		WebDescription = "Contact your local office for more information"
	end if
	
	dim thisUsersSecurityLevel
		thisUsersSecurityLevel = user_level	
	
	dim thisUsersID
		thisUsersID = user_id

	dim WebTitle
	WebTitle = JobDetail("Def2")
	if len(WebTitle & "") > 0 then

		if thisUsersSecurityLevel => userLevelPPlusSupervisor then
			dim manageThisBlog
			manageThisBlog = true
			
			dim contentTasks
			contentTasks = "" &_
				"<a style=""float:right;clear:none;"" href=""/include/system/tools/applicant/job_postings/edit/?id=" & whichJob & "&site=" & whichSite & """" &_
				" title=""Edit Message"" onclick=""grayOut(true);""><img src=""/include/style/images/blogEdit.png"" alt=""""></a>"
		end if

		dim JobPay
		JobPay = JobDetail("WC1Pay")
		if not isnull (JobPay) then
			if CInt(JobPay) = 0 then
				JobPay = "D.O.E."
			Else
				JobPay = "$" & TwoDecimals(JobPay)
			end if
		Else
			JobPay = "D.O.E."
		end if

		response.write decorateTop("", "marLRB10", WebTitle & contentTasks)
		Response.write "<table class='jobPost'>"
		response.write "<tr><th class='description'>Job Title</th><th class='posted'>Posted</th><th class='location'>Location</th><th class='startpay'>Start Pay</th><th class='jobid'>Job ID</th></tr>"
		Response.write "<tr>"
		Response.write "<td id=""WebTitle"" class='description'>" & WebTitle & "</td>"
		Response.write "<td class='posted'>" & Year(dateCache) & "/" & Month(dateCache) & "/" & Day(dateCache) & "</td>"
		Response.write "<td class='location'>" & JobDetail("WorkSite2") & "</td>"
		Response.write "<td class='startpay'>" & JobPay & "</td>"
		Response.write "<td class='jobid'>" & CompoundId & "</td></tr>"
		
		
		Response.write "<tr><td id=""apply_ways"" colspan=5>" &_
			"<div id=""thin_blue_line"">&nbsp;</div></td></tr>"

		response.write "<tr><th class='description' colspan='5'>Job Description</th></tr>"
		Response.write "<tr>"
		Response.write "<td colspan=5 class='jobdescription'><div id=""jobdetails"">" & WebDescription & "" &_
			"<div id=""apply_for_job""><a  href='/include/system/tools/applicant/application/?jobid=" & CompoundId & "'><span>Apply Now</a></span></div>" &_
			"<div id=""send_resume""><a href='/include/system/tools/applicant/resume/?jobid=" & CompoundId & "'><span>Send Resume</span></a></div>" &_
			"</div></td></tr>"

		Response.write "<tr><td colspan=3 class='jobdescription'><g:plusone size=""small""></g:plusone>" &_
			"<div style=""padding-right:10px"" class=""fb-like"" id=""fb"" data-href=""#"" data-layout=""box_count"" data-action=""like"" data-show-faces=""false"" data-share=""false""> </div>" &_
			"<div style=""padding-right:10px"" class=""fb-like"" id=""fb"" data-href=""#"" data-layout=""box_count"" data-action=""recommend"" data-show-faces=""false"" data-share=""false""> </div>"&_
			"<a href=""https://twitter.com/share"" class=""twitter-share-button"">Tweet</a></td>" &_
			"<td colspan=2><span style=""float:right"">[<a href=""/include/system/tools/applicant/job_postings/""> ... back to job postings ...</a>]</span></td></tr>"
		
		Response.write "</table>"
		response.write decorateBottom()
		response.Flush()
		
		<!-- Add the following three tags inside head -->
		response.write "<form name=""jobform"" class=""hide""><input name=""itemprop_name"" type=""hidden"" value=""" & ClearHTMLTags(WebTitle, 0) & """ />"
		response.write "<input name=""itemprop_desc"" type=""hidden"" value=""" & ClearHTMLTags(WebDescription, 0) & """/></form>"
		
	end if
end if

JobDetail.Close
set JobDetail = nothing
set jobdetails_cmd = nothing
%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
