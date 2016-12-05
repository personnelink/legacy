<%
dim show_paid          : show_paid        = false
dim show_bill          : show_bill        = false
	
if g_Company_show_paid or user_level < userLevelSupervisor then
	 show_paid = true
end if

REM if user_level => userLevelSupervisor then
	REM show_bill = true
REM end if
REM 'for debugging
REM show_bill = true
REM show_paid = false

sub doGetPlacements
	dim Placements
	set Placements = new cPlacements

	dim perspective
		'ability to hide staff features for demo'ing
		'
		perspective = lcase(request.querystring("perspective"))

		dim qscust
		qscust = replace(getParameter("customer"), "'", "''")
		if len(qscust & "") > 0 and userLevelRequired(userLevelPPlusStaff) then
			Placements.Customer = qscust
			qscust = "customer=" & qscust
		elseif (len(g_company_custcode.CustomerCode & "") > 0 and userLevelRequired(userLevelPPlusStaff)) or (len(g_company_custcode.CustomerCode & "") > 0 and  userLevelRequired(userLevelSupervisor)) then
		Placements.Customer = getParameter("customer")
		qscust = "customer=" & g_company_custcode.CustomerCode
		else
			break "Account not associated and or Not Authorized." & vbCrlf & "Please contact 1 (877) 733-7300 or email accounts@personnel.com"
		end if
		
		
		dim qsSite
		'querystring site
		qsSite = getParameter("site")
		if len(qsSite) > 0 then
			if isnumeric(qsSite) and userLevelRequired(userLevelPPlusStaff) then
				Placements.Site = getTempsCompCode(cint(qsSite))
			elseif len(qsSite) > 0 then
			
				Placements.Site = qsSite
			else
				Placements.Site = company_dsn_site
			end if
		else
			Placements.Site = qsSite
		end if

		
	with Placements
		.ItemsPerPage = 150
		.Page = Request.QueryString("WhichPage")
		' .Company = Request.QueryString("whichCompany")
		' .Customer = Request.QueryString("WhichCustomer")
		.Order = GetParameter("id")
		.Applicant = Request.QueryString("whichApplicant")
		.FromDate = Request.QueryString("fromDate")
		.ToDate = Request.QueryString("toDate")
		.GetActivePlacements()
	end with

	'init checked text string blob
	const checkedText = "checked=""checked"""

dim LastReference      : LastReference    = 0
dim LastDepartment     : LastDepartment   = 0
dim firstloop          : firstloop        = true
dim department_total   : department_total = 0



dim manage_customer_form
manage_customer_form = "/include/system/tools/manage/customer/?"

dim resourcelink
resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"

dim numberOfPlacements    : numberOfPlacements    = 0
dim previousCode          : previousCode          = ""
dim previousLastnameFirst : previousLastnameFirst = ""
dim objChangePlacement    : objChangePlacement    = ""			
dim strResponse           : strResponse           = ""
dim hasTimeOrExpense 
dim useThisLastnameFirst
dim multiplacement

