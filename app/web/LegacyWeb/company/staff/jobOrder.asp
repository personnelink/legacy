<!-- #INCLUDE VIRTUAL='/inc/dbConn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
<% if session("adminAuth") <> "true" then response.redirect("/index.asp") end if%>
<%
dim sqlLocation
dim rsLocation
dim sqlCategory
dim rsCategory

Set rsAdminData = Server.CreateObject("ADODB.Recordset")
rsAdminData.Open "SELECT * FROM tbl_admin WHERE userName = '" & user_name & "'", Connect, 3, 3
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
    {  alert("Please enter or copy and paste a detailed Job Description."); 
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
    {  alert("Please enter the name of the Company Agent or Representative handling this job."); 
	document.adminJobOrder.companyAgent.focus();
document.adminJobOrder.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
		
  if (document.adminJobOrder.jobTitle.value == '' || document.adminJobOrder.jobTitle.value == ' ')
    {  alert("The Job Title must be specified."); 
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
    alert ("The E-mail Address provided is incomplete.")
	document.adminJobOrder.jobEmailAddress.value = "";
    document.adminJobOrder.jobEmailAddress.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false;
		return false
     }	
    }				

  if (document.adminJobOrder.wageAmount.value == '' || document.adminJobOrder.wageAmount.value == ' ')
    {  alert("The Wage Amount must be specified."); 
	document.adminJobOrder.wageAmount.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false;  
		return false
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
    {  alert("Please enter a Contact Phone Number regarding this job."); 
	document.adminJobOrder.jobContactPhone.focus();
document.adminJobOrder.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
		
  if (document.adminJobOrder.jobEmailAddress.value == '')
    {  alert("Please enter an Email Address regarding this job."); 
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
<script language="javascript" src="/inc/popcalendar.js"></script>
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">	
	<TITLE>Post a New Job</TITLE>
</HEAD>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
<FORM NAME="adminJobOrder" METHOD="POST" ACTION="jobOrder2.asp">	
<INPUT TYPE="hidden" NAME="admID" VALUE="<%=rsAdminData("admID")%>">
<TABLE width="55%" border="0" cellpadding="4" cellspacing="5">
	<TR>
		<TD style class="smallTxt" align="center" width="50%"><strong><font color="#808080"><em>Post a New Job</em></font></strong></TD>
		<td style class="smallTxt" align="center" width="50%"><a href="/company/staff/jobMod.asp"><strong>Edit Job(s) </strong></a></td>
	</TR>
</TABLE>

<TABLE WIDTH="65%" BORDER=0 CELLPADDING=4 CELLSPACING=0 BGCOLOR="#cccccc" STYLE="border: 1px solid #000000;">	
	<TR>
		<TD ALIGN="center" BGCOLOR="#b22222">
<STRONG><FONT COLOR="#FFFFFF">Post a New Job (<%=rsAdminData("firstName") & " " & rsAdminData("lastName")%>)</FONT></STRONG>
		</TD>
	</TR>
	<TR>
		<TD width="100%" align="center">
			<TABLE BORDER=0 width="100%" cellpadding="0" cellspacing="1" bgcolor="#cccccc">
	
				<TR>
					<TD width="100%" align="center" bgcolor="#cccccc">
					<TABLE width="100%" bgcolor="#FFFFFF" cellpadding="2" cellspacing="0" border="0">
					<!--  -->
						<TR>
								<TD COLSPAN="2" ALIGN="center" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> <STRONG>Job Description / Duties:</STRONG></TD>
								</TR>
								<TR>
								<TD COLSPAN="2" ALIGN="center"><TEXTAREA WRAP="soft" COLS="50" ROWS="5" NAME="jobDescription" TABINDEX="1"></TEXTAREA></TD>
								</TR>
								<TR>
								<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Company Name: </TD>
								<TD><INPUT TYPE="text" NAME="companyName" SIZE="35" MAXLENGTH="175" VALUE="<%=rsAdminData("companyName")%>" TABINDEX="2"></TD>
								</TR>	
								<TR>
								<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Company Agent Name: </TD>
								<TD><INPUT TYPE="text" NAME="companyAgent" SIZE="35" MAXLENGTH="175" VALUE="<%=rsAdminData("firstName") & " " & rsAdminData("lastName")%>" TABINDEX="3"></TD>
								</TR>
					<INPUT TYPE="hidden" NAME="companyUserName" SIZE="35" MAXLENGTH="175" VALUE="<%=rsAdminData("userName")%>" TABINDEX="4">
								<TR>
								<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Job Title: 		</TD>
							<TD><INPUT TYPE="text" NAME="jobTitle" SIZE="35" MAXLENGTH="175" TABINDEX="5"></TD>
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt">Start Date:<BR><FONT SIZE="1"><em>(optional)</em></FONT></TD>
							<TD ALIGN="left"><INPUT TYPE=TEXT SIZE=20 MAXLENGTH="20" NAME="jobStartDate" TABINDEX="6">    <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<a href='#' onClick='popUpCalendar(this,adminJobOrder.jobStartDate, \"mm/dd/yyyy\")'><font size='1'>Open Calendar</font></a>")
							}
						//-->
	</script></TD>
								</TR>	
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt">End Date:<BR><FONT SIZE="1"><em>(optional)</em></FONT></TD>
							<TD ALIGN="left"><INPUT TYPE=TEXT SIZE=20 MAXLENGTH="20" NAME="jobEndDate" TABINDEX="7"> <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<a href='#' onClick='popUpCalendar(this,adminJobOrder.jobEndDate, \"mm/dd/yyyy\")'><font size='1'>Open Calendar</font></a>")
							}
						//-->
	</script></TD>
								</TR>
								<TR>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Wage Amount & Type:<BR><FONT SIZE="1"><EM>(ex. 8.25, 26K-28K, DOE)</EM></FONT></TD>
							<TD ALIGN="left" STYLE CLASS="smallTxt"><INPUT TYPE=TEXT SIZE="20" NAME="wageAmount" MAXLENGTH="20" TABINDEX="8">&nbsp;<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="wageType" VALUE="Hourly" TABINDEX="9">Hourly <INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="wageType" VALUE="Salaried" TABINDEX="10">Salaried</TD>
								</TR>	
								<TR>
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Drivers License Required?</TD>
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
							<TD ALIGN="RIGHT" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Type of Position:</TD>
							<TD ALIGN="left" STYLE CLASS="smallTxt">
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobSchedule" VALUE="FT" TABINDEX="14">Full-Time 
					&nbsp;&nbsp;
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobSchedule" VALUE="PT" TABINDEX="15">Part-Time		
					&nbsp;&nbsp;
					<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="jobSchedule" VALUE="FP" TABINDEX="16">Both
							</TD>
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> General Job Category:</TD>
							<TD>
					<SELECT NAME="jobCategory" SIZE="1" TABINDEX="17">
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
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt">&nbsp; Report To:</TD>
							<TD><INPUT TYPE=TEXT SIZE="30" NAME="jobReportTo" MAXLENGTH="75" TABINDEX="18"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt">Lunch Information:</TD>
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
							<TD ALIGN="right" STYLE CLASS="smallTxt">Break Information:</TD>
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
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Dress Code:</TD>
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
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Jobsite Address:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="30" NAME="jobAddressOne" MAXLENGTH="125" VALUE="<%=rsAdminData("addressOne")%>" TABINDEX="22"></TD>		
								</TR>
					
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> City:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="20" NAME="jobCity" MAXLENGTH="36" VALUE="<%=rsAdminData("city")%>" TABINDEX="23"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> State:</TD>
							<TD>
						<SELECT NAME="jobState" TABINDEX="24">
							<% do while not rsLocation.eof %>
							<OPTION	VALUE="<%= rsLocation("LOCCODE")%>"		
							<% if rsLocation("locCode") = rsAdminData("state") then %>SELECTED<% End if %>> <%=rsLocation("locName") %></OPTION>		
							<% rsLocation.MoveNext %>
							<% loop %>	
						</SELECT>
						
							</TD>		
								</TR>	
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Zip Code:</TD>
							<TD><INPUT TYPE="TEXT" SIZE="10" NAME="jobZipCode" MAXLENGTH="10" VALUE="<%=rsAdminData("zipCode")%>" TABINDEX="25"></TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Job Phone #:</TD>
							<TD>
							<INPUT TYPE="TEXT" SIZE="15" NAME="jobContactPhone" MAXLENGTH="15" VALUE="<%=rsAdminData("contactPhone")%>" TABINDEX="26">
							&nbsp;Ext.
							<INPUT TYPE=TEXT SIZE="6" NAME="jobContactPhoneExt" MAXLENGTH="10" TABINDEX="27">
							</TD>		
								</TR>
								<TR>
							<TD ALIGN="right" STYLE CLASS="smallTxt"><IMG SRC="/img/asterisk.gif" ALT="" WIDTH="7" HEIGHT="9" BORDER="0"> Job E-mail Address:</TD>
							<TD><INPUT TYPE=TEXT SIZE="30" NAME="jobEmailAddress" MAXLENGTH="80" VALUE="<%=rsAdminData("emailAddress")%>" TABINDEX="28"></TD>		
								</TR>	
								<TR>
								<TD COLSPAN="2" ALIGN="center"><IMG SRC="/img/spacer.gif" ALT="" WIDTH="1" HEIGHT="9" BORDER="0"></TD>		
								</TR>	
								<TR>
								<TD ALIGN="center" bgcolor="#FFFFFF" colspan="2">
		<INPUT TYPE="button" VALUE="Post Job &gt; &gt; &gt;" STYLE="background:#4682b4; border:1 #000000 solid; font-size:9px; color:#FFFFFF;" NAME="submit_btn" onClick="checkJobOrder();" TABINDEX="29">&nbsp;&nbsp;&nbsp;
		<INPUT TYPE="button" VALUE="Clear Form" STYLE="background:#A5A5A5; border:1 #333333 solid; font-size:9px; color:#000000;" NAME="cancel_btn" onClick="javascript:document.adminJobOrder.reset();" TABINDEX="-1">
								</TD>
								</TR>		
								<TR>
								<TD COLSPAN="2" ALIGN="center"><IMG SRC="/img/spacer.gif" ALT="" WIDTH="1" HEIGHT="9" BORDER="0"></TD>		
								</TR>								
							</TABLE>				
										
							</TD>
							</TR>	
												
					<!--  -->
					</TABLE>
					</TD>
				</TR>		
						
</TABLE>
</FORM>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
</BODY>
</HTML>
