<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->

<%
' this is for maidsource
dim job_wanted	:	job_wanted = request("job_wanted")
' set a flag to prevent re-submittals, at least per session
session("directApply") = "1"

dim jobHistSMonthOne	: jobHistSMonthOne=request.form("jobHistSMonthOne")
dim jobHistSYearOne		: jobHistSYearOne=request.form("jobHistSYearOne")
dim jobHistEMonthOne	: jobHistEMonthOne=request.form("jobHistEMonthOne")
dim jobHistEYearOne		: jobHistEYearOne=request.form("jobHistEYearOne")
dim jobHistSDateOne			: jobHistSDateOne=(jobHistSMonthOne & "/" & jobHistSYearOne)
dim jobHistEDateOne 		: jobHistEDateOne=(jobHistEMonthOne & "/" & jobHistEYearOne)
dim jobHistSMonthTwo	: jobHistSMonthTwo=request.form("jobHistSMonthTwo")
dim jobHistSYearTwo		: jobHistSYearTwo=request.form("jobHistSYearTwo")
dim jobHistEMonthTwo	: jobHistEMonthTwo=request.form("jobHistEMonthTwo")
dim jobHistEYearTwo		: jobHistEYearTwo=request.form("jobHistEYearTwo")
dim jobHistSDateTwo			: jobHistSDateTwo=(jobHistSMonthTwo & "/" & jobHistSYearTwo)
dim jobHistEDateTwo 		: jobHistEDateTwo=(jobHistEMonthTwo & "/" & jobHistEYearTwo)
dim jobHistSMonthThree	: jobHistSMonthThree=request.form("jobHistSMonthThree")
dim jobHistSYearThree	: jobHistSYearThree=request.form("jobHistSYearThree")
dim jobHistEMonthThree	: jobHistEMonthThree=request.form("jobHistEMonthThree")
dim jobHistEYearThree	: jobHistEYearThree=request.form("jobHistEYearThree")
dim jobHistSDateThree		: jobHistSDateThree=(jobHistSMonthThree & "/" & jobHistSYearThree)
dim jobHistEDateThree		: jobHistEDateThree=(jobHistEMonthThree & "/" & jobHistEYearThree)
' Create default greeting to new job seeker
dim msgbody
msgBody = "Personnel Plus - Direct Online Application" & chr(10) & chr(10)
IF TRIM(job_wanted) <> "" then
msgBody = "Position of Interest: " & job_wanted & chr(10) & chr(10)
end if
msgBody = msgBody & request("firstName") & " " & request("lastName") & chr(13)
msgBody = msgBody & request("addressOne") & chr(13)
if request("addressTwo") <> "" then 
msgBody = msgBody & request("addressTwo") & chr(13) 
end if
msgBody = msgBody & request("city") & ", " & request("state") & " " & request("zipCode") & chr(13)
if request("contactPhone") <> "" then 
msgBody = msgBody & request("contactPhone") & chr(13) 
end if
if request("emailAddress") <> "" then 
msgBody = msgBody & request("emailAddress") & chr(13) 
end if
if request("preferred") <> "" then
msgBody = msgBody & "****************************< PREFERRED POSITION AND COMPANY >************************" & chr(13)
msgBody = msgBody & request("preferred") & chr(13)
msgBody = msgBody & "**************************************************************************************" & chr(13)
end if
msgBody = msgBody & chr(10) & chr(10)
if request("desiredWageAmount") <> "" then 
msgBody = msgBody & "Desired Salary/Wage:" & " " & request("desiredWageAmount") & chr(13) 
end if
if request("minWageAmount") <> "" then 
msgBody = msgBody & "Minimum Salary/Wage:" & " " & request("minWageAmount") & chr(13) 
end if
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "JOB OBJECTIVES / SUMMARY:" & chr(13) & request("jobObjective") & chr(10) & chr(10)
msgBody = msgBody & "I am 18 years or older:" & " " & request("workAge") & chr(13)
msgBody = msgBody & "Relocating?" & " " & request("workRelocate") & chr(13)
if request("workValidLicense") <> "" then
msgBody = msgBody & "I have a valid drivers license" & chr(13)
end if
if request("workLicenseType") <> "" then
msgBody = msgBody & "I have a" & " " & request("workLicenseType") & " " & "license" & chr(13)
end if
msgBody = msgBody & "Convicted of a felony:" & " " & request("workConviction") & chr(13)
if request("workConvictionExplain") <> "" then
msgBody = msgBody & "Explaination of felony:" & " " & request("workConvictionExplain") & chr(13)
end if

