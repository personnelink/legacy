<%
	session("add_css") = "./dropl.asp.css"
	session("page_title") = "Employers"
	session("no-auth") = true
	session("window_page_title") = "Employers - Personnel Plus"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->
<div id="contacts"> <%

thisUsersID = user_id
thisUsersSecurityLevel = user_level	

Database.Open MySql
Set contacts = Database.Execute("Select * From tbl_content Where class='employer' Order By classindex")
do while not contacts.eof 
	
	contentID = contacts("id")
	contentClass = contacts("class")
	contentIndex = contacts(("classindex"))
	contentDate = contacts("date")
	contentHeading = contacts("heading")
	contentBody = contacts("content")
	
	if thisUsersSecurityLevel => userLevelPPlusSupervisor then
		manageThisBlog = true
		contentTasks = "<a class='right' href=""" & imageURL & "/include/user/post/?blogid=" & contentID & Chr(34) &_
			" title='Edit Message'><img src='" & imageURL & "/include/style/images/blogEdit.png' alt=''></a>"
	end if

	response.write decorateTop(contentClass & contentID, "marLRB10", contentHeading & contentTasks)
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
