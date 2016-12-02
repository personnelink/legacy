<font class="bottomMenu"> <a href="/company/privacy.asp">
Privacy Policy</a>&nbsp;&nbsp;|&nbsp;&nbsp;  
<a href="/company/privacy.asp#terms">
Terms of Use</a> &nbsp;&nbsp;|&nbsp;&nbsp; 
<%
if session("auth") = "true" then %>
	<a href="mailto:webmaster@personnelplus-inc.com?Subject=Webmaster Notification (<% response.write(user_name)%>)">
	<img src="/img/pic_mail.gif" alt="" width="13" height="9" border="0" align="bottom"> Feedback / Notify Webmaster</a>
<% elseif session("employerAuth") = "true" then %>
	<a href="mailto:webmaster@personnelplus-inc.com?Subject=Webmaster Notification (<% response.write(session("companyUserName"))%>)">
	<img src="/img/pic_mail.gif" alt="" width="13" height="9" border="0" align="bottom"> Feedback / Webmaster</a>
<% elseif session("adminAuth") = "true" then %>
	<a href="mailto:webmaster@personnelplus-inc.com?Subject=Webmaster Notification (<% response.write(user_name)%>)">
	<img src="/img/pic_mail.gif" alt="" width="13" height="9" border="0" align="bottom"> Feedback / Webmaster</a>
<% Else %>
	<a href="mailto:webmaster@personnelplus-inc.com?Subject=Webmaster Notification">
	<img src="/img/pic_mail.gif" alt="" width="13" height="9" border="0" align="bottom"> Feedback / Webmaster</a>
<% End if %>
</font> 

  

 



