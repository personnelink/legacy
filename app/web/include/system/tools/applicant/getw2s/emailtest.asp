<%Option Explicit%>
<%
session("add_css") = "./viewW2s.asp.css"
session("required_user_level") = 4 'userLevelRegistered

Server.ScriptTimeout = 216000

dim msgBody : msgBody = "The 2011 W-2's for Personnel Plus are available online and can downloaded here: " &_
						"/include/system/tools/applicant/getW2s/ " & vbCrLf & vbCrLf &_
						"Please contact your local office if you have any questions or if you need any assistance." & vbCrLf & vbCrLf &_
						"Thank you," & vbCrLf &_
						"Personnel Plus" & vbCrLf & vbCrLf &_
						"P.S. This email address was registered with Personnel Plus, Inc. online at http://www.personnelinc.com/"


dim msgSubject : msgSubject = "W-2`s from Personnel Plus can be downloaded online"

	
	%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/functions/common.asp' -->


<%=decorateTop("getw2s", "marLR10", "Available W2's")%>
    <div class="available_w2s">
	

<%

	dim getCarrier
	getCarrier = "http://tnid.us/search.php?q=%phone%&x=94&y=64"
	Database.Open MySql
	'debug
	dim this_user
	this_user = user_id

	'check what companies user is enrolled in
	dim sql
	sql = "SELECT tbl_users.userEmail, tbl_users.firstName, tbl_users.lastName, tbl_users.userPhone, tbl_users.userSPhone " &_
			"FROM tbl_applications INNER JOIN tbl_users ON tbl_applications.userID = tbl_users.userID " &_
			"WHERE (((tbl_users.userEmail)<>"""") AND ((tbl_applications.inPER)<>0)) OR (((tbl_applications.inBUR)<>0)) OR (((tbl_applications.inBOI)<>0)) OR (((tbl_applications.inIDA)<>0));"

	
	dim emailaddy, fullName, smsMain, smsSecond
	set dbQuery = Database.Execute(sql)
	do while not dbQuery.eof

	emailaddy = trim(dbQuery("userEmail"))
	fullName = pcase(dbQuery("firstName")) & " " & pcase(dbQuery("lastName"))
	
	smsMain = dbQuery("userPhone")
	if len(smsMain) > 0 then
		smsMain = replace(getCarrier, "%phone%", smsMain)
		smsMain = "<a href=""" & smsMain & """>" & smsMain & "</a>"

	else
		smsMain = "n/a"
	end if

	smsSecond = dbQuery("userSPhone")
	if len(smsSecond) > 0 and isNumeric(smsSecond) then
		smsSecond = replace(getCarrier, "%phone%", smsSecond)
		smsSecond = "<a href=""" & smsSecond & """>" & smsSecond & "</a>"
	else
		smsSecond = "n/a"
	end if
	
	

	if len(emailaddy) > 0 then
		response.write fullName & "<" & emailaddy & ">" & "Main SMS: " & smsMain & " Secondary SMS: " & smsSecond
	end if
	
	on error resume next
	'Call SendEmail ("Gus Haner<ghaner@personnel.com>>", system_email, msgSubject, msgBody, "")
	on error goto 0
	
	response.flush()
	dbQuery.movenext
	loop
	
%>
</div>
<%=decorateBottom()%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
