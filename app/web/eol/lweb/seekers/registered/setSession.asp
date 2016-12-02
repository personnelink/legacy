<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<%
session.Contents.RemoveAll()
session.Abandon
session("auth") = ""
session("employerAuth") = ""
session("adminAuth") = ""

'response.cookies("employer") ("auth") = ""
'response.cookies("admin") ("auth") = ""
'response.cookies("seeker") ("auth") = ""

dim tmpUserName,tmpPassWord,strSendBackTo	
' MUNGE LOGIN DATA & PAGE TARGETING
If request("pgOrig") = "hp" Then
strSendBackTo = "/lweb/index2.asp?#applicant"
tmpUserName = TRIM(request("uN"))
tmpPassWord = TRIM(request("uNer"))
ElseIf request("pgOrig") = "sj" Then
strSendBackTo = "/lweb/search/index.asp"
tmpUserName = TRIM(request("uN"))
tmpPassWord = TRIM(request("uNer"))
	Else
tmpUserName = TRIM(request("userName"))
tmpPassWord = TRIM(request("password"))
End If

' Seeker
Set rsSeekerProfile = Server.CreateObject("ADODB.Recordset")
rsSeekerProfile.Open "SELECT seekID,firstName,lastName,addressOne,addressTwo,city,state,zipCode,contactPhone,userName,password,emailAddress,numResumes,suspended,dateCreated FROM tbl_seekers WHERE userName ='" & tmpUserName & "'", Connect, 3, 3
Set rsCount = Connect.Execute("SELECT count(*) AS theCount FROM tbl_seekers WHERE userName = '" & tmpUserName & "'")
' ADMIN
Set rsAdmins = Server.CreateObject("ADODB.Recordset")
rsAdmins.Open "SELECT admID,userName,companyName,password,city,emailAddress,firstName,lastName,permitLevel FROM tbl_admin WHERE userName ='" & tmpUserName & "'", Connect, 3, 3
Set rsAdminCount = Connect.Execute("SELECT count(*) AS theCount FROM tbl_admin WHERE userName = '" & tmpUserName & "'")

' Did we get a recordset for an admin?
' if not then assume we have a normal user:
if rsAdminCount("theCount") = 0 then
	if rsCount("theCount") = 0 then response.redirect("/lweb/index2.asp?who=2&error=9&notfound=" & tmpUserName & "&#applicant") end if
	if rsSeekerProfile("password") <> tmpPassWord then response.redirect("/lweb/index2.asp?who=2&error=8&#applicant") end if
	if rsSeekerProfile("suspended") = "Yes" then response.redirect("/lweb/index2.asp?who=2&error=6&#applicant") end if
	session("seekID") = rsSeekerProfile("seekID")
	session("firstName") = rsSeekerProfile("firstName")
	session("lastName") = rsSeekerProfile("lastName")
	session("userName") = tmpUserName
	session("password") = tmpPassWord		
	session("addressOne") = rsSeekerProfile("addressOne")
	session("addressTwo") = rsSeekerProfile("addressTwo")
	session("city") = rsSeekerProfile("city")
	session("state") = rsSeekerProfile("state")
	session("zipCode") = rsSeekerProfile("zipCode")	
	session("emailAddress") = rsSeekerProfile("emailAddress")
	session("numResumes") = rsSeekerProfile("numResumes")	
	session("contactPhone") = rsSeekerProfile("contactPhone")
	session("dateCreated") = rsSeekerProfile("dateCreated")
	session("suspended") = rsSeekerProfile("suspended")
	session("auth") = "true"

' Update Our Cookies Every Time We Zip Through Here Kids
		response.cookies("seeker").expires = Date + 31
		response.cookies("seeker").path = "/lweb"		
		response.cookies("seeker") ("auth") = "true"
		response.cookies("seeker") ("userName") = tmpUserName
		response.cookies("seeker") ("password") = tmpPassWord		
		
	response.redirect("/lweb/seekers/registered/index.asp?who=2")

rsSeekerProfile.Close
rsCount.Close
	
else

	if rsAdmins("password") <> tmpPassWord then response.redirect("/lweb/index2.asp?error=1&#applicant") end if
	session("admID") = rsAdmins("admID")
	session("userName") = rsAdmins("userName")
	session("city") = rsAdmins("city")
	session("emailAddress") = rsAdmins("emailAddress")
	session("firstName") = rsAdmins("firstName")
	session("lastName") = rsAdmins("lastName")
	session("companyName") = rsAdmins("companyName")
	session("permitLevel") = rsAdmins("permitLevel")
	session("adminAuth") = "true"

		response.cookies("admin").expires = Date + 30
		response.cookies("admin").path = "/lweb/"
		response.cookies("admin") ("auth") = "true"
		response.cookies("admin") ("userName") = tmpUserName
		response.cookies("admin") ("password") = tmpPassWord
		
	response.redirect("/lweb/index2.asp?#applicant")

rsAdmins.Close
rsAdminCount.Close
end if
%>