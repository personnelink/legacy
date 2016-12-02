<%Option Explicit%>
<%
session("add_css") = "shortForms.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- Revised: 3.27.2009 -->
<!-- Created: 11.22.2008 -->
<%
dim deleteBlogID

deleteBlogID = Request.QueryString("removeblogid")
if deleteBlogID > 0 then
	Database.Open MySql
	Database.Execute("DELETE From tbl_content Where id=" & deleteBlogID)
	Database.Close
	Response.Redirect("/userHome.asp")
end if

	dim blogSubject, blogBody, blogID, sqlCommand
	if request.form("postIt") = "true" then
		Database.Open MySql
		blogSubject = Replace(request.form("blogSubject"), "'", "''")
		blogBody = Replace(request.form("blogBody"), "'", "''")
		blogBody = Replace(blogBody, Chr(13), "<br>")
		blogID = Request.form("blogID")
		if len(blogID & "") = 0 then blogID = 0
		if blogID > 0 then
			sqlCommand = "Update tbl_content Set date=Now(), heading='" & blogSubject & "', content='" & blogBody & "' Where" &_
				" id=" & blogID
		Else
			sqlCommand = "Insert Into tbl_content (userID, date, heading, content) Values ('" & _
						user_id & "'," & _
						"Now()," & _
						"'" & Server.HTMLEncode(blogSubject) & "'," & _
						"'" & Server.HTMLEncode(blogBody) & "')"
		end if
		
		'response.write(sqlCommand)
		'Response.End
		
		Database.Execute(sqlCommand)
		Database.Close
		Response.Redirect("/userHome.asp")
	end if
	
blogID = Request.QueryString("blogid")
if blogID > 0 then
	Database.Open MySql
	dbQuery = Database.Execute("Select heading, content From tbl_content Where id=" & blogID)
	blogSubject = dbQuery("heading")
	blogBody = dbQuery("content")
	blogBody = Replace(blogBody, "<br>", Chr(13))
	Database.Close
end if

%>
<%=decorateTop("manageBlogForm", "notToShort marLR10", "Message Subject and Body")%>
<form id="messageBlogForm" name="messageBlog" method="post" action="../tools/system/post/">
  <div id="blogFormContent">
    <input type="hidden" name="postIt" value="true" >
	<input type="hidden" name="blogID" value="<%=blogID%>" >
    <p>
      <label for="blogSubject">Subject</label>
      <input name="blogSubject" type="text" maxlength="50" value="<%=blogSubject%>" >
    </p>
    <p>
      <label for="blogBody">Message Body</label>
      <textarea name="blogBody" cols="" rows=""><%=blogBody%></textarea>
    </p>
    <p id="postMessageButton"> <a class="squarebutton" href="javascript:document.forms['messageBlogForm'].submit();" onclick="document.forms['messageBlogForm'].submit();"><span>Post Message</span></a></p>
    <script type="text/javascript"><!--
		  document.messageBlogForm.blogSubject.focus()
		   //--></script>
  </div>
</form>


<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
