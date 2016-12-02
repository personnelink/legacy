<!-- #INCLUDE VIRTUAL='/include/core/html_header.asp' -->
<%
session("add_css") = "general.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/html_styles.asp' -->
<!-- Revision Date: 2010.01.27 -->
<!-- #INCLUDE VIRTUAL='/include/core/navi_top_menu.asp' -->
<div id="contacts"> <%

thisUsersID = user_id
thisUsersSecurityLevel = user_level	

Database.Open MySql
Set contacts = Database.Execute("Select * From tbl_content Where class='services' Order By classindex")
do while not contacts.eof 
	
	contentID = contacts("id")
	contentClass = contacts("class")
	contentIndex = contacts(("classindex"))
	contentDate = contacts("date")
	contentHeading = contacts("heading")
	contentBody = contacts("content")
	
	if thisUsersSecurityLevel => userLevelPPlusSupervisor then
		manageThisBlog = true
		contentTasks = "<a href=" &	Chr(34) & "/include/user/post/?blogid=" & contentID & Chr(34) &_
			" title='Edit Message'><img src='" & imageURL & "/include/style/images/blogEdit.png' alt=''></a>"
		'contentTasks = "<a href=" & Chr(34) & "/include/user/post/?removeblogid=" & contentID & Chr(34) &_
		'	" title='Delete Message'><img src='/include/style/images/blogDelete.png' alt=''></a><a href=" &_
		'	Chr(34) & "/include/user/post/?blogid=" & contentID & Chr(34) &_
		'	" title='Edit Message'><img src='/include/style/images/blogEdit.png' alt=''></a>"
	end if

	response.write decorateTop(contentClass & contentID, "mar10", contentHeading & contentTasks)
	response.write "<div id='" & contentClass & contentID & "-" & contentIndex & "'>" & contentBody & "</div>"
	response.write decorateBottom()

	manageThisBlog = false
	blogTasks = ""
	contacts.Movenext
loop
Set contacts = Nothing
Database.Close 

%>
</div>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
