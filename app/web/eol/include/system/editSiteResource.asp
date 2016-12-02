<%Option Explicit%>
<%
Session("additionalStyling") = "shortForms.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/master/masterPageTop.asp' -->
<!-- Revised: 3.27.2009 -->
<!-- Created: 11.22.2008 -->
<%
Dim deleteBlogID

deleteBlogID = Request.QueryString("removeblogid")
If deleteBlogID > 0 Then
	Database.Open MySql
	Database.Execute("DELETE From tbl_blogs Where blog_id=" & deleteBlogID)
	Database.Close
	Response.Redirect("/userHome.asp")
End If

	Dim blogSubject, blogBody, blogID, sqlCommand
	If Request.Form("postIt") = "true" Then
		Database.Open MySql
		blogSubject = Replace(Request.Form("blogSubject"), "'", "''")
		blogBody = Replace(Request.Form("blogBody"), "'", "''")
		blogBody = Replace(blogBody, Chr(13), "<br>")
		blogID = Request.form("blogID")
		If Len(blogID & "") = 0 Then blogID = 0
		If blogID > 0 Then
			sqlCommand = "Update tbl_blogs Set blog_date=Now(), blog_title='" & blogSubject & "', blog_text='" & blogBody & "' Where" &_
				" blog_id=" & blogID
		Else
			sqlCommand = "Insert Into tbl_blogs (userID, blog_date, blog_title, blog_text) Values ('" & _
						Session("userID") & "'," & _
						"Now()," & _
						"'" & Server.HTMLEncode(blogSubject) & "'," & _
						"'" & Server.HTMLEncode(blogBody) & "')"
		End If
		
		'Response.Write(sqlCommand)
		'Response.End
		
		Database.Execute(sqlCommand)
		Database.Close
		Response.Redirect("/userHome.asp")
	End If
	
blogID = Request.QueryString("blogid")
If blogID > 0 Then
	Database.Open MySql
	dbQuery = Database.Execute("Select blog_title, blog_text From tbl_blogs Where blog_id=" & blogID)
	blogSubject = dbQuery("blog_title")
	blogBody = dbQuery("blog_text")
	blogBody = Replace(blogBody, "<br>", Chr(13))
	Database.Close
End If

%>
<%=decorateTop("manageBlogForm", "notToShort", "Message Subject and Body")%>
<form id="messageBlogForm" name="messageBlog" method="post" action="blog_add.asp">
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
<!-- #INCLUDE VIRTUAL='/include/master/pageFooter.asp' -->
