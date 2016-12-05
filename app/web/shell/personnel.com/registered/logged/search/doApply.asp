<% response.buffer = true%>
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<%
if Request("resID") = "" then
Response.Redirect("apply.asp?error=2")
end if

dim job_id			:	job_id = Request("jobID")
dim res_id			:	res_id = Request("resID")
dim mbr_id			:	mbr_id = session("mbrID")
dim emp_id			:	emp_id = Request("empID")
dim job_title		:	job_title = Request("jobTitle")
dim job_number		:	job_number = Request("jobNumber")
dim job_city		:	job_city = Request("jobCity")
dim job_location	:	job_location = Request("jobLocation")


' // INSERT application record and get the record number
dim rsApp, sqlApp, rsID, qID, newAppID
qID = "SELECT LAST_INSERT_ID() AS new_app_id;"
sqlApp = "INSERT INTO tbl_applications (job_id, res_id, mbr_id, emp_id, app_is_deleted, app_date_created) VALUES (" & _
"'" & job_id & "'," & _
"'" & res_id & "'," & _
"'" & mbr_id & "'," & _
"'" & emp_id & "'," & _
"" & 0 & "," & _
" NOW()" & ")"
Set rsApp = Connect.Execute(sqlApp)
Set rsID = Connect.Execute(qID)
newAppID = rsID("new_app_id")
Set rsApp = Nothing
Set rsID = Nothing

' // Check for resume filename
Set rsResume = Server.CreateObject("ADODB.RecordSet")
rsResume.CursorLocation = 3
rsResume.Open "SELECT res_id, res_filename, res_title FROM tbl_resumes WHERE res_id = " & res_id,Connect
dim res_filename		:	res_filename = rsResume("res_filename")
dim res_title			:	res_title = rsResume("res_title")
rsResume.Close
Set rsResume = Nothing

' // Get employer job email address or email address
Set rsEmp = Server.CreateObject("ADODB.RecordSet")
rsEmp.CursorLocation = 3
rsEmp.Open "SELECT emp_id, emp_company_name, emp_email_address, emp_job_email_address FROM tbl_employers WHERE emp_id = " & emp_id,Connect
dim emp_company_name	:	emp_company_name = rsEmp("emp_company_name")
dim emp_email_address
if TRIM(rsEmp("emp_job_email_address")) <> "" then
  emp_email_address = TRIM(rsEmp("emp_job_email_address"))
  Else
  emp_email_address = TRIM(rsEmp("emp_email_address"))
End IF
rsEmp.Close
Set rsEmp = Nothing

' // Build & Insert new message to employer
dim rsEmpMsg, sqlEmpMsg
dim emp_msg_subject		:	emp_msg_subject = "NEW Application for Job #" & job_number
dim emp_msg_type		:	emp_msg_type = "sys"
dim emp_msg_from		:	emp_msg_from = "Applicant Manager"
dim emp_msg_body, emp_msg_body_final

emp_msg_body = "You have received an application from <strong>" & user_firstname & " " & user_lastname & "</strong> for the listed position of:<br> <strong>" & job_title & "</strong> (Job #" & job_number & ")."
emp_msg_body = emp_msg_body & "<br><br>To view this applicant's resume, visit the <a href="&"'"&"/employers/logged/resumes/index.asp"&"'"&">Applicant Manager</a>."
emp_msg_body = emp_msg_body & "<br><br>if you need to modify your job listing(s) on our site, visit the <a href="&"'"&"/employers/logged/listing/index.asp"&"'"&">Job Listings Manager</a>."

emp_msg_body_final = ConvertString(emp_msg_body) ' Replace occurances of "'"

sqlEmpMsg = "INSERT INTO tbl_employer_messages (emp_id, msg_subject, msg_is_read, msg_type, msg_from, msg_date_created, msg_body) VALUES (" & _
"" & emp_id & "," & _
"'" & emp_msg_subject & "'," & _
"" & 0 & "," & _
"'" & emp_msg_type & "'," & _
"'" & emp_msg_from & "'," & _
" NOW(), " & _
"'" & emp_msg_body_final & "')"
Set rsEmpMsg = Connect.Execute(sqlEmpMsg)
Set rsEmpMsg = Nothing

