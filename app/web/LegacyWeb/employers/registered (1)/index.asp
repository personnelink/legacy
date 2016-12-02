<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
	<% if session("employerAuth") <> "true" then response.redirect("/index2.asp") end if%>
	<%
		dim sqlLocation,rsLocation,rsTotalListings,rsTotalApps,rsJobListings
		' get states and provinces
		sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
		set rsLocation = Connect.Execute(sqlLocation)
		' count job listings
		Set rsTotalListings = Connect.Execute("SELECT count(companyUserName) AS listingsCount FROM tbl_listings WHERE companyUserName = '" & session("companyUserName") & "'")
		' count job applications
		Set rsTotalApps = Connect.Execute("SELECT count(companyUserName) AS appsCount FROM tbl_applications WHERE companyUserName = '" & session("companyUserName") & "'")
		' get employer job listings
		set rsJobListings = Server.CreateObject("ADODB.RecordSet")
		rsJobListings.Open "SELECT jobID, empID, jobTitle, jobStatus, viewCount, dateCreated FROM tbl_listings WHERE companyUserName = '" & session("companyUserName") & "' ORDER BY dateCreated DESC",Connect,3,3
		' get employer profile
		set rsEmployerProfile = Server.CreateObject("ADODB.RecordSet")
		rsEmployerProfile.Open "SELECT * FROM tbl_employers WHERE empID = '" & session("empID") & "'",Connect,3,3
	%>
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<TITLE><%=company_name%>:&nbsp;&nbsp;<%=session("companyAgent")%>, Welcome to Personnel Plus!</TITLE>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">

</HEAD>

<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
<table border="1" width="100%">
	<tr>
		<TD align="center" colspan="5" valign="top" bgcolor="#b0c4de" width="98%"><strong>Employer Control Panel : <%= rsEmployerProfile("companyName")%></strong></td>
	</tr>
	<tr>
		<td width=385 colspan="2">
			<table BORDER="0" CELLPADDING="2" CELLSPACING="0" width="372">			
				<TR>
					<td width="368"><font color="#000000"> Your <%=rsEmployerProfile("companyType")%> Account Information:</font>
						<% if request("editProfileID") <> "" then %><br><font style class="smallTxt" color="#b22222">[Account Updated]</font>
						<% end if %>
					</td>
				</TR>
				<TR>
					<td width="368">
						<font face="Courier New,Georgia"><strong><%=rsEmployerProfile("companyName")%></strong>
							<br>
							<%=rsEmployerProfile("companyAgent")%> - <%=rsEmployerProfile("companyAgentTitle")%><br>
							<%=rsEmployerProfile("addressOne")%>
							<br>
							<% if TRIM(rsEmployerProfile("addressTwo")) <> "" then%> 
								<%=rsEmployerProfile("addressTwo")%>
								<br>
							<% end if%>
							<%=rsEmployerProfile("city")%>, <%=rsEmployerProfile("state")%>&nbsp;<%=rsEmployerProfile("zipcode")%>	
							<br>
							Phone: <%=rsEmployerProfile("companyPhone")%>
							<br>	
							<% if rsEmployerProfile("faxNumber") <> "" then%>
								Fax: <%=rsEmployerProfile("faxNumber")%>
							<%end if%>	
							<br>
							Email: 	<%=rsEmployerProfile("emailAddress")%>
							<br>
							Job Email: <%=rsEmployerProfile("jobEmailAddress")%>
						</font>	
					</td>
				</TR>	
				<TR>
					<td align="left" width="368">
						<font style class="smallTxt">
							<a href="/employers/registered/editProfile.asp?who=1">Edit Account</a>
						</font>
					</td>
				</tr>											
			</table>
		</td>
		<td width="22%" colspan="3" align="center">Since <strong><%=FormatDateTime(rsEmployerProfile("dateCreated"),2)%></strong>, 
			you have posted <strong><%=rsTotalListings("listingsCount")%></strong> 
			job(s).<br>You have received <strong><%=rsTotalApps("appsCount")%></strong> 
			job application(s).
			<p></p>
			Your Account Options:<br>
			<li>
				<a href="/employers/registered/jobAdd.asp?who=1">Post a New Job</a>
			</li>
			<!--li-->
				<a href="/employers/registered/timecards/index.asp" target="_blank"><!--Submit Employee Time Cards-->&nbsp;</a>
			<!--/li-->
			<p>
				&nbsp;
			</p>
			<p>
				&nbsp;
			</p>
		</td>
	</tr>
	<tr>
		<td width="100%" bgcolor="#9ACD32" colspan="5"><strong>Job Posting 
		History</strong> - Click on a job title to view or select 'Edit' to make 
		changes.</td>
	</tr>
	<tr>
		<td width="25%"><b>Date Posted:</b></td>
		<td width="33%" colspan="2"><b>Title:</b></td>
		<td width="12%"><b>Status:</b></td>
		<td width="8%"><b>Views:</b></td>
	</tr>
	<tr>
		<td colspan="5">
			<% if rsTotalListings("listingsCount") <> 0 then %>
	            <table width="100%" border="0" cellspacing="1" cellpadding="2">
<% do until rsJobListings.eof %>
                          <TR> 
						  	<td width="3%" bgcolor="#003366" bgcolor="#003366" style="border: 1px solid #cccccc" class="smallTxt"><a href="jobEdit.asp?jobID=<%=rsJobListings("jobID")%>"><font color="#FFFFFF">Edit</font></a></TD>
                            <td bgcolor="#D1DCEB" style class="smallTxt" width="21%"><%=rsJobListings("dateCreated")%></td>								  
                            <td bgcolor="#D1DCEB" style class="smallTxt" width="53%"><a href="jobView.asp?jobID=<%=rsJobListings("jobID")%>"><%=rsJobListings("jobTitle")%></a><% if rsJobListings("jobID") = request("jobEditID") then %>&nbsp;&nbsp;<font style class="smallTxt" color="#b22222">[Updated]</font><%end if%></td>
                            <td bgcolor="#D1DCEB" style class="smallTxt" width="12%"><%=rsJobListings("jobStatus")%></td>							
                            <td bgcolor="#D1DCEB" style class="smallTxt" width="7%"><%=rsJobListings("viewCount")%> x</td>
                          </tr>
                          <%
  rsJobListings.MoveNext
  loop
  %>

  				</table>	
			<% end if %>
		</TD>
	</tr>
</table>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
</BODY>
</HTML>
