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
sqlValues = sqlValues & "res_comp_name1 ='" & TRIM(ConvertString(request("res_comp_name1"))) & "', "
sqlValues = sqlValues & "res_comp_city1 ='" & TRIM(ConvertString(request("res_comp_city1"))) & "', "
sqlValues = sqlValues & "res_comp_location1 ='" & TRIM(ConvertString(request("res_comp_location1"))) & "', "
sqlValues = sqlValues & "res_comp_job_title1 ='" & TRIM(ConvertString(request("res_comp_job_title1"))) & "', "
sqlValues = sqlValues & "res_comp_start_date1 ='" & TRIM(ConvertString(request("res_comp_start_date1"))) & "', "
sqlValues = sqlValues & "res_comp_end_date1 ='" & TRIM(ConvertString(request("res_comp_end_date1"))) & "', "
sqlValues = sqlValues & "res_comp_job_duties1 ='" & TRIM(ConvertString(request("res_comp_job_duties1"))) & "', "
sqlValues = sqlValues & "res_comp_name2 ='" & TRIM(ConvertString(request("res_comp_name2"))) & "', "
sqlValues = sqlValues & "res_comp_city2 ='" & TRIM(ConvertString(request("res_comp_city2"))) & "', "
sqlValues = sqlValues & "res_comp_location2 ='" & TRIM(ConvertString(request("res_comp_location2"))) & "', "
sqlValues = sqlValues & "res_comp_job_title2 ='" & TRIM(ConvertString(request("res_comp_job_title2"))) & "', "
sqlValues = sqlValues & "res_comp_start_date2 ='" & TRIM(ConvertString(request("res_comp_start_date2"))) & "', "
sqlValues = sqlValues & "res_comp_end_date2 ='" & TRIM(ConvertString(request("res_comp_end_date2"))) & "', "
sqlValues = sqlValues & "res_comp_job_duties2 ='" & TRIM(ConvertString(request("res_comp_job_duties2"))) & "', "
sqlValues = sqlValues & "res_comp_name3 ='" & TRIM(ConvertString(request("res_comp_name3"))) & "', "
sqlValues = sqlValues & "res_comp_city3 ='" & TRIM(ConvertString(request("res_comp_city3"))) & "', "
sqlValues = sqlValues & "res_comp_location3 ='" & TRIM(ConvertString(request("res_comp_location3"))) & "', "
sqlValues = sqlValues & "res_comp_job_title3 ='" & TRIM(ConvertString(request("res_comp_job_title3"))) & "', "
sqlValues = sqlValues & "res_comp_start_date3 ='" & TRIM(ConvertString(request("res_comp_start_date3"))) & "', "
sqlValues = sqlValues & "res_comp_end_date3 ='" & TRIM(ConvertString(request("res_comp_end_date3"))) & "', "
sqlValues = sqlValues & "res_comp_job_duties3 ='" & TRIM(ConvertString(Request("res_comp_job_duties3"))) & "', "
sqlValues = sqlValues & "res_completion_flag = 3 "	
sqlUpdRes = sqlPart1 & sqlValues & sqlPart2
Set rsUpdRes = Connect.Execute(sqlUpdRes)


session("tmp_res_flag") = "3"

Set rsUpdRes = Nothing
Connect.Close
Set Connect = Nothing

response.redirect("fourthPage.asp")
%>