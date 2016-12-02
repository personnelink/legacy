<%
'separate them with >> symbols and place link text
dim arryCrumbs(8)
dim nav_iteration : nav_iteration = -1

function LookUpBread (strBreadCrumb)
		nav_iteration = nav_iteration + 1
		arryCrumbs(nav_iteration) = strBreadCrumb
		dim intTmpReqId
   		Select Case strBreadCrumb
		Case "Main"
		 	LookUpBread = "" & _
				"<div id=""lnkPageBack"" style=""float:right;"">" & _
				ReverseBread(replace(request.serverVariables("HTTP_REFERER"), "https://www.personnelinc.com", "")) & "</div>"
	
		Case ""
			LookUpBread = "<a id=""lnkStartPage"" href=""/userHome.asp""  onclick=""grayOut(true);""><img src='/include/style/images/navigation/navUserHome.png'>Start Page</a>"
		
		Case "Attachments"
			LookUpBread = "<a href=""/include/system/tools/attachments/""> &#187; View Attachments</a><a href=""/include/system/tools/attachments/"" onclick=""grayOut(true)""> &#187; New search </a>"
		
		Case "Home"
		
		Case "Job Postings"
			LookUpBread = "<a href=""/include/system/tools/applicant/job_postings/""> &#187; Job Postings</a>"

		Case "Timecardemp"
			LookUpBread = "<a href=""/include/system/tools/timecardEmp.asp""> &#187; Manage Timecards</a>"

		Case "Whosebeenhere"
			LookUpBread = "<a href=""/include/system/tools/whoseBeenHere.asp""> &#187; Whose Been Here</a>"

		Case "Showtimedetail"
			LookUpBread = "<a href=""/include/system/tools/timecardEmp.asp""> &#187; Manage Timecards</a> &#187; Timecard Detail"

			
		Case "Userhome"
			LookUpBread = "<a href=""/userHome.asp""> &#187; Tools</a>"

		Case "Managelocations"
			LookUpBread = "<a href=""/include/system/tools/manageLocations.asp?Action=0""> &#187; Manage Locations</a>"

		Case "Manageusers"
			LookUpBread = "<a href=""/include/system/tools/manageUsers.asp""> &#187; Manage Users</a>"

		Case "Managedepartments"
			LookUpBread = "<a href=""/include/system/tools/manageDepartments.asp""> &#187; Manage Departments</a>"

		Case "Viewapplications"
			LookUpBread = "<a href=""/include/system/tools/activity/applications/view/""> &#187; Employment Applications</a>"
		
		Case "Whosehere"
			LookUpBread = "<a href=""/include/system/tools/whoseHere.asp""> &#187; Whose Here</a>"

        Case "Time Archive"
			LookUpBread = " &#187; Time Archive Report</a>"
		
		Case "Viewapplicants"
			intTmpReqId = request.QueryString("who")
			if len(intTmpReqId) > 0 then
				LookUpBread = "<a href=""/include/system/tools/manage/applicant/applicants/viewApplicants.asp""> &#187; View Applicants</a> &#187; Applicant # " & intTmpReqId
			else 
				LookUpBread = "<a href=""/include/system/tools/manage/applicant/applicants/viewApplicants.asp""> &#187; View Applicants</a>"
			end if

		Case "Maintainapplicant"
			intTmpReqId = request.QueryString("who")
			if len(intTmpReqId) > 0 then
				LookUpBread = "<a href=""/include/system/tools/manage/applicant/applicants/viewApplicants.asp""> &#187; View Applicants</a> &#187; Applicant # " & intTmpReqId
			else 
				LookUpBread = "<a href=""/include/system/tools/manage/applicant/applicants/viewApplicants.asp""> &#187; View Applicants</a>"
			end if
		
		Case "Maintainrequisitions"
				intTmpReqId = request.QueryString("RequisitionID")
			if len(intTmpReqId) > 0 then
				LookUpBread = " &#187; Requisition # " & intTmpReqId
			end if

		Case "Staff"
		 	LookUpBread = "<a href=""/include/content/blogs/staff/""> &#187; Staff Blog</a>"

		Case "Public"
		 	LookUpBread = "<a href=""/include/content/blogs/public/""> &#187; Public Blog</a>"

		Case "Blogs"
		 	LookUpBread = "<a href=""/include/content/blogs/""> &#187; Blogs</a>"

		Case "Stories"
		 	LookUpBread = ""

		Case "Content"
		 	LookUpBread = ""

		Case "Makeitread"
		 	LookUpBread = " &#187; <span style=""text-decoration:none"">Current Blog</span>"

		Case "Viewcustomers"
		 	LookUpBread = "<a href=""/include/system/tools/activity/viewCustomers.asp""> &#187; Maintain Customers</a>"

		Case "Viewattachments"
		 	LookUpBread = "<a href=""/include/system/tools/attachments/""> &#187; View Attachments</a>"
			
		Case "Requisitioncenter"
		 	LookUpBread = "<a href=""/include/system/include/system/tools/activity/forms/maintainRequisitions.asp?Action=0""> &#187; Maintain Requisistions</a>"
		
		Case ""
			LookUpBread = "<a href=""/include/system/tools/manageDepartments.asp""> &#187; Manage Departments</a>"
			
		Case Else
				LookUpBread = " &#187; <span style=""text-decoration:none"">" & strBreadCrumb & "</span>"
				
		End Select

