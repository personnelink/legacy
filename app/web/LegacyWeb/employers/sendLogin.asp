<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<%
dim emailAddress	:	emailAddress = TRIM(request("emailAddress"))

if emailAddress <> "" then
  Set rsEmployerInfo = Server.CreateObject("ADODB.Recordset")
  rsEmployerInfo.Open "SELECT companyUserName, password, emailAddress FROM tbl_employers WHERE emailAddress ='" & emailAddress & "'", Connect, 3, 3
  Set rsCount = Connect.Execute("SELECT count(emailAddress) AS theCount FROM tbl_employers WHERE emailAddress = '" & emailAddress & "'")
else
  response.redirect("forgotLogin.asp?error=1")
end if

if rsCount("theCount") = 0 then response.redirect("forgotLogin.asp?error=2&badAddress=" & emailAddress) end if

msgBody = "Your Personnel Plus account login information:" & chr(10) & chr(10)
msgBody = msgBody & "Username: " & rsEmployerInfo("companyUserName") & chr(13)
msgBody = msgBody & "Password: " & rsEmployerInfo("password") & chr(13)
msgBody = msgBody & "Email Address: " & rsEmployerInfo("emailAddress") & chr(10) & chr(10)

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
	mySmartMail.SenderAddress = "webmaster@personnelplus-inc.com"
'	-- To
	mySmartMail.Recipients.Add rsEmployerInfo("emailAddress"), rsEmployerInfo("emailAddress")
'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"
'	-- Blind carbon copy
'	mySmartMail.BCCs.Add "tmayer@personnel.com", ""
'	-- Reply To
	mySmartMail.ReplyTos.Add "webmaster@personnelplus-inc.com", "Personnel Plus Webmaster"
'	-- Message
	mySmartMail.Subject = "Personnel Plus - Your Requested Account Information"
	mySmartMail.Body = msgBody
'	-- Optional Parameters
	mySmartMail.Organization = "Personnel Plus Inc"
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


Set rsEmployerInfo = Nothing
Set rsCount = Nothing
%>

<%
  response.redirect("forgotLogin.asp?error=0")
%>


