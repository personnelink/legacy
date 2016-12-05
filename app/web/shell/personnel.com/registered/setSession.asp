<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		setSession.asp
'		Description:	Processes member email address & password. Sets session vars and cookies.
'		Created:		Tuesday, February 17, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************

session("mbrAuth") = ""
session("empAuth") = ""
session.Contents.RemoveAll()


dim tmp_email_address	: tmp_email_address = ConvertString(TRIM(request("emailAddress")))
dim tmp_password		: tmp_password = ConvertString(TRIM(request("password")))

if tmp_email_address = "" or tmp_password = "" then
  response.redirect("login.asp?error=1")
end if

dim rsMbr, sql
Set rsMbr = Server.CreateObject("ADODB.Recordset")
sql = "SELECT mbr_id, mbr_password, mbr_first_name, mbr_last_name, mbr_num_resumes, mbr_location, mbr_is_suspended, mbr_email_address FROM tbl_members WHERE mbr_email_address ='" & tmp_email_address & "' AND mbr_password = '" & tmp_password & "'"
Set rsMbr = Connect.Execute(sql)

if rsMbr.eof = true and rsMbr.BOF = true then
  response.redirect("login.asp?error=1")
Else
  if CInt(rsMbr("mbr_is_suspended")) = 1 then 
    response.redirect("login.asp?error=2")
  End if  

Session.Timeout = 35
session("mbrAuth") = "true"
session("mbrID") = rsMbr("mbr_id")
user_firstname = rsMbr("mbr_first_name")
user_lastname = rsMbr("mbr_last_name")
session("emailAddress") = rsMbr("mbr_email_address")

  if request("setCookie") = "yes" then
    response.cookies("members").Expires = Date + 31
    response.cookies("members").path = "/"  
    response.cookies("members") ("mbrAuth") = "true"
    response.cookies("members") ("emailAddress") = tmp_email_address
  End if
  
rsMbr.Close
Set rsMbr = Nothing

Connect.Close
Set Connect = Nothing

response.redirect("logged/index.asp")
end if
%>