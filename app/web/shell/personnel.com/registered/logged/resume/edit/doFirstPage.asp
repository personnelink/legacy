<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->


<%
dim rsUpdRes, sqlUpdRes, sqlPart1, sqlPart2, sqlValues
sqlPart1 = "UPDATE tbl_resumes SET "
sqlPart2 = "WHERE res_id=" & Request("num") & " AND mbr_id = " & session("mbrID") & ""
sqlValues = ""
sqlValues = sqlValues & "res_first_name='" & Request(ConvertString(TRIM("res_first_name"))) & "', "
sqlValues = sqlValues & "res_last_name='" & Request(ConvertString(TRIM("res_last_name"))) & "', "
sqlValues = sqlValues & "res_address_one='" & Request(ConvertString(TRIM("res_address_one"))) & "', "
sqlValues = sqlValues & "res_city='" & Request(ConvertString(TRIM("res_city"))) & "', "
sqlValues = sqlValues & "res_location='" & Request("res_location") & "', "
sqlValues = sqlValues & "res_zipcode='" & Request(ConvertString(TRIM("res_zipcode"))) & "', "
sqlValues = sqlValues & "res_phone_number='" & Request(ConvertString(TRIM("res_phone_number"))) & "', "
sqlValues = sqlValues & "res_email_address='" & Request(ConvertString(TRIM("res_email_address"))) & "' "	

sqlUpdRes = sqlPart1 & sqlValues & sqlPart2
Set rsUpdRes = Connect.Execute(sqlUpdRes)



Set rsUpdRes = Nothing
Connect.Close
Set Connect = Nothing


response.redirect("secondPage.asp?num=" & Request("num"))
%>