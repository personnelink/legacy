<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/loggedRedirect.asp' -->	
<%
dim userName		:	userName = StripCharacters(TRIM(request("uN")))
dim password		:	password = StripCharacters(TRIM(request("uNer")))
dim rsFindDupe, sqlFindDupe

sqlFindDupe = "SELECT count(userName) AS theCount FROM tbl_seekers WHERE userName = '" & userName & "'"
Set rsFindDupe = Connect.Execute(sqlFindDupe)

IF rsFindDupe("theCount") <> 0 THEN
' DO NOT ADD
 Error = 1
  response.redirect("newAcct1.asp?error=1&nameTaken=" & userName)
  
rsFindDupe.Close  
ELSE
' START OUR SESSION TEMPS

session("temp_userName") = userName
session("temp_password") = password
session("temp_rememberMe") = request("rememberMe")

rsFindDupe.Close  
  response.redirect("newAcct3.asp?who=2")
END IF
%>
