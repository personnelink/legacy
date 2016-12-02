<%
session("add_css") = "./job_order.asp.css, .//include/system/tools/activity/reports/appointments/followAppointments.asp.css"
session("page_title") = "Job Orders - Personnel Plus"
session("no-au") = false
session("window_page_title") = "Job Orders - Personnel Plus"

%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="/include/functions/calendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="job_order.js"></script>
<script type="text/javascript" src="/include/system/tools/activity/reports/appointments/followAppointments.js"></script>
<style type="text/css">
    @import url("/include/functions/calendar/calendar-blue.css");
</style>
<!-- #include virtual='/include/system/tools/timecards/group/timecard.classes.asp' -->
<!-- #include file='job_order.doStuff.asp' -->
<div id="boxeffect1" class="box effect1" >
    <label id="lblSearchBox" for="searchbox"><em>Search</em>: Company Name, Code, Phone, email, Job Orders, etc.</label>
    <input id="searchbox" name="searchbox" type="text" onblur="company.clear(is);" onkeyup="company.lookup(is);" /><div id="CompanyLookUp"></div>
    <div id="download" ><a href="javascript:;">[download pdf]</a></div>
</div>
<div id="jobtabs"></div>
<div id="joborder" class="marLRB10">

    <!-- <div  class="notes" id="insuctions" style="float:right;wid:24em;margin:2em 3em"><p>Use is form  to submit work requests.</p><p>Once submitted, a work order will be dispatched to e nearest branch office for processing.</p> 

<p style="color:red"><i>In case of Fire-Police-Ambulance emergencies, DIAL 911.</i></p>

