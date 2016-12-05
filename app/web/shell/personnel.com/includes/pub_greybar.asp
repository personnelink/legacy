<%
if session("mbrAuth") = "true" then
%>
  &nbsp;&nbsp;&nbsp;<a href='/registered/logged/index.asp' class=sideMenu>Home</a>&nbsp;&nbsp;
  &#149;&nbsp;&nbsp;<a href='/registered/logged/search/index.asp' class=sideMenu>Search Jobs</a>&nbsp;&nbsp; 
  &#149; &nbsp;&nbsp;<a href='/registered/logged/resume/index.asp' class=sideMenu>Resume Center</a>&nbsp;&nbsp; 
  &#149; &nbsp;&nbsp;<a href='/registered/logged/career/index.asp' class=sideMenu>Career Resources</a>&nbsp;&nbsp;
  &#149; &nbsp;&nbsp;<a href='/registered/logged/account/index.asp' class=sideMenu>Account Options</a>&nbsp;&nbsp;
  &#149; &nbsp;&nbsp;<a href='/registered/logged/logout.asp' class=sideMenu>Logout</a>&nbsp;&nbsp; 
<%
elseif session("empAuth") = "true" then
%>
  &nbsp;&nbsp;<a href='/employers/logged/index.asp' class=sideMenu>Home</a>&nbsp;&nbsp;
  &#149; &nbsp;&nbsp;<A HREF='/employers/logged/listing/index.asp' class=sideMenu>Job Listings</A>&nbsp;&nbsp;
  &#149; &nbsp;&nbsp;<A HREF='/employers/logged/search/index.asp' class=sideMenu>Resume Search</A>&nbsp;&nbsp;
  &#149; &nbsp;&nbsp;<A HREF='/employers/logged/resumes/index.asp' class=sideMenu>Applicants</A>&nbsp;&nbsp;
  &#149; &nbsp;&nbsp;<A HREF='/employers/logged/account/index.asp' class=sideMenu>Account Options</A>&nbsp;&nbsp;
  &#149; &nbsp;&nbsp;<A HREF='/employers/logged/logout.asp' class=sideMenu>Logout</A>&nbsp;&nbsp;
<%
else
  response.write("&nbsp;")
end if
%>
