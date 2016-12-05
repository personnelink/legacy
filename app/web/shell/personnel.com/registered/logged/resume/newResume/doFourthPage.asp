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
sqlPart2 = "WHERE res_id =" & session("tmp_res_id")
sqlValues = ""
sqlValues = sqlValues & "res_college_name1 ='" & TRIM(ConvertString(request("res_college_name1"))) & "', "
sqlValues = sqlValues & "res_college_city1 ='" & TRIM(ConvertString(request("res_college_city1"))) & "', "
sqlValues = sqlValues & "res_college_location1 ='" & TRIM(ConvertString(request("res_college_location1"))) & "', "
sqlValues = sqlValues & "res_college_degree1 ='" & TRIM(ConvertString(request("res_college_degree1"))) & "', "
sqlValues = sqlValues & "res_college_name2 ='" & TRIM(ConvertString(request("res_college_name2"))) & "', "
sqlValues = sqlValues & "res_college_city2 ='" & TRIM(ConvertString(request("res_college_city2"))) & "', "
sqlValues = sqlValues & "res_college_location2 ='" & TRIM(ConvertString(request("res_college_location2"))) & "', "
sqlValues = sqlValues & "res_college_degree2 ='" & TRIM(ConvertString(request("res_college_degree2"))) & "', "
sqlValues = sqlValues & "res_hs_name ='" & TRIM(ConvertString(request("res_hs_name"))) & "', "
sqlValues = sqlValues & "res_hs_city ='" & TRIM(ConvertString(request("res_hs_city"))) & "', "
sqlValues = sqlValues & "res_hs_location ='" & TRIM(ConvertString(request("res_hs_location"))) & "', "
sqlValues = sqlValues & "res_hs_diploma = " & request("res_hs_diploma") & ", "
sqlValues = sqlValues & "res_completion_flag = 4 "

sqlUpdRes = sqlPart1 & sqlValues & sqlPart2
Set rsUpdRes = Connect.Execute(sqlUpdRes)

session("tmp_res_flag") = "4"

Set rsUpdRes = Nothing
Connect.Close
Set Connect = Nothing

response.redirect("fifthPage.asp")
%>

