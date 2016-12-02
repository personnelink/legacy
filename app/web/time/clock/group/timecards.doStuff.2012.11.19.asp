<%
dim Active
set Active = new cPlacements

dim perspective
	'ability to hide staff features for demo'ing
	'
	perspective = lcase(request.querystring("perspective"))


	dim qscust
	'querystring customerqscust = replace(request.QueryString("customer"), "'", "''")
	if len(qscust & "") > 0 and userLevelRequired(userLevelPPlusStaff) then
		Active.Customer = qscust
		qscust = "customer=" & qscust
	elseif (len(g_company_custcode.CustomerCode & "") > 0 and userLevelRequired(userLevelPPlusStaff)) or (len(g_company_custcode.CustomerCode & "") > 0 and 		userLevelRequired(userLevelSupervisor)) then
	Active.Customer = request.querystring("customer")
	qscust = "customer=" & g_company_custcode.CustomerCode
	else
		break "Account not associated and or Not Authorized, please contact 1 (877) 733-7300 or email accounts@personnel.com"
	end if

	dim qsSite
	'querystring site
	qsSite = request.QueryString("site")
	if len(qsSite) > 0 then
		if isnumeric(qsSite) and userLevelRequired(userLevelPPlusStaff) then
			Active.Site = getTempsCompCode(cint(qsSite))
		else
			Active.Site = company_dsn_site
		end if
	else
		Active.Site = qsSite
	end if

with Active
	.ItemsPerPage = 150
	.Page = Request.QueryString("WhichPage")
	' .Company = Request.QueryString("whichCompany")
	' .Customer = Request.QueryString("WhichCustomer")
	.Order = Request.QueryString("whichOrder")
	.Applicant = Request.QueryString("whichApplicant")
	.FromDate = Request.QueryString("fromDate")
	.ToDate = Request.QueryString("toDate")
	.GetActivePlacements()
end with

'init checked text string blob
const checkedText = "checked=""checked"""

dim phoneApplicant, phoneCustomer, phoneOrder, contactOrder, contactCustomer
dim applicantid, lastnameFirst, maintain_link, resourcelink

function main_header (CustomerCode, CustomerName, CustomerDept)
	dim qsActivityURL
	qsActivityURL = "" &_
		"?page_title=Activities&site=" &_
		Active.Site & "&" &_
		"act_when=all&WhichOrder=&fromDate=3%2F20%2F2011&toDate=3%2F25%2F2011&" &_
		"WhichPage=&WhichPage=&activity_0=1&activity_6=1&activity_4=1&activity_7=1&" &_
		"activity_13=1&activity_14=1&activity_15=1&activity_16=1" &_
		"&customer=" & CustomerCode
		
	dim strDepartment
	if CustomerDept = CustomerName then 
		strDepartment = ""
	else
		strDepartment = CustomerDep
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
	dim strPaidColumn : strPayColumn = ""
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

function objOpenClosePlacement(p_PlacementId, p_Status)
		dim strResponse : strResponse = ""
		if p_Status = "3" then
			strResponse = strResponse & "" &_
				"<span class=""ShowMore"" " &_
					"id=""TimeSummary" & p_PlacementId & """ " &_
					"onclick=""timesummary.open('" & p_PlacementId & "', '" & Active.Site & "')"">" &_
				"</span>" &_
				"<span class=""OpenPlacement"" " &_
					"id=""Placement" & p_PlacementId & """ " &_
					"onclick=""placement.open('" & p_PlacementId & "', '" & Active.Site & "')"">" &_
				"</span>"
		else
		 	 strResponse = strResponse &_
				"<span class=""ShowMore"" " &_
					"id=""TimeSummary" & p_PlacementId & """ " &_
					"onclick=""timesummary.open('" & p_PlacementId & "', '" & Active.Site & "')"">" &_
				"</span>" &_
				"<span class=""ClosePlacement"" " &_
					"id=""Placement" & p_PlacementId & """ " &_
					"onclick=""placement.close('" & p_PlacementId & "', '" & Active.Site & "')"">" &_
				"</span>"
		end if
		
		objOpenClosePlacement = strResponse
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
	time_summary_div = "<div class=""timesummarydiv"" id=""timesummarydiv" & PlacementId & """></div>"
end function

function group_footer ()
	group_footer = ""
end function

%>
