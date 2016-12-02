<%
session("add_css") = "general.asp.css" %>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<% FormPostTo = "/include/system/include/system/tools/activity/forms/maintainRequisitions.asp?Action=" %>
<!-- Revised: 07.23.2008 -->
<style type="text/css">
@import url(/include/functions/calendar/calendar-blue2.css);
</style>
<script type="text/javascript" src="/include/functions/calendar/calendar.js"></script>
<script type="text/javascript" src="/include/functions/calendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar-setup.js"></script>
<script type="text/javascript">
<!--
function confirmDelete(reqID)
{
 var where_to= confirm("Do you really want to delete this Job Requisition?");
 if (where_to== true)
 {
   window.location="<%=FormPostTo & remove & "&ReqID="%>" + reqID;
 }
}

function submitLink(theForm, theName, theValue) {

	theForm.elements[theName].value = theValue;
	document.forms[theForm].submit()
	theForm.submit();
}

//-->
</SCRIPT>
<%

const linkImgRequisition = "<img style='border:none;' src='/include/style/images/ico_requisition.gif'>"

formAction = request.form("formAction")
if formAction =  "Update Requisition" Or formAction = "Revert Back" then
	SubmitValue = "Update Requisition"
	ResetValue = "Revert Back"
Else
	SubmitValue = "Create Requisition"
	ResetValue = "Start Over"
end if

if CheckForm = true And request.form("formAction") = "Create Requisition" then 
	CreateRequisition
	ShowRequisitions
elseif CheckForm = true And request.form("formAction") = "Update Requisition" then
	UpdateRequisition
	ShowRequisitions
end if

if request.form("task") = "Delete Selected" then RemoveRequisitions

if Request.QueryString("NewReqID") > 0 then
	ShowReqCreateSuccessfull
end if

Select Case Trim(Request.QueryString("Action")) 
	Case remove
		DeleteRequisition Request.QueryString("ReqID")
		ShowRequisitions
	Case manage
		ShowRequisitions
	Case Else
		ShowRequisitionForm
End Select

TheEnd

Sub ShowRequisitionForm
dim UserName, FirstName, MiddleName, LastName, AddressOne, AddressTwo, City, UserState, ZipCode, Country, PrimaryPhone, SecondaryPhone, eMail, ReeMail

formAction = request.form("formAction")
if formAction = "Update Requisitions" then
	SubmitValue = "Update Requisition"
	ResetValue = "Revert Back"
Else
	SubmitValue = "Create Requisition"
	ResetValue = "Start Over"
end if

Select Case Trim(formAction)
	Case "Update Requisition"
		if CheckForm = true then
			UpdateRequisition
		end if	
	Case "Create Requisition"
		if CheckForm = true then
			CreateRequisition
		end if
End Select

if request.form("task") = "Delete Selected" then ShowLocations

if Request.QueryString("action") = add then
	if request.form("formAction") <> "Start Over" then
		jobtitle = request.form("jobtitle")
		startdate = request.form("startdate")
		enddate = request.form("enddate")
		workers = request.form("workers")
		location = request.form("location")
		interview = request.form("interview")
		category = request.form("category")
		license = request.form("license")
		wage = request.form("wage")
		wagetype = request.form("wagetype")
		schedule = request.form("schedule")
		dresscode = request.form("dresscode")
		lunch = request.form("lunch")
		breaks = request.form("breaks")
		comments = request.form("comments")
	end if
elseif Request.QueryString("action") = view then
	SubmitValue = "Update Requisition"
	ResetValue = "Revert Back"
	
	Database.Open MySql

	Set dbQuery = Database.Execute("Select * From tbl_jobRequisitions Where requisitionID=" & Request.QueryString("RequisitionID"))
	jobtitle = dbQuery("jobtitle")
	startdate = dbQuery("startdate")
	enddate = dbQuery("enddate")
	workers = dbQuery("workers")
	interview = dbQuery("interview")
	category = dbQuery("category")
	license = dbQuery("license")
	wage = dbQuery("wage")
	wagetype = dbQuery("wagetype")
	schedule = dbQuery("schedule")
	dresscode = dbQuery("dresscode")
	lunch = dbQuery("lunch")
	breaks = dbQuery("breaks")
	comments = dbQuery("comments")
	requisitionID = dbQuery("requisitionID")
	lastmodified = dbQuery("lastmodified")
	location = dbQuery("addressID")
	department = dbQuery("departmentID")

	Database.Close
	Set dbQuery = Nothing
