<%@ Language=VBScript %>
<%
	'response.write(Request.ServerVariables("SERVER_NAME"))
	'Response.End()	
	Response.Status="301 Moved Permanently"
	if request.serverVariables("HTTPS") = "on" then
	
		Response.AddHeader "Location","https://www.personnelinc.com/userHome.asp"
	Else
		'WhichServer =  request.serverVariables("LOCAL_ADDR")
		'if WhichServer = "192.168.0.3" then
		'	Response.AddHeader "Location","http://www.personnelplus.net/include/content/home.asp"
		'Else
			Response.AddHeader "Location","https://www.personnelinc.com/include/content/home.asp"
		'end if
	end if
%> 