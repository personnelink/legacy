<%
session("add_css") = "./ledger.css"
session("required_user_level") = 256 'userLevelManager
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' //-->
<script type="text/javascript" src="ledger.js"></script>
<!-- #include file='ledger.doStuff.asp' //-->

<%

%>
<%=decorateTop("AccountActivity", "notToShort marLR10", "Recent Account Activity")%>
<form id="viewActivityForm" name="viewActivityForm" action="" method="post" class="left">
<input name="process_action" id="process_action" type="hidden" value="remember" />
<%=getPendingPayments%>

<div id="accountActivityDetail" class="pad0">

  <%

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
							
			%>
			<div class="apayment">
			<%=checkPendingPayments()%>
			</div>
			
						
			<div id="account_balance">
				<p id="accntbal">Account balance:<span class="bigger"><%=getAccountBalance(thisConnection)%></span></p>
				<a id="mkPayment" href="javascript:;" onclick="payment.show();">Make a payment</a>
			</div>
			<div id="make_payment" class="hide">
            <table id="paymentOptions">
                <tr class="hide">
                	<td id="paymentoptions" colspan="4">Payment Options<ul><li id="achopt">&nbsp;</li><li id="paypalopt"></td>
								</tr>                <tr>
                	<td id="billinginfo" colspan=4><span>Billing Information</span><br />Enter your check payment details below:</td>
                </tr>

								<tr>
									<td>
										<label id="routingLbl" style="float:left; clear:left" for="fromDate">Routing number: </label>					
                    <input name="routing" id="routing" type="text" value="<%=routing%>" onblur="payment.check(this)">
                  </td>
                   <td><label id="accountLbl" for="account" style="float:left; clear:left">Account number</label>
					 				<input name="account" id="account" type="text" value="<%=account%>" onblur="payment.check(this)">
                  </td>
                 <td><label id="docnumLbl" for="docnum" style="float:left; clear:left;">Document / Check #</label>
                 		<input name="docnum" id="docnum" type="text" value="<%=docnum%>">
                  </td>
                  <td><label id="amountLbl" for="amount" style="float:left; clear:left;">Amount</label>
                 		<input name="amount" id="amount" type="text" value="<%=amount%>" onblur="payment.check(this)">
                  </td>
                  </tr>
                <tr><td colspan="4" class="rememberpayment"><label><input name="remember_how" type="checkbox" value="remember" />Remember payment information</label></td></tr>

								<tr><td colspan="4"><div class="processpayment"> <a class="squarebutton" href="#" style="float:none" onclick="payment.process();">
								<span style="text-align:center"> Process payment </span></a> </div></td></tr>

                                  
              </table>				
			</div>

			<table id="accnt_heading" class="account_activity headings">
				<tr>
					<th class="ag">
						<input type="checkbox" name="ck_all" id="ck_all"  value="ck_all" onclick="change_all_boxes(this.checked);"/>
						</th>
					<th class="ah"></th>
					<th class="aa">Invoice</th>
					<th class="ab">Date</th>
					<th class="ac">Description</th>
					<th class="ad">Document</th>
					<th class="ae">Amount</th>
					<th class="af">Total</th>
				</tr>
			</table>
			
<%		
dim LastJobDescription : LastJobDescription = ""
dim firstloop : firstloop = true
dim department_total : department_total = 0

		for each Summary in AccountActivity.Summary.Items
			if LastJobDescription <> Summary.JobDescription then
				if not firstloop then
%>		
					<table class="account_activity departmenttotal">
						<tr>
							<td colspan="4"></td>
							<td class="cd">Department Total:</td>
							<td class="cf">&nbsp;$<%=TwoDecimals(department_total)%></td>
						</tr>
					</table>
<%
					department_total = 0
				end if
				firstloop = false
%>
				<table class="account_activity department">
					<tr>
						<td class="jobnumber"><%=Summary.JobNumber%></td>
						<td class="jobdescription"z><%=Summary.JobDescription%></td>
					</tr>
				</table>
<%
				LastJobDescription = Summary.JobDescription
			end if
		
			invoice_number = Summary.Invoice
			running_total = running_total + Summary.Total
			department_total = department_total + Summary.Total
			chk_box = "<input type=""checkbox"" name=""ck_boxes"" id=""ck_" &  row_number & """  value=""" & invoice_number & """ onclick=""setPayAmount();"">" &_
								"<input type=""hidden"" name=""inv_" & invoice_number & """ value=""" & itotal & """>"


			lnk_open = "<a href=""javascript:;"" onclick=""getInvoice.open('" & row_number & "', '" & invoice_number & "', '" & simsite & "', '" & simcust & "');"">"  
			
			if row_number MOD 2	= 0 then
				row_shade = " even"
			else
				row_shade = " odd"
			end if
%>
			<table id="row_<%=row_number%>_summary" class="account_activity<%=row_shade%>">
				<tr>
					<td class="cg"><%=chk_box%></td>
					<td class="ch" id="row_for_inv_<%=invoice_number%>"><%=lnk_open%><span class="plusexpand">&nbsp;</span><%=lnk_close%></td>
					<td class="ca"><%=Summary.HTMLInvoiceLink%></td>
					<td class="cb"><%=Summary.InvoiceDate%></td>
					<td class="cc"><%=Summary.Description%></td>
					<td class="cd"><%=Summary.Document%></td>
					<td class="ce">$<%=TwoDecimals(itotal)%></td>
					<td class="cf">$<%=TwoDecimals(running_total)%></td>
				</tr>
			</table>
				
			<div id="line_<%=row_number%>_detail" class="hide<%=row_shade%>">&nbsp;
				<input type="hidden" class="inv_chk" name="invoice<%=row_number%>" id="invoice<%=row_number%>" value="<%=invoice_number%>">
			</div>
<%
			row_number = row_number + 1
		next
%>
	<table class="account_activity departmenttotal">
		<tr>
			<td colspan="4"></td>
			<td class="cd">Department Total:</td>
			<td class="cf">&nbsp;$<%=TwoDecimals(department_total)%></td>
		</tr>
		<tr>
			<td colspan="4"></td>
			<td class="cd">Grand Total:</td>
			<td class="cf">&nbsp;$<%=TwoDecimals(running_total)%></td>
		</tr>
	</table>
	</div>
		<input type="hidden" name="how_many_invoices" id="how_many_invoices" value="<%=row_number%>">
				
<%
			Set AccountActivity = nothing
		end if
	end if
%>
</form>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
