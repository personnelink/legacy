<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->


<%
dim rsUpdRes, sqlUpdRes, sqlPart1, sqlPart2, sqlValues
sqlPart1 = "UPDATE tbl_resumes SET "
sqlPart2 = "WHERE res_id=" & Request("num") & " AND mbr_id = " & session("mbrID") & ""
sqlValues = ""
sqlValues = sqlValues & "res_title='" & ConvertString(TRIM(Request("res_title"))) & "', "
sqlValues = sqlValues & "res_objective='" & ConvertString(TRIM(Request("res_objective"))) & "', "
sqlValues = sqlValues & "res_date_available='" & ConvertString(TRIM(Request("res_date_available"))) & "', "
sqlValues = sqlValues & "res_availability='" & Request("res_availability") & "', "
sqlValues = sqlValues & "res_will_relocate=" & Request("res_will_relocate") & ", "
sqlValues = sqlValues & "res_is_eligible=" & Request("res_is_eligible") & ", "
sqlValues = sqlValues & "res_skills='" & ConvertString(TRIM(Request("res_skills"))) & "', "
sqlValues = sqlValues & "res_pref_salary='" & ConvertString(TRIM(Request("res_pref_salary"))) & "', "
sqlValues = sqlValues & "res_pref_location='" & Request("res_pref_location") & "' "	
sqlUpdRes = sqlPart1 & sqlValues & sqlPart2
Set rsUpdRes = Connect.Execute(sqlUpdRes)


Set rsUpdRes = Nothing
Connect.Close
Set Connect = Nothing

response.redirect("thirdPage.asp?num=" & request("num"))
%>