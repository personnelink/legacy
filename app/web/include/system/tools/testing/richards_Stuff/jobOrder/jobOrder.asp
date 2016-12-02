<%
session("add_css") = "jobOrder.css"
session("page_title") = "Job Orders - Personnel Plus"
session("no-au") = false
session("window_page_title") = "Job Orders - Personnel Plus"
%>
<!-- #INCLUDE file='init_secure_session.asp' -->

<script type="text/javascript" src="/include/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="/include/functions/calendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="job_order.js"></script>
<script type="text/javascript" src="/include/system/tools/activity/reports/appointments/followAppointments.js"></script>
<style type="text/css">
    @import url("css/master.css");
	@import url("css/global.css");
	@import url("jobOrder.css");
</style>

	<fieldset id="searchBox" name="searchbox" class="effect1" style="width:95%; margin:auto;">
		<legend style="margin: 0;"><em>Search</em></legend>
			<label id="lblSearchBox" for="searchbox"style="margin-left:10px;" >Company Name, Code, Phone, email, Job Orders, etc.</label><br><br><br>
			<input id="searchbox" name="searchbox" type="text" onblur="company.clear(is);" onkeyup="company.lookup(is);" style="margin-left:10px;"/><br><br>		
			<a href="javascript:;">[download pdf]</a><br><br>
	</fieldset>