msgBody = msgBody & "I'd prefer" & " " & request("workTypeDesired") & " " & "work." & chr(13)
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "LISTED AREAS OF KNOWLEDGE AND EXPERIENCE:" & chr(13)
msgBody = msgBody & "Software:" & chr(13) & request("skillsSoftware") & chr(10) & chr(10)
msgBody = msgBody & "Clerical:" & chr(13) & request("skillsClerical") & chr(10) & chr(10)
msgBody = msgBody & "Industrial:" & chr(13) & request("skillsIndustrial") & chr(10) & chr(10)
msgBody = msgBody & "Managerial:" & chr(13) & request("skillsManagement") & chr(10) & chr(10)
msgBody = msgBody & "Construction:" & chr(13) & request("skillsConstruction") & chr(10) & chr(10)
msgBody = msgBody & "Customer Service:" & chr(13) & request("skillsCustomerSvc") & chr(10) & chr(10)
msgBody = msgBody & "Bookkeeping:" & chr(13) & request("skillsBookkeeping") & chr(10) & chr(10)
msgBody = msgBody & "Sales:" & chr(13) & request("skillsSales") & chr(10) & chr(10)
msgBody = msgBody & "Technical:" & chr(13) & request("skillsTechnical") & chr(10) & chr(10)
msgBody = msgBody & "Food Service:" & chr(13) & request("skillsFoodService") & chr(10) & chr(10)
msgBody = msgBody & "General Labor:" & chr(13) & request("skillsGeneralLabor") & chr(10) & chr(10)
msgBody = msgBody & "Skilled Labor:" & chr(13) & request("skillsSkilledLabor")
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "CURRENT OR MOST RECENT EMPLOYER:" & chr(13)
msgBody = msgBody & "Job Title:" & " " & request("jobHistTitleOne") & chr(13)
msgBody = msgBody & "Company Name:" & " " & request("jobHistCpnyOne") & chr(13)
msgBody = msgBody & "Company Phone:" & " " & request("jobHistPhoneOne") & chr(13)

msgBody = msgBody & "Location:" & " " & request("jobHistCityOne") & ", " & Request("jobHistStateOne") & chr(13)

msgBody = msgBody & "Dates Employed:" & " " & jobHistSDateOne & "-" & jobHistEDateOne & chr(13)
msgBody = msgBody & "Job Duties/Functions:"  & " " & request("jobDutiesOne") & chr(13)
if request("jobReasonOne") <> "Other" then
msgBody = msgBody & "Reason For Leaving:"  & " " & request("jobReasonOne") & chr(13) 
 else
msgBody = msgBody & "Reason For Leaving:"  & " " & request("jobOtherReasonOne") & chr(13) 
end if
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "2ND MOST RECENT EMPLOYER:" & chr(13)
msgBody = msgBody & "Job Title:" & " " & request("jobHistTitleTwo") & chr(13)
msgBody = msgBody & "Company Name:" & " " & request("jobHistCpnyTwo") & chr(13)
msgBody = msgBody & "Company Phone:" & " " & request("jobHistPhoneTwo") & chr(13)

msgBody = msgBody & "Location:" & " " & request("jobHistCityTwo") & ", " & Request("jobHistStateTwo") & chr(13)

msgBody = msgBody & "Dates:" & " " & jobHistSDateTwo & "-" & jobHistEDateTwo & chr(13)
if request("jobDutiesTwo") <> "" then
msgBody = msgBody & "Job Duties/Functions:"  & " " & request("jobDutiesTwo") & chr(13)
end if
if request("jobReasonTwo") <> "Other" then
msgBody = msgBody & "Reason For Leaving:"  & " " & request("jobReasonTwo") & chr(13) 
 else
msgBody = msgBody & "Reason For Leaving:"  & " " & request("jobOtherReasonTwo") & chr(13) 
end if
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "3RD MOST RECENT EMPLOYER:" & chr(13)
msgBody = msgBody & "Job Title:" & " " & request("jobHistTitleThree") & chr(13)
msgBody = msgBody & "Company Name:" & " " & request("jobHistCpnyThree") & chr(13)
msgBody = msgBody & "Company Phone:" & " " & request("jobHistPhoneThree") & chr(13)

