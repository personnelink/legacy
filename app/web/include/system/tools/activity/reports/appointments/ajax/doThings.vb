<%Option Explicit%>
<%
session("required_user_level") = 4096 'userLevelPPlusStaff
session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->


<!-- #INCLUDE file='appointments.classes.vb' -->

<%
'-----------------------------------------------------------------
' parameters:
'	do     = view
'	id     = customer code
'	status = job order status
'	id      = code, applicant code or order code
'	name    = customer name, applicant name or order name
'	search  = search string
'	site    = temps site id
'	context = 'c = customer, a = application, o = order
'
'-----------------------------------------------------------------

'flag to toggle using query string or form post data
dim use_qs
if request.querystring("use_qs") = "1" then
	use_qs = true
else
	use_qs = false
end if

'retrieve site id and make sure it's numeric
dim g_strSite     : g_strSite     = getParameter("site")
dim qs_customer   : qs_customer   = replace(getParameter("customer"), "'", "''")
dim apptid        : apptid        = getParameter("apptid")
dim appointmentid : appointmentid = apptid
dim context       : context       = getParameter("context")
dim if_customer   : if_customer   = getParameter("ifc")
dim search        : search        = getParameter("q")
dim site          : site          = g_strSite
dim qsSite        : qsSite        = g_strSite
dim name          : name          = getParameter("name")

dim which_method : which_method = getParameter("do")
select case which_method
	case "applicantlookup"
		doApplicantLookUp
	case "changedisp"
		doChangeDisp
	case "changeappt"
		doChangeAppt
	case "newappointment"
		newAppointment
	case "updatecomment"
		doUpdateComment
	case "lookupcustomer"
		doCustomerLookup
	case "lookup"
		doLookUp
	case "setvalue"
		doSetValue
	case else
		break "[here]: " & which_method
end select

sub doUpdateComment ()

	dim appointmentid
	appointmentid = getParameter("appointmentid")
	
	dim comment
	comment = getParameter("comment")
	if len(comment) > 0 then comment = replace(comment, "'", "''")
	
	'set up database connection	and get placement info
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(g_strSite))
		.CommandText =	"" &_
			"UPDATE Appointments SET Comment='" & comment & "', LastModified=GETDATE(), LastModifiedBy='" & tUser_id &"' " &_
			"WHERE ID=" & replace(appointmentid, "txt_cm", "") & ";"
		.execute()
	end with
	
	set cmd = nothing
	
	response.write replace(appointmentid, "txt_cm", "")
	
end sub

sub newAppointment ()
	'set up database connection	and get placement info
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(g_strSite))
		.CommandText =	"" &_
			"INSERT INTO Appointments " &_
				"(AppDate, Entered, EnteredBy) " &_
				"VALUES (GETDATE(), GETDATE(),'" & tUser_id & "') "			
		.Execute()
		.CommandText = "select @@identity"
	end with

	dim rs 
	set rs = server.CreateObject("ADODB.Recordset")

	set rs = cmd.Execute()
	
	dim appointmentid
		appointmentid = rs(0)

	if Err.number <> 0 then
		response.write appointmentid & "[:][Err#] " & Err.number
	else
		response.write appointmentid
	end if
	
	set rs = nothing
	set cmd = nothing
	
end sub

