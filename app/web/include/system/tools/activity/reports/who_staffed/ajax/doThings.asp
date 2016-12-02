<%Option Explicit%>
<%
session("required_user_level") = 4096 'userLevelPPlusStaff
session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<%

select case request.querystring("do")
	case "update"
		doUpdate
end select

sub doUpdate ()

	dim heardthen
	heardthen = request.querystring("heard")
	if len(heardthen) > 0 then heardthen = replace(heardthen, "'", "''")
	
	dim heardnow
	heardnow = request.querystring("now")
	if len(heardnow) > 0 then heardnow = replace(heardnow, "'", "''")
	
	'set up database connection	and get placement info
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText =	"" &_
			"UPDATE tbl_applications SET rawHeardUsHow=heardAboutUs " &_
			"WHERE trim(lcase(heardAboutUs))='" & trim(lcase(heardthen)) & "';"

		.execute()
	end with

	with cmd
		.CommandText =	"" &_
			"UPDATE tbl_applications SET heardAboutUs='" &  trim(lcase(heardnow)) & "' " &_
			"WHERE trim(lcase(heardAboutUs))='" & trim(lcase(heardthen)) & "';"

		.execute()
	end with
	
end sub

%>