<%
public function approveTimeSummary()
	dim placementid
	placementid = getParameter("id")
	
	dim siteid
	if isnumeric(g_strSite) then
		siteid = getTempsDSN(getCompCode(g_strSite))
	else
		siteid = getTempsDSN(g_strSite)
	end if
		
	dim summaryid
	summaryid = getParameter("summary")
	
' dim cmd
	' set cmd = server.CreateObject("ADODB.Command")
	' with cmd
		' .ActiveConnection = MySql
		
		' if isnumeric(g_strSite) then
			' .CommandText = "" &_
				' "INSERT INTO time_summary " &_
				' "(placementid, site) " &_
				' "VALUES " &_
				' "(" & placementid & ", " & g_strSite & ")"
		' else
			' .CommandText = "" &_
				' "INSERT INTO time_summary " &_
				' "(placementid, site) " &_
				' "VALUES " &_
				' "(" & placementid & ", " & getSiteNumber(g_strSite) & ")"
		' end if
		
		' 'print cmd.CommandText
		' .Execute()

		' ' .CommandText = "" &_
			' ' "SELECT weekending, workday, SUM(TIME_TO_SEC(TIMEDIFF(timeout, timein))) AS totalhours " &_
			' ' "FROM time_summary INNER JOIN time_detail ON time_summary.id = time_detail.summaryid " &_
			' ' "WHERE placementid=" & placementid & " " &_
			' ' "GROUP By workday ORDER By weekending desc, workday asc;"
	' end with
	' set cmd = nothing
	
	dim MySqlFriendlyDate
	MySqlFriendlyDate = Year(date) & "/" & Month(date) & "/" & Day(date)
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	
	cmd.ActiveConnection = MySql
	
	cmd.CommandText = "" &_
		"INSERT IGNORE INTO time_detail_archive " &_
			"SELECT " &_
				"`time_detail`.`id`, " &_
				"`time_detail`.`summaryid`, " &_
				"`time_detail`.`workday`, " &_
				"`time_detail`.`timein`, " &_
				"`time_detail`.`timeout`, " &_
				"`time_detail`.`timetotal`, " &_
				"`time_detail`.`adjusted`, " &_
				"`time_detail`.`timetype`, " &_
				"`time_detail`.`created`, " &_
				"`time_detail`.`modified`, " &_
				"`time_detail`.`creatorId`, " &_
				"`time_detail`.`createdby`, " &_
				"'" & MySqlFriendlyDate & "' AS archived " &_
			"FROM pplusvms.time_detail " &_
			"WHERE time_detail.summaryid=" & summaryid & ";" &_
			"" &_
		"DELETE time_detail.* FROM pplusvms.time_detail LEFT OUTER JOIN time_detail_archive ON time_detail.id= time_detail_archive.id " &_
		"WHERE time_detail_archive.summaryid=" & summaryid & ";" &_
			"" &_
		"INSERT IGNORE INTO time_summary_archive " &_
			"SELECT " &_
				"`time_summary`.`id`, " &_
				"`time_summary`.`customer`, " &_
				"`time_summary`.`weekending`, " &_
				"`time_summary`.`placementid`, " &_
				"`time_summary`.`department`, " &_
				"`time_summary`.`costcenter`, " &_
				"`time_summary`.`regpay`, " &_
				"`time_summary`.`regbill`, " &_
				"`time_summary`.`otpay`, " &_
				"`time_summary`.`otbill`, " &_
				"`time_summary`.`workcode`, " &_
				"`time_summary`.`wc_description`, " &_
				"`time_summary`.`employeenumber`, " &_
				"`time_summary`.`cc_description`, " &_
				"`time_summary`.`site`, " &_
				"`time_summary`.`d1`, " &_
				"`time_summary`.`d2`, " &_
				"`time_summary`.`d3`, " &_
				"`time_summary`.`d4`, " &_
				"`time_summary`.`d5`, " &_
				"`time_summary`.`d6`, " &_
				"`time_summary`.`d7`, " &_
				"`time_summary`.`rt`, " &_
				"`time_summary`.`ot`, " &_
				"`time_summary`.`dt`, " &_
				"`time_summary`.`exp_tot`, " &_
				"`time_summary`.`pp_submitted`, " &_
				"`time_summary`.`emp_submitted`, " &_
				"`time_summary`.`paid`, " &_
				"`time_summary`.`approved`, " &_
				"`time_summary`.`received`, " &_
				"`time_summary`.`modified`, " &_
				"`time_summary`.`created`, " &_
				"`time_summary`.`creatorid`, " &_
				"`time_summary`.`foruserid`, " &_
				"`time_summary`.`createdby`, " &_
				insert_number(user_id) & " AS approverid, " &_
				"NOW() AS approved_on " &_
			"FROM pplusvms.time_summary " &_
			"WHERE id=" & summaryid & ";" &_
			"" &_
			"DELETE time_summary.* FROM pplusvms.time_summary LEFT OUTER JOIN time_summary_archive ON time_summary.id=time_summary_archive.id " &_
			"WHERE time_summary_archive.id=" & summaryid & ";"
	'print cmd.CommandText
	cmd.execute

		
	dim sql
	sql	= "" &_
			"SELECT Orders.Customer, Customers.CustomerName, Customers.Phone AS CustPhone, Orders.JobNumber, Orders.Reference, Orders.EmailAddress, " &_
				"Orders.JobDescription, Applicants.LastnameFirst, Applicants.EmailAddress AS ApplicantEmail, Applicants.Telephone AS ApplicantPhone, " &_
				"Applicants.[2ndTelephone] AS AlternatePhone, Applicants.[2ndTeleDescription] AS AltPhoneDescript, Placements.EmployeeNumber, Placements.WorkCode, " &_
				"Placements.RegPayRate, Placements.RegBillRate, Placements.OvertimePayRate, Placements.OvertimeBillRate " &_
			"FROM (Orders RIGHT JOIN (Applicants RIGHT JOIN Placements ON Applicants.ApplicantID = Placements.ApplicantId) " &_
				"ON Orders.Reference = Placements.Reference) LEFT JOIN Customers ON Placements.Customer = Customers.Customer " &_
			"WHERE Placements.PlacementID=" & placementid & ";"
	
	dim rs
	set rs = GetRSfromDB(sql, dsnLessTemps(siteid))

	
	dim approvalSubject
		approvalSubject = rs("CustomerName") & " has approved time for " & rs("LastnameFirst")
	
	dim indenter : indenter = "<br>&nbsp;----&nbsp;"
	dim approvalBody
		approvalBody = rs("CustomerName") & " has approved time for " & rs("LastnameFirst") & "<br><br>" &_
			"<em><strong>Time approved and submitted</strong> by " & user_firstname & " " & user_lastname & " [userid: " & user_name & "]</em><br><br>" &_
			"<em><strong>Additional Customer Details</strong></em>: " & indenter &_
				"Customer Name: " & rs("CustomerName") & indenter &_
				"Customer Code: " & rs("Customer") & indenter &_
				"Customer email: " & rs("EmailAddress") & indenter &_
				"Customer Phone: " & FormatPhone(rs("CustPhone")) & "<br><br>" &_
			"<em><strong>Order Details for '" & rs("JobDescription") & "'</strong></em>: " & indenter &_
				"Department [Job Number]: " & rs("JobNumber") & indenter &_
				"Order Reference: " & rs("Reference") & indenter &_
				"Order WorkCode: " & rs("WorkCode") & indenter &_
				"Regular Bill Rate: $" & TwoDecimals(rs("RegBillRate")) & indenter &_
				"Overtime Bill Rate: $" & TwoDecimals(rs("OvertimeBillRate")) &_
				"<br><br>"
	
	dim anyQuestions
		anyQuestions = "Please contact a <a href=""https://www.personnelinc.com/include/content/contact.asp"" alt=""Contact Us"">" &_
			"local office</a> nearest you if you have any questions or need additional assistance.<br><br>" &_
			"Sincerely,<br>Personnel Plus<br>www.personnelinc.com<br>"

	dim sendToBranch
	
	select case siteid
		case 0
			sendToBranch = "twin@personnel.com"
		case 1
			sendToBranch = "burley@personnel.com"
		case 2
			sendToBranch = "boise@personnel.com>;Timecard Approved<nampa@personnel.com"
		case 3
			sendToBranch = "boise@personnel.com>;Timecard Approved<nampa@personnel.com"
		case else
			sendToBranch = "managers@personnel"
	end select
	
	dim eContact : eContact = user_name
	dim eSubject : eSubject = approvalSubject
	dim eBody    : eBody = approvalBody
	
	Call SendEmail (user_firstname & " " & user_lastname & "<" & user_email & ">", "Timecard Approved<" & sendToBranch & ">;" & system_email, "Time Approval: " & eSubject, "<send_as_html>" & eBody & anyQuestions, "")

		eBody = eBody &_
			"<em><strong>Employee Details for '" & rs("LastnameFirst") & "'</strong></em>: " & indenter &_
				"Employee Number: " & rs("EmployeeNumber") & indenter &_
				"Regular Pay: $" & TwoDecimals(rs("RegPayRate")) & indenter &_
				"Overtime Pay: $" & TwoDecimals(rs("OvertimePayRate")) & indenter &_
				"Email Address: " & rs("ApplicantEmail") & indenter &_
				"Primary Phone: " & FormatPhone(rs("ApplicantPhone")) & indenter &_
				"Alternate Phone: " & rs("AlternatePhone") & " - " & rs("AltPhoneDescript") &_
				"<br>------------------------------------------------------"
	
	Call SendEmail ("Timecard Approved<" & sendToBranch & ">", system_email, "Time Approval: " & eSubject, "<send_as_html>" & eBody, "")

	
	
	
	response.write placementid & ":" & g_strSite
	
