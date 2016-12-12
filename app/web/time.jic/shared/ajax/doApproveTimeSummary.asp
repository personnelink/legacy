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
	
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"INSERT INTO time_detail_archive " &_
			"SELECT " &_
				"`time_detail`.`id`, " &_
				"`time_detail`.`summaryid`, " &_
				"`time_detail`.`workday`, " &_
				"`time_detail`.`timein`, " &_
				"`time_detail`.`timeout`, " &_
				"`time_detail`.`timetotal`, " &_
				"`time_detail`.`timetype`, " &_
				"`time_detail`.`created`, " &_
				"`time_detail`.`modified`, " &_
				"`time_detail`.`creatorId`, " &_
				"`time_detail`.`createdby`, " &_
				"'" & MySqlFriendlyDate & "' AS archived " &_
			"FROM pplusvms.time_detail " &_
			"WHERE summaryid=" & summaryid & ";" &_
			"DELETE FROM time_detail WHERE summaryid=" & summaryid & ";" &_
			"" &_
			"INSERT INTO time_summary_archive " &_
			"SELECT " &_
				"`time_summary`.`id`, " &_
				"`time_summary`.`customer`, " &_
				"`time_summary`.`weekending`, " &_
				"`time_summary`.`placementid`, " &_
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
				"`time_summary`.`paid`, " &_
				"`time_summary`.`approved`, " &_
				"`time_summary`.`received`, " &_
				"`time_summary`.`modified`, " &_
				"`time_summary`.`created`, " &_
				"`time_summary`.`creatorid`, " &_
				"`time_summary`.`createdby`, " &_
				user_id & " AS approverid " &_
			"FROM pplusvms.time_summary " &_
			"WHERE id=" & summaryid & ";" &_
			"DELETE FROM time_summary WHERE id=" & summaryid & ";"
			
			
			
		end with
	
		'print cmd.CommandText
		cmd.Execute()
		
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




%>