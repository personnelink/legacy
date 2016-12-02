<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<% if session("adminAuth") <> "true" then
response.redirect("/index.asp")
end if 
%>

<%
dim jobSchedule		:	jobSchedule = request("jobSchedule")
dim jobCategory		:	jobCategory = request("jobCategory")
dim jobState		:	jobState = request("jobState")
dim jobCity			:	jobCity = TRIM(request("jobCity"))
dim orderBy			:	orderBy = request("orderBy")
dim srchStr			:	srchStr = "&jobSchedule=" & jobSchedule & "&jobCategory=" & jobCategory & "&jobCity=" & jobCity & "&jobState=" & jobState & "&orderBy=" & orderBy

set rsEditJob = Server.CreateObject("ADODB.RecordSet")
rsEditJob.Open "SELECT * FROM tbl_listings WHERE jobID = '" & request("jobID") & "'",Connect,3,3
sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation = Connect.Execute(sqlLocation)
sqlCategory = "SELECT catLabel, catValue FROM tbl_categories ORDER BY catLabel"
set rsCategory = Connect.Execute(sqlCategory)
%>
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<TITLE>Administrative Job Edit - Personnel Plus, Inc. - Idaho's Total Staffing Solution</TITLE>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<SCRIPT LANGUAGE="Javascript">
function resetCount() {
document.jobEditForm.viewCount.value="0";
document.jobEditForm.viewCount.focus();
}
function refreshPage() {
}

