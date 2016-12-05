<%
if session("empAuth") <> "true" then 
response.redirect("/employers/login.asp?error=3")
end if
%>