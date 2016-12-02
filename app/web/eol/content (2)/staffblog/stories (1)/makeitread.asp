<%
session("add_css") = "./makeitread.asp.css" %>

<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->

<%
thisUsersID = user_id
thisUsersSecurityLevel = user_level	

const imgdirectory = "stories/images/"
const storydirectory = "stories/"

dim story_id
story_id = only_numbers(request.querystring("story_id"))

if len(story_id) > 0 then 

	Database.Open MySql

	dim story
	Set story = Database.Execute("Select story from staffblog_story where story_id=" & story_id)

	if not story.eof then
		
		if thisUsersSecurityLevel => userLevelPPlusSupervisor then
			manageThisBlog = true
			contentTasks = "<a style='float:right; clear: none;' href=" & Chr(34) & "/include/user/post/?blogid=" & id & Chr(34) &_
				" title='Edit Message'><img src='" & imglink & "/include/style/images/blogEdit.png' alt=''></a>"
		end if

		%><div class="main_story"><%=story("story")%></div><%
		
		manageThisBlog = false
		blogTasks = ""
	end if
	Set story = Nothing
	Database.Close 

end if

%>
  
<!-- End of content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->



























