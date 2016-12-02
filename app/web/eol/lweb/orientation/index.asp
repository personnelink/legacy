<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<META NAME="ROBOTS" CONTENT="INDEX, FOLLOW">
<TITLE>Welcome to Personnel Plus! Idaho's Total Staffing Solution</TITLE>
</HEAD>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/js/maximize.js' -->
<!-- NAVI TOP START CLSP8 -->
<div align="center">
	<table border="0" width="746">
		<tr>
			<td align="center">
				<H2>Orientation...</H2>
			</td>
		</tr>
		<tr>
			<td align="center">&nbsp;
				
			</td>
		</tr>
		<tr>
			<td align="center">
<FORM NAME="orLogin" METHOD="post" ACTION="/lweb/orientation/setSession.asp">
	<INPUT TYPE="hidden" NAME="pgOrig" VALUE="or">
				<TABLE BORDER="0" CELLPADDING="3" CELLSPACING="0" width="176">
					<TR>
						<TD COLSPAN="2" align="center">Login with your given<br>password to continue...</TD>
					</TR>
					<TR>
				<TD align="center">
				<INPUT TYPE="password" NAME="password" SIZE="15" MAXLENGTH="30" STYLE="background:#F1F1F1; border:1 #333333 solid; font-size:9px; color:#111111"><BR><FONT SIZE="1">
				password</FONT></TD>
					</TR>
					<TR>
					<TD VALIGN="top" COLSPAN="2" align="center">
					<INPUT TYPE="button" NAME="btn_orLogin" VALUE="login" STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" onClick="checkInfo3()">
<% if request("error") <> "" then %>
	<% if request("error") = 2 then %> <STRONG><FONT COLOR="#b22222">Invalid Password!</FONT></STRONG> <% end if %>
<% End If %>
<BR>
						</TD>
					</TR>
				</TABLE>
				</FORM>
			</td>
		</tr>
	</table>
</div>
<!-- End Main Content -->			
		
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
</BODY>
</HTML>