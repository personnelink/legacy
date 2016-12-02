<%
if session("empAuth") = "true" then
response.redirect("/registered/logged/index.asp")
end if
%>
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		secondPage.asp
'		Description:	New Employer sign up - page 3/4 - gathers general information about employer
'		Created:		Tuesday, February 17, 2004
'		Lastmod:
'		Developer(s):	James Werrbach
'	**********************************************************************

%>
<html>
<head>
<title>Create Employer Account [Step 3] - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<script language="Javascript">
/*
Form field Limiter script- By Dynamic Drive
For full source code and more DHTML scripts, visit http://www.dynamicdrive.com
This credit MUST stay intact for use
*/

var ns6=document.getElementById&&!document.all

function restrictinput(maxlength,e,placeholder){
if (window.event&&event.srcElement.value.length>=maxlength)
return false
else if (e.target&&e.target==eval(placeholder)&&e.target.value.length>=maxlength){
var pressedkey=/[a-zA-Z0-9\.\,\/]/ //detect alphanumeric keys
if (pressedkey.test(String.fromCharCode(e.which)))
e.stopPropagation()
}
}

function countlimit(maxlength,e,placeholder){
var theform=eval(placeholder)
var lengthleft=maxlength-theform.value.length
var placeholderobj=document.all? document.all[placeholder] : document.getElementById(placeholder)
if (window.event||e.target&&e.target==eval(placeholder)){
if (lengthleft<0)
theform.value=theform.value.substring(0,maxlength)
placeholderobj.innerHTML=lengthleft
}
}


