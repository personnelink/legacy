<!-- #INCLUDE VIRTUAL='/inc/dbConn.asp' -->
<%
dim sqlLocation
dim rsLocation,rsLocation2,rsLocation3,rsLocation4,rsLocation5,rsLocation6,rsLocation7

Set rsEmployerData = Server.CreateObject("ADODB.Recordset")
rsEmployerData.Open "SELECT * FROM tbl_employers WHERE companyUserName ='" & session("companyUserName") & "'", Connect, 3, 3

sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation = Connect.Execute(sqlLocation)
set rsLocation2 = Connect.Execute(sqlLocation)
set rsLocation3 = Connect.Execute(sqlLocation)
set rsLocation4 = Connect.Execute(sqlLocation)
set rsLocation5 = Connect.Execute(sqlLocation)
set rsLocation6 = Connect.Execute(sqlLocation)
set rsLocation7 = Connect.Execute(sqlLocation)

dim currenttime	:	currenttime = now

response.cookies("creditapp")("time") = currenttime

%>
<HTML>
<HEAD>
<meta http-equiv="Content-Language" content="en-us">
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<TITLE>Credit Application - Personnel Plus, Inc. - Idaho's Total Staffing Solution</TITLE>
</HEAD>
	<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/advertise/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 --> 
<!-- #INCLUDE VIRTUAL='/inc/creditcheck.asp' -->
	<form name="creditApp" method="post" action="/company/emailcredit.asp">
		<table border="0" cellspacing="0" cellpadding="0" width="775">
			<tr>
				<td valign="top" align="left" colspan="6" height="36">
				<p align="center"><strong>
					<font size="6">Credit Application</font></strong></td>
			</tr>
			<tr>
				<td valign="top" align="left" colspan="6" height="19">
					<p align="center">
						***********************************************************************************************</td>
			</tr>
			<tr>
				<td valign="top" align="left" colspan="6" height="19"><b>Billing Information:</b></td>
			</tr>
			<tr>
				<td valign="top" align="right" width="181">Name: </td>
				<td valign="top" align="left" width="239">
					<input type="text" name="billname" size="30" tabindex="1"></td>
				<td valign="top" align="right" width="96">Phone # </td>
				<td valign="top" align="left" width="137">
					<input type="text" name="billphone" size="15" tabindex="6"></td>
				<td valign="top" align="right" width="27">&nbsp;</td>
				<td valign="top" align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="181">P. O. Box or Street Address: </td>
				<td align="left" width="239">
					<input type="text" name="billadd1" size="30" tabindex="2"></td>
				<td valign="top" align="right" width="96">Fax # </td>
				<td valign="top" align="left" width="137">
					<input type="text" name="billfax" size="15" tabindex="7"></td>
				<td valign="top" align="right" width="27">&nbsp;</td>
				<td valign="top" align="left" height="19" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="181">&nbsp;<font size="1">(continued)</font></td>
				<td valign="top" align="left" width="239">
					<input type="text" name="billadd2" size="30" tabindex="3"></td>
				<td align="right" width="96">&nbsp;</td>
				<td align="left" width="137">&nbsp;</td>
				<td align="right" width="27">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="181">City: </td>
				<td valign="top" align="left" width="239">
					<input type="text" name="billcity" size="30" tabindex="4"></td>
				<td valign="top" align="right" width="96">State: </td>
				<td valign="top" align="left" width="137">
					<SELECT NAME="billstate" tabindex="8">
						<option value="">- Select a State -</option>
						<% do while not rsLocation.eof %>
							<OPTION	VALUE="<%= rsLocation("locCode")%>"		
							<% if rsLocation("locCode") = rsEmployerData("state") then %>SELECTED<% End if %>> <%=rsLocation("locName") %></OPTION>		
							<% rsLocation.MoveNext %>
						<% loop %>	
					</SELECT></td>
				<td valign="top" align="right" width="27">Zip: </td>
				<td valign="top" align="left" height="22" width="95">
					<input type="text" name="billzip" size="10" maxlength="15" tabindex="9"></td>
			</tr>
			<tr>
				<td valign="top" align="right" width="181">Accounts Payable Contact:</td>
				<td valign="top" align="left" width="239">
					<input type="text" name="billpayablecont" size="30" tabindex="5"></td>
				<td valign="top" align="right" width="96">Contact Email: </td>
				<td valign="top" align="left" colspan="3" height="38">
					<input type="text" name="billcontemail" size="30" tabindex="10"></td>
			</tr>
			<tr>
				<td valign="top" align="right" colspan="6" height="19">
					<p align="center">***********************************************************************************************</td>
			</tr>
			<tr>
				<td valign="top" align="right" colspan="6" height="19">
					<p align="left"><b>Physical Address:</b></td>
			</tr>
			<tr>
				<td valign="top" align="right" width="181">Name: </td>
				<td valign="top" align="left" width="239">
					<input type="text" name="physname" size="30" tabindex="11"></td>
				<td valign="top" align="right" width="96">Phone # </td>
				<td valign="top" align="left" width="137">
					<input type="text" name="physphone" size="15" tabindex="16"></td>
				<td valign="top" align="right" width="27">&nbsp;</td>
				<td valign="top" align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="181">Address: </td>
				<td valign="top" align="left" width="239">
					<input type="text" name="physadd1" size="30" tabindex="12"></td>
				<td valign="top" align="right" width="96">Fax # </td>
				<td valign="top" align="left" width="137">
					<input type="text" name="physfax" size="15" tabindex="17"></td>
				<td valign="top" align="right" width="27">&nbsp;</td>
				<td valign="top" align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="181">&nbsp;<font size="1">(continued)</font></td>
				<td valign="top" align="left" width="239">
					<input type="text" name="physadd2" size="30" tabindex="13"></td>
				<td align="right" width="96">Hours: </td>
				<td align="left" width="137">
					<input type="text" name="physhours" size="15" maxlength="15" tabindex="18"></td>
				<td align="right" width="27">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="181">City: </td>
				<td valign="top" align="left" width="239">
					<input type="text" name="physcity" size="30" tabindex="14"></td>
				<td valign="top" align="right" width="96">State: </td>
				<td valign="top" align="left" width="137">
					<SELECT NAME="physstate" tabindex="19">
						<option value="">- Select a State -</option>
						<% do while not rsLocation2.eof %>
							<OPTION	VALUE="<%= rsLocation2("locCode")%>"		
							<% if rsLocation2("locCode") = rsEmployerData("state") then %>SELECTED<% End if %>> <%=rsLocation2("locName") %></OPTION>		
							<% rsLocation2.MoveNext %>
						<% loop %>	
					</SELECT></td>
				<td valign="top" align="right" width="27">Zip: </td>
				<td valign="top" align="left" height="22" width="95">
					<input type="text" name="physzip" size="10" maxlength="15" tabindex="20"></td>
			</tr>
			<tr>
				<td valign="top" align="right" width="181">County: </td>
				<td align="left" width="239">
					<input type="text" name="physcounty" size="30" tabindex="15"></td>
				<td valign="top" align="right" width="96">Contact Email: </td>
				<td valign="top" align="left" colspan="3">
					<input type="text" name="physcontemail" size="30" tabindex="21"></td>
			</tr>
			<tr>
				<td valign="top" align="right" colspan="6" height="19">
					<p align="center">***********************************************************************************************</td>
			</tr>
		</table>
		<table border="0" cellspacing="0" cellpadding="0" width="775">
			<tr>
				<td valign="top" align="right" colspan="5" height="19">
					<p align="left"><b>Company Information:</b></td>
			</tr>
			<tr>
				<td align="right" width="114">
					<p align="left">
						<input type="radio" value="individual" name="coInfo" tabindex="22">Individual</td>
				<td valign="top" align="right" width="98">Buyers Name:</td>
				<td valign="top" align="left" width="224">
					<input name="cobuyername" size="30" style="float: left" tabindex="25"></td>
				<td valign="top" width="173">
					<p align="right">Length of time in business: </td>
				<td align="right" height="11" width="171">
					<p align="left">
						<select name="timebusiness" tabindex="26">
							<option value="">- Select How Long -</option>
							<option value="<1">Less than 1 Year</option>
							<option value="1-3">1 - 3 Years</option>
							<option value="4-6">4 - 6 Years</option>
							<option value=">7">More than 7 Years</option>
						</select>
				</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="114">
					<p align="left">
					<input type="radio" value="partnership" name="coInfo" tabindex="23" >Partnership</td>
				<td valign="top" align="right" colspan="2">
					<p align="right">Approximate Monthly Volume: </td>
				<td valign="top" colspan="2">
					<input type="text" name="comonthlyvolume" size="15" maxlength="15" tabindex="27"></td>
			</tr>
			<tr>
				<td valign="top" align="right" width="114">
					<p align="left">
					<input type="radio" value="corporation" name="coInfo" tabindex="24">Corporation</td>
				<td valign="top" align="right" colspan="2">
					<p align="right">Type of Business <font size="1">(<i>Attorney, 
						Accounting, Manufacturing, etc.</i>): </font></td>
				<td valign="top" align="left" colspan="2" rowspan="2" width="354">
					<TEXTAREA WRAP="soft" COLS="28" ROWS="2" NAME="typebusiness" TABINDEX="28"></TEXTAREA></td>
			</tr>
			<tr>
				<td valign="top" align="right" colspan="3">
					<p align="left">Purchase Order Required?&nbsp;<input type="radio" value="Yes" name="po" tabindex="29">Yes&nbsp;<input type="radio" value="No" name="po" tabindex="30">No
				</td>
			</tr>
			<tr>
				<td valign="top" align="right" colspan="5" height="19">
					<p align="center">Tax ID #:
					<input type="text" name="taxID" size="15" tabindex="31" onfocus="showIDmsg()"></td>
			</tr>
			<tr>
				<td valign="top" align="right" colspan="5" height="19">
					<p align="center">
					<input type="checkbox" name="issubsidiary" value="Yes" tabindex="32"> 
					Check if 
							Subsidiary, and fill out name of parent company's office 
					including city state and zip code:</td>
			</tr>
			<tr>
				<td valign="top" align="right" colspan="5" height="165">
					<p align="center">
					<TEXTAREA WRAP="soft" COLS="50" ROWS="10" NAME="subsidiary" TABINDEX="33"></TEXTAREA></td>
			</tr>
			<tr>
				<td valign="top" align="right" colspan="5" height="19">
					<p align="center">***********************************************************************************************</td>
			</tr>
		</table>
		<table border="0" cellspacing="0" cellpadding="0" width="775">
			<tr>
				<td valign="top" align="right" colspan="6" height="19">
					<p align="left"><b>Key Principals or Partners:</b></td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Name: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keynamea" size="30" tabindex="34"></td>
				<td valign="top" align="right" width="133">Title:</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keytitlea" size="15" tabindex="39"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Residence Address:</td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyadd1a" size="30" tabindex="35"></td>
				<td valign="top" align="right" width="133">Residence Phone #</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keyphonea" size="15" tabindex="40"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120"><font size="1">(continued)</font></td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyadd2a" size="30" tabindex="36"></td>
				<td valign="top" align="right" width="133">Social Security #</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keysocseca" size="15" tabindex="41" onfocus="showIDmsg()"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">City: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keycitya" size="30" tabindex="37"></td>
				<td valign="top" align="right" width="133">State:</td>
				<td valign="top" align="left" width="131">
					<SELECT NAME="keystatea" tabindex="42">
						<option value="">- Select a State -</option>
						<% do while not rsLocation3.eof %>
							<OPTION	VALUE="<%= rsLocation3("locCode")%>"		
							<% if rsLocation3("locCode") = rsEmployerData("state") then %>SELECTED<% End if %>> <%=rsLocation3("locName") %></OPTION>		
							<% rsLocation3.MoveNext %>
						<% loop %>	
					</SELECT>
				</td>
				<td align="right" width="28">Zip: </td>
				<td align="left" height="22" width="95">
					<input type="text" name="keyzipa" size="10" maxlength="15" tabindex="43"></td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">% of Ownership: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyownershipa" size="30" tabindex="38"></td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" align="left" width="268">
					&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="19" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" align="left" width="268">
					&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="19" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Name: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keynameb" size="30" tabindex="44"></td>
				<td valign="top" align="right" width="133">Title:</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keytitleb" size="15" tabindex="49"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Residence Address:</td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyadd1b" size="30" tabindex="45"></td>
				<td valign="top" align="right" width="133">Residence Phone #</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keyphoneb" size="15" tabindex="50"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120"><font size="1">(continued)</font></td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyadd2b" size="30" tabindex="46"></td>
				<td valign="top" align="right" width="133">Social Security #</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keysocsecb" size="15" tabindex="51"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">City: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keycityb" size="30" tabindex="47"></td>
				<td valign="top" align="right" width="133">State:</td>
				<td valign="top" align="left" width="131">
					<SELECT NAME="keystateb" tabindex="52">
						<option value="">- Select a State -</option>
						<% do while not rsLocation4.eof %>
							<OPTION	VALUE="<%= rsLocation4("locCode")%>"		
							<% if rsLocation4("locCode") = rsEmployerData("state") then %>SELECTED<% End if %>> <%=rsLocation4("locName") %></OPTION>		
							<% rsLocation4.MoveNext %>
						<% loop %>	
					</SELECT>
				</td>
				<td align="right" width="28">Zip: </td>
				<td align="left" height="22" width="95">
					<input type="text" name="keyzipb" size="10" maxlength="15" tabindex="53"></td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">% of Ownership: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyownershipb" size="30" tabindex="48"></td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" align="left" width="268">
					&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="19" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Name: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keynamec" size="30" tabindex="54"></td>
				<td valign="top" align="right" width="133">Title:</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keytitlec" size="15" tabindex="59"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Residence Address:</td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyadd1c" size="30" tabindex="55"></td>
				<td valign="top" align="right" width="133">Residence Phone #</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keyphonec" size="15" tabindex="60"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120"><font size="1">(continued)</font></td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyadd2c" size="30" tabindex="56"></td>
				<td valign="top" align="right" width="133">Social Security #</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keysocsecc" size="15" tabindex="61"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">City: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keycityc" size="30" tabindex="57"></td>
				<td valign="top" align="right" width="133">State:</td>
				<td valign="top" align="left" width="131">
					<SELECT NAME="keystatec" tabindex="62">
						<option value="">- Select a State -</option>
						<% do while not rsLocation5.eof %>
							<OPTION	VALUE="<%= rsLocation5("locCode")%>"		
							<% if rsLocation5("locCode") = rsEmployerData("state") then %>SELECTED<% End if %>> <%=rsLocation5("locName") %></OPTION>		
							<% rsLocation5.MoveNext %>
						<% loop %>	
					</SELECT>
				</td>
				<td align="right" width="28">Zip: </td>
				<td align="left" height="22" width="95">
					<input type="text" name="keyzipc" size="10" maxlength="15" tabindex="63"></td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">% of Ownership: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyownershipc" size="30" tabindex="58"></td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" align="left" width="268">
					&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="19" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Name: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keynamed" size="30" tabindex="64"></td>
				<td valign="top" align="right" width="133">Title:</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keytitled" size="15" tabindex="69"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Residence Address:</td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyadd1d" size="30" tabindex="65"></td>
				<td valign="top" align="right" width="133">Residence Phone #</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keyphoned" size="15" tabindex="70"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120"><font size="1">(continued)</font></td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyadd2d" size="30" tabindex="66"></td>
				<td valign="top" align="right" width="133">Social Security #</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keysocsecd" size="15" tabindex="71"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">City: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keycityd" size="30" tabindex="67"></td>
				<td valign="top" align="right" width="133">State:</td>
				<td valign="top" align="left" width="131">
					<SELECT NAME="keystated" tabindex="72">
						<option value="">- Select a State -</option>
						<% do while not rsLocation6.eof %>
							<OPTION	VALUE="<%= rsLocation6("locCode")%>"		
							<% if rsLocation6("locCode") = rsEmployerData("state") then %>SELECTED<% End if %>> <%=rsLocation6("locName") %></OPTION>		
							<% rsLocation6.MoveNext %>
						<% loop %>	
					</SELECT>
				</td>
				<td align="right" width="28">Zip: </td>
				<td align="left" height="22" width="95">
					<input type="text" name="keyzipd" size="10" maxlength="15" tabindex="73"></td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">% of Ownership: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyownershipd" size="30" tabindex="68"></td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" align="left" width="268">
					&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="19" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Name: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keynamee" size="30" tabindex="74"></td>
				<td valign="top" align="right" width="133">Title:</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keytitlee" size="15" tabindex="79"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Residence Address:</td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyadd1e" size="30" tabindex="75"></td>
				<td valign="top" align="right" width="133">Residence Phone #</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keyphonee" size="15" tabindex="80"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120"><font size="1">(continued)</font></td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyadd2e" size="30" tabindex="76"></td>
				<td valign="top" align="right" width="133">Social Security #</td>
				<td valign="top" align="left" width="131">
					<input type="text" name="keysocsece" size="15" tabindex="81"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">City: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keycitye" size="30" tabindex="77"></td>
				<td valign="top" align="right" width="133">State:</td>
				<td valign="top" align="left" width="131">
					<SELECT NAME="keystatee" tabindex="82">
						<option value="">- Select a State -</option>
						<% do while not rsLocation7.eof %>
							<OPTION	VALUE="<%= rsLocation7("locCode")%>"		
							<% if rsLocation7("locCode") = rsEmployerData("state") then %>SELECTED<% End if %>> <%=rsLocation7("locName") %></OPTION>		
							<% rsLocation7.MoveNext %>
						<% loop %>	
					</SELECT>
				</td>
				<td align="right" width="28">Zip: </td>
				<td align="left" height="22" width="95">
					<input type="text" name="keyzipe" size="10" maxlength="15" tabindex="83"></td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">% of Ownership: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="keyownershipe" size="30" tabindex="78"></td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" colspan="6" height="19">
				<p align="center">***********************************************************************************************</td>
			</tr>
			<tr>
				<td valign="top" align="left" colspan="6" height="19"><b>Trade 
					References:&nbsp; <font size="1">(3 required, if you don't 
				have three, then please contact your local office for more info)</font></b></td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Name: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="tradename" size="30" tabindex="84"></td>
				<td valign="top" align="right" width="133">Contact: </td>
				<td valign="top" align="left" width="131">
					<input type="text" name="tradecontact" size="15" tabindex="86"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Address: </td>
				<td valign="top" align="left" rowspan="2" width="268">
					<TEXTAREA WRAP="soft" COLS="25" ROWS="2" NAME="tradeaddress" TABINDEX="85"></TEXTAREA></td>
				<td valign="top" align="right" width="133">Phone # </td>
				<td valign="top" align="left" width="131">
					<input type="text" name="tradephone" size="15" tabindex="87"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="19" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" align="left" width="268">
					&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="19" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Name: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="tradename0" size="30" tabindex="88"></td>
				<td valign="top" align="right" width="133">Contact: </td>
				<td valign="top" align="left" width="131">
					<input type="text" name="tradecontact0" size="15" tabindex="90"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Address: </td>
				<td valign="top" align="left" rowspan="2" width="268">
					<TEXTAREA WRAP="soft" COLS="25" ROWS="2" NAME="tradeaddress0" TABINDEX="89"></TEXTAREA></td>
				<td valign="top" align="right" width="133">Phone # </td>
				<td valign="top" align="left" width="131">
					<input type="text" name="tradephone0" size="15" tabindex="91"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="19" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" align="left" width="268">
					&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="19" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Name: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="tradename1" size="30" tabindex="92"></td>
				<td valign="top" align="right" width="133">Contact: </td>
				<td valign="top" align="left" width="131">
					<input type="text" name="tradecontact1" size="15" tabindex="94"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Address: </td>
				<td valign="top" align="left" rowspan="2" width="268">
					<TEXTAREA WRAP="soft" COLS="25" ROWS="2" NAME="tradeaddress1" TABINDEX="93"></TEXTAREA></td>
				<td valign="top" align="right" width="133">Phone # </td>
				<td valign="top" align="left" width="131">
					<input type="text" name="tradephone1" size="15" tabindex="95"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="19" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" align="left" width="268">
					&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="19" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Name: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="tradename2" size="30" tabindex="96"></td>
				<td valign="top" align="right" width="133">Contact: </td>
				<td valign="top" align="left" width="131">
					<input type="text" name="tradecontact2" size="15" tabindex="98"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Address: </td>
				<td valign="top" align="left" rowspan="2" width="268">
					<TEXTAREA WRAP="soft" COLS="25" ROWS="2" NAME="tradeaddress2" TABINDEX="97"></TEXTAREA></td>
				<td valign="top" align="right" width="133">Phone # </td>
				<td valign="top" align="left" width="131">
					<input type="text" name="tradephone2" size="15" tabindex="99"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="22" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="20" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" align="left" width="268">
					&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="20" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Name: </td>
				<td valign="top" align="left" width="268">
					<input type="text" name="tradename3" size="30" tabindex="100"></td>
				<td valign="top" align="right" width="133">Contact: </td>
				<td valign="top" align="left" width="131">
					<input type="text" name="tradecontact3" size="15" tabindex="102"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="23" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">Address: </td>
				<td valign="top" align="left" rowspan="2" width="268">
					<TEXTAREA WRAP="soft" COLS="25" ROWS="2" NAME="tradeaddress3" TABINDEX="101"></TEXTAREA></td>
				<td valign="top" align="right" width="133">Phone # </td>
				<td valign="top" align="left" width="131">
					<input type="text" name="tradephone3" size="15" tabindex="103"></td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="23" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" width="120">&nbsp;</td>
				<td valign="top" width="133">&nbsp;</td>
				<td valign="top" align="left" width="131">&nbsp;</td>
				<td align="right" width="28">&nbsp;</td>
				<td align="left" height="20" width="95">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" colspan="6" height="20">
				<p align="center">***********************************************************************************************</td>
			</tr>
		</table>
		<table border="0" cellspacing="0" cellpadding="0" width="775">
			<tr>
				<td valign="top" align="right" colspan="3" height="13">
				<p align="left"><font size="1"><b>Terms of Sale and Agreement:</b></font></td>
			</tr>
			<tr>
				<td valign="top" align="right" colspan="3" height="85">
					<p align="left"><font size="1">Applicant(s) agrees to pay all 
						monies within 30 days from date of sale.&nbsp; A finance charge 
						of 1 1/2% per month, at an annual rate of 18%, will be charged 
						on all delinquent accounts.  (Minimum service charge is 
						$1.00)&nbsp; Should applicant default on terms and legal action 
						become necessary, the Applicant(s) agrees to pay all collection 
						expenses including administrative costs, court costs and 
						attorney's fees.<br><br>Applicant(s) will inform Personnel Plus, Inc. 
						(in writing) of any change in company name, address or phone 
						number as soon as such<br>changes occur.  The information given 
						is warranted to be true and Applicant(s) authorize the release 
						of all pertinent information necessary<br>for processing the 
						Applicant's request for credit, including bank records and other 
						financial data.</font>
				</td>
			</tr>

			
			
			<tr>
				<td valign="top" align="right">&nbsp;</td>
				<td valign="top">&nbsp;</td>
				<td valign="top" align="left" height="20">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="center">By</td>
				<td valign="top">
					<p align="center">Title</td>
				<td valign="top" align="center" height="20">Date</td>
			</tr>
			<tr>
				<td valign="top" align="right">&nbsp;</td>
				<td valign="top">&nbsp;</td>
				<td valign="top" align="left" height="20">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right">
					<p align="center">
						<input type="text" name="signname" size="52" tabindex="104" onfocus="showSignmsg()"></td>
				<td valign="top" align="center">
						<input type="text" name="signtitle" size="23" tabindex="105"></td>
				<td valign="top" align="left" height="23">
					<p align="center"><%=request.cookies("creditapp")("time")%></td>
			</tr>
			<tr>
				<td valign="top" align="right">
					<p align="center">__________________________________________</td>
				<td valign="top">
					<p align="center">___________________</td>
				<td valign="top" align="left" height="20">
					<p align="center">___________________</td>
			</tr>
			<tr>
				<td valign="top" align="right" colspan="3">
					<p align="center"><font size="1">By filling out the above 
						box with your first name, middle name, last name, and title, 
						you agree to above terms and are legally electronically 
						singing this document.</font>
				</td>
			</tr>
			<tr>
				<td colspan="3">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="right" colspan="3">
					<p align="center">Your email address:
						<input type="text" name="youremail" size="23" tabindex="106"></td>
			</tr>
			<tr>
				<td colspan="3">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3">
				<input type="text" name="Account_Number" size="10" maxlength="11" style="display:none;
visibility:hidden;">
				</td>
			</tr>			
			<tr>
				<td colspan="3">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" align="center" colspan="3">
					<input type="button" value="Email Info to Personnel Plus" name="submit_btn" tabindex="106" onclick="checkCredit()">&nbsp;&nbsp;<input type="reset" value="Reset Form" tabindex="107">
				</td>
			</tr>
		</table>
	</form>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/advertise/inc/navi_btm.asp' -->
	</BODY>
</HTML>