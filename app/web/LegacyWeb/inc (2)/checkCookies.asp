<%
' EMPLOYER cookie search
if request.cookies("employer") ("auth") = "true" and session("employerAuth") <> "true" then
  set rsSetSession = Server.CreateObject("ADODB.RecordSet")
  companyUserName = request.cookies("employer") ("companyUserName")
  rsSetSession.Open "SELECT empID,companyUserName,password,companyType,companyName,companyAgent,companyAgentTitle,addressOne,addressTwo,jobEmailAddress,emailAddress,city,state,zipCode,country,companyPhone,faxNumber,suspended,dateCreated FROM tbl_employers WHERE companyUserName = '" & companyUserName & "'",Connect,3,3
session("empID") = rsSetsession("empID")
session("companyUserName") = rsSetsession("companyUserName")
session("password") = rsSetsession("password")
session("companyType") = rsSetsession("companyType")
company_name = rsSetcompany_name
session("companyAgent") = rsSetsession("companyAgent")
session("companyAgentTitle") = rsSetsession("companyAgentTitle")
session("addressOne") = rsSetsession("addressOne")
session("addressTwo") = rsSetsession("addressTwo")
session("jobEmailAddress") = rsSetsession("jobEmailAddress")
session("emailAddress") = rsSetsession("emailAddress")
session("city") = rsSetsession("city")
session("state") = rsSetsession("state")
user_zip = rsSetuser_zip
session("country") = rsSetsession("country")
company_phone = rsSetcompany_phone
session("faxNumber") = rsSetsession("faxNumber")
session("suspended") = rsSetsession("suspended")
session("dateCreated") = rsSetsession("dateCreated")
session("employerAuth") = "true"

rsSetSession.Close
Set rsSetSession = Nothing
end if
%>

<%
'  SEEKER cookie search
if request.cookies("seeker") ("auth") = "true" and session("auth") <> "true" then
  set rsSetSession = Server.CreateObject("ADODB.RecordSet")
  userName = request.cookies("seeker") ("userName")
  rsSetSession.Open "SELECT seekID, firstName, lastName, userName, password, addressOne, addressTwo, contactPhone, emailAddress, numResumes, city, state, zipCode, dateCreated FROM tbl_seekers WHERE userName = '" & userName & "'",Connect,3,3

session("seekID") = rsSetsession("seekID")
user_firstname = rsSetuser_firstname
user_lastname = rsSetuser_lastname
user_name = userName
session("password") = rsSetsession("password")
session("addressOne") = rsSetsession("addressOne")
session("addressTwo") = rsSetsession("addressTwo")
session("city") = rsSetsession("city")
session("state") = rsSetsession("state")
user_zip = rsSetuser_zip
session("contactPhone") = rsSetsession("contactPhone")
session("emailAddress") = rsSetsession("emailAddress")
session("dateCreated") = rsSetsession("dateCreated")
session("numResumes") = rsSetsession("numResumes")
session("auth") = "true"  
  
rsSetSession.Close
Set rsSetSession = Nothing
end if
%>

<%
' ADMIN cookie search
if request.cookies("admin") ("auth") = "true" and session("adminAuth") <> "true" then
  set rsSetSession = Server.CreateObject("ADODB.RecordSet")
  userName = request.cookies("admin") ("userName")
  rsSetSession.Open "SELECT * FROM tbl_admin WHERE userName = '" & userName & "'",Connect,3,3
session("admID") = rsSetsession("admID")	
  user_firstname = rsSetuser_firstname
  user_lastname = rsSetuser_lastname
  session("emailAddress") = rsSetsession("emailAddress")  
  session("permitLevel") = rsSetsession("permitLevel")
  company_name = rsSetcompany_name  
  session("city") = rsSetsession("city")  
  session("state") = rsSetsession("state")    
  user_name = userName
  session("adminAuth") = "true"
  
rsSetSession.Close  
Set rsSetSession = Nothing
end if
%>