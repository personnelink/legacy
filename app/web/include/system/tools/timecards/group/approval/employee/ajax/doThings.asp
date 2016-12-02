<%
session("required_user_level") = 8 'userLevelScreened
%>

<!-- #INCLUDE VIRTUAL='/include/system/tools/timecards/group/ajax/doThings.asp' -->

<%

sub doGetEmployeeOrders

	dim JobOrders
	set JobOrders = new cOrders

		dim cust
		'querystring customer
		cust = replace(getParameter("id"), "'", "''")
		if len(cust & "") > 0 and userLevelRequired(userLevelScreened) then
			JobOrders.Customer = cust
			cust = "customer=" & cust
		end if
		
		JobOrders.Department = departmentId
		dim qsSite
		'querystring site
		qsSite = request.form("site")
		if len(qsSite) = 0 then	qsSite = request.querystring("site")
			
			
		if len(qsSite) > 0 then
			if userLevelRequired(userLevelScreened) then
				if isnumeric(qsSite) then
					JobOrders.Site = getTempsCompCode(cint(qsSite))
				else
					JobOrders.Site = getTempsCompCode(getCompanyNumber(qsSite))
				end if
			else
				JobOrders.Site = company_dsn_site
			end if
		else
			JobOrders.Site = company_dsn_site
		end if
		
		JobOrders.ApplicantId = GetApplicantIdFromUserId(user_id, JobOrders.Site )
		
	with JobOrders
		.ItemsPerPage = 150
		.Page = Request.QueryString("WhichPage")
		' .Company = Request.QueryString("whichCompany")
		' .Customer = Request.QueryString("WhichCustomer")
		.FromDate = Request.QueryString("fromDate")
		.ToDate = Request.QueryString("toDate")
	end with

	if getParameter("status") = "closed" then
		JobOrders.GetEmployeeClosedOrders()
	else
		JobOrders.GetEmployeeOpenOrders()
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
			"<th class=""OrderActivities"">&nbsp;</th>" &_
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
			"act_when=all&WhichOrder=&fromDate=&toDate=&" &_
			"WhichPage=&WhichPage=&activity_0=1&activity_6=1&activity_4=1&activity_7=1&" &_
			"activity_13=1&activity_14=1&activity_15=1&activity_16=1" &_
			"&customer=" & Order.CustomerCode
	%>
		<div class="joborders" title="<%=Order.EmailAddress%>">
			<table><tr>
			<td class="MoreDetail"><%=objEmployeeShowMore(Order.CustomerCode, Order.Reference, Order.Site)%></td>
			<td class="OrderDept"><%=Order.CustomerDept%></td>
			<td class="OrderReference"><%=Order.Reference%></td>
			<td class="OrderDescription"><div><%=Order.JobDescription%></div></td>
			<td class="OrderWorkSite"><div><%=Order.WorkSite%></div></td>
			<td class="OrderDate"><div><%=Order.OrderDate%></div></td>
			<td class="OrderStartDate"><div><%=Order.StartDate%></div></td>
			<td class="OrderStopDate"><div><%=Order.StopDate%></div></td>
			<td class="OrderPhone"><div><%=FormatPhone(Order.WorkSitePhone)%></div></td>
			<td class="OrderActivities">
				<span class="button"><span onclick="activity.load.order('<%=Order.CustomerCode%>', '<%=qsActivityURL%>', '<%=Order.Site%>', '<%=Order.Reference%>')">Order Activity</span></span>
			</td>
			</tr></table>
			<div id="order_activity_<%=Order.Reference%>"></div>
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

function objEmployeeShowMore(CustomerCode, Reference, Site)
		dim strResponse
			strResponse = "" &_
				"<span class=""ShowMore"" " &_
					"id=""ctrl.order." & CustomerCode & "." & Reference & """ " &_
					"onclick=""order.getemployeeplacements('" & CustomerCode & "', '" & Reference & "', '" & Site & "')"">" &_
				"</span>"
		
		objEmployeeShowMore = strResponse
end function

%>
