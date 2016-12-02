<%Option Explicit%>
<%
session("add_css") = "./emailResume.css"
session("required_user_level") = 1 'Guest
session("user_level") = 0

dim func
response.buffer=true
func = Request("Func")
if func = 2 or func = 3 then session("no_header") = true
%>

<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->

<script type="text/javascript" src="/include/js/global.js"></script>

<!-- #INCLUDE FILE='form.asp' -->

<%=decorateBottom()%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
