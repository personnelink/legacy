<!-- INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
<%

set rsUpdateProfile = Server.CreateObject("ADODB.RecordSet")
rsUpdateProfile.Open "SELECT * FROM tbl_seekers WHERE seekID = '" & session("seekID") & "'",Connect,3,3

rsUpdateProfile("numResumes") = rsUpdateProfile("numResumes") + 1
rsUpdateProfile.update		


' Make sure we are not getting a double submission...
dim tmpUserName		:	tmpUserName = request("userName")

dim rsFindDupe, sqlFindDupe

sqlFindDupe = "SELECT count(userName) AS theCount FROM tbl_resumes WHERE userName = '" & tmpUserName & "'"
Set rsFindDupe = Connect.Execute(sqlFindDupe)

'IF rsFindDupe("theCount") <> 0 THEN
' Do Not Insert, send back to edit existing resume
' Error = 4
'  response.redirect("/seekers/registered/applyOnline.asp?who=2&?error=318&dupeResName=" & tmpUserName)
'ELSE

' Update the main fields:

dim seekID						: seekID=session("seekID")
dim userName					: userName=user_name
dim firstName					: firstName=user_firstname
dim lastName					: lastName=user_lastname
dim addressOne					: addressOne=session("addressOne")
dim addressTwo					: addressTwo=session("addressTwo")
dim city						: city=session("city")
dim state						: state=session("state")
dim zipCode						: zipCode=user_zip
dim contactPhone				: contactPhone=session("contactPhone")
dim emailAddress				: emailAddress=session("emailAddress")
dim title						: title="Resume Emailed to Personnel Plus ask for: " & user_firstname & " " & user_lastname & " resume."

' Fill the rest of the fields in with blanks.

dim workAuth					: workAuth=" "
dim workAuthProof				: workAuthProof=" "
dim workAge						: workAge=" "
dim workConviction				: workConviction=" "
dim workTypeDesired				: workTypeDesired=" "
dim workValidLicense			: workValidLicense=" "
dim workLicenseType				: workLicenseType=" "
dim skillsSoftware				: skillsSoftware=" "
dim skillsClerical				: skillsClerical=" "
dim skillsIndustrial			: skillsIndustrial=" "
dim skillsManagement			: skillsManagement=" "
dim skillsConstruction			: skillsConstruction=" "
dim skillsHealthCare			: skillsHealthCare=" "
dim skillsBookkeeping			: skillsBookkeeping=" "
dim skillsSales					: skillsSales=" "
dim skillsTechnical				: skillsTechnical=" "
dim skillsFoodService			: skillsFoodService=" "
dim skillsGeneralLabor			: skillsGeneralLabor=" "
dim skillsSkilledLabor			: skillsSkilledLabor=" "
dim jobHistSMonthOne	: jobHistSMonthOne=" "
dim jobHistSYearOne		: jobHistSYearOne=" "
dim jobHistEMonthOne	: jobHistEMonthOne=" "
dim jobHistEYearOne		: jobHistEYearOne=" "
dim jobHistSDateOne			: jobHistSDateOne=" "
dim jobHistEDateOne 		: jobHistEDateOne=" "
dim jobHistSMonthTwo	: jobHistSMonthTwo=" "
dim jobHistSYearTwo		: jobHistSYearTwo=" "
dim jobHistEMonthTwo	: jobHistEMonthTwo=" "
dim jobHistEYearTwo		: jobHistEYearTwo=" "
dim jobHistSDateTwo			: jobHistSDateTwo=" "
dim jobHistEDateTwo 		: jobHistEDateTwo=" "
dim jobHistSMonthThree	: jobHistSMonthThree=" "
dim jobHistSYearThree	: jobHistSYearThree=" "
dim jobHistEMonthThree	: jobHistEMonthThree=" "
dim jobHistEYearThree	: jobHistEYearThree=" "
dim jobHistSDateThree		: jobHistSDateThree=" "
dim jobHistEDateThree		: jobHistEDateThree=" "
dim jobHistTitleOne				: jobHistTitleOne=" "
dim jobHistCpnyOne				: jobHistCpnyOne=" "
dim jobHistPhoneOne				: jobHistPhoneOne=" "
dim jobHistTitleTwo				: jobHistTitleTwo=" "
dim jobHistCpnyTwo 				: jobHistCpnyTwo=" "
dim jobHistPhoneTwo 			: jobHistPhoneTwo=" "
dim jobHistTitleThree			: jobHistTitleThree=" "
dim jobHistCpnyThree			: jobHistCpnyThree=" "
dim jobHistPhoneThree 			: jobHistPhoneThree=" "
dim eduLevel  					: eduLevel=" "
dim dateCreated					: dateCreated=now()
dim deleted			: deleted = "No"
dim active			: active = "No"
dim suspended		: suspended = "No"
dim jobObjective  				: jobObjective=" "
dim additionalInfo   			: additionalInfo="Resume Emailed to Personnel Plus ask for: " & user_firstname & " " & user_lastname & " resume."

