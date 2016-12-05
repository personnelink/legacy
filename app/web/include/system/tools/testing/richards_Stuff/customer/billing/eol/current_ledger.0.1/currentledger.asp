<%
session("add_css") = "./currentledger.css"
session("required_user_level") = 1024 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' //-->
<script type="text/javascript" src="currentledger.js"></script>
<!-- #include file='currentledger.doStuff.asp' //-->

<%

%>
<%=decorateTop("AccountActivity", "notToShort marLR10", "Recent Account Activity")%>
<form id="viewActivityForm" name="viewActivityForm" action="" method="post" class="left">
<div id="accountActivityDetail" class="pad10">

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
			<div id="account_balance">
				<p id="accntbal">Account balance due:<span class="bigger"><%=getAccountBalance(thisConnection)%></span></p>
				<p id="mkPayment"><a href="javascript:;" onclick="payment.show();">Make a payment</a></p>
			</div>
			<div id="make_payment" class="hide">
            <table id="paymentOptions">
                <tr class="hide">
                	<td id="paymentoptions" colspan=4>Payment Options<ul><li id="achopt"&nbsp;</li><li id="paypalopt"></td>
								</tr>                <tr>
                	<td id="billinginfo" colspan=4><span>Billing Information</span><br />Enter your check payment details below:</td>
                </tr>

								<tr>
									<td>
										<label style="float:left; clear:left" for="fromDate">Routing number: </label>					
                    <input name="routing" id="routing" type="text" value="<%=routing%>">
                  </td>
                   <td><label for="account" style="float:left; clear:left">Account number</label>
					 				<input name="account" id="account" type="text" value="<%=account%>">
                  </td>
                 <td><label for="docnum" style="float:left; clear:left;">Document / Check #</label>
                 		<input name="docnum" id="docnum" type="text" value="<%=docnum%>">
                  </td>
                  <td><label for="amount" style="float:left; clear:left;">Amount</label>
                 		<input name="amount" id="amount" type="text" value="<%=amount%>">
                  </td>
                  </tr>
                <tr><td colspan="4" class="rememberpayment"><label><input name="remember_how" type="checkbox" value="remember" />Remember my payment information for next time.</label></td></tr>

								<tr><td colspan="4"><div class="processpayment"> <a class="squarebutton" href="#" style="float:none" onclick="javascript:document.viewActivityForm.submit();">
								<span style="text-align:center"> Process payment </span></a> </div></td></tr>

                                  
              </table>				
			</div>

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
						"<input type=""checkbox"" name=""ck_all"" id=""ck_all""  value=""ck_all"" onclick=""change_all_boxes(this.checked);""/>" &_
						"</th>" &_
					"<th class='aa'>Invoice</th>" &_
					"<th class='ab'>Date</th>" &_
					"<th class='ac'>Description</th>" &_
					"<th class='ad'>Document</th>" &_
					"<th class='ae'>Amount</th>" &_
					"<th class='af'>Total</th>"
							
			response.write "</tr></table>"
			
			Set AccountActivity = getAccountActivity_cmd.Execute	
			showAccountActivity AccountActivity
			

			Set AccountActivity = nothing
			Set getAccountActivity_cmd = Nothing
		end if
	end if
%>
</form>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
