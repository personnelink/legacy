<%Option Explicit%>

<%
session("add_css") = "css/practice.css"
session("required_user_level") = 256 'userLevelSupervisor
%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE FILE='practice.do.vb' -->
<!-- #INCLUDE FILE='practice.html' -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
