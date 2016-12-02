<%response.buffer=true%>
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<%
'	*************************  File Description  *************************
'		FileName:		doSecondPage.asp
'		Description:	New Employer sign up - Process general employer information, set 
'						global session vars and add new record to tbl_employers. 
'						Also sends Email confirmation to new employer.
'		Created:		Tuesday, February 17, 2004
'		Lastmod:		Wednesday, March 3, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************

if session("empAuth") = "true" then
response.redirect("/employers/logged/index.asp")
end if

if session("tmp_email_address") = "" or session("tmp_password") = "" then
  response.redirect("/employers/newuser/firstPage.asp?error=2")
end if

' ---------------------------------------------------------------
' Insert new employer and get new record ID
' ---------------------------------------------------------------
dim tmp_contact_name		:	tmp_contact_name = ConvertString(TRIM(Request("emp_first_name"))) + " " + ConvertString(TRIM(Request("emp_last_name")))
dim emp_password			:	emp_password = session("tmp_password")
dim emp_company_name		:	emp_company_name = ConvertString(TRIM(Request("emp_company_name")))
dim emp_contact_name		:	emp_contact_name = tmp_contact_name
dim emp_email_address		:	emp_email_address = session("tmp_email_address")
dim emp_job_email_address 
' if empty populate job email with normal email address
if ConvertString(TRIM(request("emp_job_email_address"))) = "" then
  emp_job_email_address = emp_email_address
Else
  emp_job_email_address = ConvertString(TRIM(request("emp_job_email_address")))
end if
dim emp_account_type		:	emp_account_type = Request("emp_account_type")
dim emp_account_size		:	emp_account_size = Request("emp_account_size")
dim emp_address_one			:	emp_address_one = ConvertString(TRIM(Request("emp_address_one")))
dim emp_address_two			:	emp_address_two = ConvertString(TRIM(Request("emp_address_two")))
dim emp_city				:	emp_city = ConvertString(TRIM(Request("emp_city")))
dim emp_location			:	emp_location = Request("emp_location")
dim emp_zipcode				:	emp_zipcode = ConvertString(TRIM(Request("emp_zipcode")))
dim emp_phone_number		:	emp_phone_number = ConvertString(TRIM(Request("emp_phone_number")))
dim emp_fax_number			:	emp_fax_number = ConvertString(TRIM(Request("emp_fax_number")))
dim emp_url					:	emp_url = ConvertString(TRIM(Request("emp_url")))
dim emp_date_searched		:	emp_date_searched = "never" 
dim emp_company_profile		:	emp_company_profile = ConvertString(Request("emp_company_profile"))

dim sqlInsertEmp, rsInsertEmp, rsID, qID, newEmpID
sqlInsertEmp = "INSERT INTO tbl_employers (emp_password, emp_company_name, emp_contact_name, emp_email_address, emp_job_email_address, emp_account_type, emp_account_size, emp_address_one, emp_address_two, emp_city, emp_location, emp_zipcode, emp_phone_number, emp_fax_number, emp_url, emp_is_suspended, emp_date_searched, emp_date_created, emp_company_profile) VALUES (" & _
"'" & emp_password & "'," & _
"'" & emp_company_name & "'," & _
"'" & emp_contact_name & "'," & _
"'" & emp_email_address & "'," & _
"'" & emp_job_email_address & "'," & _
"'" & emp_account_type & "'," & _
"'" & emp_account_size & "'," & _
"'" & emp_address_one & "'," & _
"'" & emp_address_two & "'," & _
"'" & emp_city & "'," & _
"'" & emp_location & "'," & _
"'" & emp_zipcode & "'," & _
"'" & emp_phone_number & "'," & _
"'" & emp_fax_number & "'," & _
"'" & emp_url & "'," & _
"" & 0 & "," & _
"'" & emp_date_searched & "'," & _
" NOW()," & _
"'" & emp_company_profile & "')"

Set rsInsertEmp = Connect.Execute(sqlInsertEmp)
Set rsInsertEmp = Nothing

qID = "SELECT LAST_INSERT_ID() AS new_emp_id;"
Set rsID = Connect.Execute(qID)
newEmpID = rsID("new_emp_id")
Set rsID = Nothing

' --- TESTING
'response.write(sqlInsertEmp)
'response.write("<p></p>New ID:")
'response.write(newEmpID)

