<% 
if session("mbrAuth") = "true" then
response.redirect("/registered/logged/index.asp")
end if
%>

<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->
<html>
<head>
<title>Create Member Account [Step 2] - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<SCRIPT LANGUAGE="javascript">	
function checkInfo()  {

var isGood = true

document.accountInfo.submit_btn.disabled = true;	

  if (document.accountInfo.mbr_first_name.value == '' || (IsBlank(document.accountInfo.mbr_first_name.value)))
    {  alert("Please enter your First Name."); 
document.accountInfo.mbr_first_name.value = "";	
document.accountInfo.mbr_first_name.focus();
document.accountInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}		
  if (document.accountInfo.mbr_last_name.value == '' || (IsBlank(document.accountInfo.mbr_last_name.value)))
    {  alert("Please enter your Last Name."); 
document.accountInfo.mbr_last_name.value = "";		
document.accountInfo.mbr_last_name.focus();
document.accountInfo.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}					
				  	
  if (document.accountInfo.mbr_address_one.value == '' || (IsBlank(document.accountInfo.mbr_address_one.value)))
    {  alert("Please provide your street or mailing address."); 
document.accountInfo.mbr_address_one.value = "";		
document.accountInfo.mbr_address_one.focus();
document.accountInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
		   		
  if (document.accountInfo.mbr_city.value == '' || (IsBlank(document.accountInfo.mbr_city.value)))
    {  alert("Please provide a city name."); 
document.accountInfo.mbr_city.value = "";		
document.accountInfo.mbr_city.focus();
document.accountInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 			
	
  if (document.accountInfo.mbr_location.value == '1')
    {  alert("Please indicate which state you live in."); 
document.accountInfo.mbr_location.focus();
document.accountInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
  if (document.accountInfo.mbr_location.value == '2')
    {  alert("Please indicate which province you live in."); 
document.accountInfo.mbr_location.focus();
document.accountInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}
  if (document.accountInfo.mbr_location.value == '3')
    {  alert("Please indicate which country you live in."); 
document.accountInfo.mbr_location.focus();
document.accountInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}				 
 
  if (document.accountInfo.mbr_zipcode.value == '' && document.accountInfo.mbr_location.value.length > 2)
    {  alert("Please enter a zip or postal code."); 
	document.accountInfo.mbr_zipcode.focus();
document.accountInfo.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
  if (document.accountInfo.mbr_zipcode.value.length < 5 && document.accountInfo.mbr_location.value.length > 2)
    {  alert("Please enter your complete zip or postal code."); 
	document.accountInfo.mbr_zipcode.focus();
document.accountInfo.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}			
					 	
							
  if (isGood != false)
    {  document.accountInfo.submit();  }
}
</SCRIPT>

<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
</head>

<body onLoad="javascript:document.accountInfo.mbr_first_name.focus()">
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
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td colspan="2" align="left"><img src="/images/hdr_new_mbr_reg.gif" width="328" height="48"></td>
                    </tr>
                    <tr> 
                       <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                       <td><p>We now need to collect some information from you 
                            so we can better
                            suit your needs.<br> After this you can build an online 
                            resume, search for jobs, and much more.</p>
                         
 						</td>
                    </tr>		
              		<tr> 
                       <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>	
                       <td>Please complete the following <b>required</b> information:</td>					   				
                	</tr>
					<tr>
					<td colspan="2">
                  <form name="accountInfo" method="post" action="doSecondPage.asp" onSubmit="noReturn('accountInfo'); return false">
                    <table width="90%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 

                      </tr>
                      <tr> 
                        <td align="right" style class="req_label">First Name:</td>
                        <td> 
                          <input type="text" name="mbr_first_name" size="30" maxlength="50">
                        </td>
					  </tr>
					  <tr>
                        <td align="right" style class="req_label">Last Name:</td>
                        <td> 
                          <input type="text" name="mbr_last_name" size="30" maxlength="50">
                        </td>
                      </tr>
                      <tr> 
                        <td align="right" style class="req_label">Address:</td>
                        <td> 
                          <input type="text" name="mbr_address_one" size="30" maxlength="175">
                        </td>
					  </tr>
					  <tr>						
                        <td align="right">Address <font size="1">(Continued...)</font></td>
                        <td> 
                          <input type="text" name="mbr_address_two" size="30" maxlength="100">
                        </td>
                      </tr>
                      <tr> 
                        <td align="right" style class="req_label">City:</td>
                        <td valign="top"> 
                          <input type="text" name="mbr_city" size="30" maxlength="50">
                        </td>
					  </tr>
					  <tr>						
                        <td align="right" style class="req_label">State / Country:</td>
                        <td> 
						<SELECT NAME="mbr_location">
				<% do while not rsLoc.eof %>
						<OPTION	VALUE="<%= rsLoc("loc_code")%>"> <%=rsLoc("loc_name") %></OPTION>
					<% rsLoc.MoveNext %>
				<% loop %>
						</SELECT>
                        </td>
                      </tr>
                      <tr> 
                        <td align="right" style class="req_label">Zip / Postal Code:</td>
                        <td> 
                          <input type="text" name="mbr_zipcode" size="10" maxlength="20"> (US & Canada only)
                        </td>
					  </tr>
					  <tr>						
                        <td align="right">Contact Phone:</td>
                        <td> 
                          <input type="text" name="mbr_phone_number" size="30" maxlength="25" onBlur="formatPhoneNumber(this);">
                        </td>
                      </tr>					  
					  <tr>						
                        <td align="right">&nbsp;</td>
                        <td><input type="button" name="submit_btn" value="Finish..." onClick="checkInfo();"></td>
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
rsLoc.Close
set rsLoc = nothing
%>
