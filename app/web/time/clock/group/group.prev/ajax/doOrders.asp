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

sub doGetOrders
	
	dim JobOrders
	set JobOrders = new cOrders

	dim perspective
		'ability to hide staff features for demo'ing
		'
		perspective = lcase(request.querystring("perspective"))

		dim cust
		'querystring customer
		cust = replace(getParameter("customer"), "'", "''")
		if len(cust & "") > 0 and userLevelRequired(userLevelPPlusStaff) then
			JobOrders.Customer = cust
			cust = "customer=" & cust

		elseif (len(g_company_custcode.CustomerCode & "") > 0 and userLevelRequired(userLevelPPlusStaff)) or (len(g_company_custcode.CustomerCode & "") > 0 and 		userLevelRequired(userLevelSupervisor)) then
			JobOrders.Customer = getParameter("id")
		cust = "customer=" & g_company_custcode.CustomerCode
			else
			break "Account not associated and or Not Authorized, please contact 1 (877) 733-7300 or email accounts@personnel.com"
		end if

		dim qsSite
		'querystring site
		qsSite = request.form("site")
		if len(qsSite) = 0 then	qsSite = request.querystring("site")
			
			
		if len(qsSite) > 0 then
			if userLevelRequired(userLevelPPlusStaff) then
				if isnumeric(qsSite) then
					JobOrders.Site = getTempsCompCode(cint(qsSite))
				else
					JobOrders.Site = getTempsCompCode(getCompanyNumber(qsSite))
				end if
			else
				JobOrders.Site = company_dsn_site
			end if
		else
			JobOrders.Site = qsSite
		end if
		
	with JobOrders
		.ItemsPerPage = 150
		.Page = Request.QueryString("WhichPage")
		' .Company = Request.QueryString("whichCompany")
		' .Customer = Request.QueryString("WhichCustomer")
		.FromDate = Request.QueryString("fromDate")
		.ToDate = Request.QueryString("toDate")
	end with

	if getParameter("status") = "closed" then
		JobOrders.GetClosedOrders()
	else
		JobOrders.GetOpenOrders()
	end if

	dim group_header 
	group_header = group_header &_
		"<div class=""joborders"">" &_
		"<table class=""etcdetails"">" &_
		"<tr class=""etcHeader"">" &_
			"<th class=""MoreDetail"">&nbsp;</th>" &_
			"<th class=""OrderDept"">Dept</th>" &_
			"<th class=""OrderReference"">JO#</th>" &_
			"<th class=""OrderDescription"">Description</th>" &_
			"<th class=""OrderWorkSite"">Work Site</th>" &_
			"<th class=""OrderDate"">Ordered</th>" &_
			"<th class=""OrderStartDate"">Start</th>" &_
			"<th class=""OrderStopDate"">Stop</th>" &_
			"<th class=""OrderPhone"">Phone</th>" &_
			"<th class=""CustomerActivities"">&nbsp;</th>" &_
		"</tr></table></div>"
	
	response.write group_header
	
	dim inatleastone
		inatleastone = false
	dim Order, hasTimeOrExpense
	for each Order in JobOrders.Orders.Items
		inatleastone = true
		hasTimeOrExpense = ""	
			
		dim qsActivityURL
		qsActivityURL = "" &_
			"?page_title=Activities&site=" &_
			Order.Site & "&" &_
			"act_when=all&WhichOrder=&fromDate=3%2F20%2F2011&toDate=3%2F25%2F2011&" &_
			"WhichPage=&WhichPage=&activity_0=1&activity_6=1&activity_4=1&activity_7=1&" &_
			"activity_13=1&activity_14=1&activity_15=1&activity_16=1" &_
			"&customer=" & Order.CustomerCode
	%>
		<div class="joborders" title="<%=Order.EmailAddress%>">
			<table><tr>
			<td class="MoreDetail"><%=objShowMore(Order.CustomerCode, Order.Reference, Order.Site)%></td>
			<td class="OrderDept"><%=Order.CustomerDept%></td>
			<td class="OrderReference"><%=Order.Reference%></td>
			<td class="OrderDescription"><div><%=Order.JobDescription%></div></td>
			<td class="OrderWorkSite"><div><%=Order.WorkSite%></div></td>
			<td class="OrderDate"><div><%=Order.OrderDate%></div></td>
			<td class="OrderStartDate"><div><%=Order.StartDate%></div></td>
			<td class="OrderStopDate"><div><%=Order.StopDate%></div></td>
			<td class="OrderPhone"><%=FormatPhone(Order.WorkSitePhone)%></td>
			<td class="CustomerActivities">
				<a href="/include/system/tools/activity/reports/activity/<%=qsActivityURL%>">[order activity]</a>
			</td>
			</tr></table>
		</div>

		<!-- '"<td class=""Reference"">"  & "</td>" &_ -->
		<%=placements_div(Order.CustomerCode, Order.Reference)%>
	
	<%
	next
	
	if not getParameter("status") = "closed" then

		if not inatleastone then
			response.write "<div class=""noOpenOrders""><i>no open orders found, " &_
				"<a href=""javascript:;"" onclick=""customer.getorders('" & JobOrders.Customer & "', '" & JobOrders.Site & "', 'closed')"">show closed orders</a>?</i></div>"
		else
			response.write "<div class=""noOpenOrders""><i>" &_
				"<a href=""javascript:;"" onclick=""customer.getorders('" & JobOrders.Customer & "', '" & JobOrders.Site & "', 'closed')"">[show closed orders]</a>?</i></div>"
		end if

	else
		if not inatleastone then
			response.write "<div class=""noClosedOrders""><i>no closed orders found.</i></div>"
		end if
	end if

	response.write "<!-- [split] -->" & JobOrders.Customer

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
