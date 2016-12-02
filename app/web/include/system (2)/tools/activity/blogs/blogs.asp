<%Option Explicit%>
<% session("add_css") = "./blogs.asp.css"
session("page_title") = "User Home"
session("required_user_level") = 4096 'userLevelPPlusStaff
session("window_page_title") = "Manage Blog Messages - Personnel Plus"
dim is_service
if request.QueryString("isservice") = "true" then
	is_service = true
	session("no_header") = true
end if

%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="blogs.js"></script>
<form id="blog_form" name="blog_form" action="" method="get">
<%

if not is_service then response.write decorateTop("homeBlogSpot", "marLR10", "")

Database.Open MySql

dim thisUsersID, thisUsersSecurityLevel
thisUsersID = user_id
thisUsersSecurityLevel = user_level

dim checkedText : checkedText = "checked=""checked"""
dim public_checked : public_checked = ""
dim private_checked : private_checked = ""

dim blogPosts
dim blogUserID
dim blogID
dim blogDate
dim blogTasks
dim blogSubject
dim blogBody
dim getUserName
dim manageThisBlog
dim blogVisible


Set blogPosts = Database.Execute("select * from tbl_blogs where Class='message' order By date desc")

do while not blogPosts.eof 
	
	blogID = blogPosts("id")
	blogUserID = blogPosts("userID")
	blogDate = blogPosts("date")
	blogSubject = blogPosts("heading")
	blogBody = blogPosts("content")
	blogVisible = blogPosts("visible")
	getUserName = Database.Execute("Select userName From tbl_users Where userID=" & blogUserID)
	
	if thisUsersSecurityLevel => userLevelPPlusSupervisor then
		manageThisBlog = true
	elseif blogUserID = thisUsersID then
		manageThisBlog = true
	end if
	
	if manageThisBlog then
		blogTasks = "<a href=""/include/user/post/?removeblogid=" & blogID & "&blogid=" & blogID & """ title=""Delete Message"" class=""delBlog"">" &_
		"<img src=""/include/style/images/blogDelete.png"" alt=""""></a><a href=""/include/user/post/?blogid=" &_
		blogID & """ title=""Edit Message"" class=""editBlog""><img src=""/include/style/images/blogEdit.png"" alt=""""></a><span class=""blogDate"">" & blogDate & "</span>"

	end if

	if blogVisible = 1 then
		public_checked = checkedText
		private_checked = ""
	else
		public_checked = ""
		private_checked = checkedText
	end if
	
	response.write "<p><h5>" & blogSubject & blogTasks & "</h5></p>" &_
		"<span><p>" & blogBody & "</p></span>"&_
		"<p class=""security"">" &_
		"<label class=""public"" for=""public" & blogID & """>" &_
			"<input id=""public" & blogID & """ name=""security" & blogID & """ type=""radio"" value=""1"" " &_
				"onclick=""change.show('" & blogID & "')"" " &_
				public_checked & ">Public [viewable]</label><span id=""Status" & blogID & """ class=""Idle""></span>" &_
		"<label class=""private"" for=""private" & blogID & """>Private [hidden]" &_
			"<input id=""private" & blogID & """ name=""security" & blogID & """ type=""radio"" value=""0"" " &_
				"onclick=""change.hide('" & blogID & "')"" " &_
				private_checked & "></label></p>"

	manageThisBlog = false
	blogTasks = ""
	blogPosts.Movenext
loop
Set blogPosts = Nothing
Database.Close 


if is_service then
	response.End()
else
	response.write decorateBottom()
end if


%>
</form>
<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
