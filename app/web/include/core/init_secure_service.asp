<% 
dim global_debug
select case request.querystring("debugging")
case "1"
	global_debug = true
case else
	global_debug = false
end select

if global_debug then
	dim  objFS, debug_log
	set objFS=Server.CreateObject("Scripting.FileSystemObject")
	const FilePath = "c:\vmsDebug\vms_debug.txt"
	if objFS.FileExists(FilePath) then
		set debug_log=objFS.OpenTextFile(FilePath, 8) '8 = Appending
	else
		'set debug_log=objFS.CreateTextFile("c:\vmsDebug\vms_debug.txt",true)
	end if
		
	debug_log.WriteLine("--- Start Logging ---")
end if
%>

<!-- #INCLUDE VIRTUAL='include/core/global_declarations.asp' -->
<!-- #INCLUDE VIRTUAL='include/core/checkSignIn.asp' -->
<%

'sign in processing
'if session("resetpassword") <> "resetting" then 
if not gResettingPassword then 
	Response.Buffer = true
	
	dim errImage, LoginCookie, formSignInAction
	
	errImage = "<img src='/include/images/mainsite/icon_err.gif' alt='Missing or Incorrect Informatin'>"
	if not session_signed_in then
		'print "session_not signed in"
		
		if request.cookies("signin") = "true"  then
			if session_signed_in and user_id = 367 then 
				response.cookies("signin") = "false"
				formSignInAction = "Sign In"
			elseif not session_signed_in then
				response.cookies("signin") = "false"
				formSignInAction = "Sign In"
			end if
		end if
		
		if formSignInAction = "Sign In" And CheckVMSLogin("password") = "" And CheckVMSLogin("username") = "" then 
			begin_session(user_id)
			dim referringURL, referringQuery
			referringURL = request.serverVariables("URL")
			referringQuery = request.serverVariables("QUERY_STRING")
			if len(Trim(referringQuery)) > 0 then 
				referringURL = referringURL & "?" & referringQuery
				Response.Redirect(referringURL)
			elseif user_id ="367" then
				begin_session(367)
			end if
		else
			Response.Expires = -1000 'Makes the browser not cache this page
			show_login = true
		end if
	else
		dim reqUserLevel
			reqUserLevel = session("required_user_level")
			
		if len(reqUserLevel) > 0 then
			if userLevelRequired(reqUserLevel) <> true then
				Response.Expires = -1000 'Makes the browser not cache this page
				show_login = true
			end if	
		end if
	end if
end if

if show_login = true then
	show_login = false
	response.write "secure service init failed because session is not signed in"
	Response.End()
end if

session("no_header") = false

'Access tracking logging bread crumb
dim g_UserAgent, g_uaID
Database.Open MySql
g_UserAgent = request.serverVariables("HTTP_USER_AGENT")
Set g_uaID = Database.Execute("SELECT id FROM lst_useragents where user_agent='" & g_UserAgent & "'")
if g_uaID.eof then
	
	Database.Execute("" &_
		"INSERT INTO lst_useragents (user_agent) " &_
		"VALUES ('" & g_UserAgent & "'); " &_
		"SELECT last_insert_id()").nextrecordset
end if
Database.Execute("" &_
	"INSERT INTO tbl_siteaccess (username, query_string, remote_address, url, http_referer, " &_
		"datetime) VALUES ('" & user_name & "', " &_
		"'" & Server.HTMLEncode(Request.ServerVariables("QUERY_STRING")) & "', " &_
		"'" & request.serverVariables("REMOTE_ADDR") & "', " &_
		"'" & request.serverVariables("URL") & "', " &_
		"'" & request.serverVariables("HTTP_REFERER") & "', " &_
		"Now())")
Database.Close 

Set g_uaID =   Nothing

if global_debug then
	dim ins
	For Each ins in Session.StaticObjects
	  Response.Write(ins & "<br />Hi")
	Next

	output_debug("--- Logging Complete ---")
	debug_log.Close
	set debug_log=nothing
	set objFS=nothing
end if

%>
