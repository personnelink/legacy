<%response.buffer=true%>
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->

<%
if session("tmp_email_address") = "" or session("tmp_password") = "" then
  response.redirect("/registered/newuser/index.asp?error=2")
end if

dim mbr_password			:	mbr_password = session("tmp_password")
dim mbr_first_name			:	mbr_first_name = TRIM(ConvertString(request("mbr_first_name")))
dim mbr_last_name			:	mbr_last_name = TRIM(ConvertString(request("mbr_last_name")))
dim mbr_address_one			:	mbr_address_one = TRIM(ConvertString(request("mbr_address_one")))
dim mbr_address_two			:	mbr_address_two = TRIM(ConvertString(request("mbr_address_two")))
dim mbr_city				:	mbr_city = TRIM(ConvertString(request("mbr_city")))
dim mbr_location			:	mbr_location = request("mbr_location")
dim mbr_zipcode				:	mbr_zipcode = TRIM(ConvertString(request("mbr_zipcode")))
dim mbr_phone_number		:	mbr_phone_number = TRIM(ConvertString(request("mbr_phone_number")))
dim mbr_email_address		:	mbr_email_address = session("tmp_email_address")
dim mbr_availability		:	mbr_availability = "FP"
dim mbr_is_suspended		:	mbr_is_suspended = "no"
dim mbr_num_resumes			:	mbr_num_resumes = 0

dim sqlInsertMbr, rsInsertMbr, rsID, qID, newMbrID
sqlInsertMbr = "INSERT INTO tbl_members (mbr_password, mbr_first_name, mbr_last_name, mbr_address_one, mbr_address_two, mbr_city, mbr_location, mbr_zipcode, mbr_phone_number, mbr_email_address, mbr_availability, mbr_is_suspended, mbr_num_resumes, mbr_date_created) VALUES (" & _
"'" & mbr_password & "'," & _
"'" & mbr_first_name & "'," & _
"'" & mbr_last_name & "'," & _
"'" & mbr_address_one & "'," & _
"'" & mbr_address_two & "'," & _
"'" & mbr_city & "'," & _
"'" & mbr_location & "'," & _
"'" & mbr_zipcode & "'," & _
"'" & mbr_phone_number & "'," & _
"'" & mbr_email_address & "'," & _
"'" & mbr_availability & "'," & _
"'" & mbr_is_suspended & "'," & _
"'" & mbr_num_resumes & "'," & _
" NOW()" & ")"

qID = "SELECT LAST_INSERT_ID() AS new_mbr_id;"

Set rsInsertMbr = Connect.Execute(sqlInsertMbr)
Set rsID = Connect.Execute(qID)
newMbrID = rsID("new_mbr_id")

Set rsInsertMbr = Nothing

' --- TESTING
'response.write(sqlInsertMbr)
'response.write("<p></p>")
'response.write(rsID("new_mbr_id"))

' tbl_member_messages
dim rsInsertMsg, sqlInsertMsg
dim msg_subject			:	msg_subject = "Welcome, " & mbr_first_name & " " & mbr_last_name & "!"
dim msg_is_read			:	msg_is_read = "no"
dim msg_type			:	msg_type = "file"
dim msg_from			:	msg_from = "Personnel.com Staff"
dim msg_body			:	msg_body = "/messages/welcome.txt"

sqlInsertMsg = "INSERT INTO tbl_member_messages (mbr_id, msg_subject, msg_is_read, msg_type, msg_from, msg_date_created, msg_body) VALUES (" & _
"'" & newMbrID & "'," & _
"'" & msg_subject & "'," & _
"'" & msg_is_read & "'," & _
"'" & msg_type & "'," & _
"'" & msg_from & "'," & _
" NOW()," & _
"'" & msg_body & "')"

Set rsInsertMsg = Connect.Execute(sqlInsertMsg)
Set rsInsertMsg = Nothing

session("tmp_email_address") = ""
session("tmp_password") = ""

session("mbrAuth") = "true"
session("mbrID") = newMbrID
user_firstname = mbr_first_name
user_lastname = mbr_last_name
session("emailAddress") = mbr_email_address

' construct Email
dim userIP	:	userIP = request.ServerVariables("REMOTE_ADDR")
dim txtOne
txtOne = mbr_first_name & " " & mbr_last_name & "," & chr(13)
txtOne = txtOne & "On" & " " & FormatDateTime(Now(),1) & ", you created a Member Account at www.personnel.com from IP address:" & " " & userIP & "." & chr(10) & chr(10)
txtOne = txtOne & "Your username and password are:" & chr(10) & chr(10)
txtOne = txtOne & "-------------------------------------" & chr(13)
txtOne = txtOne & "Username: " & mbr_email_address & chr(13)
txtOne = txtOne & "Password: " & mbr_password & chr(13)
txtOne = txtOne & "-------------------------------------" & chr(10) & chr(10)
txtOne = txtOne & "To create your resume and apply for jobs you will need to log in first." & chr(10)
txtOne = txtOne & "To log in, please visit: http://www.personnel.com/registered/login.asp" & chr(10) & chr(10)
txtOne = txtOne & "To change your password or account information (after logging in), use the Account Options from the main menu." & chr(10) & chr(10)
txtOne = txtOne & "We are excited to welcome you to personnel.com." & chr(10) & chr(10)
txtOne = txtOne & "It is our goal here to efficiently connect you with potential employers." & chr(10)
txtOne = txtOne & "Feel free to browse the site and set up your online resume - the sooner you do this the quicker you will benefit from its advanced features." & chr(10) & chr(10)
txtOne = txtOne & "if you experience any problems, are unable to find answers to your questions in the Help Section, or would like to comment on this site, please feel free to email us at webmaster@personnel.com, or, call us toll-free at (877)-733-7300." & chr(10) & chr(10)
txtOne = txtOne & "Sincerely," & chr(10) & chr(10)
txtOne = txtOne & "The Personnel.com Staff" & chr(10) & chr(10)
txtOne = txtOne & "[if you did not request this email, please reply to this email.]" & chr(13) & chr(13)


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
	mySmartMail.SenderAddress = "registration_manager@personnel.com"
'	-- To
	mySmartMail.Recipients.Add mbr_email_address, mbr_email_address
'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"
'	-- Blind carbon copy
	mySmartMail.BCCs.Add "tmayer@personnel.com", ""
	mySmartMail.BCCs.Add "monitor@personnel.com", ""
'	-- Reply To
	mySmartMail.ReplyTos.Add "registration_manager@personnel.com", "registration_manager@personnel.com"
'	-- Message
	mySmartMail.Subject = "Your new Member Account - www.personnel.com"
	mySmartMail.Body = txtOne
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

	set mySmartMail = nothing
' ---- aspSmartMail / ----

Connect.Close
Set Connect = Nothing

response.redirect("/registered/logged/index.asp")
%>







