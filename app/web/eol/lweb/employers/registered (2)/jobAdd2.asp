<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<% if session("employerAuth") <> "true" then response.redirect("/lweb/employers/registered/index.asp?Err=1") end if%>

<%
dim empID								: empID=Request.Form("empID")
dim companyUserName						: companyUserName=Request.Form("companyUserName")
dim jobSchedule							: jobSchedule=Request.Form("jobSchedule")
dim companyName							: companyName=Request.Form("companyName")
dim companyAgent						: companyAgent=Request.Form("companyAgent")
dim jobTitle							: jobTitle=Request.Form("jobTitle")
dim jobCategory							: jobCategory=Request.Form("jobCategory")
dim jobEmailAddress						: jobEmailAddress=Request.Form("jobEmailAddress")
dim jobContactPhone						: jobContactPhone=Request.Form("jobContactPhone")
dim jobContactPhoneExt					: jobContactPhoneExt=Request.Form("jobContactPhoneExt")
dim jobAddressOne						: jobAddressOne=Request.Form("jobAddressOne")
dim jobAddressTwo						: jobAddressTwo=Request.Form("jobAddressTwo")
dim jobCity								: jobCity=request.Form("jobCity")
dim jobState							: jobState=request.Form("jobState")
dim jobZipCode							: jobZipCode=request.Form("jobZipCode")
dim jobCountry							: jobCountry="US"
dim jobReportTo							: jobReportTo=request.Form("jobReportTo")
dim jobTimeLunch						: jobTimeLunch=request.Form("jobTimeLunch")
dim jobTimeBreaks						: jobTimeBreaks=request.Form("jobTimeBreaks")
dim jobDressCode						: jobDressCode=request.Form("jobDressCode")
dim jobLicenseReq						: jobLicenseReq=request.Form("jobLicenseReq")
dim jobCDLReq							: jobCDLReq=request.Form("jobCDLReq")
dim jobStatus							: jobStatus="Open"
dim jobStartDate						: jobStartDate=request.Form("jobStartDate")
dim jobEndDate							: jobEndDate=request.Form("jobEndDate")
dim wageType							: wageType=request.Form("wageType")
dim wageAmount							: wageAmount=request.Form("wageAmount")
dim deleted								: deleted="No"
dim dateCreated							: dateCreated=now()
dim jobDescription						: jobDescription=ConvertString(request.Form("jobDescription"))


dim strSQL
dim rsNewListing
strSQL = "INSERT INTO tbl_listings (empID, companyUserName, jobSchedule, companyName, companyAgent, jobTitle,jobCategory, jobEmailAddress, jobContactPhone, jobContactPhoneExt, jobAddressOne, jobAddressTwo, jobCity, jobState, jobZipCode, jobCountry, jobReportTo, jobTimeLunch, jobTimeBreaks, jobDressCode, jobLicenseReq, jobCDLReq, jobStatus, jobStartDate, jobEndDate, wageType, wageAmount, deleted, dateCreated, jobDescription) VALUES (" & _
"'" & empID & "'," & _
"'" & companyUserName & "'," & _
"'" & jobSchedule & "'," & _
"'" & companyName & "'," & _
"'" & companyAgent & "'," & _
"'" & jobTitle & "'," & _
"'" & jobCategory & "'," & _
"'" & jobEmailAddress & "'," & _
"'" & jobContactPhone & "'," & _
"'" & jobContactPhoneExt & "'," & _
"'" & jobAddressOne & "'," & _
"'" & jobAddressTwo & "'," & _
"'" & jobCity & "'," & _
"'" & jobState & "'," & _
"'" & jobZipCode & "'," & _
"'" & jobCountry & "'," & _
"'" & jobReportTo & "'," & _
"'" & jobTimeLunch & "'," & _
"'" & jobTimeBreaks & "'," & _
"'" & jobDressCode & "'," & _
"'" & jobLicenseReq & "'," & _
"'" & jobCDLReq & "'," & _
"'" & jobStatus & "'," & _
"'" & jobStartDate & "'," & _
"'" & jobEndDate & "'," & _
"'" & wageType & "'," & _
"'" & wageAmount & "'," & _
"'" & deleted & "'," & _
"'" & dateCreated & "'," & _
"'" & jobDescription & "'" & ")"


set rsNewListing = Connect.Execute(strSql)

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
		& " <title>Job Order Email</title>" & vbCrLf _
		& " <meta http-equiv=Content-Type content=""text/html; charset=iso-8859-1"">" & vbCrLf _
		& "</head>" & vbCrLf _
		& "<body bgcolor=""#FFFF99"">" & vbCrLf _
		& " <h2>Job Order Email</h2>" & vbCrLf _
		& " <p>" & vbCrLf _
		& "Company Name: " & companyName & "<BR>" & vbCrLf _
		& "Company Agent: " & companyAgent & "<BR>" & vbCrLf _
		& "<BR>" & vbCrLf _
		& "Job Title: " & jobTitle & "<BR>" & vbCrLf _
		& "Reports to: " & jobReportTo & "<BR>" & vbCrLf _
		& "Category: " & jobCategory & "<BR>" & vbCrLf _
		& "Description: " & jobDescription & "<BR>" & "<BR>" & vbCrLf _
		& "Dress Code: " & jobDressCode & "<BR>" & "<BR>" & vbCrLf _
		& "Contact's Phone: " & jobContactPhone & " x" & jobContactPhoneExt & "<BR>" & vbCrLf _
		& "Contact's Email: " & jobEmailAddress & "<BR>" & "<BR>" & vbCrLf _
		& "Job Address: " & "<BR>" & vbCrLf _
		& jobAddressOne & "<BR>" & vbCrLf _
		& jobAddressTwo & "<BR>" & vbCrLf _
		& jobCity & ", " & jobState & "  " & jobZipCode & ", " & jobCountry & "<BR>" & "<BR>" & vbCrLf _
		& "Lunch: " & jobTimeLunch & "&nbsp;&nbsp;&nbsp;Breaks: " & jobTimeBreaks & "<BR>" & vbCrLf _
		& "License Required? " & jobLicenseReq & "&nbsp;&nbsp;&nbsp;CDL Required? " & jobCDLReq & "<BR>" & vbCrLf _
		& "Start Date: " & jobStartDate & "<BR>" & vbCrLf _
		& "End Date: " & jobEndDate & "<BR>" & vbCrLf _
		& "$" & wageAmount & " per " & wageType & "<BR>" & vbCrLf _
		& "Date Created: " & dateCreated & "<BR>" & vbCrLf _
		& "Status: " & jobStatus & "<BR>" & vbCrLf _
		& "Deleted? " & deleted & "<BR>" & vbCrLf _
		& "  </p>" & vbCrLf _
		& "</body>" & vbCrLf _
		& "</html>" & vbCrLf


Set cdoMessage = Server.CreateObject("CDO.Message") 


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
	mySmartMail.Subject = "Personnel Plus - New Job Posting from " & companyName
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

response.redirect("/lweb/employers/registered/index.asp?who=1")

%>
