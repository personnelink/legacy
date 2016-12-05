<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		setSession.asp
'		Description:	Processes employer username & password. Sets session vars and cookies.
'		Created:		Tuesday, February 17, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************

session("empAuth") = ""
session("mbrAuth") = ""
session.Contents.RemoveAll()

dim tmp_email_address	: tmp_email_address = TRIM(Request("emailAddress"))
dim tmp_password	: tmp_password = TRIM(Request("password"))

if tmp_email_address = "" or tmp_password = "" then
  response.redirect("login.asp?error=1")
end if

dim rsEmp, sql
Set rsEmp = Server.CreateObject("ADODB.Recordset")
sql = "SELECT emp_id, emp_password, emp_is_suspended, emp_contact_name, emp_company_name, emp_email_address FROM tbl_employers WHERE emp_email_address ='" & tmp_email_address & "' AND emp_password = '" & tmp_password & "'"
Set rsEmp = Connect.Execute(sql)

if rsEmp.eof = true and rsEmp.BOF = true then
  response.redirect("login.asp?error=1")
Else
  if CInt(rsEmp("emp_is_suspended")) = 1 then 
    response.redirect("login.asp?error=2")
  End if  

Session.Timeout = 35
session("empAuth") = "true"
session("empID") = rsEmp("emp_id")
company_name = rsEmp("emp_company_name")
session("contactName") = rsEmp("emp_contact_name")
session("emailAddress") = tmp_email_address

  if request("setCookie") = "yes" then
    response.cookies("employers").Expires = Date + 31
    response.cookies("employers").path = "/"  
    response.cookies("employers") ("empAuth") = "true"
    response.cookies("employers") ("emailAddress") = tmp_email_address
  End if

rsEmp.Close
Set rsEmp = Nothing

Connect.Close
Set Connect = Nothing

response.redirect("logged/index.asp")
end if
%>