sub doChangeAppt ()
	'on error resume next
	
	'retrieve appointment id
	dim tmpInt
	tmpInt = getParameter("id")
	if isnumeric(tmpInt) then
		dim AppointmentId
		AppointmentId = cdbl(tmpInt)
	end if
	
	'set the appointment type
	dim theApptType
	Select Case getParameter("appointment")
		Case "0"
			theApptType = 0 'Initial Interview

		Case "3"
			theApptType = 3 'Other
			
		Case "4"
			theApptType = 4 'Arrival Call

		Case "5"
			theApptType = 5 'Marketing Call

		Case "6"
			theApptType = 6 'Placement Follow-Up

		Case "7"
			theApptType = 7 'Sent Resume

		Case "8"
			theApptType = 8 'Unemployment
			
		Case "9"
			theApptType = 9 'CS Order/Garnishment

		Case "11"
			theApptType = 11 'Collection Call

		Case "12"
			theApptType = 12 'Separation
			
		Case "13"
			theApptType = 13 'Job Order Correspondence

		Case "14"
			theApptType = 14 'Client QA & Correspondence
			
		Case "15"
			theApptType = 15 'Availability

		Case "16"
			theApptType = 16 'Rates

		Case "17"
			theApptType = 17 'Work Comp

		Case "18"
			theApptType = 18 'Accident
			
		Case "19"
			theApptType = 19 'Interviewed
			
		Case Else
			response.write AppointmentId
			response.end
	End Select
	
	'set up database connection	and get placement info
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(g_strSite))
		.CommandText =	"" &_
			"UPDATE Appointments " &_
			"SET " &_
				"ApptTypeCode=" & theApptType & " " &_
			"WHERE Id=" & AppointmentId & ";"
		.Execute()
	end with
	
	set cmd = nothing

	if Err.number <> 0 then
		response.write AppointmentId & "[:][Err#] " & Err.number
	else
		response.write AppointmentId & "[:]" & "No error"
	end if
end sub

sub doChangeDisp ()
	'on error resume next
	
	'retrieve appointment id
	dim tmpInt
	tmpInt = getParameter("id")
	if isnumeric(tmpInt) then
		dim AppointmentId
		AppointmentId = cdbl(tmpInt)
	end if
	
	'set the disposition type
	dim theDisposistion, theComment, m_PlacementId
	Select Case getParameter("disposition")
		Case "0"
			theDisposistion = 0 'Active
			theComment = "Completed by " &_
			user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"
			
			'make sure placement is open [in case of accidental miss click]
			m_PlacementId = getPlacementViaAppointment(AppointmentId)
			openPlacement(m_PlacementId)

		Case "1"
			theDisposistion = 1 'Re-scheduled staff
			theComment = "Completed by " &_
			user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"
			
		Case "2"
			theDisposistion = 2 'Re-secheduled applicant [called-in]
			theComment = "Completed by " &_
			user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"

		Case "3"
			theDisposistion = 3 'Took Place
			theComment = "Completed by " &_
			user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"

		Case "4"
			theDisposistion = 4 'No Show
			theComment = "Completed by " &_
			user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"
			
			'close the placement
			m_PlacementId = getPlacementViaAppointment(AppointmentId)
			closePlacement(m_PlacementId)
		Case Else
			response.write AppointmentId
			response.end
	End Select
	
	'set up database connection	and get placement info
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(g_strSite))
		.CommandText =	"" &_
			"SELECT Comment FROM Appointments " &_
			"WHERE Id=" & AppointmentId & ";"
	end with
	
	dim rs
	set rs = cmd.Execute()
	dim Comment
	if not rs.eof then theComment = replace(left(rs("Comment") & ", " & theComment, 255), "., ", ". ")
	theComment = replace(theComment, ". , ", ". ")
	
	with cmd
		.ActiveConnection = dsnLessTemps(getTempsDSN(g_strSite))
		.CommandText =	"" &_
			"UPDATE Appointments " &_
			"SET " &_
				"DispTypeCode=" & theDisposistion & ", " &_
				"Comment='" & replace(theComment, "'", "''") & "' " &_
			"WHERE Id=" & AppointmentId & ";"
		.Execute()
	end with

	'set the placement status

	set cmd = nothing
	set rs = nothing

	if Err.number <> 0 then
		response.write AppointmentId & "[:][Err#] " & Err.number
	else
		response.write AppointmentId & "[:]" & server.HTMLEncode(theComment)
	end if
end sub

