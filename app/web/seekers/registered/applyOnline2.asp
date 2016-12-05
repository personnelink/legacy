<!--#include virtual="/inc/dbConn.asp"--> 
<%
' Make sure we are not getting a double submission...
dim tmpUserName		:	tmpUserName = request("userName")

dim rsFindDupe, sqlFindDupe

sqlFindDupe = "SELECT count(userName) AS theCount FROM tbl_resumes WHERE userName = '" & tmpUserName & "'"
Set rsFindDupe = Connect.Execute(sqlFindDupe)

IF rsFindDupe("theCount") <> 0 THEN
' Do Not Insert, send back to edit existing resume
 Error = 4
  response.redirect("/seekers/registered/applyOnline.asp?who=2&?error=318&dupeResName=" & tmpUserName)
ELSE

dim seekID						: seekID=request.form("seekID")
dim userName					: userName=request.form("userName")
dim firstName					: firstName=request.form("firstName")
dim lastName					: lastName=request.form("lastName")
dim addressOne					: addressOne=request.form("addressOne")
dim addressTwo					: addressTwo=request.form("addressTwo")
dim city						: city=request.form("city")
dim state						: state=request.form("state")
dim zipCode						: zipCode=request.form("zipCode")
dim contactPhone				: contactPhone=request.form("contactPhone")
dim emailAddress				: emailAddress=request.form("emailAddress")
dim workAuth					: workAuth=request.form("workAuth")
dim workAuthProof				: workAuthProof=request.form("workAuthProof")
dim workAge						: workAge=request.form("workAge")
dim workConviction				: workConviction=request.form("workConviction")
dim workTypeDesired				: workTypeDesired=request.form("workTypeDesired")
dim workValidLicense			: workValidLicense=request.form("workValidLicense")
dim workLicenseType				: workLicenseType=request.form("workLicenseType")
dim title						: title=request.form("title")
dim skillsSoftware				: skillsSoftware=request.form("skillsSoftware")
dim skillsClerical				: skillsClerical=request.form("skillsClerical")
dim skillsIndustrial			: skillsIndustrial=request.form("skillsIndustrial")
dim skillsManagement			: skillsManagement=request.form("skillsManagement")
dim skillsConstruction			: skillsConstruction=request.form("skillsConstruction")
dim skillsHealthCare			: skillsHealthCare=request.form("skillsHealthCare")
dim skillsBookkeeping			: skillsBookkeeping=request.form("skillsBookkeeping")
dim skillsSales					: skillsSales=request.form("skillsSales")
dim skillsTechnical				: skillsTechnical=request.form("skillsTechnical")
dim skillsFoodService			: skillsFoodService=request.form("skillsFoodService")
dim skillsGeneralLabor			: skillsGeneralLabor=request.form("skillsGeneralLabor")
dim skillsSkilledLabor			: skillsSkilledLabor=request.form("skillsSkilledLabor")
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
dim jobHistTitleOne				: jobHistTitleOne=TRIM(request.form("jobHistTitleOne"))
dim jobHistCpnyOne				: jobHistCpnyOne=TRIM(request.form("jobHistCpnyOne"))
dim jobHistPhoneOne				: jobHistPhoneOne=request.form("jobHistPhoneOne")
dim jobHistTitleTwo				: jobHistTitleTwo=TRIM(request.form("jobHistTitleTwo"))
dim jobHistCpnyTwo 				: jobHistCpnyTwo=TRIM(request.form("jobHistCpnyTwo"))
dim jobHistPhoneTwo 			: jobHistPhoneTwo=request.form("jobHistPhoneTwo")
dim jobHistTitleThree			: jobHistTitleThree=TRIM(request.form("jobHistTitleThree"))
dim jobHistCpnyThree			: jobHistCpnyThree=TRIM(request.form("jobHistCpnyThree"))
dim jobHistPhoneThree 			: jobHistPhoneThree=request.form("jobHistPhoneThree")
dim eduLevel  					: eduLevel=request.form("eduLevel")
dim dateCreated					: dateCreated=now()
dim deleted			: deleted = "No"
dim active			: active = "No"
dim suspended		: suspended = request.form("suspended")
dim jobObjective  				: jobObjective=ConvertString(request.form("jobObjective"))
dim additionalInfo   			: additionalInfo=ConvertString(request.form("additionalInfo"))

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

response.redirect("/seekers/registered/applyOnline3.asp?who=2")
end if

%>

