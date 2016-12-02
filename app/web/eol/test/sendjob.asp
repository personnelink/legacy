<%
' // CDO Email
dim cdoConfig,cdoMessage,msgBody
sch = "http://schemas.microsoft.com/cdo/configuration/"
Set cdoConfig = Server.CreateObject("CDO.Configuration")

With cdoConfig.Fields 
      .Item(sch & "sendusing") = 2 ' cdoSendUsingPort 
      .Item(sch & "smtpserver") = "127.0.0.1" 
      .update 
End With 

'Set the Body
msgBody = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">" & vbCrLf _
		& "<html>" & vbCrLf _
		& "<head>" & vbCrLf _
		& " <title>Job Order Email</title>" & vbCrLf _
		& " <meta http-equiv=Content-Type content=""text/html; charset=iso-8859-1"">" & vbCrLf _
		& "</head>" & vbCrLf _
		& "<body bgcolor=""#FFFF99"">" & vbCrLf _
		& " <h2>Job Order Email</h2>" & vbCrLf _
		& " <p>" & vbCrLf _
		& "Company Agent's Email: " & request.form("companyAgentEmail") & "<BR>" & vbCrLf _
		& "Company Agent's Name: " & request.form("companyAgent") & "<BR>" & vbCrLf _
		& "Company Agent's Phone #: " & request.form("companyAgentPhone") & " x" & request.form("companyAgentPhoneExt") & "<BR>" & vbCrLf _
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


Set cdoMessage = Server.CreateObject("CDO.Message") 

With cdoMessage 
  Set .Configuration = cdoConfig
	  .From = request.form("companyAgentEmail")
	  .To = "saguilar@aguilarfam.myrf.net"
'	  .To = "twin@personnel.com;tmayer@personnel.com"
	  .Bcc = "saguilar@aguilarfam.myrf.net"
      .Subject = "Personnel Plus - Job Email Application"
'      .Priority = 2
      .Importance = "High"
      .HtmlBody = msgBody
'      .TextBody = msgBody
      .Send 
End With 

Set cdoMessage = Nothing 
Set cdoConfig = Nothing 

response.redirect("/company/jobmail.asp?success=1")

' \\ CDO
%>