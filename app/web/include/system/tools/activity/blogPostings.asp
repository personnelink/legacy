<% session("add_css") = "general.asp.css"
session("page_title") = "User Home"
session("required_user_level") = 4096 'userLevelPPlusStaff

dim is_service
if request.QueryString("isservice") = "true" then
	is_service = true
	session("no_header") = true
end if

%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<%

if not is_service then response.write decorateTop("homeBlogSpot", "marLR10", "")

Database.Open MySql
thisUsersID = user_id
thisUsersSecurityLevel = user_level
Set blogPosts = Database.Execute("select * from tbl_content where Class='message' order By date desc")
do while not blogPosts.eof 
	
	blogID = blogPosts("id")
	blogUserID = blogPosts("userID")
	blogDate = blogPosts("date")
	blogSubject = blogPosts("heading")
	blogBody = blogPosts("content")
	getUserName = Database.Execute("Select userName From tbl_users Where userID=" & blogUserID)
	
	if thisUsersSecurityLevel => userLevelPPlusSupervisor then
		manageThisBlog = true
	elseif blogUserID = thisUsersID then
		manageThisBlog = true
	end if
	
	if manageThisBlog then
		blogTasks = "<a href=""/include/user/blog_add.asp?removeblogid=" & blogID & "&blogid=" & blogID & """ title=""Delete Message"" class=""delBlog"">" &_
		"<img src=""/include/style/images/blogDelete.png"" alt=""""></a><a href=""/include/user/blog_add.asp?blogid=" &_
		blogID & """ title=""Edit Message"" class=""editBlog""><img src=""/include/style/images/blogEdit.png"" alt=""""></a>"

	end if
	
	response.write "<p><h5>" & blogSubject & blogTasks & "</h5></p><span><p>" & blogBody & "</p></span>"
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
<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
