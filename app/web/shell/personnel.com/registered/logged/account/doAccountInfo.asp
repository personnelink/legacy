<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		doAccountInfo.asp
'		Description:	updates tbl_members with newly entered member information
'		Created:		Wednesday, January 21, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************

dim mbr_first_name		:	mbr_first_name = TRIM(ConvertString(request("mbr_first_name")))
dim mbr_last_name		:	mbr_last_name = TRIM(ConvertString(request("mbr_last_name")))
dim mbr_address_one		:	mbr_address_one = TRIM(ConvertString(request("mbr_address_one")))
dim mbr_address_two		:	mbr_address_two = TRIM(ConvertString(request("mbr_address_two")))
dim mbr_city			:	mbr_city = TRIM(ConvertString(request("mbr_city")))
dim mbr_location		:	mbr_location = TRIM(ConvertString(request("mbr_location")))
dim mbr_zipcode			:	mbr_zipcode = TRIM(ConvertString(request("mbr_zipcode")))
dim mbr_phone_number	:	mbr_phone_number = TRIM(ConvertString(request("mbr_phone_number")))

dim rsUpdMbr, sqlUpdMbr, sqlPart1, sqlPart2, sqlValues
sqlPart1 = "UPDATE tbl_members SET "
sqlPart2 = "WHERE mbr_id=" & session("mbrID")
sqlValues = ""
sqlValues = sqlValues & "mbr_first_name='" & mbr_first_name & "', "
sqlValues = sqlValues & "mbr_last_name='" & mbr_last_name & "', "
sqlValues = sqlValues & "mbr_address_one='" & mbr_address_one & "', "
sqlValues = sqlValues & "mbr_address_two='" & mbr_address_two & "', "
sqlValues = sqlValues & "mbr_city='" & mbr_city & "', "
sqlValues = sqlValues & "mbr_location='" & mbr_location & "', "
sqlValues = sqlValues & "mbr_zipcode='" & mbr_zipcode & "', "
sqlValues = sqlValues & "mbr_phone_number='" & mbr_phone_number & "' "	

sqlUpdMbr = sqlPart1 & sqlValues & sqlPart2
Set rsUpdMbr = Connect.Execute(sqlUpdMbr)

' refresh session vars with new info
user_firstname = mbr_first_name
user_lastname = mbr_last_name


Set rsUpdMbr = Nothing
Connect.Close
Set Connect = Nothing

response.redirect("../index.asp")
%>