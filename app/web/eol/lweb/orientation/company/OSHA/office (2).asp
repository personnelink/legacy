<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<META NAME="ROBOTS" CONTENT="INDEX, FOLLOW">
<TITLE>Welcome to Personnel Plus! Idaho's Total Staffing Solution</TITLE>
</HEAD>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/advertise/inc/navi_top.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/js/maximize.js' -->
<!-- NAVI TOP START CLSP8 -->
<%
	Dim submit_email,submit_fname,submit_lname,submit_result,submit_answer
	submit_email = request("submit_email")
	submit_fname = request("submit_fname")
	submit_lname = request("submit_lname")
	submit_trgemail = request("submit_trgemail")
	submit_result = " "
	submit_answer = " "
	
	Response.Cookies("OSHA")("email") = (submit_email)
	Response.Cookies("OSHA")("fname") = (submit_fname)
	Response.Cookies("OSHA")("lname") = (submit_lname)
	Response.Cookies("OSHA")("trgemail") = (submit_trgemail)
	Response.Cookies("OSHA")("result") = (submit_result)
	Response.Cookies("OSHA")("answer") = (submit_answer)
'	response.write"Cookies <BR>"
'	response.write request.cookies("OSHA")("email") & "<BR>"
'	response.write request.cookies("OSHA")("fname") & "<BR>"
'	response.write request.cookies("OSHA")("lname") & "<BR>"
%>
<div align="center">
	<table border="0" width="431" height="97">
		<tr>
			<td align="center" height="35" width="425">
				<H2>Office Training</H2>
			</td>
		</tr>
		<tr>
			<td align="center" width="425" height="30">
				&nbsp;
				Temporary Associate Office Training
				<form method="POST" action="/lweb/orientation/company/OSHA/office2.asp?goback=1&test=2">
					<input align="middle" type="submit" value="View Orientation" STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF">
				</form>
			</td>
		<tr>
			<td align="center" width="425">&nbsp;
				</td>
		<tr>&nbsp;</tr>
		</table>
<table border="0" width="44%" cellspacing="0" cellpadding="0">
	<tr>
		<td width="140"><a href="/lweb/orientation/company/OSHA/office2.asp">
		<img border="0" src="/lweb/img/OfficeErg.JPG" height="100"></a></td>
		<td>&nbsp;&nbsp;</td>
		<td width="117"><a href="/lweb/orientation/company/OSHA/office2.asp">
		<img border="0" src="/lweb/img/ElevSafety.JPG" height="100"></a></td>
	</tr>
	<tr>
		<td width="140">&nbsp;
		</td>
		<td>&nbsp;</td>
		<td width="117">&nbsp;</td>
	</tr>
	<tr>
		<td width="140"><a href="/lweb/orientation/company/OSHA/office2.asp">
		<img border="0" src="/lweb/img/OfficeClean.JPG" height="100"></a></td>
		<td>&nbsp;&nbsp;</td>
		<td width="117"><a href="/lweb/orientation/company/OSHA/office2.asp">
		<img border="0" src="/lweb/img/EmgEvac.JPG" height="100"></a></td>
	</tr>
	<tr>
		<td width="140">&nbsp;
		</td>
		<td>&nbsp;</td>
		<td width="117">&nbsp;
		</td>
	</tr>
	<tr>
		<td width="140"><a href="/lweb/orientation/company/OSHA/office2.asp">
		<img border="0" src="/lweb/img/Security.JPG" height="100"></a></td>
		<td>&nbsp;&nbsp;</td>
		<td width="117"><a href="/lweb/orientation/company/OSHA/office2.asp">
		<img border="0" src="/lweb/img/OfficeEquip.JPG" height="100"></a></td>
	</tr>
	<tr>
		<td width="140">&nbsp;
		</td>
		<td>&nbsp;</td>
		<td width="117">&nbsp;
		</td>
	</tr>
	<tr>
		<td width="140"><a href="/lweb/orientation/company/OSHA/office2.asp">
		<img border="0" src="/lweb/img/FirstAid.JPG" height="100"></a></td>
		<td>&nbsp;&nbsp;</td>
		<td width="117"><a href="/lweb/orientation/company/OSHA/office2.asp">
		<img border="0" src="/lweb/img/FandHSafety.JPG" height="100"></a></td>
	</tr>
</table>
</div>
<!-- End Main Content -->			
		
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/advertise/inc/navi_btm.asp' -->
</BODY>
</HTML>