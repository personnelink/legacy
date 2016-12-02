<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpAuth.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		doChangeEmail.asp
'		Description:	Updates tbl_employers with new primary email address
'		Created:		Monday, February 16, 2004
'		LastMod:		Monday, February 16, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************


dim e1					:	e1 = ConvertString(TRIM(request("e1")))
dim e2					:	e2 = ConvertString(TRIM(request("e2")))

if e1 = "" OR e2 = "" then ' check for empty strings
  Response.Redirect("changeEmail.asp?error=2")
end if
if e1 <> e2 then ' be sure addresses match
  Response.Redirect("changeEmail.asp?error=1")
 Else

 ' double check email address
Function CheckMail(strEmail)
  dim objRegExp , blnValid
  Set objRegExp = New RegExp
  objRegExp.Pattern = "^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
  blnValid = objRegExp.Test(strEmail)
  if blnValid then
    Else
    response.redirect("changeEmail.asp?error=3&badVal="& e1)
  End if 
End Function

CheckMail(e1)


session("emailAddress") = e1

dim rsUpdEmp, sqlUpdEmp, sqlPart1, sqlPart2, sqlValues
sqlPart1 = "UPDATE tbl_employers SET "
sqlPart2 = "WHERE emp_id=" & session("empID")
sqlValues = ""
sqlValues = sqlValues & "emp_email_address='" & e1 & "' "	
sqlUpdEmp = sqlPart1 & sqlValues & sqlPart2
Set rsUpdEmp = Connect.Execute(sqlUpdEmp)

end if


Set rsUpdEmp = Nothing
Connect.Close
Set Connect = Nothing

response.redirect("changeEmail.asp?confirm=1&newEmail=" & e1)
%>