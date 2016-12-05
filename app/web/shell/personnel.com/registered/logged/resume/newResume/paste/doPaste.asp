<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->

<%
dim mbr_first_name		:	mbr_first_name = Request("mbr_first_name")
dim mbr_last_name		:	mbr_last_name = Request("mbr_last_name")
dim mbr_address_one		:	mbr_address_one = Request("mbr_address_one")
dim mbr_address_two		:	mbr_address_two = Request("mbr_address_two")
dim mbr_city			:	mbr_city = Request("mbr_city")
dim mbr_location		:	mbr_location = Request("mbr_location")
dim mbr_zipcode			:	mbr_zipcode = Request("mbr_zipcode")
dim mbr_phone_number	:	mbr_phone_number = Request("mbr_phone_number")
dim mbr_email_address	:	mbr_email_address = Request("mbr_email_address")

dim res_title			:	res_title = ConvertString(TRIM(Request("res_title")))
dim res_date_available 	:	res_date_available  = Request("res_date_available")
dim res_is_eligible  	:	res_is_eligible  = Request("res_is_eligible")
dim res_availability  	:	res_availability  = Request("res_availability")
dim res_will_relocate  	:	res_will_relocate  = Request("res_will_relocate")
dim res_pref_location	:	res_pref_location = Request("res_pref_location")
dim res_pref_salary		:	res_pref_salary = ConvertString(Request("res_pref_salary"))


dim res_filename		:	res_filename = "paste"
dim res_is_active		:	res_is_active = 1
dim res_is_deleted		:	res_is_deleted = 0
dim res_description		:	res_description = ConvertString(TRIM(Request("res_description")))
dim res_body			:	res_body = ConvertString(TRIM(Request("res_body")))

dim sqlInsRes, rsInsRes, qID, rsID

' Insert tbl_resumes
sqlInsRes = "INSERT INTO tbl_resumes (mbr_id, res_is_deleted, res_first_name, res_last_name, res_address_one, res_address_two, res_city, res_location, res_zipcode, res_phone_number, res_email_address, res_title, res_date_available, res_is_eligible, res_availability, res_will_relocate, res_pref_location, res_pref_salary, res_description, res_body, res_is_active, res_filename, res_completion_flag, res_view_count, res_date_created) VALUES (" & _
"'" & session("mbrID") & "'," & _
"" & res_is_deleted & "," & _
"'" & mbr_first_name & "'," & _
"'" & mbr_last_name & "'," & _
"'" & mbr_address_one & "'," & _
"'" & mbr_address_two & "'," & _
"'" & mbr_city & "'," & _
"'" & mbr_location & "'," & _
"'" & mbr_zipcode & "'," & _
"'" & mbr_phone_number & "'," & _
"'" & mbr_email_address & "'," & _
"'" & res_title & "'," & _
"'" & res_date_available & "'," & _
"" & res_is_eligible & "," & _
"'" & res_availability & "'," & _
"" & res_will_relocate & "," & _
"'" & res_pref_location & "'," & _
"'" & res_pref_salary & "'," & _
"'" & res_description & "'," & _
"'" & res_body & "'," & _
"" & res_is_active & "," & _
"'" & res_filename & "'," & _
"5," & _
"0," & _
" NOW()" & ")"

qID = "SELECT LAST_INSERT_ID() AS new_res_id;"

Set rsInsRes = Connect.Execute(sqlInsRes)
Set rsID = Connect.Execute(qID)
newResID = rsID("new_res_id")

Set rsInsRes = Nothing
Set rsID = Nothing


Connect.Close
Set Connect = Nothing

response.redirect("/registered/logged/resume/index.asp")
%>