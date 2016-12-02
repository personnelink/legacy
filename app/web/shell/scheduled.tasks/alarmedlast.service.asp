<%
session("required_user_level") = 4096 'userLevelSupervisor
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->
<%

dim okaytoalarm
	okaytoalarm = get_session("lastalarmed")
if not isdate(okaytoalarm) then
	' "okay to alarm"
	okaytoalarm = set_session("lastalarmed", now())
	response.write true
	
elseif DateDiff("n", okaytoalarm , now()) <= 15 then
	'"not okay to alarm"
	response.write false
else
	okaytoalarm = set_session("lastalarmed", "")
	okaytoalarm = set_session("lastalarmed", now())
	response.write true
end if

if request.querystring("clear") = 1 then
	okaytoalarm = set_session("lastalarmed", "")
	response.write true
end if

ServiceEnd

%>