end if
	%>
<form id="requisition" name="requisition" method="post" action="<%=FormPostTo & add%>">
	<div class="bordered">
		<h2>Job Requisition Detail</h2>
		<div class="pageSubContent">
			<p>
				<label for="jobtitle">Position Title</label>
				<input type="text" id="jobtitle" name="jobtitle" value="<%=jobtitle%>">
					<script type="text/javascript">
						<!--
					  document.requisition.jobtitle.focus()
						//-->
					</script>
			</p>
			<p class="formErrMsg"><%=CheckField("jobtitle")%></p>
			<p>
				<label for="workers">Quantity</label>
				<input type="text" name="workers" value="<%=workers%>">
			</p>
			<p class="formErrMsg"><%=CheckField("workers")%></p>
			<p>
				<label for="f_startdate">Start Date</label>
				<input type="text" id="f_startdate" name="startdate" value="<%=startdate%>" onfocus="calendar.create();">
				<script type="text/javascript">
				Calendar.setup({
				inputField : "f_startdate", //*
				ifFormat : "%m/%d/%Y",
				showsTime : false,
				button : "f_trigger_b", //*
				step : 1,
				eventName : "focus",
				});
			</script>
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="f_enddate">End Date</label>
				<input type="text" id="f_enddate" name="enddate" value="<%=enddate%>">
				<script type="text/javascript">
				Calendar.setup({
				inputField : "f_enddate", //*
				ifFormat : "%m/%d/%Y",
				showsTime : false,
				button : "f_trigger_b", //*
				step : 1,
				eventName : "focus",
				});
			</script>
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="location">Location <a class="smallTxt" href="/include/system/tools/system/managelocations/manageLocations.asp?Action=1">[Add]</a></label>
				<select name="location">
					<%=populateList("tbl_locations", "addressID", "description", "Where companyID=" & companyId & " Order By description", location)%>
				</select>
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="department">Department <a class="smallerTxt" href="/include/system/tools/system/managedepartments/manageDepartments.asp?Action=1">[Add]</a></label>
				<select name="department">
					<option value="0">-- Department Not Assigned --</option>
					<%=PopulateList("tbl_departments Where companyID=" & companyId, "departmentID", "name", "Order By name", department)%>
				</select>
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="interview">Interview Canidate?</label>
				<select name="interview">
					<%=populateList("list_miscellaneous", "valueInterview", "labelInterview", "", interview)%>
				</select>
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="category">Select General Job Category</label>
				<select name="category">
					<option value="" selected="selected">-- General Job Category --</option>
					<%=populateList("list_jobCategories", "catValue", "catLabel", "Order By catLabel", category)%>
				</select>
			</p>
			<p class="formErrMsg"><%=CheckField("category")%></p>
			<p>
				<label for="license">Drivers License Needed?</label>
				<select name="license">
					<%=populateList("list_miscellaneous", "valueDL", "labelDL", "Order By labelDL DESC", license)%>
				</select>
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="wage">$ Wage Amount</label>
				<input type="text" name="wage" value="<%=TwoDecimals(wage)%>">
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="wagetype">Type of Wage</label>
				<select name="wagetype">
					<option value="">-Type-</option>
					<%=populateList("list_miscellaneous", "valueWageType", "labelWageType", "", wagetype)%>
				</select>
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="schedule">Position</label>
				<select name="schedule">
					<option value="">---</option>
					<%=populateList("list_miscellaneous", "valuePositionType", "labelPositionType", "", schedule)%>
				</select>
			</p>
		</div>
		<div class="normalTitle" style="margin-bottom:10;">Worker and Additional Information</div>
		<div class="pageSubContent">
			<p>
				<label for="dresscode">Dress Code</label>
				<select name="dresscode">
					<OPTION VALUE="">-- Select Dress Code --</OPTION>
					<%=populateList("list_miscellaneous", "valueDress", "labelDress", "Order By labelDress DESC", dresscode)%>
				</SELECT>
			</p>
			<p class="formErrMsg"><%=CheckField("dresscode")%></p>
			<p>
				<label for="lunch">Lunch Information</label>
				<SELECT NAME="lunch">
					<OPTION VALUE="">-- Job Lunch Information --</OPTION>
					<%=populateList("list_miscellaneous", "valueLunch", "labelLunch", "Order By labelLunch DESC", lunch)%>
				</SELECT>
			</p>
			<p class="formErrMsg"><%=CheckField("lunch")%></p>
			<p>
				<label for="breaks">Break Information</label>
				<SELECT NAME="breaks">
					<OPTION VALUE="">-- Job Break Information --</OPTION>
					<%=populateList("list_miscellaneous", "valueBreak", "labelBreak", "Order By labelBreak DESC", breaks)%>
				</SELECT>
			</p>
			<p class="formErrMsg"><%=CheckField("breaks")%></p>
			<p>
				<label for="comments">Additional Comments, Instructions and/or Directions</label>
				<textarea name="comments" id="comments"><%=comments%></textarea>
			</p>
		</div>
	</div>
	<p style="text-align:right;">
		<input type="hidden" name="formAction" value="">
		<input type="hidden" name="requisitionID" value="<%=requisitionID%>">
		<input type="hidden" name="lastmodified" value="<%=lastmodified%>">
	<div class="buttonwrapper" style="padding:10px 0 10px 0;">
		<%
		if SubmitValue = "Update Requisition" then 
			createNew = "Submit As A New Requisition" %>
			<a class="squarebutton" href="javascript:;" style="margin-left:6px" onclick="document.requisition.formAction.value='Update Requisition';document.forms['requisition'].submit();"><span>Update Requisition</span></a>
		<%
		Else
		 createNew = "Submit New Requisition"
		End if %>
		<a class="squarebutton" href="javascript:;" onclick="document.requisition.formAction.value='Create Requisition';document.forms['requisition'].submit();" style="margin-left: 6px"><span><%=createNew%></span></a> <a class="squarebutton" href="javascript:;" style="margin-left: 6px" onclick="document.forms['requisition'].reset();"><span><%=ResetValue%></span></a> <a class="squarebutton" href="<%=FormPostTo & manage%>"><span>Return To Requisition Center</span></a> </div>
