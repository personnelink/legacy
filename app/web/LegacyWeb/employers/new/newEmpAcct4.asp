<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
<% 
if session("employerAuth") = "true" then
response.redirect("/employers/registered/index.asp")
end if
%>

<%
dim rsAddEmployer, rsGetNewEmpID
dim rememberLogin		:	rememberLogin = session("temp_rememberMe")
dim zipCode
if TRIM(request("zipCodePlus4")) <> "" then
 zipCode = TRIM(request("zipCode")) & "-" & TRIM(request("zipCodePlus4"))
 Else
 zipCode = TRIM(request("zipCode"))
End if 

' add new employer
Set rsAddEmployer = Server.CreateObject("ADODB.Recordset")
rsAddEmployer.Open "SELECT empID, companyUserName, password, companyType, companyName, companyAgent, companyAgentTitle, addressOne, addressTwo, jobEmailAddress, emailAddress, city, state, zipCode, country, companyPhone, faxNumber, suspended, dateCreated, dateLastSearched FROM tbl_employers",Connect,3,3
rsAddEmployer.addNew
rsAddEmployer("companyUserName") = TRIM(session("temp_companyUserName"))
rsAddEmployer("password") = TRIM(session("temp_password"))
rsAddEmployer("companyType") = TRIM(session("temp_companyType"))
rsAddEmployer("companyName") = ConvertString(TRIM(request("companyName")))
rsAddEmployer("companyAgent") = PCase(TRIM(request("companyAgentFirstName"))) + " " + PCase(TRIM(request("companyAgentLastName")))
rsAddEmployer("companyAgentTitle") = ConvertString(PCase(TRIM(request("companyAgentTitle"))))
rsAddEmployer("addressOne") = ConvertString(Pcase(TRIM(request("addressOne"))))
rsAddEmployer("addressTwo") = ConvertString(Pcase(TRIM(request("addressTwo"))))
rsAddEmployer("jobEmailAddress") = TRIM(request("emailAddress"))
rsAddEmployer("emailAddress") = TRIM(request("emailAddress"))
rsAddEmployer("city") = ConvertString(PCase(TRIM(request("city"))))
rsAddEmployer("state") = request("state")
rsAddEmployer("zipCode") = request("zipCode")
rsAddEmployer("country") = request("country")
rsAddEmployer("companyPhone") = ConvertString(TRIM(request("companyPhone")))
rsAddEmployer("faxNumber") = ConvertString(TRIM(request("faxNumber")))
rsAddEmployer("suspended") = "No"
rsAddEmployer("dateCreated") = now()
rsAddEmployer.update

' get new employer id
Set rsGetNewEmpID = Server.CreateObject("ADODB.Recordset")
rsGetNewEmpID.Open "SELECT empID, companyUserName FROM tbl_employers WHERE companyUserName='" & session("temp_companyUserName") & "'", Connect,3,3  
dim empID	:	empID = rsGetNewEmpID("empID")

' set final session vars after clearing out temp session vars
session.Contents.RemoveAll()

Set rsSession = Server.CreateObject("ADODB.Recordset")
rsSession.Open "SELECT empID, companyUserName, password, companyType, companyName, companyAgent, companyAgentTitle, addressOne, addressTwo, jobEmailAddress, emailAddress, city, state, zipCode, country, companyPhone, faxNumber, suspended, dateCreated, dateLastSearched FROM tbl_employers WHERE empID ='" & empID & "'",Connect,3,3
session("empID") = empID
session("companyUserName") = rssession("companyUserName")
session("password") = rssession("password")
session("companyType") = rssession("companyType")
company_name = rscompany_name
session("companyAgent") = rssession("companyAgent")
session("companyAgentTitle") = rssession("companyAgentTitle")
session("addressOne") = rssession("addressOne")
session("addressTwo") = rssession("addressTwo")
session("jobEmailAddress") = rssession("jobEmailAddress")
session("emailAddress") = rssession("emailAddress")
session("city") = rssession("city")
session("state") = rssession("state")
user_zip = rsuser_zip
session("country") = rssession("country")
company_phone = rscompany_phone
session("faxNumber") = rssession("faxNumber")
session("suspended") = rssession("suspended")
session("dateCreated") = rssession("dateCreated")
session("employerAuth") = "true"

' set Cookies if asked
if rememberLogin = "Yes" then
		response.cookies("employer").expires = Date + 31
		response.cookies("employer").path = "/"		
		response.cookies("employer") ("auth") = "true"
		response.cookies("employer") ("companyUserName") = session("companyUserName")
		response.cookies("employer") ("password") = session("password")		
End if

' add default message
Set rsMessages = Server.CreateObject("ADODB.RecordSet")
rsMessages.Open "SELECT msgID,userName,accountType,msgSubject,msgBody,msgType,msgRead,msgFrom,msgCreationDate FROM tbl_messages",Connect,3,3

 rsMessages.AddNew
rsMessages("userName") = session("companyUserName")
rsMessages("accountType") = "Employer"
rsMessages("msgSubject") = "Welcome new employer!"
rsMessages("msgBody") = "/messages/employerWelcome.html"
rsMessages("msgType") = "File"
rsMessages("msgRead") = "No"
rsMessages("msgFrom") = "Personnel Plus Staff"
rsMessages("msgCreationDate") = now()
 rsMessages.Update

' [ MailSender ]
fileName = Server.MapPath("/messages/employerWelcome.html")
Set fileSys = Server.CreateObject("Scripting.FileSystemObject")
Set file = fileSys.OpenTextFile(fileName,1)
msgBody = file.ReadAll
file.Close

msgBody = msgBody & chr(10) & chr(10) & "- New Employer Account Registration Information -" & chr(10) & chr(10)
msgBody = msgBody & "User Name:" & session("companyUserName") & chr(13)
msgBody = msgBody & "Password:" & session("password") & chr(10)
msgBody = msgBody & "Registered Email Address:" & session("emailAddress") & chr(13)

' *** Jan 8th 2006 - Removed Employer Welcome Email Script ***

' clean up
rsAddEmployer.Close
rsGetNewEmpID.Close
rsSession.Close
rsMessages.Close

set rsAddEmployer=Nothing
set rsGetNewEmpID=Nothing
set rsSession=Nothing
set rsMessages=Nothing


response.redirect("/employers/registered/index.asp?who=1")
%>

