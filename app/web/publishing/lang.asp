<%@LANGUAGE="VBSCRIPT"%>
<%
Dim Ubloglanguage ' lingua da utilizzare
Ubloglanguage = request.querystring("lang")
If Ubloglanguage = "italian" then 
Session("language") = "italian"
else
Session("language") = "english"
end if 
response.redirect ("index.asp")
%>