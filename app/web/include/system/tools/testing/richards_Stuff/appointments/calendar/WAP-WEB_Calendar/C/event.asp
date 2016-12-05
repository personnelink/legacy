<% 
Response.ContentType = "text/vnd.wap.wml"
Response.Buffer = True
%>

<!-- #include file="functions.asp" -->

<?xml version="1.0"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
	<card id="start">		
		<%
		iID = Request.QueryString("ID")
		Call OpenDB()
		sSQL = "SELECT * FROM Calendar WHERE ID = " & iID
		Call OpenRORS(sSQL)
		%>
		<p><b><%= objRS("Subject") %></b></p>
		<%
		
		If objRS.EOF then
			Response.Write "<p><b>Event not found.</b></p>"
		else
			Response.Write "<p>" & objRS("Message") & "</p>"
		end if
		
		Call CloseRS()
		Call CloseDB()
		%>
		<do type="options" label="Home">
			<go href="Default.asp#start" />
		</do>
	</card>
</wml>
