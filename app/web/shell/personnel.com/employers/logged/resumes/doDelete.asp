<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpAuth.asp' -->
<%
dim rsDelApp, sqlDelApp
sqlDelApp = "UPDATE tbl_applications SET app_is_deleted = 1 WHERE app_id = " & request("id")
Set rsDelApp = Connect.Execute(sqlDelApp)
Set rsDelApp = Nothing
Connect.Close
Set Connect = Nothing

response.redirect("index.asp")
%>