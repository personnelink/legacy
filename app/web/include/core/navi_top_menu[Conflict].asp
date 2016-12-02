<% ' Revised: 2.10.2009

dim onClickAction, hrefAction
	header_response = header_response & "</head>" &_
	"<body onLoad=""" & session("javascriptOnLoad") & """>" &_
	"<div id=""pageWrapper"" style=""padding-top:0;"">" &_
	"<div id=""pageBanner"">"

	
	
header_response = header_response &_
"<div id=""topnav"">" &_
	"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=""" & baseURL & "/include/content/home.asp"">Home</a>" &_
	 "&nbsp;&nbsp; | &nbsp;&nbsp;<a href=""" & baseURL & "/include/content/about.asp"">About Personnel Plus</a>" &_
	 "&nbsp;&nbsp; | &nbsp;&nbsp;<a href=""/case-studies.asp""><a href=""" & baseURL & "/include/content/resources.asp"">Resources</a>" &_
	 "&nbsp;&nbsp; | &nbsp;&nbsp;<a href=""" & baseURL & "/include/content/contact.asp"">Contact</a>" &_
"</div>" 


header_response = header_response &_
"<div id=""account"" class=""right"">" &_
    "<ul id=""loginTabs"" class=""clearfix"">" &_
      "<li id=""logInTab"" class=""selected"">"
	  
if not session_signed_in then 
		header_response = header_response & "<h2><a href=""" & ifDev & "/userHome.asp"" title=""Log In"">Log In</a></h2>"
elseif session_signed_in then 
		header_response = header_response & "<h2><a href=""" & ifDev & "/include/user/signOut.asp"" title=""Log Out"">Log Out</a></h2>"
end if

header_response = header_response & "</li><li id=""signUpTab""" 

if session_signed_in then header_response = header_response & "class=""hide"""

if Instr(Request.ServerVariables("URL"), "submitapplication") > 0 then
	onClickAction = "checkApplication();"
	hrefAction = "#"
Else
	onClickAction = ""
	hrefAction = secureURL & "/include/system/tools/applicant/application/"
End if

header_response = header_response & "><h2> <a title=""Apply Now!"" href=""" & hrefAction & """ onClick=""" & onClickAction & """>Apply Now!</a></h2>" &_
	"</li>" &_
    "</ul>" &_
  "</div></div>" &_

"<div id=""search"">" &_
"<a class=""leftSearch"" href=""" & secureURL & "/userHome.asp"">" &_
"&nbsp;</a>" &_
"<a class=""middleSearch"" href=""/include/system/tools/applicant/job_postings/"" title=""View Current Job Opportunities"">" &_
"&nbsp;</a>" &_
"<a class=""rightSearch"" href=""/include/system/tools/timecardEmp.asp"">&nbsp;</a>" &_

"</div>" &_

"<div id=""subBanner""><div id=""sessionStatus"">"

