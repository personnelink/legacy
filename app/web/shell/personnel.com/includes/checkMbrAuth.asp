<%
if session("mbrAuth") <> "true" then 
response.redirect("/registered/login.asp?error=3")
end if
%>