function closePlacement(PlacementId)
	if PlacementId > 0 then
		'set need final time card to false since applicant no-showed
		dim blnNeedFinalTime : blnNeedFinalTime = false
		

		'set the placement status
		dim doQuery_cmd
		set doQuery_cmd = server.CreateObject("ADODB.Command")
		with doQuery_cmd
			.ActiveConnection = dsnLessTemps(getTempsDSN(getParameter("site")))
			.CommandText =	"" &_
				"UPDATE Placements " &_
				"SET " &_
					"PlacementStatus=3, " &_
					"NeedFinalTime=" & blnNeedFinalTime & " " &_
				"WHERE PlacementID=" & PlacementId & ";"
		end with

		dim doQuery
		doQuery = doQuery_cmd.Execute()
		
		set doQuery = nothing
		set doQuery_cmd = nothing
	end if
end function

function openPlacement(PlacementId)
	if PlacementId > 0 then
		'set need final time card to false since applicant no-showed
		dim blnNeedFinalTime : blnNeedFinalTime = false
		

		'set the placement status
		dim doQuery_cmd
		set doQuery_cmd = server.CreateObject("ADODB.Command")
		with doQuery_cmd
			.ActiveConnection = dsnLessTemps(getTempsDSN(getParameter("site")))
			.CommandText =	"" &_
				"UPDATE Placements " &_
				"SET " &_
					"PlacementStatus=0, " &_
					"NeedFinalTime=" & blnNeedFinalTime & " " &_
				"WHERE PlacementID=" & PlacementId & ";"
		end with

		dim doQuery
		doQuery = doQuery_cmd.Execute()
		
		set doQuery = nothing
		set doQuery_cmd = nothing
	end if
end function

function getPlacementViaAppointment(AppointmentId)
	if AppointmentId > 0 then
		'set up database connection	and get placement info
		dim doQuery_cmd
		set doQuery_cmd = server.CreateObject("ADODB.Command")
		with doQuery_cmd
			.ActiveConnection = dsnLessTemps(getTempsDSN(g_strSite))
			.CommandText =	"" &_
				"SELECT Appointments.Id, Placements.PlacementID, Placements.PlacementStatus " &_
				"FROM Appointments " &_
				"INNER JOIN Placements ON " &_
				"(Appointments.Reference = Placements.Reference) AND " &_
				"(Appointments.Customer = Placements.Customer) AND " &_
				"(Appointments.ApplicantId = Placements.ApplicantId) " &_
				"WHERE (Appointments.Id=" & AppointmentId & " AND Placements.PlacementStatus=0);"
		end with
		dim rsPlacementId
		set rsPlacementId = doQuery_cmd.Execute()
		
		'if placement exists, make an 'appointment'
		
		if not rsPlacementId.eof then
			getPlacementViaAppointment = rsPlacementId("PlacementID")
		end if

		set rsPlacementId = nothing
		set doQuery_cmd = nothing
	end if
end function

sub doSetValue
	
	dim table_element_or_column_to_update 'figure out where to put the data based on the context
	select case lcase(trim(context))
	case "applicant"
		table_element_or_column_to_update = "ApplicantId"
	case "customer"
		table_element_or_column_to_update = "Customer"
	case "order"
		table_element_or_column_to_update = "Reference"
	case else
		response.write "out of context"
	end select
	
	dim update_temps
	set update_temps = new cTempsAttribute
	with update_temps
		.site        = g_strSite
		.table       = "Appointments"
		.element     = table_element_or_column_to_update
		.newvalue    = search
		.whereclause = "ID=" & appointmentid
		.update
	end with

	set update_temps = nothing
	
	response.write 1
end sub

