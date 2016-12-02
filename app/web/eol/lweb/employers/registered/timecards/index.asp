<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
	<% if session("employerAuth") <> "true" then response.redirect("/lweb/index2.asp") end if%>
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
		
		response.cookies("timecards")("time") = now
	 %>
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<title>Email Time Cards</title>

<SCRIPT language="javascript">
function goTimecards()
{
	var isGood = true
	var sendtime = ""
	document.sendtimecards.submit_btn.disabled = true;
	
if (document.sendtimecards.timecardoption[0].checked)
	{	sendtime = document.sendtimecards.timecardoption[0].value;
	}
	else if (document.sendtimecards.timecardoption[1].checked)
		{	sendtime = document.sendtimecards.timecardoption[1].value;
		}
		else
		{	isGood = false;
			alert("Please select how you want to submit yoru timecard.")
		document.sendtimecards.timecardoption[0].focus();
		document.sendtimecards.submit_btn.disabled = false;
			return false;
		}
	
  if (document.sendtimecards.officeSelector.value == '')
    {  alert("Please select your home office before proceeding."); 
	document.sendtimecards.officeSelector.focus();
	document.sendtimecards.submit_btn.disabled = false;		
			isGood = false; 
			return false
  	}	
  
  var mailto
  mailto = document.sendtimecards.officeSelector.value
  alert(document.sendtimecards.officeSelector.value)
  alert(mailto)
  if (document.sendtimecards.officeSelector.value != '')
  	{	alert("setting cookie")
  		document.cookie = ("emailTo" = mailto);
//  		alert(getCookie('emailTo'));
  		alert("here we go");
  	}
  
  if (isGood != false)
  	{	
  		if (sendtime == 'attach')
    		{	document.sendtimecards.action = "/employers/registered/timecards/attach/index.asp";
    			document.sendtimecards.submit();
    		}
		else if (sendtime == 'form')
  			{	document.sendtimecards.action = "/employers/registered/timecards/form/index.asp";
  				document.sendtimecards.submit();
  			}
  	}
}

</SCRIPT>

</HEAD>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/advertise/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
<TABLE width="90%" BORDER="0" CELLPADDING="2" CELLSPACING="2" BGCOLOR="#ffffff">
	<TR>
		<TD>
			<TABLE width="100%" border="0" cellpadding="3" cellspacing="3" style="border: 1px solid #b22222;">
				<TR>
					<TD>
						<FORM name="sendtimecards" method="POST">
							<table border="0" width="100%" cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<font color="#b22222"><strong>Step 1:</strong></font>
									</td>
									<td>
										<em><strong><%=session("companyName")%> choose how you want to send your 
										time card(s)...</strong></em>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>
										<em><strong>
											<input type="radio" value="attach" name="timecardoption">
											&nbsp; send as attachment<br>
											<input type="radio" value="form" name="timecardoption">
											&nbsp;fill out the form
										</strong></em><br><br>
									</td>
								</tr>
								<tr>
									<td>
							<font color="#b22222"><strong>Step 2:</strong></font></td>
									<td>
							<em><strong>Select your home office below and click continue.</strong></em>
									</td>
								</tr>
							</table>
							<br><font color="#b22222"><strong>To send the time card now, select the home office from the following list:</strong></font> 
							<SELECT name="officeSelector" size="1">
								<option value="">Select your Home Office:</option>
								<option value="boise@personnel.com">Boise</option>
								<option value="burley@personnel.com">Burley</option>	
								<option value="nampa@personnel.com">Caldwell</option>
								<option value="burley@personnel.com">Jerome</option>	
								<option value="nampa@personnel.com">Nampa</option>
								<option value="rupert@personnel.com">Rupert</option>	
								<option value="twin@personnel.com">Twin Falls</option>
								<option value="twin@personnel.com">- Out of State -</option>
							</SELECT>
							<br><font color="#b22222"><strong>When finished with your selection</strong></font> <INPUT TYPE="button" style="background:#b22222; border:1 #000000 solid; font-size:9px; font-weight:bold; color:#FFFFFF" NAME="submit_btn" VALUE="click here to continue..." onClick="goTimecards()">.
						</form>
					</TD>
				</tr>
			</table>
		</td>
	</tr>
</TABLE>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/advertise/inc/navi_btm.asp' -->
</BODY>
</HTML>