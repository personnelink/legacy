<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<html>
	<head>
		<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
		<meta name="ROBOTS" content="INDEX, FOLLOW">
		<title>Welcome to Personnel Plus! Idaho's Total Staffing Solution</title>
	</head>
	<noscript>Your internet browser does not support the scripting on this page. Please be sure you have the most current browser version installed</noscript>
	<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top2.asp' -->
	<!-- Navi Top Start CLSP8 -->
	<div align="center">
		<table border="0" width="746">
			<tr>
				<td colspan="2" align="center" height="35" width="740">
					<h2>Welcome to Personnel Plus!</h2>
				</td>
				<!-- Place Column Here -->
				<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_right_main.asp' -->
			</tr>
			<tr>
				<td align="center">
					<table border="0" cellpadding="3" cellspacing="0" width="576">
					<%if session("UserName") <> "" then%>
						<tr>
							<td align="center" bgcolor="#eee8aa" style="border: 1px solid #eee8aa;">
								<font color="#003366">
									<strong>Welcome,  <%=session("firstName")%>&nbsp;<%=session("lastName")%></strong>
								</font>
							</td>
						</tr>
						<tr>
							<td align="center" height="25">
								<a href="/lweb/seekers/registered/index.asp?who=2&?#app"><strong>Go To Account</strong></a>
							</td>
						</tr>
					<%end if%>
					<%if session("UserName") = "" then%>
						<tr>
							<td align="center" bgcolor="#C7D2E0" width="570" height="35">
								<font size="+1" face="Verdana, Arial, Helvetica, sans-serif" color="#003366">
									<a href="/lweb/index2.asp?who=2&?#app"><span style="text-decoration: none;">Applicants!</span></a>
								</font>
								Job Seekers, see what <strong>Personnel Plus</strong> has to offer.
							</td>
							<td bgcolor="#C7D2E0" align="center" valign="middle">
								<form method="post" action="/lweb/index2.asp?who=2&?#app" style="padding: 0; margin: 0;">
									<input type="submit" value="Applicant, Login" STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF; vertical-align: middle;">
								</form>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="border: 1px solid #C7D2E0;" height="103" width="568" align="center">
								<a href="/lweb/seekers/new/applyDirect.asp?who=2" style="text-decoration: none; font-weight: bold; color: #BD1429">You Can Try Your Job First!!!</a>
								<br />
								<br />* One Stop Shop for Jobs VS. Dropping off <strong>Many</strong> Resumes *<br />* Variety of Jobs and Work Environments *<br />* Your Choice of the Job and the Hours *<br />* Try the Employer First! *<br /><br />
								<em>Full / Part-Time Work</em><br /><br />
								<form method="POST" action="/lweb/seekers/new/applyDirect.asp?who=2">
									<input align="middle" type="submit" value="Apply Now!!!" STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF"><br>
								</form>
								Three Convenient Ways to Receive Pay:<br />
								<ul>
									<!-- BEGIN SCROLLING SCRIPT -->                 
									<script language="JavaScript1.2">
									//configure the below five variables to change the style of the scroller
									var scrollerwidth=400
									var scrollerheight=20
									var scrollerbgcolor=''
									//set below to '' if you don't wish to use a background image
									var scrollerbackground=''
									
									//configure the below variable to change the contents of the scroller
									var messages=new Array()
									messages[0]="<a href='/lweb/company/payment.asp' target='_blank'><font face='Arial' color='#AF0000'><b><LI>Check</LI></b></font></a>"
									messages[1]="<a href='/lweb/company/payment.asp' target='_blank'><font face='Arial' color='#00AF00'><b><LI>Direct Deposit</li></b></font></a>"
									messages[2]="<a href='/lweb/company/payment.asp' target='_blank'><font face='Arial' color='#0000AF'><b><li>IPAY Debit Card</li></b></font></a>"
									
									</script>
									
									<!-- #INCLUDE VIRTUAL='/lweb/js/scroll.js' -->
									
									<!-- END SCROLLING SCRIPT 001B -->
								</ul>
								<br />
								<a href="/lweb/index2.asp?who=2&?#applicant" style="color: #BD1429; font-weight: bold; text-decoration: none">Click here for more Information</a>
							</td>
						</tr>
					<%end if%>
						<tr>
							<td align="center" bgcolor="#C7D2E0" width="570" height="34" colspan="2">
								<font size="+1" face="Verdana, Arial, Helvetica, sans-serif" color="#003366" style="text-decoration: none;">Orientation</font>
							</td>
						</tr>
						<tr>
							<td style="border: 1px solid #C7D2E0;" height="103" width="568" colspan="2" align="center">
								<font color="#BD1429" style="font-weight: bold;">Here you will find all the Orientation information you need to start your new job.</font>
								<br /><a href="/lweb/orientation/rules.asp" target="_blank">Rules to Remember</a>
								<br /><a href="/lweb/orientation/rights.asp" target="_blank">Your Right to Know</a>
								<br />
								<% if request.cookies("OSHATEST") <> "DONE" then %>
									<a href="/lweb/orientation/company/OSHA/OSHA.asp" target="_blank">OSHA</a>
								<% else %>
									You have already taken the OSHA training courses needed.
								<% end if %>
							</td>
						</tr>
					</table>
					<!-- Employers Stuff -->
					<table style="margin-top: 10px;" border="0" cellpadding="3" cellspacing="0" width="576">
					<%if session("companyUserName") <> "" then%>
						<tr>
							<td align="center" bgcolor="#eee8aa" style="border: 1px solid #eee8aa; color: #003366; font-weight: bold;" valign="top" width="476">
								Welcome,  <%=session("companyAgent")%>
							</td>
							<td width="100">
								<a href="/lweb/employers/registered/index.asp?who=1&?#applicant" style="font-weight: bold;">Go To Account</a>
							</td>
							<td bgcolor="#C7D2E0">&nbsp;</td>
						</tr>
					<%end if%>
					<%if session("companyUserName") = "" then %>
						<tr>
							<td align="center" bgcolor="#C7D2E0" width="564" height="35" valign="top" colspan="2">
								<font size="+1" face="Verdana, Arial, Helvetica, sans-serif" color="#003366"><a href="/lweb/index2.asp?who=1&?#applicant" style="text-decoration:none;">Employers!</a></font> We have Quality Employees.
							</td>
							<td bgcolor="#C7D2E0" align="center" valign="middle">
								<form method="post" action="/lweb/index2.asp?who=1&?#applicant" style="padding: 0; margin: 0;">
									<input type="submit" value="Employer, Login" STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF; vertical-align: middle;">
								</form>
							</td>
						</tr>
						<tr>
							<td style="border: 1px solid #C7D2E0; text-align:center;" height="103" width="560" colspan="3">
								<a href="/lweb/company/benefits.asp" target="_blank" style="text-decoration: none; color: #BD1429; font-weight: bold;">Screened and Ready to Work!</a>
								<br /><br />
								* General Labor * Manufacturing * Construction * Warehouse *
								<br />
								* Call Center * Office / Clerical * Bookkeeping * Janitorial *
								<br /><br />
								<em>Temporary or Permanent * Full / Part-Time</em>
								<br /><br />
								<form method="POST" action="/lweb/employers/email_job/jobmail.asp?page=1" target="_blank">
									<input align="middle" type="submit" value="Order Employees" STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF">
								</form>
								<form method="post" action="/lweb/employers/email_job/jobmail.asp?page=2" target="_blank">
									<input align="middle" type="submit" value="Email Your Job Openings" style="background:#339900; border:1 #333333 solid; font-size:9px; color:#ffffff"><br>
								</form>
								Workers Comp.   Coverage Bonded & Insured
								<br /><br />
								<a href="/lweb/company/post.asp" style="text-decoration: none; color: #bd1429; font-weight: bold;" target="_blank">Click here for more Information</a>
							</td>
						</tr>
					<%end if%>
					</table>
					<!-- Final Stuff -->
					<p><img src="/lweb/img/shake.jpg" alt="" width="150" height="85" border="0" align="left" hspace="0"></p>
					<table border="0" cellpadding="3" cellspacing="0" width="426">
						<tr>
							<td style="border: 1px solid #C7D2E0;" width="418">
								<strong>Our Mission</strong>: To provide quality human resource solutions through a network that profits our associates, customers, and communities. 
								<p></p>
								<div align="center"><em>&quot;Your Total Staffing Solution&quot;</em></div>
							</td>
						</tr>
					</table>
					<p><a href="http://www.staffingtoday.net/aboutasa/index.html" target="_blank"><img src="/lweb/img/asa.gif" alt="" width="264" height="48" border="0"></a>
				</td>
			</tr>
		</table>
	</div>
<!-- End Main Content -->
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
	</body>
</html>