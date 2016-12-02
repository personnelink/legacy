<%Option Explicit%>
<%
session("required_user_level") = 4096 'userLevelPPlusStaff
session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<%


const hide = 0
const show = 1

dim visibility
select case request.querystring("do")
	case "hide"
		visibility = hide
		doSight

	case "show"
		visibility = show
		doSight
end select


sub doSight ()
	'on error resume next
	
	'retrieve placement id
	dim tmpInt
	tmpInt = request.querystring("id")
	if isnumeric(tmpInt) then
		dim BlogId
		BlogId = cint(tmpInt)
	end if
	
	'set up database connection	and get placement info
	dim doQuery_cmd
	set doQuery_cmd = server.CreateObject("ADODB.Command")
	with doQuery_cmd
		.ActiveConnection = MySql
		.CommandText =	"" &_
			"UPDATE tbl_blogs " &_
			"SET " &_
				"visible=" & visibility & " " &_
			"WHERE id=" & BlogId
	end with
	dim rsApptInfo
	set rsApptInfo = doQuery_cmd.Execute()
	
	set rsApptInfo = nothing
	set doQuery_cmd = nothing

	if Err.number <> 0 then
		response.write BlogId & " Err# " & Err.number
	else
		response.write BlogId
	end if
end sub

%>