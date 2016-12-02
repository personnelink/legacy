<!--#include virtual="/lweb/inc/dbconn.asp"--> 
<%
' Make sure we are not getting a double submission...
dim tmpUserName		:	tmpUserName = request("userName")

dim rsFindDupe, sqlFindDupe

sqlFindDupe = "SELECT count(userName) AS theCount FROM tbl_resumes WHERE userName = '" & tmpUserName & "'"
Set rsFindDupe = Connect.Execute(sqlFindDupe)

IF rsFindDupe("theCount") <> 0 THEN
' Do Not Insert, send back to edit existing resume
 Error = 4
  response.redirect("/lweb/seekers/registered/applyOnline.asp?who=2&?error=318&dupeResName=" & tmpUserName)
ELSE

dim seekID						: seekID=Request.Form("seekID")
dim userName					: userName=Request.Form("userName")
dim firstName					: firstName=Request.Form("firstName")
dim lastName					: lastName=Request.Form("lastName")
dim addressOne					: addressOne=Request.Form("addressOne")
dim addressTwo					: addressTwo=Request.Form("addressTwo")
dim city						: city=Request.Form("city")
dim state						: state=Request.Form("state")
dim zipCode						: zipCode=Request.Form("zipCode")
dim contactPhone				: contactPhone=Request.Form("contactPhone")
dim emailAddress				: emailAddress=Request.Form("emailAddress")
dim workAuth					: workAuth=Request.Form("workAuth")
dim workAuthProof				: workAuthProof=Request.Form("workAuthProof")
dim workAge						: workAge=Request.Form("workAge")
dim workConviction				: workConviction=Request.Form("workConviction")
dim workTypeDesired				: workTypeDesired=Request.Form("workTypeDesired")
dim workValidLicense			: workValidLicense=Request.Form("workValidLicense")
dim workLicenseType				: workLicenseType=Request.Form("workLicenseType")
dim title						: title=Request.Form("title")
dim skillsSoftware				: skillsSoftware=Request.Form("skillsSoftware")
dim skillsClerical				: skillsClerical=Request.Form("skillsClerical")
dim skillsIndustrial			: skillsIndustrial=Request.Form("skillsIndustrial")
dim skillsManagement			: skillsManagement=Request.Form("skillsManagement")
dim skillsConstruction			: skillsConstruction=Request.Form("skillsConstruction")
dim skillsHealthCare			: skillsHealthCare=Request.Form("skillsHealthCare")
dim skillsBookkeeping			: skillsBookkeeping=Request.Form("skillsBookkeeping")
dim skillsSales					: skillsSales=Request.Form("skillsSales")
dim skillsTechnical				: skillsTechnical=Request.Form("skillsTechnical")
dim skillsFoodService			: skillsFoodService=Request.Form("skillsFoodService")
dim skillsGeneralLabor			: skillsGeneralLabor=Request.Form("skillsGeneralLabor")
dim skillsSkilledLabor			: skillsSkilledLabor=Request.Form("skillsSkilledLabor")
dim jobHistSMonthOne	: jobHistSMonthOne=Request.Form("jobHistSMonthOne")
dim jobHistSYearOne		: jobHistSYearOne=Request.Form("jobHistSYearOne")
dim jobHistEMonthOne	: jobHistEMonthOne=Request.Form("jobHistEMonthOne")
dim jobHistEYearOne		: jobHistEYearOne=Request.Form("jobHistEYearOne")
dim jobHistSDateOne			: jobHistSDateOne=(jobHistSMonthOne & "/" & jobHistSYearOne)
dim jobHistEDateOne 		: jobHistEDateOne=(jobHistEMonthOne & "/" & jobHistEYearOne)
dim jobHistSMonthTwo	: jobHistSMonthTwo=Request.Form("jobHistSMonthTwo")
dim jobHistSYearTwo		: jobHistSYearTwo=Request.Form("jobHistSYearTwo")
dim jobHistEMonthTwo	: jobHistEMonthTwo=Request.Form("jobHistEMonthTwo")
dim jobHistEYearTwo		: jobHistEYearTwo=Request.Form("jobHistEYearTwo")
dim jobHistSDateTwo			: jobHistSDateTwo=(jobHistSMonthTwo & "/" & jobHistSYearTwo)
dim jobHistEDateTwo 		: jobHistEDateTwo=(jobHistEMonthTwo & "/" & jobHistEYearTwo)
dim jobHistSMonthThree	: jobHistSMonthThree=Request.Form("jobHistSMonthThree")
dim jobHistSYearThree	: jobHistSYearThree=Request.Form("jobHistSYearThree")
dim jobHistEMonthThree	: jobHistEMonthThree=Request.Form("jobHistEMonthThree")
dim jobHistEYearThree	: jobHistEYearThree=Request.Form("jobHistEYearThree")
dim jobHistSDateThree		: jobHistSDateThree=(jobHistSMonthThree & "/" & jobHistSYearThree)
dim jobHistEDateThree		: jobHistEDateThree=(jobHistEMonthThree & "/" & jobHistEYearThree)
dim jobHistTitleOne				: jobHistTitleOne=TRIM(Request.Form("jobHistTitleOne"))
dim jobHistCpnyOne				: jobHistCpnyOne=TRIM(Request.Form("jobHistCpnyOne"))
dim jobHistPhoneOne				: jobHistPhoneOne=Request.Form("jobHistPhoneOne")
dim jobHistTitleTwo				: jobHistTitleTwo=TRIM(Request.Form("jobHistTitleTwo"))
dim jobHistCpnyTwo 				: jobHistCpnyTwo=TRIM(Request.Form("jobHistCpnyTwo"))
dim jobHistPhoneTwo 			: jobHistPhoneTwo=Request.Form("jobHistPhoneTwo")
dim jobHistTitleThree			: jobHistTitleThree=TRIM(Request.Form("jobHistTitleThree"))
dim jobHistCpnyThree			: jobHistCpnyThree=TRIM(Request.Form("jobHistCpnyThree"))
dim jobHistPhoneThree 			: jobHistPhoneThree=Request.Form("jobHistPhoneThree")
dim eduLevel  					: eduLevel=Request.Form("eduLevel")
dim dateCreated					: dateCreated=now()
dim deleted			: deleted = "No"
dim active			: active = "No"
dim suspended		: suspended = Request.Form("suspended")
dim jobObjective  				: jobObjective=ConvertString(Request.Form("jobObjective"))
dim additionalInfo   			: additionalInfo=ConvertString(Request.Form("additionalInfo"))

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

response.redirect("/lweb/seekers/registered/applyOnline3.asp?who=2")
End If

%>

