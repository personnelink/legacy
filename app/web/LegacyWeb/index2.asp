<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<META NAME="ROBOTS" CONTENT="INDEX, FOLLOW">
<TITLE>Welcome to Personnel Plus! Idaho's Total Staffing Solution</TITLE>
</HEAD>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
<div align="center">
	<table border="0" width="728">
		<tr>
			<td colspan="2" align="center" height="35" width="533">
				<h2>Welcome to Personnel Plus!</h2>
			</td>
<!-- PLACE RIGHT COLUMN HERE -->
<!-- #INCLUDE VIRTUAL='/inc/navi_right_info.asp' -->
		</tr>
		<tr>
			<td width="533" height="35" colspan="2">&nbsp;</td>
		</tr>
<% if request("DA") = 1 then %>
		<tr>
			<td width="150" align="center" colspan="2" valign="top">
				You have only just recenly sent an application in. Please allow time for your submission to be processed.
			</td>
		</tr>
<% end if %>
<% if request("who") = 1 then %>
		<tr>
			<td width="150" align="center" height="205">
			<img border="0" src="/img/commu006.jpg" width="150" height="180"></td>
			<td align="center" width="376" height="35">
								<TABLE border="0" cellpadding="3" cellspacing="0" width="374">
								<% if session("companyUserName") <> "" then %>
									<TR>
										<td align="center" BGCOLOR="#eee8aa" STYLE="border: 1px solid #eee8aa;"><FONT COLOR="#003366"><strong>Welcome,  <%=session("companyAgent")%></strong></FONT></td>
									</TR>
									<TR>
										<td align="center"><A HREF="/employers/registered/index.asp?who=1"><strong>Go To Account</strong></a></td>
									</TR>
								<% end if %>		
								<% if session("companyUserName") = "" then %>	
								<TR>
				<td align="center" BGCOLOR="#C7D2E0" width="368" height="35"><FONT SIZE="+1" FACE="Verdana" COLOR="#003366">
				Employers</FONT>:</td>
			</TR>		
			<TR>
				<TD STYLE="border: 1px solid #C7D2E0;" height="170" width="366">
				<A HREF="/employers/new/newEmpAcct1.asp?who=1"><STRONG>
				Create your <EM>free</EM> account now and post your job 
				openings!</STRONG></A> 
<FORM NAME="empLogin" METHOD="post" ACTION="/employers/registered/setSession.asp?who=1">
	<INPUT TYPE="hidden" NAME="pgOrig" VALUE="hp">
				<TABLE BORDER="0" CELLPADDING="3" CELLSPACING="0">
					<TR>
						<TD COLSPAN="2">Already have an Employer Account?</TD>
					</TR>
					<TR>
				<TD>
				<INPUT TYPE="text" NAME="companyUserName" SIZE="10" MAXLENGTH="30" STYLE="background:#F1F1F1; border:1 #333333 solid; font-size:9px; color:#111111"><BR><FONT SIZE="1">
				username</FONT></TD>
				<TD>
				<INPUT TYPE="password" NAME="password" SIZE="10" MAXLENGTH="30" STYLE="background:#F1F1F1; border:1 #333333 solid; font-size:9px; color:#111111"><BR><FONT SIZE="1">
				password</FONT></TD>
					</TR>
					<TR>
					<TD VALIGN="top" COLSPAN="2">
					<INPUT TYPE="button" NAME="btn_empLogin" VALUE="login" STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" onClick="checkInfo2()">
<% if request("error") <> "" then %>
	<% if request("error") = 1 then %> <STRONG><FONT COLOR="#b22222">Invalid Username!</FONT></STRONG> <% end if %>
	<% if request("error") = 2 then %> <STRONG><FONT COLOR="#b22222">Invalid Password!</FONT></STRONG> <% end if %>
	<% if request("error") = 3 then %> <STRONG><FONT COLOR="#B22222">Your Account is Disabled, Contact the Admin!</FONT></STRONG> <% end if %>
<% End if %>
<BR>
<A HREF="/employers/forgotLogin.asp?who=1"><FONT SIZE="1"><STRONG>
					Forgot your login?</STRONG></FONT></A><br><br><a href="/company/qag.asp" target="_blank">View our Quality Assurance Guarantee</a><br>
					<a href="/company/ppa.asp" target="_blank">See the Personnel Plus Advantage!</a><br>
					<a href="/company/benefits.asp" target="_blank">Your Benefits Through Us</a><br>
					<a href="/company/testimonial.asp" target="_blank">Read other Employer's Testimonials</a><br>
					<a href="/company/hr.asp" target="_blank">Our Human Rescource Services</a><br>
					<a href="/company/note.asp" target="_blank">A Personal Note From our President...</a>
						</TD>
					</TR>
				</TABLE>
				</FORM>
 					</TD>
				</TR>
<% End if %>	
 </td>
								</tr></table>
			</td>
		</tr>
<% end if %>

<% if request("who") = 2 then %>
		<tr>
			<td width="150" height="205" align="center">
			<img border="0" src="/img/commu008.jpg" width="150" height="180"></td>
			<td width="376" height="35" align="center">
	<!-- id=applicant -->							<TABLE border="0" cellpadding="3" cellspacing="0" width="376">
								<% if user_name <> "" then %>
									<TR>
										<td align="center" BGCOLOR="#eee8aa" STYLE="border: 1px solid #eee8aa;"><FONT COLOR="#003366"><strong>Welcome,  <%=user_firstname%>&nbsp;<%=user_lastname%></strong></FONT></td>
									</TR>
									<TR>
										<td align="center"><A HREF="/seekers/registered/index.asp?who=2"><strong>Go To Account</strong></a></td>
									</TR>
								<% end if %>		
								<% if user_name = "" then %>
								<TR>
				<td align="center" BGCOLOR="#C7D2E0" width="365" height="35">
				<font face="Verdana" size="+1" color="#003366">Applicants</font>:</td>
			</TR>		
			<TR>
				<TD STYLE="border: 1px solid #C7D2E0;" height="170" width="365">
				<A HREF="/seekers/new/applyDirect.asp?who=2"><STRONG>
				Create your <EM>free</EM> account now and view our job 
				openings!</STRONG></A> 
