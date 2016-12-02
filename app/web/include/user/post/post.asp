<%Option Explicit%>
<%
dim post_it
post_it = request.form("postIt")
if post_it = "true" then session("no_header") = true

session("add_css") = "./post.asp.css"
session("additionalScripting")  = "<script src=""/include/js/tinymce/tinymce.min.js""></script><script type=""text/javascript"" src=""/include/user/post/post.js""></script>"

dim CompoundId

%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->

<!-- #include file='post.doStuff.asp' -->

<%=decorateTop("manageBlogForm", "notToShort marLR10", formWindowTitle)%>
<form id="messageBlogForm" name="messageBlog" method="post" action="#">
  <div id="blogFormContent">
    <input type="hidden" name="postIt" value="true" >


	<% if not jobedit then %>
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
	
	<% elseif jobedit then %>

	<input type="hidden" name="compoundid" value="<%=CompoundId%>">
	<input type="hidden" name="jobedit" value="1">
    <p>
      <label for="jobDescription">Description</label>
      <input name="jobDescription" type="text" maxlength="255" value="<%=WebTitle%>" >
    </p>
     <p>
      <label for="jobLocation">Location</label>
      <input id="jobLocation" name="jobLocation" type="text" maxlength="255" value="<%=jobLocation%>" >
    </p>
     <p>
      <label for="jobPay">Start Pay [D.O.E. shows if 'blank']</label>
      <input id="jobPay" name="jobPay" type="text" maxlength="255" value="<%=jobPay%>" >
    </p>
    <p>
      <label for="blogSubject">Subject</label>
      <input name="blogSubject" type="text" maxlength="50" value="<%=blogSubject%>" >
    </p>
    <p>
      <label for="blogBody">Description</label>
      <textarea name="blogBody" cols="" rows=""><%=WebDescription%></textarea>
    </p>

	<% end if
	
	dim inpChecks(1)
	if request.querystring("formatting")="html" then
		inpChecks(1) = "checked"
	else
		inpChecks(0) = "checked"
	end if

	%>

    <p id="blogFormat">
		<label for="blogBody">Display Formatting </label>
		<label for="display_text"><input id="display_text"  type="radio" name="formatting" value="text" <%=inpChecks(0)%>>text</label>
		<label for="display_html"><input id="display_html" type="radio" name="formatting" value="html"  <%=inpChecks(1)%>>html</label><br>
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
