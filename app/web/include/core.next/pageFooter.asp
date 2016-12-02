<%
dim objLeftSideMenu
if showLeftSideMenu then
	objLeftSideMenu = "" &_
		"<div id=""leftSideMenu""><img id=""communications"" src=""/include/style/images/communication.jpg"" />" & leftSideMenu & "</div>"
end if

%>
</div><%=social_blob%></div></div><%=objLeftSideMenu%></div><div id="pageFooter"><div><div style="text-align:center"> <a href="<%=baseURL%>/include/content/privacy.asp">Privacy Policy</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="<%=baseURL%>/include/content/privacy.asp#terms">Terms of Use</a> &nbsp;&nbsp;|&nbsp;&nbsp;<a href="mailto:webmaster@personnelplus-inc.com?Subject=Webmaster Notification"><img src="/include/style/images/pic_mail.gif" alt="" width="13" height="9">&nbsp; Feedback / Notify Webmaster</a> </div><p>&copy;
<script type="text/javascript">
<!--
tday=new Date();
yr0=tday.getFullYear();
// end hiding -->
</script>
<script type="text/javascript">
<!-- Hide from old browsers
document.write(yr0);
// end hiding -->
</script>
Personnel Plus, Inc. All Rights Reserved. </p></div></div>
<%
select case request.querystring("nosocial")
	case "1"
		noSocial = true
end select
%>

<% if not is_mobile AND not noSocial AND not isSecure then %>
<div id='pageshare' title="Socializing">

<!--
<div class='sbutton' id='su'>
<script src="http://www.stumbleupon.com/hostedbadge.php?s=5"></script>
</div>


<div class='sbutton' id='digg' style='margin-left:3px;width:48px'>
<script src='http://widgets.digg.com/buttons.js' type='text/javascript'></script>
<a class="DiggThisButton DiggMedium"></a>
</div>

-->

<div class='sbutton' id='gplusone'>
<script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script>
<g:plusone size="tall"></g:plusone>
</div><%


end if

if is_mobile then
	response.write "</div></div></body></html>"
else
	response.write "</div></div></body></html>"
end if

	response.Flush()

	Set dbQuery =  Nothing
	Set Database = Nothing
	Set SystemDatabase = Nothing

	Session.Contents.RemoveAll()
	Response.End
%>
