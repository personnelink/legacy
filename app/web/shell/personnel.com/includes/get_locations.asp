<%
dim rsLoc, sqlLoc
sqlLoc = "SELECT loc_id, loc_code, loc_name FROM tbl_locations"
set rsLoc = Connect.Execute(sqlLoc)
%>