<div class="smForm">
	<div id="jobtabs"></div>
	<div id="joborder" class="marLRB10">
	<form id="smallForm" name="smallForm" method="post" onload="form.setup();">
	<fieldset id="jobdetails" name="jobdetails" class="effect1">
		<legend style="margin: 0;">Job Details</legend>
			<label class="threeCol" for="">Order Date</label>
			<label class="threeCol" for="">Time Received</label>
			<label class="threeCol" for="">New Client</label>
				<input class="threeCol" type="text" id="OrderDate" name="OrderDate" />
				<input class="threeCol" type="text" id="TimeReceived" name="TimeReceived" />
				<input class="threeCol" type="text" id="" name="" />
			<br>
			<br>
			<label class="threeCol" for="">Office</label>
			<label class="threeCol" for="Orders_Customer">Customer #</label>
			<label class="threeCol" for="">Proposal Date</label>
				<input class="threeCol" type="text" id="Office" name="Office" />
				<input class="threeCol" type="text" id="Orders_Customer" name="Orders_Customer" />
				<input class="threeCol" type="text" id="OrderDate" name="OrderDate" />
			<br>
			<br>
			<label class="threeCol" for="">Corporation</label>
			<label class="threeCol" for="Orders_OrderTakenBy">Taken By</label>
			<label class="threeCol" for="">Department</label>			
				<input class="threeCol" type="text" id="" name="" />
				<input class="threeCol" type="text" id="Orders_OrderTakenBy" name="Orders_OrderTakenBy" />
				<input class="threeCol" type="text" id="JobNumber" name="JobNumber" />
			<br>
			<br>
			<br>
			<label class="twoCol" for="">Reference</label><br>
				<input class="twoCol" type="text" id="Reference" name="Reference" />
			<br>
			<br>
			<br>
			<br>
			<label class="twoCol" for="Customers_CustSetupDate">Setup Date</label>
				<input class="oneCol" type="text" id="Customers_CustSetupDate" name="Customers_CustSetupDate" />
			<br>
			<label class="twoCol" for="Customers_CustSetupBy">Setup By</label><br>
				<input class="oneCol" type="text" id="Customers_CustSetupBy" name="Customers_CustSetupBy" />
			
	</fieldset>
	<br>
	<fieldset id="companyinfo" class="effect1">
		<legend style="margin: 0;">Company Info</legend>
			<label class="threeCol" for="CustomerName">Company Name</label>
			<label class="threeCol" for="">Order Placer</label>
			<label class="threeCol" for="Customers_Phone">Telephone #</label><br><br><br>
				<input class="threeCol" id="CustomerName" name="CustomerName" type="text">
				<input class="threeCol" type="text" id="" name="" />
				<input class="threeCol" type="text" id="Customers_Phone" name="Customers_Phone" />
			<br>
			<br>
			<label class="threeCol" for="Customers_EmailAddress">email</label>
			<label class="threeCol" for="Customers_Fax">Fax #</label>
			<label class="threeCol" for="">Address</label>
				<input class="threeCol" type="text" id="Customers_EmailAddress" name="Customers_EmailAddress" />
				<input class="threeCol" type="text" id="Customers_Fax" name="Customers_Fax" />
				<input class="threeCol" type="text" id="" name="" />
			<br>
			<br>
			<label class="oneCol" for="">City, State, Zip</label>
				<input class="oneCol" type="text" id="" name="" style="height:30px"/>
			<br>
			<br>
			<label class="oneCol" for="">Directions to Work Site</label>
				<input class="oneCol" type="text" id="" name="" style="height:30px"/>
			<br>
			<br>
			<label class="oneCol" for="">Billing Address (if different)</label>
				 <input class="oneCol" type="text" id="" name="" style="height:30px"/><br>
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
            <label class="threeCol" for="">EIN of Business I.D.</label>
			<label class="threeCol" for="">Bank Reference</label>
			<label class="threeCol" for="">Supplier Reference</label>
			<br>	
			<br>
				<input class="threeCol" type="text" name="" />
				<input class="threeCol" type="text" name="" />
				<input class="threeCol" type="text" name="" />
			<br>	
			<label class="twoCol" for="">Credit Checked</label>
				<input class="oneCol" type="text" name="" style="height:30px" />
			<label class="gray" style="width:80%; margin:auto;">Yes, they're Approved, Not yet, Not Approved</label>
			<br>
			<br>
			<br>
			<label class="oneCol"  for="">Credit Limit</label>
				<input class="twoCol"  type="text" name="" />
			<br>	
			<br>
			<br>
			<br>
			<br>
			<label class="oneCol"  for="">Credit Comments</label>		
				<input class="oneCol"  type="text" name="" style="height:30px"/><br>
	</fieldset>
	<br>
	<fieldset id="jobposting" class="effect1">
		<legend style="padding-left: 1em;">Job Posting Details</legend><br>
			<label class="oneCol" for="OtherOrders_Def2">Description</label>
				<input class="oneCol" type="text" id="OtherOrders_Def2" name="OtherOrders_Def2" />
			<label class="oneCol" for="OtherOrders_Def1">Details</label>
        <textarea class="oneCol" id="OtherOrders_Def1" name="OtherOrders_Def1"></textarea><br><br>
	</fieldset>
	<br>
	<fieldset id="businesstype" class="effect1">
		<legend style="padding-left: 1em;">Business Type</legend>
			<label class="twoCol" for="">Type of Business</label><br>
				<input class="oneCol" type="text" name="" style="height:22px"/>				
            <label class="threeCol" for="Customers_CustomerType">Customer Type</label>
			<label class="threeCol" for="">Bonding Required</label>
			<label class="threeCol" for="">Drivers License Required</label>
				<input class="threeCol" type="text" id="Customers_CustomerType" name="Customers_CustomerType"/>
				<input class="threeCol" type="text" name="" />
				<input class="threeCol" type="text" name=""/> 
			<br>
            <br>
            <label class="oneCol" for="">CDL Required</label><br>
				<input class="oneCol" type="text" name="" /><br>
	</fieldset>
	<br>
	<fieldset id="orderdetails" class="effect1">
        <legend style="padding-left: 1em;">Order Details</legend>
			<label class="twoCol" for="Startdate">Start Date:<span id="Startdate" name="Startdate"></span></label><br><br>
			<label class="oneCol" for="">Job Order Description</label>
				<input class="oneCol" type="text" id="JobDescription" name="JobDescription" style="height:30px"/>
			<br>
			<label class="oneCol" for="JobStatus">Time Received</label><br>
				<input class="twoCol" type="text" id="TimeReceived" name="TimeReceived" readonly />
			<br>
			<br>
			<br>
			<label class="twoCol" for="TimeReceived">Status</label>
			<select class="oneCol" id="JobStatus" name="JobStatus">
                <option value="0"><span style="color: blue;">No Assignments</span></option>
				<option value="1"><span style="color: blue;">Less Assignments an needed</span></option>
                <option value="3"><span style="color: green;">Enough Assignments</span></option>
                <option value="4"><span style="color: magenta;">Closed Job Order</span></option>
                <option value="2"><span style="color: blue;">Close/marked for deletion</span></option>
            </select>
		<br>
		<br>
        <label class="oneCol" for="">Essential Functions (Duties and Actions)</label>
		<br>
			<input class="oneCol" type="text" id="Essentials" name="Essentials" style="height:30px"/>
		<br>
		<br>
		<br>
		<br>
		<label class="oneCol" for="">Job Order Description</label>
			<input class="oneCol" type="text" id="JobDescription" name="JobDescription"  style="height:30px"/>
		<label class="oneCol" for="">Memo</label>
			<input class="oneCol" type="text" id="Memo" name="Memo" />
		<label class="twoCol" for="" style="width:30%">Regular Hours</label>
		<label class="twoCol" for="" style="width:30%">OT Hours</label>
			<input class="twoCol" type="text" id="Orders_RegHours" name="Orders_RegHours" style="margin-left:25px"/>
			<input class="twoCol" type="text" id="Orders_OTHours" name="Orders_OTHours" style="margin-left:5px" />
		<br>	
        <label class="twoCol" for="Orders_RegTimePay" style="width:30%">Regular Pay</label>
		<label class="twoCol" for="" style="width:30%">OT Hours</label>
			<input class="twoCol" type="text" id="Orders_RegTimePay" name="Orders_RegTimePay" style="margin-left:25px"/>
			<input class="twoCol" type="text" id="Orders_OTPay" name="Orders_OTPay" style="margin-left:5px"/>
	    <label class="oneCol" for="">Skills Required</label>
			<input class="oneCol" type="text" name="" style="height:30px"/>
		<br>
		<label class="fourCol" for="">Dress</label>
		<label class="fourCol" for="">Dress Code</label>
		<label class="fourCol" for="">Tools Used</label>
		<label class="fourCol" for="">Tools Required</label>
			<input class="fourCol" type="text" name="" />
			<input class="fourCol" type="text" name="" />
			<input class="fourCol" type="text" name="" />
			<input class="fourCol" type="text" name="" />
		<br>
		<br>
        <br>
        <label class="fourCol" for="">Physical Tasks</label>
		<label class="fourCol" for="">Safety Equip. Req.</label>
		<label class="fourCol" for="">Repetitive Motion</label>
		<label class="fourCol" for="">Weight Lighting</label>
			<input class="fourCol" type="text" name="" />
       		<input class="fourCol" type="text" name="" />
       		<input class="fourCol" type="text" name="" />
		    <input class="fourCol" type="text" name="" />
	</fieldset>
	<br>
	<fieldset id="orderdetails" class="effect1">
		<legend style="padding-left: 1em;">Billing Info</legend><br>
			<label for="">Billing Address</label><br><br>
				<input type="text" id="Orders_Bill1" name="Orders_Bill1" />
                <input type="text" id="Orders_Bill2" name="Orders_Bill2" /><br>
				<input type="text" id="Orders_Bill3" name="Orders_Bill3" />
                <input type="text" id="Orders_Bill4" name="Orders_Bill4" /><br>
			<label for="T">Sales Tax Exempt Number</label>
				<input type="text" id="Customers_SalesTaxExemptNo" name="Customers_SalesTaxExemptNo" style="margin-left:10px;"/>
            <label for="TimeReceived">Sales Tax Exempt Number</label><br>
				<input type="text" id="Customers_InvoiceTaxExemptNo" name="Customers_InvoiceTaxExemptNo" style="margin-left:10px;"/><br>
			<label for="Customers_SuspendService" style="margin-left:55px;">Suspend Service</label>
				<input type="text" id="Customers_SuspendService" name="Customers_SuspendService" style="margin-left:10px;"/><br>
			<label for="Customers_ETimeCardStyle" style="margin-left:63px;">Timecard Style</label>
				<input type="text" id="Customers_ETimeCardStyle" name="Customers_ETimeCardStyle" style="margin-left:10px;"/><br>
    </fieldset>                       
    <br>
	<fieldset id="workcomp" class="effect1">
		<legend>Work Comp</legend>
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for="">Required</label>
				<input class="fourCol" type="text" id="WorkCode1" name="WorkCode1" />
                <input class="fourCol" type="text" id="WC1Pay" name="WC1Pay" />
                <input class="fourCol" type="text" id="WC1Bill" name="WC1Bill" />
                <input class="fourCol" type="text" id="WC1Required" name="WC1Required" />
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for="">Required</label>
                <input class="fourCol" type="text" id="WorkCode2" name="WorkCode2" />
                <input class="fourCol" type="text" id="WC2Pay" name="WC2Pay" />
                <input class="fourCol" type="text" id="WC2Bill" name="WC2Bill" />
                <input class="fourCol" type="text" id="WC2Required" name="WC2Required" />
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for="">Required</label>
                <input class="fourCol" type="text" id="WorkCode3" name="WorkCode3" />
                <input class="fourCol" type="text" id="WC3Pay" name="WC3Pay" />
                <input class="fourCol" type="text" id="WC3Bill" name="WC3Bill" />
                <input class="fourCol" type="text" id="WC3Required" name="WC3Required" />
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for="">Required</label>
                <input class="fourCol" type="text" id="WorkCode4" name="WorkCode4" />
                <input class="fourCol" type="text" id="WC4Pay" name="WC4Pay" />
                <input class="fourCol" type="text" id="WC4Bill" name="WC4Bill" />
                <input class="fourCol" type="text" id="WC4Required" name="WC4Required" />
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for="">Required</label>
                <input class="fourCol" type="text" id="WorkCode5" name="WorkCode5" />
                <input class="fourCol" type="text" id="WC5Pay" name="WC5Pay" />
                <input class="fourCol" type="text" id="WC5Bill" name="WC5Bill" />
                <input class="fourCol" type="text" id="WC5Required" name="WC5Required" />
            <label class="fourCol" for=""></label>
            <label class="fourCol" for="">Other Pay</label>
            <label class="fourCol" for="">Other Bill</label>
            <label class="fourCol" for="">Other Required</label>
				<label class="fourCol" type="text" id="blank" name="blank" style="display:hidden"></label>
                <input class="fourCol" type="text" id="OtherPay" name="OtherPay" />
                <input class="fourCol" type="text" id="OtherBill" name="OtherBill" />
                <input class="fourCol" type="text" id="OtherRequired" name="OtherRequired" />
           
	</fieldset>
	<br>
	<fieldset id="SafetyEquip" class="effect1">
		<legend>Safety Equipment Required</legend>	<br>
			<label class="fourCol" for="">Safety Clothing</label>
			<label class="fourCol" for="">Hardhat</label>
			<label class="fourCol" for="">Eye Protection</label>
			<label class="fourCol" for="">Hearing Protection</label>
				<input type="checkbox" name="" style="margin-left:15px;"/>
				<input type="checkbox" name="" style="margin-left:50px;" />
				<input type="checkbox" name="" style="margin-left:50px;" />
				<input type="checkbox" name="" style="margin-left:50px;" />
	</fieldset>
	<br>
	<fieldset id="instructions" class="effect1">
		<legend style="padding-left: 1em;">Comments</legend>
            <label class="twoCol" for="">Comments or Special Instructions</label><br>           
				<textarea rows="3" Cols="25" type="text" name="" style="margin-bottom:5px;"></textarea><br>
	</fieldset>
	<br>
	<fieldset id="chronicle" class="effect1">
		<legend style="padding-left: 1em;">Date and Time Info</legend>
			<label class="threeCol" for="Startdate">Start Date</label>
			<label class="threeCol" for="StopDate">End Date</label>
			<label class="threeCol" for="ReportTo ">Report To</label>
				<input class="threeCol" type="text" id="Orders_Starate" name="Orders_Starate" />
				<input class="threeCol" type="text" id="Orders_StopDate" name="Orders_StopDate" />	
				<input class="threeCol" type="text" id="Orders_ReportTo" name="Orders_ReportTo" />
			<label class="threeCol" for="">Work Hours</label>
			<label class="threeCol" style="text-align:left" for="Orders_StartTime">Report Time</label>	
			<label class="threeCol" for="Orders_StopTime">End Time</label>	
				<input class="threeCol" type="text" id="" name="" />
				<input class="threeCol" type="text" id="Orders_StartTime" name="Orders_StartTime" />
            	<input class="threeCol" type="text" id="Orders_StopTime" name="Orders_StopTime" />
    </fieldset>          
	<br>
	<fieldset id="rates" class="effect1">
		<legend style="padding-left: 1em;">Rate Info</legend>
            <label class="threeCol" for="">Pay Rate</label>
			<label class="threeCol" for="CustomerRates_RegBill">Bill Rate</label>
			<label class="threeCol" for="">Multiplier</label>
				<input class="threeCol" type="text" id="" name="" />
				<input class="threeCol" type="text" id="CustomerRates_RegBill" name="CustomerRates_RegBill" />
				<input class="threeCol" type="text" id="" name="CustomerRates_Multiplier"/>
			<label class="threeCol" for="CustomerRates_RegPay">Pay Rate</label>
            <label class="threeCol" for="CustomerRates_OtBill">OT Bill </label>
            <label class="threeCol" for="">Multiplier</label>
				<input class="threeCol" type="text" id="CustomerRates_RegPay" name="CustomerRates_RegPay" />
				<input class="threeCol" type="text" id="CustomerRates_OtBill" name="CustomerRates_OtBill" />
				<input class="threeCol" type="text" id="CustomerRates_Multi" name=""/>
			<label class="oneCol" for="CustomerRates_Comment">Rates Comments</label>
				<textarea rows="3" cols="29" type="text" id="CustomerRates_Comment" name="CustomerRates_Comment" style="margin-bottom:5px"></textarea>
	</fieldset>     
	<br>		
    <fieldset id="servicecalls" class="effect1">
        <legend style="padding-left: 1em;">Service Calls</legend>
			<label for="" class="entire" >Customer Service Calls / Date (used to create appointments)</label><br>
				<input class="entire"type="text" name="" style="margin-bottom:5px;"/>
    </fieldset>
	<br>
	<fieldset id="placements" class="effect1">
        <legend style="padding-left: 1em;">Placements</legend>
			<label class="fourCol" for="">Start Date</label>
			<label class="fourCol" for="">End Date</label>
			<label class="fourCol" for="">Name</label>
			<label class="fourCol" for="">Telephone or Message</label>
				<input class="fourCol" type="text" name="" />
				<input class="fourCol" type="text" name="" />
				<input class="fourCol" type="text" name="" />
				<input class="fourCol" type="text" name="" />
			<div style="margin-left:15px;">
			<label class="threeCol" for="">Pay Rate</label>
			<label class="threeCol" for="">Pay Rate</label>
			<label class="threeCol" for="">Pay Rate</label>
				<input class="threeCol" type="text" name=""/>
				<input class="threeCol" type="text" name="" />
				<input class="threeCol" type="text" name="" />
			</div>	
			<label class="oneCol" for="">Weekly Service Calls</label>
				<textarea rows="2" Cols="28" type="text" name="" style="margin-bottom:15px;"></textarea>
	</fieldset>
	<br>
	<fieldset id="orderactivities" class="effect1" style="width:70%; margin:10px;">	
		<!--<legend>
		<div id="orderactivities"></div>
		</legend>-->
	</fieldset>
	</form>
	</div>
