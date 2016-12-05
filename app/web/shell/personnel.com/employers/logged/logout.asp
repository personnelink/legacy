<%
'	*************************  File Description  *************************
'		FileName:		logout.asp
'		Description:	Employer logout page - removes all session vars, cookies and then abandons session.
'		Created:		Tuesday, February 17, 2004
'		Lastmod:
'		Developer(s):	James Werrbach
'	**********************************************************************
session("empAuth") = ""
response.cookies("employers") ("empAuth") = ""
response.cookies("employers") ("emailAddress") = ""
session.Contents.RemoveAll()
session.Abandon

response.redirect("/index.asp")
%>