<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/loggedRedirect.asp' -->
<%

dim rsAddNewSeeker, rsGetNewSeekID, rsAddNewSeekerPreferences
dim rememberLogin		:	rememberLogin = session("temp_rememberMe")
' add new job seeker profile
Set rsAddNewSeeker = Server.CreateObject("ADODB.Recordset")
rsAddNewSeeker.Open "SELECT seekID,firstName,lastName,userName,password,addressOne,addressTwo,city,state,zipCode,country,contactPhone,emailAddress,suspended,numResumes,dateCreated FROM tbl_seekers", Connect,3,3
  rsAddNewSeeker.addnew
  rsAddNewSeeker("firstName") = session("temp_firstName")
  rsAddNewSeeker("lastName") = session("temp_lastName")
  rsAddNewSeeker("userName") = session("temp_userName")
  rsAddNewSeeker("password") = session("temp_password")
  rsAddNewSeeker("addressOne") = session("temp_addressOne")
  rsAddNewSeeker("addressTwo") = session("temp_addressTwo")
  rsAddNewSeeker("city") = session("temp_city")
  rsAddNewSeeker("state") = session("temp_state")
  rsAddNewSeeker("zipCode") = session("temp_zipCode")
  rsAddNewSeeker("country") = session("temp_country")
  rsAddNewSeeker("contactPhone") = session("temp_contactPhone")
  rsAddNewSeeker("emailAddress") = session("temp_emailAddress")
  rsAddNewSeeker("suspended") = "No"
  rsAddNewSeeker("numResumes") = 0
  rsAddNewSeeker("dateCreated") = now()         
  rsAddNewSeeker.Update

' get new job seeker id
Set rsGetNewSeekID = Server.CreateObject("ADODB.Recordset")
rsGetNewSeekID.Open "SELECT seekID, userName FROM tbl_seekers WHERE userName='" & session("temp_userName") & "'", Connect,3,3  
dim seekID	:	seekID = rsGetNewSeekID("seekID")

' add new job seeker preferences
Set rsAddNewSeekerPreferences = Server.CreateObject("ADODB.RecordSet")
rsAddNewSeekerPreferences.Open "SELECT seekID,userName,schedule,shift,wageType,wageAmount,qRelocate,relocateAreaOne,relocateAreaTwo,relocateAreaThree,commuteDist,workLegalStatus, workLegalProof FROM tbl_seekers_preferences WHERE seekID ='" & seekID & "'", Connect, 3, 3
 rsAddNewSeekerPreferences.addnew
rsAddNewSeekerPreferences("seekID") = seekID
rsAddNewSeekerPreferences("userName") = session("temp_userName")
rsAddNewSeekerPreferences("schedule") = request("schedule")
rsAddNewSeekerPreferences("shift") = request("shift")
rsAddNewSeekerPreferences("wageType") = request("wageType")
rsAddNewSeekerPreferences("wageAmount") = TRIM(request("wageAmount"))
rsAddNewSeekerPreferences("qRelocate") = request("qRelocate")
rsAddNewSeekerPreferences("relocateAreaOne") = request("relocateAreaOne")
rsAddNewSeekerPreferences("relocateAreaTwo") = request("relocateAreaTwo")
rsAddNewSeekerPreferences("relocateAreaThree") = request("relocateAreaThree")
rsAddNewSeekerPreferences("commuteDist") = request("commuteDist")
rsAddNewSeekerPreferences("workLegalStatus") = request("workLegalStatus")
rsAddNewSeekerPreferences("workLegalProof") = request("workLegalProof")
rsAddNewSeekerPreferences.update		

' set final session vars after clearing out temp session vars
session.Contents.RemoveAll()

Set rsSession = Server.CreateObject("ADODB.Recordset")
rsSession.Open "SELECT seekID, firstName, lastName, addressOne, addressTwo, city, state, zipCode, country, contactPhone, userName, password, emailAddress, numResumes, suspended, dateCreated FROM tbl_seekers WHERE seekID ='" & seekID & "'", Connect, 3, 3
session("seekID") = rsSession("seekID")
session("firstName") = rsSession("firstName")
session("lastName") = rsSession("lastName")
session("userName") = rsSession("userName")
session("password") = rsSession("password")
session("addressOne") = rsSession("addressOne")
session("addressTwo") = rsSession("addressTwo")
session("city") = rsSession("city")
session("state") = rsSession("state")
session("zipCode") = rsSession("zipCode")
session("contactPhone") = rsSession("contactPhone")
session("emailAddress") = rsSession("emailAddress")
session("dateCreated") = rsSession("dateCreated")
session("numResumes") = rsSession("numResumes")
session("auth") = "true"

' set Cookies if asked
if rememberLogin = "Yes" then
		response.cookies("seeker").expires = Date + 31
		response.cookies("seeker").path = "/"		
		response.cookies("seeker") ("auth") = "true"
		response.cookies("seeker") ("userName") = session("userName")
		response.cookies("seeker") ("password") = session("password")		
end if

' add default message
Set rsMessages = Server.CreateObject("ADODB.RecordSet")
rsMessages.Open "SELECT msgID,userName,accountType,msgSubject,msgBody,msgType,msgRead,msgFrom,msgCreationDate FROM tbl_messages",Connect,3,3

 rsMessages.AddNew
rsMessages("userName") = session("userName")
rsMessages("accountType") = "Seeker"
rsMessages("msgSubject") = "Welcome new user"
rsMessages("msgBody") = "/messages/welcome.html"
rsMessages("msgType") = "File"
rsMessages("msgRead") = "No"
rsMessages("msgFrom") = "Personnel Plus Staff"
rsMessages("msgCreationDate") = now()
 rsMessages.Update

' send new registration receipt to job seeker
fileName = Server.MapPath("/messages/welcome.html")
Set fileSys = Server.CreateObject("Scripting.FileSystemObject")
Set file = fileSys.OpenTextFile(fileName,1)
msgBody = file.ReadAll
file.Close

' [ MailSender ] 

msgBody = msgBody & chr(10) & chr(10) & "- New Job Seeker Account Information -" & chr(10) & chr(10)
msgBody = msgBody & "User Name:" & Session("userName") & chr(13)
msgBody = msgBody & "Password:" & Session("password") & chr(10)
msgBody = msgBody & "Registered Email Address:" & Session("emailAddress") & chr(13)

'Set Mail = Server.CreateObject("Persits.MailSender")
'Mail.Host = "mail.personnelplus-inc.com"
'Mail.Username = ""
'Mail.Password = ""
'Mail.Port = 25
'Mail.AddAddress "applicants@personnelplus-inc.com"
'Mail.AddBcc "jwerrba@cableone.net"
'Mail.From = "webmaster@personnelplus-inc.com"
'Mail.FromName = "Personnel Plus"
'Mail.Subject = "Welcome to Personnel Plus, " & session("firstName") & "!"
'Mail.Body = msgBody
'Mail.Send
'Set Mail = Nothing
%>

<%
' clean up
rsAddNewSeeker.Close
rsGetNewSeekID.Close 
rsAddNewSeekerPreferences.Close 
rsSession.Close
rsMessages.Close

set rsAddNewSeeker = Nothing
set rsGetNewSeekID = Nothing
set rsAddNewSeekerPreferences = Nothing
set rsSession = Nothing
set rsMessages = Nothing


response.redirect("/lweb/seekers/registered/applyOnline.asp?who=2")
%>
