<!-- #INCLUDE VIRTUAL = 'includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->
<%

if session("tmp_res_id") <> "" then ' Duplicate entry, perform UPDATE instead of INSERT

dim rsUpdRes, sqlUpdRes, sqlPart1, sqlPart2, sqlValues
sqlPart1 = "UPDATE tbl_resumes SET "
sqlPart2 = "WHERE res_id=" & session("tmp_res_id")
sqlValues = ""
sqlValues = sqlValues & "res_first_name ='" & TRIM(ConvertString(Request("res_first_name"))) & "', "
sqlValues = sqlValues & "res_last_name ='" & Request("res_last_name") & "', "
sqlValues = sqlValues & "res_address_one ='" & Request("res_address_one") & "', "
sqlValues = sqlValues & "res_address_two ='" & Request("res_address_two") & "', "
sqlValues = sqlValues & "res_city ='" & Request("res_city") & "', "
sqlValues = sqlValues & "res_location ='" & TRIM(ConvertString(Request("res_location"))) & "', "
sqlValues = sqlValues & "res_zipcode ='" & TRIM(ConvertString(Request("res_zipcode"))) & "', "
sqlValues = sqlValues & "res_phone_number ='" & TRIM(ConvertString(Request("res_phone_number"))) & "', "
sqlValues = sqlValues & "res_email_address ='" & Request(ConvertString(TRIM("res_email_address"))) & "' "	
sqlUpdRes = sqlPart1 & sqlValues & sqlPart2
Set rsUpdRes = Connect.Execute(sqlUpdRes)

Response.redirect("secondPage.asp?loc=" & request("res_location"))

Else ' NOT a Duplicate entry, proceed with INSERT

dim sqlInsRes, rsInsRes, rsID, qID, newResID, is_active

if Request("res_is_active") = "" then
is_active = 1
Else
is_active = 0
end if

sqlInsRes = "INSERT INTO tbl_resumes (mbr_id, res_first_name, res_last_name, res_address_one, res_address_two, res_city, res_location, res_zipcode, res_phone_number, res_email_address, res_is_active, res_completion_flag, res_date_created) VALUES (" & _
"'" & session("mbrID") & "'," & _
"'" & Request(ConvertString(TRIM("res_first_name"))) & "'," & _
"'" & Request(ConvertString(TRIM("res_last_name"))) & "'," & _
"'" & Request(ConvertString(TRIM("res_address_one"))) & "'," & _
"'" & Request(ConvertString(TRIM("res_address_two"))) & "'," & _
"'" & Request(ConvertString(TRIM("res_city"))) & "'," & _
"'" & Request("res_location") & "'," & _
"'" & Request(ConvertString(TRIM("res_zipcode"))) & "'," & _
"'" & Request(ConvertString(TRIM("res_phone_number"))) & "'," & _
"'" & Request(ConvertString(TRIM("res_email_address"))) & "'," & _
"" & is_active & "," & _
"1," & _
" NOW()" & ")"

qID = "SELECT LAST_INSERT_ID() AS new_res_id;"

Set rsInsRes = Connect.Execute(sqlInsRes)
Set rsID = Connect.Execute(qID)
newResID = rsID("new_res_id")

Set rsInsRes = Nothing
rsID.Close
Set rsID = Nothing
Connect.Close
Set Connect = Nothing

session("tmp_res_id") = newResID ' new res_id
session("tmp_res_flag") = "1" 'not used yet

Response.redirect("secondPage.asp?loc=" & request("res_location"))

end if
%>