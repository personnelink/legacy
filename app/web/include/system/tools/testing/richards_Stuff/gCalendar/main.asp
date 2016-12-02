<%Option Explicit%>

<%
session("required_user_level") = 256 'userLevelSupervisor
%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->

<style>
 
 #leftSideMenu {
	 
	 display:none;
 }
 
 #contentcolumn {
	 border-left:none;
	 float:none;
	 padding:0;
 }
	
</style>
<!-- #INCLUDE FILE='gCalendar.html' -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