end function

public function unapproveTimeSummary()
		
	dim summaryid
	summaryid = getParameter("id")
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	
	cmd.ActiveConnection = MySql
	
	cmd.CommandText = "" &_
		"INSERT IGNORE INTO time_detail " &_
			"SELECT " &_
				"`time_detail_archive`.`id`, " &_
				"`time_detail_archive`.`summaryid`, " &_
				"`time_detail_archive`.`workday`, " &_
				"`time_detail_archive`.`timein`, " &_
				"`time_detail_archive`.`timeout`, " &_
				"`time_detail_archive`.`timetotal`, " &_
				"`time_detail_archive`.`adjusted`, " &_
				"`time_detail_archive`.`timetype`, " &_
				"`time_detail_archive`.`created`, " &_
				"`time_detail_archive`.`modified`, " &_
				"`time_detail_archive`.`creatorId`, " &_
				"`time_detail_archive`.`createdby` " &_
			"FROM pplusvms.time_detail_archive " &_
			"WHERE time_detail_archive.summaryid=" & summaryid & ";" &_
			"" &_
		"DELETE time_detail_archive.* FROM pplusvms.time_detail_archive LEFT OUTER JOIN time_detail ON time_detail_archive.id= time_detail.id " &_
		"WHERE time_detail.summaryid=" & summaryid & ";" &_
			"" &_
		"INSERT IGNORE INTO time_summary " &_
			"SELECT " &_
				"`time_summary_archive`.`id`, " &_
				"`time_summary_archive`.`customer`, " &_
				"`time_summary_archive`.`weekending`, " &_
				"`time_summary_archive`.`placementid`, " &_
				"`time_summary_archive`.`department`, " &_
				"`time_summary_archive`.`costcenter`, " &_
				"`time_summary_archive`.`regpay`, " &_
				"`time_summary_archive`.`regbill`, " &_
				"`time_summary_archive`.`otpay`, " &_
				"`time_summary_archive`.`otbill`, " &_
				"`time_summary_archive`.`workcode`, " &_
				"`time_summary_archive`.`wc_description`, " &_
				"`time_summary_archive`.`employeenumber`, " &_
				"`time_summary_archive`.`cc_description`, " &_
				"`time_summary_archive`.`site`, " &_
				"`time_summary_archive`.`d1`, " &_
				"`time_summary_archive`.`d2`, " &_
				"`time_summary_archive`.`d3`, " &_
				"`time_summary_archive`.`d4`, " &_
				"`time_summary_archive`.`d5`, " &_
				"`time_summary_archive`.`d6`, " &_
				"`time_summary_archive`.`d7`, " &_
				"`time_summary_archive`.`rt`, " &_
				"`time_summary_archive`.`ot`, " &_
				"`time_summary_archive`.`dt`, " &_
				"`time_summary_archive`.`exp_tot`, " &_
				"`time_summary_archive`.`pp_submitted`, " &_
				"`time_summary_archive`.`emp_submitted`, " &_
				"`time_summary_archive`.`paid`, " &_
				"`time_summary_archive`.`approved`, " &_
				"`time_summary_archive`.`received`, " &_
				"`time_summary_archive`.`modified`, " &_
				"`time_summary_archive`.`created`, " &_
				"`time_summary_archive`.`creatorid`, " &_
				"`time_summary_archive`.`foruserid`, " &_
				"`time_summary_archive`.`createdby` " &_
			"FROM pplusvms.time_summary_archive " &_
			"WHERE id=" & summaryid & ";" &_
			"" &_
			"DELETE time_summary_archive.* FROM pplusvms.time_summary_archive LEFT OUTER JOIN time_summary ON time_summary_archive.id=time_summary.id " &_
			"WHERE time_summary.id=" & summaryid & ";"
	'print cmd.CommandText
	cmd.execute

	response.write summaryid
	
end function


%>