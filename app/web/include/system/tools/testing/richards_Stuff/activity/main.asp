<%

if request.querystring("isservice") = "1" then
	Server.Transfer("followActivities.service.asp")
else
	Server.Transfer("followActivities.asp")
end if

%>


