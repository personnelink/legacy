<%

'---- Initialize Session
dim show_login
dim session_id
dim session_ip
dim session_signed_in

session_id = request.Cookies("session_id")
session_ip = request.ServerVariables("REMOTE_ADDR")
if session_ip = "::1" then session_ip = "127.0.0.1" ' fix-up localhost for IPV_4 web_sessions compatibility testing

session_signed_in = false

if global_debug then
	output_debug("* Initialize Session --- *")
	output_debug("* -- -- session_id: " & session_id & " *")
	output_debug("* -- -- session_ip: " & session_ip & " *")
	select case session_signed_in
		case true
			output_debug("* -- -- session_signed_in: true *")
		case false
			output_debug("* -- -- session_signed_in: false *")
	end select
	output_debug("")
end if

session_init()

'---------------------------------------------------------------------------------------------------
function begin_session(this_user_id)
	'on error resume next
	if len(this_user_id) > 0 then 
		session_signed_in = true
		
		if global_debug then output_debug("* web_session: begin_session: this_user_id > 0 [" & this_user_id & "]: session_signed_in = true *")
		
		dim session_info
		set session_info = Server.CreateObject ("ADODB.Connection")
		session_info.Open MySql
	
		dim sqlSession
		sqlSession = "" &_
			"SELECT tbl_users.applicationID, tbl_users.addressID, tbl_users.companyID, tbl_users.departmentID, tbl_users.EmpCode, " &_
			"tbl_users.userID, tbl_users.userName, tbl_users.userLevel, tbl_users.userEmail, tbl_users.userPhone, " &_
			"tbl_addresses.zip, tbl_users.userSPhone, tbl_users.firstName, tbl_users.lastName, tbl_users.creationDate, " &_
			"tbl_companies.addressid, tbl_companies.companyName, tbl_companies.companyPhone, tbl_companies.companySPhone, " &_
			"tbl_companies.creationDate, tbl_companies.Customer, tbl_users.locationid, tbl_locations.description, " &_
			"tbl_companies.weekends, tbl_companies.site, tbl_companies.showpaid, tbl_users2temps.tUserId " &_
			"FROM (tbl_locations RIGHT JOIN ((tbl_users LEFT JOIN tbl_companies ON tbl_users.companyID = tbl_companies.companyid)" &_
			"LEFT JOIN tbl_addresses ON tbl_users.addressID = tbl_addresses.addressID) ON tbl_locations.locationID = tbl_users.locationid) " &_
			"LEFT JOIN tbl_users2temps ON tbl_users.userID = tbl_users2temps.userId " &_
			"WHERE tbl_users.userID=" & this_user_id & ";"

		set dbQuery = 	 session_info.execute(sqlSession)
		if not dbQuery.eof then
			if global_debug then output_debug("* web_session: loaded session info for user: [" & this_user_id & "] *")
		
			applicationId =  CDbl("0" & dbQuery("applicationId"))
			addressId = dbQuery(1)
			companyId = dbQuery("companyID")
			departmentId = cstr(dbQuery("departmentID") & "")
			user_id = dbQuery("userID")
			tUser_id = dbQuery("tUserId")
			
			if len(tUser_id) = 0 then tUser_id = "VMS" & user_id
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
			company_phone = dbQuery("companyphone")
			company_sphone = dbQuery("companysphone")
			company_created = dbQuery("creationdate")
			company_custcode = dbQuery("customer")
			if global_debug then output_debug("dbQuery(""customer""): " & dbQuery("customer"))
			g_company_custcode.CustomerCode = company_custcode

			change_sim = request.querystring("simlevel")
			if len(change_sim) > 0 then user_level = getSecurityLevel(change_sim)			
			if global_debug then output_debug("user simulate level: " & change_sim)
			
			if global_debug then 
				output_debug("Initilized 'CustomerCode' class...")
				output_debug("Customer Code: " & g_company_custcode.CustomerCode)
				output_debug("Testing methods...")
				output_debug("   NumOfCompanies: " & g_company_custcode.NumOfCompanies)
			end if
			company_weekends = dbQuery("weekends")
			
			'set defaults Temps company to use
			dim p_site
			p_site = dbQuery("site")
			if not isnull(p_site) then
				company_dsn_site = cint(p_site)
			else
				p_site = -1
			end if
			
			g_Company_show_paid = cbool("0" & dbQuery("showpaid"))
			
			company_location_description = dbQuery("description")
			select case dbQuery("locationid")
			case g_TwinFalls
				session("location") = "PER"
				branch_address = "Personnel Plus, 111 Filer Ave, Twin Falls, Id 83301"
				branch_fax = "(208) 733-7362"
			case g_Nampa
				session("location") = "BOI"
				branch_fax = "(208) 466-7148"
				branch_address = "Personnel Plus, 1116 Caldwell Blvd, Nampa, Id 83651"
			case g_Burley
				session("location") = "BUR"
				branch_address = "Personnel Plus, 735 Overland Avenue, Burley, Id 83318"
				branch_fax = "(208) 678-5655"
			case g_Boise
				session("location") = "BOI"
				branch_fax = "(208) 378-8750"
				branch_address = "Personnel Plus, 5900 Overland Road, Boise, Id 83709"
			case g_Pocatello
				session("location") = "POC"
				branch_fax = "(208) 238-6000"
				branch_address = "Personnel Plus, 4835 Yellowstone Ave. Suite B, Boise, Id 83709"
			case else
				branch_address = "Personnel Plus, 111 Filer Ave, Twin Falls, Id 83301"
				branch_fax = "(208) 733-7362"
			end select
		
			session_info.execute "update web_sessions set userid=" & user_id & ", lastactivity=Now() where guid='" & session_id & "'"
			session_info.execute "INSERT INTO tbl_tracking (userID, datetime, username) VALUES ('" &_
				user_id & "', Now(), '" & user_name & "'); " &_
				"UPDATE tbl_users  SET lastloginDate=Now() WHERE userid='" & user_id & "'"
		elseif global_debug then 
			output_debug("* web_session: no user session info found for user: [" & this_user_id & "] *")
		end if
		session_info.Close()
		set session_info = Nothing
		set dbQuery = Nothing
	else
		if global_debug then output_debug("* web_session: begin_session: this_user_id = 0 : session_signed_in = false *")
	end if

	On Error Goto 0
