<%
' Email Body
msgBody = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">" & vbCrLf _
		& "<html>" & vbCrLf _
		& "<head>" & vbCrLf _
		& " <title>Job Order Email</title>" & vbCrLf _
		& " <meta http-equiv=Content-Type content=""text/html; charset=iso-8859-1"">" & vbCrLf _
		& "</head>" & vbCrLf _
		& "<body bgcolor=""#FFFF99"">" & vbCrLf _
		& " <h2>Job Order Email</h2>" & vbCrLf _
		& " <p>" & vbCrLf _
		& "Company Agent's Email: " & request.form("companyBillingEmail") & "<BR>" & vbCrLf _
		& "Company Agent's Name: " & request.form("companyBilling") & "<BR>" & vbCrLf _
		& "Company Agent's Phone #: " & request.form("companyBillingPhone") & " x" & request.form("companyAgentPhoneExt") & "<BR>" & vbCrLf _
		& "Company Name: " & request.form("companyName") & "<BR>" & vbCrLf _
		& "<BR>" & vbCrLf _
		& "Job Title: " & request.form("jobTitle") & "<BR>" & vbCrLf _
		& "Job Desription: " & request.form("jobDescription") & "<BR>" & vbCrLf _
		& "<BR>" & vbCrLf _
		& "Wage: " & "$" & request.form("wageAmount") & "<BR>" & vbCrLf _
		& "Wage Type: " & request.form("wageType") & "<BR>" & vbCrLf _
		& "<BR>" & vbCrLf _
		& "License Required? " & request.form("jobLicenseReq") & "<BR>" & vbCrLf _
		& "<BR>" & vbCrLf _
		& "Job Schedule: " & request.form("jobSchedule") & "<BR>" & vbCrLf _
		& "Job Category: " & request.form("jobCategory") & "<BR>" & vbCrLf _
		& "<BR>" & vbCrLf _
		& "Lunch? " & request.form("jobTimeLunch") & "<BR>" & vbCrLf _
		& "Breaks? " & request.form("jobTimeBreaks") & "<BR>" & vbCrLf _
		& "<BR>" & vbCrLf _
		& "Dress Code: " & request.form("jobDressCode") & "<BR>" & vbCrLf _
		& "<BR>" & vbCrLf _
		& "Job Contact: " & request.form("jobContactName") & "<BR>" & vbCrLf _
		& "Job Contact's Email Address: " & request.form("jobEmailAddress") & "<BR>" & vbCrLf _
		& "Job Contact's Phone Number: " & request.form("jobContactPhone") & " x" & request.form("jobContactPhoneExt") & "<BR>" & vbCrLf _
		& "Job Address: " & vbCrLf _
		& "<BR>" & vbCrLf _
		& request.form("jobAddressOne") & "<BR>" & vbCrLf _
		& request.form("jobAddressTwo") & "<BR>" & vbCrLf _
		& request.form("jobCity") & ", " & request.form("jobState") & "  " & request.form("jobZipCode") & vbCrLf _
		& "  </p>" & vbCrLf _
		& "</body>" & vbCrLf _
		& "</html>" & vbCrLf




' ---- / aspSmartMail ----
	On error resume next

	Dim mySmartMail
	Set mySmartMail = Server.CreateObject("aspSmartMail.SmartMail")

'	-- Mail Server
	mySmartMail.Server = "127.0.0.1"
'	mySmartMail.ServerPort = 25

	mySmartMail.ServerTimeOut = 35
	
'	-- From
'	mySmartMail.SenderName = "Your Name"
	mySmartMail.SenderAddress = TRIM(request.form("companyBillingEmail"))
'	-- To
	mySmartMail.Recipients.Add "twin@personnel.com", ""
	mySmartMail.Recipients.Add "tmayer@personnel.com", ""	
'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"
'	-- Blind carbon copy
	mySmartMail.BCCs.Add "jwerrbach@cableone.net", ""
'	-- Reply To
	mySmartMail.ReplyTos.Add "webmaster@personnelplus-inc.com", "Personnel Plus Webmaster"

'	-- Message
	mySmartMail.Subject = "Personnel Plus - Employer Job Post Request"
	mySmartMail.Body = msgBody

'	-- Optional Parameters
	mySmartMail.Organization = "Personnel Plus Inc"
'	mySmartMail.XMailer = "Your Web App Name"
	mySmartMail.Priority = 3
	mySmartMail.ReturnReceipt = false
	mySmartMail.ConfirmRead = false
'	mySmartMail.ContentType = "text/plain"
	mySmartMail.ContentType = "text/html"	
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
'		Response.Write "aspSmartMail has sent your message with this file as attachment : <br>"
'		Response.Write mySmartMail.Attachments.Item(1).FilePathName
	end if

	set mySmartMail = nothing
' ---- aspSmartMail / ----
	

response.redirect("/lweb/employers/email_job/jobmail.asp?success=1")

%>