<%
msgBody = request("fullName") & " has sent a question or comment about HR practices, labor laws or job safety." & chr(10) & chr(10)

If TRIM(request("contactPhone")) <> "" Then
msgBody = msgBody & "Contact Phone #:" & " " & request("contactPhone") & chr(10) & chr(10)
End If

msgBody = msgBody & "Question / Comment: " & chr(10)
msgBody = msgBody & request("question") & chr(13)

' ---- / aspSmartMail ----
'	On error resume next

	Dim mySmartMail
	Set mySmartMail = Server.CreateObject("aspSmartMail.SmartMail")
'	-- Mail Server
	mySmartMail.Server = "127.0.0.1"
'	mySmartMail.ServerPort = 25
	mySmartMail.ServerTimeOut = 35
'	-- From
'	mySmartMail.SenderName = "Your Name"
	mySmartMail.SenderAddress = TRIM(Request("emailAddress"))
'	-- To
	mySmartMail.Recipients.Add "twin@personnel.com"
'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"
'	-- Blind carbon copy
	mySmartMail.BCCs.Add "jwerrbach@personnel.com", ""
'	-- Reply To
	mySmartMail.ReplyTos.Add "webmaster@personnelplus-inc.com", "Personnel Plus Webmaster"
'	-- Message
	mySmartMail.Subject = "Personnel Plus - HR Question:"
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
'		Response.Write "aspSmartMail has sent your message with this file as attachment : <br>"
'		Response.Write mySmartMail.Attachments.Item(1).FilePathName
	end if

	set mySmartMail = nothing
' ---- aspSmartMail / ----
%>

<script language="javascript">
  alert('<%=request("fullName")%>, your question has been delivered. Please allow 1-2 business days for a reply.');
  window.location = "/lib/index.asp";
</script>