function displaylimit(theform,thelimit){
var limit_text='[<font size=1><b><span id="'+theform.toString()+'">'+thelimit+'</span></b> of</font>'
if (document.all||ns6)
document.write(limit_text)
if (document.all){
eval(theform).onkeypress=function(){ return restrictinput(thelimit,event,theform)}
eval(theform).onkeyup=function(){ countlimit(thelimit,event,theform)}
}
else if (ns6){
document.body.addEventListener('keypress', function(event) { restrictinput(thelimit,event,theform) }, true); 
document.body.addEventListener('keyup', function(event) { countlimit(thelimit,event,theform) }, true); 
}
}

	
function checkFields()  {

var isGood = true

document.accountInfo.submit_btn.disabled = true;	

  if (document.accountInfo.emp_first_name.value == '' || (IsBlank(document.accountInfo.emp_first_name.value)))
    {  alert("Please enter your First Name."); 
    document.accountInfo.emp_first_name.value = "";	
	document.accountInfo.emp_first_name.focus();
document.accountInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}		
  if (document.accountInfo.emp_last_name.value == '' || (IsBlank(document.accountInfo.emp_last_name.value)))
    {  alert("Please enter your Last Name."); 
    document.accountInfo.emp_last_name.value = "";		
	document.accountInfo.emp_last_name.focus();
document.accountInfo.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}					
				  	
  if (document.accountInfo.emp_address_one.value == '' || (IsBlank(document.accountInfo.emp_address_one.value)))
    {  alert("Please provide a street or mailing address."); 
    document.accountInfo.emp_address_one.value = "";		
	document.accountInfo.emp_address_one.focus();
document.accountInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
		   		
  if (document.accountInfo.emp_city.value == '' || (IsBlank(document.accountInfo.emp_city.value)))
    {  alert("Please provide a City name."); 
    document.accountInfo.emp_city.value = "";		
	document.accountInfo.emp_city.focus();
document.accountInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 			
	
  if (document.accountInfo.emp_location.value == '1')
    {  alert("Please indicate which State you live in."); 
	document.accountInfo.emp_location.focus();
document.accountInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
  if (document.accountInfo.emp_location.value == '2')
    {  alert("Please indicate which Province you live in."); 
	document.accountInfo.emp_location.focus();
document.accountInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
  if (document.accountInfo.emp_location.value == '3')
    {  alert("Please indicate which Country you live in."); 
	document.accountInfo.emp_location.focus();
document.accountInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}					 
  if ((document.accountInfo.emp_zipcode.value == '' || (IsBlank(document.accountInfo.emp_zipcode.value))) && document.accountInfo.emp_location.value.length > 2)
    {  alert("Please enter a ZIP or Postal Code."); 
	document.accountInfo.emp_zipcode.focus();
document.accountInfo.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
  if (document.accountInfo.emp_zipcode.value.length < 5 && document.accountInfo.emp_location.value.length > 2)
    {  alert("Please enter a complete ZIP or Postal Code."); 
	document.accountInfo.emp_zipcode.focus();
document.accountInfo.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}					
  if (document.accountInfo.emp_phone_number.value == '' || (IsBlank(document.accountInfo.emp_phone_number.value)))
    {  alert("Please provide a contact phone number"); 
    document.accountInfo.emp_phone_number.value = "";	
	document.accountInfo.emp_phone_number.focus();
document.accountInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}				
					
  if (isGood != false)
    {  document.accountInfo.submit();  }
}
</SCRIPT>
</head>

<body onLoad="document.accountInfo.emp_first_name.focus()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="100%" bgcolor="#000000"> 
      <!-- #INCLUDE VIRTUAL='/includes/top_menu.asp' -->
    </td>
  </tr>
  <tr> 
    <td width="100%" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr bgcolor="EFEFEF"> 
          <td bgcolor="#5187CA"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td rowspan="2" width="216"><img src="/images/logo.gif" width="215" height="76"></td>
                <td width="100%"><img src="/images/pixel.gif" width="100%" height="72"></td>
              </tr>
              <tr> 
                <td height="4" width="100%" bgcolor="#FFFFFF"><img src="/images/pixel.gif" width="1" height="1"></td>
              </tr>
            </table>
          </td>
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_srn_w.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <!-- #INCLUDE VIRTUAL='/includes/menu.asp' -->
          </td>
          <td width="175">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="1" cellpadding="6">
			  <tr>
			  	<td colspan="2"><img src="/images/hdr_new_emp_reg.gif" alt="" width="328" height="48" border="0"></td>
			  </tr>				
              <tr>
			    <td width="20"><img src="/images/pixel.gif" width="20" height="1"></td>			   
                <td> 
<form name="accountInfo" method="post" action="doSecondPage.asp" onSubmit="noReturn('accountInfo'); return false">
<input type="hidden" name="emp_account_type" value="<%=request("act")%>">
<input type="hidden" name="emp_account_size" value="<%=request("acs")%>"> 		  
<table width="550" border="0" cellpadding="0" cellspacing="0">
 <tr>
 	<td colspan="2" rowspan="5"><img src="/images/pixel.gif" width="10" height="1"></td>
 </tr>
 <tr>
  <td colspan="2">Please enter your contact information below in the required (*) fields.<br>
</td>
 </tr>
 <tr>
 	<td colspan="2"><img src="/images/pixel.gif" width="10" height="15"></td>
 </tr>

 <tr valign="top">
  <td>
		<b>*</b>&nbsp;<strong>First Name:</strong><br>
		<input type="text" name="emp_first_name" size="30" maxlength="50" style class="req_entry"><br>
		<b>*</b>&nbsp;<strong>Last Name:</strong><br>
		<input type="text" name="emp_last_name" size="30" maxlength="50" style class="req_entry"><br>
		<b>*</b>&nbsp;<strong>Company Name:</strong><br>
		<input type="text" name="emp_company_name" size="30" maxlength="125" style class="req_entry"><br>
		Job E-mail: <font size="1">(For job seekers to contact you) </font><br>
		<input type="text" name="emp_job_email_address" value="<%=session("tmp_email_address")%>" size="30" maxlength="100" onBlur="IsEmail(this);"><br>
		Company Description:<br>
		<textarea cols="23" rows="4" name="emp_company_profile"></textarea>
<br>
<script>
displaylimit("document.accountInfo.emp_company_profile",1000)
</script>		
<font size="1"> 1000 characters left</font>]
	
   </td>
   <td>
		<b>*</b>&nbsp;<strong>Address:</strong><br>
		<input type="text" name="emp_address_one" size="31" maxlength="175" style class="req_entry"><br>
		<input type="text" name="emp_address_two" size="31" maxlength="100" style class="req_entry"><br>
		<b>*</b>&nbsp;<strong>City:</strong><br>
		<input type="text" name="emp_city" size="31" maxlength="50" style class="req_entry"><br>
		<b>*</b>&nbsp;<strong>State / Country:</strong><br>
		<SELECT NAME="emp_location" style class="req_entry">
<% do while not rsLoc.eof %>
		<OPTION	VALUE="<%= rsLoc("loc_code")%>"> <%=rsLoc("loc_name") %></OPTION>
	<% rsLoc.MoveNext %>
<% loop %>	
		</SELECT>
		<br>
		<b>*</b>&nbsp;<strong>ZIP Code:</strong><br>
		<input type="text" name="emp_zipcode" size="9" maxlength="10" style class="req_entry"><br>
		<b>*</b>&nbsp;<strong>Contact Phone:</strong><br>		
		<input type="text" name="emp_phone_number" size="16" maxlength="25" style class="req_entry" onBlur="formatPhoneNumber(this);"><br>
		Fax:<br>
		<input type="text" name="emp_fax_number" size="16" maxlength="25" onBlur="formatPhoneNumber(this);"><br>		
		

   </td>
  </tr>
  <tr>
  	<td>Your website homepage:<br>
	<input type="text" name="emp_url" value="http://" size="36" maxlength="150" onBlur="IsURL(this);"></td>
	<td><input type="button" name="submit_btn" value="Finished..." onClick="checkFields()"></td>
  </tr>
</table>
</form>
                </td>
              </tr>
            </table>
          </td>
          <td width="175" valign="top"> 
            <!-- #INCLUDE VIRTUAL='/includes/pub_menu.asp' -->
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="100%" height="10" bgcolor="#5187CA"> 
      <!-- #INCLUDE VIRTUAL='/includes/bottom_menu.asp' -->
    </td>
  </tr>
  <tr> 
    <td height="10" class="legal"><!-- #INCLUDE VIRTUAL='/includes/copyright.inc' --></td>
  </tr>
</table>
</body>
</html>
<%
Set rsLoc = Nothing
Connect.Close
Set Connect = Nothing
%>
