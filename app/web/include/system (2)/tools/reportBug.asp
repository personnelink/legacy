<%Option Explicit%>
<%
dim bugSubject, bugContact, bugBody, bugID, sqlCommand
if request.form("postIt") = "true" then
	bugContact = Replace(request.form("bugContact"), "'", "''")
	bugSubject = Replace(request.form("bugSubject"), "'", "''")
	bugBody = Replace(request.form("bugBody"), "'", "''")

	Call SendEmail ("debug@personnel.com", system_email, "Bug Report: " & Server.HTMLEncode(bugContact) & Server.HTMLEncode(bugSubject), Server.HTMLEncode(bugBody), "")

	session("homeMessageHeading") = "Message Submitted"
	session("homeMessageBody") = "<div id=" & chr(34) & "bugReported" & chr(34) & "><p><strong> Thank you!</strong>" &_
		"<p>We are continuing to make improvements to the site and the services that we can offer. Your information and " &_
		"feedback is paramount to us offering the highest quility service and product available! " &_
		"Feel free to contact your nearest <a href='http://www.personnelplus.net/include/content/contact.asp'><strong>office " &_
		"location</strong></a> if you have any additional questions or concerns. Again, thank you for the feedback</p><p>- " &_
		"Personnel Plus Web Team</p></div>"
	Server.Transfer("/userHome.asp")
end if

session("add_css") = "shortForms.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- Revised: 3.27.2009 -->
<!-- Created: 11.22.2008 -->
<%
	
%>
<%=decorateTop("manageBugForm", "notToShort marLR10", "Bug (or Feedback and/or Suggestions) Subject and Body")%>
<form id="messageBugForm" name="messageBugForm" method="post" action="reportBug.asp">
  <div id="bugFormContent">
    <input type="hidden" name="postIt" value="true" >
	<input type="hidden" name="bugID" value="<%=bugID%>" >
    <p>
      <label for="bugContact">Contact Information</label>
      <input name="bugContact" id="bugContact" type="text" maxlength="255" value="<%=bugContact%>" >
    </p>
    <p>
      <label for="bugSubject">Subject</label>
      <input name="bugSubject" id="bugSubject" type="text" maxlength="50" value="<%=bugSubject%>" >
    </p>
    <p>
      <label for="bugBody">Message Body</label>
      <textarea name="bugBody" cols="" rows=""><%=bugBody%></textarea>
    </p>
    <p id="postMessageButton"> <a class="squarebutton" href="javascript:document.forms['messageBugForm'].submit();" onclick="document.forms['messageBugForm'].submit();"><span>Submit Report</span></a></p>
    <script type="text/javascript"><!--
		  document.messageBugForm.bugContact.focus()
		   //--></script>
  </div>
</form>


<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