' // Build & Insert new message for member (applicant)
dim rsMbrMsg, sqlMbrMsg
dim mbr_msg_subject		:	mbr_msg_subject = "Job Application Sent - " & job_number
dim mbr_msg_type		:	mbr_msg_type = "sys"
dim mbr_msg_from		:	mbr_msg_from = "Job Applicant Manager"
dim mbr_msg_body, mbr_msg_body_final

mbr_msg_body = "On " & FormatDateTime(Now(),1) & ", you applied online for the following position:<p></p> <A HREF='/registered/logged/search/viewJob.asp?id=" & job_id & "'><STRONG>" & job_title & "</STRONG></A>" & " [Job # " & "<A HREF='/registered/logged/search/viewJob.asp?id=" & job_id & "'><STRONG>" & job_number & "</STRONG></A>]<br> Posted by <STRONG>" & emp_company_name & "</STRONG><p></p>The following resume was included with your application:"

' // Check which kind of resume we have and give correct link - empty or pasted
if res_filename <> "empty" then
  mbr_msg_body = mbr_msg_body + " <A HREF='/registered/logged/resume/viewResume2.asp?id=" & res_id & "'><STRONG>" & res_title & "</STRONG></A>."
Else
  mbr_msg_body = mbr_msg_body + " <A HREF='/registered/logged/resume/viewResume.asp?id=" & res_id & "'><STRONG>" & res_title & "</STRONG></A>."
end if

mbr_msg_body_final = ConvertString(mbr_msg_body) ' Replace occurances of "'"
sqlMbrMsg = "INSERT INTO tbl_member_messages (mbr_id, msg_subject, msg_is_read, msg_type, msg_from, msg_date_created, msg_body) VALUES (" & _
"" & mbr_id & "," & _
"'" & mbr_msg_subject & "'," & _
"" & 0 & "," & _
"'" & mbr_msg_type & "'," & _
"'" & mbr_msg_from & "'," & _
" NOW(), " & _
"'" & mbr_msg_body_final & "')"
Set rsMbrMsg = Connect.Execute(sqlMbrMsg)
Set rsMbrMsg = Nothing


' // Build and E-Mail notice to Employer
dim msgbody
msgBody = "You have recieved an application from " & user_firstname & " " & user_lastname & " "
msgBody = msgBody & "for the following position that you have listed on www.personnel.com :" & chr(10) & chr(10)
msgBody = msgBody & "Job Title: " & job_title & chr(10) & "Job Location: " & job_city & ", " & job_location & chr(10) & "Job #: " & job_number

if res_filename <> "empty" then
	msgBody = msgBody & chr(10) & chr(10) & "To view this applicants resume, please visit:" & chr(10) & "http://www.personnel.com/messages/viewResume2.asp?id=" & res_id
Else
	msgBody = msgBody & chr(10) & chr(10) & "To view this applicants resume, please visit:" & chr(10) & "http://www.personnel.com/messages/viewResume.asp?id=" & res_id
end if
msgBody = msgBody & chr(10) & chr(10) & "To modify your job listing(s) and manage received job applications, please log-in at:" & chr(10) & "http://www.personnel.com/employers/login.asp "
msgBody = msgBody & chr(10) & chr(10) & chr(10) & "(This message was automatically generated by the Applicant Manager, there is no need to reply.)"

' ---- / aspSmartMail ----
'	On error resume next

	dim mySmartMail
	Set mySmartMail = Server.CreateObject("aspSmartMail.SmartMail")
'	-- Mail Server
	mySmartMail.Server = "127.0.0.1"
'	mySmartMail.ServerPort = 25
	mySmartMail.ServerTimeOut = 35
'	-- From
'	mySmartMail.SenderName = "Your Name"
	mySmartMail.SenderAddress = "applicant_manager@personnel.com"
'	-- To
	mySmartMail.Recipients.Add emp_email_address, emp_email_address
'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"
'	-- Blind carbon copy
	mySmartMail.BCCs.Add "tmayer@personnel.com", ""
	mySmartMail.BCCs.Add "monitor@personnel.com", ""
'	-- Reply To
	mySmartMail.ReplyTos.Add "applicant_manager@personnel.com", "applicant_manager@personnel.com"
'	-- Message
	mySmartMail.Subject = "NEW Job Application from www.personnel.com"
	mySmartMail.Body = msgBody
'	-- Optional Parameters
	mySmartMail.Organization = "Personnel.com"