sub doLookUp

	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	' dim perspective
	' 'ability to hide staff features for demo'ing
	' '
	' perspective = lcase(request.querystring("perspective"))

	if g_strSite  < 1 then g_strSite = PER

	
	'querystring customer
	search = lcase(replace(search, "'", "''"))
	if not userLevelRequired(userLevelPPlusStaff) then
		response.end 'no access for you
	end if
	
	dim how_many_bob : how_many_bob = 5
		
	dim rs

	cmd.ActiveConnection = dsnLessTemps(getTempsDSN(g_strSite))
	
	select case lcase(trim(context))
	case "customer"
		cmd.CommandText =	"" &_
			"SELECT DISTINCT TOP " & how_many_bob + 1 & " Customers.Customer AS Code, Customers.CustomerName AS Description, Max(Customers.DateLastActive) AS MaxOfLastActive " & _
			"FROM Customers " & _
			"WHERE Customers.Customer Like '%" & search & "%' OR Customers.CustomerName Like '%" & search & "%' " & _
			"GROUP BY Customers.Customer, Customers.CustomerName, Customers.DateLastActive " & _
			"ORDER BY Max(Customers.DateLastActive) DESC ,Customers.Customer, Customers.CustomerName "
	
	case "order"
		if len(if_customer) > 0 then
			dim this_customer
			this_customer = "(Customers.Customer='" & if_customer & "') AND "
		end if
		
		if isnumeric(search) then 
			dim search_where
			search_where = "(Orders.Reference = " & search & " OR Orders.JobNumber = " & search & ")"
		else
			if len(if_customer) > 0 then
				search_where =	"(Orders.JobDescription Like '%" & search & "%' OR Customers.Customer Like '%" & search & "%' OR Customers.CustomerName Like '%" & search & "%')"
			else
				search_where =	"(Orders.JobDescription Like '%" & search & "%')"
			end if
		end if
		
		cmd.CommandText =	"" &_
			"SELECT DISTINCT TOP " & how_many_bob + 1 & " Orders.Reference AS Code, Orders.JobDescription AS Description, Max(Orders.JobChangedDate) AS MaxOfLastActive " & _
			"FROM Orders LEFT JOIN Customers ON Customers.Customer = Orders.Customer " & _
			"WHERE " & this_customer & " " & search_where & _
			"GROUP BY Orders.Reference, Orders.JobDescription, Orders.JobChangedDate " & _
			"ORDER BY Max(Orders.JobChangedDate) DESC, Orders.Reference, Orders.JobDescription;"

	case "applicant"

		if isnumeric(search) then 
			search_where = "(Applicants.ApplicantID=" & search & " OR Applicants.SSNumber=" & search & ")"
		else
			search_where =	"(Applicants.LastnameFirst Like '%" & search & "%' OR Applicants.EmployeeNumber Like '%" & search & "%')"
		end if

	cmd.CommandText =	"" &_
			"SELECT DISTINCT TOP " & how_many_bob + 1 & " Applicants.ApplicantID AS Code, Applicants.LastnameFirst AS Description, Max(Applicants.AppChangedDate) AS MaxOfLastActive " & _
			"FROM Applicants " & _
			"WHERE " & search_where & _
			"GROUP BY Applicants.ApplicantID, Applicants.LastnameFirst, Applicants.AppChangedDate " & _
			"ORDER BY Max(Applicants.AppChangedDate) DESC , Applicants.ApplicantID, Applicants.LastnameFirst;"
	
	case else
	
	end select
	
	set rs = cmd.execute()
	
	dim i, results_description, results_code, more_than_enough
	response.write "<table>"
	
	do while not rs.eof
		i = i + 1
		
		if i > how_many_bob then
			more_than_enough = true
		else
			
			
			results_description = lcase(replace(rs("Description"), "'", "\'"))
			results_code = lcase(replace(rs("Code"), "'", "\'"))
			
			
			if vartype(results_description) > 1 then results_description = Replace(results_description, search, "<b>" & search & "</b>")
			if vartype(results_code) > 1 then results_code = Replace(results_code, search, "<b>" & search & "</b>")
			
			response.write "<tr onclick=""lookup.set_value('" & context & "','" & appointmentid & "','" & results_code & "', '" & results_description & "');"">"
			response.write 	"<td class="""">" & results_description & "</td>"
			response.write 	"<td class="""">" & results_code & "</td>"
			response.write "</tr>"
		end if
		
		rs.movenext
	loop 
	
	if more_than_enough = true then

		response.write "" &_
			"<tr>" &_
				"<td colspan=""6""><i>... " & how_many_bob & " result found ... type more ... </i></td>" &_
			"</tr>"
	
	end if

	response.write "</table><here>" & context & "<here>" & apptid

