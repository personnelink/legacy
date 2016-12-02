<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/loggedRedirect.asp' -->
<%
' Get states/provinces
Dim sqlLocation
Dim rsLocation
sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation = Connect.Execute(sqlLocation)

Dim sqlLocation2
Dim rsLocation2
sqlLocation2 = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation2 = Connect.Execute(sqlLocation2)

Dim sqlLocation3
Dim rsLocation3
sqlLocation3 = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation3 = Connect.Execute(sqlLocation3)

' Get countries
Dim sqlCountry
Dim rsCountry
sqlCountry = "SELECT locCode, locName, display FROM tbl_locations WHERE display = 'N' ORDER BY locName"
set rsCountry = Connect.Execute(sqlCountry)
%>	
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<TITLE>Creating Your New Account - Step 3: General Preferences</TITLE>
<SCRIPT LANGUAGE="javascript">
function checkPreferences()  {

var isGood = true
document.preferenceInfo.submit_btn.disabled = true;	

  if (!document.preferenceInfo.qRelocate[0].checked && !document.preferenceInfo.qRelocate[1].checked)
    {  alert("Please indicate if you are willing to relocate for work."); 
	document.preferenceInfo.qRelocate[0].focus();
document.preferenceInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}	
		
  if (!document.preferenceInfo.schedule[0].checked && !document.preferenceInfo.schedule[1].checked && !document.preferenceInfo.schedule[2].checked && !document.preferenceInfo.schedule[3].checked)
    {  alert("Please check at least one work schedule option."); 
	document.preferenceInfo.schedule[0].focus();
document.preferenceInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}	
		
  if (document.preferenceInfo.wageAmount.value == '' || isNaN(document.preferenceInfo.wageAmount.value))
    {  alert("Please enter desired income in US dollars using numbers only.\n\n Example: 11.25 or 38750.\n\n"); 
	document.preferenceInfo.wageAmount.focus();
document.preferenceInfo.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}

  if (!document.preferenceInfo.wageType[0].checked && !document.preferenceInfo.wageType[1].checked)
    {  alert("Please indicate if your desired income is Hourly of Yearly."); 
	document.preferenceInfo.wageType[0].focus();
document.preferenceInfo.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}
		
  if (!document.preferenceInfo.shift[0].checked && !document.preferenceInfo.shift[1].checked && !document.preferenceInfo.shift[2].checked && !document.preferenceInfo.shift[3].checked && !document.preferenceInfo.shift[4].checked && !document.preferenceInfo.shift[5].checked)
    {  alert("Please check one or more shifts that you are willing to work."); 
	document.preferenceInfo.shift[0].focus();
document.preferenceInfo.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
		
  if (document.preferenceInfo.qRelocate[1].checked && document.preferenceInfo.relocateAreaOne.value != '')
    {  alert("You selected at least one relocation area but did not indicate if you would relocate by checking YES.\n Select (none) from the relocation area list(s) if this was unintended."); 
	document.preferenceInfo.qRelocate[0].focus();
document.preferenceInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}	
		
  if (document.preferenceInfo.qRelocate[0].checked && document.preferenceInfo.relocateAreaOne.value == '' && document.preferenceInfo.relocateAreaTwo.value == '' && document.preferenceInfo.relocateAreaThree.value == '')
    {  alert("You indicated a willingness to relocate but did not choose at least one preferred relocation area:"); 
	document.preferenceInfo.relocateAreaOne.focus();
document.preferenceInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}			
		
		
  if (document.preferenceInfo.commuteDist.value == '')
    {  alert("Please select the maximum distance that you would be willing to commute regularly"); 
	document.preferenceInfo.commuteDist.focus();
document.preferenceInfo.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}					

  if (document.preferenceInfo.workLegalStatus.value == '')
    {  alert("Please select your legal work status in the United States"); 
	document.preferenceInfo.workLegalStatus.focus();
document.preferenceInfo.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}		
		
  if (!document.preferenceInfo.workLegalProof[0].checked && !document.preferenceInfo.workLegalProof[1].checked)
    {  alert("Please check whether or not you have proof of US citizenship.\nSome common types of proof are:\n\n-Social Security Card\n-Drivers License\n-Passports\n-Military ID\n-State-issued ID cards."); 
	document.preferenceInfo.workLegalProof[0].focus();
document.preferenceInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}							
		
  if (isGood != false)
    { document.preferenceInfo.submit();  }
}		
</SCRIPT>


</HEAD>

<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
<FORM NAME="preferenceInfo" METHOD="post" ACTION="newAcct6.asp?who=2">	

<TABLE WIDTH=100% BORDER=0 CELLPADDING=0 CELLSPACING=0 BGCOLOR="#FFFFFF">				
	<TR>
		<TD COLSPAN="2" ALIGN="center">
			<TABLE WIDTH="75%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
				<TR>
				<TD BGCOLOR="#003366" ALIGN="left" HEIGHT="35"><IMG SRC="/lweb/img/tab_top_left.gif" ALT="" WIDTH="17" HEIGHT="35" BORDER="0"><IMG SRC="/lweb/img/tab_preferences.gif" ALT="General Preferences" WIDTH="166" HEIGHT="31" BORDER="0" ALIGN="absmiddle"></TD>
<TD BGCOLOR="#003366" HEIGHT="35" ALIGN="right" NOWRAP><FONT COLOR="#FFFFFF">Creating Your New Account - STEP <STRONG>3</STRONG> of 3</FONT><IMG SRC="/lweb/img/tab_top_right.gif" ALT="" WIDTH="17" HEIGHT="35" BORDER="0" ALIGN="absmiddle"></TD>
				</TR>
				<TR>
				<TD COLSPAN="2">
						<TABLE WIDTH="100%" BORDER="0" CELLSPACING="10" CELLPADDING="0" style="border: 1px solid #D1DCEB;">
						<TR>
						<TD COLSPAN="2"><img src="/lweb/img/req_info.gif" alt="" width="87" height="16" border="0"></TD>
						</TR>
						<TR><TD VALIGN="top" WIDTH="50%"><IMG SRC="/lweb/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> Are you willing to relocate?
<br>
<div align="center">
Yes <INPUT NAME="qRelocate" TYPE="radio" style="background:#FFFFFF; border:0; color:#FFFFFF" value="Yes" TABINDEX="1">&nbsp;
No <INPUT NAME="qRelocate" TYPE="radio" style="background:#FFFFFF; border:0; color:#FFFFFF" CHECKED value="No">

</div>
<br>
<IMG SRC="/lweb/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> Your desired work schedule:
<br>
<div align="center">
<table width="90%" border="0">
	<tr>
		<td><INPUT NAME="schedule" TYPE="checkbox" style="background:#FFFFFF; border:0; color:#FFFFFF" value="FT" TABINDEX="2"></td>
		<td>Full-time</td>						
		<td><INPUT NAME="schedule" TYPE="checkbox" style="background:#FFFFFF; border:0; color:#FFFFFF" value="PT"></td>
<td>Part-time</td>
	</tr>
	<tr>
		<td><INPUT NAME="schedule" TYPE="checkbox" style="background:#FFFFFF; border:0; color:#FFFFFF" value="SE"></td>
		<td>Seasonal</td>		
		<td><INPUT NAME="schedule" TYPE="checkbox" style="background:#FFFFFF; border:0; color:#FFFFFF" value="TP"></td>
<td>Temporary</td>
	</tr>	
</table>
</div>
							</TD>
							<TD VALIGN="top" WIDTH="50%">
<IMG SRC="/lweb/img/spacer.gif" WIDTH="23" HEIGHT="1" BORDER="0">
Top 3 relocation areas:
<br>
<IMG SRC="/lweb/img/spacer.gif" WIDTH="32" HEIGHT="1" BORDER="0">
1- <SELECT NAME="relocateAreaOne" TABINDEX="-1">
<OPTION VALUE="" SELECTED>-- Select 1st Area --</OPTION>
<OPTION VALUE="">(none)</OPTION>
<%	
	Do While NOT rsLocation.EOF
	response.Write "<OPTION VALUE='" & rsLocation("locCode") & _
					   "'>" & rsLocation("locCode") & " - " & rsLocation("locName") & "</option>"	
		rsLocation.MoveNext
				
	Loop		
%>
</SELECT>
<p></p>
<IMG SRC="/lweb/img/spacer.gif" WIDTH="32" HEIGHT="1" BORDER="0">
2- <SELECT NAME="relocateAreaTwo" TABINDEX="-1">
<OPTION VALUE="" SELECTED>-- Select 2nd Area --</OPTION> 
<OPTION VALUE="">(none)</OPTION>
<%	
	Do While NOT rsLocation2.EOF
	response.Write "<OPTION VALUE='" & rsLocation2("locCode") & _
					   "'>" & rsLocation2("locCode") & " - " & rsLocation2("locName") & "</option>"	
		rsLocation2.MoveNext
				
	Loop		
%>
</SELECT>
<p></p>
<IMG SRC="/lweb/img/spacer.gif" WIDTH="32" HEIGHT="1" BORDER="0">
3- <SELECT NAME="relocateAreaThree" TABINDEX="-1">
<OPTION VALUE="" SELECTED>-- Select 3rd Area --</OPTION>
<OPTION VALUE="">(none)</OPTION>
<%	
	Do While NOT rsLocation3.EOF
	response.Write "<OPTION VALUE='" & rsLocation3("locCode") & _
					   "'>" & rsLocation3("locCode") & " - " & rsLocation3("locName") & "</option>"	
		rsLocation3.MoveNext
				
	Loop		
%>
</SELECT>
							</TD>
						</TR>						
						
						<TR><TD VALIGN="top" WIDTH="50%"><IMG SRC="/lweb/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> Your desired income range:
<br>
<IMG SRC="/lweb/img/spacer.gif" WIDTH="15" HEIGHT="1" BORDER="0">$ <INPUT NAME="wageAmount" TYPE="text" MAXLENGTH="9" SIZE="6"  TABINDEX=3> <INPUT NAME="wageType" TYPE="radio" style="background:#FFFFFF; border:0; color:#FFFFFF" value="Hourly">Hourly<INPUT NAME="wageType" TYPE="radio" style="background:#FFFFFF; border:0; color:#FFFFFF" value="Salaried">Yearly
							</TD>
							<TD VALIGN="top" WIDTH="50%"><IMG SRC="/lweb/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
<IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> How far would you commute?
<br>
<IMG SRC="/lweb/img/spacer.gif" WIDTH="52" HEIGHT="1" BORDER="0"><SELECT NAME="commuteDist">
							<option value="">-- SELECT ONE --</OPTION>	
							<option value="1">1 mile</OPTION>													
							<option value="5">5 miles</OPTION>
							<option value="10">10 miles</OPTION>
							<option value="25">25 miles</OPTION>
							<option value="50">50 miles</OPTION>
							<option value="100">100 miles</OPTION>
							</SELECT>
							</TD>
						</TR>
						<TR><TD VALIGN="top" WIDTH="50%"><IMG SRC="/lweb/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> What shifts can you work?
<br>
<div align="center"><table width="90%" border="0">
	<tr>
		<td><INPUT NAME="shift" TYPE="checkbox" style="background:#FFFFFF; border:0; color:#FFFFFF" value="1" TABINDEX="5"></td>
		<td>1st shift</td>						
		<td><INPUT NAME="shift" TYPE="checkbox" style="background:#FFFFFF; border:0; color:#FFFFFF" value="2"></td>
<td>2nd shift</td>
	</tr>
	<tr>
		<td><INPUT NAME="shift" TYPE="checkbox" style="background:#FFFFFF; border:0; color:#FFFFFF" value="3"></td>
		<td>3rd shift</td>						
		<td><INPUT NAME="shift" TYPE="checkbox" style="background:#FFFFFF; border:0; color:#FFFFFF" value="R"></td>
<td>Rotating</td>
	</tr>
	<tr>
		<td><INPUT NAME="shift" TYPE="checkbox" style="background:#FFFFFF; border:0; color:#FFFFFF" value="W"></td>
		<td>Weekends</td>						
		<td><INPUT NAME="shift" TYPE="checkbox" style="background:#FFFFFF; border:0; color:#FFFFFF" value="A"></td>
<td>After school</td>
	</tr>		
</table>
</div>
							</TD>
							<TD VALIGN="top" WIDTH="50%"><br><IMG SRC="/lweb/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> U.S. Work Authorization:<BR><SELECT NAME="workLegalStatus" TABINDEX="6">
						<OPTION VALUE="">( Please select your legal work status )</OPTION>
						<OPTION VALUE="Yes">I am a citizen of the United States</OPTION>
						<OPTION VALUE="Any">I have authorization to work for any employer</OPTION>
						<OPTION VALUE="One">I have authorization to work for my current employer</OPTION>
						<OPTION VALUE="No">I am seeking authorization		</OPTION>											
					</SELECT>
<p></p>			  
<IMG SRC="/lweb/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> Do you have proof of Authorization?
<BR>
<div align="center">
Yes <INPUT NAME="workLegalProof" TYPE="radio" style="background:#FFFFFF; border:0; color:#FFFFFF" value="Yes" TABINDEX="7"> &nbsp; No<INPUT NAME="workLegalProof" TYPE="radio" style="background:#FFFFFF; border:0; color:#FFFFFF" value="No">
<br>
<br><INPUT TYPE="button" NAME="submit_btn" style="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" VALUE="Continue &gt;&gt;&gt;" TABINDEX=13 onClick="checkPreferences()" TABINDEX="11"></div>							
							</TD>
						</TR>
									
						</TABLE>
					</TD>
					</TR>			
			</TABLE>
		</TD>
		</TR>		
</TABLE>
</form>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->


