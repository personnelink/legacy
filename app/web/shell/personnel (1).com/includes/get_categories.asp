<%
dim rsCat, sqlCat
sqlCat = "SELECT cat_id, cat_name FROM tbl_categories"
set rsCat = Connect.Execute(sqlCat)
%>