<FORM NAME="hpform" METHOD="post" ACTION="/seekers/registered/setSession.asp?who=2">
	<INPUT TYPE="hidden" NAME="pgOrig" VALUE="hp">
				<TABLE BORDER="0" CELLPADDING="3" CELLSPACING="0">
					<TR>
						<TD COLSPAN="2">Already have an Applicant Account?</TD>
					</TR>
					<TR>
				<TD>
				<INPUT TYPE="text" NAME="uN" SIZE="10" MAXLENGTH="30" STYLE="background:#F1F1F1; border:1 #333333 solid; font-size:9px; color:#111111"><BR><FONT SIZE="1">
				username</FONT></TD>
				<TD>
				<INPUT TYPE="password" NAME="uNer" SIZE="10" MAXLENGTH="30" STYLE="background:#F1F1F1; border:1 #333333 solid; font-size:9px; color:#111111"><BR><FONT SIZE="1">
				password</FONT></TD>
					</TR>
					<TR>
					<TD VALIGN="top" COLSPAN="2">
					<INPUT TYPE="button" NAME="btn_Input" VALUE="login" STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" onClick="checkInfo()">
<% if request("error") <> "" then %>
	<% if request("error") = 9 then %> <STRONG><FONT COLOR="#b22222">Invalid Username!</FONT></STRONG> <% end if %>
	<% if request("error") = 8 then %> <STRONG><FONT COLOR="#b22222">Invalid Password!</FONT></STRONG> <% end if %>
	<% if request("error") = 6 then %> <STRONG><FONT color="#b22222">Your Account is Disabled, contact the nearest office!</FONT></STRONG> <% end if %>
<% End if %>
<BR>
<A HREF="/seekers/forgotLogin.asp?who=2"><FONT SIZE="1"><STRONG>
					Forgot your login?</STRONG></FONT></A>
						</TD>
					</TR>
				</TABLE>
				</FORM>
 					</TD>
				</TR>
<% end if %>	
 </td>
								</tr></table>
			</td>
		</tr>
<% end if %>
<% if session("adminAuth") = "true" then %>
		<tr>
			<td width="450" height="238" colspan="2" align="right" valign="top">
				<TABLE WIDTH="75%" BORDER="0" CELLPADDING="2" CELLSPACING="5" BGCOLOR="#FFFFFF" STYLE="border: 1px solid #000000;">
					<tr>
						<td align=center width="118%" colspan="2"><FONT COLOR="#003366"><strong>Welcome,  <%=user_firstname%>&nbsp;<%=user_lastname%></strong></FONT></td>
					</tr>
					<TR>
						<TD ALIGN="center" COLSPAN="2" BGCOLOR="#b22222" STYLE CLASS="smallTxt"><STRONG><FONT COLOR="#FFFFFF">Job Maintenance Options:</FONT></STRONG></TD>
					</TR>
					<TR>
						<TD STYLE CLASS="smallTxt" ALIGN="center" width="52%"><A HREF="/company/staff/jobOrder.asp"><STRONG>Post a New Job</STRONG></A> 			</TD>
						<TD STYLE CLASS="smallTxt" ALIGN="center" width="42%"><A HREF="/company/staff/jobMod.asp"><STRONG>Edit Job(s) </STRONG></A> 			</TD>
					</TR>
					<TR>
						<TD COLSPAN="2" ALIGN="center" CLASS="smallTxt">
							<A HREF="/company/staff/jpm_admguide.asp" TARGET="_NEW"><STRONG>Overview & Instructions </STRONG></A>
						</TD>
					</TR>	
				</TABLE>
			</td>
		</tr>
<% end if %>
		<tr>
			<td width="150" height="238">

<IMG SRC="/img/shake.jpg" ALT="" WIDTH="150" HEIGHT="85" BORDER="0" ALIGN="left" hspace="0"></td>
			<td width="376" height="238" align="center">
								<TABLE border="0" cellpadding="3" cellspacing="0" width="376">
								<TR>
									<TD STYLE="border: 1px solid #C7D2E0;" width="365">
&nbsp;<strong>Personnel Plus</strong>, in business over 14 years, is locally owned 
and operated and one of the largest and most established staffing services in 
Southern Idaho.<br>  
We have earned a superior reputation for our dedication in providing outstanding 
customer service and providing our clients with quality employees when they need 
them. 
<br>
&nbsp;Our staffing professionals are available 24 hours a day; 7 days a week to 
ensure your needs are met. We follow-up on every order to make sure the person 
arrives on time and that work performance is acceptable.
<p></p>
&nbsp;<strong>Our Mission</strong>: To provide quality human resource solutions 
through a network that profits our associates, customers, and communities. 
<p></p>
<DIV ALIGN="center"><EM>&quot;Your Total Staffing Solution&quot;</EM>
</DIV>									
									</TD>
								</TR>
								</TABLE>
								</td>
		</tr>
		<tr>
			<td width="150" align="center" height="48">&nbsp;</td>
			<td width="376" align="center" height="48">
				<a href="http://www.staffingtoday.net/aboutasa/index.html" target="_blank">
					<img src="/img/asa.gif" alt="" width="264" height="48" border="0">
				</a>
			</td>
		</tr>
	</table>
</div>
<!-- End Main Content -->			
		
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
</BODY>
</HTML>