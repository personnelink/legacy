<%

	dim tagAsHtml, HTMLTag : HTMLTag = "<!-- HTML Formatted -->"

	'check if editting blog or system content [using path]

	dim scriptName
	scriptName = request.ServerVariables("SCRIPT_NAME")

	dim blogOrSys
	if instr(scriptName, "/include/system/tools/edit/") > 0 then

		blogOrSys = "tbl_content"

	elseif instr(scriptName, "/include/user/post/") > 0 then

		blogOrSys = "tbl_content"
		
	elseif instr(scriptName, "/job_postings/edit/") > 0 then

		blogOrSys = "job"

	else

		blogOrSys = "tbl_blogs"

	end if
		
	dim jobedit
	select case blogOrSys
		case "job"
			jobedit = true
			
		case else
			jobedit = false
			
	end select
	
	dim deleteBlogID, referredFrom

	deleteBlogID = Request.QueryString("removeblogid")
	if deleteBlogID > 0 then
		if request.form("confirmed") = "yes" then
			Database.Open MySql
			Database.Execute("DELETE From " & blogOrSys & " Where id=" & deleteBlogID)
			Database.Close
			Response.Redirect("/userHome.asp")
		Else
			response.write decorateTop("", "notToShort marLR10", "Are you sure you want to do this?")
			response.write "<div id=""confirmDelete"">You cannot undo this, are you sure you want to delete this?</div>"
			response.write "<p id=""deleteMessage""><a class=""squarebutton"" href=""javascript:document.forms['messageBlogForm'].submit();"" onclick=""document.forms['messageBlogForm'].submit();""><span>Yes, Delete</span></a></p>"
			response.write "<script type=""text/javascript""><!--"
			response.write "document.messageBlogForm.blogSubject.focus()"
			response.write "//--></script>"
			response.write decorateBottom()
		end if
	end if

	dim blogSubject, blogContact, blogBody, blogID, sqlCommand, blogFormat, blogReply, htmlReformatted
	if post_it = "true" then
	
		blogSubject = Replace(request.form("blogSubject"), "'", "''")
		blogContact = Replace(request.form("blogContact"), "'", "''")
		blogBody = Replace(request.form("blogBody"), "'", "''")
		blogID = Request.form("blogID")
		blogFormat = Request.form("formatting")

		if jobedit then
		
			blogSubject = Replace(request.form("jobDescription"), "'", "''")
			blogContact = user_firstname & " " & user_lastname & "<" & user_email & ">"
			
		end if	
		
		if instr(blogBody, "replydate") > 0 then
			blogReply = true
		else
			blogReply = false
		end if
		
		if instr(blogBody, HTMLTag) > 0 or blogBody <> ClearHTMLTags(WebDescription, 0) then
			htmlReformatted = true
		else
			if blogFormat = "html" then tagAsHTML = HTMLTag
			htmlReformatted = false
		end if
	
		if blogFormat = "html" then	
			if not htmlReformatted then
				blogBody =  Replace(blogBody, vbCrLf, "<br />")
				blogBody =  Replace(blogBody, "<br /><br /><br /><br />", "<br /><br />") & tagAsHTML
				tagAsHTML = ""
				htmlReformatted = true
			end if
		end if

		if not blogOrSys = "job" then
		
			if len(blogID & "") = 0 then blogID = 0
			if blogID > 0 then
				blogReply = true
				if blogReply then
					'don't change date on reply
					sqlCommand = "Update " & blogOrSys & " Set heading='" & blogSubject & "', contact='" & blogContact & "', content='" & blogBody & tagAsHTML & "' Where" &_
						" id=" & blogID
				else
					sqlCommand = "Update " & blogOrSys & " Set heading='" & blogSubject & "', contact='" & blogContact & "', content='" & tagAsHTML & blogBody & "' Where" &_
						" id=" & blogID
				end if

			else
				if (blogFormat = "html" and htmlReformatted) then	
					sqlCommand = "Insert Into " & blogOrSys & " (userID, date, heading, contact, content, class) Values ('" & user_id & "'," & _
							"Now()," & "'" & blogSubject & "', '" & blogContact & "'," & "'" & blogBody & "','message')"
				Else	
					sqlCommand = "Insert Into " & blogOrSys & " (userID, date, heading, contact, content, class) Values ('" &_
						user_id & "'," &_
						"Now()," &_
						"'" & Server.HTMLEncode(blogContact) & "'," &_
						"'" & Server.HTMLEncode(blogSubject) & "'," &_
						"'" & Server.HTMLEncode(blogBody) & "'," &_
						"'message')"
				end if
			end if
		elseif blogOrSys = "job" then
				
			'check if posting is html or preformatted
			dim nohtml
			nohtml = ClearHTMLTags(blogBody, 0)
			if len(nohtml) < len(blogBody) then blogFormat = "html"
			
			dim whichSite, intSite
			intSite = request.QueryString("site")
			if len(intSite) > 0 then whichSite = cint(intSite)
			
			dim updatejob_cmd
			Set updatejob_cmd = Server.CreateObject("ADODB.Command")
			With updatejob_cmd
				.ActiveConnection = dsnLessTemps(whichSite)
			End With
			
			dim qs_id, reference
			qs_id = request.QueryString("id")
			if len(qs_id) > 0 then reference = cdbl(qs_id)
			
			if (blogFormat = "html" and htmlReformatted) then	
				
				updatejob_cmd.CommandText = "" &_
					"UPDATE OtherOrders  SET OtherOrders.Def2=" & insert_string(blogSubject) & ", OtherOrders.Def1=" &  insert_string(replace(blogBody, """", """""")) & " " &_
					"WHERE OtherOrders.Reference=" & reference & ";"
			
			else
				
				updatejob_cmd.CommandText = "" &_
					"UPDATE OtherOrders  SET OtherOrders.Def2=" &  insert_string(Server.HTMLEncode(blogSubject)) & ", OtherOrders.Def1=" &  insert_string(Server.HTMLEncode(replace(blogBody, """", """"""))) & " " &_
					"WHERE OtherOrders.Reference=" & reference & ";"
	
			end if
		'print updatejob_cmd.CommandText
			updatejob_cmd.Execute()

		end if

		if len(sqlCommand) > 0 then
			Database.Open MySql
			Database.Execute(sqlCommand)
			Database.Close
		end if
		
		
		
	'send notification email
	dim blogLink, msgBody, msgSubject, city, appState, zipcode, deliveryLocation

	blogLink = "<a href='https://www.personnelinc.com/include/system/tools/activity/blogs/'>View Blog Postings</a>" 
	'check if business
	if len(company_name) > 0 then
		msgSubject = user_firstname & " " & user_lastname & " with " & company_name & " posted a new message. "
	else
		msgSubject = user_firstname & " " & user_lastname & " posted a new message. "
	end if

	msgBody = "Blob Subject: " & blogSubject & "<br><br>" &_
		"Message: " & blogBody & "<br><br>" &_
		"Contact Info Provided: " & blogContact & "<br><br><br>" &_
		"Posted Messages can be viewed by clicking the ""Blog Messages"" link from the VMS Start Page or via here: " & blogLink &_
		"<send_as_html>"

	deliveryLocation = "burley@personnel.com;boise@personnel.com;nampa@personnel.com;twin@personnel.com;pocatello@personnel.com"
	
	if not blogReply then
		'suppress email on replys
		Call SendEmail (deliveryLocation, system_email, msgSubject, msgBody, "")
	end if
	
	referringQuery = request.form("referringQuery")
	referringURL = request.form("referringURL")
	
	dim queryParameters, copyReferringURL
	queryParameters = split(referringQuery, "&")
	copyReferringURL = referringURL
	
	dim thisParam
	for thisParam = 0 to ubound(queryParameters)

		if instr(referringURL, queryParameters(thisParam)) = 0 then

			referringURL = referringURL & "&" & queryParameters(thisParam)
		
		end if

	next
	
	if instr(referringURL, "?") = 0 then

		referringURL = copyReferringURL & "?" & referringQuery

	end if
	
	session("no_header") = false
	if len(referringURL) > 0 then
		response.redirect(referringURL)
	else
		response.redirect("/userHome.asp")
	end if
end if

blogID = Request.QueryString("blogid")
if not isnumeric(blogID) then
	blogID = -1
end if

if blogID > 0 then
	Database.Open MySql
	dbQuery = Database.Execute("Select heading, contact, content From " & blogOrSys & " Where id=" & blogID)
	blogContact = dbQuery("contact")
	blogContact = Replace(blogContact & "", """", "'")
	blogContact = Replace(blogContact & "", "'", "''")
	blogSubject = dbQuery("heading")
	blogBody = dbQuery("content")
	blogBody = Replace(blogBody, "<br>", Chr(13))
	Database.Close
end if

if jobedit then

	dim thisConnection, Customers, selectedID, customerID

	dim getWebDescription_cmd, getWebDescription

			
	dim whichJob, intJob
	intJob = request.QueryString("id")
	if len(intJob) > 0 then whichJob = cdbl(intJob)

	dim QueryText
	QueryText = "" &_
		"SELECT OtherOrders.Def1, Orders.JobChangedDate, Orders.RegTimePay, OtherOrders.Def2, OtherOrders.Reference, Orders.DirectionsParking " &_
		"FROM Orders RIGHT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference " &_
		"WHERE OtherOrders.Reference=" & whichJob & ";"

	intSite = request.QueryString("site")
	 if len(intSite) > 0 then whichSite = cint(intSite)
	
	dim jobdetails_cmd
	Set jobdetails_cmd = Server.CreateObject("ADODB.Command")
	With jobdetails_cmd
		.ActiveConnection = dsnLessTemps(whichSite)
		.CommandText     = QueryText
	End With

	Dim JobDetail
	Set JobDetail = jobdetails_cmd.Execute
	if Not JobDetail.eof then
	
		dim dateCache      : dateCache      = JobDetail("JobChangedDate")
		dim WebDescription : WebDescription = JobDetail("Def1")
		dim jobLocation    : jobLocation    = JobDetail("DirectionsParking")
		dim jobPay         : jobPay         = JobDetail("RegTimePay")
		dim WebTitle       : WebTitle       = JobDetail("Def2")
		
		blogContact = user_firstname & " " & user_lastname & "<" & user_email & ">"
		
		if not isnull(blogContact) then 
			blogContact = Replace(blogContact & "", """", "'")
			blogContact = Replace(blogContact & "", "'", "''")
		end if
		
		blogSubject = WebTitle
		blogBody = WebDescription
		if not isnull(blogBody) then 
			blogBody = Replace(blogBody, "<br>", Chr(13))
		end if
		
	end if

	JobDetail.Close
	set JobDetail = nothing
	set jobdetails_cmd = nothing
end if

function CompanyCode(intCode)
	Select Case intCode
		Case 0
			CompanyCode = "PER"
		Case 1
			CompanyCode = "BUR"
		Case 2
			CompanyCode = "BOI"
		Case 3
			CompanyCode = "IDA"
		Case 4
			CompanyCode = "POC"
		Case 5
			CompanyCode = "ORE"
	End Select
end function

dim formWindowTitle
if jobedit then
	formWindowTitle = "Edit Job Order"
else
	formWindowTitle = "Message Subject and Body"
end if

%>