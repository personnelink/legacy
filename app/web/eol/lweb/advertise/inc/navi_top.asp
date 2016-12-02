<!-- BEGIN SWAP.JS -->
<!-- INCLUDE VIRTUAL='/lweb/js/swap.js' -->
<!-- END SWAP.JS -->

<body id="top">

<% if request("goback") = "1" then %>
	<div style="position: absolute; width: 100px; height: 23px; z-index: 1; left: 419px; top: 99px" id="goback">
		<FORM> 
			<INPUT STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" type="button" value="Go Back" onClick="history.go(-1)"> 
		</FORM>
	</div>
<% end if %>
<% if request("goback") = "2" then %>
	<div style="position: absolute; width: 100px; height: 23px; z-index: 1; left: 419px; top: 99px" id="goback">
		<FORM> 
			<INPUT STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" type="button" value="Go Back" onClick="history.go(-2)"> 
		</FORM>
	</div>
<% end if %>
<% if request("goback") = "3" then %>
	<div style="position: absolute; width: 100px; height: 23px; z-index: 1; left: 419px; top: 99px" id="goback">
		<FORM> 
			<INPUT STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" type="button" value="Go Back" onClick="history.go(-2)"> 
		</FORM>
	</div>
<% end if %>
<% if request("test") = "2" then %>
	<div style="position: absolute; width: 100px; height: 30px; z-index: 3; left: 357px; top: 123px" id="test">
		<FORM method="post" action="/lweb/orientation/company/OSHA/tests/officetest.asp?goback=3"> 
			<INPUT STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" type="submit" value="Take the Office Test"> 
		</FORM>			
	</div>
<% end if %>
<% if request("test") = "3" then %>
	<div style="position: absolute; width: 100px; height: 30px; z-index: 3; left: 357px; top: 123px" id="test">
		<FORM method="post" action="/lweb/orientation/company/OSHA/tests/labortest.asp?goback=3"> 
			<INPUT STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" type="submit" value="Take the Labor Test"> 
		</FORM>			
	</div>
<% end if %>

<TABLE WIDTH="800" BORDER="0" CELLPADDING="0" CELLSPACING="0">
	<TR>
		<TD WIDTH="4" NOWRAP></TD>
		<TD WIDTH="283" NOWRAP></TD>
		<TD WIDTH="281" NOWRAP></TD>
		<TD WIDTH="228" NOWRAP></TD>
		<TD WIDTH="4" NOWRAP></TD>
		<TD WIDTH="98" NOWRAP></TD>
		<TD WIDTH="91" NOWRAP></TD>
		<TD WIDTH="105" NOWRAP></TD>
		<TD WIDTH="131" NOWRAP></TD>
		<TD WIDTH="2" NOWRAP></TD>
	</TR>
	<TR>
		<TD ROWSPAN="4" WIDTH="4" bgcolor="#003366"></TD>
		<TD COLSPAN="1"><a href="/index.asp"><IMG SRC="/lweb/img/navi-2.gif" WIDTH="283" HEIGHT="72" border="0" alt="Personnel Plus, Inc."></A></TD>	
		<TD COLSPAN="1" bgcolor="#003366" WIDTH="281" HEIGHT="72" valign="top"><font color="#FFFFFF" style class="smallTxt"><% response.write(FormatDateTime(now(),1)&"&nbsp;&nbsp;")%></font></TD>
<!-- PLACE ADD HERE!!! -->
		<TD WIDTH="228" HEIGHT="72" bgcolor="#003366">
						
		</TD>
<!-- END PLACE ADD -->
		<TD ROWSPAN="4" WIDTH="4" bgcolor="#003366"></TD>
	</TR>
	<TR>
		<TD ROWSPAN="1"><IMG SRC="/lweb/img/navi-12.gif" WIDTH="283" HEIGHT="8" border="0"></TD>
		<td rowspan="1"><img src="/lweb/img/navi-12.gif" width="281" height="8" border="0"></td>
		<TD COLSPAN="2"><IMG SRC="/lweb/img/navi-12.gif" WIDTH="236" HEIGHT="8" border="0"></TD>
	</TR>
	<TR>
		<TD COLSPAN="3" WIDTH="792" HEIGHT="32" bgcolor="#C7D2E0" align="center" NOWRAP>
			<div style="position: absolute; width: 127px; height: 20px; z-index: 2; left: 651px; top: 101px" id="layer2">
				<div style="position: absolute; width: 124px; height: 19px; z-index: 1; left: -351px; top: -2px" id="layer3">
					<FORM> 
						<INPUT STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" type="button" value="Close Window" onClick="javascript:window.close()"> 
					</FORM>
				</div>
			</div>
		</TD>
	</TR>
	<TR>
<!-- SET BKG HERE FOR MAIN CONTENT C7D2E0 -->
		<TD COLSPAN="3" WIDTH="792" bgcolor="#C7D2E0" align="center">
<!-- Start Pad -->
			<TABLE WIDTH="760" BORDER=0 CELLPADDING=0 CELLSPACING=0 BGCOLOR="#FFFFFF">
				<TR>
					<TD height="12" colspan="3" bgcolor="#C7D2E0" align="right">
					</TD>
				</TR>
				<TR>
					<TD WIDTH=10 HEIGHT=10><IMG SRC="/lweb/img/pad_1.gif" WIDTH=10 HEIGHT=10></TD>
					<TD WIDTH="780" HEIGHT=10><IMG SRC="/lweb/img/pad_2.gif" WIDTH=563 HEIGHT=10></TD>
					<TD WIDTH=10 HEIGHT=10><IMG SRC="/lweb/img/pad_3.gif" WIDTH=10 HEIGHT=10></TD>
				</TR>
				<TR>
					<TD COLSPAN=3 WIDTH="100%" ALIGN="center">