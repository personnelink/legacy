<% if session("employerAuth") = "true" then response.redirect("/lweb/employers/registered/index.asp?who=1") end if%>
<% if session("auth") = "true" then response.redirect("/index.asp?who=2") end if%>
<% if session("adminAuth") = "true" then response.redirect("/index.asp") end if%>
