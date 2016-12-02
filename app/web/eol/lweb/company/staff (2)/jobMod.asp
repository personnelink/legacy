<!-- #INCLUDE VIRTUAL='/lweb/inc/dbConn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<% if session("adminAuth") <> "true" then 
response.redirect("/index.asp")
end if
%>
<%
' Get job categories
Dim sqlCategory
sqlCategory = "SELECT catLabel, catValue FROM tbl_categories ORDER BY catLabel"
Dim rsCategory
set rsCategory = Connect.Execute(sqlCategory)
' Get locations
Dim sqlLocation
Dim rsLocation
sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation = Connect.Execute(sqlLocation)
' END NON-SESSION DB FUNCTIONS

%>

<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<TITLE>Administrative Job Search - Personnel Plus, Inc. - Idaho's Total Staffing Solution</TITLE>
<META NAME="ROBOTS" CONTENT="NINDEX, NOFOLLOW">
<SCRIPT language="javascript">
function goSearch()  {
	document.searchJobListings.submit();
}
</SCRIPT>
</HEAD>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
 
<TABLE WIDTH="95%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>
						<TD align="center" colspan="2">		
							<TABLE width="55%" border="0" cellpadding="2" cellspacing="5" bgcolor="#FFFFFF">
	<TR>
		<TD style class="smallTxt" align="center" width="50%"><a href="/lweb/company/staff/jobOrder.asp"><strong>Post a New Job</a></strong></TD>
		<td style class="smallTxt" align="center" width="50%"><strong><font color="#808080"><em>Edit Job(s)</em></font></strong></td>
	</TR>
							</TABLE>		
						</TD>
    				<TR>
	<TR>
		<TD ALIGN="center" valign="top" width="100%">
  			<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="3" BGCOLOR="#FFFFFF" style="border: 1px solid #000000;">
				<TR>
					<TD ALIGN="center" COLSPAN="2" BGCOLOR="#b22222">
					<STRONG><FONT COLOR="#FFFFFF">Search Job Listings to Edit/Delete:</FONT></STRONG>
					</TD>
				</TR>
				<TR>
				<TD COLSPAN="2" width="80%">
<FORM NAME="searchJobListings" METHOD="post" ACTION="jobModList.asp">
  					<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="5">
					
      					<TD ALIGN="right" valign="top"><STRONG>Job Availability:</STRONG></TD>
      					<TD> <INPUT TYPE="hidden" NAME="keywords" SIZE="50" MAXLENGTH="50">
				        <SELECT NAME="jobSchedule" SIZE="4">
				          <OPTION VALUE="" SELECTED>-- SELECT ONE --</OPTION>
				          <OPTION VALUE="FT">Full Time</OPTION>
				          <OPTION VALUE="PT">Part Time</OPTION>
						  <OPTION VALUE="FP">Both</OPTION>		  
				        </SELECT>
      					</TD>
    				</TR>
    				<TR> 
      					<TD VALIGN="top" ALIGN="right"><STRONG>Category:</STRONG></TD>
      					<TD> 
				        <SELECT NAME="jobCategory" SIZE="8">
				          <OPTION VALUE="" SELECTED>-- ALL CATEGORIES --</OPTION>
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
      					<TD VALIGN="top" ALIGN="right"><STRONG>City:</STRONG></TD>
      					<TD> 
				        <INPUT TYPE="text" NAME="jobCity" SIZE="40" MAXLENGTH="36">

      					</TD>
    				</TR>					
    				<TR> 
      					<TD VALIGN="top" ALIGN="right"><STRONG>State / Province:</STRONG></TD>
      					<TD> 
						<SELECT NAME="jobState" SIZE="1">
                        <option value="">- Select a Job Location -</option>
				<% Do While NOT rsLocation.EOF %>
						<OPTION	VALUE="<%= rsLocation("locCode")%>"<%If rsLocation("locCode") = "ID" Then %>SELECTED<%End If%>> <%=rsLocation("locName") %></OPTION>
					<% rsLocation.MoveNext %>
				<% Loop %>
						</SELECT>						
      					</TD>
    				</TR>	
    				<TR> 
      					<TD ALIGN="right"><STRONG>Sort By:</STRONG></TD>
      					<TD><INPUT TYPE="radio" style="background:#FFFFFF; border:0; color:#FFFFFF" NAME="orderBy" VALUE="dateCreated" CHECKED>Date Posted<INPUT TYPE="radio" style="background:#FFFFFF; border:0; color:#FFFFFF" NAME="orderBy" VALUE="jobTitle">Job Title<BR><INPUT TYPE="radio" style="background:#FFFFFF; border:0; color:#FFFFFF" NAME="orderBy" VALUE="jobState">Location
		  				</TD>
    				</TR>
    				<TR> 
      					<TD colspan="2" align="center"><INPUT TYPE="button" STYLE="background:#4682b4; border:1 #000000 solid; font-size:9px; color:#FFFFFF;" NAME="submitBtn" VALUE="Search &gt; &gt; &gt;" onClick="goSearch()"></TD></FORM>
    				</TR>	
  					</TABLE>
				</TD>
				</TR>
				</TABLE>
		</TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
	</TR>		
</TABLE>
<%
rsCategory.Close
rsLocation.Close
if session ("auth") = "true" then
rstotalJobApps.close
rsLocationName.close
rstotalStateJobs.close
end if
Connect.Close
set Connect = Nothing
%>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
</BODY>
</HTML>
