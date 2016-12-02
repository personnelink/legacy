<!-- #include virtual='/include/system/classes/lookup/customer.classes.vb' -->

<%

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
		qsSite = request.querystring("site")
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
		.FromDate = Request.QueryString("fromDate")
		.ToDate = Request.QueryString("toDate")
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
%>
		<tr onclick="setApplicantId('<%=Customer.CustomerCode%>', '<%=CustomerName%>');">
			<td class=""><%=CustomerCode%></td>
			<td class=""><%=CustomerName%></td>
			<td class=""><%=Phone%></td>
			<td class=""><%=EmailAddress%></td>
			<td class=""><%=Fax%></td>
		</tr>
<%
		if cdbl(Customer.Id) > 14 then moreThanFifteen = true
		
	next
	
	if moreThanFifteen then
%>
		<tr>
			<td colspan="6"><i>... 15 or more result found ... try typing more to return fewer results ... </i></td>
		</tr>
<%	
	end if
	
	response.write "</table></div>"
	
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
