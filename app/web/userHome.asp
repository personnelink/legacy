<%
session("add_css") = "general.asp.css, ./include/system/tools/activity/reports/appointments/followAppointments.asp.css"
session("page_title") = "User Home"
session("window_page_title") = "User Home Start Page - Personnel Plus" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/system/tools/activity/reports/appointments/followAppointments.js"></script>
<script type="text/javascript" src="/include/js/userHome.013.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="/include/functions/calendar/lang/calendar-en.js"></script>
<style type="text/css"> @import url("/include/functions/calendar/calendar-blue.css"); </style>
<%

dim enrollmentMessage, enrollmentMessageTxt
	enrollmentMessageTxt = "<div id=" & chr(34) & "enrollmentCompleteContent" & chr(34) & "><p><strong>" &_
		"Thanks for registering with us!</strong></p><p>We look forward to working with you, listening to your " &_
		"comments and what you have tell us. <br><br>Your user account has been created successfully and " &_
		"an email sent to you with your account information to keep for records.</p>" &_
		"</div>"
enrollmentMessage = get_session("enrollmentMessage")
if enrollmentMessage = "true" then
	response.write(decorateTop("enrollmentComplete", "marLR10", "Account Created ..."))
	response.write(enrollmentMessageTxt)
	response.write(decorateBottom())
	enrollmentMessage = set_session("enrollmentMessage", "")
end if

dim welcomeMessage, welcomeMessageTxt
welcomeMessage = get_session("welcomeMessage")
if len(welcomeMessage) > 0 then
	response.write(decorateTop("welcomeUser", "marLR10", "Welcome to Personnel Plus"))
	response.write(session("welcomeMessage"))
	response.write(decorateBottom())
	welcomeMessage = set_session("welcomeMessage", "")
end if

if len(session("homeMessageHeading")) > 0 then
	response.Write decorateTop("", "marLR10", session("homeMessageHeading"))
	response.Write session("homeMessageBody")
	response.write decorateBottom()
	'session("homeMessageHeading") = ""
	'session("homeMessageBody") = ""
end if

if len(no_you_heading) > 0 then
	response.Write decorateTop("", "marLRB10", home_message)
	response.Write get_message(home_message)
	response.write decorateBottom()
	home_message = set_session("homeMessageHeading", "")
end if

dim ast 'Alternate System State
dim profile_updated
ast = Request.QueryString("AST")
select case ast
case "ao"
	dim ifAppliedOnline
	ifAppliedOnline = "<div id='appCompletedBlog'><p>Your on-line application has been successfully submitted! if you are completing your registration from outside our " &_
		"offices, you will need to stop in to finalize your application. Be sure to bring appropriate identification to complete your Employment Eligibility Verification Form I-9. " &_
		"Please don't hesitate to contact one of our <a href='https://www.personnelinc.com/include/content/contact.asp'><b>offices</b></a> if you have any questions.</p>" &_
		"<p>&nbsp;</p><p><strong> Thanks for submitting your application with "  &_
		"us!</strong> We look forward to meeting and working with you!</p></div>"

	response.write(decorateTop("applicationCompleted", "marLR10", "Online Application Completed!"))
	response.write(ifAppliedOnline)
	response.write(decorateBottom())
	
case "updated"

	profile_updated = "<span style=""color:red;margin:0 0 0 0em;"">* Your Profile Information Has Been Updated. </span>"

case "rs"
	dim resumeSubmitted
	resumeSubmitted = "<div id='appCompletedBlog'><p>Your resume has been successfully submitted! If you are submitting your resume from outside our " &_
		"offices, you will need to stop in to finalize your application as well. Be sure to bring appropriate identification to complete your Employment Eligibility Verification Form I-9. " &_
		"Please don't hesitate to contact one of our <a href='https://www.personnelinc.com/include/content/contact.asp'><b>offices</b></a> if you have any questions.</p>" &_
		"<p>&nbsp;</p><p><strong> Thanks for submitting your resume with "  &_
		"us!</strong> We look forward to meeting and working with you!</p></div>"

	response.write(decorateTop("applicationCompleted", "marLR10", "Resume Submission Complete!"))
	response.write(resumeSubmitted)
	response.write(decorateBottom())
	
	resumeSubmitted = ""
	
