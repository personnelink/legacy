<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpAuth.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		doChangePwd.asp
'		Description:	Updates tbl_employers with new password
'		Created:		Monday, February 16, 2004
'		LastMod:		Monday, February 16, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************


dim p1					:	p1 = ConvertString(TRIM(request("p1")))
dim p2					:	p2 = ConvertString(TRIM(request("p2")))

if p1 = "" OR p2 = "" then ' check for empty string
  Response.Redirect("changePwd.asp?error=2")
end if
if p1 <> p2 then ' be sure passwords match
  Response.Redirect("changePwd.asp?error=1")
 Else	

dim rsUpdEmp, sqlUpdEmp, sqlPart1, sqlPart2, sqlValues
sqlPart1 = "UPDATE tbl_employers SET "
sqlPart2 = "WHERE emp_id=" & session("empID")
sqlValues = ""
sqlValues = sqlValues & "emp_password='" & p1 & "' "	
sqlUpdEmp = sqlPart1 & sqlValues & sqlPart2
Set rsUpdEmp = Connect.Execute(sqlUpdEmp)

end if


Set rsUpdEmp = Nothing
Connect.Close
Set Connect = Nothing

response.redirect("changePwd.asp?confirm=1")
%>