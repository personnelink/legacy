<!-- #INCLUDE VIRTUAL='/lweb/inc/dbConn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<%
Dim sqlLocation
Dim rsLocation
Dim sqlCategory
Dim rsCategory

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

  if (document.emailJobOrder.jobDescription.value == '')
    {  alert("Please provide a detailed Job Description."); 
	document.emailJobOrder.jobDescription.focus();
document.emailJobOrder.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}	

  if (document.emailJobOrder.companyAgentEmail.value != '')
    {
    var okSoFar=true
    var foundAt = document.emailJobOrder.companyAgentEmail.value.indexOf("@",0)
    var foundDot = document.emailJobOrder.companyAgentEmail.value.indexOf(".",0)
     if (foundAt+foundDot < 2 && okSoFar) {
    alert ("The Company Agent's E-mail Address provided is incomplete.")
	document.emailJobOrder.companyAgentEmail.value = "";
    document.emailJobOrder.companyAgentEmail.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false;
		return false
     }	
    }				
		
  if (document.emailJobOrder.companyName.value == '')
    {  alert("Please specify a Company Name."); 
	document.emailJobOrder.companyName.focus();
document.emailJobOrder.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
					
  if (document.emailJobOrder.companyAgent.value == '')
    {  alert("Please enter the name of the Company Agent or Representative responsible for this job posting."); 
	document.emailJobOrder.companyAgent.focus();
document.emailJobOrder.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
		
  if (document.emailJobOrder.companyAgentPhone.value == '')
    {  alert("Please enter the name of the Company Agent or Representative responsible for this job posting."); 
	document.emailJobOrder.companyAgentPhone.focus();
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
				
  if (document.emailJobOrder.jobEmailAddress.value != '')
    {
    var okSoFar=true
    var foundAt = document.emailJobOrder.jobEmailAddress.value.indexOf("@",0)
    var foundDot = document.emailJobOrder.jobEmailAddress.value.indexOf(".",0)
     if (foundAt+foundDot < 2 && okSoFar) {
    alert ("The contact E-mail Address provided is incomplete.")
	document.emailJobOrder.jobEmailAddress.value = "";
    document.emailJobOrder.jobEmailAddress.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false;
		return false
     }	
    }				

if (document.emailJobOrder.wageAmount.value != "DOE" || document.emailJobOrder.wageAmount.value == '')
	{
  if (document.emailJobOrder.wageAmount.value == '' || isNaN(document.emailJobOrder.wageAmount.value))
    {  alert("Please enter the Wage Amount using only numbers.\nIf unknown, enter DOE using all capital letters."); 
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
		
  if (!document.emailJobOrder.jobLicenseReq[0].checked && !document.emailJobOrder.jobLicenseReq[1].checked)
    {  alert("Please indicate if this job requires a valid Drivers License."); 
	document.emailJobOrder.jobLicenseReq[0].focus();
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
						
  if (document.emailJobOrder.jobCategory.value == '')
    {  alert("Please choose a Job Category that best describes this position."); 
	document.emailJobOrder.jobCategory.focus();
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
		
  if (document.emailJobOrder.jobDressCode.value == '')
    {  alert("Please select a Dress Code option."); 
	document.emailJobOrder.jobDressCode.focus();
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
    {  alert("Please enter a Contact Name regarding this job."); 
	document.emailJobOrder.jobContactName.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	  		
  		
  if (document.emailJobOrder.jobContactPhone.value == '')
    {  alert("Please enter a Contact Phone number regarding this job."); 
	document.emailJobOrder.jobContactPhone.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
		
  if (document.emailJobOrder.jobEmailAddress.value == '')
    {  alert("A Job contact Email Address for potential applicants is needed."); 
	document.emailJobOrder.jobEmailAddress.focus();
document.emailJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
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

<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">	
	<TITLE>Employers - Post a New Job - Personnel Plus, Inc.</TITLE>
</HEAD>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
<%
	If request("success") <> "1" Then
%>
<FORM NAME="emailJobOrder" METHOD="POST" ACTION="sendjob.asp">	
<INPUT TYPE="hidden" NAME="empID" VALUE="<%=rsEmployerData("empID")%>">
<TABLE WIDTH="65%" BORDER=0 CELLPADDING=2 CELLSPACING=0 BGCOLOR="#cccccc" STYLE="border: 1px solid #999999;">	
	<TR>
		<TD ALIGN="center" BGCOLOR="#9acd32">
<STRONG>Post a New Job Listing</STRONG>
		</TD>
	</TR>
	<TR>
		<TD width="100%" align="center">
			<TABLE BORDER=0 width="100%" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
				<TR>
					<TD width="100%" align="center">
					<TABLE width="100%" cellpadding="2" cellspacing="0" border="0">
						<TR>
								<TD COLSPAN="2" ALIGN="center" STYLE CLASS="smallTxt"><STRONG><font color="#000000">Job Description / Duties:</font></STRONG></TD>
								</TR>
								<TR>
								<TD COLSPAN="2" ALIGN="center"><TEXTAREA WRAP="soft" COLS="50" ROWS="5" NAME="jobDescription" TABINDEX="1"></TEXTAREA></TD>
								</TR>
								<TR>
								<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Company Agent's Email: </TD>
								<TD><INPUT TYPE="text" NAME="companyAgentEmail" SIZE="35" MAXLENGTH="175" VALUE="" TABINDEX="2"></TD>
								</TR>	
								<TR>
								<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Company Agent Name: </TD>
								<TD><INPUT TYPE="text" NAME="companyAgent" SIZE="35" MAXLENGTH="175" VALUE="<%=rsEmployerData("companyAgent")%>" TABINDEX="3"></TD>
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Company Agent's Phone #:</TD>
							<TD>
							<INPUT TYPE="TEXT" SIZE="15" NAME="companyAgentPhone" MAXLENGTH="15" VALUE="" TABINDEX="4">
							&nbsp;Ext.
							<INPUT TYPE=TEXT SIZE="6" NAME="companyAgentPhoneExt" MAXLENGTH="10" TABINDEX="5">
							</TD>		
								</TR>
								<TR>
								<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Company Name: </TD>
								<TD><INPUT TYPE="text" NAME="companyName" SIZE="35" MAXLENGTH="175" VALUE="<%=rsEmployerData("companyName")%>" TABINDEX="6"></TD>
								</TR>									
					<INPUT TYPE="hidden" NAME="companyUserName" SIZE="35" MAXLENGTH="175" VALUE="<%=rsEmployerData("companyUserName")%>" TABINDEX="7">
								<TR>
								<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Job Position's Title: 		</TD>
							<TD><INPUT TYPE="text" NAME="jobTitle" SIZE="35" MAXLENGTH="175" TABINDEX="8"></TD>
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt">Start Date:<BR><FONT SIZE="1"><em>(optional)</em></FONT></TD>
							<TD ALIGN="left"><INPUT TYPE=TEXT SIZE=16 MAXLENGTH="20" NAME="jobStartDate" TABINDEX="9"> <FONT size="1">(mm/dd/yy)</FONT></TD>
								</TR>	
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt">End Date:<BR><FONT SIZE="1"><em>(optional)</em></FONT></TD>
							<TD ALIGN="left"><INPUT TYPE=TEXT SIZE=16 MAXLENGTH="20" NAME="jobEndDate" TABINDEX="10"> <FONT size="1">(mm/dd/yy)</FONT></TD>
								</TR>
								<TR>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Wage Amount & Type:<BR><FONT SIZE="1"><EM>(ex. 8.25, 26400)</EM></FONT></TD>
							<TD ALIGN="left" STYLE CLASS="smallTxt">$ <INPUT TYPE=TEXT SIZE="10" NAME="wageAmount" MAXLENGTH="10" TABINDEX="11">&nbsp;&nbsp;
								<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="wageType" VALUE="Hourly" TABINDEX="12">Hourly 
								<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="wageType" VALUE="Salaried" TABINDEX="13">Salaried</TD>
								</TR>	
								<TR>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Drivers License Required?</TD>
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
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Type of Position:</TD>
							<TD ALIGN="left" STYLE CLASS="smallTxt">
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobSchedule" VALUE="FT" TABINDEX="17">Full-Time 
					&nbsp;&nbsp;
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobSchedule" VALUE="PT" TABINDEX="18">Part-Time		
					&nbsp;&nbsp;
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobSchedule" VALUE="FP" TABINDEX="19">Both
							</TD>
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> General Job Category:</TD>
							<TD>
					<SELECT NAME="jobCategory" SIZE="1" TABINDEX="20">
						<OPTION VALUE="" SELECTED>-- Choose Best Category --</OPTION>
					<%	
					Do While NOT rsCategory.EOF
					response.Write "<OPTION VALUE='" & rsCategory("catValue") & _
					"'>" & rsCategory("catLabel")	
					rsCategory.MoveNext
					Loop		
					%>
					</SELECT>		
							</TD>
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt">Postion Reports To:</TD>
							<TD><INPUT TYPE=TEXT SIZE="30" NAME="jobReportTo" MAXLENGTH="75" TABINDEX="21"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Lunch Information:</TD>
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
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Break Information:</TD>
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
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Dress Code:</TD>
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
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Jobsite Address:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="30" NAME="jobAddressOne" MAXLENGTH="125" VALUE="<%=rsEmployerData("addressOne")%>" TABINDEX="25"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Address <font size="1">(continued)</font>:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="30" NAME="jobAddressTwo" MAXLENGTH="125" VALUE="<%=rsEmployerData("addressTwo")%>" TABINDEX="26"></TD>		
								</TR>								
					
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> City:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="20" NAME="jobCity" MAXLENGTH="36" VALUE="<%=rsEmployerData("city")%>" TABINDEX="27"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> State:</TD>
							<TD>
						<SELECT NAME="jobState" TABINDEX="28">
							<% Do While NOT rsLocation.EOF %>
							<OPTION	VALUE="<%= rsLocation("locCode")%>"		
							<% If rsLocation("locCode") = rsEmployerData("state") then %>SELECTED<% End If %>> <%=rsLocation("locName") %></OPTION>		
							<% rsLocation.MoveNext %>
							<% Loop %>	
						</SELECT>
						
							</TD>		
								</TR>	
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Zip Code:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="10" NAME="jobZipCode" MAXLENGTH="10" VALUE="<%=rsEmployerData("zipCode")%>" TABINDEX="29"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Job Contact Name:</TD>
							<TD>
							<INPUT TYPE="TEXT" SIZE="30" NAME="jobContactName" MAXLENGTH="75" VALUE="<%=rsEmployerData("companyPhone")%>" TABINDEX="30">
							</TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Job Contact's Phone #:</TD>
							<TD>
							<INPUT TYPE="TEXT" SIZE="15" NAME="jobContactPhone" MAXLENGTH="15" VALUE="<%=rsEmployerData("companyPhone")%>" TABINDEX="31">
							&nbsp;Ext.
							<INPUT TYPE=TEXT SIZE="6" NAME="jobContactPhoneExt" MAXLENGTH="10" TABINDEX="32">
							</TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/include/content/images/legacy/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Job Contact's E-mail Address:</TD>
							<TD><INPUT TYPE=TEXT SIZE="30" NAME="jobEmailAddress" MAXLENGTH="80" VALUE="<%=rsEmployerData("emailAddress")%>" TABINDEX="33"></TD>		
								</TR>	
								<TR>
								<TD COLSPAN="2" ALIGN="center"><IMG SRC="/include/content/images/legacy/img/spacer.gif" ALT="" WIDTH="1" HEIGHT="9" BORDER="0"></TD>		
								</TR>	
								<TR>
								<TD ALIGN="center" bgcolor="#FFFFFF" colspan="2">
		<INPUT TYPE="button" VALUE="Email This Job Now" STYLE="background:#4682b4; border:1 #000000 solid; font-size:9px; color:#FFFFFF;" NAME="submit_btn" onClick="checkJobOrder();" TABINDEX="34">&nbsp;&nbsp;&nbsp;
		<INPUT TYPE="button" VALUE="Reset Order Form" STYLE="background:#000000; border:1 #333333 solid; font-size:9px; color:#FFFFFF" NAME="cancel_btn" onClick="javascript:document.emailJobOrder.reset();" TABINDEX="-1">
								</TD>
								</TR>		
								<TR>
								<TD COLSPAN="2" ALIGN="center"><IMG SRC="/include/content/images/legacy/img/spacer.gif" ALT="" WIDTH="1" HEIGHT="9" BORDER="0"></TD>		
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
				<STRONG>Your Job Posting Email has been recieved!</STRONG><br>You should be contacted within 48hrs.<br><br>Thank you for your order.
			</TD>
		</TR>
	</TABLE>
</P>
<%
	End If
%>


<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
</BODY>
</HTML>
