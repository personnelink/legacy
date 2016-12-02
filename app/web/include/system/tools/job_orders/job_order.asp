<%
session("add_css") = "./job_order.asp.css, .//include/system/tools/activity/reports/appointments/followAppointments.asp.css"
session("page_title") = "Job Orders - Personnel Plus"
session("no-auth") = false
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
<div id="pdfheader" style="margin-left:5em;"> <img src="css/images/pp_logo.png" alt="PPlus Logo" height="93" width="250"><span style="float:right; margin-right:20em;"><strong>Job Order # <span id="Reference" name="Reference"></span></strong></span></div>
<div id="boxeffect1" class="box effect1" >
  <label id="lblSearchBox" for="searchbox"><em>Search</em>: Company Name, Code, Phone, email, Job Orders, etc.</label>
  <input id="searchbox" name="searchbox" type="text" onblur="company.clear(this);" onkeyup="company.lookup(this);" />
  <div ><a style="margin-left:5em;" class="squarebutton" href="javascript:window.print() ;"><span>Print PDF</span></a></div>
</div>
<div id="CompanyLookUp"></div>
</div>
<div id="jobtabs"></div>
<div id="joborder" class="marLRB10"> 
  
  <!-- <div  class="notes" id="instructions" style="float:right;width:24em;margin:2em 3em"><p>Use this form  to submit work requests.</p><p>Once submitted, a work order will be dispatched to the nearest branch office for processing.</p> 

<p style="color:red"><i>In case of Fire-Police-Ambulance emergencies, DIAL 911.</i></p>

