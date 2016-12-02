<% if session("employerAuth") <> "true" then 
response.redirect("/index.asp")
end if
%>
<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<%
dim jobID				:	jobID = Request("jobID")
dim strSQL, rsOpenJob		
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
		& " <title>Job Order Email Re-Opening</title>" & vbCrLf _
		& " <meta http-equiv=Content-Type content=""text/html; charset=iso-8859-1"">" & vbCrLf _
		& "</head>" & vbCrLf _
		& "<body bgcolor=""#FFFF99"">" & vbCrLf _
		& " <h2>Job Order Email Re-Opening</h2>" & vbCrLf _
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

Set cdoMessage = Server.CreateObject("CDO.Message") 

With cdoMessage 
  Set .Configuration = cdoConfig
	  .From = rsEmail("jobEmailAddress")
'	  .To = "saguilar@aguilarfam.myrf.net"
	  .To = "twin@personnel.com;tmayer@personnel.com"
	  .Bcc = "saguilar@personnel.com"
      .Subject = "Personnel Plus - Job Email Application Re-Opening"
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

strSQL = "UPDATE tbl_listings SET jobStatus = 'Open', deleted = 'No', dateCreated = #" & now() & "#, dateJobClosed = '" & null & "' WHERE jobID = '" & jobID & "'"	  
Connect.Execute(strSQL)
set rsOpenJob = Connect.Execute(strSQL)		  	  

%>
<%
'response.write("/employers/registered/index.asp?who=1&jobEditID=" & request("jobID"))
response.redirect("/employers/registered/index.asp?who=1&jobEditID=" & request("jobID"))
%>