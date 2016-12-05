<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->

<%
dim rsUpdRes, sqlUpdRes, sqlPart1, sqlPart2, sqlValues
sqlPart1 = "UPDATE tbl_resumes SET "
sqlPart2 = "WHERE res_id=" & Request("num") & " AND mbr_id = " & session("mbrID") & ""
sqlValues = ""
sqlValues = sqlValues & "res_comp_name1='" & ConvertString(TRIM(Request("res_comp_name1"))) & "', "
sqlValues = sqlValues & "res_comp_city1='" & ConvertString(TRIM(Request("res_comp_city1"))) & "', "
sqlValues = sqlValues & "res_comp_location1='" & ConvertString(TRIM(Request("res_comp_location1"))) & "', "
sqlValues = sqlValues & "res_comp_job_title1='" & ConvertString(TRIM(Request("res_comp_job_title1"))) & "', "
sqlValues = sqlValues & "res_comp_start_date1='" & Request("res_comp_start_date1") & "', "
sqlValues = sqlValues & "res_comp_end_date1='" & Request("res_comp_end_date1") & "', "
sqlValues = sqlValues & "res_comp_job_duties1='" & ConvertString(TRIM(Request("res_comp_job_duties1"))) & "', "

sqlValues = sqlValues & "res_comp_name2='" & ConvertString(TRIM(Request("res_comp_name2"))) & "', "
sqlValues = sqlValues & "res_comp_city2='" & ConvertString(TRIM(Request("res_comp_city2"))) & "', "
sqlValues = sqlValues & "res_comp_location2='" & ConvertString(TRIM(Request("res_comp_location2"))) & "', "
sqlValues = sqlValues & "res_comp_job_title2='" & ConvertString(TRIM(Request("res_comp_job_title2"))) & "', "
sqlValues = sqlValues & "res_comp_start_date2='" & Request("res_comp_start_date2") & "', "
sqlValues = sqlValues & "res_comp_end_date2='" & Request("res_comp_end_date2") & "', "
sqlValues = sqlValues & "res_comp_job_duties2='" & ConvertString(TRIM(Request("res_comp_job_duties2"))) & "', "

sqlValues = sqlValues & "res_comp_name3='" & ConvertString(TRIM(Request("res_comp_name3"))) & "', "
sqlValues = sqlValues & "res_comp_city3='" & ConvertString(TRIM(Request("res_comp_city3"))) & "', "
sqlValues = sqlValues & "res_comp_location3='" & ConvertString(TRIM(Request("res_comp_location3"))) & "', "
sqlValues = sqlValues & "res_comp_job_title3='" & ConvertString(TRIM(Request("res_comp_job_title3"))) & "', "
sqlValues = sqlValues & "res_comp_start_date3='" & Request("res_comp_start_date3") & "', "
sqlValues = sqlValues & "res_comp_end_date3='" & Request("res_comp_end_date3") & "', "
sqlValues = sqlValues & "res_comp_job_duties3='" & ConvertString(TRIM(Request("res_comp_job_duties3"))) & "' "	
sqlUpdRes = sqlPart1 & sqlValues & sqlPart2
Set rsUpdRes = Connect.Execute(sqlUpdRes)


Set rsUpdRes = Nothing
Connect.Close
Set Connect = Nothing

response.redirect("fourthPage.asp?num=" & request("num"))
%>