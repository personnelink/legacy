<font class="bottomMenu"> <a href="/lweb/company/privacy.asp">
Privacy Policy</a>&nbsp;&nbsp;|&nbsp;&nbsp;  
<a href="/lweb/company/privacy.asp#terms">
Terms of Use</a> &nbsp;&nbsp;|&nbsp;&nbsp; 
<%
If Session("auth") = "true" then %>
	<a href="mailto:webmaster@personnelplus-inc.com?Subject=Webmaster Notification (<% response.write(Session("userName"))%>)">
	<img src="/lweb/img/pic_mail.gif" alt="" width="13" height="9" border="0" align="bottom"> Feedback / Notify Webmaster</a>
<% Elseif Session("employerAuth") = "true" then %>
	<a href="mailto:webmaster@personnelplus-inc.com?Subject=Webmaster Notification (<% response.write(Session("companyUserName"))%>)">
	<img src="/lweb/img/pic_mail.gif" alt="" width="13" height="9" border="0" align="bottom"> Feedback / Webmaster</a>
<% Elseif Session("adminAuth") = "true" then %>
	<a href="mailto:webmaster@personnelplus-inc.com?Subject=Webmaster Notification (<% response.write(Session("userName"))%>)">
	<img src="/lweb/img/pic_mail.gif" alt="" width="13" height="9" border="0" align="bottom"> Feedback / Webmaster</a>
<% Else %>
	<a href="mailto:webmaster@personnelplus-inc.com?Subject=Webmaster Notification">
	<img src="/lweb/img/pic_mail.gif" alt="" width="13" height="9" border="0" align="bottom"> Feedback / Webmaster</a>
<% End If %>
</font> 

  

 