end sub


sub doApplicantLookUp
	
	dim Applicants
	set Applicants = new cApplicants

	' dim perspective
	' 'ability to hide staff features for demo'ing
	' '
	' perspective = lcase(request.querystring("perspective"))

	dim search
	'querystring customer
	search = replace(getParameter("search"), "'", "''")
	if len(search & "") > 0 and userLevelRequired(userLevelPPlusStaff) then
		search = search
	else
		response.end
	end if

	dim qsSite
	'querystring site
	qsSite = request.form("site")
	if len(qsSite) = 0 then
		qsSite = getParameter("site")
	end if
	
	if len(qsSite) > 0 then
		if userLevelRequired(userLevelPPlusStaff) then
			if isnumeric(qsSite) then
				Applicants.Site = getTempsCompCode(cint(qsSite))
			else
				Applicants.Site = getTempsCompCode(getCompanyNumber(qsSite))
			end if
		else
			Applicants.Site = company_dsn_site
		end if
	else
		Applicants.Site = company_dsn_site
	end if
		
	with Applicants
		.ItemsPerPage = 15
		.Page = 1
		.FromDate = getParameter("fromDate")
		.ToDate = getParameter("toDate")
	end with

	Applicants.Search(search)
	
	' if getParameter("status") = "closed" then
		' JobOrders.GetClosedOrders()
	' else
		' JobOrders.GetOpenOrders()
	' end if

	dim group_header 
	group_header = group_header &_
		"<div id=""applicantlookup"" class=""applicants"">" &_
		"<table class="""">" &_
		"<tr class=""etcHeader"">" &_
			"<th class=""ApplicantId"">Id</th>" &_
			"<th class=""ApplicantName"">Name</th>" &_
			"<th class=""ApplicantSSN"">SSN</th>" &_
			"<th class=""ApplicantPhone"">Phone</th>" &_
			"<th class=""ApplicantEmail"">Email</th>" &_
			"<th class=""EmpCode"">EmpCode</th>" &_
		"</tr>"
	
	response.write group_header
	
	dim inatleastone
		inatleastone = false

	dim id
	dim ApplicantId
	dim ApplicantName
	dim SSN
	dim Phone
	dim EmailAddress
	dim EmployeeCode

	dim Applicant, hasTimeOrExpense, moreThanFifteen
	for each Applicant in Applicants.Applicants.Items
		inatleastone = true
		hasTimeOrExpense = ""	

		ApplicantId   = cdbl(Applicant.ApplicantId)
		id            = ApplicantId
		ApplicantName = Applicant.ApplicantName
		SSN           = Applicant.SSN
		Phone         = Applicant.Phone
		EmailAddress  = lcase(Applicant.EmailAddress)
		EmployeeCode  = ucase(Applicant.EmployeeCode)

			
			
		if vartype(ApplicantId) > 1 then ApplicantId = Replace(ApplicantId, search, "<b>" & search & "</b>")
		if vartype(ApplicantName) > 1 then ApplicantName = Replace(ApplicantName, search, "<b>" & search & "</b>")
		if vartype(ApplicantName) > 1 then ApplicantName = Replace(ApplicantName, pcase(search), "<b>" & pcase(search) & "</b>")
		if vartype(SSN) > 1 then SSN = Replace(SSN, search, "<b>" & search & "</b>")
		if vartype(Phone) > 1 then Phone = Replace(Phone, search, "<b>" & search & "</b>")
		if vartype(EmailAddress) > 1 then EmailAddress = Replace(EmailAddress, search, "<b>" & search & "</b>")
		if vartype(EmployeeCode) > 1 then EmployeeCode = Replace(EmployeeCode, ucase(search), "<b>" & ucase(search) & "</b>")
		
		'Applicant.ApplicantId
		response.write "<tr onclick=""setApplicantId('" & id &  "', '" & ApplicantName & "');"">"
		response.write 	"<td class="""">" & ApplicantId & "</td>"
		response.write 	"<td class="""">" & ApplicantName & "</td>"
		response.write 	"<td class="""">" & SSN & "</td>"
		response.write 	"<td class="""">" & Phone & "</td>"
		response.write 	"<td class="""">" & EmailAddress & "</td>"
		response.write 	"<td class="""">" & EmployeeCode & "</td>"
		response.write "</tr>"

		if cdbl(Applicant.Id) > 14 then moreThanFifteen = true
		
	next
	
	if moreThanFifteen then

		response.write "" &_
			"<tr>" &_
				"<td colspan=""6""><i>... 15 or more result found ... try typing more to return fewer results ... </i></td>" &_
			"</tr>"
	
	end if

	response.write "</table></div>"

end sub

sub doCustomerLookup
	
	dim Customers
	set Customers = new cCustomers

	' dim perspective
	' 'ability to hide staff features for demo'ing
	' '
	' perspective = lcase(request.querystring("perspective"))

	dim search
	'querystring customer
	search = replace(getParameter("search"), "'", "''")
	if len(search & "") > 0 and userLevelRequired(userLevelPPlusStaff) then
		search = search
	else
		response.end
	end if

	dim qsSite
	'querystring site
	qsSite = request.form("site")
	if len(qsSite) = 0 then
		qsSite = getParameter("site")
	end if
	
	if len(qsSite) > 0 then
		if userLevelRequired(userLevelPPlusStaff) then
			if isnumeric(qsSite) then
				Customers.Site = getTempsCompCode(cint(qsSite))
			else
				Customers.Site = getTempsCompCode(getCompanyNumber(qsSite))
			end if
		else
			Customers.Site = company_dsn_site
		end if
	else
		Customers.Site = company_dsn_site
	end if
		
	with Customers
		.ItemsPerPage = 15
		.Page = 1
		.FromDate = getParameter("fromDate")
		.ToDate = getParameter("toDate")
	end with

	Customers.Search(search)
	
	' if getParameter("status") = "closed" then
		' JobOrders.GetClosedOrders()
	' else
		' JobOrders.GetOpenOrders()
	' end if

	dim group_header 
	group_header = group_header &_
		"<div id=""customerlookup"" class="""">" &_
		"<table class="""">" &_
		"<tr class=""etcHeader"">" &_
			"<th class=""CustomerCode"">Code</th>" &_
			"<th class=""CustomerName"">Name</th>" &_
			"<th class=""CustomerPhone"">Phone</th>" &_
			"<th class=""CustomerEmail"">Email</th>" &_
			"<th class=""CustomerFax"">Fax</th>" &_
		"</tr>"
	
	response.write group_header
	
	dim CustomerCode
	dim CustomerName
	dim Fax
	dim Phone
	dim EmailAddress

	dim Customer, moreThanFifteen
	for each Customer in Customers.Customers.Items

		CustomerCode   = Customer.CustomerCode
		CustomerName = Customer.CustomerName
		Fax           = Customer.Fax
		Phone         = Customer.Phone
		EmailAddress  = lcase(Customer.EmailAddress)
			
		if vartype(CustomerCode) > 1 then CustomerCode = Replace(CustomerCode, search, "<b>" & search & "</b>")
		if vartype(CustomerName) > 1 then CustomerName = Replace(CustomerName, search, "<b>" & search & "</b>")
		if vartype(Fax) > 1 then Fax = Replace(Fax, pcase(search), "<b>" & pcase(search) & "</b>")
		if vartype(Phone) > 1 then Phone = Replace(Phone, search, "<b>" & search & "</b>")
		if vartype(EmailAddress) > 1 then EmailAddress = Replace(EmailAddress, search, "<b>" & search & "</b>")

		response.write "" &_
			"<tr onclick=""setApplicantId('" & Customer.CustomerCode & "', '" & CustomerName & "');"">" &_
				"<td class="""">" & CustomerCode & "</td>" &_
				"<td class="""">" & CustomerName & "</td>" &_
				"<td class="""">" & Phone & "</td>" &_
				"<td class="""">" & EmailAddress & "</td>" &_
				"<td class="""">" & Fax & "</td>" &_
			"</tr>"

		if cdbl(Customer.Id) > 14 then moreThanFifteen = true
		
	next
	
	if moreThanFifteen then

		response.write "" &_
			"<tr>" &_
				"<td colspan=""6""><i>... 15 or more result found ... try typing more to return fewer results ... </i></td>" &_
			"</tr>"
	
	end if
	
	response.write "</table></div><!-- split -->" & apptid