' ---------------------------------------------------------------
' Insert Default Message and Send Confirmation Email
' ---------------------------------------------------------------
dim rsInsertMsg, sqlInsertMsg
dim msg_subject			:	msg_subject = "Welcome, " & emp_company_name
dim msg_type			:	msg_type = "file"
dim msg_from			:	msg_from = "Registration Manager"
dim msg_body			:	msg_body = "/messages/employerWelcome.txt"

sqlInsertMsg = "INSERT INTO tbl_employer_messages (emp_id, msg_subject, msg_is_read, msg_type, msg_from, msg_date_created, msg_body) VALUES (" & _
"'" & newEmpID & "'," & _
"'" & msg_subject & "'," & _
"" & 0 & "," & _
"'" & msg_type & "'," & _
"'" & msg_from & "'," & _
" NOW()," & _
"'" & msg_body & "')"

Set rsInsertMsg = Connect.Execute(sqlInsertMsg)
Set rsInsertMsg = Nothing

' Clear temp session vars 
session("tmp_email_address") = ""
session("tmp_password") = ""

' Set global session vars
session("empAuth") = "true"
session("empID") = newEmpID
company_name = emp_company_name
session("contactName") = emp_contact_name
session("emailAddress") = emp_email_address

' --- TESTING
'response.write(sqlInsertMsg)
'response.write(session("empAuth"))
'response.write(session("empID"))
'response.write(company_name)
'response.write(session("contactName"))
'response.write(user_name)


' Put together E-mail to Employer
dim userIP	:	userIP = request.ServerVariables("REMOTE_ADDR")

dim fileName, fileSys, file, txtOne, txtTwo
fileName = Server.MapPath("/messages/employerWelcome.txt")
Set fileSys = Server.CreateObject("Scripting.FileSystemObject")
Set file = fileSys.OpenTextFile(fileName,1)
txtTwo = file.ReadAll
file.Close
Set file = Nothing

' We don't need an open db connection anymore
Connect.Close
Set Connect = Nothing

txtOne = emp_contact_name & " - " & chr(13)
txtOne = txtOne & emp_company_name & ":" & chr(13) & chr(13)
txtOne = txtOne & "At" & " " & now() & " " & "you created an Employer Account at www.personnel.com from IP address:" & " " & userIP & "." & chr(10) & chr(10)
txtOne = txtOne & chr(10) & "Your username and password are:" & chr(10) & chr(10)
txtOne = txtOne & "-------------------------------------" & chr(13)
txtOne = txtOne & "Username: " & emp_email_address & chr(13)
txtOne = txtOne & "Password: " & emp_password & chr(13)
txtOne = txtOne & "-------------------------------------" & chr(10) & chr(10)
txtOne = txtOne & "To begin posting jobs and to access all the features, you will need to log in first." & chr(10)
txtOne = txtOne & "To log in, please visit: http://www.personnel.com/employers/login.asp" & chr(10) & chr(10)
txtOne = txtOne & "To change your password or account information (after logging in), select Account Options from the main menu." & chr(10) & chr(10)
txtOne = txtOne & "We are excited to welcome you to personnel.com!" & chr(13)
txtOne = txtOne & "Our automated website is targeted at efficiently connecting you with potential employees." & chr(10)
txtOne = txtOne & "if you experience any problems, are unable to find answers to your questions in the Help Section, or would like to comment on this site, please feel free to email us at webmaster@personnel.com, or, call us toll-free at (877)-733-7300." & chr(10) & chr(10)
txtOne = txtOne & "Sincerely," & chr(10) & chr(10)
txtOne = txtOne & "The Personnel.com Staff" & chr(10) & chr(10)
txtOne = txtOne & "[if you did not request an Employer Account, please reply to this email.]" & chr(13) & chr(13)

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
	mySmartMail.Recipients.Add emp_email_address, emp_email_address
'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"
'	-- Blind carbon copy
	mySmartMail.BCCs.Add "tmayer@personnel.com", ""
	mySmartMail.BCCs.Add "monitor@personnel.com", ""
'	-- Reply To
	mySmartMail.ReplyTos.Add "registration_manager@personnel.com", "registration_manager@personnel.com"
'	-- Message
	mySmartMail.Subject = "Your new Employer Account - www.personnel.com"
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


response.redirect("/employers/logged/index.asp")
%>