dim strSQL
dim rsRes
strSQL = "INSERT INTO tbl_resumes (seekID, userName, firstName, lastName, addressOne, addressTwo, city, state, zipCode, contactPhone, emailAddress, workAuth, workAuthProof, workAge, workConviction, workTypeDesired, workValidLicense, workLicenseType, title, skillsSoftware, skillsClerical, skillsIndustrial, skillsManagement, skillsConstruction, skillsHealthCare, skillsBookkeeping, skillsSales, skillsTechnical, skillsFoodService, skillsGeneralLabor, skillsSkilledLabor, jobHistTitleOne, jobHistCpnyOne, jobHistPhoneOne, jobHistTitleTwo, jobHistCpnyTwo, jobHistPhoneTwo, jobHistTitleThree, jobHistCpnyThree, jobHistPhoneThree, jobHistSDateOne, jobHistEDateOne, jobHistSDateTwo, jobHistEDateTwo, jobHistSDateThree, jobHistEDateThree, eduLevel, deleted, active, suspended, dateCreated, jobObjective, additionalInfo) VALUES (" & _
"'" & seekID & "'," & _
"'" & userName & "'," & _
"'" & firstName & "'," & _
"'" & lastName & "'," & _
"'" & addressOne & "'," & _
"'" & addressTwo & "'," & _
"'" & city & "'," & _
"'" & state & "'," & _
"'" & zipCode & "'," & _
"'" & contactPhone & "'," & _
"'" & emailAddress & "'," & _
"'" & workAuth & "'," & _
"'" & workAuthProof & "'," & _
"'" & workAge & "'," & _
"'" & workConviction & "'," & _
"'" & workTypeDesired & "'," & _
"'" & workValidLicense & "'," & _
"'" & workLicenseType & "'," & _
"'" & title & "'," & _
"'" & skillsSoftware & "'," & _
"'" & skillsClerical & "'," & _
"'" & skillsIndustrial & "'," & _
"'" & skillsManagement & "'," & _
"'" & skillsConstruction & "'," & _
"'" & skillsHealthCare & "'," & _
"'" & skillsBookkeeping & "'," & _
"'" & skillsSales & "'," & _
"'" & skillsTechnical & "'," & _
"'" & skillsFoodService & "'," & _
"'" & skillsGeneralLabor & "'," & _
"'" & skillsSkilledLabor & "'," & _
"'" & jobHistTitleOne & "'," & _
"'" & jobHistCpnyOne & "'," & _
"'" & jobHistPhoneOne & "'," & _
"'" & jobHistTitleTwo & "'," & _
"'" & jobHistCpnyTwo & "'," & _
"'" & jobHistPhoneTwo & "'," & _
"'" & jobHistTitleThree & "'," & _
"'" & jobHistCpnyThree & "'," & _
"'" & jobHistPhoneThree & "'," & _
"'" & jobHistSDateOne & "'," & _
"'" & jobHistEDateOne & "'," & _
"'" & jobHistSDateTwo & "'," & _
"'" & jobHistEDateTwo & "'," & _
"'" & jobHistSDateThree & "'," & _
"'" & jobHistEDateThree & "'," & _
"'" & eduLevel & "'," & _
"'" & deleted & "'," & _
"'" & active & "'," & _
"'" & suspended & "'," & _
"'" & dateCreated & "'," & _
"'" & jobObjective & "'," & _
"'" & additionalInfo & "'" & ")"

'response.write("My SQL= " & strSql)
'on error resume next
set rsRes = Connect.Execute(strSql)

'sqlResumeInfo = "SELECT * FROM tbl_resumes WHERE seekID = '" & session("seekID") & "'"

dim rsEditSeeker,rsnumResumes

' Edit job seeker profile
'Set rsEditSeeker = Server.CreateObject("ADODB.Recordset")
'rsEditSeeker.Open "SELECT seekID,numResumes FROM tbl_seekers WHERE seekID = '" & session("seekID") & "'", Connect,3,3

'if rsEditSeeker("numResumes") = "0" then
'	rsnumResumes = "1"
'else
'	rsnumResumes = rsEditSeeker("numResumes") + 1
'end if
'
'  rsEditSeeker("numResumes") = rsnumResumes
'  rsEditSeeker.Update

%>