end sub

public function doView ()
	'what job order status?
	dim intJobStatus
	Select Case getParameter("status")
		Case "0"
			intJobStatus = "0"

		Case "1"
			intJobStatus = "1"

		Case "2"
			intJobStatus = "2"

		Case "3"
			intJobStatus = "3"

		Case "4"
			intJobStatus = "4"

		Case Else
			exit function

	End Select

	dim Customers
	set Customers = new cCustomers
	' Customers.ItemsPerPage = 20
	' Customers.Page = CInt(Request.QueryString("Page"))
	Customers.GetAllCustomers(intJobStatus)

	dim LightOrDark : LightOrDark = "light" 'toggle light or dark row shadding

	for each Customer in Customers.Customer.Items

	select case EvenOrOdd
		case "dark"
			LightOrDark = "light"
		case else
			LightOrDark = "dark"
	end select
	%>

	<div class="customer <%=LightOrDark%>" onclick="orders.get('')">
		<span class="custcode"><%=Customer.Customer%></span>
		<span class="custname"><%=Customer.CustomerName%></span>
		<div id="<%=Customer.Customer & intJobStatus%>" class="orders hide"></div>
	</div>
	
	<%

	next
end function

public function updateTimeDetail()
	dim inputid     : inputid = getParameter("id")
	dim parameters  : parameters  = split(inputid, "_")
	dim column      : column      = parameters(0)
	dim placementid : placementid = parameters(1)
	dim summaryid   : summaryid   = parameters(2)
	dim detailid    : detailid    = parameters(3)
	dim dayid       : dayid       = parameters(4)
	dim siteid      : siteid      = getTempsDSN(g_strSite)
	dim value       : value       = cdbl(getParameter("t"))
	
	dim oldDayId
	if len(dayid) > 1 then
		oldDayId = left(dayid ,1)
		dayid    = right(dayid, 1)
	else
		oldDayId = dayid
	end if
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = MySql
	
	dim newSum
	dim sqlNewSum
		sqlNewSum = "" &_
			"SELECT IFNULL(SUM(timetotal),0) AS totalhours " &_
			"FROM time_detail " &_
			"WHERE (workday=" & dayid & ") AND (summaryid=" & summaryid & ")"
			
	select case column
	case "in", "out" 
		dim paramTimeDiff
		value = (value*60)*60
		
		select case column
		case "in"
			paramTimeDiff = "timeout, SEC_TO_TIME(" & value & ")"
		case "out"
			paramTimeDiff = "SEC_TO_TIME(" & value & "), timein"
		end select
				
		with cmd
			.CommandText = "" &_
				"UPDATE time_detail " &_
				"SET time" & column & "=SEC_TO_TIME(" & value & "), " &_
				"timetotal=(" &_
					"SELECT (TIME_TO_SEC(TIMEDIFF(" & paramTimeDiff & "))/60)/60 " &_
					") " &_
				"WHERE (summaryid=" & summaryid & ") AND (id=" & detailid & ")"
			.Execute()
			.CommandText = sqlNewSum
		end with
		
	case "total"
		with cmd
			.CommandText = "" &_
				"UPDATE time_detail " &_
				"SET timetotal=" & value & ", timein=null, timeout=null " &_
				"WHERE (summaryid=" & summaryid & ") AND (id=" & detailid & ")"
			.Execute()
			.CommandText = sqlNewSum
		end with
		
	case "type"
		with cmd
			.CommandText = "" &_
				"UPDATE time_detail " &_
				"SET workday=" & value & " " &_
				"WHERE (summaryid=" & summaryid & ") AND (id=" & detailid & ")"
			.Execute()
			.CommandText = sqlNewSum
		end with
	
	case "workday"
		with cmd
			.CommandText = "" &_
				"UPDATE time_detail " &_
				"SET workday=" & value & " " &_
				"WHERE (summaryid=" & summaryid & ") AND (id=" & detailid & ")"

			.Execute()
			.CommandText = sqlNewSum
		end with
	end select
	
	dim howManyUpdates
	if column = "workday" then
		howManyUpdates = 2
	else
		howManyUpdates = 1
	end if
	
	dim eachUpdate
	for eachUpdate = 1 to howManyUpdates
		
		if eachUpdate > 1 then
			sqlNewSum = replace(sqlNewSum, "WHERE (workday=" & dayid & ")", "WHERE (workday=" & oldDayId & ")")
			dayid = oldDayId
			cmd.CommandText = sqlNewSum
		end if
		
		'get total of new line and update summary table
		select case column
		case "in", "out", "total", "workday", "oldworkday"
			dim rs

			set rs = cmd.Execute()
			if not rs.eof then newSum = rs("totalhours")
			with cmd	
				.CommandText = "" &_
					"UPDATE time_summary " &_
					"SET time_summary.d" & dayid & "=" & newSum & " " &_
					"WHERE id=" & summaryid & ";"
					
				'print cmd.CommandText
				.Execute()
			end with
			set rs = nothing
		end select
	next
	set cmd = nothing

	response.write "[" & column & "," & placementid & "," & summaryid & "," & detailid & "," & dayid & "," & newSum & "]"

