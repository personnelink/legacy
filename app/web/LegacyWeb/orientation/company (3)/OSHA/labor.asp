<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<META NAME="ROBOTS" CONTENT="INDEX, FOLLOW">
<TITLE>Welcome to Personnel Plus! Idaho's Total Staffing Solution</TITLE>
</HEAD>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- INCLUDE VIRTUAL='/advertise/inc/navi_top.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
<!-- #INCLUDE VIRTUAL='/js/maximize.js' -->
<!-- NAVI TOP START CLSP8 -->
<%
	dim submit_email,submit_fname,submit_lname,submit_result,submit_answer
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
				<H2>Labor Training</H2>
			</td>
		</tr>
		<tr>
			<td align="center" width="425" height="30">
				&nbsp;
				Temporary Associate General Labor
				<form method="POST" action="/orientation/company/OSHA/Labor2.asp?goback=1&test=3">
					<input align="middle" type="submit" value="View Orientation" STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF">
				</form>
			</td>
		<tr>
			<td align="center" width="425">
				&nbsp;</td>
		<tr>&nbsp;</tr>
		</table>
<table border="0" width="44%" cellspacing="0" cellpadding="0">
	<tr>
		<td width="140"><a href="/orientation/company/OSHA/Labor2.asp?goback=1&test=3&#HazCom">
		<img border="0" src="/img/HazCom.JPG" height="100"></a></td>
		<td>&nbsp;&nbsp;</td>
		<td width="117"><a href="/orientation/company/OSHA/Labor2.asp?goback=1&test=3&#MachineGuard">
		<img border="0" src="/img/MachineGuard.JPG" height="100"></a></td>
	</tr>
	<tr>
		<td width="140">
		&nbsp;</td>
		<td>&nbsp;</td>
		<td width="117">&nbsp;</td>
	</tr>
	<tr>
		<td width="140"><a href="/orientation/company/OSHA/Labor2.asp?goback=1&test=3&#Lockout">
		<img border="0" src="/img/Lockout.JPG" height="100"></a></td>
		<td>&nbsp;&nbsp;</td>
		<td width="117"><a href="/orientation/company/OSHA/Labor2.asp?goback=1&test=3&#HndTools">
		<img border="0" src="/img/HndTools.JPG" height="100"></a></td>
	</tr>
	<tr>
		<td width="140">
		&nbsp;</td>
		<td>&nbsp;</td>
		<td width="117">
		&nbsp;</td>
	</tr>
	<tr>
		<td width="140"><a href="/orientation/company/OSHA/Labor2.asp?goback=1&test=3&#ProtectEquip">
		<img border="0" src="/img/ProtectEquip.JPG" height="100"></a></td>
		<td>&nbsp;&nbsp;</td>
		<td width="117"><a href="/orientation/company/OSHA/Labor2.asp?goback=1&test=3&#MaterialHand">
		<img border="0" src="/img/MaterialHand.JPG" height="100"></a></td>
	</tr>
	<tr>
		<td width="140">
		&nbsp;</td>
		<td>&nbsp;</td>
		<td width="117">
		&nbsp;</td>
	</tr>
	<tr>
		<td width="140"><a href="/orientation/company/OSHA/Labor2.asp?goback=1&test=3&#EmgProced">
		<img border="0" src="/img/EmgProced.JPG" height="100"></a></td>
		<td>&nbsp;&nbsp;</td>
		<td width="117"><a href="/orientation/company/OSHA/Labor2.asp?goback=1&test=3&#Frklft">
		<img border="0" src="/img/Frklft.JPG" height="100"></a></td>
	</tr>
</table>
</div>
<!-- End Main Content -->			
		
<!-- NAVI BTM START CLSP10 -->
<!-- INCLUDE VIRTUAL='/advertise/inc/navi_btm.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
</BODY>
</HTML>