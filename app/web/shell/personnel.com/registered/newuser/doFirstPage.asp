<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<% 
if session("mbrAuth") = "true" then
response.redirect("/registered/logged/index.asp")
end if
%>

<%
dim tmp_email_address	: 	tmp_email_address = TRIM(ConvertString(request("emailAddress")))
dim tmp_password		:	tmp_password = TRIM(ConvertString(request("password")))


if tmp_email_address = "" OR tmp_password = "" then
  response.redirect("index.asp?error=2")
Else

Function CheckMail(strEmail)
  dim objRegExp , blnValid
  Set objRegExp = New RegExp
  objRegExp.Pattern = "^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
  blnValid = objRegExp.Test(strEmail)
  if blnValid then
    Else
    response.redirect("index.asp?error=3&emailAddress="& tmp_email_address)
  End if 
End Function

CheckMail(tmp_email_address)

dim rsFindDupe, sql


	sql = "SELECT count(mbr_email_address) AS theCount FROM tbl_members WHERE mbr_email_address = '" & tmp_email_address & "'"
	Set rsFindDupe = Connect.Execute(sql)
	
	if rsFindDupe("theCount") <> 0 then
	  response.redirect("index.asp?error=1&emailAddress=" & tmp_email_address)
	  rsFindDupe.Close  
	Else
	  Set rsFindDupe = Nothing
	
	 session("tmp_email_address") = tmp_email_address
	 session("tmp_password") = tmp_password

	response.redirect("secondPage.asp")
	
	end if
end if
%>
