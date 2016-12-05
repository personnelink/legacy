<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkMbrAuth.asp' -->

<%


dim res_title			:	res_title = ConvertString(TRIM(Request("res_title")))
dim res_date_available 	:	res_date_available  = Request("res_date_available")
dim res_is_eligible  	:	res_is_eligible  = Request("res_is_eligible")
dim res_availability  	:	res_availability  = Request("res_availability")
dim res_will_relocate  	:	res_will_relocate  = Request("res_will_relocate")
dim res_pref_location	:	res_pref_location = Request("res_pref_location")
dim res_pref_salary		:	res_pref_salary = ConvertString(Request("res_pref_salary"))
dim res_description		:	res_description = ConvertString(TRIM(Request("res_description")))
dim res_body			:	res_body = ConvertString(TRIM(Request("res_body")))



dim rsUpdRes, sqlUpdRes, sqlPart1, sqlPart2, sqlValues
sqlPart1 = "UPDATE tbl_resumes SET "
sqlPart2 = "WHERE res_id= " & Request("id") & " AND mbr_id = " & session("mbrID") & ""
sqlValues = ""

sqlValues = sqlValues & "res_title='" & res_title & "', "
sqlValues = sqlValues & "res_date_available='" & res_date_available & "', "
sqlValues = sqlValues & "res_is_eligible=" & res_is_eligible & ", "
sqlValues = sqlValues & "res_availability='" & res_availability & "', "
sqlValues = sqlValues & "res_will_relocate=" & res_will_relocate & ", "
sqlValues = sqlValues & "res_pref_location='" & res_pref_location & "', "
sqlValues = sqlValues & "res_pref_salary='" & res_pref_salary & "', "
sqlValues = sqlValues & "res_date_created= NOW(), "
sqlValues = sqlValues & "res_description='" & res_description & "', "
sqlValues = sqlValues & "res_body='" & res_body & "' "	


sqlUpdRes = sqlPart1 & sqlValues & sqlPart2
Set rsUpdRes = Connect.Execute(sqlUpdRes)
Set rsUpdRes = Nothing



Connect.Close
Set Connect = Nothing
  
response.redirect("../viewResume2.asp?id=" & request("id"))
%>