</div>
<!-- This is the end of the smForm -->
<!-- This is the start of the medForm -->
<div class="medForm">
	<div id="jobtabs"></div>
	<div id="joborder" class="marLRB10">
	<form id="medForm" name="medForm" method="post" onload="form.setup();">
	<fieldset id="jobdetails" name="jobdetails" class="effect1">
		<legend style="margin: 0;">Job Details</legend>
			<label class="threeCol" for="">Order Date</label>
			<label class="threeCol" for="">Time Received</label>
			<label class="threeCol" for="">New Client</label>
				<input class="threeCol" type="text" id="OrderDate" name="OrderDate" />
				<input class="threeCol" type="text" id="TimeReceived" name="TimeReceived" />
				<input class="threeCol" type="text" id="" name="" />
			<br>
			<br>
			<label class="threeCol" for="">Office</label>
			<label class="threeCol" for="Orders_Customer">Customer #</label>
			<label class="threeCol" for="">Proposal Date</label>
				<input class="threeCol" type="text" id="Office" name="Office" />
				<input class="threeCol" type="text" id="Orders_Customer" name="Orders_Customer" />
				<input class="threeCol" type="text" id="OrderDate" name="OrderDate" />
			<br>
			<br>
			<label class="threeCol" for="">Corporation</label>
			<label class="threeCol" for="Orders_OrderTakenBy">Taken By</label>
			<label class="threeCol" for="">Department</label>			
				<input class="threeCol" type="text" id="" name="" />
				<input class="threeCol" type="text" id="Orders_OrderTakenBy" name="Orders_OrderTakenBy" />
				<input class="threeCol" type="text" id="JobNumber" name="JobNumber" />
			<br>
			<br>
			<br>
			<label class="oneCol" for="">Reference</label><br>
				<input class="oneCol" type="text" id="Reference" name="Reference" />
			<br>
			<br>
			<br>
			<br>
			<label class="oneCol" for="Customers_CustSetupDate">Setup Date</label>
				<input class="oneCol" type="text" id="Customers_CustSetupDate" name="Customers_CustSetupDate" />
			<br>
			<label class="oneCol" for="Customers_CustSetupBy">Setup By</label><br>
				<input class="oneCol" type="text" id="Customers_CustSetupBy" name="Customers_CustSetupBy" />
			
	</fieldset>
	<br>
	<fieldset id="companyinfo" class="effect1">
		<legend style="margin: 0;">Company Info</legend>
			<label class="threeCol" for="CustomerName">Company Name</label>
			<label class="threeCol" for="">Order Placer</label>
			<label class="threeCol" for="Customers_Phone">Telephone #</label><br>
				<input class="threeCol" id="CustomerName" name="CustomerName" type="text">
				<input class="threeCol" type="text" id="" name="" />
				<input class="threeCol" type="text" id="Customers_Phone" name="Customers_Phone" />
			<br>
			<br>
			<label class="threeCol" for="Customers_EmailAddress">email</label>
			<label class="threeCol" for="Customers_Fax">Fax #</label>
			<label class="threeCol" for="">Address</label>
				<input class="threeCol" type="text" id="Customers_EmailAddress" name="Customers_EmailAddress" />
				<input class="threeCol" type="text" id="Customers_Fax" name="Customers_Fax" />
				<input class="threeCol" type="text" id="" name="" />
			<br>
			<br>
			<label class="oneCol" for="">City, State, Zip</label>
				<input class="oneCol" type="text" id="" name="" style="height:30px"/>
			<br>
			<br>
			<label class="oneCol" for="">Directions to Work Site</label>
				<input class="oneCol" type="text" id="" name="" style="height:30px"/>
			<br>
			<br>
			<label class="oneCol" for="">Billing Address (if different)</label>
				 <input class="oneCol" type="text" id="" name="" style="height:30px"/><br>
			<input type="hidden" id="Site" name="Site" /><br>
                                <input type="hidden" id="Department" name="Department" />
                                <input type="hidden" id="" name="" />
                                <input type="hidden" id="" name="" />
                                <input type="hidden" id="" name="" />
                                <input type="hidden" id="" name="" />	 
	</fieldset>
	<br>
	<fieldset id="creditinfo" class="effect1">
        <legend style="padding-left: 1em;">Credit Info</legend>
            <label class="threeCol" for="">EIN of Business I.D.</label>
			<label class="threeCol" for="">Bank Reference</label>
			<label class="threeCol" for="">Supplier Reference</label>
			<br>	
				<input class="threeCol" type="text" name="" />
				<input class="threeCol" type="text" name="" />
				<input class="threeCol" type="text" name="" />
			<br>	
			<label class="oneCol" for="">Credit Checked</label>
				<input class="oneCol" type="text" name="" style="height:30px" />
			<label class="gray" style="width:80%; margin:auto;">Yes, they're Approved, Not yet, Not Approved</label>
			<br>
			<br>
			<br>
			<label class="oneCol"  for="">Credit Limit</label>
				<input class="twoCol"  type="text" name="" />
			<br>	
			<br>
			<br>
			<br>
			<br>
			<label class="oneCol"  for="">Credit Comments</label>		
				<input class="oneCol"  type="text" name="" style="height:30px"/><br>
	</fieldset>
	<br>
	<fieldset id="jobposting" class="effect1">
		<legend style="padding-left: 1em;">Job Posting Details</legend><br>
			<label class="oneCol" for="OtherOrders_Def2">Description</label>
				<input class="oneCol" type="text" id="OtherOrders_Def2" name="OtherOrders_Def2" />
			<label class="oneCol" for="OtherOrders_Def1">Details</label>
        <textarea rows="3" cols="44" id="OtherOrders_Def1" name="OtherOrders_Def1"></textarea><br><br>
	</fieldset>
	<br>
	<fieldset id="businesstype" class="effect1">
		<legend style="padding-left: 1em;">Business Type</legend>
			<label class="oneCol" for="">Type of Business</label><br>
				<input class="oneCol" type="text" name="" style="height:22px"/>				
            <label class="fourCol" for="Customers_CustomerType">Customer Type</label>
			<label class="fourCol" for="">Bonding Required</label>
			<label class="fourCol" for="">Drivers License Required</label>
			<label class="fourCol" for="">CDL Required</label>
			<br><br><br><br><br>
				<input class="fourCol" type="text" id="Customers_CustomerType" name="Customers_CustomerType"/>
				<input class="fourCol" type="text" name="" />
				<input class="fourCol" type="text" name=""/> 
				<input class="fourCol" type="text" name="" /><br>
	</fieldset>
	<br>
	<fieldset id="orderdetails" class="effect1">
        <legend style="padding-left: 1em;">Order Details</legend>
			<label class="twoCol" for="Startdate">Start Date:<span id="Startdate" name="Startdate"></span></label><br><br>
			<label class="oneCol" for="">Job Order Description</label>
				<input class="oneCol" type="text" id="JobDescription" name="JobDescription" style="height:30px"/>
			<br>
			<label class="oneCol" for="JobStatus">Time Received</label><br>
				<input class="twoCol" type="text" id="TimeReceived" name="TimeReceived" readonly />
			<br>
			<br>
			<br>
			<label class="oneCol" for="TimeReceived">Status</label>
			<select class="twoCol" id="JobStatus" name="JobStatus">
                <option value="0"><span style="color: blue;">No Assignments</span></option>
				<option value="1"><span style="color: blue;">Less Assignments an needed</span></option>
                <option value="3"><span style="color: green;">Enough Assignments</span></option>
                <option value="4"><span style="color: magenta;">Closed Job Order</span></option>
                <option value="2"><span style="color: blue;">Close/marked for deletion</span></option>
            </select>
		<br>
		<br>
        <label class="oneCol" for="">Essential Functions (Duties and Actions)</label>
			<input class="oneCol" type="text" id="Essentials" name="Essentials" style="height:30px"/>
		<br>
		<br>
		<br>
		<label class="oneCol" for="">Job Order Description</label>
			<input class="oneCol" type="text" id="JobDescription" name="JobDescription"  style="height:30px"/>
		<label class="oneCol" for="">Memo</label>
			<input class="oneCol" type="text" id="Memo" name="Memo" />
		<br>
		<label class="fourCol" for="" >Regular Hours</label>
		<label class="fourCol" for="" >OT Hours</label>
		<label class="fourCol" for="Orders_RegTimePay" >Regular Pay</label>
		<label class="fourCol" for="" >OT Hours</label>
			<input class="fourCol" type="text" id="Orders_RegHours" name="Orders_RegHours" style="width:18.5%" />
			<input class="fourCol" type="text" id="Orders_OTHours" name="Orders_OTHours"  style="width:18.5%" />
			<input class="fourCol" type="text" id="Orders_RegTimePay" name="Orders_RegTimePay"  style="width:18.5%"/>
			<input class="fourCol" type="text" id="Orders_OTPay" name="Orders_OTPay"  style="width:18.5%"/>
	    <label class="oneCol" for="">Skills Required</label>
			<input class="oneCol" type="text" name="" style="height:30px"/>
		<br>
		<label class="fourCol" for="">Dress</label>
		<label class="fourCol" for="">Dress Code</label>
		<label class="fourCol" for="">Tools Used</label>
		<label class="fourCol" for="">Tools Required</label>
			<input class="fourCol" type="text" name="" style="width:18.5%" />
			<input class="fourCol" type="text" name="" style="width:18.5%" />
			<input class="fourCol" type="text" name="" style="width:18.5%" />
			<input class="fourCol" type="text" name="" style="width:18.5%" />
		<br>
		<br>
        <br>
        <label class="fourCol" for="">Physical Tasks</label>
		<label class="fourCol" for="">Safety Equip. Req.</label>
		<label class="fourCol" for="">Repetitive Motion</label>
		<label class="fourCol" for="">Weight Lighting</label>
			<input class="fourCol" type="text" name="" style="width:18.5%" />
       		<input class="fourCol" type="text" name="" style="width:18.5%" />
       		<input class="fourCol" type="text" name="" style="width:18.5%" />
		    <input class="fourCol" type="text" name="" style="width:18.5%" />
	</fieldset>
	<br>
	<fieldset id="orderdetails" class="effect1">
		<legend style="padding-left: 1em;">Billing Info</legend><br>
			<label for="">Billing Address</label><br><br>
				<input type="text" id="Orders_Bill1" name="Orders_Bill1" />
                <input type="text" id="Orders_Bill2" name="Orders_Bill2" /><br>
				<input type="text" id="Orders_Bill3" name="Orders_Bill3" />
                <input type="text" id="Orders_Bill4" name="Orders_Bill4" /><br>
			<label class="twoCol" for="T">Sales Tax Exempt Number</label>
			<label class="twoCol" for="TimeReceived">Sales Tax Exempt Number</label>
				<input class="twoCol" type="text" id="Customers_SalesTaxExemptNo" name="Customers_SalesTaxExemptNo" />
            	<input class="twoCol" type="text" id="Customers_InvoiceTaxExemptNo" name="Customers_InvoiceTaxExemptNo"/><br>
			<label class="twoCol" for="Customers_SuspendService" >Suspend Service</label>
			<label class="twoCol" for="Customers_ETimeCardStyle" >Timecard Style</label>
				<input class="twoCol" type="text" id="Customers_SuspendService" name="Customers_SuspendService" />
				<input class="twoCol" type="text" id="Customers_ETimeCardStyle" name="Customers_ETimeCardStyle" />
    </fieldset>                       
    <br>
	<fieldset id="workcomp" class="effect1">
		<legend>Work Comp</legend>
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for="">Required</label>
				<input class="fourCol" type="text" id="WorkCode1" name="WorkCode1" />
                <input class="fourCol" type="text" id="WC1Pay" name="WC1Pay" />
                <input class="fourCol" type="text" id="WC1Bill" name="WC1Bill" />
                <input class="fourCol" type="text" id="WC1Required" name="WC1Required" />
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for="">Required</label>
                <input class="fourCol" type="text" id="WorkCode2" name="WorkCode2" />
                <input class="fourCol" type="text" id="WC2Pay" name="WC2Pay" />
                <input class="fourCol" type="text" id="WC2Bill" name="WC2Bill" />
                <input class="fourCol" type="text" id="WC2Required" name="WC2Required" />
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for="">Required</label>
                <input class="fourCol" type="text" id="WorkCode3" name="WorkCode3" />
                <input class="fourCol" type="text" id="WC3Pay" name="WC3Pay" />
                <input class="fourCol" type="text" id="WC3Bill" name="WC3Bill" />
                <input class="fourCol" type="text" id="WC3Required" name="WC3Required" />
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for="">Required</label>
                <input class="fourCol" type="text" id="WorkCode4" name="WorkCode4" />
                <input class="fourCol" type="text" id="WC4Pay" name="WC4Pay" />
                <input class="fourCol" type="text" id="WC4Bill" name="WC4Bill" />
                <input class="fourCol" type="text" id="WC4Required" name="WC4Required" />
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for="">Required</label>
                <input class="fourCol" type="text" id="WorkCode5" name="WorkCode5" />
                <input class="fourCol" type="text" id="WC5Pay" name="WC5Pay" />
                <input class="fourCol" type="text" id="WC5Bill" name="WC5Bill" />
                <input class="fourCol" type="text" id="WC5Required" name="WC5Required" />
            <label class="fourCol" for=""></label>
            <label class="fourCol" for="">Other Pay</label>
            <label class="fourCol" for="">Other Bill</label>
            <label class="fourCol" for="">Other Required</label>
				<label class="fourCol" type="text" id="blank" name="blank" style="display:hidden"></label>
                <input class="fourCol" type="text" id="OtherPay" name="OtherPay" />
                <input class="fourCol" type="text" id="OtherBill" name="OtherBill" />
                <input class="fourCol" type="text" id="OtherRequired" name="OtherRequired" />
           
	</fieldset>
	<br>
	<fieldset id="SafetyEquip" class="effect1">
		<legend>Safety Equipment Required</legend>	<br>
			<label class="fiveCol" for="">Safety Clothing</label>
			<label class="fiveCol" for="">Hardhat</label>
			<label class="fiveCol" for="">Eye Protection</label>
			<label class="fiveCol" for="">Hearing Protection</label>
			<label class="fiveCol" for=""></label>
			<br><br><br>
 				<input type="checkbox" name="" style="margin-left:35px;"/>
				<input type="checkbox" name="" style="margin-left:75px;"/>
				<input type="checkbox" name="" style="margin-left:75px;"/>
				<input type="checkbox" name="" style="margin-left:75px;"/>
				
	</fieldset>
	<br>
	<fieldset id="instructions" class="effect1">
		<legend style="padding-left: 1em;">Comments</legend>
            <label for="">Comments or Special Instructions</label><br><br>         
				<textarea rows="3" Cols="50" type="text" name="" style="margin-bottom:5px;"></textarea><br>
	</fieldset>
	<br>
	<fieldset id="chronicle" class="effect1">
		<legend style="padding-left: 1em;">Date and Time Info</legend>
			<label class="threeCol" for="Startdate">Start Date</label>
			<label class="threeCol" for="StopDate">End Date</label>
			<label class="threeCol" for="ReportTo ">Report To</label>
				<input class="threeCol" type="text" id="Orders_Starate" name="Orders_Starate" />
				<input class="threeCol" type="text" id="Orders_StopDate" name="Orders_StopDate" />	
				<input class="threeCol" type="text" id="Orders_ReportTo" name="Orders_ReportTo" />
			<label class="threeCol" for="">Work Hours</label>
			<label class="threeCol" style="text-align:left" for="Orders_StartTime">Report Time</label>	
			<label class="threeCol" for="Orders_StopTime">End Time</label>	
				<input class="threeCol" type="text" id="" name="" />
				<input class="threeCol" type="text" id="Orders_StartTime" name="Orders_StartTime" />
            	<input class="threeCol" type="text" id="Orders_StopTime" name="Orders_StopTime" />
    </fieldset>          
	<br>
	<fieldset id="rates" class="effect1">
		<legend style="padding-left: 1em;">Rate Info</legend>
            <label class="threeCol" for="">Pay Rate</label>
			<label class="threeCol" for="CustomerRates_RegBill">Bill Rate</label>
			<label class="threeCol" for="">Multiplier</label>
				<input class="threeCol" type="text" id="" name="" />
				<input class="threeCol" type="text" id="CustomerRates_RegBill" name="CustomerRates_RegBill" />
				<input class="threeCol" type="text" id="" name="CustomerRates_Multiplier"/>
			<label class="threeCol" for="CustomerRates_RegPay">Pay Rate</label>
            <label class="threeCol" for="CustomerRates_OtBill">OT Bill </label>
            <label class="threeCol" for="">Multiplier</label>
				<input class="threeCol" type="text" id="CustomerRates_RegPay" name="CustomerRates_RegPay" />
				<input class="threeCol" type="text" id="CustomerRates_OtBill" name="CustomerRates_OtBill" />
				<input class="threeCol" type="text" id="CustomerRates_Multi" name=""/>
			<label class="oneCol" for="CustomerRates_Comment">Rates Comments</label>
				<textarea rows="3" cols="29" type="text" id="CustomerRates_Comment" name="CustomerRates_Comment" style="margin-bottom:5px"></textarea>
	</fieldset>     
	<br>		
    <fieldset id="servicecalls" class="effect1">
        <legend style="padding-left: 1em;">Service Calls</legend>
			<label for="" class="entire" >Customer Service Calls / Date (used to create appointments)</label><br>
				<input class="entire" type="text" name="" style="margin-bottom:5px;"/>
    </fieldset>
	<br>
	<fieldset id="placements" class="effect1">
        <legend style="padding-left: 1em;">Placements</legend>
			<label class="fourCol" for="">Start Date</label>
			<label class="fourCol" for="">End Date</label>
			<label class="fourCol" for="">Name</label>
			<label class="fourCol" for="">Telephone or Message</label>
				<input class="fourCol" type="text" name="" />
				<input class="fourCol" type="text" name="" />
				<input class="fourCol" type="text" name="" />
				<input class="fourCol" type="text" name="" />
			<div style="margin-left:15px;">
			<label class="threeCol" for="">Pay Rate</label>
			<label class="threeCol" for="">Pay Rate</label>
			<label class="threeCol" for="">Pay Rate</label>
				<input class="threeCol" type="text" name=""/>
				<input class="threeCol" type="text" name="" />
				<input class="threeCol" type="text" name="" />
			</div>	
			<label class="oneCol" for="" style="margin-left:15px;">Weekly Service Calls</label>
				<textarea rows="2" Cols="42.5" type="text" name="" style="margin-bottom:15px;"></textarea>
	</fieldset>
	<br>
	<fieldset id="orderactivities" class="effect1" style="width:70%; margin:10px;">	
		<!--<legend>
		<div id="orderactivities"></div>
		</legend>-->
	</fieldset>
	</div>
	<div class="clear"></div>
