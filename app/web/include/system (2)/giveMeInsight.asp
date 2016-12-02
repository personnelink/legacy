<%
if Request.QueryString("debug") = 1 then
	for each x in Request.ServerVariables
	  response.write(x & ": " & request.serverVariables(x) & "<br />")
	next
	
	response.write("SessionID: " & Session.SessionID)
	
end if
%>
