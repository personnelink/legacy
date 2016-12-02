<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%

Response.Expires = -1000 'Makes the browser not cache this page
Response.Buffer = true 'Buffers the content so our Response.Redirect will work

session_abandon(session_id)

Session.Abandon()
Session.Contents.RemoveAll()

Response.Redirect("/userHome.asp")
%>