dim placement
for each Placement in Placements.Placements.Items
	' do while not ( rs.Eof Or rs.AbsolutePage <> nPage )
		' if rs.eof then
			' rs.Close
			' ' Clean up
			' ' Do the no results HTML here
			' response.write "No Items found."
			' ' Done
			' Response.End 
		' end if
		
		' chkSpace = instr(PStopDate, " ")
		' if chkSpace > 0 then
			' PStopDate = left(PStopDate, chkSpace - 1)
		' end if
		
		if previousCode <> Placement.CustomerCode then
			if previousCode <> "" then
				response.write group_footer
			end if
			
			response.write group_header
			
			previousCode = Placement.CustomerCode
		end if

		if Placement.HasTimeOrExpense then
			hasTimeOrExpense = ""
		else
			hasTimeOrExpense = " GreyOut"
		end if
		
		if Placement.lastnamefirst = previousLastnameFirst then
			numberOfPlacements = numberOfPlacements + 1
			useThisLastnameFirst = "<span class=""duplicateplacement"">&nbsp;</span>"
			multiplacement = " multiplacement"
		else
			useThisLastnameFirst  = Placement.lastnamefirst
			previousLastnameFirst = useThisLastnameFirst
			numberOfPlacements = 1
			multiplacement = ""
			
		end if
		%>

		<table class="etcdetails">
			<tr>
				<td class="lastnamefirst<%=hasTimeOrExpense%>"><div><div class="<%=multiplacement%>"><%=objShowMorePlacements(Placement.PlacementId, Placements.Site) & "<em><i>" & useThisLastnameFirst& "</i></em>"%></div></div></td>
				<td class="EmployeeNumber<%=hasTimeOrExpense%>"><div><%=objOpenClosePlacement(Placement.PlacementId, Placement.Status, Placements.Site) & Placement.EmployeeNumber%></div></td>
				<td class="JobNumber<%=hasTimeOrExpense%>"><%=Placement.Reference%></td>
				<td class="WCDescription<%=hasTimeOrExpense%>"><div><%=Placement.WCDescription%></div></td>
				<td class="StartDate<%=hasTimeOrExpense%>"><%=Placement.StartDate%></td>
				<td class="PStopDate<%=hasTimeOrExpense%>"><div><%=Placement.PStopDate%></div></td>
				<td class="WorkCode<%=hasTimeOrExpense%>"><%=Placement.WorkCode%></td>
				<% if show_paid then %>
				<td class="RegPayRate alignR<%=hasTimeOrExpense%>">$<%=Placement.RegPayRate%></td>
				<% end if %>
				<% if show_bill then %>
				<td class="RegBillRate alignR<%=hasTimeOrExpense%>">$<%=Placement.RegBillRate%></td>
				<% end if %>
				<td class="ExpenseSummary alignR<%=hasTimeOrExpense%>"><div><%=Placement.ExpenseSummary%></div></td>
				<td class="TimeSummary alignR<%=hasTimeOrExpense%>"><div><%=Placement.TimeSummary%></div></td>
				<td class="OkayApprove alignR">
					<input type="checkbox" class="TimeOkay" id="TimeOkay<%=Placement.PlacementId%>" onclick="timeokay.open('<%Placement.PlacementId%>', '<%Placements.Site%>')" />
				</td>
			</tr>
		</table>
		<!-- '"<td class=""Reference"">"  & "</td>" &_ -->
		<%=time_summary_div(Placement.PlacementId)%>
	
<%
next

Response.write group_footer

response.write "<!-- [split] -->" & Placements.Customer & Placements.Order
end sub
	
function main_header (CustomerCode, CustomerName, CustomerDept, Site)
	dim qsActivityURL
	qsActivityURL = "" &_
		"?page_title=Activities&site=" &_
		Site & "&" &_
		"act_when=all&WhichOrder=&fromDate=3%2F20%2F2011&toDate=3%2F25%2F2011&" &_
		"WhichPage=&WhichPage=&activity_0=1&activity_6=1&activity_4=1&activity_7=1&" &_
		"activity_13=1&activity_14=1&activity_15=1&activity_16=1" &_
		"&customer=" & CustomerCode
		
	dim strDepartment
	if CustomerDept = CustomerName then 
		strDepartment = ""
	else
		strDepartment = CustomerDept
	end if
	
	dim strHeader : strHeader = ""
	strHeader = strHeader &_
		"<div class=""groupheader"">" &_
			"<span class=""CustomerCode"">" & CustomerCode & "</span>" &_
			"<span class=""CustomerName"">" & CustomerName & "</span>" &_
			"<span class=""CustomerDept"">" & strDepartment & "</span>" &_
			"<span class=""CustomerActivities""><a href=""/include/system/tools/activity/reports/activity/" & qsActivityURL & """>[view activities]</a></span>" &_
		"</div>"
		
	main_header = strHeader
end function

function group_header ()
	dim strResponse : strResponse = ""
	dim strPaidColumn : strPaidColumn = ""
	dim strBillColumn : strBillColumn = ""
	
	if show_paid then
		strPaidColumn = "<th class=""RegPayRate"">Pay</th>"
	end if
	
	if show_bill then
		strBillColumn = "<th class=""RegBillRate"">Bill</th>"
	end if
	
	strResponse = strResponse &_
			"<table class=""etcdetails"">" &_
			"<tr class=""etcHeader"">" &_
				"<th class=""lastnamefirst"">&nbsp;</th>" &_
				"<th class=""EmployeeNumber"">Empl#</th>" &_
				"<th class=""JobNumber"">Ref#</th>" &_
				"<th class=""WCDescription"">Description</th>" &_
				"<th class=""StartDate"">Started</th>" &_
				"<th class=""PStopDate"">Ending</th>" &_
				"<th class=""WorkCode"">$ Center</th>" &_
				strPaidColumn &_
				strBillColumn &_
				"<th class=""ExpenseSummary"">Expense</th>" &_
				"<th class=""TimeSummary"">Time</th>" &_
				"<th class=""OkayApprove"">Ok</th>" &_
			"</tr></table>"

			'"<th class=""Reference"">Ref#</th>" &_

	group_header = strResponse
end function

function objOpenClosePlacement(p_PlacementId, p_Status, Site)
		dim strResponse : strResponse = ""
		if p_Status = "3" then
			strResponse = strResponse & "" &_
				"<span class=""OpenPlacement"" " &_
					"id=""Placement" & p_PlacementId & """ " &_
					"onclick=""placement.open('" & p_PlacementId & "', '" & Site & "')"">" &_
				"</span>"
		else
		 	 strResponse = strResponse &_
				"<span class=""ClosePlacement"" " &_
					"id=""Placement" & p_PlacementId & """ " &_
					"onclick=""placement.close('" & p_PlacementId & "', '" & Site & "')"">" &_
				"</span>"
		end if
		
		objOpenClosePlacement = strResponse
end function

function objShowMorePlacements(p_PlacementId, Site)
		dim strResponse : strResponse = ""
			strResponse = strResponse & "" &_
				"<span class=""ShowMore"" " &_
					"id=""TimeSummary" & p_PlacementId & """ " &_
					"onclick=""timesummary.open('" & p_PlacementId & "', '" & Site & "')"">" &_
				"</span>"
		
		objShowMorePlacements = strResponse
