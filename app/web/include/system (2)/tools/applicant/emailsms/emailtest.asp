<%Option Explicit%>
<%
session("add_css") = "./viewW2s.asp.css"
session("required_user_level") = 4 'userLevelRegistered

Server.ScriptTimeout = 216000

dim msgBody 
msgBody = "," & vbCrLf &_
	"We currently need several dozen people for next week [Wednesday February 15, 2012] and we hope that this number will continue " &_
	"to increase. We need general laborers with some construction experience. Pay is $10 to start raises will be based on performance." &_
	"" & vbCrLf & vbCrLf &_
	"You will need basic construction tools [hammer, tape measure, tool belt, etc], steel toed work boots, gloves " &_
	"and cold weather gear; we have available a supply of hard hats and safety vests." & vbCrLf & vbCrLf &_
	"We’re sending you this email because your email address was included on your Employment Application that was submitted " &_
	"with us and based on skills that you selected." & vbCrLf & vbCrLf &_
	"Your information can be updated online. If this position is something that you think you may be interested in please contact " &_
	"our office by no later than Tuesday February 14, 2012." & vbCrLf & vbCrLf &_
	"Thank you!" & vbCrLf &_
	"Personnel Plus" & vbCrLf &_
	"208.733.7300" & vbCrLf &_
	"http://www.personnelinc.com" & vbCrLf
	
dim msgSubject : msgSubject = "We need several dozen construction workers for next week."
	
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/functions/common.asp' -->


<%=decorateTop("getw2s", "marLR10", "Email SMS")%>
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
	'sql = "SELECT tbl_users.userEmail, tbl_users.firstName, tbl_users.lastName, tbl_users.userPhone, tbl_users.userSPhone " &_
	'		"FROM tbl_applications INNER JOIN tbl_users ON tbl_applications.userID = tbl_users.userID " &_
	'		"WHERE (((tbl_users.userEmail)<>"""") AND ((tbl_applications.inPER)<>0)) OR (((tbl_applications.inBUR)<>0)) OR (((tbl_applications.inBOI)<>0)) OR (((tbl_applications.inIDA)<>0));"

	sql = "SELECT tbl_users.userName, tbl_users.firstName, tbl_users.lastName, tbl_users.userEmail, " &_
		"tbl_users.UserAlternateEmail, tbl_applications.inPER, tbl_applications.inBUR, tbl_applications.skillsSet " &_
		"FROM tbl_users INNER JOIN tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID " &_
		"WHERE (inBUR >0 OR inPER >0) AND (Instr(skillsSet, "".1316."") >0 OR Instr(skillsSet, "".62."") >0 OR " &_
		"Instr(skillsSet, "".19."") >0 OR Instr(skillsSet, "".204."") >0 OR Instr(skillsSet, "".220."") >0 OR Instr(skillsSet, "".220."") >0 " &_
		"OR Instr(skillsSet, "".216."") >0 OR Instr(skillsSet, "".274."") >0 OR Instr(skillsSet, "".215."") >0) AND " &_
		"(userEmail <>"" OR UserAlternateEmail <>"");"

	
	
	dim emailaddy, fullName, i
	set dbQuery = Database.Execute(sql)
	'on error resume next
	'do while not dbQuery.eof

	' emailaddy = trim(dbQuery("userEmail"))
	' fullName = trim(pcase(dbQuery("firstName"))) & " " & trim(pcase(dbQuery("lastName")))
	emailaddy = trim("rkmore420@gmail.com")
	fullName = trim(pcase("rICHArD")) & " " & trim(pcase("SiZeMore"))
	
	' smsMain = dbQuery("userPhone")
	' if len(smsMain) > 0 then
		' smsMain = replace(getCarrier, "%phone%", smsMain)
		' smsMain = "&nbsp;&nbsp;&nbsp;SMS: <a href=""" & smsMain & """>" & smsMain & "</a><br />"

	' else
		' smsMain = ""
	' end if

	' smsSecond = dbQuery("userSPhone")
	' if len(smsSecond) > 0 and isNumeric(smsSecond) then
		' smsSecond = replace(getCarrier, "%phone%", smsSecond)
		' smsSecond = "&nbsp;&nbsp;&nbsp;SMS: <a href=""" & smsSecond & """>" & smsSecond & "</a><br />"
	' else
		' smsSecond = ""
	' end if
	
	
	' if i < 200 then
	response.write "<em>" & i & " : " & fullName & "</em><" & emailaddy & "<br />"
	' end if

	Call SendEmail (fullName & "<" & emailaddy & ">", system_email, msgSubject, fullName & msgBody, "")
	
	response.flush()
	i = i + 1
	'dbQuery.movenext
	'loop
	dbQuery = Database.Close
	
%>
</div>
<%=decorateBottom()%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