if session_signed_in then
	header_response = header_response & "<div id=""loginStatus"">" &_
		"<ul>" &_
		  "<li><a href=""" & ifDev & "/userHome.asp"" title=""Account Home"" id=""guid"">" & user_firstname & " " & user_lastname & " " & "[logged in]&nbsp;" &_
		  	"<img src=""" & imageURL & "/include/style/images/mnuUserHome.png"" alt=""""></a></li>" &_
		"</ul>" &_
	  "</div>"
end if

header_response = header_response & "</div>" &_
	"&nbsp;" &_
	"</div>" &_ 
	"<div id=""pageNavigation"">" &_
	"<ul id=""nav"" class=""dropdown dropdown-horizontal"">" &_
	"<li><a href=""" & baseURL & "/include/content/home.asp"">Home</a></li>" &_
	"<li><a href=""" & baseURL & "/include/content/employer.asp"">Employers</a></li>" &_
	"<li><a href=""" & baseURL & "/include/content/employee.asp"">Find a Candidate</a></li>" &_
	"<li><a href=""" & baseURL & "/include/content/resources.asp"">Resources</a></li>" &_
	"<li><a href=""" & baseURL & "/include/content/blogs/staff/"">Blogging</a><ul style=""left:0"">" &_
		"<li><a href=""" & baseURL & "/include/content/blogs/staff/"">Staff Blogs</a></li>" &_
		"<li><a href=""" & baseURL & "/include/content/blogs/public/"">Public Blogs</a></li>" &_
	"</ul>" &_
	"<li><a href=""" & baseURL & "/include/content/contact.asp"">Contact Us</a></li>" &_
	"<li><a href=""" & baseURL & "/include/content/about.asp"">About Us</a></li>" &_
	"<li><a href=""" & baseURL & "/include/content/orientation.asp"">Orientation</a></li>" &_
	"<li><a href=""" & baseURL & "/include/content/help.asp"">Help</a></li>" &_
	"</ul>" &_
	"<ul id=""rightNav"" class=""dropdown dropdown-horizontal"" style="""">" &_
		"<li class=""dir rtl""><a href=""#"">Tools</a>" &_
			"<ul>"

	
	dim mnuSeeking
	dim mnuEmployee
	dim mneEmployer
	dim mnuInternal
	dim mnuDeveloper

	mnuSeeking = "" &_
		"<li><a href=""/include/system/tools/applicant/job_postings/"" title='Open and Unfilled Jobs'><img src='/include/style/images/mnuJobSearch.png' alt=''>&nbsp;View Job Postings</a></li>" &_
		"<li><a href=""/include/system/tools/applicant/resume/"" title='Send Resume'><img src='/include/style/images/mnuResume.png' alt=''>&nbsp;Send Resume</a></li>" &_
		"<li><a href=""/include/system/tools/submitapplication.asp"" title='Manage Employment Application'><img src='/include/style/images/mnuOnlineApps.png' alt=''>&nbsp;Manage Employment App</a></li>" &_
		"<li><a href=""/include/content/blogs/public/"" title='Post Blog Message'><img src='/include/style/images/mnuBlogPost.png' alt=''>&nbsp;Post Message</a></li>"

	mnuEmployee = "" &_
		"<li><a href=""/include/user/password/change/"" title='Change Password'><img src='/include/style/images/mnuChangePassword.png' alt='Change Password'>&nbsp;Change Password</a></li>" &_
		"<li><a href=""/include/system/tools/timecardEmp.asp"" title='Manage Timecards'><img src='/include/style/images/mnuTimecards.png' alt='Manage Timecards'>&nbsp;Employee Timecard</a></li>"
	
	mneEmployer = "" &_
		"<li><a href=""/include/system/tools/timecards/group/"" title='Manage Timecards'><img src='/include/style/images/mnuTimecards.png' alt='Manage Timecards'>&nbsp;Group Timecard</a></li>" &_
		"<li><a href=""/include/system/tools/manage/users/?Action=2"" title='Manage Users'><img src='/include/style/images/mnuManageUsers.png' alt='Manage Users'>&nbsp;Manage Users</a></li>" &_
		"<li><a href=""/include/system/tools/manageDepartments.asp"" title='Manage Departments'><img src='/include/style/images/mnuManageDepartments.png' alt='Manage Departments'>&nbsp;Manage Departments</a></li>" 
		' "<li><a href=""/include/system/tools/manageLocations.asp"" title='Manage Locations'><img src='/include/style/images/mnuManageLocations.png' alt='Manage Locations'>&nbsp;Manage Locations</a></li>"

	mnuInternal = "" &_
		"<li><a href=""/include/system/tools/activity/reports/activity/?act_when=all&WhichCustomer=%40ALL&WhichOrder=&fromDate=3%2F20%2F2011&toDate=3%2F25%2F2011&WhichPage=&WhichPage=&activity_0=1&activity_3=1&activity_4=1&activity_5=1&activity_6=1&activity_7=1&activity_8=1&activity_9=1&activity_11=1&activity_12=1&activity_13=1&activity_14=1&activity_15=1&activity_16=1&activity_17=1"" title='View Activity'><img src='" & imageURL & "/include/style/images/mnuAccountActivity.png' alt=''>&nbsp;View Activity</a></li>" &_
		"<li><a href=""/include/system/tools/search/"" title='Search Network Documents'><img src='/include/style/images/mnuSearch.png' alt=''>&nbsp;Search NetDocs</a></li>" &_
		"<li><a href=""/include/system/tools/search/?searchCatalog=Resumes"" title='Search Resumes'><img src='/include/style/images/mnuSearch.png' alt=''>&nbsp;Search Resumes</a></li>" &_
		"<li><a href=""/include/system/tools/whose_here/"" title='Applicant Called In'><img src='/include/style/images/mnuCalledIn.png' alt=''>&nbsp;Applicants Who Called In</a></li>" &_
		"<li><a href=""/include/system/tools/activity/applications/view/"" title='Search Applications'><img src='/include/style/images/mnuOnlineApps.png' alt=''>&nbsp;Search Applications</a></li>" &_
		"<li><a href=""/include/system/tools/attachments/"" title='View Attachments'><img src='/include/style/images/mnuOnlineApps.png' alt=''>&nbsp;View Attachments</a></li>" &_
		"<li><a href=""/reference/ISIF_CODES_RATES.asp"" title='ISIF Codes & Rates'><img src='/include/style/images/mnuOnlineApps.png' alt=''>&nbsp;ISIF Codes & Rates</a></li>"

	mnuDeveloper = "" &_
		"<li><a href=""" & devURL & "/userHome.asp"" title='Development'><img src='/include/style/images/mnuJobSearch.png' alt=''>&nbsp; Development Server</a></li>"

		
	dim whoseMenu, userMenu
	whoseMenu = user_level
	if whoseMenu <= userLevelRegistered then
		userMenu = seeking
		header_response = header_response & mnuSeeking	
	elseif whoseMenu <= userLevelEngaged then
		userMenu = employee
		header_response = header_response & mnuSeeking & mnuEmployee
	elseif whoseMenu <= userLevelAdministrator then
		userMenu = employer
		header_response = header_response & mnuSeeking & mnuEmployee & mneEmployer
	elseif whoseMenu <= userLevelPPlusAdministrator then
		userMenu = internal
		header_response = header_response & mnuSeeking & mnuEmployee & mneEmployer & mnuInternal
	elseif whoseMenu <= userLevelPPlusDeveloper then
		userMenu = developer
		header_response = header_response & mnuSeeking & mnuEmployee & mneEmployer & mnuInternal & mnuDeveloper
	else
		header_response = header_response & "Sorry, I don't know you"	
	end if

	header_response = header_response & "</ul></li></ul></div>"

