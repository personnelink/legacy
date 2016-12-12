<!-- #include virtual='/include/system/functions/common.asp' -->
<%
dim post_to
post_to = "maintainCustomer.asp"
errImage = "<img src='/include/images/mainsite/icon_err.gif' alt='Missing or Incorrect Information'>"

dim where, where_friendly, cust, who_check
where_friendly = request.QueryString("where")
where = getTempsDSN(where_friendly)
cust = replace(request.QueryString("cust"), "'", "''")

dim Customer
dim CustomerName
dim Address
dim Cityline
dim Contact
dim Phone
dim EmailAddress
dim Fax
dim DiscountType
dim SalesCode
dim SalesTaxExemptNo
dim CreditLimit
dim PrintStatement
dim CustomerType
dim InvoiceFormat
dim Notes

if len(cust) > 0 then

'	dim entry_date, LastAssignDate, LastAssignCust, DateAvailable
'	dim EmployeeNumber
'	entry_date = request.form("EntryDate")
'	LastAssignDate = request.form("LastAssignDate")
'	LastAssignCust = request.form("LastAssignCust")
'	DateAvailable = request.form("DateAvailable")
'	EmployeeNumber = request.form("EmployeeNumber")
	
'	dim app_skills
'	app_skills = request.form("app_skills") 
	
'	dim i, test_results(8)
'	for i = 0 to 8
'		test_results(i) = request.Form("UserNumeric" & i + 1)
'	next
	
	Customer = request.form("Customer")
	CustomerName = request.form("CustomerName")
	Address = request.form("Address")
	Cityline = request.form("Cityline")
	Contact = request.form("Contact")
	Phone = request.form("Phone")
	EmailAddress = request.form("EmailAddress")
	Fax = request.form("Fax")
	DiscountType = request.form("DiscountType")
	SalesCode = request.form("SalesCode")
	SalesTaxExemptNo = request.form("SalesTaxExemptNo")
	CreditLimit = request.form("CreditLimit")
	PrintStatement = request.form("PrintStatement")
	CustomerType = request.form("CustomerType")
	InvoiceFormat = request.form("InvoiceFormat")
	Notes = server.HTMLEncode(request.Form("Notes"))
	
	dim update_applicant
	update_applicant = request.Form("action")
	if update_applicant = "update" then
		dim update_cmd, sqlStr

		sqlStr = "UPDATE Customers " & _
					"SET CustomerName = " & insert_string(CustomerName) & ", " &_
						"Address = " & insert_string(Address) & ", " &_
						"Cityline =" & insert_string(Cityline) & ", " &_
						"Contact = " & insert_string(Contact) & ", " &_
						"Phone = " & insert_string(Phone) & ", " &_
						"EmailAddress = " & insert_string(EmailAddress) & ", " &_
						"Fax = " & insert_string(Fax) & ", " &_
						"DiscountType = " & insert_string(DiscountType) & ", " &_
						"SalesCode = " & insert_string(SalesCode) & ", " &_
						"SalesTaxExemptNo = " & insert_string(SalesTaxExemptNo) & ", " &_
						"CreditLimit =  " & insert_string(CreditLimit) & ", " &_
						"PrintStatement = " & insert_string(PrintStatement) & ", " &_
						"CustomerType = " & insert_string(CustomerType) & ", " &_
						"InvoiceFormat = " & insert_string(InvoiceFormat) & ", " &_
						"WHERE Customer=" & cust
	
	'Notes = server.HTMLEncode(request.Form("Notes"))
		
		set update_cmd = Server.CreateObject("adodb.connection")
		update_cmd.Open dsnLessTemps(where)
		update_cmd.execute sqlStr
		update_cmd.Close
		set update_cmd = nothing
		dim updated : updated = "<i>Successfully Updated</i>"
	end if
	
	
	if not trim(lcase(Customer)) = trim(lcase(cust)) then 
		dim customer_cmd, rsCustomer, i
		set customer_cmd = server.CreateObject("adodb.command")
		with customer_cmd
			.activeconnection = dsnLessTemps(where)
			.CommandText = "SELECT Customers.Customer, CustomerName, Address, Cityline, Contact, Cityline, Phone, EmailAddress, " &_
							"Fax, DiscountType, SalesCode, SalesTaxExemptNo, CreditLimit, PrintStatement, CustomerType, " &_
							"InvoiceFormat, Notes " &_
							"FROM Customers LEFT JOIN NotesCustomers ON Customers.Customer = NotesCustomers.Customer " &_
							"WHERE Customers.Customer='" & cust & "';"
			.Prepared = true
		End With
		
		Set rsCustomer = customer_cmd.Execute
		
		Customer = rsCustomer.fields.item("Customer")
		CustomerName = rsCustomer.fields.item("CustomerName")
		Address = rsCustomer.fields.item("Address")
		Cityline = rsCustomer.fields.item("Cityline")
		Contact = rsCustomer.fields.item("Contact")
		Phone = rsCustomer.fields.item("Phone")
		EmailAddress = rsCustomer.fields.item("EmailAddress")
		Fax = rsCustomer.fields.item("Fax")
		DiscountType = rsCustomer.fields.item("DiscountType")
		SalesCode = rsCustomer.fields.item("SalesCode")
		SalesTaxExemptNo = rsCustomer.fields.item("SalesTaxExemptNo")
		CreditLimit = rsCustomer.fields.item("CreditLimit")
		PrintStatement = rsCustomer.fields.item("PrintStatement")
		CustomerType = rsCustomer.fields.item("CustomerType")
		InvoiceFormat = rsCustomer.fields.item("InvoiceFormat")
		'notes = server.HTMLEncode(rsCustomer.fields.item("Notes"))
		
		set customer_cmd = nothing
		set rsCustomer = nothing
	end if

	maintainCompanyForm
	
end if

function CheckField(thisField)
end function

function CheckPhone(thisField)
end function

function getActivities(thisApplicant)

	dim activities_cmd
	set activities_cmd = server.CreateObject("adodb.command")
	with activities_cmd
		.activeconnection = dsnLessTemps(where)
		.CommandText = "SELECT Appointments.ApplicantId, Appointments.AppDate, Appointments.Comment, " &_
			"Appointments.AssignedTo, ApptTypes.ApptType, Dispositions.Disposition, Appointments.Customer, " &_
			"Appointments.Reference, Appointments.ContactId, Appointments.Entered, Appointments.EnteredBy, " &_
			"Appointments.LastModified, Appointments.LastModifiedBy " &_
			"FROM Dispositions RIGHT JOIN (ApptTypes RIGHT JOIN Appointments ON ApptTypes.ApptTypeCode = " &_
			"Appointments.ApptTypeCode) ON Dispositions.DispTypeCode = Appointments.DispTypeCode " &_
			"WHERE Appointments.ApplicantId=" & ApplicantId & " " &_
			"ORDER BY Appointments.AppDate DESC;"
	end with
	
	dim activities
	set activities = activities_cmd.execute
	
	if activities.eof then
		response.write "<i>No actitivies</i>"
	else
		response.write "<table>"
		do until activities.eof
			response.write "<tr><th>" & activities.fields.item("AppDate") & "</th> " &_
					"<td>&nbsp;</td>" &_
					"<th>" & activities.fields.item("Disposition") & "</th></tr>" &_
					"<tr><td colspan=3>" & activities.fields.item("Comment") & "</td></tr>"
			activities.movenext
		loop
		response.write "</table>"
	end if
	set activities = nothing
	set activities_cmd = nothing
end function
%>