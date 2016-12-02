<% if session("employerAuth") <> "true" then 
response.redirect("/index.asp")
end if
%>
<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<%
dim jobID		:	jobID = Request("jobID")
dim strSQL, rsDelJob	
dim rsEmail

Set rsEmail = Server.CreateObject("ADODB.Recordset")
rsEmail.Open "SELECT * FROM tbl_listings WHERE jobID = '" & jobID & "'", Connect, 3, 3

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
		& " <title>Job Order Closure Notice</title>" & vbCrLf _
		& " <meta http-equiv=Content-Type content=""text/html; charset=iso-8859-1"">" & vbCrLf _
		& "</head>" & vbCrLf _
		& "<body bgcolor=""#FFFF99"">" & vbCrLf _
		& " <h2>Job Order Email Closure</h2>" & vbCrLf _
		& " <p>" & vbCrLf _
		& "Company Name: " & rsEmail("companyName") & "<BR>" & vbCrLf _
		& "Company Agent: " & rsEmail("companyAgent") & "<BR>" & vbCrLf _
		& "<BR>" & vbCrLf _
		& "Job Title: " & rsEmail("jobTitle") & "<BR>" & vbCrLf _
		& "Reports to: " & rsEmail("jobReportTo") & "<BR>" & vbCrLf _
		& "Category: " & rsEmail("jobCategory") & "<BR>" & vbCrLf _
		& "Description: " & rsEmail("jobDescription") & "<BR>" & "<BR>" & vbCrLf _
		& "Dress Code: " & rsEmail("jobDressCode") & "<BR>" & "<BR>" & vbCrLf _
		& "Contact's Phone: " & rsEmail("jobContactPhone") & " x" & jobContactPhoneExt & "<BR>" & vbCrLf _
		& "Contact's Email: " & rsEmail("jobEmailAddress") & "<BR>" & "<BR>" & vbCrLf _
		& "Job Address: " & "<BR>" & vbCrLf _
		& rsEmail("jobAddressOne") & "<BR>" & vbCrLf _
		& rsEmail("jobAddressTwo") & "<BR>" & vbCrLf _
		& rsEmail("jobCity") & ", " & rsEmail("jobState") & "  " & rsEmail("jobZipCode") & ", " & rsEmail("jobCountry") & "<BR>" & "<BR>" & vbCrLf _
		& "Lunch: " & rsEmail("jobTimeLunch") & "&nbsp;&nbsp;&nbsp;Breaks: " & rsEmail("jobTimeBreaks") & "<BR>" & vbCrLf _
		& "License Required? " & rsEmail("jobLicenseReq") & "&nbsp;&nbsp;&nbsp;CDL Required? " & rsEmail("jobCDLReq") & "<BR>" & vbCrLf _
		& "Start Date: " & rsEmail("jobStartDate") & "<BR>" & vbCrLf _
		& "End Date: " & rsEmail("jobEndDate") & "<BR>" & vbCrLf _
		& "$" & rsEmail("wageAmount") & " per " & rsEmail("wageType") & "<BR>" & vbCrLf _
		& "Date Created: " & rsEmail("dateCreated") & "<BR>" & vbCrLf _
		& "Status: " & rsEmail("jobStatus") & "<BR>" & vbCrLf _
		& "Deleted? " & rsEmail("deleted") & "<BR>" & vbCrLf _
		& "  </p>" & vbCrLf _
		& "</body>" & vbCrLf _
		& "</html>" & vbCrLf

strSQL = "UPDATE tbl_listings SET jobStatus = 'Closed', deleted = 'Yes', dateJobClosed ='" & now() & "' WHERE jobID = '" & jobID & "'"
Connect.Execute(strSQL)
set rsDelJob = Connect.Execute(strSQL)			  

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
	mySmartMail.SenderAddress = "webmaster@personnelplus-inc.com"
'	-- To
	mySmartMail.Recipients.Add "twin@personnel.com", ""
	mySmartMail.Recipients.Add "tmayer@personnel.com", ""	
'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"
'	-- Blind carbon copy
	mySmartMail.BCCs.Add "jwerrbach@personnel.com", ""
'	-- Reply To
	mySmartMail.ReplyTos.Add "webmaster@personnelplus-inc.com", "Personnel Plus Webmaster"
'	-- Message
	mySmartMail.Subject = "Personnel Plus - Job Posting Closed by " & companyName
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

%>
<%
response.redirect("/lweb/employers/registered/index.asp?who=1&jobEditID=" & request("jobID"))
%>