end function


function ReverseBread (strBreadCrumb)
		' dim crumbs, crumb_pattern
		
		' crumbs = Split(strBreadCrumb, "/")
		
		' dim this
		' for this = 0 to ubound(crumbs)
			' if instr(crumbs(this), "?") = 0 and len(trim(crumbs(this))) > 0 then
				' if len(crumb_pattern) = 0 then
					' crumb_pattern = crumbs(this)
				' else
					' crumb_pattern = crumb_pattern & "_" & crumbs(this)
				' end if
			' end if
		' next
		
		
		if arryCrumbs(nav_iteration-1) = "Time Archive" then
				ReverseBread = "<a href=""https://www.personnelinc.com/include/system/tools/timecards/group/""  onclick=""grayOut(true);"">[ group time card ]</a>"
		end if
		
 end function


Function BreadCrumb(FullPath)
FullPath = Replace(FullPath, ".", "/")

dim Letters, notThese, useThisOne, thisOne, tmpPath, strTmpPath, DirPath, firstLetter, letter, PageTitle, i, crumbs, this, word
	Letters = array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
	notThese = array("tools", "activity", "system", "include", "asp", "forms")

	'if len(ifDev) > 0 then
	'	'if development url is the same as current
	'	'change possible urls in blogContent
	'	blogSubject = replace(blogSubject,  secureURL, ifDev)
	'	blogBody = replace(blogBody,  secureURL, ifDev)
	'end if

tmpPath = Split(FullPath, "/")
for this = 0 to ubound(tmpPath)
	strTmpPath = Trim(tmpPath(this))
	
	useThisOne = true
	for each word in notThese 
		if lcase(strTmpPath) = word then useThisOne = false
	next
	if useThisOne then
		strTmpPath = Pcase(strTmpPath)
	
		'## replace udnerscores with spaces and upshift the following character
		if instr(strTmpPath, "_") > 0 then
			for each letter in letters
				strTmpPath = Replace(Trim(strTmpPath),"_" & lcase(letter)," " & UCase(letter))
			next
		end if
		crumbs = crumbs & LookUpBread (strTmpPath)
	end if
next

IF PageTitle <> "" THEN crumbs = crumbs & " &#187; " & session("page_title")

BreadCrumb = crumbs
End Function 

dim strUserAgent, is_mobile
strUserAgent = request.serverVariables("HTTP_USER_AGENT")

if instr(strUserAgent, "iPhone") > 0 or instr(strUserAgent, "Android") > 0 or request.querystring("mobile") = "true" then
	is_mobile = true
end if	

%>
