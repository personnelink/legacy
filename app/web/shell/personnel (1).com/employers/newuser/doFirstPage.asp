<% 
if session("empAuth") = "true" then
response.redirect("/employers/logged/index.asp")
end if
%>
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<%
dim tmp_email_address	: 	tmp_email_address = TRIM(ConvertString(request("emailAddress")))
dim tmp_password		:	tmp_password = TRIM(ConvertString(request("password")))
dim tmp_account_type	:	tmp_account_type = request("emp_account_type")
dim tmp_account_size	:	tmp_account_size = request("emp_account_size")

if tmp_email_address = "" OR tmp_password = "" then
  response.redirect("firstPage.asp?error=2")
Else

Function CheckMail(strEmail)
  dim objRegExp , blnValid
  Set objRegExp = New RegExp
  objRegExp.Pattern = "^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
  blnValid = objRegExp.Test(strEmail)
  if blnValid then
    Else
    response.redirect("firstPage.asp?error=3&emailAddress="& tmp_email_address)
  End if 
End Function

CheckMail(tmp_email_address)

dim rsFindDupe, sql


	sql = "SELECT count(emp_email_address) AS theCount FROM tbl_employers WHERE emp_email_address = '" & tmp_email_address & "'"
	Set rsFindDupe = Connect.Execute(sql)
	
	if rsFindDupe("theCount") <> 0 then
	  response.redirect("firstPage.asp?error=1&emailAddress=" & tmp_email_address)
	  rsFindDupe.Close  
	Else
	  Set rsFindDupe = Nothing
	
	 session("tmp_email_address") = tmp_email_address
	 session("tmp_password") = tmp_password

Connect.Close
Set Connect = Nothing

	response.redirect("secondPage.asp?act=" & tmp_account_type & "&acs=" & tmp_account_size)
	
	end if
end if
%>
