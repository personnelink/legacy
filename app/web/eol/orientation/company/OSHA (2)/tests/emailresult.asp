<%

' // CDO Email the Test Results to Personnel Inc.

dim cdoConfig,cdoMessage,msgBody
sch = "http://schemas.microsoft.com/cdo/configuration/"
Set cdoConfig = Server.CreateObject("CDO.Configuration")

With cdoConfig.Fields 
      .Item(sch & "sendusing") = 2 ' cdoSendUsingPort 
      .Item(sch & "smtpserver") = "127.0.0.1" 
      .update 
End With 

Set cdoMessage = Server.CreateObject("CDO.Message") 

'Set the Body
msgBody = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">" & vbCrLf _
		& "<html>" & vbCrLf _
		& "<head>" & vbCrLf _
		& " <title>Test Results for" & request.cookies("OSHA")("fname") & "&nbsp;" & request.cookies("OSHA")("lname") & "</title>" & vbCrLf _
		& " <meta http-equiv=Content-Type content=""text/html; charset=iso-8859-1"">" & vbCrLf _
		& "</head>" & vbCrLf _
		& "<body bgcolor=""#FFFF99"">" & vbCrLf _
		& " <h2>Test Results for&nbsp;" & request.cookies("OSHA")("fname") & "&nbsp;" & request.cookies("OSHA")("lname") & "</h2>" & vbCrLf _
		& " <p>" & vbCrLf _
		& " <h3>&nbsp;" & request.cookies("test") & "&nbsp;test results&nbsp;" & request.cookies("result") & "&nbsp;out of&nbsp;" & request.cookies("answer") & "</h3>" & vbCrLf _
		& "  </p>" & vbCrLf _
		& "</body>" & vbCrLf _
		& "</html>" & vbCrLf

With cdoMessage 
  Set .Configuration = cdoConfig
	  .From = request.cookies("OSHA")("email")
'	  .To = "saguilar@aguilarfam.myrf.net"
	  .To = request.cookies("OSHA")("trgemail")
	  .Cc = request.cookies("OSHA")("email")
	  .Bcc = "saguilar@personnel.com"
      .HtmlBody = msgBody
      .Subject = "Personnel Plus - " & request.cookies("test") & " Test Results" & " " & request.cookies("OSHA")("lname") & ", " & request.cookies("OSHA")("fname")
      .Send 
End With 

Set cdoMessage = Nothing 
Set cdoConfig = Nothing 


' Set Redirection

dim camefrom,reURL
camefrom = ""
reURL = request.cookies("reURL")

if request.cookies("test") = "Office" then
	camefrom = "2"
end if
if request.cookies("test") = "Labor" then
	camefrom = "3"
end if

reURL = reURL + camefrom
response.cookies("reURL") = reURL

Response.redirect("/orientation/company/OSHA/OSHA.asp?test=" & reURL)
%>