end function

'---------------------------------------------------------------------------------------------------
function session_init()
	if global_debug then output_debug("* session_init(): begin *")
	
	if len(session_id) = 0 then 
		if global_debug then output_debug("* session_init(): session_id = 0 *")
	
		new_session()
		session_signed_in = false
	else
		session_signed_in = session_state()
	end if
end function

function new_session ()
	if global_debug then output_debug("* new_session(): begin *")
	dim web_session, sqlStr
	
	session_id = GetGuid()
	sqlStr = "insert into web_sessions (guid, clientip, lastactivity) values ('" &_
		session_id & "', '" &_
		session_ip & "', Now())"

	if global_debug then output_debug("* new_session(): (" & sqlStr & ") *")
	
	set web_session = server.CreateObject("ADODB.Connection")
	'print MySql
	web_session.open MySql
	web_session.execute(sqlStr)
	web_session.close
	set web_session = nothing

	if global_debug then output_debug("* -- --- session_id: " & session_id & " *")
	Response.Cookies("session_id") = session_id
end function

'---------------------------------------------------------------------------------------------------
function session_state()
	if global_debug then output_debug("* session_state(): begin *")
	
	dim web_session
	set web_session = server.CreateObject("ADODB.Connection")
	web_session.open MySql
	
	dim sqlStr
	sqlStr = "select userid, started, lastactivity from web_sessions where clientip='" &_
		session_ip & "' and guid='" & session_id & "'"
		'global_debug start
		if global_debug then output_debug("* (" & sqlStr & ") *")
		'global_debug finish		
		
	'global_debug start
	if global_debug then
		output_debug("* -- -- session_id: " & session_id & " *")
		output_debug("* -- -- session_ip: " & session_ip & " *")
	end if
	'global_debug finish
	
	dim good_session
	set good_session = web_session.execute(sqlStr)

	if not good_session.eof then
		dim session_userid, session_lasttime, session_started
		session_userid = good_session("userid")
		session_lasttime = good_session("lastactivity")
		session_started = good_session("started")
	
		'global_debug start
		if global_debug then
			output_debug("* session_state(): previous session exists --- *")
			output_debug("* -- -- session_userid: " & session_userid & " *")
			output_debug("* -- -- session_lasttime: " & session_lasttime & " *")
			output_debug("* -- -- session_started: " & session_started & " *")
		end if
		'global_debug finish
	
		dim nowtime
		nowtime = now
		if datediff("s", session_lasttime, nowtime) > 3600 then
			'global_debug start
			if global_debug then
				output_debug("* session_state():previous session too old, abandoning. *")
				output_debug("* -- -- session_abandon: " & session_id & " *")
			end if
			'global_debug finish
			session_abandon(session_id)
			session_state = false

		elseif len("" & session_userid) > 0 then 
			'global_debug start
			if global_debug then
				output_debug("* session_state():previous good. *")
				output_debug("* -- -- begin_session: " & session_userid & " *")
			end if
			'global_debug finish

			begin_session(session_userid)
			session_state = true

			'global_debug start
			if global_debug then output_debug("* -- -- session_state: true *")
			'global_debug finish
		end if
	else
		new_session() 'start new empty session
		session_state = false 'set signed in flag to false
		
		'global_debug start
		if global_debug then
			output_debug("* session_state(): start new empty session --- *")
			output_debug("* -- -- session_userid: " & session_userid & " *")
			output_debug("* -- -- session_lasttime: " & session_lasttime & " *")
			output_debug("* -- -- session_started: " & session_started & " *")
			output_debug("* -- -- session_state: false *")
		end if
		'global_debug finish
	end if
	
	web_session.close
	set good_session = nothing
	set web_session = nothing
