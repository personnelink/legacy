<%Option Explicit%>
<%
session("add_css") = "./viewW2s.asp.css"
session("required_user_level") = 4 'userLevelRegistered

Server.ScriptTimeout = 216000

' First used to send notices on 2012.01.19



dim msgBody : msgBody = "As part of our efforts to offer better and more convenient services, the 2013 W2's for Personnel Plus, Inc., as well as previous years, are available for download here: " &_
						"https://www.personnelinc.com/include/system/tools/applicant/getW2s/ " & vbCrLf & vbCrLf &_
						"Please contact your local office if you have any questions or if you need any assistance." & vbCrLf & vbCrLf &_
						"Thank you," & vbCrLf &_
						"Personnel Plus" & vbCrLf & vbCrLf &_
						"P.S. This is the email address that was registered with Personnel Plus, Inc. online at https://www.personnelinc.com/" & vbCrLf &_
						"If you would not like to receive emails from Personnel Plus in the future please update your contact preferences in your profile." 


dim msgSubject : msgSubject = "Personnel Plus 2013 W2's available for download"

	
	%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/functions/common.asp' -->


<%=decorateTop("getw2s", "marLR10", "Available W2's")%>
    <div class="available_w2s"><pre>
	

<%

	Database.Open MySql
	'debug
	dim this_user
	this_user = user_id

	'check what companies user is enrolled in
	dim sql
	sql = "" &_
	
	"SELECT tbl_users.lastemailed, tbl_users.userEmail, " &_
		"tbl_users.firstName, tbl_users.lastName " &_
	"FROM tbl_applications INNER JOIN tbl_users ON tbl_applications.userID = tbl_users.userID " &_
	"WHERE (tbl_users.userEmail<>"""")" &_
	" AND (tbl_applications.inPER<>0 OR tbl_applications.inBUR<>0 OR tbl_applications.inBOI<>0 OR tbl_applications.inIDA<>0)" &_
	" AND (tbl_users.lastemailed IS NULL);"
	 
	dim emailaddy, fullName
	set dbQuery = Database.Execute(sql)
	dim totalEmailsSent
	dim MySqlFriendlyDate
	dim sqlTagAsEmailed
	dim rsTagUsersAsEmailed
			
	do while not dbQuery.eof
	totalEmailsSent = totalEmailsSent + 1

	emailaddy = trim(dbQuery("userEmail"))
	fullName = pcase(dbQuery("firstName")) & " " & pcase(dbQuery("lastName")) 
	if len(emailaddy) > 0 then
		response.write totalEmailsSent & ": " & fullName & "(" & emailaddy & ")" & vbCrLf
	end if
	MySqlFriendlyDate = Year(Date) & "/" & Month(Date) & "/" & Day(Date)
	sqlTagAsEmailed = "" &_
		"UPDATE tbl_users SET lastemailed='" & MySqlFriendlyDate & "' " &_
		"WHERE (userName LIKE '%" & emailaddy & "%') OR (userEmail LIKE '%" & emailaddy & "%') OR (UserAlternateEmail LIKE '%" & emailaddy & "%')"
	
	'print sqlTagAsEmailed
	
	Database.Execute(sqlTagAsEmailed)
	'if totalEmailsSent > 9341 then 'arbitrary number from new emails in my inbox, plus number remaining in mail server queue, to compensate for previous failed previous send
		on error resume next
		Call SendEmail (fullName & "<" & emailaddy & ">", w2_system_email, msgSubject, msgBody, "")
		'Call SendEmail (fullName & "Richard Sizemore<richardksizemore@gmail.com>", system_email, msgSubject, msgBody, "")
		'Call SendEmail (fullName & "Julie Peterson<jpeterson@personnel.com>", system_email, msgSubject, msgBody, "")
		'Call SendEmail (fullName & "Gus Haner<ghaner@personnel.com>", w2_system_email, msgSubject, msgBody, "")
		on error goto 0
	'end if
	'break "test done"
	
	
	response.flush()
	dbQuery.movenext
		' if totalEmailsSent > 3 then break "three sent" 'testing brake
	loop
	response.write vbCrLf & "Total emailed: " &  totalEmailsSent
%>
</pre></div>
<%=decorateBottom()%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