end function

function objShowMoreEmployeePlacements(p_PlacementId, Site)
		dim strResponse : strResponse = ""
			strResponse = strResponse & "" &_
				"<span class=""ShowMore"" " &_
					"id=""TimeSummary" & p_PlacementId & """ " &_
					"onclick=""timesummary.open_employee('" & p_PlacementId & "', '" & Site & "')"">" &_
				"</span>"
		
		objShowMoreEmployeePlacements = strResponse
end function

function objShowMoreInternalPlacements(p_PlacementId, Site)
		dim strResponse : strResponse = ""
			strResponse = strResponse & "" &_
				"<span class=""ShowMore"" " &_
					"id=""TimeSummary" & p_PlacementId & """ " &_
					"onclick=""timesummary.open_internal('" & p_PlacementId & "', '" & Site & "')"">" &_
				"</span>"
		
		objShowMoreInternalPlacements = strResponse
end function

function group_details (PlacementId, lastnamefirst, EmployeeNumber, JobNumber, Reference, PlacementStatus, WCDescription, StartDate, PStopDate, WorkCode, RegPayRate, RegBillRate)
	dim objChangePlacement: objChangePlacement = ""
		if PlacementStatus = "3" then
			objChangePlacement = objChangePlacement &_
				"<span class=""ShowMore"" " &_
					"id=""TimeSummary" & PlacementId & """ " &_
					"onclick=""timesummary.open('" & PlacementId & "', '" & whichCompany & "')"">" &_
				"</span>" &_
				"<span class=""OpenPlacement"" " &_
					"id=""Placement" & PlacementId & """ " &_
					"onclick=""placement.open('" & PlacementId & "', '" & whichCompany & "')"">" &_
				"</span>"
		else
		 	 objChangePlacement = objChangePlacement &_
				"<span class=""ShowMore"" " &_
					"id=""TimeSummary" & PlacementId & """ " &_
					"onclick=""timesummary.close('" & PlacementId & "', '" & whichCompany & "')"">" &_
				"</span>" &_
				"<span class=""ClosePlacement"" " &_
					"id=""Placement" & PlacementId & """ " &_
					"onclick=""placement.close('" & PlacementId & "', '" & whichCompany & "')"">" &_
				"</span>"
		end if

		dim strResponse : strResponse = ""

				' "<td class=""JobNumber"">" & JobNumber & "/" & Reference & "</td>" &_
				' "<td class=""PlacementStatus"">" & PlacementStatus & "</td>" &_
				' "<td class=""WCDescription""><div>" & WCDescription & "</div></td>" &_
				' "<td class=""StartDate"">" & StartDate & "</td>" &_
				' "<td class=""PStopDate"">" & PStopDate & "</td>" &_
				' "<td class=""WorkCode"">" & WorkCode & "</td>" &_
				' "<td class=""RegPayRate alignR"">$" & RegPayRate & "</td>" &_
				' "<td class=""RegBillRate alignR"">" &_
					' "$" & RegBillRate &_
				' "</td>" &_


		strResponse = strResponse &_
			"<tr>" &_
				"<td class=""lastnamefirst""><div>" & objChangePlacement & lastnamefirst & "</div></td>" &_
				"<td class=""EmployeeNumber"">" & EmployeeNumber & " Where is this</td>" &_
				"<td class=""ExpenseSummary alignR"">" &_
					"<span class=""ExpenseIconNormal"" " &_
						"id=""expensesummary" & PlacementId & """ " &_
						"onclick=""timesummary.open('" & PlacementId & "', '" & whichCompany & "')"">" &_
					"</span>$000.00" &_
				"</td>" &_
				"<td class=""TimeSummary alignR"">" &_
					"<span class=""TimeIconHormal"" " &_
						"id=""timesummary" & PlacementId & """ " &_
						"onclick=""timesummary.open('" & PlacementId & "', '" & whichCompany & "')"">" &_
					"</span>000" &_
				"</td>" &_
				"<td class=""OkayApprove alignR"">" &_
					"<input type=""checkbox"" class=""TimeOkay""" &_
						"id=""TimeOkay" & PlacementId & """ " &_
						"onclick=""timeokay.open('" & PlacementId & "', '" & whichCompany & "')"" />" &_
				"</td>" &_
			"</tr>"
			'"<td class=""Reference"">"  & "</td>" &_
	group_details = strResponse
end function

function time_summary_div(PlacementId)
	time_summary_div = "<div class=""timesummarydiv timesummaries"" id=""timesummarydiv" & PlacementId & """></div>"
