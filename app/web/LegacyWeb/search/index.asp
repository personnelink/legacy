<!-- #INCLUDE VIRTUAL='/inc/dbConn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->

<%
' Get job categories
dim sqlCategory
sqlCategory = "SELECT catLabel, catValue FROM tbl_categories ORDER BY catLabel"
dim rsCategory
set rsCategory = Connect.Execute(sqlCategory)
' Get current job locations
dim rsL, sqlL
sqlL = "SELECT tbl_listings.jobCity, tbl_listings.jobState FROM tbl_listings GROUP BY tbl_listings.jobCity, tbl_listings.jobState ORDER BY tbl_listings.jobState, tbl_listings.jobCity"
set rsL = Connect.Execute(sqlL)

%>

<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<TITLE>Job Search - Personnel Plus, Inc. - Idaho's Total Staffing Solution</TITLE>
<META NAME="ROBOTS" CONTENT="INDEX, NOFOLLOW">
</HEAD>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
	<table border="0" width="740">
		<tr>
			<td align="center" width="576" valign="top">



<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" BGCOLOR="#FFFFFF">

	<TR>
		<TD ALIGN="center" VALIGN="top" WIDTH="100%">
  			<TABLE  BORDER="0" CELLSPACING="0" CELLPADDING="0">
				<TR>
				<TD BGCOLOR="#003366" ALIGN="left" HEIGHT="35"><IMG SRC="/img/tab_top_left.gif" ALT="" WIDTH="17" HEIGHT="35" BORDER="0"><IMG SRC="/img/tab_job_search.gif" ALT="Job Search" WIDTH="124" HEIGHT="31" BORDER="0"></TD>
<TD BGCOLOR="#003366" HEIGHT="35" ALIGN="right"><font color="#FFFFFF">Create your own search or search all jobs:</font><IMG SRC="/img/tab_top_right.gif" ALT="" WIDTH="17" HEIGHT="35" BORDER="0" ALIGN="absmiddle"></TD>
				</TR>
				<TR>
				<TD COLSPAN="2" WIDTH="80%">
<FORM NAME="searchJobListings" METHOD="post" ACTION="searchResults.asp">
  					<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="5" STYLE="border: 1px solid #D1DCEB;">
    				<TR> 
      					<TD ALIGN="right"><STRONG>Search For Keywords:</STRONG></TD>
      					<TD><INPUT TYPE="text" NAME="keywords" SIZE="50" MAXLENGTH="50"></TD>
    				</TR>
    				<TR> 
      					<TD ALIGN="right"><STRONG>Job Availability:</STRONG></TD>
      					<TD> 
				        <SELECT NAME="jobSchedule" SIZE="4">
				          <OPTION VALUE="" SELECTED>--- SELECT ONE ---</OPTION>
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
				          <OPTION VALUE="" SELECTED>ALL CATEGORIES &nbsp;&nbsp;</OPTION>
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
      					<TD VALIGN="top" ALIGN="right"><STRONG>City / State:</STRONG></TD>
      					<TD> 
						
				        <SELECT NAME="jobLocation" SIZE="1">
				          <OPTION VALUE="" SELECTED>--- ALL LOCATIONS ---</OPTION>
<%	
do while not rsL.eof
response.Write "<OPTION VALUE='" & rsL("jobCity") & ", " & rsL("jobState") & _
"'>" & rsL("jobCity") & ", " & rsL("jobState")
rsL.MoveNext

loop		
%>
</SELECT>

      					</TD>
    				</TR>						
    				<TR> 
      					<TD ALIGN="right"><STRONG>Sort By:</STRONG></TD>
      					<TD><INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="orderBy" VALUE="dateCreated" CHECKED>Date Posted<INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="orderBy" VALUE="jobTitle">Job Title<BR><INPUT TYPE="radio" STYLE="background:#FFFFFF; border:0; color:#FFFFFF" NAME="orderBy" VALUE="jobState">Location
		  				</TD>
    				</TR>
    				<TR> 
      					<TD align="center" colspan="2">
					<Table>
						<tr>
							<td><INPUT TYPE="submit" STYLE="background:#ffcc00; border:1 #333333 solid; font-size:9px; color:#000000;" NAME="submitBtn" VALUE="Start Search...">&nbsp;</form></td>
							<td>
<FORM ACTION="searchResults.asp" NAME="searchAll" METHOD="POST">
<input type="hidden" name="searchFlag" value="All">
<INPUT TYPE="submit" STYLE="background:#FFA500; border:1 #333333 solid; font-size:9px; color:#000000;" NAME="searchAll" VALUE="Search All Jobs">
</FORM>							
							</td>
						</tr>
					</TABLE>
					</TD>
    				</TR>	
  					</TABLE>
				</TD>
				</TR>
	
				</TABLE>
		</TD>
	</TR>		
</TABLE>
			</td>
<!-- #INCLUDE VIRTUAL='/inc/navi_right_main.asp' -->
		</tr>
	</table>

<%
rsCategory.Close
Connect.Close
set Connect = Nothing
%>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
</BODY>
</HTML>
