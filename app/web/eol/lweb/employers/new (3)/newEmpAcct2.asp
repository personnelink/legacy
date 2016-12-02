<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<% 
if session("employerAuth") = "true" then
response.redirect("/lweb/employers/registered/index.asp?who=1")
end if
%>
<%
dim companyUserName		:	companyUserName = TRIM(request("uN"))
dim password			:	password = TRIM(request("uNer"))
dim companyType			:	companyType = request("companyType")
dim rsFindDupe, sqlFindDupe

sqlFindDupe = "SELECT count(companyUserName) AS theCount FROM tbl_employers WHERE companyUserName = '" & companyUserName & "'"
Set rsFindDupe = Connect.Execute(sqlFindDupe)

IF rsFindDupe("theCount") <> 0 THEN
' DO NOT ADD
 Error = 1
  response.redirect("newEmpAcct1.asp?error=1&?who=1&nameTaken=" & companyUserName)
  rsFindDupe.Close  
ELSE
' START OUR SESSION TEMPS
session("temp_companyUserName") = companyUserName
session("temp_password") = password
session("temp_companyType") = companyType
session("temp_rememberMe") = request("rememberMe")

rsFindDupe.Close  
  response.redirect("newEmpAcct3.asp")
END IF
%>
