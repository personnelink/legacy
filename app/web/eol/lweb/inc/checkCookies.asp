<%
' EMPLOYER cookie search
if request.cookies("employer") ("auth") = "true" and session("employerAuth") <> "true" then
  set rsSetSession = Server.CreateObject("ADODB.RecordSet")
  companyUserName = request.cookies("employer") ("companyUserName")
  rsSetSession.Open "SELECT empID,companyUserName,password,companyType,companyName,companyAgent,companyAgentTitle,addressOne,addressTwo,jobEmailAddress,emailAddress,city,state,zipCode,country,companyPhone,faxNumber,suspended,dateCreated FROM tbl_employers WHERE companyUserName = '" & companyUserName & "'",Connect,3,3
session("empID") = rsSetSession("empID")
session("companyUserName") = rsSetSession("companyUserName")
session("password") = rsSetSession("password")
session("companyType") = rsSetSession("companyType")
session("companyName") = rsSetSession("companyName")
session("companyAgent") = rsSetSession("companyAgent")
session("companyAgentTitle") = rsSetSession("companyAgentTitle")
session("addressOne") = rsSetSession("addressOne")
session("addressTwo") = rsSetSession("addressTwo")
session("jobEmailAddress") = rsSetSession("jobEmailAddress")
session("emailAddress") = rsSetSession("emailAddress")
session("city") = rsSetSession("city")
session("state") = rsSetSession("state")
session("zipCode") = rsSetSession("zipCode")
session("country") = rsSetSession("country")
session("companyPhone") = rsSetSession("companyPhone")
session("faxNumber") = rsSetSession("faxNumber")
session("suspended") = rsSetSession("suspended")
session("dateCreated") = rsSetSession("dateCreated")
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

session("seekID") = rsSetSession("seekID")
session("firstName") = rsSetSession("firstName")
session("lastName") = rsSetSession("lastName")
session("userName") = userName
session("password") = rsSetSession("password")
session("addressOne") = rsSetSession("addressOne")
session("addressTwo") = rsSetSession("addressTwo")
session("city") = rsSetSession("city")
session("state") = rsSetSession("state")
session("zipCode") = rsSetSession("zipCode")
session("contactPhone") = rsSetSession("contactPhone")
session("emailAddress") = rsSetSession("emailAddress")
session("dateCreated") = rsSetSession("dateCreated")
session("numResumes") = rsSetSession("numResumes")
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
session("admID") = rsSetSession("admID")	
  session("firstName") = rsSetSession("firstName")
  session("lastName") = rsSetSession("lastName")
  session("emailAddress") = rsSetSession("emailAddress")  
  session("permitLevel") = rsSetSession("permitLevel")
  session("companyName") = rsSetSession("companyName")  
  session("city") = rsSetSession("city")  
  session("state") = rsSetSession("state")    
  session("userName") = userName
  session("adminAuth") = "true"
  
rsSetSession.Close  
Set rsSetSession = Nothing
end if
%>