</form>
<%
End Sub 

Sub ShowRequisitions	%>
<form method="post" action="/include/system/include/system/tools/activity/forms/maintainRequisitions.asp?Action=<%=add%>">
<div class="bordered">
	<div class="normalTitle">Job Requisitions</div>
	<div class="pageSubContent">
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td width="4%"></td>
				<td width="4%"></td>
				<td width="4%"></td>
				<td width="15%"><b>Modified</b></td>
				<td width="9%"><b>ID</b></td>
				<td width="51%"><b>Position Title</b></td>
				<td width="16%"><b>Status</b></td>
				<td width="2%"><center>
						<b>!</b>
					</center></td>
				</td>
			</tr>
			<%
			Database.Open MySql
			set dbQuery = Database.Execute("Select requisitionID, lastmodified, jobTitle, status, CreationDate From tbl_jobRequisitions Where companyID=" & companyId & " Order By lastmodified Desc")
	
			do while not dbQuery.eof
				reqID = dbQuery("requisitionID")
				lastModified = dbQuery("lastmodified")
				jobTitle = dbQuery("jobTitle")
				reqStatus = dbQuery("status")	
				smallDate = lastModified
				ReqLink = FormPostTo & view & "&amp;RequisitionID="
				if len(smallDate) > 0 then smallDate = Mid(smallDate, 1, Instr(smallDate, " ")-1)
				if lastModified > dbQuery("CreationDate") then 
					updateAlert = "<img style='padding-right:4px;' src='/include/style/images/flashing_light.gif' height='10' width='10'>"
				Else
					updateAlert	= ""
				end if	%>
			<tr>
				<td><input type="checkbox" class="borNone" name="checkbox<%=reqID%>" value="checkbox" id="checkbox<%=reqID%>"></td>
				<td><img style="border:none; cursor:pointer" src="/include/style/images/ico_msgDelete.gif" onClick="confirmDelete(<%=reqID%>);"></td>
				<td><a href="<%= ReqLink & reqID%>"><img style="border:none; cursor:pointer" src="/include/style/images/ico_msgDetail.gif"></a></td>
				<td><a href="<%= ReqLink & reqID%>"><%=smallDate%></a></td>
				<td><a href="<%= ReqLink & reqID%>"><%=reqID%></a></td>
				<td><a href="<%= ReqLink & reqID%>"><%=jobTitle%></a></td>
				<td><a href="<%= ReqLink & reqID%>"><%=reqStatus%></a></td>
				<td><%=updateAlert%></td>
			</tr>
			<%
				dbQuery.Movenext
			loop
			Database.Close()
			Set dbQuery=Nothing
			%>
		</table>
	</div>