end function

function group_footer ()
	group_footer = ""
end function

sub doGetEmployeePlacements
	dim Placements
	set Placements = new cPlacements

		dim qscust
		qscust = replace(getParameter("customer"), "'", "''")
		if len(qscust & "") > 0 and userLevelRequired(userLevelScreened) then
			Placements.Customer = qscust
			qscust = "customer=" & qscust
		else
			break "Account not associated and or Not Authorized." & vbCrlf & "Please contact 1 (877) 733-7300 or email accounts@personnel.com"
		end if
		
		
		dim qsSite
		'querystring site
		qsSite = getParameter("site")
		if len(qsSite) > 0 then
			if isnumeric(qsSite) and userLevelRequired(userLevelPPlusStaff) then
				Placements.Site = getTempsCompCode(cint(qsSite))
			elseif len(qsSite) > 0 then
			
				Placements.Site = qsSite
			else
				Placements.Site = company_dsn_site
			end if
		else
			Placements.Site = qsSite
		end if

		
	with Placements
		.ItemsPerPage = 150
		.Page = Request.QueryString("WhichPage")
		' .Company = Request.QueryString("whichCompany")
		' .Customer = Request.QueryString("WhichCustomer")
		.Order = GetParameter("id")
		.Applicant = getApplicantIdFromUserId(user_id, Placements.Site)
		.FromDate = Request.QueryString("fromDate")
		.ToDate = Request.QueryString("toDate")
		.GetActiveEmployeePlacements()
	end with

	'init checked text string blob
	const checkedText = "checked=""checked"""

dim LastReference      : LastReference    = 0
dim LastDepartment     : LastDepartment   = 0
dim firstloop          : firstloop        = true
dim department_total   : department_total = 0



dim manage_customer_form
manage_customer_form = "/include/system/tools/manage/customer/?"

dim resourcelink
resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"

dim numberOfPlacements    : numberOfPlacements    = 0
dim previousCode          : previousCode          = ""
dim previousLastnameFirst : previousLastnameFirst = ""
dim objChangePlacement    : objChangePlacement    = ""			
dim strResponse           : strResponse           = ""
dim hasTimeOrExpense 
dim useThisLastnameFirst
dim multiplacement

