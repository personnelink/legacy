<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<%
session.Contents.RemoveAll()
session.Abandon
session("auth") = ""
session("employerAuth") = ""
session("adminAuth") = ""

'response.cookies("employer") ("auth") = ""
'response.cookies("admin") ("auth") = ""
'response.cookies("seeker") ("auth") = ""

dim companyUserName	:	companyUserName = TRIM(request("companyUserName"))
dim password 		:	password = TRIM(request("password"))

Set rsEmployerProfile = Server.CreateObject("ADODB.Recordset")
rsEmployerProfile.Open "SELECT * FROM tbl_employers WHERE companyUserName ='" & companyUserName & "'", Connect, 3, 3

if rsEmployerProfile.RecordCount < 1 then response.redirect("/index2.asp?who=1&error=1")
if rsEmployerProfile("password") <> password then response.redirect("/index2.asp?who=1&error=2")
if rsEmployerProfile("suspended") = "Yes" then response.redirect("/index2.asp?who=1&error=3")
session("empID") = rsEmployerProfile("empID")
session("companyUserName") = companyUserName
session("companyType") = rsEmployerProfile("companyType")
company_name = rsEmployerProfile("companyName")
session("companyAgent") = rsEmployerProfile("companyAgent")
session("companyAgentTitle") = rsEmployerProfile("companyAgentTitle")
session("addressOne") = rsEmployerProfile("addressOne")
session("addressTwo") = rsEmployerProfile("addressTwo")
session("emailAddress") = rsEmployerProfile("emailAddress")
session("jobEmailAddress") = rsEmployerProfile("jobEmailAddress")
session("city") = rsEmployerProfile("city")
session("state") = rsEmployerProfile("state")
user_zip = rsEmployerProfile("zipCode")
session("country") = rsEmployerProfile("country")
company_phone = rsEmployerProfile("companyPhone")
session("faxNumber") = rsEmployerProfile("faxNumber")
session("suspended") = rsEmployerProfile("suspended")
session("dateCreated") = rsEmployerProfile("dateCreated")
session("employerAuth") = "true"



  response.cookies("employer").expires = Date + 31
  response.cookies("employer").path = "/"
  response.cookies("employer") ("auth") = "true"
  response.cookies("employer") ("companyUserName") = companyUserName
  response.cookies("employer") ("password") = password  
  response.cookies("employer") ("companyAgentName") = companyAgentName



response.redirect("/employers/registered/index.asp?who=1")
Set rsEmployerProfile = Nothing
%>