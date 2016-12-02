<%
if request.cookies("members") ("mbrAuth") = "true" and session("mbrAuth") <> "true" then
  dim rs
  rs.CursorLocation = 3
  Set rs = Server.CreateObject("ADODB.RecordSet")
  emailAddress = request.cookies("members") ("emailAddress")
  rs.Open "SELECT mbr_id, mbr_first_name, mbr_last_name, mbr_email_address FROM tbl_members WHERE mbr_email_address = '" & emailAddress & "'",Connect

session("mbrAuth") = "true"
session("mbrID") = rs("mbr_id")
user_firstname = rs("mbr_first_name")
user_lastname = rs("mbr_last_name")
session("emailAddress") = emailAddress

rs.Close
rs = Nothing
end if
%>