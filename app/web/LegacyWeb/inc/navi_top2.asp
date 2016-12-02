<!-- BEGIN IMAGE SWAP -->

<!-- #INCLUDE VIRTUAL='/js/swap.js' -->

<!-- END IMAGE SWAP -->

<!-- BEGIN MAXIMIZE SCRIPT -->

<!-- #INCLUDE VIRTUAL='/js/maximize.js' -->

<!-- END MAXIMISE SCRIPT -->




<body onLoad="FP_preloadImgs(/*url*/'/img/webdev03.jpg')">
<center>
<TABLE WIDTH="800" BORDER="0" CELLPADDING="0" CELLSPACING="0">
	<TR>
		<TD WIDTH="2" NOWRAP></TD>
		<TD WIDTH="99" NOWRAP></TD>
		<TD WIDTH="92" NOWRAP></TD>
		<TD WIDTH="92" NOWRAP></TD>
		<TD WIDTH="93" NOWRAP></TD>
		<TD WIDTH="93" NOWRAP></TD>
		<TD WIDTH="91" NOWRAP></TD>
		<TD WIDTH="105" NOWRAP></TD>
		<TD WIDTH="131" NOWRAP></TD>
		<TD WIDTH="2" NOWRAP></TD>
	</TR>
	<TR>
		<TD ROWSPAN="4" WIDTH="2" bgcolor="#003366"></TD>
		<TD COLSPAN="3"><a href="/index.asp"><IMG SRC="/img/navi-2.gif" WIDTH="283" HEIGHT="72" border="0" alt="Personnel Plus, Inc."></A></TD>	
		<TD COLSPAN="4" bgcolor="#003366" WIDTH="382" HEIGHT="72" valign="top"><font color="#FFFFFF" style class="smallTxt"><% response.write(FormatDateTime(now(),1)&"&nbsp;&nbsp;")%></font></TD>
		<TD ROWSPAN="4" WIDTH="2" bgcolor="#003366"></TD>
	</TR>
	<TR>
		<TD ROWSPAN="2"><a href="/index.asp"><IMG SRC="/img/navi-6.gif" WIDTH="99" HEIGHT="40" border="0"></a></TD>
		<TD ROWSPAN="2"><a href="/lib/index.asp"><IMG SRC="/img/navi-7.gif" WIDTH="92" HEIGHT="40" border="0"></a></TD>
		<TD ROWSPAN="2"><a href="/search/index.asp"><IMG SRC="/img/navi-8.gif" WIDTH="92" HEIGHT="40" border="0"></a></TD>
		<TD ROWSPAN="2"><a href="/company/offices.asp"><IMG SRC="/img/navi-9.gif" WIDTH="93" HEIGHT="40" border="0"></a></TD>
		<TD ROWSPAN="2"><a href="/company/about.asp"><IMG SRC="/img/navi-10.gif" WIDTH="93" HEIGHT="40" border="0"></a></TD>
		<TD ROWSPAN="2"><a href="/hlp/index.asp"><IMG SRC="/img/navi-11.gif" WIDTH="91" HEIGHT="40" border="0"></a></TD>
		<TD COLSPAN="2"><IMG SRC="/img/navi-12.gif" WIDTH="236" HEIGHT="8" border="0"></TD>
	</TR>
	<TR>
		<% if session("adminAuth") = "" AND session("auth") = "" AND session("employerAuth") = "" then %>
			<TD COLSPAN="2" WIDTH="236" HEIGHT="32" bgcolor="#C7D2E0" align="center" NOWRAP>
				<div style="position: absolute; width: 127px; height: 20px; z-index: 2; left: 631px; top: 106px" id="layer2">
					<% if session("companyUserName") <> "" then %>
						<FONT COLOR="#003366"><strong>Welcome,  <%=session("companyAgent")%></strong></FONT><BR>
						<td align="center" valign="top"><A HREF="/employers/registered/index.asp?who=1"><strong>Go To Account</strong></a>
					<% end if %>
					<% if user_name <> "" then %>
						<FONT COLOR="#003366"><strong>Welcome,  <%=user_firstname%>&nbsp;<%=user_lastname%></strong></FONT>
						<A HREF="/seekers/registered/index.asp?who=2"><strong>Go To Account</strong></a>
					<% end if %>
<!--					<% if session("companyUserName") = "" AND user_name= "" THEN %>
						<font color="#C6D3E7">
						<a href="/index2.asp">					
							<span style="text-decoration: none">Return User Login</span>
						</a>
						</font>
					<% end if %>-->
				</div>
			</TD>
		<% Else %>
			<td colspan="2" width="236" height="32" bgcolor="#C7D2E0" align="right">
				<font style class="logout"><strong><%=user_name%><%=session("companyUserName")%> : <a href="/logout.asp">LOGOUT</a></strong></font>&nbsp;
			</td>
		<% End if %>	
	</TR>
	<TR>
<!-- SET BKG HERE FOR MAIN CONTENT C7D2E0 -->
		<TD COLSPAN="8" WIDTH="800" bgcolor="#C7D2E0" align="center">
<!-- Start Pad -->
			<TABLE WIDTH="760" BORDER=0 CELLPADDING=0 CELLSPACING=0 BGCOLOR="#FFFFFF">
				<TR>
					<TD height="12" colspan="3" bgcolor="#C7D2E0" align="right">
					</TD>
				</TR>
				<TR>
					<TD WIDTH=10 HEIGHT=10><IMG SRC="/img/pad_1.gif" WIDTH=10 HEIGHT=10></TD>
					<TD WIDTH="780" HEIGHT=10><IMG SRC="/img/pad_2.gif" WIDTH=563 HEIGHT=10></TD>
					<TD WIDTH=10 HEIGHT=10><IMG SRC="/img/pad_3.gif" WIDTH=10 HEIGHT=10></TD>
				</TR>
				<TR>
					<TD COLSPAN=3 WIDTH=100% ALIGN="center">