'	mySmartMail.XMailer = "Your Web App Name"
	mySmartMail.Priority = 3
	mySmartMail.ReturnReceipt = false
	mySmartMail.ConfirmRead = false
	mySmartMail.ContentType = "text/plain"
	mySmartMail.Charset = "us-ascii"
	mySmartMail.Encoding = "base64"
'	-- Attached file
'	mySmartMail.Attachments.Add Server.MapPath("\aspSmartMail\sample.txt"),, false
'	-- Send the message
	mySmartMail.SendMail

'	-- Error handling
	if err.number <> 0 then
		response.write("Error n° " &  err.number - vbobjecterror & " = " & err.description  & "<br>")
	else
'		response.write "aspSmartMail has sent your message with this file as attachment : <br>"
'		response.write mySmartMail.Attachments.Item(1).FilePathName
	end if

' hold off on destroying mySmartMail object until after Member Email is sent...
'	set mySmartMail = nothing
' ---- aspSmartMail / ----


' // Build and Send E-Mail receipt to Member
dim msgBody2
msgBody2 = user_firstname & " " & user_lastname & "," & chr(13)
msgBody2 = msgBody2 & "On " & FormatDateTime(Now(),1) & ", you applied online for the job position listed below:" & chr(10) & chr(10) & "Job Title: " & job_title & " (Job #" & job_number & ")" & chr(13) & "Company: " & emp_company_name & chr(13) & "Location: " & job_city & ", " & job_location & chr(10) & chr(10)
msgBody2 = msgBody2 & "Your Resume Title: " & res_title & chr(10) & chr(10)
msgBody2 = msgBody2 & "To review the complete description of this job, please visit:" & chr(13)
msgBody2 = msgBody2 & "http://www.personnel.com/search/viewJob.asp?id=" & job_id & chr(10) & chr(10)
msgBody2 = msgBody2 & "if you need to make changes to your resume or contact information please log-in at: http://www.personnel.com/registered/login.asp"
msgBody2 = msgBody2 & chr(10) & chr(10) & chr(10) & "(This message was automatically generated by the Applicant Manager, there is no need to reply.)"

' ---- / aspSmartMail ----
'	On error resume next

'	dim mySmartMail
'	Set mySmartMail = Server.CreateObject("aspSmartMail.SmartMail")
'	-- Mail Server
	mySmartMail.Server = "127.0.0.1"
'	mySmartMail.ServerPort = 25
	mySmartMail.ServerTimeOut = 35
'	-- From
'	mySmartMail.SenderName = "Your Name"
	mySmartMail.SenderAddress = "applicant_manager@personnel.com"
'	-- To
	mySmartMail.Recipients.Add session("emailAddress"), session("emailAddress")
'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"
'	-- Blind carbon copy
	mySmartMail.BCCs.Add "tmayer@personnel.com", ""
	mySmartMail.BCCs.Add "monitor@personnel.com", ""
'	-- Reply To
	mySmartMail.ReplyTos.Add "applicant_manager@personnel.com", "applicant_manager@personnel.com"
'	-- Message
	mySmartMail.Subject = "Job Application Sent - www.personnel.com"
	mySmartMail.Body = msgBody2
'	-- Optional Parameters
	mySmartMail.Organization = "Personnel.com"
'	mySmartMail.XMailer = "Your Web App Name"
	mySmartMail.Priority = 3
	mySmartMail.ReturnReceipt = false
	mySmartMail.ConfirmRead = false
	mySmartMail.ContentType = "text/plain"
	mySmartMail.Charset = "us-ascii"
	mySmartMail.Encoding = "base64"
'	-- Attached file
'	mySmartMail.Attachments.Add Server.MapPath("\aspSmartMail\sample.txt"),, false
'	-- Send the message
	mySmartMail.SendMail

'	-- Error handling
	if err.number <> 0 then
		response.write("Error n° " &  err.number - vbobjecterror & " = " & err.description  & "<br>")
	else
'		response.write "aspSmartMail has sent your message with this file as attachment : <br>"
'		response.write mySmartMail.Attachments.Item(1).FilePathName
	end if

' now we can destroy mySmartMail object
	set mySmartMail = nothing
' ---- aspSmartMail / ----

response.redirect("viewJob.asp?confirm=1&id=" & job_id)
%>