<p>You will receive an email wi e Work Order number and be contacted by a member of our team. If you have any questions, please <a href="/include/content/contact.asp" alt="Contact Us">contact us</a>.</p>
</div>-->

    <form name="frmJobOrder" id="frmJobOrder" method="post" onload="form.setup();">
	<fieldset id="tblJobOrder" id="companyinfo" class="effect1">
		 <legend style="margin: 0;">Job Details</legend>
			<label for="">Order Date</label><br>
				<input type="text" id="OrderDate" name="OrderDate"/><br>
			<label for="">Time Received</label><br>
				<input type="text" id="" name="" /><br>
			<label for="">New Client</label><br>
				<input type="text" id="" name="" />		<br>		
			<label for="">Office</label><br>
				<input type="text" id="Office" name="Office" /><br>
			<label for="Orders_Customer">Customer #</label><br>
				<input type="text" id="Orders_Customer" name="Orders_Customer" /><br>
			<label for="">Proposal Date</label> <br>
				 <input type="text" id="OrderDate" name="OrderDate" /><br>
			<label for="">Corporation</label><br>
				 <input type="text" id="" name="" /><br>
			<label for="Orders_OrderTakenBy">Taken By</label><br>
				<input type="text" id="Orders_OrderTakenBy" name="Orders_OrderTakenBy" /><br>
			<label for="">Department</label><br>
				<input type="text" id="JobNumber" name="JobNumber" /><br>
			<label for="">Reference</label><br>
				<input type="text" id="Reference" name="Reference" /><br>
			<label for="Customers_CustSetupDate">Setup Date</label><br>
				<input type="text" id="Customers_CustSetupDate" name="Customers_CustSetupDate" /><br>
			<label for="Customers_CustSetupBy">Setup By</label><br>
				<input type="text" id="Customers_CustSetupBy" name="Customers_CustSetupBy" /><br>
			<label for="">Reference</label><br>
				<input type="text" id="Reference" name="Reference" /><br>
	</fieldset>
	
	<br>
	<fieldset id="companyinfo" class="effect1">
		<legend style="margin: 0;">Company Info</legend>
			<label for="CustomerName">Company Name</label><br>
				<input id="CustomerName" name="CustomerName" type="text"><br>
			<label for="">Order Placer</label><br>
				<input type="text" id="" name="" /><br>
			<label for="Customers_Phone">Telephone #</label><br>
				<input type="text" id="Customers_Phone" name="Customers_Phone" /><br>
			<label for="Customers_EmailAddress">email</label><br>
				<input type="text" id="Customers_EmailAddress" name="Customers_EmailAddress" /><br>
			<label for="Customers_Fax">Fax #</label><br>
				 <input type="text" id="Customers_Fax" name="Customers_Fax" /><br>
			<label for="">Address</label><br>
				 <input type="text" id="" name="" /><br>
			<label for="">City, State, Zip</label><br>
				 <input type="text" id="" name="" /><br>
			<label for="">Directions to Work Site</label><br>
				 <input type="text" id="" name="" /><br>
			<label for="">Billing Address (if different)</label><br>
				 <input type="text" id="" name="" /><br>
			<input type="hidden" id="Site" name="Site" /><br>
                                <input type="hidden" id="Department" name="Department" />
                                <input type="hidden" id="" name="" />
                                <input type="hidden" id="" name="" />
                                <input type="hidden" id="" name="" />
                                <input type="hidden" id="" name="" />	 
	</fieldset>
	
	<br>
	<fieldset id="companyinfo" class="effect1">
                    <legend style="padding-left: 1em;">Credit Info</legend>
                            <label for="">Social Security Number of Business I.D.</label><br>
				<input type="text" name="" /><br>
			<label for="">Bank Reference</label><br>
				<input type="text" name="" /><br>
			<label for="">Supplier Reference</label><br>
				<input type="text" name="" /><br>
                            <label for="">Credit Checked</label><br>
				<input type="text" name="" /><br>
				<label>Yes, they're Approved, Not yet, Not Approved</label><br>
			<label for="">Credit Limit</label><br>
				<input type="text" name="" /><br>
			<label for="">Credit Comments</label><br>
				<input type="text" name="" /><br>
				<br>
	</fieldset>
	
	<br>
	<fieldset id="jobposting" class="effect1">
		<legend style="padding-left: 1em;">Job Posting Details</legend>
			<label for="OtherOrders_Def2">Description</label><br>
				<input type="text" id="OtherOrders_Def2" name="OtherOrders_Def2" /><br>
			<label for="OtherOrders_Def1">Details</label><br>
                                <textarea id="OtherOrders_Def1" name="OtherOrders_Def1"></textarea><br>
	</fieldset>
	
	<br>
	<fieldset id="businesstype" class="effect1">
		<legend style="padding-left: 1em;">Business Type</legend>
			<label for="">Type of Business</label><br>
				<input type="text" name="" />		<br>				
                            <label for="Customers_CustomerType">Customer Type</label><br>
				<input type="text" id="Customers_CustomerType" name="Customers_CustomerType" /><br>
                            <label for="">Bonding Required</label><br>
                                     <input type="text" name="" />        <br>
                            <label for="">Drivers License Required</label><br>
                                     <input type="text" name=""/>          <br>
                            <label for="">CDL Required</label><br>
				<input type="text" name="" /><br>
	</fieldset>
	
	<br>
	<fieldset id="orderdetails" class="effect1">
                  <legend style="padding-left: 1em;">Order Details</legend>
                  <label for="Startdrate">Start Date : <span id="Starate" name="Starate"></span></label><br>
                  <label for="">Job Order Description</label><br>
			<input type="text" id="JobDescription" name="JobDescription" /><br>
                  <label for="JobStatus">Time Received</label><br>
			<input type="text" id="TimeReceived" name="TimeReceived" readonly /><br><br>
                  <label for="TimeReceived">Status</label><br>
                            <select id="JobStatus" name="JobStatus"><br>
                                     <option value="0"><span style="color: blue;">No Assignments</span></option>
				<option value="1"><span style="color: blue;">Less Assignments an needed</span></option>
                                     <option value="3"><span style="color: green;">Enough Assignments</span></option>
                                     <option value="4"><span style="color: magenta;">Closed Job Order</span></option>
                                     <option value="2"><span style="color: blue;">Close/marked for deletion</span></option>
                            </select><br><br>
                  <label for="">Essential Functions (Duties and Actions)</label><br>
			<input type="text" name="" /><br>
                  <label for="">Job Order Description</label><br>
                            <input type="text" id="JobDescription" name="JobDescription" /><br>
                  <label for="">Memo</label><br>
                            <input type="text" id="Memo" name="Memo" /><br>
                  <label for="">Regular Hours</label><br>
			<input type="text" id="Orders_RegHours" name="Orders_RegHours" /><br>
                  <label for="">OT Hours</label> <br>
			<input type="text" id="Orders_Oours" name="Orders_Oours" /><br>
		<label for="Orders_RegTimePay">Regular Pay</label><br>
			<input type="text" id="Orders_RegTimePay" name="Orders_RegTimePay" /><br>
		<label for="">OT Hours</label><br>
			<input type="text" id="Orders_OTPay" name="Orders_OTPay" /><br>
	         <label for="">Skills Required</label><br>
			<input type="text" name="" /><br>
		<label for="">Dress</label><br>
			<input type="text" name="" /><br>
		<label for="">Dress Code</label><br>
			<input type="text" name="" /><br>
		<label for="">Tools Used</label><br>
			<input type="text" name="" /><br>
		<label for="">Tools Required</label><br>
                            <input type="text" name="" /><br>
                  <label for="">Physical Tasks</label><br>
			<input type="text" name="" /><br>
                  <label for="">Safety Equipment Required</label><br>
			<input type="text" name="" /><br>
                  <label for="">Repetitive Motion</label><br>
			<input type="text" name="" /><br>
		<label for="">Weight Lighting</label><br>
                           <input type="text" name="" /><br>
	</fieldset>
	
	<br>
	<fieldset id="orderdetails" class="effect1">
		<legend style="padding-left: 1em;">Billing Info</legend><br>
			<label for="">Billing Address</label><br>
				<input type="text" id="Orders_Bill1" name="Orders_Bill1" /><br>
                                     <input type="text" id="Orders_Bill2" name="Orders_Bill2" /><br>
				<input type="text" id="Orders_Bill3" name="Orders_Bill3" /><br>
                                     <input type="text" id="Orders_Bill4" name="Orders_Bill4" /><br>

                            <label for="T">Sales Tax Exempt Number</label><br>
				<input type="text" id="Customers_SalesTaxExemptNo" name="Customers_SalesTaxExemptNo" /><br>
                            <label for="TimeReceived">Sales Tax Exempt Number</label><br>
				<input type="text" id="Customers_InvoiceTaxExemptNo" name="Customers_InvoiceTaxExemptNo" /><br>
			<label for="Customers_SuspendService">Suspend Service</label><br>
				<input type="text" id="Customers_SuspendService" name="Customers_SuspendService" /><br>
	                  <label for=""></label><label for=""></label><br>
			<label for="Customers_ETimeCardStyle">Timecard Style</label><br>
				<input type="text" id="Customers_ETimeCardStyle" name="Customers_ETimeCardStyle" /><br>
        </fieldset>                       
                                    
         <br>
	<fieldset id="workcomp" class="effect1" style="width:70%;">
	<legend>Work Comp</legend>
                <table id="workcomp" class="effect1" style="width: 95%; margin:5px;">
                    <tr>
                        <th style="width:18%;">
                            <label for="">Work Code</label></th>
                        <th style="width:18%;">
                            <label for="">Pay Rate</label></th>
                        <th style="width:18%;">
                            <label for="">Bill Rate</label></th>
                        <th style="width:18%;">
                            <label for="">Required</label></th>

                    </tr>
                    <tr>
                        <td style="width:18%;">
                            <input type="text" id="WorkCode1" name="WorkCode1" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC1Pay" name="WC1Pay" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC1Bill" name="WC1Bill" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC1Required" name="WC1Required" /></td>
                    </tr>
                    <tr>
                        <th style="width:18%;">
                            <label for="">Work Code</label></th>
                        <th style="width:18%;">
                            <label for="">Pay Rate</label></th>
                        <th style="width:18%;">
                            <label for="">Bill Rate</label></th>
                        <th style="width:18%;">
                            <label for="">Required</label></th>

                    </tr>
                    <tr>
                        <td style="width:18%;">
                            <input type="text" id="WorkCode2" name="WorkCode2" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC2Pay" name="WC2Pay" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC2Bill" name="WC2Bill" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC2Required" name="WC2Required" /></td>
                    </tr>
                    <tr>
                        <th style="width:18%;">
                            <label for="">Work Code</label></th>
                        <th style="width:18%;">
                            <label for="">Pay Rate</label></th>
                        <th style="width:18%;">
                            <label for="">Bill Rate</label></th>
                        <th style="width:18%;">
                            <label for="">Required</label></th>

                    </tr>
                    <tr>
                        <td style="width:18%;">
                            <input type="text" id="WorkCode3" name="WorkCode3" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC3Pay" name="WC3Pay" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC3Bill" name="WC3Bill" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC3Required" name="WC3Required" /></td>
                    </tr>
                    <tr>
                        <th style="width:18%;">
                            <label for="">Work Code</label></th>
                        <th style="width:18%;">
                            <label for="">Pay Rate</label></th>
                        <th style="width:18%;">
                            <label for="">Bill Rate</label></th>
                        <th style="width:18%;">
                            <label for="">Required</label></th>

                    </tr>
                    <tr>
                        <td style="width:18%;">
                            <input type="text" id="WorkCode4" name="WorkCode4" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC4Pay" name="WC4Pay" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC4Bill" name="WC4Bill" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC4Required" name="WC4Required" /></td>
                    </tr>
                    <tr>
                        <th style="width:18%;">
                            <label for="">Work Code</label></th>
                        <th style="width:18%;">
                            <label for="">Pay Rate</label></th>
                        <th style="width:18%;">
                            <label for="">Bill Rate</label></th>
                        <th style="width:18%;">
                            <label for="">Required</label></th>

                    </tr>
                    <tr>
                        <td style="width:18%;">
                            <input type="text" id="WorkCode5" name="WorkCode5" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC5Pay" name="WC5Pay" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC5Bill" name="WC5Bill" /></td>
                        <td style="width:18%;">
                            <input type="text" id="WC5Required" name="WC5Required" /></td>
                    </tr>
                    <tr>
                        <th style="width:18%;">
                            <label for=""></label>
                        </th>
                        <th style="width:18%;">
                            <label for="">Other Pay</label></th>
                        <th style="width:18%;">
                            <label for="">Other Bill</label></th>
                        <th style="width:18%;">
                            <label for="">Other Required</label></th>

                    </tr>
                    <tr>
                        <td style="width:18%;"></td>
                        <td style="width:18%;">
                            <input type="text" id="OtherPay" name="OtherPay" /></td>
                        <td style="width:18%;">
                            <input type="text" id="OtherBill" name="OtherBill" /></td>
                        <td style="width:18%;">
                            <input type="text" id="OtherRequired" name="OtherRequired" /></td>
                    </tr>
		</table>
                   <!--<legend style="padding-left: 1em;">Work Comp</legend>                 
                            <label for="">Work Code</label>
				<input type="text" id="WorkCode1" name="WorkCode1" />
                            <label for="">Pay Rate</label>
				<input type="text" id="WC1Pay" name="WC1Pay" />
                            <label for="">Bill Rate</label>
				<input type="text" id="WC1Bill" name="WC1Bill" />
                            <label for="">Required</label>
				<input type="text" id="WC1Required" name="WC1Required" />
			<label for="">Work Code</label>
				<input type="text" id="WorkCode2" name="WorkCode2" />
                            <label for="">Pay Rate</label>
				<input type="text" id="WC2Pay" name="WC2Pay" />
                            <label for="">Bill Rate</label>
				<input type="text" id="WC2Bill" name="WC2Bill" />
                            <label for="">Required</label>
				<input type="text" id="WC2Required" name="WC2Required" />
                            <label for="">Work Code</label>
				<input type="text" id="WorkCode3" name="WorkCode3" />
                            <label for="">Pay Rate</label>
				<input type="text" id="WC3Pay" name="WC3Pay" />
                            <label for="">Bill Rate</label>
				<input type="text" id="WC3Bill" name="WC3Bill" />
                            <label for="">Required</label>
				<input type="text" id="WC3Required" name="WC3Required" />
			<label for="">Work Code</label>
				<input type="text" id="WorkCode4" name="WorkCode4" />                    
			<label for="">Pay Rate</label>                        
				<input type="text" id="WC4Pay" name="WC4Pay" />                            
			<label for="">Bill Rate</label>                        
				<input type="text" id="WC4Bill" name="WC4Bill" />                           
			<label for="">Required</label>                        
				<input type="text" id="WC4Required" name="WC4Required" />                            
                            <label for="">Work Code</label>
				<input type="text" id="WorkCode5" name="WorkCode5" />                        
                            <label for="">Pay Rate</label>
				<input type="text" id="WC5Pay" name="WC5Pay" />
                            <label for="">Bill Rate</label>
				<input type="text" id="WC5Bill" name="WC5Bill" />
                            <label for="">Required</label>
				<input type="text" id="WC5Required" name="WC5Required" />
                            <label for=""></label>
                            <label for="">Other Pay</label>
				<input type="text" id="OtherPay" name="OtherPay" />
                            <label for="">Other Bill</label>
				<input type="text" id="OtherBill" name="OtherBill"/>                  
                            <label for="">Other Required</label>
				<input type="text" id="OtherRequired" name="OtherRequired" />-->
	</fieldset>
	<fieldset  id="SafetyEquip" class="effect1">
			<legend>Safety Equipment Required</legend>	<br>
				<label for="">Safety Clothing<input type="checkbox" name="" /></label>
				<label for="">Hardhat<input type="checkbox" name="" /></label>
				<label for="">Eye Protection<input type="checkbox" name="" /></label>
				<label for="">Hearing Protection<input type="checkbox" name="" /></label>
	</fieldset>
	
	<br>
	<fieldset  id="instructions" class="effect1" style="width:70%; margin:10px;">
		<legend style="padding-left: 1em;">Comments</legend>
                            <label for="">Comments / Special Instructions</label>            <br>           
				<input type="text" name="" /><br>
	</fieldset>
	
	<br>
	<fieldset id="chronicle" class="effect1" style="width:70%; margin:10px;">
		<legend>Date and Time Info</legend>
			<label for="Startdate">Start Date</label><br>
				<input type="text" id="Orders_Starate" name="Orders_Starate" /><br>
                            <label for="StopDate">End Date</label><br>
				<input type="text" id="Orders_StopDate" name="Orders_StopDate" /><br>
                            <label for="ReportTo ">Report To</label><br>
				<input type="text" id="Orders_ReportTo" name="Orders_ReportTo" /><br>
			<label for="">Work Hours</label><br>
				<input type="text" id="" name="" /><br>
			<label for="Orders_StartTime">Time to Report</label><br>
				<input type="text" id="Orders_StartTime" name="Orders_StartTime" /><br>
                            <label for="Orders_StopTime">End Time</label><br>
				<input type="text" id="Orders_StopTime" name="Orders_StopTime" /><br>
         </fieldset>          
                        
         <br>
	<fieldset id="rates" class="effect1" style="width:30%; margin:10px;">
		    <legend style="padding-left: 1em;">Rate Info</legend>
                            <label for="">Pay Rate<input type="text" id="" name="" style="width:70%;float:right;"/></label>
				
                            <label for="CustomerRates_RegBill">Bill Rate<input type="text" id="CustomerRates_RegBill" name="CustomerRates_RegBill" style="width:70%;float:right;"/></label>
				
                            <label for="">Multiplier<input type="text" id="" name="" style="width:70%;float:right;"/></label>
				
			<label for="CustomerRates_RegPay">Pay Rate<input type="text" id="CustomerRates_RegPay" name="CustomerRates_RegPay" style="width:70%;float:right;"/></label>
                       
                            <label for="CustomerRates_OtBill">OT Bill <input type="text" id="CustomerRates_OtBill" name="CustomerRates_OtBill" style="width:70%;float:right;"/></label>
                    
                            <label for="">Multiplier<input type="text" id="" name="" style="width:70%;float:right;"/></label>

			<label for="CustomerRates_Comment">Rates Comments<input type="text" id="CustomerRates_Comment" name="CustomerRates_Comment" /></label><br>
				
        </fieldset>     

	<br>		
         <fieldset id="servicecalls" class="effect1" style="width:70%; margin:10px;">
                <legend style="padding-left: 1em;">Service Calls</legend>
			<label for="">Customer Service Calls / Date (used to create appointments)</label><br>
				<input type="text" name="" />
         </fieldset>
		 
	<br>
	<fieldset id="placements" class="effect1" style="width:70%; margin:10px;">
                <legend style="padding-left: 1em;">Placements</legend>

					<label for="">Start Date</label><input type="text" name="" />
					<label for="">End Date</label><input type="text" name="" />
			
			<br>
			<label for="">Name</label><br> <input type="text" name="" /><br>
			<label for="">Telephone or Message</label><br><input type="text" name="" /><br>
			<label for="">Pay Rate</label><br><input type="text" name=""/><br>
			<label for="">Pay Rate</label><br><input type="text" name="" /><br>
			<label for="">Pay Rate</label><br><input type="text" name="" /><br>
			<label for="">Weekly Service Calls</label><br><input type="text" name="" /><br>
	</fieldset>
	<fieldset id="orderactivities" class="effect1" style="width:70%; margin:10px;">	
								  
		<!--<legend>
		<div id="orderactivities"></div>
		</legend>-->
	</fieldset>
    </form>
</div>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