end function

function placements_div(CustomerCode, Reference)
	placements_div = "<div class=""leftline""><div class=""placements hide"" id=""or" & CustomerCode & Reference & """></div></div>"
end function

function time_summary_div(PlacementId)
	time_summary_div = "<div class=""timesummarydiv"" id=""timesummarydiv" & PlacementId & """></div>"
end function

function getParameter(p_name)
	if use_qs then
		getParameter = request.querystring(p_name)
	else
		getParameter = request.form(p_name)
	end if
end function


function objShowMore(CustomerCode, Reference, Site)
		dim strResponse
			strResponse = "" &_
				"<span class=""ShowMore"" " &_
					"id=""ctrl.order." & CustomerCode & "." & Reference & """ " &_
					"onclick=""order.getplacements('" & CustomerCode & "', '" & Reference & "', '" & Site & "')"">" &_
				"</span>"
		
		objShowMore = strResponse
end function

function placements_div(CustomerCode, Reference)
	placements_div = "<div class=""leftline""><div class=""placements hide"" id=""or" & CustomerCode & Reference & """></div></div>"
end function

function objShowMore(CustomerCode, Reference, Site)
		dim strResponse
			strResponse = "" &_
				"<span class=""ShowMore"" " &_
					"id=""ctrl.order." & CustomerCode & "." & Reference & """ " &_
					"onclick=""order.getplacements('" & CustomerCode & "', '" & Reference & "', '" & Site & "')"">" &_
				"</span>"
		
		objShowMore = strResponse
end function

function time_summary_div(PlacementId)
	time_summary_div = "<div class=""timesummarydiv"" id=""timesummarydiv" & PlacementId & """></div>"
end function

%>