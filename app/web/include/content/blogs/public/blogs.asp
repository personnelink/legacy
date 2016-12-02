<%Option Explicit%>
<% session("add_css") = "./blogs.asp.css"
session("page_title") = "User Home"
session("window_page_title") = "Public Blog - Personnel Plus"%>

<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->
<%
dim enrollmentMessage, enrollmentMessageTxt
	enrollmentMessageTxt = "<div id=""introBlog""><p class=""bigger""><em>A Welcome to Our Blog</em></p>" &_
		"<p>Welcome to Personnel Plus’s online forum designed to share experiences and insights! " &_
		"As an enhancement to Personnel Plus – businesses and applicants staffing and employment solutions – " &_
		"we’ve gathered stories, observations, reflections, and more.</p><p>" &_
		"Visit us often to read notes from the field and hear the latest about " &_
		"jobs. Blog postings are made by several writers who share a passion for careers and staffing.</p> " &_
		"<p>And of course, we want to hear your comments and more. We hope you’ll enjoy and help build our community designed " &_
		"to promote and pique your career around us.</p><br>" &_
		"<p id=""signature"">Very Truly Yours,</p>" &_
		"</div>"
	response.write "<div id=""blogback"">"
	response.write(decorateTop("publicBlog", "marLR10 transparent", ""))
	response.write(enrollmentMessageTxt)
	response.write(decorateBottom())


Database.Open MySql

dim thisUsersID, thisUsersSecurityLevel
thisUsersID = user_id
thisUsersSecurityLevel = user_level

dim blogPosts
dim blogUserID
dim blogID
dim blogDate
dim blogTasks
dim blogSubject
dim blogBody
dim getUserName
dim manageThisBlog



response.write "<div id=""postmessage""><a href=""/include/user/post/"">[ post a message ]</a></div></div>"
response.write decorateTop("homeBlogSpot", "marLR10", "")

Set blogPosts = Database.Execute("SELECT * FROM tbl_blogs WHERE (Class='message' AND visible=true) ORDER By date desc")
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
		blogTasks = "<a href=""/include/user/post/?removeblogid=" & blogID & "&blogid=" & blogID & """ title=""Delete Message"" class=""delBlog"">" &_
		"<img src=""/include/style/images/blogDelete.png"" alt=""""></a><a href=""/include/user/post/?blogid=" &_
		blogID & """ title=""Edit Message"" class=""editBlog""><img src=""/include/style/images/blogEdit.png"" alt=""""></a>"

	end if
	
	response.write "<p><h5>" & blogSubject & blogTasks & "<span class=""blogDate"">" & blogDate & "</span></h5></p><div class=""blog""><span><p>" & blogBody & "</p></span></div>"
	manageThisBlog = false
	blogTasks = ""
	blogPosts.Movenext
loop
Set blogPosts = Nothing
Database.Close 

response.write decorateBottom()

%>
<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
