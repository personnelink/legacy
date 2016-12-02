<%
response.write "VMS Distributed Computing Model Version: 0.00.0000.001 <br><br>"
response.write "Hello. <br><br>"
response.write "HTTP RPC Online and waiting for requests... " 
response.write Request.ServerVariables("SERVER_NAME")

select case lcase(request.ServerVariables("SERVER_NAME"))
case "nampa.rpc.personnelplus.net"
	response.write " [NAMPA-HYPER] ready."

case "burley.rpc.personnelplus.net"
	response.write " [BURLEY-MAIN-FS] ready."

case "boise.rpc.personnelplus.net"
	response.write " [BOISE-MAIN] ready."

end select

%>