function checkEditForm()  {

var isGood = true
document.jobEditForm.submit_btn.disabled = true;	

  if (document.jobEditForm.jobDescription.value == '')
    {  alert("Please type or copy and paste a detailed Job Description."); 
	document.jobEditForm.jobDescription.focus();
document.jobEditForm.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}	
		
		
  if (document.jobEditForm.companyName.value == '')
    {  alert("Please specify the Company Name."); 
	document.jobEditForm.companyName.focus();
document.jobEditForm.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
					
  if (document.jobEditForm.companyAgent.value == '')
    {  alert("Please enter the name of the Company Agent or Representative handling this job."); 
	document.jobEditForm.companyAgent.focus();
document.jobEditForm.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
		
  if (document.jobEditForm.jobTitle.value == '' || document.jobEditForm.jobTitle.value == ' ')
    {  alert("The Job Title must be specified."); 
	document.jobEditForm.jobTitle.focus();
document.jobEditForm.submit_btn.disabled = false;		
			isGood = false;  
		return false
		}	
				
  if (document.jobEditForm.jobEmailAddress.value != '')
    {
    var okSoFar=true
    var foundAt = document.jobEditForm.jobEmailAddress.value.indexOf("@",0)
    var foundDot = document.jobEditForm.jobEmailAddress.value.indexOf(".",0)
     if (foundAt+foundDot < 2 && okSoFar) {
    alert ("The E-mail Address provided is incomplete.")
	document.jobEditForm.jobEmailAddress.value = "";
    document.jobEditForm.jobEmailAddress.focus();
document.jobEditForm.submit_btn.disabled = false;		
			isGood = false;
		return false
     }	
    }				

  if (document.jobEditForm.wageAmount.value == '')
    {  alert("Please enter the wage amount or salary requirements for this position."); 
	document.jobEditForm.wageAmount.focus();
document.jobEditForm.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
		
						
  if (document.jobEditForm.jobCategory.value == '')
    {  alert("Please choose a Job Category that best describes this position."); 
	document.jobEditForm.jobCategory.focus();
document.jobEditForm.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
													  	
  if (document.jobEditForm.jobAddressOne.value == '')
    {  alert("Please provide a street address for the initial job location."); 
	document.jobEditForm.jobAddressOne.focus();
document.jobEditForm.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	   		
  if (document.jobEditForm.jobCity.value == '')
    {  alert("Please provide a city name for the initial job location."); 
	document.jobEditForm.jobCity.focus();
document.jobEditForm.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 			
	
  if (document.jobEditForm.jobState.value == '')
    {  alert("Please indicate the state or province for the initial job location."); 
	document.jobEditForm.jobState.focus();
document.jobEditForm.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 
 
  if (document.jobEditForm.jobZipCode.value == '')
    {  alert("Please enter a zip or postal code for the initial job location."); 
	document.jobEditForm.jobZipCode.focus();
document.jobEditForm.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
  if (document.jobEditForm.jobContactPhone.value == '')
    {  alert("Please enter a Contact Phone Number regarding this job."); 
	document.jobEditForm.jobContactPhone.focus();
document.jobEditForm.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
		
  if (document.jobEditForm.jobEmailAddress.value == '')
    {  alert("Please enter an Email Address regarding this job."); 
	document.jobEditForm.jobEmailAddress.focus();
document.jobEditForm.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}				 	
							
  if (isGood != false)
  
	{var agree=confirm("Ready to save changes?");
		if (agree)
	document.jobEditForm.submit();
else
    document.jobEditForm.submit_btn.disabled = false;	
	return false ;
	}
}


function confirmDelete()  {

var delOK=confirm("Are you sure you want to permanently delete this job?");
		if (delOK)
	window.location="jobDelete.asp?jobID=<%=rsEditJob("jobID")%>&srchStr=<%=srchStr%>";
else	
	return false ;


}
</SCRIPT>
</HEAD>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
 <!-- NAVI TOP START CLSP8 -->
    
<TABLE WIDTH="85%" CELLSPACING="0" CELLPADDING="3" BGCOLOR="#FFFFFF">
		<TR>
			<TD COLSPAN="2" ALIGN="center">
				<TABLE width="65%" border="0" cellpadding="2" cellspacing="5">
					<TR>
		<td style class="smallTxt" align="center" width="33%"><a href="/lweb/company/staff/jobModList.asp?xCrypt=<%=srchStr%>"><strong>&lt;Back to Search Results</strong></a></td>					
		<TD style class="smallTxt" align="center" width="33%"><a href="/lweb/company/staff/jobOrder.asp"><strong>Post a New Job</a></strong></TD>
					</TR>				
				</TABLE>			
			</TD>
					</TR>	
					<TR>
					<TD style class="smallTxt" align="center" colspan="2"><strong><FONT SIZE="3"> <%=rsEditJob("jobTitle")%></FONT></STRONG></TD>
					</TR>						
					<TR>
					<TD COLSPAN="2" ALIGN="center">
					<TABLE WIDTH="100%" CELLSPACING="0" CELLPADDING="4" BGCOLOR="#FFFFFF" style="border:1 #333333 solid;">	
					<TR>
						<TD COLSPAN="2" ALIGN="center" bgcolor="#b22222"><STRONG><FONT COLOR="#FFFFFF" SIZE="3">Edit Job Posting - </FONT></strong>  <strong><font size="3" color="#FFFFFF"><%=session("firstName")%> Administration</font></strong></TD>
					</TR>								
					<TR>
						<TD colspan="2" align="center" bgcolor="#CCCCCC" width="100%"><form name="jobEditForm" method="post" action="jobEdit2.asp">
<input type="hidden" name="jobID" value="<%=rsEditJob("jobID")%>">
<input type="hidden" name="srchStr" value="<%=srchStr%>">
							<table border="0" CELLSPACING="0" CELLPADDING="3" width="100%">
								<tr>
									<td align="center" bgcolor="#FFFFFF"><STRONG>:: Job Title ::</STRONG></td>
								</tr>
								
								<tr>
									<td align="center" bgcolor="#CCCCCC"><INPUT TYPE="text" NAME="jobTitle" SIZE="78" MAXLENGTH="175" VALUE="<%=rsEditJob("jobTitle")%>" STYLE="background:#e7e7e7; border:1 #333333 solid; font-size:12px; color:#000000;"></td>
								</tr>	
					<TR> 
					<TD ALIGN="center" VALIGN="top" bgcolor="#FFFFFF"><STRONG>:: Job description & Duties ::</STRONG>
					</TD>
					</TR>	
					<TR> 
					<TD ALIGN="center" VALIGN="top" bgcolor="#e7e7e7"><TEXTAREA ROWS="14" COLS="67" NAME="jobDescription"><%=rsEditJob("jobDescription")%></TEXTAREA>
					</TD>
					</TR>																			
							</table>
						
						</td>
					</tr>
					<tr>
						<TD WIDTH="50%" align="right" valign="top">
							<TABLE width="100%" CELLSPACING="3" CELLPADDING="3" BORDER="0" bgcolor="#cccccc">
								<TR>
									<TD colspan="2" align="center" bgcolor="#FFFFFF"><strong>:: Company / Location ::</strong></TD>
								</TR>
								<tr>
									<td align="right">Company:</td>
									<td><INPUT TYPE="TEXT" name="companyName" SIZE="30" MAXLENGTH="125" VALUE="<%=rsEditJob("companyName")%>"></td>
								</tr>
								<tr>
									<td align="right">Company Agent:</td>
									<td><INPUT TYPE="TEXT" name="companyAgent" SIZE="30" MAXLENGTH="125" VALUE="<%=rsEditJob("companyAgent")%>"></td>
								</tr>																	
								<tr>
									<td align="right">Address:</td>
									<td><INPUT TYPE="TEXT" name="jobAddressOne" SIZE="30" MAXLENGTH="125" VALUE="<%=rsEditJob("jobAddressOne")%>"></td>
								</tr>
								<tr>
									<td align="right">Address:<br><font size="1"><em>continued</em>...</font></td>
									<td><INPUT TYPE="TEXT" name="jobAddressTwo" SIZE="30" MAXLENGTH="125" VALUE="<%=rsEditJob("jobAddressTwo")%>"></td>
								</tr>								
								<tr>
									<TD align="right">State:</TD>
									<TD>
<SELECT NAME="jobState" TABINDEX="24">
<% Do While NOT rsLocation.EOF %>
<OPTION	VALUE="<%= rsLocation("LOCCODE")%>"		
<% If rsLocation("locCode") = rsEditJob("jobState") then %>SELECTED<% End If %>> <%=rsLocation("locName") %></OPTION>		
<% rsLocation.MoveNext %>
<% Loop %>	
</SELECT>
									</TD>
								</tr>
								<tr>
									<td align="right">City:</td>
									<td><INPUT TYPE="TEXT" name="jobCity" MAXLENGTH="36" SIZE="24" VALUE="<%=rsEditJob("jobCity")%>"></td>
								</tr>
								<tr>
									<td align="right">Zip Code:</td>
									<td><INPUT TYPE="text" NAME="jobZipCode" SIZE="10" MAXLENGTH="10" VALUE="<%=rsEditJob("jobZipCode")%>">&nbsp;Country:&nbsp;&nbsp;<INPUT TYPE="text" NAME="jobCountry" SIZE="3" MAXLENGTH="3" VALUE="<%=rsEditJob("jobCountry")%>"></td>
								</tr>
								<tr>
									<td align="right">License Req'd:</td>
									<td>
			<SELECT NAME="jobLicenseReq" SIZE="1">
			<OPTION VALUE="Yes" <%IF rsEditJob("jobLicenseReq") = "Yes" THEN%>SELECTED<%end if%>>Yes</OPTION>
			<OPTION VALUE="No" <%IF rsEditJob("jobLicenseReq") = "No" THEN%>SELECTED<%end if%>>No</OPTION>
			</SELECT>	
			&nbsp;CDL Type:	
			<SELECT NAME="jobCDLReq" SIZE="1">
			<OPTION VALUE="N/A" <%IF rsEditJob("jobCDLReq") = "N/A" THEN%>SELECTED<%end if%>>N/A</OPTION>
			<OPTION VALUE="CDL-A" <%IF rsEditJob("jobCDLReq") = "CDL-A" THEN%>SELECTED<%end if%>>CDL-A</OPTION>
			<OPTION VALUE="CDL-B" <%IF rsEditJob("jobCDLReq") = "CDL-B" THEN%>SELECTED<%end if%>>CDL-B</OPTION>
			<OPTION VALUE="CDL-C" <%IF rsEditJob("jobCDLReq") = "CDL-C" THEN%>SELECTED<%end if%>>CDL-C</OPTION>
			</SELECT>												
									
									</td>
								</tr>	
								<TR>
									<TD colspan="2" align="center" bgcolor="#FFFFFF"><strong>:: Miscellaneous ::</strong></TD>
								</TR>
								<tr>
									<td align="right">Job View Count:</td>
									<td>
<INPUT TYPE="text" NAME="viewCount" SIZE="3" MAXLENGTH="3" VALUE="<%=rsEditJob("viewCount")%>">	&nbsp;<input type="button" name="resetViewCount" STYLE="background:#000000; border:1 #333333 solid; font-size:9px; color:#FFFFFF" value="RESET" onClick="resetCount()">						
									
									</td>
								</tr>	
								<tr>
									<td colspan="2"><img src="/lweb/img/spacer.gif" alt="" width="1" height="1" border="0"></td>
								</tr>
																																														
							</TABLE>
						</TD>
						<TD WIDTH="50%" align="left" valign="top">
							<TABLE width="100%" CELLSPACING="3" CELLPADDING="3" BORDER="0" bgcolor="#cccccc">
								<TR>
									<TD colspan="2" align="center" bgcolor="#FFFFFF"><strong>:: Job Details ::</strong></TD>
								</TR>
								<tr>
									<TD align="right">Category:</TD>
									<TD>
				<SELECT NAME="jobCategory" TABINDEX="24">
					<% Do While NOT rsCategory.EOF %>
					<OPTION	VALUE="<%= rsCategory("CATVALUE")%>"		
					<% If rsCategory("catValue") = rsEditJob("jobCategory") then %>SELECTED<% End If %>> <%=rsCategory("catLabel") %></OPTION>		
					<% rsCategory.MoveNext %>
					<% Loop %>	
				</SELECT>
									</TD>
								</tr>
								<tr>
									<td align="right">Schedule:</td>
									<td>
			<SELECT NAME="jobSchedule" SIZE="1">
			<OPTION VALUE="FT" <%IF rsEditJob("jobSchedule") = "FT" THEN%>SELECTED<%end if%>>Full-Time</OPTION>
			<OPTION VALUE="PT" <%IF rsEditJob("jobSchedule") = "PT" THEN%>SELECTED<%end if%>>Part-Time</OPTION>
			<OPTION VALUE="FP" <%IF rsEditJob("jobSchedule") = "FP" THEN%>SELECTED<%end if%>>Full/Part-Time</OPTION>
			<OPTION VALUE="SE" <%IF rsEditJob("jobSchedule") = "SE" THEN%>SELECTED<%end if%>>Seasonal</OPTION>
			<OPTION VALUE="TP" <%IF rsEditJob("jobSchedule") = "TP" THEN%>SELECTED<%end if%>>Temporary</OPTION>
			</SELECT>									
									</td>
								</tr>
								<tr>
									<td align="right">Wage: <strong>$</strong></td>
									<td><INPUT TYPE"text" NAME="wageAmount" VALUE="<%=rsEditJob("WAGEAMOUNT")%>" size="13" maxlength="20">&nbsp;
			<SELECT NAME="wageType" SIZE="1">
			<OPTION VALUE="Hourly" <%IF rsEditJob("wageType") = "Hourly" THEN%>SELECTED<%end if%>>Hourly</OPTION>
			<OPTION VALUE="Salaried" <%IF rsEditJob("wageType") = "Salaried" THEN%>SELECTED<%end if%>>Salaried</OPTION>
			</SELECT>	
					
									</td>
								</tr>
								<tr>
									<td align="right">Phone #:</td>
									<td><input type="text" name="jobContactPhone" value="<%=rsEditJob("jobContactPhone")%>" size="15" maxlength="15">&nbsp; Ext. <input type="text" name="jobContactPhoneExt" value="<%=rsEditJob("jobContactPhoneExt")%>" size="3" maxlength="10"></td>
								</tr>
								<tr>
									<td align="right">Email:</td>
									<td><INPUT TYPE="TEXT" name="jobEmailAddress" SIZE="30" MAXLENGTH="80" VALUE="<%=rsEditJob("jobEmailAddress") %>"></td>
								</tr>	
								<tr>
									<td align="right">Reports To:</td>
									<td><INPUT TYPE="TEXT" name="jobReportTo" SIZE="30" MAXLENGTH="75" VALUE="<%=rsEditJob("jobReportTo") %>"></td>
								</tr>
								<tr>
									<td align="right">Dress Code:</td>
									<td>
<SELECT NAME="jobDressCode">
	<OPTION VALUE="" <%IF rsEditJob("jobDressCode") = "" THEN%>SELECTED<%end if%>>None Specified</OPTION>
	<OPTION VALUE="Business Casual" <%IF rsEditJob("jobDressCode") = "Business Casual" THEN%>SELECTED<%end if%>>Business Casual</OPTION>
	<OPTION VALUE="Business Professional" <%IF rsEditJob("jobDressCode") = "Business Professional" THEN%>SELECTED<%end if%>>Business Professional</OPTION>
	<OPTION VALUE="Casual" <%IF rsEditJob("jobDressCode") = "Casual" THEN%>SELECTED<%end if%>>Casual</OPTION>
	<OPTION VALUE="Labor" <%IF rsEditJob("jobDressCode") = "Labor" THEN%>SELECTED<%end if%>>Labor</OPTION>
	<OPTION VALUE="See Job Desc" <%IF rsEditJob("jobDressCode") = "See Job Desc" THEN%>SELECTED<%end if%>>* See Job Description</OPTION>	
</SELECT>									
									
									</td>
								</tr>								
								<tr>
									<td align="right">Starts:<br><font size="1">(mm/dd/yy)</font></td>
									<td><INPUT TYPE="TEXT" name="jobStartDate" SIZE="8" MAXLENGTH="12" VALUE="<%=rsEditJob("jobStartDate") %>"> &nbsp;Ends: <INPUT TYPE="TEXT" name="jobEndDate" SIZE="8" MAXLENGTH="12" VALUE="<%=rsEditJob("jobEndDate") %>"></td>
								</tr>	
								<tr>
									<td align="right">Lunch Break:</td>
									<td>
<SELECT NAME="jobTimeLunch">
	<OPTION VALUE="" <%IF rsEditJob("jobTimeLunch") = "" THEN%>SELECTED<%end if%>>None Specified</OPTION>	
	<OPTION VALUE="No Lunch" <%IF rsEditJob("jobTimeLunch") = "No Lunch" THEN%>SELECTED<%end if%>>No Lunch</OPTION>
	<OPTION VALUE="15 Minutes" <%IF rsEditJob("jobTimeLunch") = "15 Minutes" THEN%>SELECTED<%end if%>>15 Minutes</OPTION>
	<OPTION VALUE="30 Minutes" <%IF rsEditJob("jobTimeLunch") = "30 Minutes" THEN%>SELECTED<%end if%>>30 Minutes</OPTION>
	<OPTION VALUE="45 Minutes" <%IF rsEditJob("jobTimeLunch") = "45 Minutes" THEN%>SELECTED<%end if%>>45 Minutes</OPTION>
	<OPTION VALUE="1 Hour" <%IF rsEditJob("jobTimeLunch") = "1 Hour" THEN%>SELECTED<%end if%>>1 Hour</OPTION>		
	<OPTION VALUE="See Job Desc" <%IF rsEditJob("jobTimeLunch") = "See Job Desc" THEN%>SELECTED<%end if%>>* See Job Desc</OPTION>				
</SELECT>	
</td>
								</tr>
								<tr>
									<td align="right">Normal Break:</td>
									<td>
<SELECT NAME="jobTimeBreaks">
	<OPTION VALUE="" <%IF rsEditJob("jobTimeBreaks") = "" THEN%>SELECTED<%end if%>>None Specified</OPTION>	
	<OPTION VALUE="No Breaks" <%IF rsEditJob("jobTimeBreaks") = "No Breaks" THEN%>SELECTED<%end if%>>No Breaks</OPTION>
	<OPTION VALUE="15 Minutes" <%IF rsEditJob("jobTimeBreaks") = "15 Minutes" THEN%>SELECTED<%end if%>>15 Minutes</OPTION>
	<OPTION VALUE="30 Minutes" <%IF rsEditJob("jobTimeBreaks") = "30 Minutes" THEN%>SELECTED<%end if%>>30 Minutes</OPTION>
	<OPTION VALUE="45 Minutes" <%IF rsEditJob("jobTimeBreaks") = "45 Minutes" THEN%>SELECTED<%end if%>>45 Minutes</OPTION>
	<OPTION VALUE="1 Hour" <%IF rsEditJob("jobTimeBreaks") = "1 Hour" THEN%>SELECTED<%end if%>>1 Hour</OPTION>		
	<OPTION VALUE="See Job Desc" <%IF rsEditJob("jobTimeBreaks") = "See Job Desc" THEN%>SELECTED<%end if%>>* See Job Desc</OPTION>				
</SELECT>	
<img src="/lweb/img/spacer.gif" alt="" width="1" height="19" border="0">
</td>
								</tr>																																																													
							</TABLE>						
						</TD>
					</TR>
								<tr>
									<td align="center" valign="top"><%if rsEditJob("jobStatus") = "Open" then%><font color="#008000"><strong>JOB IS OPEN</strong></font> <img src="/lweb/img/ico_open.gif" alt="JOB IS OPEN" width="19" height="23" border="0" align="absmiddle">
<%else%>
<font color="#FF0000"><strong>JOB IS CLOSED</strong></font> <img src="/lweb/img/ico_close.gif" alt="JOB IS CLOSED" width="19" height="23" border="0" align="absmiddle">
<br>
<font size="1">Closed: <%=rsEditJob("dateJobClosed")%></font>
<%end if%></td>
									<td bgcolor="#FFFFFF" align="center">
<%if rsEditJob("jobStatus") = "Closed" then%>
<a href="jobOpen.asp?jobID=<%=rsEditJob("jobID")%><%=srchStr%>"><strong>RE-OPEN JOB</strong></a>

<%else%>
<a href="jobClose.asp?jobID=<%=rsEditJob("jobID")%><%=srchStr%>"><strong>CLOSE JOB</strong></a>
<%end if%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="#" onClick="confirmDelete();"><strong>DELETE JOB</strong></a>

									</td>
								</tr>
								<tr>
									<td colspan="2" bgcolor="#b0c4de"><img src="/lweb/img/spacer.gif" alt="" width="1" height="6" border="0"></td>
								</tr>																		  
	
					<tr>
						<td align="right"><input type="button" name="submit_btn" value="Save Changes &gt; &gt; &gt;" STYLE="background:#4682b4; border:1 #000000 solid; font-size:9px; color:#FFFFFF;" onClick="checkEditForm()"></td>
						<td><input type="button" name="refreshPage" value="Clear Form" STYLE="background:#A5A5A5; border:1 #000000 solid; font-size:9px; color:#000000;" onClick="history.go()"></td>						
					</tr>															
					</TABLE>
				</TD>
			</TR>
		</TABLE>
</FORM>
<%
rsEditJob.Close
rsLocation.Close
rsCategory.Close
set Connect = Nothing
%>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
</BODY>
</HTML>