</div>
<div class="buttonwrapper" style="padding:10px 0 10px 0;"><a class="squarebutton" href="/include/system/include/system/include/system/tools/activity/forms/maintainRequisitions.asp?Action=<%=Add%>" style="margin-left: 6px"><span>Submit New Requisition</span></a> <a class="squarebutton" href="javascript:;" onclick="document.forms['SignIn'].submit();"><span>Delete Selected</span></a> </div>
<%
End Sub

Function CheckForm
	LooksGood = true
	if CheckField("jobtitle") <> "&nbsp;" then LooksGood = false
	if CheckField("workers") <> "&nbsp;" then LooksGood = false
	if CheckField("category") <> "&nbsp;" then LooksGood = false
	if CheckField("dresscode") <> "&nbsp;" then LooksGood = false
	if CheckField("lunch") <> "&nbsp;" then LooksGood = false
	if CheckField("breaks") <> "&nbsp;" then LooksGood = false

	if LooksGood = false then
		CheckForm = false
	Else
		CheckForm = true
	end if
End Function

Function CheckField (FormField)
	TempValue = ""
	Select Case	FormField
		Case "jobtitle"
			if request.form("jobtitle") = "" then
				TempValue = "Please enter a title for this position"
			end if

		Case "workers"
			if request.form("workers") = "" then
				TempValue = "How many workers?"
			end if

		Case "location"
			if request.form("location") = "" then
				TempValue = "Where do you need workers?"
			end if

		Case "interview"
			if request.form("interview") = "" then
				TempValue = "Interview Placement Canidate?"
			end if
		Case "category"
			if request.form("category") = "" then
				TempValue = "Choose the closest category."
			end if

		Case "license"
			if request.form("license") = "" then
				TempValue = "Will the canidate be driving?"
			end if
	
		Case "dresscode"
			if request.form("dresscode") = "" then
				TempValue = "Any dress code preference?"
			end if
			Case "lunch"
			if request.form("lunch") = "" then
				TempValue = "Work Lunch Break Information"
			end if
		Case "wage"
			if request.form("wage") = "" then
				TempValue = "Wage Information Needed"
			end if
		Case "breaks"
			if request.form("breaks") = "" then
				TempValue = "What kind of breaks?"
			end if
	End Select	

	if len(request.form("formAction")) = 0 Or len(request.form("formAction")) = 22 then TempValue = ""
	if TempValue = "" then
		CheckField = "&nbsp;"
	Else
		CheckField = TempValue
	end if
End Function

Sub ShowReqCreateSuccessfull
	%>
<div class="bordered">
	<div class="normalTitle bottommargin">Create Job Requisition</div>
	<p style="text-align:center">Job Requisition Was Created Successfully.</p>
	<p style="text-align:center; margin-bottom:10;">Personnel Plus VMS ID is <%=Request.QueryString("NewReqID")%></p>
	<br>
	<p style="text-align:center; margin-bottom:10;">Canidates will be notified and sent shortly.</p>
</div>
<%
End Sub

Sub ShowReqApproved (ReqID)
	Set Database=Server.CreateObject("ADODB.Connection")
	Database.Open MySql
	set dbQuery=Database.Execute("UPDATE tbl_jobRequisitions SET status='Approved', lastmodified='" & now() & "' WHERE requisitionID=" & ReqID)
	Database.Close
	%>
<div style="float:right; width:450;border: 1px solid #97A4B3;margin-right:10;">
	<div class="normalTitle" style="margin-bottom:10;">Approve Job Requisition Order</div>
	<p style="text-align:center; margin-bottom:10;">Job Requisition Order Has Been Approved.</p>
</div>
<div style="float:right;width:450;height:10;border:none;margin-right:10;">
	<p style="text-align:center">&nbsp;</p>
</div>
<%
End Sub

Sub ShowReqRejected (ReqID)
	Set Database=Server.CreateObject("ADODB.Connection")
	Database.Open MySql
	set dbQuery=Database.Execute("UPDATE tbl_jobRequisitions SET status='Rejected', lastmodified='" & now() & "' WHERE requisitionID=" & ReqID)
	Database.Close
	%>
