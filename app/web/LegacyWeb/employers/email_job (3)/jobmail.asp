<!-- #INCLUDE VIRTUAL='/inc/dbConn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
<%
dim sqlLocation
dim rsLocation
dim sqlCategory
dim rsCategory

Set rsEmployerData = Server.CreateObject("ADODB.Recordset")
rsEmployerData.Open "SELECT * FROM tbl_employers WHERE companyUserName ='" & session("companyUserName") & "'", Connect, 3, 3
sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation = Connect.Execute(sqlLocation)
sqlCategory = "SELECT catLabel, catValue FROM tbl_categories ORDER BY catLabel"
set rsCategory = Connect.Execute(sqlCategory)
%>
<HTML>
<HEAD>

<SCRIPT>
function checkJobOrder()  {

var isGood = true
document.emailJobOrder.submit_btn.disabled = true;	

  if (document.emailJobOrder.companyName.value == '')
    {  alert("Please specify a Company Name."); 
	document.emailJobOrder.companyName.focus();
document.emailJobOrder.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
					
  if (document.emailJobOrder.jobTitle.value == '' || document.emailJobOrder.jobTitle.value == ' ')
    {  alert("A Job Title must be entered."); 
	document.emailJobOrder.jobTitle.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false;  
		return false
		}	
				
  if (document.emailJobOrder.jobCategory.value == '')
    {  alert("Please choose a Job Category that best describes this position."); 
	document.emailJobOrder.jobCategory.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	

  if (document.emailJobOrder.jobDressCode.value == '')
    {  alert("Please select a Dress Code option."); 
	document.emailJobOrder.jobDressCode.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}			
										  	
  if (!document.emailJobOrder.jobSchedule[0].checked && !document.emailJobOrder.jobSchedule[1].checked && !document.emailJobOrder.jobSchedule[2].checked)
    {  alert("Please choose the Type of Position this is."); 
	document.emailJobOrder.jobSchedule[0].focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}			
						
if (document.emailJobOrder.wageAmount.value != "DOE" || document.emailJobOrder.wageAmount.value == '')
	{
  if (document.emailJobOrder.wageAmount.value == '' || isNaN(document.emailJobOrder.wageAmount.value))
    {  alert("Please enter the Wage Amount using only numbers.\nif unknown, enter DOE using all capital letters."); 
	document.emailJobOrder.wageAmount.value = "";	
	document.emailJobOrder.wageAmount.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  	}	
 	}
			
  if (!document.emailJobOrder.wageType[0].checked && !document.emailJobOrder.wageType[1].checked)
    {  alert("Please indicate if this is a Hourly or Salaried job."); 
	document.emailJobOrder.wageType[0].focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}
		
  if (document.emailJobOrder.jobDescription.value == '')
    {  alert("Please provide a detailed Job Description."); 
	document.emailJobOrder.jobDescription.focus();
document.emailJobOrder.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}	

  if (!document.emailJobOrder.jobLicenseReq[0].checked && !document.emailJobOrder.jobLicenseReq[1].checked)
    {  alert("Please indicate if this job requires a valid Drivers License."); 
	document.emailJobOrder.jobLicenseReq[0].focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
					
  if (document.emailJobOrder.jobTimeLunch.value == '')
    {  alert("Please select a Lunch Break option."); 
	document.emailJobOrder.jobTimeLunch.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
		
  if (document.emailJobOrder.jobTimeBreaks.value == '')
    {  alert("Please select a Normal Break option."); 
	document.emailJobOrder.jobTimeBreaks.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
		
  if (document.emailJobOrder.jobAddressOne.value == '')
    {  alert("Please provide a street address for the initial job location."); 
	document.emailJobOrder.jobAddressOne.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	   		
  if (document.emailJobOrder.jobCity.value == '')
    {  alert("Please provide a city name for the initial job location."); 
	document.emailJobOrder.jobCity.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 			
	
  if (document.emailJobOrder.jobState.value == '')
    {  alert("Please indicate the state or province for the initial job location."); 
	document.emailJobOrder.jobState.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 
 
  if (document.emailJobOrder.jobZipCode.value == '')
    {  alert("Please enter a zip or postal code for the initial job location."); 
	document.emailJobOrder.jobZipCode.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
  		
  if (document.emailJobOrder.jobContactName.value == '')
    {  alert("Please enter the name of the Company Contact or Representative responsible for this job posting."); 
	document.emailJobOrder.jobContactName.focus();
document.emailJobOrder.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
		
  if (document.emailJobOrder.jobContactPhone.value == '')
    {  alert("Please enter the Phone number of the Company Contact or Representative responsible for this job posting."); 
	document.emailJobOrder.jobContactPhone.focus();
document.emailJobOrder.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}		
				
  if (document.emailJobOrder.information.value == '')
    {  
		isGood = true; 
  		}			
  
  if (document.emailJobOrder.jobEmailAddress.value = '')
  	{
  	alert ("The Company Contact's E-mail Address needs to be filled in.")
  	document.emailJobOrder.jobEmailAddress.value = "";
  	document.emailJobOrder.jobEmailAddress.focus();
  	document.emailJobOrder.submit_btn.disabled = false;
  			isGood = false;
  		return false
  	}
		
  if (document.emailJobOrder.jobEmailAddress.value != '')
    {
    var okSoFar=true
    var foundAt = document.emailJobOrder.jobEmailAddress.value.indexOf("@",0)
    var foundDot = document.emailJobOrder.jobEmailAddress.value.indexOf(".",0)
     if (foundAt+foundDot < 2 && okSoFar) {
    alert ("The Company Contact's E-mail Address provided is incomplete.")
	document.emailJobOrder.jobEmailAddress.value = "";
    document.emailJobOrder.jobEmailAddress.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false;
		return false
     }	
    }				
		
  if (document.emailJobOrder.companyBillingEmail.value != '')
    {
    var okSoFar=true
    var foundAt = document.emailJobOrder.companyBillingEmail.value.indexOf("@",0)
    var foundDot = document.emailJobOrder.companyBillingEmail.value.indexOf(".",0)
     if (foundAt+foundDot < 2 && okSoFar) {
    alert ("The contact E-mail Address provided is incomplete.")
	document.emailJobOrder.companyBillingEmail.value = "";
    document.emailJobOrder.companyBillingEmail.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false;
		return false
     }	
    }				
  if (isGood != false)
  
	{var agree=confirm("Are you ready to save this job posting?");
		if (agree)
	document.emailJobOrder.submit();
else
    document.emailJobOrder.submit_btn.disabled = false;	
	return false ;
	}
}
</SCRIPT>

<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<% if request("page") = 1 then %>
	<title>Employers - Order Employees - Personnel Plus, Inc.</title>
<% Else %>
	<TITLE>Employers - Email a New Job - Personnel Plus, Inc.</TITLE>
<% End if %>
</HEAD>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/advertise/inc/navi_top.asp' -->


<style type="text/css">
#importantTest {display: none;}
</style>

<!-- NAVI TOP START CLSP8 -->
			<% if request("page") = 3 then %>				
				<div style="position: absolute; width: 100px; height: 23px; z-index: 1; left: 424px; top: 99px" id="layer1">
						<FORM> 
							<INPUT STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" type="button" value="Go Back" onClick="history.back()"> 
						</FORM>
				</div>
			<% end if %>
<%
	if request("success") <> "1" then
%>
<FORM NAME="emailJobOrder" METHOD="POST" ACTION="/employers/email_job/sendjob.asp">	
<INPUT TYPE="hidden" NAME="empID" VALUE="<%=rsEmployerData("empID")%>">
<TABLE WIDTH="65%" BORDER=0 CELLPADDING=2 CELLSPACING=0 BGCOLOR="#cccccc" STYLE="border: 1px solid #999999;">	
	<TR>
		<TD ALIGN="center" BGCOLOR="#9acd32">
<% if request("page") = 1 then %>
	<strong>Order Employees</strong>
<% Else %>
	<STRONG>Email a New Job Listing</STRONG>
<% End if %>
		</TD>
	</TR>
	<TR>
		<TD width="100%" align="center">
			<TABLE BORDER=0 width="100%" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
				<TR>
					<TD width="100%" align="center">
					<TABLE width="100%" cellpadding="2" cellspacing="0" border="0">
								<TR>
								<TD ALIGN="center" STYLE CLASS="smallTxt" colspan="2">&nbsp;</TD>
								</TR>									
								<TR>
								<TD ALIGN="center" STYLE CLASS="smallTxt" colspan="2">
								<b>Company Information:</b></TD>
								</TR>									
								<TR>
								<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Company Name: </TD>
								<TD><INPUT TYPE="text" NAME="companyName" SIZE="35" MAXLENGTH="175" VALUE="<%=rsEmployerData("companyName")%>" TABINDEX="6"></TD>
								</TR>									
					<INPUT TYPE="hidden" NAME="companyUserName" SIZE="35" MAXLENGTH="175" VALUE="<%=rsEmployerData("companyUserName")%>" TABINDEX="7">
								<TR>
								<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Job Position's Title: 		</TD>
							<TD><INPUT TYPE="text" NAME="jobTitle" SIZE="35" MAXLENGTH="175" TABINDEX="8"></TD>
								</TR>
								<tr>
							<TD ALIGN="right" STYLE CLASS="smallTxt">Position Reports To:</TD>
							<TD><INPUT TYPE=TEXT SIZE="30" NAME="jobReportTo" MAXLENGTH="75" TABINDEX="21"></TD>		
								</tr>
								<TR>
								<TD ALIGN="right" STYLE CLASS="smallTxt" colspan="2">&nbsp;</TD>
								</TR>
								<TR>
								<TD ALIGN="center" STYLE CLASS="smallTxt" colspan="2">
								<b>Job Information:</b></TD>
								</TR>
								<tr>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> General Job Category:</TD>
							<TD>
					<SELECT NAME="jobCategory" SIZE="1" TABINDEX="20">
						<OPTION VALUE="" SELECTED>-- Choose Best Category --</OPTION>
					<%	
					do while not rsCategory.eof
					response.Write "<OPTION VALUE='" & rsCategory("catValue") & _
					"'>" & rsCategory("catLabel")	
					rsCategory.MoveNext
					loop		
					%>
					</SELECT>		
							</TD>
								</tr>
						<tr>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Dress Code:</TD>
							<TD>
					<SELECT NAME="jobDressCode" TABINDEX="24">
						<OPTION VALUE="">-- Select One --</OPTION>
						<OPTION VALUE="Business Casual">Business Casual</OPTION>
						<OPTION VALUE="Business Professional">Business Professional</OPTION>
						<OPTION VALUE="Casual">Casual</OPTION>	
						<OPTION VALUE="Labor">Work / Labor</OPTION>
						<OPTION VALUE="See Job Desc">* See Job Description</OPTION>	
					</SELECT>
							</TD>
								</tr>
						<tr>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Type of Position:</TD>
							<TD ALIGN="left" STYLE CLASS="smallTxt">
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobSchedule" VALUE="FT" TABINDEX="17" checked>Full-Time 
					&nbsp;&nbsp;
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobSchedule" VALUE="PT" TABINDEX="18">Part-Time		
					&nbsp;&nbsp;
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobSchedule" VALUE="FP" TABINDEX="19">Both
							</TD>
								</tr>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt">Start Date:<BR><FONT SIZE="1"><em>(optional)</em></FONT></TD>
							<TD ALIGN="left"><INPUT TYPE=TEXT SIZE=16 MAXLENGTH="20" NAME="jobStartDate" TABINDEX="9"> <FONT size="1">(mm/dd/yy)</FONT></TD>
								</TR>	
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt">End Date:<BR><FONT SIZE="1"><em>(optional)</em></FONT></TD>
							<TD ALIGN="left"><INPUT TYPE=TEXT SIZE=16 MAXLENGTH="20" NAME="jobEndDate" TABINDEX="10"> <FONT size="1">(mm/dd/yy)</FONT></TD>
								</TR>
								<TR>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Wage Amount & Type:<BR><FONT SIZE="1"><EM>(ex. 8.25, 26400)</EM></FONT></TD>
							<TD ALIGN="left" STYLE CLASS="smallTxt">$ <INPUT TYPE=TEXT SIZE="10" NAME="wageAmount" MAXLENGTH="10" TABINDEX="11">&nbsp;&nbsp;
								<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="wageType" VALUE="Hourly" TABINDEX="12">Hourly 
								<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="wageType" VALUE="Salaried" TABINDEX="13">Salaried</TD>
								</TR>	
								<tr>
								<TD COLSPAN="2" ALIGN="center" STYLE CLASS="smallTxt">&nbsp;</TD>
								</tr>
						<tr>
								<TD COLSPAN="2" ALIGN="center" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"><STRONG><font color="#000000"> Job Description / Duties:</font></STRONG></TD>
								</tr>
						<tr>
								<TD COLSPAN="2" ALIGN="center"><TEXTAREA WRAP="soft" COLS="50" ROWS="5" NAME="jobDescription" TABINDEX="1"></TEXTAREA></TD>
								</tr>
								<TR>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt" colspan="2">&nbsp;</TD>
								</TR>
								<TR>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Drivers License Required?</TD>
							<TD>	
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobLicenseReq" VALUE="Yes" TABINDEX="14">Yes
					&nbsp;&nbsp;
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobLicenseReq" VALUE="No" TABINDEX="15">No		
							</TD>
								</TR>
								<TR>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt">CDL License Required?</TD>
							<TD>
					<SELECT SIZE="1" NAME="jobCDLReq" TABINDEX="16">
						<OPTION VALUE="N/A">-- None Required --</OPTION>
						<OPTION VALUE="CDL-A">CDL-A</OPTION>
						<OPTION VALUE="CDL-B">CDL-B</OPTION>	
						<OPTION VALUE="CDL-C">CDL-C</OPTION>								
					</SELECT>	
							</TD>
								</TR>
								<TR>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt" colspan="2">&nbsp;</TD>
								</TR>
								<TR>
							<TD ALIGN="center" STYLE CLASS="smallTxt" colspan="2">
							<b>Break Information:</b></TD>
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Lunch Information:</TD>
							<TD>
					<SELECT NAME="jobTimeLunch" TABINDEX="22">
						<OPTION VALUE="">-- Select One --</OPTION>
						<OPTION VALUE="No Lunch">(no lunch)</OPTION>
						<OPTION VALUE="15 Minutes">15 Minutes</OPTION>
						<OPTION VALUE="30 Minutes">30 Minutes</OPTION>
						<OPTION VALUE="45 Minutes">45 Minutes</OPTION>
						<OPTION VALUE="1 Hour">1 Hour</OPTION>
						<OPTION VALUE="See Job Desc">* See Job Description</OPTION>	
					</SELECT>		
							</TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Break Information:</TD>
							<TD>
					<SELECT NAME="jobTimeBreaks" TABINDEX="23">
						<OPTION VALUE="">-- Select One --</OPTION>
						<OPTION VALUE="No Breaks">(no breaks)</OPTION>
						<OPTION VALUE="15 Minutes">15 Minutes</OPTION>
						<OPTION VALUE="30 Minutes">30 Minutes</OPTION>
						<OPTION VALUE="45 Minutes">45 Minutes</OPTION>
						<OPTION VALUE="1 Hour">1 Hour</OPTION>
						<OPTION VALUE="See Job Desc">* See Job Description</OPTION>		
					</SELECT>		
							</TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt" colspan="2">&nbsp;</TD>
								</TR>
								<TR>
							<TD ALIGN="center" STYLE CLASS="smallTxt" colspan="2">
							<b>Jobsite Address (required):</b></TD>
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Address:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="30" NAME="jobAddressOne" MAXLENGTH="125" VALUE="<%=rsEmployerData("addressOne")%>" TABINDEX="25"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Address <font size="1">(continued)</font>:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="30" NAME="jobAddressTwo" MAXLENGTH="125" VALUE="<%=rsEmployerData("addressTwo")%>" TABINDEX="26"></TD>		
								</TR>								
					
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> City:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="20" NAME="jobCity" MAXLENGTH="36" VALUE="<%=rsEmployerData("city")%>" TABINDEX="27"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> State:</TD>
							<TD>
						<SELECT NAME="jobState" TABINDEX="28">
							<option value="">- Select a State -</option>
							<% do while not rsLocation.eof %>
							<OPTION	VALUE="<%= rsLocation("locCode")%>"		
							<% if rsLocation("locCode") = rsEmployerData("state") then %>SELECTED<% End if %>> <%=rsLocation("locName") %></OPTION>		
							<% rsLocation.MoveNext %>
							<% loop %>	
						</SELECT>
						
							</TD>		
								</TR>	
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Zip Code:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="10" NAME="jobZipCode" MAXLENGTH="10" VALUE="<%=rsEmployerData("zipCode")%>" TABINDEX="29"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt" colspan="2">&nbsp;</TD>
								</TR>
								<TR>
							<TD ALIGN="center" STYLE CLASS="smallTxt" colspan="2">
							<b>Contact Information (required):</b></TD>
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> 
							Job Contact's Name:</TD>
							<TD>
							<INPUT TYPE="TEXT" SIZE="30" NAME="jobContactName" MAXLENGTH="75" VALUE="<%=rsEmployerData("companyAgent")%>" TABINDEX="30">
							</TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> 
							Job Contact's Phone #:</TD>
							<TD>
							<INPUT TYPE="TEXT" SIZE="15" NAME="jobContactPhone" MAXLENGTH="15" VALUE="<%=rsEmployerData("companyPhone")%>" TABINDEX="31">
							&nbsp;Ext.
							<INPUT TYPE=TEXT SIZE="6" NAME="jobContactPhoneExt" MAXLENGTH="10" TABINDEX="32">
							</TD>		
								</TR>
								<tr>
							<TD ALIGN="right" STYLE CLASS="smallTxt">Job 
							Contact's Fax #: <font size="1">(optional)</font></TD>
							<TD>
							<INPUT TYPE="TEXT" SIZE="15" NAME="jobContactFax" MAXLENGTH="15" VALUE="<%=rsEmployerData("faxNumber")%>" TABINDEX="31">
							</TD>		
								</tr>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> 
							Job Contact's E-mail Address:</TD>
							<TD><INPUT TYPE=TEXT SIZE="30" NAME="jobEmailAddress" MAXLENGTH="80" VALUE="<%=rsEmployerData("emailAddress")%>" TABINDEX="33"></TD>		
								</TR>	
								<tr>
								<TD ALIGN="center" STYLE CLASS="smallTxt" colspan="2">&nbsp;</TD>
								</tr>
								<tr>
								<TD ALIGN="center" STYLE CLASS="smallTxt" colspan="2">
								<b>Billing Information</b><font size="1"> (if different 
								than contact information)</font><b>:</b></TD>
								</tr>
						<tr>
								<TD ALIGN="right" STYLE CLASS="smallTxt">Billing Contact's Name: </TD>
								<TD><INPUT TYPE="text" NAME="companyBilling" SIZE="35" MAXLENGTH="175" VALUE="<%=rsEmployerData("companyAgent")%>" TABINDEX="3"></TD>
								</tr>
						<tr>
							<TD ALIGN="right" STYLE CLASS="smallTxt">Billing Contact's Phone #:</TD>
							<TD>
							<INPUT TYPE="TEXT" SIZE="15" NAME="companyBillingPhone" MAXLENGTH="15" VALUE="<%=rsEmployerData("companyPhone")%>" TABINDEX="4">
							&nbsp;Ext.
							<INPUT TYPE=TEXT SIZE="6" NAME="companyBillingPhoneExt" MAXLENGTH="10" TABINDEX="5">
							</TD>		
								</tr>
								<tr>
							<TD ALIGN="right" STYLE CLASS="smallTxt">Billing 
							Contact's Fax #: <font size="1">(optional)</font></TD>
							<TD>
							<INPUT TYPE="TEXT" SIZE="15" NAME="companyBillingFax" MAXLENGTH="15" VALUE="<%=rsEmployerData("faxNumber")%>" TABINDEX="31">
							</TD>		
								</tr>
								<tr>
								<TD ALIGN="right" STYLE CLASS="smallTxt">Billing Contact's Email: </TD>
								<TD><INPUT TYPE="text" NAME="companyBillingEmail" SIZE="35" MAXLENGTH="175" VALUE="<%=rsEmployerData("emailAddress")%>" TABINDEX="2"></TD>
								</tr>
								<TR>
								<TD COLSPAN="2" ALIGN="center"><IMG SRC="/img/spacer.gif" ALT="" WIDTH="1" HEIGHT="9" BORDER="0"></TD>		
								</TR>	
								<TR>
								<TD ALIGN="center" bgcolor="#FFFFFF" colspan="2">
								<textarea id="importantTest" name="importantTest" rows="3" cols="4"></textarea>
		<INPUT TYPE="button" VALUE="Email This Job Now" STYLE="background:#4682b4; border:1 #000000 solid; font-size:9px; color:#FFFFFF;" NAME="submit_btn" onClick="checkJobOrder();" TABINDEX="34">&nbsp;&nbsp;&nbsp;
		<INPUT TYPE="button" VALUE="Reset Order Form" STYLE="background:#000000; border:1 #333333 solid; font-size:9px; color:#FFFFFF" NAME="cancel_btn" onClick="javascript:document.emailJobOrder.reset();" TABINDEX="-1">
								</TD>
								</TR>		
								<TR>
								<TD COLSPAN="2" ALIGN="center"><IMG SRC="/img/spacer.gif" ALT="" WIDTH="1" HEIGHT="9" BORDER="0"></TD>		
								</TR>								
							</TABLE>	
						</TD>
				</TABLE>
			</TD>
		</TR>		
	</TR>	
</TABLE>
</FORM>
										
<%
	Else
%>
<P>
	<TABLE WIDTH="65%" BORDER=0 CELLPADDING=2 CELLSPACING=0 BGCOLOR="#cccccc" STYLE="border: 1px solid #999999;">	
		<TR>
			<TD ALIGN="center" BGCOLOR="#9acd32">
				<STRONG>Your Job Posting Email has been recieved!</STRONG><br>A Personnel Plus representative will contact you within the next 24 hours.<br><br>Thank you for your order.
			</TD>
		</TR>
	</TABLE>
</P>
<%
	end if
%>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/advertise/inc/navi_btm.asp' -->
</BODY>
</HTML>