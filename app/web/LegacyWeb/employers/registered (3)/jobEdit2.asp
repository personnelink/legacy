<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
<% if session("employerAuth") <> "true" then
response.redirect("/index.asp")
end if 
%>
<%
' open job record to update
set rsEditJob = Server.CreateObject("ADODB.RecordSet")
rsEditJob.Open "SELECT * FROM tbl_listings WHERE jobID = '" & request("jobID") & "'",Connect,3,3

' perform update
rsEditJob("empID") = session("empID")
rsEditJob("companyUserName") = request("companyUserName")
rsEditJob("jobSchedule") = request("jobSchedule")
rsEditJob("companyName") = ConvertString(TRIM(request("companyName")))
rsEditJob("companyAgent") = ConvertString(TRIM(request("companyAgent")))
rsEditJob("jobTitle") = ConvertString(TRIM(request("jobTitle")))
rsEditJob("jobCategory") = request("jobCategory")
rsEditJob("jobEmailAddress") = ConvertString(TRIM(request("jobEmailAddress")))
rsEditJob("jobContactPhone") = ConvertString(TRIM(request("jobContactPhone")))
rsEditJob("jobContactPhoneExt") = TRIM(request("jobContactPhoneExt"))
rsEditJob("jobAddressOne") = ConvertString(TRIM(request("jobAddressOne")))
rsEditJob("jobAddressTwo") = ConvertString(TRIM(request("jobAddressTwo")))
rsEditJob("jobCity") = ConvertString(TRIM(request("jobCity")))
rsEditJob("jobState") = request("jobState")
rsEditJob("jobZipCode") = ConvertString(TRIM(request("jobZipCode")))
rsEditJob("jobCountry") = TRIM(request("jobCountry"))
rsEditJob("jobReportTo") = ConvertString(TRIM(request("jobReportTo")))
rsEditJob("jobTimeLunch") = request("jobTimeLunch")
rsEditJob("jobTimeBreaks") = request("jobTimeBreaks")
rsEditJob("jobDressCode") = request("jobDressCode")
rsEditJob("jobLicenseReq") = request("jobLicenseReq")
rsEditJob("jobCDLReq") = request("jobCDLReq")
rsEditJob("jobStartDate") = TRIM(request("jobStartDate"))
rsEditJob("jobEndDate") = TRIM(request("jobEndDate"))
rsEditJob("wageType") = request("wageType")
rsEditJob("wageAmount") = TRIM(request("wageAmount"))
rsEditJob("viewCount") = TRIM(request("viewCount"))
rsEditJob("jobDescription") = ConvertString(request("jobDescription"))
rsEditJob.update		

' // CDO Email info to Personnel Plus

dim cdoConfig,cdoMessage,msgBody : msgBody = ""
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
		& " <title>Job Order Email Modification</title>" & vbCrLf _
		& " <meta http-equiv=Content-Type content=""text/html; charset=iso-8859-1"">" & vbCrLf _
		& "</head>" & vbCrLf _
		& "<body bgcolor=""#FFFF99"">" & vbCrLf _
		& " <h2>Job Order Email Modification</h2>" & vbCrLf _
		& " <p>" & vbCrLf _
		& "Company Name: " & rsEditJob("companyName") & "<BR>" & vbCrLf _
		& "Company Agent: " & rsEditJob("companyAgent") & "<BR>" & vbCrLf _
		& "<BR>" & vbCrLf _
		& "Job Title: " & rsEditJob("jobTitle") & "<BR>" & vbCrLf _
		& "Reports to: " & rsEditJob("jobReportTo") & "<BR>" & vbCrLf _
		& "Category: " & rsEditJob("jobCategory") & "<BR>" & vbCrLf _
		& "Description: " & rsEditJob("jobDescription") & "<BR>" & "<BR>" & vbCrLf _
		& "Dress Code: " & rsEditJob("jobDressCode") & "<BR>" & "<BR>" & vbCrLf _
		& "Contact's Phone: " & rsEditJob("jobContactPhone") & " x" & jobContactPhoneExt & "<BR>" & vbCrLf _
		& "Contact's Email: " & rsEditJob("jobEmailAddress") & "<BR>" & "<BR>" & vbCrLf _
		& "Job Address: " & "<BR>" & vbCrLf _
		& rsEditJob("jobAddressOne") & "<BR>" & vbCrLf _
		& rsEditJob("jobAddressTwo") & "<BR>" & vbCrLf _
		& rsEditJob("jobCity") & ", " & rsEditJob("jobState") & "  " & rsEditJob("jobZipCode") & ", " & rsEditJob("jobCountry") & "<BR>" & "<BR>" & vbCrLf _
		& "Lunch: " & rsEditJob("jobTimeLunch") & "&nbsp;&nbsp;&nbsp;Breaks: " & rsEditJob("jobTimeBreaks") & "<BR>" & vbCrLf _
		& "License Required? " & rsEditJob("jobLicenseReq") & "&nbsp;&nbsp;&nbsp;CDL Required? " & rsEditJob("jobCDLReq") & "<BR>" & vbCrLf _
		& "Start Date: " & rsEditJob("jobStartDate") & "<BR>" & vbCrLf _
		& "End Date: " & rsEditJob("jobEndDate") & "<BR>" & vbCrLf _
		& "$" & rsEditJob("wageAmount") & " per " & rsEditJob("wageType") & "<BR>" & vbCrLf _
		& "Date Created: " & rsEditJob("dateCreated") & "<BR>" & vbCrLf _
		& "Status: " & rsEditJob("jobStatus") & "<BR>" & vbCrLf _
		& "Deleted? " & rsEditJob("deleted") & "<BR>" & vbCrLf _
		& "  </p>" & vbCrLf _
		& "</body>" & vbCrLf _
		& "</html>" & vbCrLf


Set cdoMessage = Server.CreateObject("CDO.Message") 

With cdoMessage 
  Set .Configuration = cdoConfig
	  .From = rsEditJob("jobEmailAddress")
'	  .To = "saguilar@aguilarfam.myrf.net"
	  .To = "twin@personnel.com;tmayer@personnel.com"
	  .Bcc = "saguilar@personnel.com"
      .Subject = "Personnel Plus - Job Email Application Modification"
'      .Importance = CdoHigh
'      .Priority = 2
'      .Importance = 2
      .HtmlBody = msgBody
'      .TextBody = msgBody
      .Send 
End With 

Set cdoMessage = Nothing 
Set cdoConfig = Nothing 

' \\ CDO

'response.write("/employers/registered/index.asp?who=1&jobEditID=" & request("jobID"))
response.redirect("/employers/registered/index.asp?who=1&jobEditID=" & request("jobID"))
%>