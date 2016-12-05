<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->

<%
' need to pull seekers_preferences and add to this as well as a few new fields
' see direct application for the new fields

dim rsResumeInfo, sqlResumeInfo

sqlResumeInfo = "SELECT * FROM tbl_resumes WHERE seekID = '" & session("seekID") & "'"
Set rsResumeInfo = Connect.Execute(sqlResumeInfo)

' Create default greeting to new job seeker
dim msgbody
msgBody = "Personnel Plus - Online Resume:" & " " & now() & chr(10) & chr(10)
msgBody = msgBody & user_firstname & " " & user_lastname & chr(13)
msgBody = msgBody & session("addressOne") & chr(13)
if session("addressTwo") <> "" then 
msgBody = msgBody & session("addressTwo") & chr(13) 
end if
msgBody = msgBody & session("city") & ", " & session("state") & " " & user_zip & chr(13)
msgBody = msgBody & session("contactPhone") & chr(13)
msgBody = msgBody & session("emailAddress") & chr(13)
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "JOB OBJECTIVES / SUMMARY:" & chr(13) & rsResumeInfo("jobObjective") & chr(10) & chr(10)
msgBody = msgBody & "I am 18 years or older:" & " " & rsResumeInfo("workAge") & chr(13)
msgBody = msgBody & "I have a valid drivers license:" & " " & rsResumeInfo("workValidLicense") & chr(13)
if rsResumeInfo("workLicenseType") <> "" then
msgBody = msgBody & "I have a" & " " & rsResumeInfo("workLicenseType") & " " & "license" & chr(13)
end if
msgBody = msgBody & "Have I ever been convicted of a felony in the U.S?" & " " & rsResumeInfo("workConviction") & chr(13)
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "LISTED AREAS OF KNOWLEDGE AND EXPERIENCE:" & chr(13)
msgBody = msgBody & "Software:" & chr(13) & rsResumeInfo("skillsSoftware") & chr(10) & chr(10)
msgBody = msgBody & "Clerical:" & chr(13) & rsResumeInfo("skillsClerical") & chr(10) & chr(10)
msgBody = msgBody & "Industrial:" & chr(13) & rsResumeInfo("skillsIndustrial") & chr(10) & chr(10)
msgBody = msgBody & "Managerial:" & chr(13) & rsResumeInfo("skillsManagement") & chr(10) & chr(10)
msgBody = msgBody & "Construction:" & chr(13) & rsResumeInfo("skillsConstruction") & chr(10) & chr(10)
msgBody = msgBody & "Healthcare:" & chr(13) & rsResumeInfo("skillsHealthCare") & chr(10) & chr(10)
msgBody = msgBody & "Bookkeeping:" & chr(13) & rsResumeInfo("skillsBookkeeping") & chr(10) & chr(10)
msgBody = msgBody & "Sales:" & chr(13) & rsResumeInfo("skillsSales") & chr(10) & chr(10)
msgBody = msgBody & "Technical:" & chr(13) & rsResumeInfo("skillsTechnical") & chr(10) & chr(10)
msgBody = msgBody & "Food Service:" & chr(13) & rsResumeInfo("skillsFoodService") & chr(10) & chr(10)
msgBody = msgBody & "General Labor:" & chr(13) & rsResumeInfo("skillsGeneralLabor") & chr(10) & chr(10)
msgBody = msgBody & "Skilled Labor:" & chr(13) & rsResumeInfo("skillsSkilledLabor")
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "CURRENT OR MOST RECENT EMPLOYER:" & chr(13)
msgBody = msgBody & "Job Title:" & " " & rsResumeInfo("jobHistTitleOne") & chr(13)
msgBody = msgBody & "Company Name:" & " " & rsResumeInfo("jobHistCpnyOne") & chr(13)
msgBody = msgBody & "Company Phone:" & " " & rsResumeInfo("jobHistPhoneOne") & chr(13)
msgBody = msgBody & "Dates:" & " " & rsResumeInfo("jobHistSDateOne") & "-" & rsResumeInfo("jobHistEDateOne") & chr(13)
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "2ND MOST RECENT EMPLOYER:" & chr(13)
msgBody = msgBody & "Job Title:" & " " & rsResumeInfo("jobHistTitleTwo") & chr(13)
msgBody = msgBody & "Company Name:" & " " & rsResumeInfo("jobHistCpnyTwo") & chr(13)
msgBody = msgBody & "Company Phone:" & " " & rsResumeInfo("jobHistPhoneTwo") & chr(13)
msgBody = msgBody & "Dates:" & " " & rsResumeInfo("jobHistSDateTwo") & "-" & rsResumeInfo("jobHistEDateTwo") & chr(13)
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "3RD MOST RECENT EMPLOYER:" & chr(13)
msgBody = msgBody & "Job Title:" & " " & rsResumeInfo("jobHistTitleThree") & chr(13)
msgBody = msgBody & "Company Name:" & " " & rsResumeInfo("jobHistCpnyThree") & chr(13)
msgBody = msgBody & "Company Phone:" & " " & rsResumeInfo("jobHistPhoneThree") & chr(13)
msgBody = msgBody & "Dates:" & " " & rsResumeInfo("jobHistSDateThree") & "-" & rsResumeInfo("jobHistEDateThree") & chr(13)
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "HIGHEST LEVEL OF EDUCATION:" & " " & rsResumeInfo("eduLevel") & chr(13)
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "ADDITIONAL INFORMATION:" & " " & rsResumeInfo("additionalInfo") & chr(10) & chr(10)


dim emailToAddress		:		emailToAddress = session("targetOffice")

' ** CDO Email
dim cdoConfig,cdoMessage
sch = "http://schemas.microsoft.com/cdo/configuration/"
Set cdoConfig = Server.CreateObject("CDO.Configuration")
With cdoConfig.Fields 
      .Item(sch & "sendusing") = 2 ' cdoSendUsingPort 
      .Item(sch & "smtpserver") = "mail.personnelplus-inc.com" 
      .Item(sch & "smtpserverport") = 25 
	  ' # note, the auth email below needs to eventually point to a pplus-inc email for clarity sake
      .Item(sch & "smtpauthenticate") = 1 ' cdoBasic
      .Item(sch & "sendusername") = "registration_manager@personnel.com"
      .Item(sch & "sendpassword") = "twin"
      .update 
End With 
Set cdoMessage = Server.CreateObject("CDO.Message") 
With cdoMessage 
  Set .Configuration = cdoConfig 
      .From = session("emailAddress")
      .bcc = "saguilar@aguilarfam.myrf.net"
      .To = "applicants@personnelplus-inc.com"
'	  .bcc = "jwerrbach@personnel.com"
      .Subject = "Personnel Plus - Direct Application: " & user_lastname & ", " & user_firstname
      .TextBody = msgBody
      .Send 
End With 

Set cdoMessage = Nothing 
Set cdoConfig = Nothing 
' CDO Email **


if session("state") = "ID" then
' is IDAHO resident
response.redirect("/seekers/registered/index.asp?who=2&?resVal=Yes&resType=int")
else
' not a Idaho resident
response.redirect("/seekers/registered/index.asp?who=2&?resVal=Yes&resType=ext")

end if
%>