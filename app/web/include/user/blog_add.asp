<%Option Explicit%>
<%
dim post_it
post_it = request.form("postIt")
if post_it = "true" then session("no_header") = true

session("add_css") = "shortForms.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- Revised: 3.27.2009 -->
<!-- Created: 11.22.2008 -->
<%
dim deleteBlogID, referredFrom

deleteBlogID = Request.QueryString("removeblogid")
if deleteBlogID > 0 then
	if request.form("confirmed") = "yes" then
		Database.Open MySql
		Database.Execute("DELETE From tbl_blogs Where id=" & deleteBlogID)
		Database.Close
		Response.Redirect("/userHome.asp")
	Else
		response.write decorateTop("", "notToShort marLR10", "Are you sure you want to do this?")
		response.write "<div id=""confirmDelete"">You cannot undo this, are you sure you want to delete this?</div>"
		response.write "<p id=""deleteMessage""><a class=""squarebutton"" href=""javascript:document.forms['messageBlogForm'].submit();"" onclick=""document.forms['messageBlogForm'].submit();""><span>Yes, Delete</span></a></p>"
		response.write "<script type=""text/javascript""><!--"
		response.write "document.messageBlogForm.blogSubject.focus()"
		response.write "//--></script>"
		response.write decorateBottom()
	end if
end if

	dim blogSubject, blogContact, blogBody, blogID, sqlCommand, blogFormat
	if post_it = "true" then
		Database.Open MySql
		blogSubject = Replace(request.form("blogSubject"), "'", "''")
		blogContact = Replace(request.form("blogContact"), "'", "''")
		blogBody = Replace(request.form("blogBody"), "'", "''")
		blogID = Request.form("blogID")
		blogFormat = Request.form("formatting")
		
		if len(blogID & "") = 0 then blogID = 0
		if blogID > 0 then
			sqlCommand = "Update tbl_blogs Set date=Now(), heading='" & blogSubject & "', contact='" & blogContact & "', content='" & blogBody & "' Where" &_
				" id=" & blogID
		Else
			if blogFormat = "html" then	
				sqlCommand = "Insert Into tbl_blogs (userID, date, heading, contact, content, class) Values ('" & user_id & "'," & _
						"Now()," & "'" & blogSubject & "', '" & blogContact & "'," & "'" & blogBody & "')"
			Else			
				blogBody = Replace(blogBody, Chr(13), "<br>")
				sqlCommand = "Insert Into tbl_blogs (userID, date, heading, contact, content, class) Values ('" &_
					user_id & "'," &_
					"Now()," &_
					"'" & Server.HTMLEncode(blogContact) & "'," &_
					"'" & Server.HTMLEncode(blogSubject) & "'," &_
					"'" & Server.HTMLEncode(blogBody) & "'," &_
					"'message')"
			end if
		end if
		
		'response.write(sqlCommand)
		'Response.End
		
		Database.Execute(sqlCommand)
		Database.Close

		referringQuery = request.form("referringQuery")
		referringURL = request.form("referringURL")
		if len(Trim(referringQuery)) > 0 then referringURL = referringURL & "?" & referringQuery


		session("no_header") = false
		Response.Redirect(referringURL)

		'Response.Redirect("/userHome.asp")
	end if
	
blogID = Request.QueryString("blogid")
if blogID > 0 then
	Database.Open MySql
	dbQuery = Database.Execute("Select heading, contact, content From tbl_blogs Where id=" & blogID)
	blogContact = dbQuery("contact")
	blogContact = Replace(blogContact & "", """", "'")
	blogContact = Replace(blogContact & "", "'", "''")
	blogSubject = dbQuery("heading")
	blogBody = dbQuery("content")
	blogBody = Replace(blogBody, "<br>", Chr(13))
	Database.Close
end if

%>

<%=decorateTop("manageBlogForm", "notToShort marLR10", "Message Subject and Body")%>

<form id="messageBlogForm" name="messageBlog" method="post" action="blog_add.asp">
  <div id="blogFormContent">
    <input type="hidden" name="postIt" value="true" >
	<input type="hidden" name="blogID" value="<%=blogID%>" >
    <p>
      <label for="blogContact">Contact Information</label>
      <input name="blogContact" type="text" maxlength="255" value="<%=blogContact%>" >
    </p>
    <p>
      <label for="blogSubject">Subject</label>
      <input name="blogSubject" type="text" maxlength="50" value="<%=blogSubject%>" >
    </p>
    <p>
      <label for="blogBody">Body</label>
      <textarea name="blogBody" cols="" rows=""><%=blogBody%></textarea>
    </p>
	
    <p id="blogFormat">
      <label for="blogBody">Message Formatting </label>
	<input type="radio" name="formatting" value="html" checked> HTML
	<input type="radio" name="formatting" value="text">Text<br>
	<input type="hidden" name="referringURL" value="<%=Request.ServerVariables("HTTP_REFERER")%>" />
	<input type="hidden" name="referringQuery" value="<%=Request.ServerVariables("QUERY_STRING")%>" />

	</p>
	
	
    <p id="postMessageButton"> <a class="squarebutton" href="javascript:document.forms['messageBlogForm'].submit();" onclick="document.forms['messageBlogForm'].submit();"><span>Submit</span></a></p>
    <script type="text/javascript"><!--
		  document.messageBlogForm.blogSubject.focus()
		   //--></script>
  </div>
</form>

<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
