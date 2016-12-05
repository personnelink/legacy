<%
if session("mbrAuth") = "true" then
dim thePage, Paths, A, Out, i
  thePage = request.serverVariables("URL")
  Paths = Split(thePage,"/")
  A = " > "

  Out = "&nbsp;&nbsp;<A HREF='/index.asp' class=sideMenu>Home</A>" & A
  
  for i = 0 to ubound(paths)
    select case paths(i)
	case "bookmark.asp"
      out = out & "<font class='sideMenu'>Bookmark Us</font>"		
    case "registered"
      out = out & "<A HREF='/registered/login.asp' class=sideMenu>Member</A>" & A
	case "logged"
      out = out & "<A HREF='/registered/logged/index.asp' class=sideMenu>Welcome</A>" & A
	case "messages"
      out = out & "<A HREF='/registered/logged/messages/index.asp' class=sideMenu>Message Center</A>" & A
	case "resume"
      out = out & "<A HREF='/registered/logged/resume/index.asp' class=sideMenu>Resume Center</A>" & A
	case "search"
	  if session("mbrAuth") = "true" then
        out = out & "<A HREF='/registered/logged/search/index.asp' class=sideMenu>Search Jobs</A>" & A
	  else
        out = out & "<A HREF='/search/index.asp' class=sideMenu>Search Jobs</A>" & A
      end if
	case "career"
      out = out & "<A HREF='/registered/logged/career/index.asp' class=sideMenu>Career Resources</A>" & A
	case "account"
      out = out & "<A HREF='/registered/logged/account/index.asp' class=sideMenu>Account Options</A>" & A
	case "newResume"
      out = out & "<A HREF='/registered/logged/resume/newResume/index.asp' class=sideMenu>New Resume</A>" & A
	case "edit"
      out = out & "<font class='sideMenu'>Resume Editor</font>" & A
	case "privacy.asp"
      out = out & "<font class='sideMenu'>Privacy Committment</font>"
	case "resumeHelp"
      out = out & "<A HREF='/registered/logged/resume/resumeHelp/help.asp' class=sideMenu>Resume Help / Advice</A>" & A
    case "help"
      out = out & "<A HREF='/registered/logged/help/index.asp' class=sideMenu>Help System</A>" & A
    end select
  next

  response.write Out
end if

if session("empAuth") = "true" then
  thePage = request.serverVariables("URL")
  Paths = Split(thePage,"/")
  A = " > "

  Out = "&nbsp;&nbsp;<A HREF='/index.asp' class=sideMenu>Home</A>" & A
  
  for i = 0 to ubound(paths)
    select case paths(i)

    case "employers"
      out = out & "<A HREF='/employers/login.asp' class=sideMenu>Employers</A>" & A
	case "logged"
      out = out & "<A HREF='/employers/logged/index.asp' class=sideMenu>Welcome</A>" & A
	case "billing"
      out = out & "<A HREF='/employers/logged/billing/index.asp' class=sideMenu>Billing Information</A>" & A
	case "listing"
      out = out & "<A HREF='/employers/logged/listing/index.asp' class=sideMenu>Job Listings Manager</A>" & A
	case "resumes"
      out = out & "<A HREF='/employers/logged/resumes/index.asp' class=sideMenu>Applicants</A>" & A
	case "account"
      out = out & "<A HREF='/employers/logged/account/index.asp' class=sideMenu>Account Options</A>" & A
	case "search"
      out = out & "<A HREF='/employers/logged/search/index.asp' class=sideMenu>Resume Search</A>" & A
	case "jobHits"
	  out = out & "<A HREF='/employers/logged/jobHits/showCounts.asp' class=sideMenu>Job Hit Counts</A>" & A
	case "messages"
	  out = out & "<A HREF='/employers/logged/messages/index.asp' class=sideMenu>Message Center</A>" & A
	case "help"
      out = out & "<A HREF='/employers/logged/help/index.asp' class=sideMenu>Help System</A>" & A
    end select
  next

  response.write Out
end if
%>

