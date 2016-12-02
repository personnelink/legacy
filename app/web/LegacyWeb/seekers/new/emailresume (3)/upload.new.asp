<!-- #INCLUDE VIRTUAL='/inc/dbConn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
<%
' this is for maidsource
dim job_wanted	:	job_wanted = request("job_wanted")
' set a flag to prevent re-submittals, at least per session

session("directApply") = "1"

dim emailToAddress		:		emailToAddress = session("targetOffice")

if TRIM(emailToAddress) = "" then
	emailToAddress = "twin@personnel.com"
end if

response.cookies("applyDirect")("officeSelector") = request("officeSelector")
if request("officeSelector") = "other" then
	response.cookies("applyDirect")("other_location") = request("other_location")
end if
if TRIM("job_wanted") <> "" then
	response.cookies("applyDirect")("job_wanted") = request("job_wanted")
end if
response.cookies("applyDirect")("firstName") = request("firstName")
response.cookies("applyDirect")("lastName") = request("lastName")
response.cookies("applyDirect")("addressOne") = request("addressOne")
if request("addressTwo") <> "" then
	response.cookies("applyDirect")("addressTwo") = request("addressTwo")
end if
response.cookies("applyDirect")("city") = request("city")
response.cookies("applyDirect")("state") = request("state")
response.cookies("applyDirect")("zipCode") = request("zipCode")
if request("contactPhone") <> "" then 
	response.cookies("applyDirect")("contactPhone") = request("contactPhone")
end if
if request("emailAddress") <> "" then 
	response.cookies("applyDirect")("emailAddress") = request("emailAddress")
end if
response.cookies("applyDirect")("emailToAddress") = session("targetOffice")
response.cookies("applyDirect")("desiredWageAmount") = request("desiredWageAmount")
response.cookies("applyDirect")("minWageAmount") = request("minWageAmount")
response.cookies("applyDirect")("workTypeDesired") = request("workTypeDesired")
response.cookies("applyDirect")("workAuth") = request("workAuth")
response.cookies("applyDirect")("workAuthProof") = request("workAuthProof")
response.cookies("applyDirect")("workAge") = request("workAge")
response.cookies("applyDirect")("workValidLicense") = request("workValidLicense")
response.cookies("applyDirect")("workLicenseType") = request("workLicenseType")
response.cookies("applyDirect")("workRelocate") = request("workRelocate")
response.cookies("applyDirect")("workConviction") = request("workConviction")
if request("workConviction") = "Yes" then
	response.cookies("applyDirect")("workConvictionExplain") = request("workConvictionExplain")
end if
if request("preferred") <> "" then
	response.cookies("applyDirect")("preferred") = request("preferred")
end if
response.cookies("applyDirect")("eduLevel") = request("eduLevel")
if request("additionalInfo") <> "" then
	response.cookies("applyDirect")("additionalInfo") = request("additionalInfo")
end if
if request("referenceNameOne") <> "" then
	response.cookies("applyDirect")("referenceNameOne") = request("referenceNameOne")
	response.cookies("applyDirect")("referencePhoneOne") = request("referencePhoneOne")
end if
if request("referenceNameTwo") <> "" then
	response.cookies("applyDirect")("referenceNameTwo") = request("referenceNameTwo")
	response.cookies("applyDirect")("referencePhoneTwo") = request("referencePhoneTwo")
end if
if request("referenceNameThree") <> "" then
	response.cookies("applyDirect")("referenceNameThree") = request("referenceNameThree")
	response.cookies("applyDirect")("referencePhoneThree") = request("referencePhoneThree")
end if

response.redirect"/seekers/new/emailresume/upload2.asp"
%>