<%
REM dim show_paid          : show_paid        = false
REM dim show_bill          : show_bill        = false
	
REM if g_Company_show_paid or user_level < userLevelSupervisor then
	REM show_paid = true
REM end if

REM if user_level => userLevelSupervisor then
	REM show_bill = true
REM end if
REM 'for debugging
REM show_bill = true
REM show_paid = false

sub doLookUp
	
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
		qsSite = request.querystring("site")
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
		.FromDate = Request.QueryString("fromDate")
		.ToDate = Request.QueryString("toDate")
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

		ApplicantId   = Applicant.ApplicantId
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
%>
		<tr onclick="setApplicantId('<%=Applicant.ApplicantId%>', '<%=ApplicantName%>');">
			<td class=""><%=ApplicantId%></td>
			<td class=""><%=ApplicantName%></td>
			<td class=""><%=SSN%></td>
			<td class=""><%=Phone%></td>
			<td class=""><%=EmailAddress%></td>
			<td class=""><%=EmployeeCode%></td>
		</tr>
<%
		if cdbl(Applicant.Id) > 14 then moreThanFifteen = true
		
	next
	
	if moreThanFifteen then
%>
		<tr>
			<td colspan="6"><i>... 15 or more result found ... try typing more to return fewer results ... </i></td>
		</tr>
<%	
	end if
	
end sub

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


function time_summary_div(PlacementId)
	time_summary_div = "<div class=""timesummarydiv"" id=""timesummarydiv" & PlacementId & """></div>"
end function

%>
</table></div>