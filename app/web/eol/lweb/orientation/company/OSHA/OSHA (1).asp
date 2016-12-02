<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<HTML>
<HEAD>
<script language="javascript">

function finish()
		{
		  document.OSHAemail.action = "/index.asp";
		}

function begin_office()

 {
	var isGood = true
		document.OSHAemail.btn_office.disabled = true;
	
	  if (document.OSHAemail.submit_email.value != '')
	    {
	    var okSoFar=true
	    var foundAt = document.OSHAemail.submit_email.value.indexOf("@",0)
	    var foundDot = document.OSHAemail.submit_email.value.indexOf(".",0)
	    if (foundAt+foundDot < 2 && okSoFar) {
	    alert ("The Company Agent's E-mail Address provided is incomplete.")
		document.OSHAemail.submit_email.value = "";
	    document.OSHAemail.submit_email.focus();
		document.OSHAemail.btn_office.disabled = false;
				isGood = false;
			return false
	     }	
	    }
  
	  if (document.OSHAemail.submit_fname.value == '')
	  	{  alert("A first name is required to continue.");
	  	document.OSHAemail.submit_fname.focus();
		document.OSHAemail.btn_office.disabled = false;
				isGood = false;
			return false
		}
		   
	  if (document.OSHAemail.submit_lname.value == '')
	  	{  alert("A last name is required to continue.");
	  	document.OSHAemail.submit_lname.focus();
		document.OSHAemail.btn_office.disabled = false;
				isGood = false;
			return false
		}
	
	  if (document.OSHAemail.submit_email.value == '')
	    {  alert("A contact Email Address is required to continue."); 
		document.OSHAemail.submit_email.focus();
		document.OSHAemail.btn_office.disabled = false;
				isGood = false; 
			return false
	  		}
	  						 	
  if (document.OSHAemail.submit_trgemail.value == '')
    {  alert("Please select the nearest city before proceeding."); 
	document.OSHAemail.submit_trgemail.focus();
		document.OSHAemail.submit_trgemail.value = "";
	    document.OSHAemail.submit_trgemail.focus();
		document.OSHAemail.btn_office.disabled = false;
			isGood = false; 
		return false
  		}	

	  if (isGood != false)
	  
		{var agree=confirm("Continue to the Office Orientation?");
			if (agree)
				{ 
				  document.OSHAemail.btn_office.disabled = false;
				  document.OSHAemail.action = "office.asp";
				}
	  else
		document.OSHAemail.btn_office.disabled = false;
		return false ;
		}
 }

function begin_labor()

 {
	var isGood = true
		document.OSHAemail.btn_labor.disabled = true;
	
	  if (document.OSHAemail.submit_email.value != '')
	    {
	    var okSoFar=true
	    var foundAt = document.OSHAemail.submit_email.value.indexOf("@",0)
	    var foundDot = document.OSHAemail.submit_email.value.indexOf(".",0)
	    if (foundAt+foundDot < 2 && okSoFar) {
	    alert ("The Company Agent's E-mail Address provided is incomplete.")
		document.OSHAemail.submit_email.value = "";
	    document.OSHAemail.submit_email.focus();
		document.OSHAemail.btn_labor.disabled = false;
				isGood = false;
			return false
	     }	
     }

	  if (document.OSHAemail.submit_fname.value == '')
	  	{  alert("A first name is required to continue.");
	  	document.OSHAemail.submit_fname.focus();
		document.OSHAemail.btn_labor.disabled = false;
				isGood = false;
			return false
		}
		   
	  if (document.OSHAemail.submit_lname.value == '')
	  	{  alert("A last name is required to continue.");
	  	document.OSHAemail.submit_lname.focus();
		document.OSHAemail.btn_labor.disabled = false;
				isGood = false;
			return false
		}
	
	  if (document.OSHAemail.submit_email.value == '')
	    {  alert("A contact Email Address is required to continue."); 
		document.OSHAemail.submit_email.focus();
		document.OSHAemail.btn_labor.disabled = false;
				isGood = false; 
			return false
	  		}
	  						 									
  if (document.OSHAemail.submit_trgemail.value == '')
    {  alert("Please select the nearest city before proceeding."); 
	document.OSHAemail.submit_trgemail.focus();
		document.OSHAemail.submit_trgemail.value = "";
	    document.OSHAemail.submit_trgemail.focus();
		document.OSHAemail.btn_labor.disabled = false;
			isGood = false; 
		return false
  		}	
 
	  if (isGood != false)
	  
		{var agree=confirm("Continue to the Labor Orientation?");
			if (agree)
				{ 
				  document.OSHAemail.btn_labor.disabled = false;
				  document.OSHAemail.action = "labor.asp";
				}
	  else
		document.OSHAemail.btn_labor.disabled = false;
		return false ;
		}
 }
	