<div style="float:right; width:450;border: 1px solid #97A4B3;margin-right:10;">
	<div class="normalTitle bottommargin">Reject Job Requisition Order</div>
	<p style="text-align:center; margin-bottom:10;">Job Requisition Order Has Been Rejected.</p>
</div>
<div style="float:right;width:450;height:10;border:none;margin-right:10;">
	<p style="text-align:center">&nbsp;</p>
</div>
<%
End Sub

Sub DeleteRequisitions
End Sub

Sub DeleteRequisition (ReqID)
	'
	'Need some code to verify user, and authorization to delete records
	'
	if user_level > userLevelSupervisor then
		Database.Open MySql
		set dbQuery = Database.Execute("Delete From tbl_jobRequisitions Where requisitionID=" & ReqID)
		Database.Close
		%>
<div class="bordered" style="margin:0 0 10px;padding:0 0 10px">
	<div class="normalTitle bottommargin">Delete Job Order Requisition</div>
	<p style="text-align:center; margin-bottom:10;">Job Requisition Order Has Been Deleted.</p>
</div>
<%
	end if	
End Sub

Sub RequisitionPrintView (ReqID)
	if request.form("ApproveRequisition") = "true" then 
		ShowReqApproved ReqID
	elseif request.form("RejectRequisition") = "true" then
		ShowReqRejected ReqID
	end if
	Set Database=Server.CreateObject("ADODB.Connection")
	Database.Open MySql
	
	'Req Information
	set dbQuery=Database.Execute("Select * From tbl_jobRequisitions Where requisitionID=" & ReqID)
	if Not dbQuery.eof then
		ReqCompanyID = CStr(dbQuery("companyID"))
		ReqUserID = CStr(dbQuery("userID"))
		ReqAddressID = CStr(dbQuery("addressID"))
		ReqApprovers = dbQuery("assistingIDs")
		ReqJobtitle = dbQuery("jobtitle")
		ReqWorkers = CStr(dbQuery("workers"))
		ReqInterview = dbQuery("interview")
		ReqCategory = dbQuery("category")
		ReqStartDate = dbQuery("startdate")
		ReqEndDate = dbQuery("enddate")
		ReqWage = "$ " & dbQuery("wage") & " / " & dbQuery("wagetype") & " / " & dbQuery("schedule")
		ReqComments = dbQuery("comments")
		ReqDriving = dbQuery("license")
		ReqDressLunchBreaks = dbQuery("dresscode") & "<br>" & dbQuery("lunch") & "<br>" & dbQuery("breaks")
		ReqStatus = dbQuery("status")
		ReqModified = dbQuery("lastmodified")
		ReqCreated = dbQuery("CreationDate")
	end if
	Set dbQuery=Nothing
	set dbQuery=Database.Execute("Select * From tbl_addresses Where addressID=" & ReqAddressID)
	if Not dbQuery.eof then
		ReqLocation = dbQuery("addressName") & "<br>" & dbQuery("address") & "<br>"
		if len(dbQuery("addressTwo")) >0 then ReqLocation = ReqLocation & dbQuery("addressTwo") & "<br>"
		ReqLocation = ReqLocation & dbQuery("city") & ", " & dbQuery("state") & " " & dbQuery("zip")
	end if
	Set dbQuery=Nothing

	'Req Company Information
	set dbQuery=Database.Execute("Select * From tbl_companies Where companyID=" & ReqCompanyID)
	if Not dbQuery.eof then
		ReqCompanyAddressID = dbQuery("addressID")
		ReqCompanyName = dbQuery("companyName")
		ReqCompanyPrimaryPhone = dbQuery("companyPhone")	
		ReqCompanySecondaryPhone = dbQuery("companySPhone")
		ReqCompanyCreated = dbQuery("CreationDate")
	end if
	Set dbQuery=Nothing
	set dbQuery=Database.Execute("Select * From tbl_addresses Where companyID=" & ReqCompanyAddressID)
	if Not dbQuery.eof then
		ReqCompanyLocation = dbQuery("addressName") & "<br>" & dbQuery("address") & "<br>"
		if len(dbQuery("addressTwo")) >0 then ReqCompanyLocation = ReqCompanyLocation & dbQuery("addressTwo") & "<br>"
		ReqCompanyLocation = ReqCompanyLocation & dbQuery("city") & ", " & dbQuery("state") & " " & dbQuery("zip")
	end if
	Set dbQuery=Nothing
	
	'Req Owner Information	
	set dbQuery=Database.Execute("Select * From tbl_users Where userID=" & ReqUserID)
	if Not dbQuery.eof then
		ReqOwnerName = dbQuery("lastName") & ", " & dbQuery("firstName")
		ReqOwnerEmail = dbQuery("userEmail")
		ReqOwnerAddressID = dbQuery("addressID")	
		ReqOwnerPhone = dbQuery("userPhone")
		ReqOwnerSPhone = dbQuery("userSPhone")
	end if
	Set dbQuery=Nothing
	set dbQuery=Database.Execute("Select * From tbl_addresses Where addressID=" & ReqOwnerAddressID)
	if Not dbQuery.eof then
		ReqOwnerLocation = dbQuery("addressName") & "<br>" & dbQuery("address") & "<br>"
		if len(dbQuery("addressTwo")) >0 then ReqOwnerLocation = ReqOwnerLocation & dbQuery("addressTwo") & "<br>"
		ReqOwnerLocation = ReqOwnerLocation & dbQuery("city") & ", " & dbQuery("state") & " " & dbQuery("zip")
	end if
	Set dbQuery=Nothing
	
	'Parse Approvers
	'
	ReqApprovers = ReqApprovers & ","
	'Count Number of approvers
	StrPos=1
	Do Until StrPos => len(ReqApprovers)
		StrPos = Instr(StrPos, ReqApprovers, ",") + 1
		NumOfApprovers = NumOfApprovers + 1
	loop
	Redim Approver(4, NumOfApprovers - 1)

	StrPos=1 : NumOfApprovers = 0 : ID = 0 : ApproverName = 1 : Email = 2 : Phone = 3 : APhone = 4
	Do Until StrPos => len(ReqApprovers)
		Approver(ID, NumOfApprovers) = Mid(ReqApprovers, StrPos, (Instr(StrPos, ReqApprovers, ",")-StrPos))
		set dbQuery=Database.Execute("Select * From tbl_users Where userID=" & Approver(ID, NumOfApprovers))
		if Not dbQuery.eof then
			Approver(ApproverName, NumOfApprovers) = dbQuery("lastName") & ", " & dbQuery("firstName")
			Approver(Email, NumOfApprovers) = dbQuery("userEmail")	
			Approver(Phone, NumOfApprovers) = dbQuery("userPhone")
			Approver(APhone, NumOfApprovers) = dbQuery("userSPhone")
		end if
		Set dbQuery=Nothing
		StrPos = Instr(StrPos, ReqApprovers, ",") + 1
		NumOfApprovers = NumOfApprovers + 1
	loop
	
	Set dbQuery=Nothing
	Database.Close
	'
	'
	'Security Verification Code Goes Here
	'
	'
	'Possible viewing modes, Creator, PPlus, Administrator, Unauthorized, Etc
	PageTitle = "Job Requisition " & ReqID & ", Created on " & ReqCreated
	%>
