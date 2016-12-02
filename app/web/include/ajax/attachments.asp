<%Option Explicit%>
<!-- Revised: 2010.12.14 -->
<%
session("required_user_level") = 4096 'userLevelPPlusStaff
session("no_header") = true

%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<%
dim qs_action
qs_action = request.querystring("action")

dim which_company, thisConnection
which_company = request.querystring("dsn")
if len(which_company & "") > 0 then
	thisConnection = dsnLessTemps(getTempsDSN(which_company))
else
	qs_action = "no_delete"
end if

dim this_file, this_session
this_file = request.QueryString("fileid")
this_session = request.QueryString("sessionid")

if not isnumeric(this_file) then this_file = 0

if this_file > 0 and this_session = session_id then
	dim delete_file_reference
	Set delete_file_reference = Server.CreateObject ("ADODB.RecordSet")
	
	dim sqlCommandText
	With delete_file_reference
		.CursorLocation = 3 ' adUseClient
		sqlCommandText = "SET IDENTITY_INSERT AttachmentsDeleted ON " &_
			"INSERT INTO AttachmentsDeleted ([FileId], [ApplicantId], [Customer],[Reference], [PlacementId], [ContactId], [DescriptionOfFile], [OriginalName], [Extension], [By], [On], [Source], [Secure], [FileName], [AttachType], [Expires], [Archived]) " &_
			"SELECT * FROM Attachments " &_
			"WHERE FileId=" & this_file & "; " &_
			"SET IDENTITY_INSERT AttachmentsDeleted OFF"
			
	End With
	'print sqlCommandText
	delete_file_reference.Open sqlCommandText, thisConnection
	
	sqlCommandText = "DELETE FROM Attachments " &_
			"WHERE FileId=" & this_file
			
	delete_file_reference.Open sqlCommandText, thisConnection
	'Set WhoseHere = getDailySignIn_cmd.Execute	
else
	if this_file <= 0 then qs_action = "no_delete, fileid bad"
	if this_session <> session_id then qs_action = "no_delete, session missmatch"
end if
	

If qs_action = "del" then
	response.write "<i>deleted</i>"
else
	response.write qs_action
end if
 %>