case "ts"
	dim home_message
		home_message = "" &_
			"<div id='appCompletedBlog'><p>Your file submission was successfully submitted!</p> " &_
			"<p>Please don't hesitate to contact one of our <a href='https://www.personnelinc.com/include/content/contact.asp' onclick=""grayOut(true);""><b>offices</b></a> if you have any questions.</p>" &_
			"<p>&nbsp;</p><p><strong> Thanks for your submission to us!</strong><br> " &_
			"We look forward to working with you!</p></div>"

	response.write(decorateTop("applicationCompleted", "marLR10", "Submission Successful!"))
	response.write(home_message)
	response.write(decorateBottom())
	
	home_message = ""
	
case "ds"
		home_message = "" &_
			"<div id='appCompletedBlog'>" &_
			"<p>Drug test image successfully saved in net_docs Drug Testing folder.</p>" &_
			"</div>"

	response.write(decorateTop("applicationCompleted", "marLR10", "Drug Test Seizure Successful!"))
	response.write(home_message)
	response.write(decorateBottom())
	
	home_message = ""

case else

end select


dim already_written
response.write decorateTop("homeBlogSpot", "marLR10", "")

if userLevelRequired(userLevelPPlusStaff) then
	Response.write  "" &_
		"<h2 id=""appointmentsheader"" class="""">" &_
		"<a id=""gotoappointments"" href=""/include/system/tools/activity/reports/appointments/?onlyactive=1&for=" & tUser_Id & """>[ Appointments ]</a>Appointments and Follow-ups" &_
		"<span class=""enteredby"">" &_
			"<label onclick=""alarm.check('', '');""><input type=""checkbox"" id=""onlyme"" name=""onlyme"" value=""1"" checked=""yes"" onchange=""getAppointments();""/>" &_
			"Mine Only</label></span>" &_
		"</h2>" &_
		"<div style=""position:relative;""><div id=""busyoverlay"" class=""working""></div>" &_
		"<div id=""appointments"" class=""working noappointments""><i>Checking appointments...</i></div></div>" &_
		"<div id=""messages"" class=""hide""></div>"
end if

Database.Open MySql
thisUsersID = user_id
thisUsersSecurityLevel = user_level

Set blogPosts = Database.Execute("select * from tbl_content where class is Null or Class='user' AND level <=" & thisUsersSecurityLevel & " Order By classindex")
do while not blogPosts.eof 
	
	blogID = blogPosts("id")
	blogUserID = blogPosts("userID")
	blogDate = blogPosts("date")
	blogSubject = blogPosts("heading")
	blogBody = blogPosts("content")
	
	if user_level => userLevelPPlusStaff then 'unhide internal use only tools'
		blogBody = replace(blogBody, "pplustool", "")
	end if

	if len(ifDev) > 0 then
		'if development url is the same as current
		'change possible urls in blogContent
		blogSubject = replace(blogSubject,  secureURL, ifDev)
		blogBody = replace(blogBody,  secureURL, ifDev)
	end if

	'getUserName = Database.Execute("Select userName From tbl_users Where userID=" & blogUserID)
	
	if thisUsersSecurityLevel => userLevelPPlusSupervisor then
		manageThisBlog = true
	elseif blogUserID = thisUsersID then
		manageThisBlog = true
	end if
	
	if manageThisBlog then
		blogTasks = "<a href=""/include/system/tools/edit/?removeblogid=" & blogID & "&blogid=" & blogID & """ title=""Delete Message"" class=""delBlog"">" &_
		"<img src=""/include/style/images/blogDelete.png"" alt=""""></a><a href=""/include/system/tools/edit/?formatting=html&blogid=" &_
		blogID & """ title=""Edit Message"" class=""editBlog""><img src=""/include/style/images/blogEdit.png"" alt=""""></a>"
		
	End if 
	
	if blogID = 53 then
		response.write "<p>" & blogSubject & blogTasks & "</p><span><p>"  & blogBody & profile_updated & "</p></span>"	
	else
		response.write "<p>" & blogSubject & blogTasks & "</p><span><p>" & blogBody & "</p></span>"
	end if
	
	manageThisBlog = false
	blogTasks = ""
	blogPosts.Movenext
	
loop
Set blogPosts = Nothing
Database.Close 
%>
<form id="userHome" name="userHome" action="/userHome.asp">

<input name="page_title" id="page_title" type="hidden" value="Start Page - Personnel Plus" />
<input type="hidden" id="tUser_Id" name="tUser_Id" value="<%=tUser_id%>" />
</form>
<%=decorateBottom()%>

<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