<div class="sideMargin">
	<div class="sideMargin">
		<div class="normalTitle" style="margin-bottom:5px;"><%=PageTitle%></div>
		<table cellpadding="0" cellspacing="3" width="100%">
			<tr>
				<td width="100%"><strong>Assignment Logistics</strong></td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="3" width="100%">
			<tr>
				<td style="padding-left:10;" width="20%"><em>Company </em></td>
				<td width="45%"><%=ReqCompanyName%></td>
				<td style="padding-left:10;" width="15%"><em>Phone</em></td>
				<td width="20%"><%=ReqCompanyPrimaryPhone%></td>
			</tr>
			<tr>
				<td style="padding-left:10;"><em>E-Mail</em></td>
				<td><%=ReqOwnerEmail%></td>
				<td style="padding-left:10;"><em>Alternate</em></td>
				<td><%=ReqCompanySecondaryPhone%></td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="3" width="100%" style="padding-left:10; padding-top:10;">
			<tr style="padding-top:1px;">
				<td style="padding-left:10;" width="20%"></td>
				<td width="40%"></td>
				<td width="15%">&nbsp;</td>
				<td width="25%"></td>
			</tr>
			<tr>
				<td style="padding-left:10;"><em>Job Title</em></td>
				<td><%=ReqJobtitle%></td>
				<td style="padding-left:10;"><em></em></td>
				<td></td>
			</tr>
			<tr>
				<td style="padding-left:10;"><em>Start Date</em></td>
				<td><%=ReqStartDate%></td>
				<td style="padding-left:10;"><em>End</em></td>
				<td><%=ReqEndDate%></td>
			</tr>
			<tr>
				<td style="padding-left:10;"><em>Category</em></td>
				<td><%=ReqCategory%></td>
				<td style="padding-left:10;"><em>Num Of Workers</em></td>
				<td align="center"><%=ReqWorkers%></td>
			</tr>
			<tr>
				<td valign="top" style="padding-left:10;"><em>Location</em></td>
				<td><%=ReqLocation%></td>
				<td style="padding-left:10;"><em>Dress<br>
					Lunch<br>
					Breaks</em></td>
				<td><%=ReqDressLunchBreaks%></td>
			</tr>
			<tr>
				<td style="padding-left:10;"><em>&nbsp;</em></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td style="padding-left:10;"><em>Wage Info</em></td>
				<td><%=ReqWage%></td>
				<td style="padding-left:10;"><em>Driving</em></td>
				<td><%=ReqDriving%></td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="3" width="100%">
			<tr>
				<td style="padding-left:10;" width="20%"></td>
				<td width="80%"></td>
			</tr>
			<tr>
				<td style="padding-left:10;"><em>Comments</em></td>
				<td><%=ReqComments%></td>
		</table>
	</div>
	<div class="sideMargin">
		<table cellpadding="0" cellspacing="3" width="100%">
			<tr>
				<td width="100%"><strong>Contact Information</strong></td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="3" width="100%">
			<tr>
				<td style="padding-left:10;" width="15%"><em>Name</em></td>
				<td width="45%"><%=ReqOwnerName%></td>
				<td style="padding-left:10;" width="15%"><em>Phone</em></td>
				<td width="25%"><%=ReqOwnerPhone%></td>
			</tr>
			<tr>
				<td style="padding-left:10;"><em>E-Mail</em></td>
				<td><%=ReqOwnerEmail%></td>
				<td style="padding-left:10;"><em>Alternate</em></td>
				<td><%=ReqOwnerSPhone%></td>
			</tr>
			<tr>
				<td><em>&nbsp;</em></td>
				<td></td>
				<td style="padding-left:10;"></td>
				<td></td>
			</tr>
			<tr>
				<td valign="top" style="padding-left:10;"><em>Location</em></td>
				<td><%=ReqOwnerLocation%></td>
				<td style="padding-left:10;"></td>
				<td></td>
			</tr>
		</table>
	</div>
	<div class="sideMargin">
		<table cellpadding="0" cellspacing="3" width="100%">
			<tr>
				<td width="100%"><strong>Approver Information</strong></td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="3" width="100%">
			<%
				For i = 0 To NumOfApprovers - 1
				%>
			<tr>
				<td style="padding-left:10;" width="15%"><em>Name</em></td>
				<td width="45%"><%=Approver(ApproverName, i)%></td>
				<td style="padding-left:10;" width="15%"><em>Phone</em></td>
				<td width="25%"><%=Approver(Phone, i)%></td>
			</tr>
			<tr>
				<td style="padding-left:10;"><em>E-Mail</em></td>
				<td><%=Approver(Email, i)%></td>
				<td style="padding-left:10;"><em>Alternate</em></td>
				<td><%=Approver(APhone, i)%></td>
			</tr>
			<tr>
				<td style="padding-left:10;"><em>&nbsp;</em></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<%
				Next
				%>
		</table>
	</div>
	<div class="sideMargin">
		<table cellpadding="0" cellspacing="3" width="100%">
			<tr>
				<td width="100%"><strong>Requisition Status</strong></td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="3" width="100%">
			<tr>
				<td style="padding-left:10;" width="15%"><em>Modified</em></td>
				<td width="45%"><%=ReqModified%></td>
				<td style="padding-left:10;" width="15%"><em>Status</em></td>
				<td width="25%"><%=ReqStatus%></td>
			</tr>
			<tr>
				<td style="padding-left:10;"><em>&nbsp;</em></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
	</div>
