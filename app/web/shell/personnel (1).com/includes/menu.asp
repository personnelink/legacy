<%

if session("mbrAuth") = "true" then
  response.write("<table width=100% border=0 cellspacing=0 cellpadding=3><tr><td>" & VBCRLF)
  response.write("<FONT COLOR=#FFFFFF>")
  
  response.write(" &nbsp;&nbsp;<a href='/registered/logged/index.asp' class=headmenu>Welcome</a>&nbsp;&nbsp;")
  
  response.write(" &#149; &nbsp;&nbsp;<A HREF='/registered/logged/search/index.asp' class=headmenu>Search Jobs</A>&nbsp;&nbsp;")

  response.write(" &#149; &nbsp;&nbsp;<A HREF='/registered/logged/resume/index.asp' class=headmenu>Resume Center</A>&nbsp;&nbsp;")

  response.write(" &#149; &nbsp;&nbsp;<A HREF='/registered/logged/career/index.asp' class=headmenu>Career Resources</A>&nbsp;&nbsp;")

  response.write(" &#149; &nbsp;&nbsp;<A HREF='/registered/logged/account/index.asp' class=headmenu>Account Options</A>&nbsp;&nbsp;")

  response.write(" &#149; &nbsp;&nbsp;<A HREF='/registered/logged/help/index.asp' class=headmenu>Help</A>&nbsp;&nbsp;")

  if request.serverVariables("URL") = "/index.asp" then
    response.write(" &#149; &nbsp;&nbsp;<A HREF='/registered/logged/logout.asp' class=headmenu>Logout</A>&nbsp;&nbsp;")

  end if
  response.write("</FONT></td></tr></table>" & VBCRLF)


elseif session("empAuth") = "true" then
  response.write("<table width=100% border=0 cellspacing=0 cellpadding=3><tr><td>" & VBCRLF)
  response.write("<FONT COLOR=#FFFFFF>")
  response.write(" &nbsp;&nbsp;<a href='/employers/logged/index.asp' class=headmenu>Welcome</a>&nbsp;&nbsp;")
  response.write(" &#149; &nbsp;&nbsp;<A HREF='/employers/logged/listing/index.asp' class=headmenu>Job Listings/Postings</A>&nbsp;&nbsp;")
  response.write(" &#149; &nbsp;&nbsp;<a href='/search/index.asp' class=headmenu>Search Jobs</a>&nbsp;&nbsp;")
  response.write(" &#149; &nbsp;&nbsp;<A HREF='/employers/logged/search/index.asp' class=headmenu>Resume Search</A>&nbsp;&nbsp;")
  response.write(" &#149; &nbsp;&nbsp;<A HREF='/employers/logged/resumes/index.asp' class=headmenu>Applicants</A>&nbsp;&nbsp;")
  response.write(" &#149; &nbsp;&nbsp;<A HREF='/employers/logged/account/index.asp' class=headmenu>Account Options</A>&nbsp;&nbsp;")
  response.write(" &#149; &nbsp;&nbsp;<A HREF='/employers/logged/help/index.asp' class=headmenu>Help</A>&nbsp;&nbsp;")  
  if request.serverVariables("URL") = "/index.asp" then
    response.write(" &#149; &nbsp;&nbsp;<A HREF='/employers/logged/logout.asp' class=headmenu>Logout</A>&nbsp;&nbsp;")
  end if
  response.write("</FONT></td></tr></table>" & VBCRLF)
  
elseif session("admAuth") = "true" then

else
  response.write("<table width=100% border=0 cellspacing=0 cellpadding=3><tr><td>" & VBCRLF)
  response.write("<FONT COLOR=#FFFFFF>")
  response.write(" &nbsp;&nbsp;<A HREF='/index.asp' class=headmenu><strong>Home</strong></A>&nbsp;&nbsp;")
  response.write(" &#149; &nbsp;&nbsp;<a href='/search/index.asp' class=headmenu><strong>Search Jobs</strong></a>&nbsp;&nbsp;")
  response.write(" &#149; &nbsp;&nbsp;<A HREF='/chooseLogin.asp' class=headmenu><strong>Login Now!</strong></A>&nbsp;&nbsp;")
  response.write(" &#149; &nbsp;&nbsp;<A HREF='/registered/login.asp' class=headmenu><strong>Post a Resume</strong></A>&nbsp;&nbsp;")
  response.write(" &#149; &nbsp;&nbsp;<A HREF='/employers/login.asp' class=headmenu><strong>Post a Job</strong></A>&nbsp;&nbsp;")
  response.write(" &#149; &nbsp;&nbsp;<A HREF='/help/index.asp' class=headmenu><strong>First Time Users</strong></A>&nbsp;&nbsp;")
  response.write("</font></td></tr></table>" & VBCRLF)
end if

%>