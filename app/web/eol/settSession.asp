<!-- Revised: 2009.11.24 -->
<!-- Revised: 2009.05.19 -->
<!-- Revised: 2008.07.23 -->
<%
dim SessionInfo
set SessionInfo = Server.CreateObject ("ADODB.Connection")
if session_signed_in = true then
	On Error Resume Next
	SessionInfo.Open MySql
	Set dbQuery = SessionInfo.Execute("SELECT tbl_users.applicationId, tbl_users.addressID, tbl_users.companyID, tbl_users.EmpCode, " &_
		"tbl_users.userID, tbl_users.userName, tbl_users.userLevel, tbl_users.userEmail, tbl_users.userPhone, tbl_addresses.zip, " &_
		"tbl_users.userSPhone, tbl_users.firstName, tbl_users.lastName, tbl_users.creationDate, tbl_companies.addressID, " &_
		"tbl_companies.companyName, tbl_companies.companyPhone, tbl_companies.companySPhone, tbl_companies.creationDate, " &_
		"tbl_companies.Customer " &_
		"FROM (tbl_users LEFT JOIN tbl_companies ON tbl_users.companyID = tbl_companies.companyID) " &_
		"LEFT JOIN tbl_addresses ON tbl_users.addressID = tbl_addresses.addressID " &_
		"WHERE tbl_users.userID=" & user_id & ";")

	applicationId = CInt("0" & dbQuery("applicationId"))
	addressId = dbQuery(1)
	companyId = dbQuery("companyID")
	user_id = dbQuery("userID")
	user_name = dbQuery("userName")
	user_level = dbQuery("userLevel")
	user_email = dbQuery("userEmail")
	user_phone = dbQuery("userPhone")
	user_sphone = dbQuery("userSPhone")
	user_firstname = dbQuery("firstName")
	user_lastname = dbQuery("lastName")
	user_created = dbQuery("CreationDate")
	user_empcode = dbQuery("EmpCode")
	user_zip = dbQuery("zip")
	company_addressId = dbQuery(14)
	company_name = dbQuery("companyName")
	company_phone = dbQuery("companyPhone")
	company_sphone = dbQuery("companySPhone")
	company_created = dbQuery("CreationDate")
	company_custcode = dbQuery("Customer")

	SessionInfo.Execute "INSERT INTO tbl_tracking (userID, datetime, username) VALUES ('" &_
		user_id & "', Now(), '" & user_name & "'); " &_
		"UPDATE tbl_users  SET lastloginDate=Now() WHERE userid='" & user_id & "'"
	SessionInfo.Close()
	Set dbQuery = Nothing
	Set SessionInfo = Nothing
	On Error Goto 0
End if %>
