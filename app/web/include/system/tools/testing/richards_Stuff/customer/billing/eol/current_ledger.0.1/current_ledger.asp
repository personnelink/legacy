<%
session("add_css") = "./current_ledger.asp.css"
session("required_user_level") = 1024 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="current_ledger.js"></script>
<!-- Created: 12.15.2008 -->
<%

'if len(session("insertInfo")) > 0 then
'	response.write(decorateTop("doneInsertingApp", "marLR10", "Applicants Attachments"))
'	response.write(session("insertInfo"))
'	response.write(decorateBottom())
'	session("insertInfo") = ""
'end if

dim fromDate, toDate
fromDate = request.form("fromDate") 
if len(fromDate & "") = 0 then fromDate = Date() - 90 
toDate = request.form("toDate") 
if len(toDate & "") = 0 then toDate = Date()
%>
<%=decorateTop("AccountActivity", "notToShort marLR10", "Recent Account Activity")%>
<div id="accountActivityDetail" class="pad10">

<form id="viewActivityForm" name="viewActivityForm" action="" method="post" class="oneHalf left">
 <table id="formOptions"><tr><td>
      <label style="float:left; clear:left" for="fromDate">From </label>
      <input  style="float:left; clear:left" name="fromDate" id="fromDate" type="text" value="<%=fromDate%>">
</td><td>
	<label for="toDate" style="float:left; clear:left">To </label>
	<input name="toDate" id="toDate" type="text" value="<%=toDate%>">
</td><td>
	
<div class="changeView">
<a class="squarebutton" href="#" style="float:none" onclick="javascript:document.viewActivityForm.submit();"><span style="text-align:center"> Search </span></a>
</div></td></tr>

