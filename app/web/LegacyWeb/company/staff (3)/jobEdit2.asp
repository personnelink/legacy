<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
<% if session("adminAuth") <> "true" then
response.redirect("/index.asp")
end if 

dim srchStr				:	srchStr = request("srchStr")
%>
<%
' open job record to update
set rsEditJob = Server.CreateObject("ADODB.RecordSet")
rsEditJob.Open "SELECT * FROM tbl_listings WHERE jobID = '" & request("jobID") & "'",Connect,3,3

' perform update
rsEditJob("empID") = session("admID")
rsEditJob("companyUserName") = user_name
rsEditJob("jobSchedule") = request("jobSchedule")
rsEditJob("companyName") = TRIM(request("companyName"))
rsEditJob("companyAgent") = TRIM(request("companyAgent"))
rsEditJob("jobTitle") = TRIM(request("jobTitle"))
rsEditJob("jobCategory") = request("jobCategory")
rsEditJob("jobEmailAddress") = TRIM(request("jobEmailAddress"))
rsEditJob("jobContactPhone") = TRIM(request("jobContactPhone"))
rsEditJob("jobContactPhoneExt") = TRIM(request("jobContactPhoneExt"))
rsEditJob("jobAddressOne") = TRIM(request("jobAddressOne"))
rsEditJob("jobAddressTwo") = TRIM(request("jobAddressTwo"))
rsEditJob("jobCity") = TRIM(request("jobCity"))
rsEditJob("jobState") = request("jobState")
rsEditJob("jobZipCode") = TRIM(request("jobZipCode"))
rsEditJob("jobCountry") = TRIM(request("jobCountry"))
rsEditJob("jobReportTo") = TRIM(request("jobReportTo"))
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
'rsEditJob("xxxx") = request("xxxx")
'rsEditJob("xxxx") = request("xxxx")
rsEditJob.update		

'jobID
'jobNumber
'jobStatus
'deleted
'dateJobClosed
'dateCreated







response.redirect("/company/staff/jobModList.asp?xCrypt=" & srchStr)
%>


