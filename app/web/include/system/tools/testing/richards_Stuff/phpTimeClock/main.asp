<%Option Explicit%>
<%
session("required_user_level") = 256 'userLevelSupervisor
%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<style>
#leftSideMenu {
	display: none;
}
</style>

<%
dim timeclock
    Set timeclock = Server.CreateObject("MSXML2.ServerXMLHTTP")
    
    timeclock.Open "GET", "https://next.personnelinc.com/php/include/system/tools/testing/richards_Stuff/Timeclock/index.php:444", false
    timeclock.Send
    Response.write timeclock.responseText
    Set timeclock = Nothing 
%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' --> 
    <li><a href="#" onclick="window.open('https://www.accessidaho.org/public/corr/offender/search.html');
onclick=window.open('http://isp.idaho.gov/sor_id/search.html'); onclick=window.open('https://www.idcourts.us/repository/start.do'); onclick=window.open('http://login.publicdata.com/');"
title="Background Checks">
<div class=""></div>Background Checks</a></li>