'social media plug-ins
dim social_blob
' if request.servervariables("https") <> "on" then
	' social_blob = "<span class=""social-share"" style=""width:205px;""><!-- Place this tag where you want the +1 button to render -->" &_
			' "<g:plusone size=""medium"" annotation=""inline""></g:plusone></span>" &_
			' "<!-- twitter -->" &_
			' "<span class=""social-share""><a href=""http://twitter.com/share"" class=""twitter-share-button"" data-via=""PersonnelPlus"">"  &_
			' "Tweet</a></span>"&_
			' "<span class=""social-share""><div id=""fb-root""></div>" &_
			' "<div class=""fb-like"" data-href=""http://www.personnelinc.com"" data-send=""true"" data-width=""150"" data-show-faces=""false"" " &_
			' "data-action=""recommend"" data-font=""tahoma""></div></span>"
' else
	' social_blob = "<hr style=""margin:0.6em 0 0 -0.4em;color:#003366;background-color:#003366;height:1px;border-style: none;""><span class=""social-share"" style=""width:205px;""><!-- Place this tag where you want the +1 button to render -->" &_
			' "<g:plusone size=""medium"" annotation=""inline""></g:plusone></span>" &_
			' "<!-- twitter -->" &_
			' "<span class=""social-share""><a href=""https://twitter.com/share"" class=""twitter-share-button"" data-via=""PersonnelPlus"">"  &_
			' "Tweet</a></span>"&_
			' "<span class=""social-share""><div id=""fb-root""></div>" &_
			' "<div class=""fb-like"" data-href=""http://www.personnelinc.com"" data-send=""true"" data-width=""150"" data-show-faces=""false"" " &_
			' "data-action=""recommend"" data-font=""tahoma""></div></span>"

' end if

dim holdCrumbs, mobile_crumb
if is_mobile then 
	mobile_crumb = " borLtBlue"
	holdCrumbs = BreadCrumb(Request.ServerVariables("PATH_INFO"))
		header_response = header_response & "<div id=""bread" & mobile_crumb & """><ul><li class=""first"">" & holdCrumbs & "</li></ul>" &_
			"</div><div id=""contentwrapper""><div id=""contentcolumn""><div class=""innertube""><div></div></div></div></div>"
		'	[if uncommenting move up one line] social_blob &_
else
	holdCrumbs = BreadCrumb(Request.ServerVariables("PATH_INFO"))
		header_response = header_response & "<div id=""bread" & mobile_crumb & """><ul><li class=""first"">" & holdCrumbs & "</li></ul>" &_
			"</div><div id=""contentwrapper""><div id=""contentcolumn""><div class=""innertube""><div>"
		'	[if uncommenting move up one line] social_blob &_
end if
%>
