<%@ Language=VBScript %>
<%
	'response.write(Request.ServerVariables("SERVER_NAME"))
	'Response.End()	
	Response.Status="301 Moved Permanently"
	Response.AddHeader "Location","https://secure.personnelplus.net/include/system/tools/submitapplication.asp"
%> 