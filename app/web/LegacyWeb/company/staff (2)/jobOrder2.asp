<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->

<%
dim empID								: empID=request.form("admID")
dim companyUserName						: companyUserName=request.form("companyUserName")
dim jobSchedule							: jobSchedule=request.form("jobSchedule")
dim companyName							: companyName=request.form("companyName")
dim companyAgent						: companyAgent=request.form("companyAgent")
dim jobTitle							: jobTitle=ConvertString(request.form("jobTitle"))
dim jobCategory							: jobCategory=request.form("jobCategory")
dim jobEmailAddress						: jobEmailAddress=request.form("jobEmailAddress")
dim jobContactPhone						: jobContactPhone=request.form("jobContactPhone")
dim jobContactPhoneExt					: jobContactPhoneExt=request.form("jobContactPhoneExt")
dim jobAddressOne						: jobAddressOne=request.form("jobAddressOne")
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