msgBody = msgBody & "Location:" & " " & request("jobHistCityThree") & ", " & Request("jobHistStateThree") & chr(13)

msgBody = msgBody & "Dates:" & " " & jobHistSDateThree & "-" & jobHistEDateThree & chr(13)
if request("jobDutiesThree") <> "" then
msgBody = msgBody & "Job Duties/Functions:"  & " " & request("jobDutiesThree") & chr(13)
end if
if request("jobReasonThree") <> "Other" then
msgBody = msgBody & "Reason For Leaving:"  & " " & request("jobReasonThree") & chr(13) 
 else
msgBody = msgBody & "Reason For Leaving:"  & " " & request("jobOtherReasonThree") & chr(13) 
end if
msgBody = msgBody & chr(10) & chr(10)
if request("referenceNameOne") <> "" or request ("referenceNameTwo") <> "" or request("referenceNameThree") <> "" then
msgBody = msgBody & "WORK REFERENCES:" & chr(13)
msgBody = msgBody & request("referenceNameOne") & " " & request("referencePhoneOne") & chr(13)
msgBody = msgBody & request("referenceNameTwo") & " " & request("referencePhoneTwo") & chr(13)
msgBody = msgBody & request("referenceNameThree") & " " & request("referencePhoneThree") & chr(13)
end if
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "LEVEL OF EDUCATION:" & " " & request("eduLevel") & chr(13)
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "ADDITIONAL INFORMATION:" & " " & request("additionalInfo") & chr(10) & chr(10)
msgBody = msgBody & "Date/Time of Application:" & " " & now() & chr(10) & chr(10)

' dim emailToAddress		:		emailToAddress = session("targetOffice")

' if TRIM(emailToAddress) = "" then
dim emailToAddress
emailToAddress = "twin@personnel.com"
'end if

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
	mySmartMail.SenderAddress = TRIM(request("emailAddress"))
	
'	-- To
	mySmartMail.Recipients.Add emailToAddress, emailToAddress
'	mySmartMail.Recipients.Add "yourfriend1@anydomain.com", "Friend1's name"

'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"

'	-- Blind carbon copy
	mySmartMail.BCCs.Add "tmayer@personnel.com", ""
	
'	-- Reply To
'	mySmartMail.ReplyTos.Add "webmaster@personnelplus-inc.com", "Personnel Plus Webmaster"

'	-- Message
	mySmartMail.Subject = "Personnel Plus - Direct Application: " & request("lastName") & ", " & request("firstName")
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
%>

<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<TITLE><%=request("firstName")%>&nbsp;<%=request("lastName")%>, Welcome to Personnel Plus!</TITLE>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
</HEAD>

<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
<TABLE width="90%" BORDER="0" CELLPADDING="2" CELLSPACING="2" BGCOLOR="#ffffff">
	<TR>
		<TD>
		<!-- greeting start -->
Your application was sent directly to the Personnel Plus office closest to   <%=request("city")%>,&nbsp;<%=request("state")%>!
<p></p>
Please allow up to two full business days for us to review your information.
<br>
You will then be contacted either via email <strong><%=request("emailAddress")%></strong> <%if TRIM(Request("contactPhone")) <> "" then %> and/or by phone <strong><%=request("contactPhone")%></strong>  <% End if %> to arrange a convenient time to complete your application with us in person.
<p></p>
<%if TRIM(request("emailAddress")) <> "" then %>
For your records, a copy of your application has also been sent to your email address. It is not necessary to send multiple online applications. Once you've completed our entire application process, we may have many different job openings for you to consider depending on your individual skills.
<% end if %>
<p></p>
Feel free to contact your local Personnel Plus <a href="/company/offices.asp"><strong>Office</strong></a> if you have any additional questions.
<p></p>
Thank you <%=request("firstName")%>, we look forward to meeting with you soon!
<p></p>
- The
<% Select Case session("targetOffice") %>
<% Case "boise@personnel.com" %>
Boise
<% Case "burley@personnel.com" %>
Burley
<% Case "nampa@personnel.com" %>
Nampa
<% Case "twin@personnel.com" %>
Twin Falls
<% End Select %>
Personnel Plus Staff

		</TD>
	</TR>
</TABLE>

<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
</BODY>
</HTML>
