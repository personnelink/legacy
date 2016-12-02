<!-- #INCLUDE VIRTUAL='/lweb/inc/dbConn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<% if session("employerAuth") <> "true" then response.redirect("/lweb/employers/registered/index.asp?Err=1") end if%>
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
document.adminJobOrder.submit_btn.disabled = true;	

  if (document.adminJobOrder.jobDescription.value == '')
    {  alert("Please provide a detailed Job Description."); 
	document.adminJobOrder.jobDescription.focus();
document.adminJobOrder.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}	
		
		
  if (document.adminJobOrder.companyName.value == '')
    {  alert("Please specify a Company Name."); 
	document.adminJobOrder.companyName.focus();
document.adminJobOrder.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
					
  if (document.adminJobOrder.companyAgent.value == '')
    {  alert("Please enter the name of the Company Agent or Representative responsible for this job posting."); 
	document.adminJobOrder.companyAgent.focus();
document.adminJobOrder.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
		
  if (document.adminJobOrder.jobTitle.value == '' || document.adminJobOrder.jobTitle.value == ' ')
    {  alert("A Job Title must be entered."); 
	document.adminJobOrder.jobTitle.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false;  
		return false
		}	
				
  if (document.adminJobOrder.jobEmailAddress.value != '')
    {
    var okSoFar=true
    var foundAt = document.adminJobOrder.jobEmailAddress.value.indexOf("@",0)
    var foundDot = document.adminJobOrder.jobEmailAddress.value.indexOf(".",0)
     if (foundAt+foundDot < 2 && okSoFar) {
    alert ("The contact E-mail Address provided is incomplete.")
	document.adminJobOrder.jobEmailAddress.value = "";
    document.adminJobOrder.jobEmailAddress.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false;
		return false
     }	
    }				

if (document.adminJobOrder.wageAmount.value != "DOE" || document.adminJobOrder.wageAmount.value == '')
	{
  if (document.adminJobOrder.wageAmount.value == '' || isNaN(document.adminJobOrder.wageAmount.value))
    {  alert("Please enter the Wage Amount using only numbers.\nIf unknown, enter DOE using all capital letters."); 
	document.adminJobOrder.wageAmount.value = "";	
	document.adminJobOrder.wageAmount.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  	}	
 	}
			
  if (!document.adminJobOrder.wageType[0].checked && !document.adminJobOrder.wageType[1].checked)
    {  alert("Please indicate if this is a Hourly or Salaried job."); 
	document.adminJobOrder.wageType[0].focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}
		
  if (!document.adminJobOrder.jobLicenseReq[0].checked && !document.adminJobOrder.jobLicenseReq[1].checked)
    {  alert("Please indicate if this job requires a valid Drivers License."); 
	document.adminJobOrder.jobLicenseReq[0].focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
					
  if (!document.adminJobOrder.jobSchedule[0].checked && !document.adminJobOrder.jobSchedule[1].checked && !document.adminJobOrder.jobSchedule[2].checked)
    {  alert("Please choose the Type of Position this is."); 
	document.adminJobOrder.jobSchedule[0].focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}			
						
  if (document.adminJobOrder.jobCategory.value == '')
    {  alert("Please choose a Job Category that best describes this position."); 
	document.adminJobOrder.jobCategory.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
  if (document.adminJobOrder.jobTimeLunch.value == '')
    {  alert("Please select a Lunch Break option."); 
	document.adminJobOrder.jobTimeLunch.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
		
  if (document.adminJobOrder.jobTimeBreaks.value == '')
    {  alert("Please select a Normal Break option."); 
	document.adminJobOrder.jobTimeBreaks.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
		
  if (document.adminJobOrder.jobDressCode.value == '')
    {  alert("Please select a Dress Code option."); 
	document.adminJobOrder.jobDressCode.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}			
										  	
  if (document.adminJobOrder.jobAddressOne.value == '')
    {  alert("Please provide a street address for the initial job location."); 
	document.adminJobOrder.jobAddressOne.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	   		
  if (document.adminJobOrder.jobCity.value == '')
    {  alert("Please provide a city name for the initial job location."); 
	document.adminJobOrder.jobCity.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 			
	
  if (document.adminJobOrder.jobState.value == '')
    {  alert("Please indicate the state or province for the initial job location."); 
	document.adminJobOrder.jobState.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 
 
  if (document.adminJobOrder.jobZipCode.value == '')
    {  alert("Please enter a zip or postal code for the initial job location."); 
	document.adminJobOrder.jobZipCode.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
  if (document.adminJobOrder.jobContactPhone.value == '')
    {  alert("Please enter a Contact Phone number regarding this job."); 
	document.adminJobOrder.jobContactPhone.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
		
  if (document.adminJobOrder.jobEmailAddress.value == '')
    {  alert("A Job contact Email Address for potential applicants is needed."); 
	document.adminJobOrder.jobEmailAddress.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}				 	
							
  if (isGood != false)
  
	{var agree=confirm("Are you ready to save this job posting?");
		if (agree)
	document.adminJobOrder.submit();
else
    document.adminJobOrder.submit_btn.disabled = false;	
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
<FORM NAME="adminJobOrder" METHOD="POST" ACTION="jobAdd2.asp?who=1">	
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
								<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Company Name: </TD>
								<TD><INPUT TYPE="text" NAME="companyName" SIZE="35" MAXLENGTH="175" VALUE="<%=rsEmployerData("companyName")%>" TABINDEX="2"></TD>
								</TR>	
								<TR>
								<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Company Agent Name: </TD>
								<TD><INPUT TYPE="text" NAME="companyAgent" SIZE="35" MAXLENGTH="175" VALUE="<%=rsEmployerData("companyAgent")%>" TABINDEX="3"></TD>
								</TR>
					<INPUT TYPE="hidden" NAME="companyUserName" SIZE="35" MAXLENGTH="175" VALUE="<%=rsEmployerData("companyUserName")%>" TABINDEX="4">
								<TR>
								<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Job Position's Title: 		</TD>
							<TD><INPUT TYPE="text" NAME="jobTitle" SIZE="35" MAXLENGTH="175" TABINDEX="5"></TD>
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt">Start Date:<BR><FONT SIZE="1"><em>(optional)</em></FONT></TD>
							<TD ALIGN="left"><INPUT TYPE=TEXT SIZE=16 MAXLENGTH="20" NAME="jobStartDate" TABINDEX="6"> <FONT size="1">(mm/dd/yy)</FONT></TD>
								</TR>	
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt">End Date:<BR><FONT SIZE="1"><em>(optional)</em></FONT></TD>
							<TD ALIGN="left"><INPUT TYPE=TEXT SIZE=16 MAXLENGTH="20" NAME="jobEndDate" TABINDEX="7"> <FONT size="1">(mm/dd/yy)</FONT></TD>
								</TR>
								<TR>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Wage Amount & Type:<BR><FONT SIZE="1"><EM>(ex. 8.25, 26400)</EM></FONT></TD>
							<TD ALIGN="left" STYLE CLASS="smallTxt">$ <INPUT TYPE=TEXT SIZE="10" NAME="wageAmount" MAXLENGTH="10" TABINDEX="8">&nbsp;&nbsp;<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="wageType" VALUE="Hourly" TABINDEX="9">Hourly <INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="wageType" VALUE="Salaried" TABINDEX="10">Salaried</TD>
								</TR>	
								<TR>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Drivers License Required?</TD>
							<TD>	
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobLicenseReq" VALUE="Yes" TABINDEX="11">Yes
					&nbsp;&nbsp;
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobLicenseReq" VALUE="No" TABINDEX="12">No		
							</TD>
								</TR>
								<TR>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt">CDL License Required?</TD>
							<TD>
					<SELECT SIZE="1" NAME="jobCDLReq" TABINDEX="13">
						<OPTION VALUE="N/A">-- None Required --</OPTION>
						<OPTION VALUE="CDL-A">CDL-A</OPTION>
						<OPTION VALUE="CDL-B">CDL-B</OPTION>	
						<OPTION VALUE="CDL-C">CDL-C</OPTION>								
					</SELECT>	
							</TD>
								</TR>
								<TR>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Type of Position:</TD>
							<TD ALIGN="left" STYLE CLASS="smallTxt">
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobSchedule" VALUE="FT" TABINDEX="14">Full-Time 
					&nbsp;&nbsp;
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobSchedule" VALUE="PT" TABINDEX="15">Part-Time		
					&nbsp;&nbsp;
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobSchedule" VALUE="FP" TABINDEX="16">Both
							</TD>
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> General Job Category:</TD>
							<TD>
					<SELECT NAME="jobCategory" SIZE="1" TABINDEX="17">
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
							<TD><INPUT TYPE=TEXT SIZE="30" NAME="jobReportTo" MAXLENGTH="75" TABINDEX="18"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Lunch Information:</TD>
							<TD>
					<SELECT NAME="jobTimeLunch" TABINDEX="19">
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
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Break Information:</TD>
							<TD>
					<SELECT NAME="jobTimeBreaks" TABINDEX="20">
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
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Dress Code:</TD>
							<TD>
					<SELECT NAME="jobDressCode" TABINDEX="21">
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
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Jobsite Address:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="30" NAME="jobAddressOne" MAXLENGTH="125" VALUE="<%=rsEmployerData("addressOne")%>" TABINDEX="22"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Address <font size="1">(continued)</font>:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="30" NAME="jobAddressTwo" MAXLENGTH="125" VALUE="<%=rsEmployerData("addressTwo")%>" TABINDEX="23"></TD>		
								</TR>								
					
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> City:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="20" NAME="jobCity" MAXLENGTH="36" VALUE="<%=rsEmployerData("city")%>" TABINDEX="24"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> State:</TD>
							<TD>
						<SELECT NAME="jobState" TABINDEX="25">
							<% Do While NOT rsLocation.EOF %>
							<OPTION	VALUE="<%= rsLocation("locCode")%>"		
							<% If rsLocation("locCode") = rsEmployerData("state") then %>SELECTED<% End If %>> <%=rsLocation("locName") %></OPTION>		
							<% rsLocation.MoveNext %>
							<% Loop %>	
						</SELECT>
						
							</TD>		
								</TR>	
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Zip Code:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="10" NAME="jobZipCode" MAXLENGTH="10" VALUE="<%=rsEmployerData("zipCode")%>" TABINDEX="26"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Job Phone #:</TD>
							<TD>
							<INPUT TYPE="TEXT" SIZE="15" NAME="jobContactPhone" MAXLENGTH="15" VALUE="<%=rsEmployerData("companyPhone")%>" TABINDEX="27">
							&nbsp;Ext.
							<INPUT TYPE=TEXT SIZE="6" NAME="jobContactPhoneExt" MAXLENGTH="10" TABINDEX="27">
							</TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/lweb/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Job E-mail Address:</TD>
							<TD><INPUT TYPE=TEXT SIZE="30" NAME="jobEmailAddress" MAXLENGTH="80" VALUE="<%=rsEmployerData("emailAddress")%>" TABINDEX="28"></TD>		
								</TR>	
								<TR>
								<TD COLSPAN="2" ALIGN="center"><IMG SRC="/lweb/img/spacer.gif" ALT="" WIDTH="1" HEIGHT="9" BORDER="0"></TD>		
								</TR>	
								<TR>
								<TD ALIGN="center" bgcolor="#FFFFFF" colspan="2">
		<INPUT TYPE="button" VALUE="Post This Job Now" STYLE="background:#4682b4; border:1 #000000 solid; font-size:9px; color:#FFFFFF;" NAME="submit_btn" onClick="checkJobOrder();" TABINDEX="29">&nbsp;&nbsp;&nbsp;
		<INPUT TYPE="button" VALUE="Reset Order Form" STYLE="background:#000000; border:1 #333333 solid; font-size:9px; color:#FFFFFF" NAME="cancel_btn" onClick="javascript:document.adminJobOrder.reset();" TABINDEX="-1">
								</TD>
								</TR>		
								<TR>
								<TD COLSPAN="2" ALIGN="center"><IMG SRC="/lweb/img/spacer.gif" ALT="" WIDTH="1" HEIGHT="9" BORDER="0"></TD>		
								</TR>								
							</TABLE>				
										
							</TD>
							</TR>	
					</TABLE>
					</TD>
				</TR>		
						
</TABLE>
</FORM>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
</BODY>
</HTML>
