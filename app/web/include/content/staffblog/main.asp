<%@ Language=VBScript %>
<%
' Permanent redirection
Response.Status = "301 Moved Permanently"
Response.AddHeader "Location", "http://www.personnelinc.com/include/content/blogs/staff/"
Response.End
%>