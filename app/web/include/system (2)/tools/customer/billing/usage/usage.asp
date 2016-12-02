<%
session("add_css") = "./usage.001.css"
session("required_user_level") = 256 'userLevelSupervisor
session("window_page_title") = "Customer Usage Report - Personnel Plus"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="usage.js"></script>
<!-- #include file='usage.doStuff.asp' -->

<!-- begin presentation stuff -->
<form id="report_form" name="report_form" action="<%=aspPageName%>" method="get">
<%=decorateTop("track_activities", "notToShort marLR10", report_title)%>
<div id="mainReportBody">

  	<table id="enter_dates" class="<%=show_date_form%>">
		<tr><td id="fromdate">
	     	<label style="float:left; clear:left" for="fromDate">From Date</label>
			<input  style="float:left; clear:left" name="fromDate" id="fromDate" type="text" value="<%=CustomerUsage.FromDate%>" onKeyPress="return submitenter(this,event)">
		</td><td id="todate">
			<label for="toDate" style="float:left; clear:left">To Date</label>
			<input  style="float:left; clear:left" name="toDate" id="toDate" type="text" value="<%=CustomerUsage.ToDate%>" onKeyPress="return submitenter(this,event)">
		</td>
		<td id="refreshview">
	     	<a class="squarebutton" href="#" onclick="act_refresh();"><span>Refresh View</span></a>
		</td>
		</tr>
	</table>
	<input type="hidden" value="<%=CustomerUsage.Page%>" name="Page" id="Page" />

<%=persist_simulation%>	
<%=PageNavigation%>
<%
dim LastReference      : LastReference = 0
dim LastDepartment     : LastDepartment = 0
dim LastSummaryId      : LastSummaryId = 0
dim firstloop          : firstloop = true
dim department_total   : department_total = 0
dim strRunningTotal

for each Summary in CustomerUsage.Summary.Items
	if LastReference <> Summary.Reference then
		if not firstloop then
%>		
			<table class="account_activity departmenttotal">
				<tr>
					<th class="moredetail">&nbsp;</th>
					<th class="invoice">&nbsp;</th>
					<th class="invoicedate">&nbsp;</th>
					<th class="description">&nbsp;</th>
					<th class="document">Sub-Total:&nbsp;</th>
					<th class="hours"><%=TwoDecimals(TotalHours.HoursSummary.Item(LastDepartment & ":" & LastReference).SumOfHours)%></th>
					<th class="amount">&nbsp;$<%=TwoDecimals(TotalHours.HoursSummary.Item(LastDepartment & ":" & LastReference).SumOfBilled)%></th>
					<th class="rtotal">&nbsp;</th>
				</tr>
			</table>
<%
			if LastDepartment <> Summary.JobNumber then 
				LastDepartment = Summary.JobNumber
				running_total = 0
			end if
		else
			LastDepartment = Summary.JobNumber
			LastReference = Summary.Reference
		end if
		firstloop = false
%>
		<table class="account_activity department">
			<tr>
				<td class="jobnumber"><%=Summary.JobNumber%>&nbsp;:&nbsp;<%=Summary.Reference%>&nbsp;-&nbsp;</td>
				<td class="jobdescription"><%=Summary.JobDescription%></td>
			</tr>
		</table>
		<table id="accnt_heading" class="account_activity headings">
			<tr>
				<th class="moredetail">&nbsp;</th>
				<th class="invoice">Invoice</th>
				<th class="invoicedate">Date</th>
				<th class="description">Description</th>
				<th class="document">Document</th>
				<th class="hours">Hours</th>
				<th class="amount">Billed</th>
				<th class="rtotal">Running<br />Total</th>
			</tr>
		</table>
	
<%
		LastReference = Summary.Reference

	end if
	invoice_number = Summary.Invoice
	if Summary.SummaryId <> LastSummaryId then
		running_total = running_total + Summary.Total
	end if
	
	department_total = department_total + Summary.Total
	
	' chk_box = "<input type=""checkbox"" name=""ck_boxes"" id=""ck_" &  row_number & """  value=""" & invoice_number & """ onclick=""setPayAmount();"">" &_
						' "<input type=""hidden"" name=""inv_" & invoice_number & """ value=""" & itotal & """>"
	chk_box = ""

	lnk_open = "<a href=""javascript:;"" onclick=""getInvoice.open('" & row_number & "', '" & invoice_number & "', '" & CustomerUsage.CompanyId & "', '" & CustomerUsage.CustomerCode & "');"">"  
	
	if row_number MOD 2	= 0 then
		row_shade = " even"
	else
		row_shade = " odd"
	end if
	
	'check if additional summary detail
	if Summary.SummaryId <> LastSummaryId then
		strRunningTotal = "$" & cstr(TwoDecimals(running_total))
	else
		strRunningTotal = ""
	end if
%>
		<table id="row_<%=row_number%>_summary" class="account_activity<%=row_shade%>">
			<tr>
				<td class="moredetail" id="row_for_inv_<%=invoice_number%>"><%=lnk_open%><span class="plusexpand">&nbsp;</span><%=lnk_close%></td>
				<td class="invoice"><%=Summary.HTMLInvoiceLink%></td>
				<td class="invoicedate"><%=Summary.InvoiceDate%></td>
				<td class="description"><%=Summary.Description%></td>
				<td class="document"><%=Summary.Document%></td>
				<td class="hours"><%=TwoDecimals(Summary.TotalHours)%></td>
				<td class="amount">$<%=TwoDecimals(Summary.Total)%></td>
				<td class="rtotal"><%=strRunningTotal%></td>
			</tr>
		</table>
			
		<div id="line_<%=row_number%>_detail" class="hide<%=row_shade%>">&nbsp;
			<input type="hidden" class="inv_chk" name="invoice<%=row_number%>" id="invoice<%=row_number%>" value="<%=invoice_number%>">
		</div>
<%
		row_number = row_number + 1
		LastSummaryId = Summary.SummaryId

next
%>
	<table class="account_activity departmenttotal">
		<tr>
			<th class="moredetail">&nbsp;</th>
			<th class="invoice">&nbsp;</th>
			<th class="invoicedate">&nbsp;</th>
			<th class="description">&nbsp;</th>
			<th class="document">Sub-Total:&nbsp;</th>
			<th class="subhours"><%=TwoDecimals(TotalHours.HoursSummary.Item(LastDepartment & ":" & LastReference).SumOfHours)%></th>
			<th class="subamount">&nbsp;$<%=TwoDecimals(TotalHours.HoursSummary.Item(LastDepartment & ":" & LastReference).SumOfBilled)%></th>
			<th class="rtotal">&nbsp;</th>
		</tr>
		<tr>
			<td colspan="4"></td>
			<td class="cd">Grand Total:</td>
			<td class="cf">&nbsp;$<%=TwoDecimals(TotalHours.GrandTotal)%></td>
		</tr>
	</table>
</div>
	<input type="hidden" name="how_many_invoices" id="how_many_invoices" value="<%=row_number%>">
			
<%
Set AccountActivity = nothing
%>

</form>
<%=DecorateBottom()%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
