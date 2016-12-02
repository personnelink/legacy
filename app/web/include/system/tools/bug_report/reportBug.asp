<%Option Explicit%>
<%
dim bugSubject, bugContact, bugBody, bugID, sqlCommand
dim bugged_page
dim bugged_agent
dim bugged_qs
dim bugged_url
dim bugged_user

if request.form("postIt") = "true" then
	
	bugged_page = Request.Form("bugged_page") 
	bugged_agent = Request.Form("bugged_agent") 

	bugged_qs = Request.Form("bugged_qs") 
	bugged_url = Request.Form("bugged_url") 
	
	if instr(bugged_page, "?") > 0 then
		dim urlAndQs
		urlAndQs = split(bugged_page, "?")
		bugged_page = urlAndQs(0)
		bugged_qs = urlAndQs(1)
	end if
	
	bugged_user = Request.Form("bugged_user")
	bugContact = Server.HTMLEncode(request.form("bugContact"))
	bugSubject = Server.HTMLEncode(request.form("bugSubject"))
	bugBody = request.form("bugBody")
	
	bugBody = "<send_as_html>" &_
		"<p><em>Subject:</em> " & bugSubject & "</p>" &_
		"<p><em>Contact:</em> " & bugContact & "</p>" &_
		"<p><em>User:</em> " & bugged_user & "</p><hr>" &_
		"<p><em>Bug:</em> " & bugBody & "</p><hr>" &_
		"<p><em>Bug Tool:</em> " & bugged_url & "</p>" &_
		"<p><em>Page:</em> " & bugged_page & "</p>" &_
		"<p><em>Query String: " & bugged_qs & "</p>" &_
		"<p><em>Agent:</em> " & bugged_agent & "</p>"

	Call SendEmail ("Bug Report<debug@personnel.com>", system_email, "Bug Report: " & bugSubject, bugBody, "")

	session("homeMessageHeading") = "Message Submitted"
	session("homeMessageBody") = "<div id=""bugReported""><p><strong> Thank you!</strong>" &_
		"<p>We continuously improve and enhance features and services we offer and feedback you provide " &_
		"is paramount to helping us provide the highest quality experience possible!</p><p>" &_
		"<p>Thank you for taking time to give us that feedback.</p>" &_
		"<p><i>- Personnel Plus Web Team</i></p></div>"
	Server.Transfer("/userHome.asp")
end if

bugged_page = Request.ServerVariables ("HTTP_REFERER") 
bugged_agent = Request.ServerVariables ("HTTP_USER_AGENT")
bugged_qs = Request.ServerVariables ("QUERY_STRING") 
bugged_url = Request.ServerVariables ("URL") 

session("additionalScripting") = "<script src=""/include/js/tinymce/tinymce.min.js""></script><script type=""text/javascript"" src=""reportBug.js""></script>"

session("add_css") = "./reportBug.asp.css" 
session("window_page_title") = "Bug Report - Personnel Plus"
%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- Revised: 3.27.2009 -->
<!-- Created: 11.22.2008 -->
<%
	
%>
<%=decorateTop("manageBugForm", "notToShort marLR10", "Bug (or Feedback and/or Suggestions) Subject and Body")%>
<form id="messageBugForm" name="messageBugForm" method="post" action="reportBug.asp">

	<%=decorateTop("missing_stuff", "marLR10 hide", "Some important things were missed")%>
	<div id="missed_items"%>&nbsp;</div>
	<%=decorateBottom()%>

<div id="bugFormContent">
    <input type="hidden" name="postIt" value="true" >
	<input type="hidden" name="bugged_page" value="<%=bugged_page%>">
	<input type="hidden" name="bugged_agent" value="<%=bugged_agent%>">
	<input type="hidden" name="bugged_qs" value="<%=bugged_qs%>">
	<input type="hidden" name="bugged_url" value="<%=bugged_url%>">
	<input type="hidden" name="bugged_user" value="<%=user_name%>">
	<input type="hidden" name="bugID" value="<%=bugID%>">
    <p>
      <label id="lbl_bugContact" for="bugContact">Contact Information</label>
      <input name="bugContact" id="bugContact" type="text" maxlength="255" value="<%=bugContact%>" onBlur="check_field(this);">
    </p>
    <p>
      <label id="lbl_bugSubject" for="bugSubject">Subject</label>
      <input name="bugSubject" id="bugSubject" type="text" maxlength="50" value="<%=bugSubject%>" onBlur="check_field(this);">
    </p>
    <p>
      <label id="lbl_bugBody" for="bugBody">Message Body</label>
      <textarea name="bugBody" cols="" rows="" onBlur="check_field(this);"><%=bugBody%></textarea>
    </p>
    <p id="postMessageButton">
		<a class="squarebutton" href="javascript:;" onclick="complete_report();">
			<span>Submit Report</span>
		</a>
	</p>
    <script type="text/javascript"><!--
		  document.messageBugForm.bugContact.focus()
		   //--></script>
  </div>
</form>


<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
