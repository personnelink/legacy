<%
session("add_css") = "./staff.asp.css"
session("window_page_title") = "Staff Blog - Personnel Plus"%>

<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->

<%
thisUsersID = user_id
thisUsersSecurityLevel = user_level	

Database.Open MySql

dim stories
Set stories = Database.Execute("SELECT * FROM staffblog_summary WHERE visible='1'")

const imgdirectory = "stories/images/thumbs/"
const storydirectory = "stories/"


dim id, link, imglink, heading, description, story_id
do while not stories.eof 
	
	id = stories("id")
	link = stories("link")
	imglink = stories("imglink")
	heading = stories("heading")
	description = stories("description")
	story_id = stories("story_id")
		
	if thisUsersSecurityLevel => userLevelPPlusSupervisor then
		manageThisBlog = true
		contentTasks = "<a style='float:right; clear: none;' href=" & Chr(34) & "/include/user/post/?blogid=" & id & Chr(34) &_
			" title='Edit Message'><img src='" & imglink & "/include/style/images/blogEdit.png' alt=''></a>"
	end if
%>
	  <div class="storylink">
	
	  
		<ul><li><a href="<%=storydirectory & "?story_id=" & story_id%>">
		  
		  <h4 class="heading"><%=heading%></h4>
		  <img src="<%=imgdirectory & imglink%>" alt=""><span class="description"><%=description%></span></a>
	  </li></ul>
	
	  </div> 
<%
	manageThisBlog = false
	blogTasks = ""
	stories.Movenext
loop
Set stories = Nothing
Database.Close 

%>
  
<!-- End of content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->



























