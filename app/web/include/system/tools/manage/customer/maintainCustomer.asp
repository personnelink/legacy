<%Option Explicit%>
<%
session("add_css") = "general.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #include file='customerDetails.vb' -->
<!-- #include virtual='/include/system/functions/customers.asp' -->
<!-- Revision Date: 3.25.2009 -->
<!-- Revised: 2.11.2009 -->
<script type="text/javascript" src="/include/js/createNewUser.js"></script>
<%
sub maintainCompanyForm

%>

<form name="maintain" method="post" action="<%=post_to%>?where=<%=where_friendly%>&cust=<%=cust%>">
  <!--<%=decorateTop("", "marLR10", "Maintain Customer")%> -->
  <div id="left_form">
    <div id="applicantMain">
		<h5>Customer Details</h5><%
		
		Response.write make_input("CustomerName", "Name", CustomerName, 1, "p")
		Response.write make_input("Address", "Address", Address, 2, "p")
		Response.write make_input("Cityline", "City line", Cityline, 3, "p")
		Response.write make_input("Contact", "City line", Contact, 4, "p")
		Response.write make_input("Phone", "Telephone", Phone, 6, "p")
		Response.write make_input("EmailAddress", "Email", EmailAddress, 7, "p")
		Response.write make_input("Fax", "Fax", Fax, 8, "p")
		Response.write make_input("DiscountType", "DiscountType", DiscountType, 9, "p")
		Response.write make_input("SalesCode", "SalesCode", SalesCode, 10, "p")
		Response.write make_input("SalesTaxExemptNo", "2nd Telephone Description", SalesTaxExemptNo, 11, "p")
		Response.write make_input("CreditLimit", "2nd Telephone Description", CreditLimit, 12, "p")
		Response.write make_input("PrintStatement", "2nd Telephone Description", PrintStatement, 13, "p")
		Response.write make_input("CustomerType", "2nd Telephone Description", CustomerType, 14, "p")
		Response.write make_input("InvoiceFormat", "2nd Telephone Description", InvoiceFormat, 15, "p")
		
		%>

      <script type="text/javascript"><!-- 
							document.maintain.lastnameFirst.focus()
								//--></script>
    <br />
	<div class="buttonwrapper"><%=updated%><a class="squarebutton" href="#" style="margin-left: 6px" onClick="document.maintain.action.value='update';document.maintain.submit();"><span> Update </span></a> </div>	</div>
    </div>
	<div id="right_form" >
		<div id="applicantDates" style="height:85px;">
			<table>
				<tr>
					<th>Customer Number</th>
					<td><%=CurrentCustomer.customerNumber%></td>
					<th>Status</th>
					<td><%=CurrentCustomer.status%></td>
				</tr>
				<tr>
					<th>Entry Date</th>
					<td><%=CurrentCustomer.entryDate%></td>
					<th>Available</th>
					<td><%=CurrentCustomer.availableDate%></td>
				</tr>
				<tr>
					<th>Last Assigned</th>
					<td><%=CurrentCustomer.lastAssigned%></td>
					<th>To</th>
					<td><%=CurrentCustomer.assignedTo%></td>
				</tr>
			</table>
		</div>
    	<div id="applicantActivities">
			<h5>Activities</h5>
			<div>
			<%'getActivities(ApplicantId)
			%>
			</div>
		</div>
	
	</div>
		  
	<div id="new_activity" class="buttonwrapper" style="float:left;">
		<a class="squarebutton" href="#" style="margin-left: 25px" onClick="document.maintain.action.value='new_activity';document.maintain.submit();"><span> New Activity </span></a> 
	</div>
	<div class="dialog-prompt">
		<span id="">
		<a class="squarebutton" href="#" onclick="manageSchedule();">Manage Schedules</a>
	</span>
	</div>
	<div id="tools" style="height:250px; width:47%; border:1px solid pink; float:left; margin-top:10px; margin-left:10px;">
	<a href="../customer/mSchedule/manageSchedule.html" onclick="javascript:void window.open('../customer/mSchedule/manageSchedule.html','1407022002343','width=550,height=500,toolbar=0,menubar=0,location=0,status=0,scrollbars=1,resizable=0,left=0,top=0');return false;"><span>&nbsp;Manage Schedules</span></a><img src=""></a>
	</div>
	<div id="applicantNotes">
		<label for="notes">Notes</label>
		<textarea name="notes" id="notes"><%=notes%></textarea>
	<div id="update_notes" class="buttonwrapper"><%=updated%><a class="squarebutton" href="#" style="margin-left: 6px" onClick="document.maintain.action.value='update_note';document.maintain.submit();"><span> Update </span></a> 
	</div>
	</div>
	<div style="clear:both">
  		<input class="hide" name="action" value="" type="hidden" />
	</div>
</form>
	<div style="clear:both"> </div>
<%
End Sub
%>
<!-- #INCLUDE VIRTUAL='include/core/pageFooter.asp' -->
<%
if Err.Number <>0 then
	Resonse.Write Err.Description
end if

%>
