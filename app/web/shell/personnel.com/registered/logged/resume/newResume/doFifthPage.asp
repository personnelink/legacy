<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->

<%
' Check if we are finishing an incomplete resume...if so update the tmp_res_id session var
' if not then continue using existing tmp_res_id session var
if request.form("inc_res_id") <> "" then
session("tmp_res_id") = request.form("inc_res_id")
end if

dim rsUpdRes, sqlUpdRes, sqlPart1, sqlPart2, sqlValues
sqlPart1 = "UPDATE tbl_resumes SET "
sqlPart2 = "WHERE res_id=" & session("tmp_res_id")
sqlValues = ""
sqlValues = sqlValues & "res_refer_name1 ='" & TRIM(ConvertString(request("res_refer_name1"))) & "', "
sqlValues = sqlValues & "res_refer_title1 ='" & TRIM(ConvertString(request("res_refer_title1"))) & "', "
sqlValues = sqlValues & "res_refer_company1 ='" & TRIM(ConvertString(request("res_refer_company1"))) & "', "
sqlValues = sqlValues & "res_refer_phone1 ='" & TRIM(ConvertString(request("res_refer_phone1"))) & "', "
sqlValues = sqlValues & "res_refer_name2 ='" & TRIM(ConvertString(request("res_refer_name2"))) & "', "
sqlValues = sqlValues & "res_refer_title2 ='" & TRIM(ConvertString(request("res_refer_title2"))) & "', "
sqlValues = sqlValues & "res_refer_company2 ='" & TRIM(ConvertString(request("res_refer_company2"))) & "', "
sqlValues = sqlValues & "res_refer_phone2 ='" & TRIM(ConvertString(request("res_refer_phone2"))) & "', "
sqlValues = sqlValues & "res_refer_name3 ='" & TRIM(ConvertString(request("res_refer_name3"))) & "', "
sqlValues = sqlValues & "res_refer_title3 ='" & TRIM(ConvertString(request("res_refer_title3"))) & "', "
sqlValues = sqlValues & "res_refer_company3 ='" & TRIM(ConvertString(request("res_refer_company3"))) & "', "
sqlValues = sqlValues & "res_refer_phone3 ='" & TRIM(ConvertString(request("res_refer_phone3"))) & "', "
sqlValues = sqlValues & "res_view_count = 0, "
sqlValues = sqlValues & "res_completion_flag = 5 "

sqlUpdRes = sqlPart1 & sqlValues & sqlPart2
Set rsUpdRes = Connect.Execute(sqlUpdRes)

session("tmp_res_flag") = "5"

' Clear temporary resume ID as we have a complete entry to DB now
newResID = session("tmp_res_id")
session("tmp_res_id") = ""

Set rsUpdRes = Nothing
Connect.Close
Set Connect = Nothing

response.redirect("../viewResume.asp?id=" & newResID &"&confirm=1")
%>