<p>You will receive an email with the Work Order number and be contacted by a member of our team. If you have any questions, please <a href="/include/content/contact.asp" alt="Contact Us">contact us</a>.</p>
</div>-->
  
  <form name="frmJobOrder" id="frmJobOrder" method="post" onload="form.setup();">
    <table id="tblJobOrder" class="effect1">
      <tr>
        <td colspan="2"><legend style="margin: 0;">Job Details</legend>
          <table id="orderheader" class="effect1">
            <tr>
              <th> <label for="">Order Date</label></th>
              <th> <label for="">Time Received</label></th>
              <th> <label for="">New Client</label></th>
              <th> <label for="">Office</label></th>
              <th> <label for="Orders_Customer">Customer #</label></th>
            </tr>
            <tr>
              <td><input class="order_input" data-previous-value="" data-reference="" data-site="" type="text" id="OrderDate" name="OrderDate" /></td>
              <td><input class="order_input" type="text" id="" name="" /></td>
              <td><input class="order_input" type="text" id="" name="" /></td>
              <td><input class="order_input" type="text" id="Office" name="Office" /></td>
              <td><input class="order_input" type="text" id="Orders_Customer" name="Orders_Customer" /></td>
            </tr>
            <tr>
              <th> <label for="">Proposal Date</label></th>
              <th> <label for="">Corporation</label></th>
              <th> <label for="Orders_OrderTakenBy">Taken By</label></th>
              <th> <label for="">Department</label></th>
              <th> <label for="">Reference</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="OrderDate" name="OrderDate" /></td>
              <td><input class="order_input" type="text" id="" name="" /></td>
              <td><input class="order_input" type="text" id="Orders_OrderTakenBy" name="Orders_OrderTakenBy" /></td>
              <td><input class="order_input" type="text" id="JobNumber" name="JobNumber" /></td>
              <td><input class="order_input" type="text" id="Reference" name="Reference" /></td>
            </tr>
            <tr>
              <th colspan="2"> <label for="Customers_CustSetupDate">Setup Date</label></th>
              <th> <label for="Customers_CustSetupBy">Setup By</label></th>
            </tr>
            <tr>
              <td colspan="2"><input class="order_input" type="text" id="Customers_CustSetupDate" name="Customers_CustSetupDate" /></td>
              <td><input class="order_input" type="text" id="Customers_CustSetupBy" name="Customers_CustSetupBy" /></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td><legend>Company Info</legend>
          <table id="companyinfo" class="effect1">
            <tr>
              <th> <label for="Customers_CustomerName">Company Name</label></th>
            </tr>
            <tr>
              <td><input class="order_input" id="Customers_CustomerName" name="Customers_CustomerName" type="text"></td>
            </tr>
            <tr>
              <th> <label for="">Order Placer</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="" name="" /></td>
            </tr>
            <tr>
              <th> <label for="Customers_Phone">Telephone #</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="Customers_Phone" name="Customers_Phone" /></td>
            </tr>
            <tr>
              <th> <label for="Customers_EmailAddress">email</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="Customers_EmailAddress" name="Customers_EmailAddress" /></td>
            </tr>
            <tr>
              <th> <label for="Customers_Fax">Fax #</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="Customers_Fax" name="Customers_Fax" /></td>
            </tr>
            <tr>
              <th> <label class="order_input" for="">Address</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="" name="" /></td>
            </tr>
            <tr>
              <th> <label for="">City, State, Zip</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="" name="" /></td>
            </tr>
            <tr>
              <th> <label for="">Directions to Work Site</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="" name="" /></td>
            </tr>
            <tr>
              <th> <label for="">Billing Address (if different)</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="" name="" /></td>
            </tr>
            <tr>
              <td><input type="hidden" id="Site" name="Site" />
                <input class="order_input" type="hidden" id="Department" name="Department" />
                <input class="order_input" type="hidden" id="" name="" />
                <input class="order_input" type="hidden" id="" name="" />
                <input class="order_input" type="hidden" id="" name="" />
                <input class="order_input" type="hidden" id="" name="" /></td>
            </tr>
          </table></td>
        <td><legend style="padding-left: 1em;">Credit Info</legend>
          <table id="creditinfo" class="effect1">
            <tr>
              <th> <label for="">Social Security Number of Business I.D.</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" name="" /></td>
            </tr>
            <tr>
              <th> <label for="">Bank Reference</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" name="" /></td>
            </tr>
            <tr>
              <th> <label for="">Supplier Reference</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" name="" /></td>
            </tr>
            <tr>
              <th> <label for="">Credit Checked</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" name="" />
                Yes, They're Approved, Not yet, Not Approved</td>
            </tr>
            <tr>
              <th> <label for="">Credit Limit</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" name="" /></td>
            </tr>
            <tr>
              <th> <label for="">Credit Comments</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" name="" /></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td colspan="2"><legend>Job Posting Details</legend>
          <table id="jobposting" class="effect1">
            <tr>
              <th> <label for="OtherOrders_Def2">Description</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="OtherOrders_Def2" name="OtherOrders_Def2" /></td>
            </tr>
            <tr>
              <th> <label for="OtherOrders_Def1">Details</label></th>
            </tr>
            <tr>
              <td><textarea class="order_input" id="OtherOrders_Def1" name="OtherOrders_Def1"></textarea></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td colspan="2"><legend>Business Type</legend>
          <table id="businesstype" class="effect1">
            <tr>
              <td><table>
                  <tr>
                    <th> <label for="">Type of Business</label></th>
                    <th> <label for="Customers_CustomerType">Customer Type</label></th>
                  </tr>
                  <tr>
                    <td><input class="order_input" type="text" name="" /></td>
                    <td><input class="order_input" type="text" id="Customers_CustomerType" name="Customers_CustomerType" /></td>
                  </tr>
                  <tr>
                    <td><table>
                        <tr>
                          <th> <label for="">Bonding Required</label></th>
                          <th> <label for="">Drivers License Required</label></th>
                          <th> <label for="">CDL Required</label></th>
                        </tr>
                        <tr>
                          <td><input class="order_input" type="text" name="" /></td>
                          <td><input class="order_input" type="text" name="" /></td>
                          <td><input class="order_input" type="text" name="" /></td>
                        </tr>
                      </table></td>
                  </tr>
                </table></td>
            </tr>
          </table></td>
      </tr>
      <tr id="pageBreak">
        <td colspan="2"><legend>Order Details</legend>
          <table id="orderdetails" class="effect1">
            
              <td><table>
                  <tr>
                    <th colspan="2"> <label for="StartDate">Start Date : <span id="StartDate" name="StartDate"></span></label>
                    </th>
                  </tr>
                  <tr>
                    <th colspan="2"> <label for="">Job Order Description</label></th>
                  </tr>
                  <tr>
                    <td colspan="2"><input class="order_input" type="text" id="JobDescription" name="JobDescription" /></td>
                  </tr>
                  <tr>
                    <th> <label for="JobStatus">Time Received</label></th>
                    <th> <label for="TimeReceived">Status</label></th>
                  </tr>
                  <tr>
                    <td><input class="order_input" type="text" id="TimeReceived" name="TimeReceived" readonly /></td>
                    <td><select id="JobStatus" name="JobStatus">
                        <option value="0"><span style="color: blue;">No Assignments</span></option>
                        <option value="1"><span style="color: blue;">Less Assignments than needed</span></option>
                        <option value="3"><span style="color: green;">Enough Assignments</span></option>
                        <option value="4"><span style="color: magenta;">Closed Job Order</span></option>
                        <option value="2"><span style="color: blue;">Close/marked for deletion</span></option>
                      </select></td>
                  </tr>
                  <tr>
                    <th colspan="2"> <label for="">Essential Functions (Duties and Actions)</label></th>
                  </tr>
                  <tr>
                    <td colspan="2"><input class="order_input" type="text" name="" /></td>
                  </tr>
                  <tr>
                    <th colspan="2"> <label for="">Job Order Description</label></th>
                  </tr>
                  <tr>
                    <td colspan="2"><input class="order_input" type="text" id="JobDescription" name="JobDescription" /></td>
                  </tr>
                  <tr>
                    <th> <label for="">Memo</label></th>
                  </tr>
                  <tr>
                    <td><input class="order_input" type="text" id="Memo" name="Memo" /></td>
                  </tr>
                  
                    <td><table>
                        <tr>
                          <th> <label for="">Regular Hours</label></th>
                          <th> <label for="">OT Hours</label></th>
                          <th> <label for=""></label>
                          </th>
                        </tr>
                        <tr>
                          <td><input class="order_input" type="text" id="Orders_RegHours" name="Orders_RegHours" /></td>
                          <td><input class="order_input" type="text" id="Orders_OTHours" name="Orders_OTHours" /></td>
                          <td></td>
                        </tr>
                        <tr>
                          <th> <label for="Orders_RegTimePay">Regular Pay</label></th>
                          <th> <label for="">OT Hours</label></th>
                          <th> <label for=""></label>
                          </th>
                        </tr>
                        <tr>
                          <td><input class="order_input" type="text" id="Orders_RegTimePay" name="Orders_RegTimePay" /></td>
                          <td><input class="order_input" type="text" id="Orders_OTPay" name="Orders_OTPay" /></td>
                          <td></td>
                        </tr>
                      </table></td>
                  </tr>
                  <tr>
                    <th> <label for="">Skills Required</label></th>
                  </tr>
                  <tr>
                    <td><input class="order_input" type="text" name="" /></td>
                  </tr>
                  <tr>
                    <th> <label for="">Dress</label></th>
                  </tr>
                  <tr>
                    <td><input class="order_input" type="text" name="" /></td>
                  </tr>
                  <tr>
                    <td><table>
                        <tr>
                          <th> <label for="">Dress Code</label></th>
                          <th> <label for="">Tools Used</label></th>
                          <th> <label for="">Tools Required</label></th>
                        </tr>
                        <tr>
                          <td><input class="order_input" type="text" name="" /></td>
                          <td><input class="order_input" type="text" name="" /></td>
                          <td><input class="order_input" type="text" name="" /></td>
                        </tr>
                      </table></td>
                  </tr>
                  <tr>
                    <td><table>
                        <tr>
                          <th> <label for="">Physical Tasks</label></th>
                          <th> <label for="">Safety Equipment Required</label></th>
                        </tr>
                        <tr>
                          <td><input class="order_input" type="text" name="" /></td>
                          <td><input class="order_input" type="text" name="" /></td>
                        </tr>
                      </table></td>
                  </tr>
                  <tr>
                    <td><table>
                        <tr>
                          <th> <label for="">Repetitive Motion</label></th>
                          <th> <label for="">Weight Lighting</label></th>
                        </tr>
                        <tr>
                          <td><input class="order_input" type="text" name="" /></td>
                          <td><input class="order_input" type="text" name="" /></td>
                        </tr>
                      </table></td>
                  </tr>
                </table></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td colspan="2"><legend>Billing Info</legend>
          <table id="orderdetails" class="effect1">
            <tr>
              <td><table>
                  <tr>
                    <th colspan="3"> <label for="">Billing Address</label></th>
                  </tr>
                  <tr>
                    <td colspan="3"><input class="order_input" type="text" id="Orders_Bill1" name="Orders_Bill1" /></td>
                  </tr>
                  <tr>
                    <td colspan="3"><input class="order_input" type="text" id="Orders_Bill2" name="Orders_Bill2" /></td>
                  </tr>
                  <tr>
                    <td colspan="3"><input class="order_input" type="text" id="Orders_Bill3" name="Orders_Bill3" /></td>
                  </tr>
                  <tr>
                    <td colspan="3"><input class="order_input" type="text" id="Orders_Bill4" name="Orders_Bill4" /></td>
                  </tr>
                  <tr>
                    <th> <label for="T">Sales Tax Exempt Number</label></th>
                    <th> <label for="TimeReceived">Sales Tax Exempt Number</label></th>
                    <th> <label for="Customers_SuspendService">Suspend Service</label></th>
                  </tr>
                  <tr>
                    <td><input class="order_input" type="text" id="Customers_SalesTaxExemptNo" name="Customers_SalesTaxExemptNo" /></td>
                    <td><input class="order_input" type="text" id="Customers_InvoiceTaxExemptNo" name="Customers_InvoiceTaxExemptNo" /></td>
                    <td><input class="order_input" type="text" id="Customers_SuspendService" name="Customers_SuspendService" /></td>
                  </tr>
                  <tr>
                    <th> <label for=""></label>
                    </th>
                    <th> <label for=""></label>
                    </th>
                    <th> <label for="Customers_ETimeCardStyle">Timecard Style</label></th>
                  </tr>
                  <tr>
                    <td></td>
                    <td></td>
                    <td><input class="order_input" type="text" id="Customers_ETimeCardStyle" name="Customers_ETimeCardStyle" /></td>
                  </tr>
                </table></td>
            </tr>
          </table></td>
      </tr>
      <tr id="pageBreak">
        <td><legend>Work Comp</legend>
          <table id="workcomp" class="effect1">
            <tr>
              <th> <label for="">Work Code</label></th>
              <th> <label for="">Pay Rate</label></th>
              <th> <label for="">Bill Rate</label></th>
              <th> <label for="">Required</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="WorkCode1" name="WorkCode1" /></td>
              <td><input class="order_input" type="text" id="WC1Pay" name="WC1Pay" /></td>
              <td><input class="order_input" type="text" id="WC1Bill" name="WC1Bill" /></td>
              <td><input class="order_input" type="text" id="WC1Required" name="WC1Required" /></td>
            </tr>
            <tr>
              <th> <label for="">Work Code</label></th>
              <th> <label for="">Pay Rate</label></th>
              <th> <label for="">Bill Rate</label></th>
              <th> <label for="">Required</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="WorkCode2" name="WorkCode2" /></td>
              <td><input class="order_input" type="text" id="WC2Pay" name="WC2Pay" /></td>
              <td><input class="order_input" type="text" id="WC2Bill" name="WC2Bill" /></td>
              <td><input class="order_input" type="text" id="WC2Required" name="WC2Required" /></td>
            </tr>
            <tr>
              <th> <label for="">Work Code</label></th>
              <th> <label for="">Pay Rate</label></th>
              <th> <label for="">Bill Rate</label></th>
              <th> <label for="">Required</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="WorkCode3" name="WorkCode3" /></td>
              <td><input class="order_input" type="text" id="WC3Pay" name="WC3Pay" /></td>
              <td><input class="order_input" type="text" id="WC3Bill" name="WC3Bill" /></td>
              <td><input class="order_input" type="text" id="WC3Required" name="WC3Required" /></td>
            </tr>
            <tr>
              <th> <label for="">Work Code</label></th>
              <th> <label for="">Pay Rate</label></th>
              <th> <label for="">Bill Rate</label></th>
              <th> <label for="">Required</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="WorkCode4" name="WorkCode4" /></td>
              <td><input class="order_input" type="text" id="WC4Pay" name="WC4Pay" /></td>
              <td><input class="order_input" type="text" id="WC4Bill" name="WC4Bill" /></td>
              <td><input class="order_input" type="text" id="WC4Required" name="WC4Required" /></td>
            </tr>
            <tr>
              <th> <label for="">Work Code</label></th>
              <th> <label for="">Pay Rate</label></th>
              <th> <label for="">Bill Rate</label></th>
              <th> <label for="">Required</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="WorkCode5" name="WorkCode5" /></td>
              <td><input class="order_input" type="text" id="WC5Pay" name="WC5Pay" /></td>
              <td><input class="order_input" type="text" id="WC5Bill" name="WC5Bill" /></td>
              <td><input class="order_input" type="text" id="WC5Required" name="WC5Required" /></td>
            </tr>
            <tr>
              <th> <label for=""></label>
              </th>
              <th> <label for="">Other Pay</label></th>
              <th> <label for="">Other Bill</label></th>
              <th> <label for="">Other Required</label></th>
            </tr>
            <tr>
              <td></td>
              <td><input class="order_input" type="text" id="OtherPay" name="OtherPay" /></td>
              <td><input class="order_input" type="text" id="OtherBill" name="OtherBill" /></td>
              <td><input class="order_input" type="text" id="OtherRequired" name="OtherRequired" /></td>
            </tr>
            <tr>
              <th colspan="4">Safety Equipment Required</th>
            </tr>
            <tr>
              <th> <label for="">Safety Clothing
                  <input type="checkbox" name="" />
                </label></th>
              <th> <label for="">Hardhat
                  <input type="checkbox" name="" />
                </label></th>
              <th> <label for="">Eye Protection
                  <input type="checkbox" name="" />
                </label></th>
              <th> <label for="">Hearing Protection
                  <input type="checkbox" name="" />
                </label></th>
            </tr>
          </table></td>
        <td><legend style="padding-left: 1em;">Comments</legend>
          <table id="instructions" class="effect1">
            <tr>
              <th> <label for="">Comments / Special Instructions</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" name="" /></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td><legend>Date and Time Info</legend>
          <table id="chronicle" class="effect1">
            <tr>
              <th> <label for="StartDate">Start Date</label></th>
              <th> <label for="StopDate">End Date</label></th>
              <th> <label for="ReportTo ">Report To</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="Orders_StartDate" name="Orders_StartDate" /></td>
              <td><input class="order_input" type="text" id="Orders_StopDate" name="Orders_StopDate" /></td>
              <td><input class="order_input" type="text" id="Orders_ReportTo" name="Orders_ReportTo" /></td>
            </tr>
            <tr>
              <th> <label for="">Work Hours</label></th>
              <th> <label for="Orders_StartTime">Time to Report</label></th>
              <th> <label for="Orders_StopTime">End Time</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="" name="" /></td>
              <td><input class="order_input" type="text" id="Orders_StartTime" name="Orders_StartTime" /></td>
              <td><input class="order_input" type="text" id="Orders_StopTime" name="Orders_StopTime" /></td>
            </tr>
          </table></td>
        <td><legend style="padding-left: 1em;">Rate Info</legend>
          <table id="rates" class="effect1">
            <tr>
              <th> <label for="">Pay Rate</label></th>
              <th> <label for="CustomerRates_RegBill">Bill Rate</label></th>
              <th> <label for="">Multiplier</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="" name="" /></td>
              <td><input class="order_input" type="text" id="CustomerRates_RegBill" name="CustomerRates_RegBill" /></td>
              <td><input class="order_input" type="text" id="" name="" /></td>
            </tr>
            <tr>
              <th> <label for="CustomerRates_RegPay">Pay Rate</label></th>
              <th> <label for="CustomerRates_OtBill">OT Bill</label></th>
              <th> <label for="">Multiplier</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" id="CustomerRates_RegPay" name="CustomerRates_RegPay" /></td>
              <td><input class="order_input" type="text" id="CustomerRates_OtBill" name="CustomerRates_OtBill" /></td>
              <td><input class="order_input" type="text" id="" name="" /></td>
            </tr>
            <tr>
              <th colspan="3"> <label for="CustomerRates_Comment">Rates Comments</label></th>
            </tr>
            <tr>
              <td colspan="3"><input class="order_input" type="text" id="CustomerRates_Comment" name="CustomerRates_Comment" /></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td colspan="2"><legend>Service Calls</legend>
          <table id="servicecalls" class="effect1">
            <tr>
              <th> <label for="">Customer Service Calls / Date (used to create appointments)</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" name="" /></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td colspan="2"><legend>Placements</legend>
          <table id="placements" class="effect1">
            <tr>
              <th> <label for="">Start<br />
                  Date</label></th>
              <th> <label for="">End <br />
                  Date</label></th>
              <th> <label for=""> <br />
                  Name</label></th>
              <th> <label for="">Telephone<br />
                  or Message</label></th>
              <th> <label for="">Pay<br />
                  Rate</label></th>
              <th> <label for="">Pay<br />
                  Rate</label></th>
              <th> <label for="">Pay<br />
                  Rate</label></th>
              <th> <label for=""> <br />
                  Weekly Service Calls</label></th>
            </tr>
            <tr>
              <td><input class="order_input" type="text" name="" /></td>
              <td><input class="order_input" type="text" name="" /></td>
              <td><input class="order_input" type="text" name="" /></td>
              <td><input class="order_input" type="text" name="" /></td>
              <td><input class="order_input" type="text" name="" /></td>
              <td><input class="order_input" type="text" name="" /></td>
              <td><input class="order_input" type="text" name="" /></td>
              <td><input class="order_input" type="text" name="" /></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td colspan="2"><legend>Order Activities</legend>
          <table id="orderactivities" class="effect1">
            <tr>
              <td><div id="orderactivities"></div></td>
            </tr>
          </table></td>
      </tr>
    </table>
	<input type="hidden" id="frm_site" name="frm_site" />
	<input type="hidden" id="frm_customer" name="frm_customer" />
	<input type="hidden" id="frm_reference" name="frm_reference" />
	<input type="hidden" id="frm_dept" name="frm_dept" />
	<input type="text" id="page_title" name="page_title" />
  </form>
</div>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' --> 
