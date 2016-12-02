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
	
	'get lookup verb
	
	dim SearchResults
	set SearchResults = new cSearchTemps
	
	' dim perspective
	' 'ability to hide staff features for demo'ing
	' '
	' perspective = lcase(request.querystring("perspective"))

	dim search
	'querystring customer
	search = replace(getParameter("search"), "'", "''")
	if not len(search & "") > 0 and userLevelRequired(userLevelPPlusStaff) then
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
				SearchResults.Site = getTempsCompCode(cint(qsSite))
			else
				SearchResults.Site = getTempsCompCode(getCompanyNumber(qsSite))
			end if
		else
			SearchResults.Site = company_dsn_site
		end if
	else
		SearchResults.Site = company_dsn_site
	end if
		
	with SearchResults
		.ItemsPerPage = 10
		.Page = 1
		.FromDate = Request.QueryString("fromDate")
		.ToDate = Request.QueryString("toDate")
	end with
	
	dim searchField : searchField = request.querystring("lookup")
	select case lcase(searchField)
		case "whichcustomer"
			SearchResults.SearchByCustomer(search)
			
		case "whichorder"
			SearchResults.SearchByJobOrder(search)
			
		case "employee"
			SearchResults.SearchByEmployee(search)
			
		case "enteredby"
			SearchResults.SearchByEnteredBy(search)
			
		case "assignedto"
			SearchResults.SearchByAssignTo(search)
			
		case "search"
			SearchResults.SearchByEverything(search)
			
	end select

	
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
			"<th class=""SearchId"">Id</th>" &_
			"<th class=""SearchName"">Name</th>" &_
			"<th class=""SearchEIN"">EIN</th>" &_
		"</tr>"
	
	response.write group_header
	
	dim inatleastone
		inatleastone = false

	dim SearchResultsId
	dim SearchResultsCode
	dim SearchResultsDescription

	dim Result, hasTimeOrExpense, moreThanTen, count
	
	for each Result in SearchResults.SearchResults.Items

		count=count+1
		inatleastone = true
		hasTimeOrExpense = ""	
		
		SearchResultsId = Result.Id
		SearchResultsCode = Result.Code
		SearchResultsDescription = Result.Description
		
		if vartype(SearchResultsId) > 1 then SearchResultsId = Replace(SearchResultsId, search, "<b>" & search & "</b>")
		if vartype(SearchResultsCode) > 1 then SearchResultsCode = Replace(SearchResultsCode, search, "<b>" & search & "</b>")
		if vartype(SearchResultsDescription) > 1 then SearchResultsDescription = Replace(SearchResultsDescription, pcase(search), "<b>" & pcase(search) & "</b>")
%>
		<tr onclick="SetSearchField('<%=searchField%>', '<%=SearchResultsId%>');">
			<td class=""><%=SearchResultsId%></td>
			<td class=""><%=SearchResultsDescription%></td>
			<td class=""><%=SearchResultsCode%></td>
		</tr>
<%
	next

	if cdbl(count) > 9 then moreThanTen = true
	
	if moreThanTen then
%>
		<tr>
			<td colspan="3"><i>... 10 or more result found ... try typing more to return fewer results ... </i></td>
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