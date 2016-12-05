<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->


<%
dim rsUpdRes, sqlUpdRes, sqlPart1, sqlPart2, sqlValues
sqlPart1 = "UPDATE tbl_resumes SET "
sqlPart2 = "WHERE res_id=" & Request("num") & " AND mbr_id=" & session("mbrID") & ""
sqlValues = ""
sqlValues = sqlValues & "res_college_name1='" & ConvertString(TRIM(Request("res_college_name1"))) & "', "
sqlValues = sqlValues & "res_college_city1='" & ConvertString(TRIM(Request("res_college_city1"))) & "', "
sqlValues = sqlValues & "res_college_location1='" & Request("res_college_location1") & "', "
sqlValues = sqlValues & "res_college_degree1='" & ConvertString(TRIM(Request("res_college_degree1"))) & "', "
sqlValues = sqlValues & "res_college_name2='" & ConvertString(TRIM(Request("res_college_name2"))) & "', "
sqlValues = sqlValues & "res_college_city2='" & ConvertString(TRIM(Request("res_college_city2"))) & "', "
sqlValues = sqlValues & "res_college_location2='" & Request("res_college_location2") & "', "
sqlValues = sqlValues & "res_college_degree2='" & ConvertString(TRIM(Request("res_college_degree2"))) & "', "
sqlValues = sqlValues & "res_hs_name='" & ConvertString(TRIM(Request("res_hs_name"))) & "', "
sqlValues = sqlValues & "res_hs_city='" & ConvertString(TRIM(Request("res_hs_city"))) & "', "
sqlValues = sqlValues & "res_hs_location='" & Request("res_hs_location") & "', "
sqlValues = sqlValues & "res_hs_diploma=" & Request("res_hs_diploma") & " "
sqlUpdRes = sqlPart1 & sqlValues & sqlPart2
Set rsUpdRes = Connect.Execute(sqlUpdRes)



Set rsUpdRes = Nothing
Connect.Close
Set Connect = Nothing

response.redirect("fifthPage.asp?num=" & request("num"))
%>

