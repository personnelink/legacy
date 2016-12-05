<%Option Explicit%>
<%
session("window_page_title") = "Personnel Plus - Current Job Opportunity"
session("add_css") = "./job_details.css" 
session("no_cache") = true
session("no-flush") = true
session("htmltag") = "itemscope itemtype=""http://schema.org/Blog"" xmlns=""http://www.w3.org/1999/xhtml"" xmlns:og=""http://ogp.me/ns#"" xmlns:fb=""https://www.facebook.com/2008/fbml"""
%>

<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->

<!-- #INCLUDE FILE='job_details.doStuff.asp' -->

<%

dim locationSpecificImage(20)

locationSpecificImage(BOI) = "https://www.personnelinc.com/images/posted/help_wanted_treasure_opt.png"
locationSpecificImage(POC) = "https://www.personnelinc.com/images/posted/help_wanted_poki_opt.png"
locationSpecificImage(BUR) = "https://www.personnelinc.com/images/posted/help_wanted_burley_opt.png"
locationSpecificImage(PER) = "https://www.personnelinc.com/images/posted/help_wanted_twin_opt.png"
locationSpecificImage(PPI) = "https://www.personnelinc.com/images/posted/hiring_opt.png"
locationSpecificImage(WYO) = "https://www.personnelinc.com/images/posted/hiring_opt.png"
locationSpecificImage(ORE) = "https://www.personnelinc.com/images/posted/hiring_opt.png"
locationSpecificImage(ALL) = "https://www.personnelinc.com/images/posted/hiring_opt.png"

	
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
	dim job_location : job_location = JobDetail("WorkSite2")
	
	dim WebTitle : WebTitle = JobDetail("Def2")
	
	
	
	dim fbDescription : fbDescription = WebDescription
		fbDescription = replace(WebDescription, vbCrLf, " ")
		fbDescription = replace(fbDescription, "<pre>", "")
		fbDescription = replace(fbDescription, "- ", "* ")
		fbDescription = replace(fbDescription, """", "")
		fbDescription = replace(fbDescription, "</pre>", " ")
	
		fbDescription = ClearHTMLTags(fbDescription, 0)
	
		session("metatagging") = session("metatagging") &_
			"<meta property=""og:title"" content=""" & replace(WebTitle & " - " & job_location,"""", "") & """ />" &_
			"<meta property=""og:description"" content=""" & fbDescription & """ />" &_
			"<meta property=""og:image"" content=""" & locationSpecificImage(getSiteNumber(getCompCode(whichSite))) & """ />"

	
%>

<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_noglobal_session.asp' -->

<script type="text/javascript" src="job_details.js"></script>
<div id="fb-root"></div>
<script type="text/javascript">var switchTo5x=true;</script>
<script type="text/javascript" src="https://ws.sharethis.com/button/buttons.js"></script>
<script type="text/javascript">stLight.options({publisher: "12a2ed7b-3561-4c90-954d-1e19022309df", doNotHash: false, doNotCopy: false, hashAddressBar: false});</script>
<%	
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
		response.write "<table class='jobPost'>"
		response.write "<tr><th class='description'>Job Title</th><th class='posted'>Posted</th><th class='location'>Location</th><th class='startpay'>Start Pay</th><th class='jobid'>Job ID</th></tr>"
		response.write "<tr>"
		response.write "<td id=""WebTitle"" class='description'>" & WebTitle & "</td>"
		response.write "<td class='posted'>" & Year(dateCache) & "/" & Month(dateCache) & "/" & Day(dateCache) & "</td>"
		response.write "<td class='location'>" & job_location & "</td>"
		response.write "<td class='startpay'>" & JobPay & "</td>"
		response.write "<td class='jobid'>" & CompoundId & "</td></tr>"
		
		
		response.write "<tr><td id=""apply_ways"" colspan=5>" &_
			"<div id=""thin_blue_line"">&nbsp;</div></td></tr>"

		response.write "<tr><th class='description' colspan='5'>Job Description</th></tr>"
		response.write "<tr>"
		response.write "<td colspan=5 class='jobdescription'><div id=""jobdetails"">" & WebDescription & "" &_
			"<div id=""apply_for_job""><a  href='/include/system/tools/applicant/application/?jobid=" & CompoundId & "'><span>Apply Now</a></span></div>" &_
			"<div id=""send_resume""><a href='/include/system/tools/applicant/resume/?jobid=" & CompoundId & "'><span>Send Resume</span></a></div>" &_
			"<br><br><br><br><div style=""position: absolute;""><span class='st_facebook_large' displayText='Facebook'></span>" &_
			"<span class='st_linkedin_large' displayText='LinkedIn'></span>" &_
			"<span class='st_googleplus_large' displayText='Google +'></span>" &_
			"<span class='st_twitter_large' displayText='Tweet'></span>" &_			
			"<span class='st_evernote_large' displayText='Evernote'></span>" &_
			"<span class='st_email_large' displayText='Email'></span>" &_
			"</div></td></tr>"
			


		response.write "<tr><td colspan=3 class='jobdescription'><td>" &_			
			"<td colspan=2><span style=""float:left"">[<a href=""/include/system/tools/applicant/job_postings/"">... back to job postings ...</a>]</span></td></tr>"
			' "<div style=""padding-right:10px"" class=""fb-share-button"" id=""fb"" data-href=""#"" data-layout=""button""> </div>"
			' "<a href=""https://twitter.com/share"" class=""twitter-share-button"">Tweet</a></td>"
		response.write "</table>"
		response.write decorateBottom()

		
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
