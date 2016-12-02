<%
session("add_css") = "general.asp.css"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->
<%

thisUsersID = user_id
thisUsersSecurityLevel = user_level	

Database.Open MySql
Set content = Database.Execute("Select * From tbl_content Where class='about' Order By classindex")
do while not content.eof 
	
	contentID = content("id")
	contentClass = content("class")
	contentIndex = content(("classindex"))
	contentDate = content("date")
	contentHeading = content("heading")
	contentBody = content("content")
	contentOptionID = content("optionalid")
	
	if thisUsersSecurityLevel => userLevelPPlusSupervisor then
		manageThisBlog = true
		contentTasks = "<a style='float:right; clear: none;' href=" & Chr(34) & "/include/user/post/?blogid=" & contentID & Chr(34) &_
			" title='Edit Message'><img src='" & imageURL & "/include/style/images/blogEdit.png' alt=''></a>"
	end if

	if len(contentOptionID) > 0 then
		CssID = contentOptionID
	Else
		CssID = contentClass & contentID
	end if
	
	response.write decorateTop(CssID, "marLRB10", contentHeading & contentTasks)
	response.write "<div id='" & contentClass & contentID & "-" & contentIndex & "'>" & contentBody & "</div>"
	response.write decorateBottom()

	manageThisBlog = false
	blogTasks = ""
	content.Movenext
loop
Set contacts = Nothing
Database.Close 

%>

<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
