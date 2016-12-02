<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		doForgot.asp
'		Description:	Processes employer email address for forgotten login- sends email to employer
'						if valid record is found in tbl_employers.
'		Created:		Tuesday, February 17, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************

dim tmpEmailAddress	: tmpEmailAddress = ConvertString(TRIM(request("emailAddress")))

if tmpEmailAddress = "" then
  response.redirect("forgot.asp?error=1")
end if

Function CheckMail(strEmail)
  dim objRegExp , blnValid
  Set objRegExp = New RegExp
  objRegExp.Pattern = "^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
  blnValid = objRegExp.Test(strEmail)
  if blnValid then
    Else
    response.redirect("forgot.asp?error=3&badEmail="&tmpEmailAddress)
  End if 
End Function

CheckMail(tmpEmailAddress)

dim rsCount, numCounted
Set rsCount = Connect.Execute("SELECT count(emp_email_address) AS theCount FROM tbl_employers WHERE emp_email_address = '" & tmpEmailAddress & "'")

numCounted = Clng(rsCount("theCount"))

Set rsCount = Nothing

if numCounted = 0 then
  response.redirect("forgot.asp?error=2&badEmail=" & tmpEmailAddress) 
Else

dim rsLoginInfo, tmp_password, msgbody

Set rsLoginInfo = Server.CreateObject("ADODB.Recordset")
rsLoginInfo.CursorLocation = 3
rsLoginInfo.Open "SELECT emp_id, emp_password, emp_email_address FROM tbl_employers WHERE emp_email_address ='" & tmpEmailAddress & "'",Connect

  msgBody = "Here is the login information that you requested for your Employer Account at www.personnel.com" & chr(13) & chr(13)
  msgBody = msgBody & "Username: " & rsLoginInfo("emp_email_address") & chr(13)
  msgBody = msgBody & "Password: " & rsLoginInfo("emp_password") & chr(13) & chr(13)
  msgBody = msgBody & "To access your Employer Account at any time, visit: " & chr(13)
  msgBody = msgBody & "http://www.personnel.com/employers/login.asp" & chr(10)


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
	mySmartMail.SenderAddress = "webmaster@personnel.com"
'	-- To
	mySmartMail.Recipients.Add tmpEmailAddress, tmpEmailAddress
'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"
'	-- Blind carbon copy
	mySmartMail.BCCs.Add "monitor@personnel.com", ""
'	-- Reply To
	mySmartMail.ReplyTos.Add "webmaster@personnel.com", "webmaster@personnel.com"
'	-- Message
	mySmartMail.Subject = "www.personnel.com - Your Employer Account Login"
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

	set mySmartMail = nothing
' ---- aspSmartMail / ----



rsLoginInfo.Close
Set rsLoginInfo = Nothing
Connect.Close
Set Connect = Nothing
end if
%>
<script language=javascript>
  alert('Your account details have been sent to <%=tmpEmailAddress%>');
  window.location = "login.asp";
</script>

