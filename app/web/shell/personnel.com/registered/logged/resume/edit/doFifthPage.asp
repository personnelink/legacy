<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->


<%
dim rsUpdRes, sqlUpdRes, sqlPart1, sqlPart2, sqlValues
sqlPart1 = "UPDATE tbl_resumes SET "
sqlPart2 = "WHERE res_id=" & Request("num") & " AND mbr_id = " & session("mbrID") & ""
sqlValues = ""
sqlValues = sqlValues & "res_refer_name1='" & ConvertString(TRIM(Request("res_refer_name1"))) & "', "
sqlValues = sqlValues & "res_refer_title1='" & ConvertString(TRIM(Request("res_refer_title1"))) & "', "
sqlValues = sqlValues & "res_refer_company1='" & ConvertString(TRIM(Request("res_refer_company1"))) & "', "
sqlValues = sqlValues & "res_refer_phone1='" & ConvertString(TRIM(Request("res_refer_phone1"))) & "', "
sqlValues = sqlValues & "res_refer_name2='" & ConvertString(TRIM(Request("res_refer_name2"))) & "', "
sqlValues = sqlValues & "res_refer_title2='" & ConvertString(TRIM(Request("res_refer_title2"))) & "', "
sqlValues = sqlValues & "res_refer_company2='" & ConvertString(TRIM(Request("res_refer_company2"))) & "', "
sqlValues = sqlValues & "res_refer_phone2='" & ConvertString(TRIM(Request("res_refer_phone2"))) & "', "
sqlValues = sqlValues & "res_refer_name3='" & ConvertString(TRIM(Request("res_refer_name3"))) & "', "
sqlValues = sqlValues & "res_refer_title3='" & ConvertString(TRIM(Request("res_refer_title3"))) & "', "
sqlValues = sqlValues & "res_refer_company3='" & ConvertString(TRIM(Request("res_refer_company3"))) & "', "
sqlValues = sqlValues & "res_refer_phone3='" & ConvertString(TRIM(Request("res_refer_phone3"))) & "' "	

sqlUpdRes = sqlPart1 & sqlValues & sqlPart2
Set rsUpdRes = Connect.Execute(sqlUpdRes)



Set rsUpdRes = Nothing
Connect.Close
Set Connect = Nothing




response.redirect("../viewResume.asp?id=" & request("num") &"&confirm=2")
%>