</script>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<META NAME="ROBOTS" CONTENT="INDEX, FOLLOW">
<TITLE>Welcome to Personnel Plus! Idaho's Total Staffing Solution</TITLE>
</HEAD>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
<div align="center">
	<table border="0" width="431" height="97">
		<tr>
			<td align="center" height="35" width="425">
				<H2>OSHA Training</H2>
			</td>
		</tr>
		<!--tr>
			<td align="center" width="425">
				&nbsp;</td-->
		<!--tr>&nbsp;</tr-->
	</table>
	<table border="0" width="44%" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center">
				<% if session("companyUserName") <> "" then %>
					Welcome <%=session("companyUserName") %>,<br><BR>
					Please verify your email address below.<br><BR>
				<% end if %>
				<% if session("firstName") <> "" then %>
					Welcome <%=session("lastName") %>, <%=session("firstName") %>,<br><br>
					Please verify your email address below.<br><br>
				<% end if %>
				<% if request.cookies("OSHA")("fname") <> "" then %>
					Welcome <%=request.cookies("OSHA")("fname") %>,<br><br>
					Please verify your email address below.<br><br>
				<% end if %>
				<% if session("companyUserName") AND session("fistName") AND request.cookies("OSHA")("fname") = "" then %>
					Welcome Guest,<br><br>please enter your email address and name below.<br><br>
				<% end if %>
			</td>
		</tr>
	<form name="OSHAemail" method="post">
		<tr>
			<td align="center">
					<% if session("emailAddress") <> "" then %>
						<input type="hidden" name="submit_fname" value="<%=session("firstName") %>">
						<input type="hidden" name="submit_lname" value="<%=session("lastName") %>">
						Email Address:&nbsp;<input type="text" name="submit_email" size="35" maxlength="175" value="<%=session("emailAddress") %>"><br><br>
						<SELECT NAME="submit_trgemail" SIZE="1">
							<OPTION VALUE="">Select the nearest office: </OPTION>
							<OPTION VALUE="boise@personnel.com">Boise, ID</OPTION>
							<OPTION VALUE="burley@personnel.com">Burley, ID</OPTION>	
							<OPTION VALUE="nampa@personnel.com">Caldwell, ID</OPTION>
							<OPTION VALUE="burley@personnel.com">Jerome, ID</OPTION>	
							<OPTION VALUE="nampa@personnel.com">Nampa, ID</OPTION>
							<OPTION VALUE="twin@personnel.com">Twin Falls, ID</OPTION>
							<OPTION VALUE="twin@personnel.com">- Out of State -</option>
							<OPTION VALUE="twin@personnel.com">- Not Sure -</OPTION>
						</SELECT>																				
					<% else %>
						<% if request.cookies("OSHA")("email") <> "" then %>
							<input type="hidden" name="submit_fname" value="<%=request.cookies("OSHA")("fname") %>">
							<input type="hidden" name="submit_lname" value="<%=request.cookies("OSHA")("lname") %>">
							Email Address:&nbsp;<input type="text" name="submit_email" size="35" maxlength="175" value="<%=request.cookies("OSHA")("email") %>"><br><br>
							<SELECT NAME="submit_trgemail" SIZE="1">
								<OPTION VALUE="">Select the nearest office: </OPTION>
								<OPTION VALUE="boise@personnel.com">Boise, ID</OPTION>
								<OPTION VALUE="burley@personnel.com">Burley, ID</OPTION>	
								<OPTION VALUE="nampa@personnel.com">Caldwell, ID</OPTION>
								<OPTION VALUE="burley@personnel.com">Jerome, ID</OPTION>	
								<OPTION VALUE="nampa@personnel.com">Nampa, ID</OPTION>
								<OPTION VALUE="twin@personnel.com">Twin Falls, ID</OPTION>
								<OPTION VALUE="twin@personnel.com">- Out of State -</option>
								<OPTION VALUE="twin@personnel.com">- Not Sure -</OPTION>
							</SELECT>							
						<% else %>
							First Name:&nbsp;<input type="text" name="submit_fname" size="35" maxlength="50" value=""><br><br>
							Last Name:&nbsp;<input type="text" name="submit_lname" size="35" maxlength+"50" value=""><br><br>
							Email Address:&nbsp;<input type="text" name="submit_email" size="35" maxlength="175" value=""><br><br>
							<SELECT name="submit_trgemail" size="1">
								<option value="">Select the nearest office:</option>
								<option value="boise@personnel.com">Boise</option>
								<option value="burley@personnel.com">Burley</option>	
								<option value="nampa@personnel.com">Caldwell</option>
								<option value="burley@personnel.com">Jerome</option>	
								<option value="nampa@personnel.com">Nampa</option>
								<option value="rupert@personnel.com">Rupert</option>	
								<option value="twin@personnel.com">Twin Falls</option>
								<option value="twin@personnel.com">- Out Of State -</option>
								<option value="twin@personnel.com">- Not Sure -</option>
							</SELECT>
						<% end if %>
					<% end if %>
			</td>
		</tr>
		<tr>
			<td align="center">
				<br><br><br>
				<% if request("test") > "3" then %>
					<% Response.Cookies("OSHATEST").Expires = Now() + 999 %>
					<% Response.Cookies("OSHATEST") = "DONE" %>
					<INPUT STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" type="submit" name="btn_done" value="You are finished" onclick="finish();">
				<% else %>
					<% if request("test") = "2" then %>
						<INPUT STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" type="submit" name="btn_labor" value="Labor Training" onclick="begin_labor();"> 
					<% else %>
						<% if request("test") = "3" then %>
							<INPUT STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" type="submit" name="btn_office" value="Office Training" onclick="begin_office();"> 
						<% else %>
							<% if request("test") = "" OR request("test") < "2" then %>
								<INPUT STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" type="submit" name="btn_labor" value="Labor Training" onclick="begin_labor();">&nbsp;
								<INPUT STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" type="submit" name="btn_office" value="Office Training" onclick="begin_office();"> 
							<% else %>
								<INPUT STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" type="submit" name="btn_done" value="You are finished" onclick="finish();">							
								<% Response.Cookies("OSHATEST").Expires = Now() + 999 %>
								<% Response.Cookies("OSHATEST") = "DONE" %>
							<% end if %>
						<% end if %>
					<% end if %>
				<% end if %>
			</td>
		</tr>
	</FORM>						
	</table>
</div>
<!-- End Main Content -->			
		
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
</BODY>
</HTML>