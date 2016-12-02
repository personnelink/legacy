<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->

<%
dim empID								: empID=Request.Form("admID")
dim companyUserName						: companyUserName=Request.Form("companyUserName")
dim jobSchedule							: jobSchedule=Request.Form("jobSchedule")
dim companyName							: companyName=Request.Form("companyName")
dim companyAgent						: companyAgent=Request.Form("companyAgent")
dim jobTitle							: jobTitle=ConvertString(Request.Form("jobTitle"))
dim jobCategory							: jobCategory=Request.Form("jobCategory")
dim jobEmailAddress						: jobEmailAddress=Request.Form("jobEmailAddress")
dim jobContactPhone						: jobContactPhone=Request.Form("jobContactPhone")
dim jobContactPhoneExt					: jobContactPhoneExt=Request.Form("jobContactPhoneExt")
dim jobAddressOne						: jobAddressOne=Request.Form("jobAddressOne")
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
strSQL = "INSERT INTO tbl_listings (empID, companyUserName, jobSchedule, companyName, companyAgent, jobTitle,jobCategory, jobEmailAddress, jobContactPhone, jobContactPhoneExt, jobAddressOne, jobCity, jobState, jobZipCode, jobCountry, jobReportTo, jobTimeLunch, jobTimeBreaks, jobDressCode, jobLicenseReq, jobCDLReq, jobStatus, jobStartDate, jobEndDate, wageType, wageAmount, deleted, dateCreated, jobDescription) VALUES (" & _
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

response.redirect("/index.asp")

%>
