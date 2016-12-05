<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<%
dim taf_to			:	taf_to = ConvertString(TRIM(Request("taf_to")))
dim taf_subject		:	taf_subject = ConvertString(TRIM(Request("taf_subject")))
	if taf_subject = "" then ' Use default subject if left blank...
	taf_subject = "Thought you might be interested in this job position..."
	end if
dim taf_comments	:	taf_comments = ConvertString(TRIM(Request("taf_comments")))
dim taf_from		:	taf_from = session("emailAddress")

dim jobID			:	jobID = Request("jobID")
dim jCat			:	jCat = Request("jCat")
dim jTitle			:	jTitle = Request("jTitle")
dim jCompany		:	jCompany = Request("jCompany")
dim jCity			:	jCity = Request("jCity")
dim jLoc			:	jLoc = Request("jLoc")
dim jNum			:	jNum = Request("jNum")
dim jSalary			:	jSalary = ConvertString(TRIM(Request("jSalary")))
	if jSalary = "" then
	jSalary = "Not Specified"
	end if
dim jType			:	jType = Request("jType")
	Select Case jType
	  Case "FP"
	    jType = "Full-Time or Part-Time"
	  Case "FT"
	    jType = "Full-Time"
	  Case "PT"
	    jType = "Part-Time"
	  Case "CT"
	    jType = "Contractor"		
	End Select
dim jDesc			:	jDesc = ConvertString(Request("jDesc"))
dim sEmail ' Registered Member Email Address

dim emailBody
emailBody = user_firstname & " " & user_lastname & " (" & taf_from & ") has sent you information about the following job position listed on http://www.personnel.com:"& chr(10) & chr(10)
emailBody = emailBody & "Comments: " & taf_comments & chr(10) & chr(10)
emailBody = emailBody & "---------Job Information---------" & chr(10)
emailBody = emailBody & "Position Title: " & jTitle & chr(10)
emailBody = emailBody & "Company Name: " & jCompany & chr(10)
emailBody = emailBody & "Location: " & jLoc & chr(10)
emailBody = emailBody & "Category: " & jCat & chr(10)
emailBody = emailBody & "Type: " & jType & chr(10)
emailBody = emailBody & "Salary/Pay: " & jSalary & chr(10)
emailBody = emailBody & "Description: " & jDesc & chr(10)
emailBody = emailBody & "---------------------------------" & chr(10) & chr(10)
emailBody = emailBody & "To apply or search for more jobs please visit: " & chr(10)
emailBody = emailBody & "http://www.personnel.com/search/viewJob.asp?id=" & jobID & chr(10)

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
	mySmartMail.SenderAddress = taf_from
'	-- To
	mySmartMail.Recipients.Add taf_to, taf_to
'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"
'	-- Blind carbon copy
'	mySmartMail.BCCs.Add "tmayer@personnel.com", ""
'	mySmartMail.BCCs.Add "monitor@personnel.com", ""
'	-- Reply To
	mySmartMail.ReplyTos.Add taf_from, ""
'	-- Message
	mySmartMail.Subject = taf_subject
	mySmartMail.Body = emailBody
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

Connect.Close
Set Connect = Nothing


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Tell A Friend - Sending Your Message - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script type="text/javascript" language="JavaScript">
<!-- // hide from old browsers

function closeWindow(close){
        window.close( )
}
//-->
</SCRIPT>
</head>

<body>
<table bgcolor="#FFFFFF" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
  		<td width="100%" align="center">
			<table width="100%" border="0" cellspacing="0" cellpadding="5">
  		 		<tr>
    				<td colspan="2" bgcolor="#5187CA" width="100%" align="center">
					<font color="#FFFFFF"><strong>Sending Message...Please Wait</strong></font></td>
  		  		</tr>			
  		 		<tr>
    				<td colspan="2" bgcolor="#5187CA" width="100%" align="center">
<script language="javascript" src="/includes/scripts/timerbar.js">

/*
Time-based progress bar- By Brian Gosselin at http://scriptasylum.com/bgaudiodr
Featured on DynamicDrive.com
For full source, visit http://www.dynamicdrive.com
*/

</script>
					</td>
  		  		</tr>	
  		 		<tr>
    				<td colspan="2" bgcolor="#5187CA" width="100%" align="center"><font color="#FFFFFF">Recipient: <strong><%=taf_to%></strong></font></td>
  		  		</tr>	
  		 		<tr>
    				<td colspan="2" bgcolor="#FFFFFF" width="100%" align="center"> <strong>JOB DETAILS</strong></td>
  		  		</tr>										
  		  		<tr>
    				<td colspan="2" width="100%" bgcolor="#efefef">
<strong><%=jTitle%></strong>	
<br>					
<strong><%=jCompany%></strong>
<br>
<strong><%=jCity%>, <%=jLoc%></strong>	

					</td>
		  		</tr>

  		  		<tr>
    				<td colspan="2" width="100%" bgcolor="#FFFFFF">
Subject: <%=taf_subject%>
					</td>
		  		</tr>
		  		<tr>
    				<td bgcolor="#FFFFFF" colspan="2">
Your Comment(s): <%=Left((taf_comments),900)%>
    				</td>
				</tr>
				<tr>
					<td align="left" width="50%">
				
					</td>				
					<td align="right" width="50%"><a href="javascript:closeWindow();">Close Window</a>
</td>				
				</tr>

  				</tr>
			</table>
    	</td>
  	</tr>
</table>



</body>
</html>