</div>
<%
End Sub

Sub CreateRequisition
	CreationDate = Now()
	SQLCommand = "INSERT INTO tbl_jobRequisitions (companyID, userID, addressID, assistingIDs, departmentID, jobtitle, workers, interview, " & _
					"category, dresscode, startdate, enddate, wage, wagetype, schedule, comments, license, breaks, lunch, status," & _
					"lastmodified, lastaccessed, CreationDate) VALUES (" & _
					"'" & companyId & "'," & _
					"'" & user_id & "'," & _
					"'" & request.form("location") & "'," & _
					"'" & request.form("approvers") & "'," & _
					"'" & request.form("department") & "'," & _
					"'" & request.form("jobtitle") & "'," & _
					request.form("workers") & "," & _
					"'" & request.form("interview") & "'," & _
					"'" & request.form("category") & "'," & _
					"'" & request.form("dresscode") & "'," & _
					"'" & request.form("startdate") & "'," & _
					"'" & request.form("enddate") & "'," & _
					"'" & request.form("wage") & "'," & _
					"'" & request.form("wagetype") & "'," & _
					"'" & request.form("schedule") & "'," & _
					"'" & Replace(request.form("comments"), "'", "''") & "'," & _
					"'" & request.form("license") & "'," & _
					"'" & request.form("breaks") & "'," & _
					"'" & request.form("lunch") & "'," & _
					"'Pending'," & _
					"'" & CreationDate & "'," & _
					"'" & CreationDate & "'," & _
					"'" & CreationDate & "')"