end function

'---------------------------------------------------------------------------------------------------
function session_valid(this_session)
	'global_debug start
	if global_debug then output_debug("* session_valid(): start --- *")
	'global_debug finish

	dim sqlStr
	sqlStr = "select userid, started, lastactivity from web_sessions where clientip='" &_
		session_ip & "' and guid='" & this_session & "'"

	dim web_session
	set web_session = server.CreateObject("ADODB.Connection")
	web_session.open MySql
	
	dim good_session
	set good_session = web_session.execute(sqlStr)
	if good_session.eof then
		session_valid = false
		'global_debug start
		if global_debug then output_debug("*      session_valid: false --- *")
		'global_debug finish
	else
		session_valid = true
		'global_debug start
		if global_debug then output_debug("*      session_valid: true --- *")
		'global_debug finish
	end if

	web_session.close
	set good_session = nothing
	set web_session = nothing
end function

'---------------------------------------------------------------------------------------------------
function set_session(save_key, save_data)
	save_data = replace(save_data, "'", "''")
	dim web_session, sql
	set web_session = server.CreateObject("ADODB.Command")
	
	if len(MySql) = 0 then
		MySql = "DRIVER={MySQL ODBC 5.1 Driver};Server=192.168.0.6;port=6612;Option=67108899;Database=pplusvms;User ID=online;Password=.SystemUser"
	end if
	
	if len(session_id) = 0 then
		new_session()
	end if

	if save_data = "" then
		sql = "delete from web_sessions_data where sessionkey='" & session_id & "' and savekey='" &_
			save_key & "'"
	else
		sql = "insert into web_sessions_data (sessionkey, savekey, data) values ('" & session_id & "', '" &_
			save_key & "', '" &_
			save_data & "')"
	end if
	with web_session
		.ActiveConnection = MySql
		.CommandText = sql
		.Execute()
	end with

	set web_session = nothing
end function

'---------------------------------------------------------------------------------------------------
function session_abandon(this_session)
	'global_debug start
	if global_debug then output_debug("* session_abandon(): start --- *")
	'global_debug finish
	on error resume next
	dim web_session
	if session_valid(this_session) then
		set web_session = server.CreateObject("ADODB.Command")
		with web_session
			.ActiveConnection = MySql
			'web_session.execute("delete web_sessions.*, web_sessions_data.* from web_sessions guid, web_sessions session where web_session.guid=web_sessions_data.session and web_sessions.guid='" & session_id & "';delete from web_sessions where lastactivity < date_sub(now(), interval 1 hour)")
			.CommandText = "" &_
				"DELETE from `web_sessions`, `web_sessions_data` USING `web_sessions` " &_
				"LEFT JOIN `web_sessions_data` ON `web_sessions_data`.`sessionkey` = `web_sessions`.`guid` " &_
				"WHERE ('" & session_id & "') " &_
				"OR (lastactivity < date_sub(now(), interval 1 hour) OR stored < date_sub(now(), interval 24 hour));"
			.execute()
		end with
		
		set web_session = nothing
		
	end if
	session_signed_in = false
	Response.Cookies("session_id") = ""
	
	'global_debug start
	if global_debug then
		If Err.number <> 0 then	output_debug("* session_abandon(): *error: " & Err.number & " *")
	end if
	'global_debug finish
		
	on error goto 0
	'global_debug start
	if global_debug then output_debug("* session_abandon(): abandoned --- *")
	'global_debug finish

end function

'---------------------------------------------------------------------------------------------------
function get_session(this_key)
	dim web_session, session_data
	set web_session = server.CreateObject("ADODB.Command")
	with web_session
		.ActiveConnection = MySql
		.CommandText = "select data from web_sessions_data where savekey='" & this_key & "' and sessionkey='" & session_id & "'"
	end with
	set session_data = web_session.Execute
	if not session_data.eof then get_session = session_data("data")
	set web_session = nothing
	set session_data = nothing
end function

'---------------------------------------------------------------------------------------------------
function get_message(this_key)
	dim web_message, message_data
	set web_message = server.CreateObject("ADODB.Command")
	with web_message
		.ActiveConnection = MySql
		.CommandText = "select message from web_messages where heading='" & this_key & "'"
	end with
	
	set message_data = web_message.Execute
	if not message_data.eof then get_message = message_data("message")

	set web_message = nothing
	set message_data = nothing
end function

%>