dim Placement
for each Placement in Placements.Placements.Items
	' do while not ( rs.Eof Or rs.AbsolutePage <> nPage )
		' if rs.eof then
			' rs.Close
			' ' Clean up
			' ' Do the no results HTML here
			' response.write "No Items found."
			' ' Done
			' Response.End 
		' end if
		
		' chkSpace = instr(PStopDate, " ")
		' if chkSpace > 0 then
			' PStopDate = left(PStopDate, chkSpace - 1)
		' end if
		
		if previousCode <> Placement.CustomerCode then
			if previousCode <> "" then
				response.write group_footer
			end if
			
			response.write group_header
			
			previousCode = Placement.CustomerCode
		end if

		if Placement.HasTimeOrExpense then
			hasTimeOrExpense = ""
		else
			hasTimeOrExpense = " GreyOut"
		end if
		
		if Placement.lastnamefirst = previousLastnameFirst then
			numberOfPlacements = numberOfPlacements + 1
			useThisLastnameFirst = "<span class=""duplicateplacement"">&nbsp;</span>"
			multiplacement = " multiplacement"
		else
			useThisLastnameFirst  = Placement.lastnamefirst
			previousLastnameFirst = useThisLastnameFirst
			numberOfPlacements = 1
			multiplacement = ""
			
		end if
		%>

		<table class="etcdetails">
			<tr>
				<td class="lastnamefirst<%=hasTimeOrExpense%>"><div><div class="<%=multiplacement%>"><%=objShowMoreEmployeePlacements(Placement.PlacementId, Placements.Site) & "<em><i>" & useThisLastnameFirst& "</i></em>"%></div></div></td>
				<td class="EmployeeNumber<%=hasTimeOrExpense%>"><div></div></td>
				<td class="JobNumber<%=hasTimeOrExpense%>"><%=Placement.Reference%></td>
				<td class="WCDescription<%=hasTimeOrExpense%>"><div><%=Placement.WCDescription%></div></td>
				<td class="StartDate<%=hasTimeOrExpense%>"><%=Placement.StartDate%></td>
				<td class="PStopDate<%=hasTimeOrExpense%>"><div><%=Placement.PStopDate%></div></td>
				<td class="WorkCode<%=hasTimeOrExpense%>"><%=Placement.WorkCode%></td>
				<% if show_paid then %>
				<td class="RegPayRate alignR<%=hasTimeOrExpense%>">$<%=Placement.RegPayRate%></td>
				<% end if %>
				<% if show_bill then %>
				<td class="RegBillRate alignR<%=hasTimeOrExpense%>">$<%=Placement.RegBillRate%></td>
				<% end if %>
				<td class="ExpenseSummary alignR<%=hasTimeOrExpense%>"><div><%=Placement.ExpenseSummary%></div></td>
				<td class="TimeSummary alignR<%=hasTimeOrExpense%>"><div><%=Placement.TimeSummary%></div></td>
				<td class="OkayApprove alignR">
					<input type="checkbox" class="TimeOkay" id="TimeOkay<%=Placement.PlacementId%>" onclick="timeokay.open('<%Placement.PlacementId%>', '<%Placements.Site%>')" />
				</td>
			</tr>
		</table>
		<!-- '"<td class=""Reference"">"  & "</td>" &_ -->
		<%=time_summary_div(Placement.PlacementId)%>
	
<%
next

Response.write group_footer

response.write "<!-- [split] -->" & Placements.Customer & Placements.Order
end sub
	
sub doGetInternalPlacements
	dim Placements
	set Placements = new cPlacements

		dim qscust
		qscust = replace(getParameter("customer"), "'", "''")
		if len(qscust & "") > 0 and userLevelRequired(userLevelScreened) then
			Placements.Customer = qscust
			qscust = "customer=" & qscust
		else
			break "Account not associated and or Not Authorized." & vbCrlf & "Please contact 1 (877) 733-7300 or email accounts@personnel.com"
		end if
		
		
		dim qsSite
		'querystring site
		qsSite = getParameter("site")
		if len(qsSite) > 0 then
			if isnumeric(qsSite) and userLevelRequired(userLevelPPlusStaff) then
				Placements.Site = getTempsCompCode(cint(qsSite))
			elseif len(qsSite) > 0 then
			
				Placements.Site = qsSite
			else
				Placements.Site = company_dsn_site
			end if
		else
			Placements.Site = qsSite
		end if

		
	with Placements
		.ItemsPerPage = 150
		.Page = Request.QueryString("WhichPage")
		' .Company = Request.QueryString("whichCompany")
		' .Customer = Request.QueryString("WhichCustomer")
		.Order = GetParameter("id")
		.Applicant = getApplicantIdFromUserId(user_id, Placements.Site)
		.FromDate = Request.QueryString("fromDate")
		.ToDate = Request.QueryString("toDate")
		.GetActiveEmployeePlacements()
	end with

	'init checked text string blob
	const checkedText = "checked=""checked"""

