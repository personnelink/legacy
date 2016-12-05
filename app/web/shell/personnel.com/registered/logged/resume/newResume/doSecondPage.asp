<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
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
sqlValues = sqlValues & "res_title ='" & ConvertString(TRIM(Request("res_title"))) & "', "
sqlValues = sqlValues & "res_date_available ='" & Request("res_date_available") & "', "
sqlValues = sqlValues & "res_is_eligible =" & Request("res_is_eligible") & ", "
sqlValues = sqlValues & "res_availability ='" & Request("res_availability") & "', "
sqlValues = sqlValues & "res_will_relocate =" & Request("res_will_relocate") & ", "
sqlValues = sqlValues & "res_pref_location ='" & Request("res_pref_location") & "', "
sqlValues = sqlValues & "res_pref_salary ='" & ConvertString(TRIM(Request("res_pref_salary"))) & "', "
sqlValues = sqlValues & "res_objective ='" & ConvertString(TRIM(Request("res_objective"))) & "', "
sqlValues = sqlValues & "res_skills ='" & ConvertString(TRIM(Request("res_skills"))) & "', "
sqlValues = sqlValues & "res_completion_flag = 2 "
sqlUpdRes = sqlPart1 & sqlValues & sqlPart2
Set rsUpdRes = Connect.Execute(sqlUpdRes)


session("tmp_res_flag") = "2"

Set rsUpdRes = Nothing
Connect.Close
Set Connect = Nothing
response.redirect("thirdPage.asp")
%>