</div>
<!-- This is the end of the medForm -->
</div>
<!-- This is the start of the lgForm -->
<div class="lgForm">

	<div id="jobtabs"></div>
	<div id="joborder" class="marLRB10">
		<form id="lgForm" name="lgForm" method="post" onload="form.setup();">

	<fieldset id="jobdetails" name="jobdetails" class="effect1">
		<legend style="margin-left: 0;">Job Details</legend>
			<label class="threeCol" for="">Order Date</label>
			<label class="threeCol" for="">Time Received</label>
			<label class="threeCol" for="">Office</label>
			<br><br><br>
				<input class="threeCol" type="text" id="OrderDate" name="OrderDate" />
				<input class="threeCol" type="text" id="TimeReceived" name="TimeReceived" />
				<input class="threeCol" type="text" id="Office" name="Office" />
				
			<label class="threeCol" for="Orders_OrderTakenBy">Taken By</label>
			<label class="threeCol" for="">Proposal Date</label>
			<label class="threeCol" for="Orders_Customer">Customer #</label>
			<br><br><br><br><br>
				<input class="threeCol" type="text" id="Orders_OrderTakenBy" name="Orders_OrderTakenBy" />
				<input class="threeCol" type="text" id="OrderDate" name="OrderDate" />
				<input class="threeCol" type="text" id="Orders_Customer" name="Orders_Customer" />
			
			<label class="threeCol" for="">New Client</label>
			<label class="threeCol" for="">Corporation</label>
			<label class="threeCol" for="">Department</label>	
			<br><br><br>
				<input class="threeCol" type="text" id="" name="" />
				<input class="threeCol" type="text" id="" name="" />
				<input class="threeCol" type="text" id="JobNumber" name="JobNumber" />
			<br>
			<label class="oneCol" for="">Reference</label><br>
				<input class="oneCol" type="text" id="Reference" name="Reference" />
			<br>
			<label class="oneCol" for="Customers_CustSetupDate">Setup Date</label>
				<input class="oneCol" type="text" id="Customers_CustSetupDate" name="Customers_CustSetupDate" />
			<br><br>
			<label class="oneCol" for="Customers_CustSetupBy">Setup By</label>
				<input class="oneCol" type="text" id="Customers_CustSetupBy" name="Customers_CustSetupBy" />
	</fieldset>
	<fieldset id="companyinfo" name="companyinfo" class="effect1">
		<legend style="margin: 0;">Company Info</legend>
			<label class="threeCol" for="CustomerName">Company Name</label>
			<label class="threeCol" for="">Order Placer</label>
			<label class="threeCol" for="Customers_Phone">Telephone #</label>
			<br><br><br>
				<input class="threeCol" id="CustomerName" name="CustomerName" type="text">
				<input class="threeCol" type="text" id="" name="" />
				<input class="threeCol" type="text" id="Customers_Phone" name="Customers_Phone" />
			<br>
			<label class="threeCol" for="Customers_EmailAddress">email</label>
			<label class="threeCol" for="Customers_Fax">Fax #</label>
			<label class="threeCol" for="">Address</label>
				<input class="threeCol" type="text" id="Customers_EmailAddress" name="Customers_EmailAddress" />
				<input class="threeCol" type="text" id="Customers_Fax" name="Customers_Fax" />
				<input class="threeCol" type="text" id="" name="" />
			<br>
			<br>
			<label class="oneCol" for="">City, State, Zip</label>
				<input class="oneCol" type="text" id="" name="" style="height:30px"/>
			<br>
			<br>
			<label class="oneCol" for="">Directions to Work Site</label>
				<input class="oneCol" type="text" id="" name="" style="height:40px"/>
			<br>
			<br>
			<label class="oneCol" for="">Billing Address (if different)</label>
				 <input class="oneCol" type="text" id="" name="" style="height:40px"/><br>
			<input type="hidden" id="Site" name="Site" /><br>
                                <input type="hidden" id="Department" name="Department" />
                                <input type="hidden" id="" name="" />
                                <input type="hidden" id="" name="" />
                                <input type="hidden" id="" name="" />
                                <input type="hidden" id="" name="" />	 
	</fieldset>
	<br>
	<fieldset id="creditinfo" class="effect1">
        <legend style="padding-left: 1em;">Credit Info</legend>
            <label class="threeCol" for="">SSN / EIN of Business I.D.</label>
			<label class="threeCol" for="">Bank Reference</label>
			<label class="threeCol" for="">Supplier Reference</label>
			<br>	
				<input class="threeCol" type="text" name="" />
				<input class="threeCol" type="text" name="" />
				<input class="threeCol" type="text" name="" />
			<br>	
			<label class="oneCol" for="">Credit Checked</label>
				<input class="oneCol" type="text" name="" style="height:15px" />
			<label  class="gray" >Yes, they're Approved, Not yet, Not Approved</label>
			<br>
			<br>
			<br><br>
			<label class="oneCol"  for="">Credit Limit</label>
				<input class="twoCol"  type="text" name="" />
			<br>	
			<br>
			<label class="oneCol"  for="">Credit Comments</label>		
				<input class="oneCol"  type="text" name="" style="height:30px"/><br>
	</fieldset>
	<br>
	<fieldset id="jobposting" class="effect1">
		<legend style="padding-left: 1em;">Job Posting Details</legend><br>
			<label class="oneCol" for="OtherOrders_Def2">Description</label>
				<input class="oneCol" type="text" id="OtherOrders_Def2" name="OtherOrders_Def2" />
			<label class="oneCol" for="OtherOrders_Def1">Details</label>
        <textarea rows="3" cols="44" id="OtherOrders_Def1" name="OtherOrders_Def1"></textarea><br><br>
	</fieldset>
	<br>
	<fieldset id="businesstype" class="effect1">
		<legend style="padding-left: 1em;">Business Type</legend>
			<label class="oneCol" for="">Type of Business</label><br>
				<input class="oneCol" type="text" name="" style="height:22px"/>	
			<br><br><br>
            <label class="fourCol" for="Customers_CustomerType">Customer Type</label>
			<label class="fourCol" for="">Bonding Required</label>
			<label class="fourCol" for="">Drivers License Required</label>
			<label class="fourCol" for="">CDL Required</label>
			<br><br><br><br>
				<input class="sevenCol" type="text" id="Customers_CustomerType" name="Customers_CustomerType" style="margin-left:12px;"/>
				<input class="sevenCol" type="text" name="" style="margin-left:25px;"/>
				<input class="sevenCol" type="text" name="" style="margin-left:25px;"/> 
				<input class="sevenCol" type="text" name="" style="margin-left:25px;"/>
				<br>
	</fieldset>
	<br>
	<br><br><br><br>
	<fieldset id="orderdetails" class="effect1">
        <legend style="padding-left: 1em;">Order Details</legend>
			<label class="twoCol" for="Startdate">Start Date:<span id="Startdate" name="Startdate"></span></label><br><br>
			<label class="oneCol" for="">Job Order Description</label>
				<input class="oneCol" type="text" id="JobDescription" name="JobDescription" style="height:30px"/>
			<br>
			<label class="twoCol" for="JobStatus">Time Received</label><br>
			<label class="twoCol" for="TimeReceived">Status</label>	
				<input class="twoCol" type="text" id="TimeReceived" name="TimeReceived" readonly />
				<select class="twoCol" id="JobStatus" name="JobStatus">
					<option value="0"><span style="color: blue;">No Assignments</span></option>
					<option value="1"><span style="color: blue;">Less Assignments an needed</span></option>
					<option value="3"><span style="color: green;">Enough Assignments</span></option>
					<option value="4"><span style="color: magenta;">Closed Job Order</span></option>
					<option value="2"><span style="color: blue;">Close/marked for deletion</span></option>
				</select>
			<br>
			<br>
			<br>
			<br><br>
        <label class="oneCol" for="">Essential Functions (Duties and Actions)</label>
			<input class="oneCol" type="text" id="Essentials" name="Essentials" style="height:30px"/>
		<br>
		<br>
		<br>
		<label class="oneCol" for="">Job Order Description</label>
			<input class="oneCol" type="text" id="JobDescription" name="JobDescription"  style="height:30px"/>
		<label class="oneCol" for="">Memo</label>
			<input class="oneCol" type="text" id="Memo" name="Memo" />
		<br><br><br><br><br>
		<label class="fiveCol" for="" >Regular Hours</label>
		<label class="fiveCol" for="" >OT Hours</label>
		<label class="fiveCol" for="Orders_RegTimePay" >Regular Pay</label>
		<label class="fiveCol" for="" >OT Hours</label>
			<input class="fiveCol" type="text" id="Orders_RegHours" name="Orders_RegHours" style="width:18.5%" />
			<input class="fiveCol" type="text" id="Orders_OTHours" name="Orders_OTHours"  style="width:18.5%" />
			<input class="fiveCol" type="text" id="Orders_RegTimePay" name="Orders_RegTimePay"  style="width:18.5%"/>
			<input class="fiveCol" type="text" id="Orders_OTPay" name="Orders_OTPay"  style="width:18.5%"/>
	    <label class="oneCol" for="">Skills Required</label>
			<input type="text" name="" style="height:40px; width;60%; margin-left:10px;"/>
		<br>
		<label class="fiveCol" for="">Dress</label>
		<label class="fiveCol" for="">Dress Code</label>
		<label class="fiveCol" for="">Tools Used</label>
		<label class="fiveCol" for="">Tools Required</label>
			<input class="fiveCol" type="text" name="" style="width:18.5%" />
			<input class="fiveCol" type="text" name="" style="width:18.5%" />
			<input class="fiveCol" type="text" name="" style="width:18.5%" />
			<input class="fiveCol" type="text" name="" style="width:18.5%" />
		<br>
		<br>
        <br>
        <label class="fiveCol" for="">Physical Tasks</label>
		<label class="fiveCol" for="">Safety Equip. Req.</label>
		<label class="fiveCol" for="">Repetitive Motion</label>
		<label class="fiveCol" for="">Weight Lighting</label>
			<input class="fiveCol" type="text" name="" style="width:18.5%" />
       		<input class="fiveCol" type="text" name="" style="width:18.5%" />
       		<input class="fiveCol" type="text" name="" style="width:18.5%" />
		    <input class="fiveCol" type="text" name="" style="width:18.5%" />
	</fieldset>
	<br>
	<fieldset id="orderdetails" class="effect1">
		<legend style="padding-left: 1em;">Billing Info</legend><br>
			<label class="oneCol"for="">Billing Address</label><br><br>
				<input type="text" id="Orders_Bill1" name="Orders_Bill1" style="margin-left:5px;" />
                <input type="text" id="Orders_Bill2" name="Orders_Bill2" style="margin-left:5px;" />
				<input type="text" id="Orders_Bill3" name="Orders_Bill3" style="margin-left:5px;" />
                <input type="text" id="Orders_Bill4" name="Orders_Bill4" style="margin-left:5px;" /><br>
			<label class="fourCol" for="T">Sales Tax Exempt Number</label>
			<label class="fourCol" for="TimeReceived" style="margin-left:15px;">Sales Tax Exempt Number</label>
			<label class="fourCol" for="Customers_SuspendService" style="margin-left:15px;">Suspend Service</label>
			<label class="fourCol" for="Customers_ETimeCardStyle" >Timecard Style</label><br><br><br>
				<input class="fourCol" type="text" id="Customers_SalesTaxExemptNo" name="Customers_SalesTaxExemptNo" />
            	<input class="fourCol" type="text" id="Customers_InvoiceTaxExemptNo" name="Customers_InvoiceTaxExemptNo"/>
				<input class="fourCol" type="text" id="Customers_SuspendService" name="Customers_SuspendService" />
				<input class="fourCol" type="text" id="Customers_ETimeCardStyle" name="Customers_ETimeCardStyle" />
				<br>
	</fieldset>                       
	<br>
	<fieldset id="workcomp" class="effect1">
		<legend>Work Comp</legend>
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for="" style="margin-left:15px;">Required</label>
				<input class="fourCol" type="text" id="WorkCode1" name="WorkCode1" />
                <input class="fourCol" type="text" id="WC1Pay" name="WC1Pay" />
                <input class="fourCol" type="text" id="WC1Bill" name="WC1Bill" />
                <input class="fourCol" type="text" id="WC1Required" name="WC1Required" />
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for=""style="margin-left:15px;">Required</label>
                <input class="fourCol" type="text" id="WorkCode2" name="WorkCode2" />
                <input class="fourCol" type="text" id="WC2Pay" name="WC2Pay" />
                <input class="fourCol" type="text" id="WC2Bill" name="WC2Bill" />
                <input class="fourCol" type="text" id="WC2Required" name="WC2Required" />
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for=""style="margin-left:15px;">Required</label>
                <input class="fourCol" type="text" id="WorkCode3" name="WorkCode3" />
                <input class="fourCol" type="text" id="WC3Pay" name="WC3Pay" />
                <input class="fourCol" type="text" id="WC3Bill" name="WC3Bill" />
                <input class="fourCol" type="text" id="WC3Required" name="WC3Required" />
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for=""style="margin-left:15px;">Required</label>
                <input class="fourCol" type="text" id="WorkCode4" name="WorkCode4" />
                <input class="fourCol" type="text" id="WC4Pay" name="WC4Pay" />
                <input class="fourCol" type="text" id="WC4Bill" name="WC4Bill" />
                <input class="fourCol" type="text" id="WC4Required" name="WC4Required" />
            <label class="fourCol" for="">Work Code</label>
            <label class="fourCol" for="">Pay Rate</label>
            <label class="fourCol" for="">Bill Rate</label>
            <label class="fourCol" for=""style="margin-left:15px;">Required</label>
                <input class="fourCol" type="text" id="WorkCode5" name="WorkCode5" />
                <input class="fourCol" type="text" id="WC5Pay" name="WC5Pay" />
                <input class="fourCol" type="text" id="WC5Bill" name="WC5Bill" />
                <input class="fourCol" type="text" id="WC5Required" name="WC5Required" />
            <label class="fourCol" for=""></label>
            <label class="fourCol" for="">Other Pay</label>
            <label class="fourCol" for="">Other Bill</label>
            <label class="fourCol" for="" style="margin-left:25px;">Other Required</label>
				<label class="fourCol" type="text" id="blank" name="blank" style="display:hidden" style="margin-left:15px;" ></label>
                <input class="fourCol" type="text" id="OtherPay" name="OtherPay"style="margin-left:15px;"  />
                <input class="fourCol" type="text" id="OtherBill" name="OtherBill" />
                <input class="fourCol" type="text" id="OtherRequired" name="OtherRequired" />
           
	</fieldset>
	<br>
	<fieldset id="SafetyEquip" class="effect1">
		<legend>Safety Equipment Required</legend>	<br>
			<label class="fourCol" for="">Safety Clothing</label>
			<label class="fourCol" for="">Hardhat</label>
			<label class="fourCol" for="">Eye Protection</label>
			<label class="fourCol" for="">Hearing Protection</label>
			
 				<input class="fourCol" type="checkbox" name="" style="margin-left:-5px;"/>
				<input class="fourCol"type="checkbox" name="" />
				<input class="fourCol"type="checkbox" name="" style="margin-left:-5px;"/>
				<input class="fourCol"type="checkbox" name="" />
				
	</fieldset>
	<fieldset id="instructions" class="effect1">
		<legend style="padding-left: 1em;">Comments</legend>
            <label style="margin-left:5px;" for="">Comments or Special Instructions</label><br><br>         
				<textarea rows="3" Cols="35" type="text" name="" style=" margin:5px; margin-top:-5px;"></textarea><br>
	</fieldset>
	<br>
	<fieldset id="chronicle" class="effect1">
		<legend style="padding-left: 1em;">Date and Time Info</legend>
			<label class="threeCol" for="Startdate">Start Date</label>
			<label class="threeCol" for="StopDate">End Date</label>
			<label class="threeCol" for="ReportTo ">Report To</label>
				<input class="threeCol" type="text" id="Orders_Starate" name="Orders_Starate" />
				<input class="threeCol" type="text" id="Orders_StopDate" name="Orders_StopDate" />	
				<input class="threeCol" type="text" id="Orders_ReportTo" name="Orders_ReportTo" />
			<label class="threeCol" for="">Work Hours</label>
			<label class="threeCol" style="text-align:left" for="Orders_StartTime">Report Time</label>	
			<label class="threeCol" for="Orders_StopTime">End Time</label>	
				<input class="threeCol" type="text" id="" name="" />
				<input class="threeCol" type="text" id="Orders_StartTime" name="Orders_StartTime" />
            	<input class="threeCol" type="text" id="Orders_StopTime" name="Orders_StopTime" />
    </fieldset>          
	<br>
	<fieldset id="rates" class="effect1">
		<legend style="padding-left: 1em;">Rate Info</legend>
            <label class="threeCol" for="">Pay Rate</label>
			<label class="threeCol" for="CustomerRates_RegBill">Bill Rate</label>
			<label class="threeCol" for="">Multiplier</label>
				<input class="threeCol" type="text" id="" name="" />
				<input class="threeCol" type="text" id="CustomerRates_RegBill" name="CustomerRates_RegBill" />
				<input class="threeCol" type="text" id="" name="CustomerRates_Multiplier"/>
			<label class="threeCol" for="CustomerRates_RegPay">Pay Rate</label>
            <label class="threeCol" for="CustomerRates_OtBill">OT Bill </label>
            <label class="threeCol" for="">Multiplier</label>
				<input class="threeCol" type="text" id="CustomerRates_RegPay" name="CustomerRates_RegPay" />
				<input class="threeCol" type="text" id="CustomerRates_OtBill" name="CustomerRates_OtBill" />
				<input class="threeCol" type="text" id="CustomerRates_Multi" name=""/>
			<label class="oneCol" for="CustomerRates_Comment">Rates Comments</label>
				<textarea rows="3" cols="44" type="text" id="CustomerRates_Comment" name="CustomerRates_Comment" style="margin-bottom:5px"></textarea>
	</fieldset>     
	<br>	
    <fieldset id="servicecalls" class="effect1">
        <legend style="padding-left: 1em;">Service Calls</legend>
			<label for="" class="entire" >Customer Service Calls / Date (used to create appointments)</label><br>
				<input class="entire" type="text" name="" style="margin-bottom:5px;margin-left:5px;"/>
    </fieldset>
	<br>	<!--<h3>Your Screen:</h3>
	-->	
	<fieldset id="placements" class="effect1">
        <legend style="padding-left: 1em;">Placements</legend>
			<label class="fourCol" for="">Start Date</label>
			<label class="fourCol" for="">End Date</label>
			<label class="fourCol" for="">Name</label>
			<label class="fourCol" for="">Telephone or Message</label>
				<input class="fourCol" type="text" name="" />
				<input class="fourCol" type="text" name="" />
				<input class="fourCol" type="text" name="" />
				<input class="fourCol" type="text" name="" />
			<div style="margin-left:15px;">
			<label class="threeCol" for="">Pay Rate</label>
			<label class="threeCol" for="">Pay Rate</label>
			<label class="threeCol" for="">Pay Rate</label>
				<input class="threeCol" type="text" name=""/>
				<input class="threeCol" type="text" name="" />
				<input class="threeCol" type="text" name="" />
			</div>	
			<label class="oneCol" for="" style="margin-left:15px;">Weekly Service Calls</label>
				<textarea rows="2" Cols="42.5" type="text" name="" style="margin-bottom:15px;"></textarea>
	</fieldset>
	<br>
	<fieldset id="orderactivities" class="effect1" style="width:70%; margin:10px;">	
		<!--<legend>
		<div id="orderactivities"></div>
		</legend>-->
	</fieldset>
	</div>
	<div class="clear"></div>
</div>
<div class="clear"></div>
<!-- This is the end of the lgForm -->
</div>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->