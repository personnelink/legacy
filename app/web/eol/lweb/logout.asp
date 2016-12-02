<%
' Kaboom! Bye Bye
response.cookies("seeker") ("auth") = ""
response.cookies("seeker") ("userName") = ""
response.cookies("seeker") ("password") = ""

response.cookies("employer") ("auth") = ""
response.cookies("employer") ("companyUserName") = ""
response.cookies("employer") ("password") = ""

response.cookies("admin") ("auth") = ""
response.cookies("admin") ("userName") = ""
response.cookies("admin") ("password") = ""

session.Abandon
session.Contents.RemoveAll()
session("auth") = ""
session("employersAuth") = ""
session("adminAuth") = ""

response.redirect("/index.asp")
%>