</table>

  <%

	dim whichCompany, linkInvoice, simcust, simsite, this_customer

	simcust = replace(request.QueryString("simulate_customer"), "'", "''")
	if len(simcust & "") > 0 and userLevelRequired(userLevelPPlusStaff) then
		whichCompanyID = "((ARSummary.Customer)='" & simcust & "') AND "
		this_customer = simcust
		simcust = "cust=" & simcust
	elseif (len(g_company_custcode.CustomerCode & "") > 0 and userLevelRequired(userLevelPPlusStaff)) or (len(g_company_custcode.CustomerCode & "") > 0 and userLevelRequired(userLevelManager)) then
		whichCompanyID = "((ARSummary.Customer)='" & g_company_custcode.CustomerCode & "') AND "
		this_customer = g_company_custcode.CustomerCode
		simcust = "cust=" & g_company_custcode.CustomerCode
	else
	
		break g_company_custcode.CustomerCode
		print "SELECT ARActivity.Oldest, ARActivity.Balance, ARActivity.Customer FROM ARActivity WHERE ARActivity.Customer=""ZIONSB"";"
	end if
	
	simsite = request.QueryString("simulate_site")
	if isnumeric(simsite) and userLevelRequired(userLevelPPlusStaff) then

		simsite = cint(simsite)
	else
		simsite = company_dsn_site
	end if
	
	if company_dsn_site > -1 or simsite <> "" then
		
		if simsite <> "" and simsite > -1 then
			thisConnection = dsnLessTemps(simsite)
			simcust = "where=" & simcust
		elseif company_dsn_site > 0 then
			thisConnection = dsnLessTemps(company_dsn_site)
			simcust = "cust=" & company_dsn_site
		end if
		'if len(this_customer) = 0 then
		'	if not userLevelRequired(userLevelPPlusStaff) then
		'		thisConnections
		
		if len(thisConnection) > 0 then 
			set getAccntBalance_cmd = Server.CreateObject("ADODB.Command")
			with getAccntBalance_cmd
				.ActiveConnection = thisConnection
				'.CommandText = "SELECT ARActivity.Oldest, ARActivity.Balance, ARActivity.Customer FROM ARActivity WHERE ARActivity.Customer=""ZIONSB"";"
				.CommandText = "SELECT ARActivity.Oldest, ARActivity.Balance, ARActivity.Customer " &_
					"FROM ARActivity " &_
					"WHERE ARActivity.Customer=""" & ucase(this_customer) & """;"
				'break getAccntBalance_cmd.CommandText
				.Prepared = true
			end with
			'break getAccntBalance_cmd.CommandText
			set AccountBalance = getAccntBalance_cmd.Execute
			
			dim account_balance
		if not AccountBalance.eof then
				account_balance = "  $" & TwoDecimals(AccountBalance("Balance")}
			else
				account_balance = "  <i>Unavailable ... </i>"
			end if
						
			%>
			<div id="account_balance">
				<p id="accntbal">Account balance due:<span class="bigger"><%=account_balance%></span></p>
				<p id="mkPayment"><a href="javascript:;" onclick="show_payment();">Make a Payment</a></p>
			</div>
			<div id="make_payment" class="hide">
            <table id="paymentOptions">
                <tr>
                                    <td id="billinginfo" colspan=4><span>Billing Information</span><br />Enter your payment details below.</td>
				</tr>
                <tr>
                                    <td id="paymentoptions" colspan=4>Payment Options<ul><li id="achopt"&nbsp;</li><li id="paypalopt"></td>
				</tr>
       			
				<tr><td><label style="float:left; clear:left" for="fromDate">Routing number: </label>					
                    <input name="todata" id="todata" type="text" value="<%=todata%>">
                  </td>
                   <td><label for="toDate" style="float:left; clear:left">Account number</label>
					 <input name="fromdata" id="fromdata" type="text" value="<%=fromdata%>">
                  </td>
                 <td>
				<label for="toDate" style="float:left; clear:left;">Amount</label>
				<input name="amount" id="amount" type="text" value="<%=amount%>">
                  </td>
					<td><div class="changeView"> <a class="squarebutton" href="#" style="float:none" onclick="javascript:document.viewActivityForm.submit();"><span style="text-align:center"> Pay </span></a> </div></td>
                                  </tr>
              </table>				
			</div>
						
			
</form>
                                <%		
			Set getAccountActivity_cmd = Server.CreateObject ("ADODB.Command")
			With getAccountActivity_cmd
				.ActiveConnection = thisConnection
				.CommandText = "SELECT ARSummary.Invoice, ARSummary.InvoiceDate, " &_
					"ARCustomers.Contact, ARDetail.Amount, " &_
					"ARDetail.PostingDate, ARSummary.Total, ARDetail.Document, ARDetail.Description " &_
					"FROM ((ARSummary ARSummary LEFT OUTER JOIN ARCustomers ARCustomers ON ARSummary.Customer=ARCustomers.Customer) " &_
					"LEFT OUTER JOIN ARDetail ARDetail ON ARSummary.SummaryId=ARDetail.SummaryId) " &_
					"LEFT OUTER JOIN ArTerms ArTerms ON ARCustomers.TermsCode=ArTerms.TermsCode " &_
					"WHERE " & whichCompanyID & " ((ARSummary.InvoiceDate)>=#" & fromDate & "# And (ARSummary.InvoiceDate)<=#" & toDate & "#) AND ARSummary.InHistory=FALSE " &_
					"ORDER BY ARSummary.Customer, ARSummary.Invoice"
	
					'"ORDER BY HistoryDetail.WorkDate DESC;"
				.Prepared = true
			End With
			
			'Response.write getAccountActivity_cmd.CommandText
			'Response.End()
			Response.write "<table id=""accnt_heading"" class=""account_activity headings""><tr>" &_
					"<th class='ag'>" &_
						"<input type=""checkbox"" name=""ck_all"" id=""ck_all""  value=""ck_all"" onclick=""ck_all();""/>" &_
						"</th>" &_
					"<th class='aa'>Invoice</th>" &_
					"<th class='ab'>Date</th>" &_
					"<th class='ac'>Description</th>" &_
					"<th class='ad'>Document</th>" &_
					"<th class='ae'>Amount</th>" &_
					"<th class='af'>Total</th>"
							
			response.write "</tr></table>"
			
			Set AccountActivity = getAccountActivity_cmd.Execute	
				
			dim lnk_open, lnk_close	, chk_box
			dim running_total, itotal, row_number, invoice_number
			dim row_shade
			row_number = 0
			do while not AccountActivity.eof
				chk_box = "<input type=""checkbox"" name=""ck_" & row_number & """ id=""ck_" &  row_number & """  value=""" & invoice_number & """ />"
				invoice_number = AccountActivity.Fields.Item("Invoice")
				itotal = AccountActivity.Fields.Item("Total")
				running_total = running_total + itotal
	
				lnk_open = "<a href=""javascript:;"" onclick=""getInvoice('" & row_number & "', '" & invoice_number & "', '" & simsite & "', '" & simcust & "');"">"  
				lnk_close = "</a>"
				if row_number MOD 2	= 0 then
					row_shade = " even"
				else
					row_shade = " odd"
				end if
				
			response.write "<div id=""line_" & row_number & "_detail"" class=""hide" & row_shade & """>&nbsp;<input type=""hidden"" class=""inv_chk"" name=""invoice" & row_number & """ id=""invoice" & row_number &""" value=""" & invoice_number & """></div>"
			Response.write "<table id=""row_" & row_number & "_summary"" class=""account_activity" & row_shade & """><tr>"
					Response.write "<td class='cg'>" & chk_box & "</td>"
					Response.write "<td class='ca'>" & lnk_open & invoice_number & lnk_close & "</td>"
					Response.write "<td class='cb'>" & AccountActivity.Fields.Item("InvoiceDate") & "</td>"
					Response.write "<td class='cc'>" & AccountActivity.Fields.Item("Description") & "</td>"
					Response.write "<td class='cd'>" & AccountActivity.Fields.Item("Document") & "</td>"
					Response.write "<td class='ce'>$" & TwoDecimals(itotal) & "</td>"
					Response.write "<td class='cf'>$" & TwoDecimals(running_total) & "</td>"
				Response.write "</tr></table>" &_
					"<table class=""account_activity"">"
					
				row_number = row_number + 1
				AccountActivity.MoveNext
			loop
					Response.write "<tr>"
					Response.write "<td colspan='4'></td>"
					Response.write "<td class='cd'>TOTAL</td>"
					Response.write "<td class='cf'>$" & TwoDecimals(running_total) & "</td>"
				Response.write "</tr></table>" &_
					"<table class=""account_activity"">"
					
	
			Response.write "</table></div>"
	
			Response.write "<input type=""hidden"" name=""how_many_invoices"" id=""how_many_invoices"" value=""" & row_number & """>"
			Set AccountActivity = nothing
			Set getAccountActivity_cmd = Nothing
		end if
	end if
%>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