'	response.write(SQLCommand)
'	Response.End()
	Database.Open MySql
	Database.Execute(SQLCommand)
	Set dbQuery = Database.Execute("Select requisitionID From tbl_jobRequisitions Where CreationDate='" & CreationDate & "'")
	ReqID = dbQuery("requisitionID")
	
	Set dbQuery = Database.Execute("Select * From email_templates Where template='newJobRequisition'")

	MessageSubject = dbQuery("subject")
	MessageSubject = Replace(MessageSubject, "%companyname%", company_name)
	MessageSubject = Replace(MessageSubject, "%ReqID%", ReqID)

	MessageBody = dbQuery("body")
	MessageBody = Replace(MessageBody, "%companyname%", company_name)
	MessageBody = Replace(MessageBody, "%ReqID%", ReqID)
	MessageBody = Replace(MessageBody, "%Position%", request.form("jobtitle"))
	MessageBody = Replace(MessageBody, "%Start%", request.form("startdate"))

'	Set dbQuery = Database.Execute("Select * From email_templates Where template='testTemplate'")
'	MessageBody = dbQuery("body")
'	MessageSubject = dbQuery("subject")

	
	SendTo = "Personnel Supervisor<placements@personnel.com>"
	Call SendEmail (SendTo, "Personnel Plus VMS <ghaner@personnel.com>", MessageSubject, MessageBody, "")

	Set dbQuery = Nothing
	Database.Close

	Response.Redirect(FormPostTo & manage & "&amp;NewReqID=" & ReqID)
	Database.Close()
	Set dbQuery=Nothing
End Sub

Sub UpdateRequisition
	CreationDate = Now()
	
	SQLCommand = "Update tbl_jobRequisitions Set " & _
				"addressID=" & request.form("location") & _
				", assistingIDs='" & request.form("approvers") & _
				"', departmentID=" & request.form("department") & _
				", jobtitle='" & request.form("jobtitle") & _
				"', workers=" & request.form("workers") & _
				", interview='" & request.form("interview") & _
				"', category='" & request.form("category") & _
				"', dresscode='" & request.form("dresscode") & _
				"', startdate='" & request.form("startdate") & _
				"', enddate='" & request.form("enddate") & _
				"', wage='" & request.form("wage") & _
				"', wagetype='" & request.form("wagetype") & _
				"', schedule='" & request.form("schedule") & _
				"', comments='" & Replace(request.form("comments"), "'", "''") & _
				"', license='" & request.form("license") & _
				"', breaks='" & request.form("breaks") & _
				"', lunch='" & request.form("lunch") & _
				"', status='Modified" & _
				"', lastmodified='" & request.form("lastmodified") & _
				"', lastaccessed='" & request.form("lastmodified") & _
				"' Where requisitionID=" & request.form("requisitionID")
	Database.Open MySql
	Database.Execute(SQLCommand)
	'response.write(SQLCommand)
	'Response.End()
	Response.Redirect(FormPostTo & manage & "&amp;RequisitionID=" & request.form("requisitionID"))
	Database.Close()
	Set dbQuery=Nothing
End Sub

%>
