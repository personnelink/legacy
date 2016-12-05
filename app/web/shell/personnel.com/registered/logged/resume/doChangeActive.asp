<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->

<%
dim rsR, activeStatus
Set rsR = Server.CreateObject("ADODB.RecordSet")
rsR.CursorLocation = 3
rsR.Open "SELECT res_id, mbr_id, res_is_active FROM tbl_resumes WHERE res_id = " & request("id") & " AND mbr_id = " & session("mbrID"),Connect

if CInt(rsR("res_is_active")) = 1 then
activeStatus = 0
Else
activeStatus = 1
end if
rsR.Close
Set rsR = Nothing

dim rsUpdStatus, sqlUpdStatus, sqlPart1, sqlPart2, sqlValues
sqlPart1 = "UPDATE tbl_resumes SET "
sqlPart2 = "WHERE res_id=" & Request("id") & " AND mbr_id = " & session("mbrID") & ""
sqlValues = ""
sqlValues = sqlValues & "res_is_active=" & activeStatus & " "	
sqlUpdStatus = sqlPart1 & sqlValues & sqlPart2
Set rsUpdStatus = Connect.Execute(sqlUpdStatus)
Set rsUpdStatus = Nothing

Connect.Close
Set Connect = Nothing

if request("pgto") = "view" then
  response.redirect("viewResume.asp?id=" & request("id"))
 elseif request("pgto") = "view2" then
  response.redirect("viewResume2.asp?id=" & request("id"))
 Else
  response.redirect("index.asp")
end if
%>