dim LastReference      : LastReference    = 0
dim LastDepartment     : LastDepartment   = 0
dim firstloop          : firstloop        = true
dim department_total   : department_total = 0



dim manage_customer_form
manage_customer_form = "/include/system/tools/manage/customer/?"

dim resourcelink
resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"

dim numberOfPlacements    : numberOfPlacements    = 0
dim previousCode          : previousCode          = ""
dim previousLastnameFirst : previousLastnameFirst = ""
dim objChangePlacement    : objChangePlacement    = ""			
dim strResponse           : strResponse           = ""
dim hasTimeOrExpense 
dim useThisLastnameFirst
dim multiplacement

dim Placement
for each Placement in Placements.Placements.Items
	' do while not ( rs.Eof Or rs.AbsolutePage <> nPage )
		' if rs.eof then
			' rs.Close
			' ' Clean up
			' ' Do the no results HTML here
			' response.write "No Items found."
			' ' Done
			' Response.End 
		' end if
		
		' chkSpace = instr(PStopDate, " ")
		' if chkSpace > 0 then
			' PStopDate = left(PStopDate, chkSpace - 1)
		' end if
		
		if previousCode <> Placement.CustomerCode then
			if previousCode <> "" then
				response.write group_footer
			end if
			
			response.write group_header
			
			previousCode = Placement.CustomerCode
		end if

		if Placement.HasTimeOrExpense then
			hasTimeOrExpense = ""
		else
			hasTimeOrExpense = " GreyOut"
		end if
		
		if Placement.lastnamefirst = previousLastnameFirst then
			numberOfPlacements = numberOfPlacements + 1
			useThisLastnameFirst = "<span class=""duplicateplacement"">&nbsp;</span>"
			multiplacement = " multiplacement"
		else
			useThisLastnameFirst  = Placement.lastnamefirst
			previousLastnameFirst = useThisLastnameFirst
			numberOfPlacements = 1
			multiplacement = ""
			
		end if
		%>

		<table class="etcdetails">
			<tr>
				<td class="lastnamefirst<%=hasTimeOrExpense%>"><div><div class="<%=multiplacement%>"><%=objShowMoreInternalPlacements(Placement.PlacementId, Placements.Site) & "<em><i>" & useThisLastnameFirst& "</i></em>"%></div></div></td>
				<td class="EmployeeNumber<%=hasTimeOrExpense%>"><div></div></td>
				<td class="JobNumber<%=hasTimeOrExpense%>"><%=Placement.Reference%></td>
				<td class="WCDescription<%=hasTimeOrExpense%>"><div><%=Placement.WCDescription%></div></td>
				<td class="StartDate<%=hasTimeOrExpense%>"><%=Placement.StartDate%></td>
				<td class="PStopDate<%=hasTimeOrExpense%>"><div><%=Placement.PStopDate%></div></td>
				<td class="WorkCode<%=hasTimeOrExpense%>"><%=Placement.WorkCode%></td>
				<% if show_paid then %>
				<td class="RegPayRate alignR<%=hasTimeOrExpense%>">$<%=Placement.RegPayRate%></td>
				<% end if %>
				<% if show_bill then %>
				<td class="RegBillRate alignR<%=hasTimeOrExpense%>">$<%=Placement.RegBillRate%></td>
				<% end if %>
				<td class="ExpenseSummary alignR<%=hasTimeOrExpense%>"><div><%=Placement.ExpenseSummary%></div></td>
				<td class="TimeSummary alignR<%=hasTimeOrExpense%>"><div><%=Placement.TimeSummary%></div></td>
				<td class="OkayApprove alignR">
					<input type="checkbox" class="TimeOkay" id="TimeOkay<%=Placement.PlacementId%>" onclick="timeokay.open('<%Placement.PlacementId%>', '<%Placements.Site%>')" />
				</td>
			</tr>
		</table>
		<!-- '"<td class=""Reference"">"  & "</td>" &_ -->
		<%=time_summary_div(Placement.PlacementId)%>
	
<%
next

Response.write group_footer

response.write "<!-- [split] -->" & Placements.Customer & Placements.Order
end sub
	

%>
