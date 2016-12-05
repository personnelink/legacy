<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->

<%
dim rsEditRes
set rsEditRes = Server.CreateObject("ADODB.RecordSet")
rsEditRes.CursorLocation = 3
rsEditRes.Open "SELECT * FROM tbl_resumes WHERE mbr_id = " & session("mbrID") & " AND res_id=" & request("id"),Connect,3,3
%>

<html>
<head>
<title>Resume Editor - Step 1 of 5 - EDIT CONTACT INFORMATION: - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL = '/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<SCRIPT LANGUAGE="javascript">
function checkInfo()  {

var isGood = true

document.resumeInfo.submit_btn.disabled = true;	

  if (document.resumeInfo.res_first_name.value == '' || (IsBlank(document.resumeInfo.res_first_name.value)))
    {  alert("Please enter your First Name."); 
document.resumeInfo.res_first_name.value = "";	
document.resumeInfo.res_first_name.focus();
document.resumeInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}		
  if (document.resumeInfo.res_last_name.value == '' || (IsBlank(document.resumeInfo.res_last_name.value)))
    {  alert("Please enter your Last Name."); 
document.resumeInfo.res_last_name.value = "";		
document.resumeInfo.res_last_name.focus();
document.resumeInfo.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}					
				  	
  if (document.resumeInfo.res_address_one.value == '' || (IsBlank(document.resumeInfo.res_address_one.value)))
    {  alert("Please provide your street or mailing address."); 
document.resumeInfo.res_address_one.value = "";		
document.resumeInfo.res_address_one.focus();
document.resumeInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
		   		
  if (document.resumeInfo.res_city.value == '' || (IsBlank(document.resumeInfo.res_city.value)))
    {  alert("Please provide a city name."); 
document.resumeInfo.res_city.value = "";		
document.resumeInfo.res_city.focus();
document.resumeInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 			
	
  if (document.resumeInfo.res_location.value == '1')
    {  alert("Please indicate which state you live in."); 
document.resumeInfo.res_location.focus();
document.resumeInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
  if (document.resumeInfo.res_location.value == '2')
    {  alert("Please indicate which province you live in."); 
document.resumeInfo.res_location.focus();
document.resumeInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}
  if (document.resumeInfo.res_location.value == '3')
    {  alert("Please indicate which country you live in."); 
document.resumeInfo.res_location.focus();
document.resumeInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}				 
 
  if (document.resumeInfo.res_zipcode.value == '' && document.resumeInfo.res_location.value.length > 2)
    {  alert("Please enter a zip or postal code."); 
	document.resumeInfo.res_zipcode.focus();
document.resumeInfo.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
  if (document.resumeInfo.res_zipcode.value.length < 5 && document.resumeInfo.res_location.value.length > 2)
    {  alert("Please enter your complete zip or postal code."); 
	document.resumeInfo.res_zipcode.focus();
document.resumeInfo.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}			
			
if (IsBlank(document.resumeInfo.res_email_address.value))
  {
alert("Your E-mail Address cannot be blank");
document.resumeInfo.res_email_address.value = "";
document.resumeInfo.res_email_address.focus();
document.resumeInfo.submit_btn.disabled = false;
isGood=false;
return false;
  } 
	 	
							
  if (isGood != false)
    {  document.resumeInfo.submit();  }
}
</SCRIPT>
      <!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
</head>

<body>
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
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_cdc.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <!-- #INCLUDE VIRTUAL='/includes/menu.asp' -->
          </td>
          <td width="175" bgcolor="#000000">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="1">
              <tr bgcolor="E7E7E7"> 
                <td bgcolor="E7E7E7"> 
                  <p class="navLinks"> 
                    <!-- #INCLUDE VIRTUAL='/includes/textNav.asp' -->
                  </p>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="/images/headers/resumeCenter.gif" width="328" height="48"></td>
                    </tr>
                  </table>
                  <table width="95%" border="0" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                      <td> 
                        <form name="resumeInfo" method="post" action="doFirstPage.asp">
                          <table width="100%" border="0" cellspacing="0" cellpadding="2">
                            <tr> 
                              <td colspan="2" class="resTitle">Step 1 of 5 - EDIT CONTACT INFORMATION:</td>
                            </tr>
                            <tr> 
                              <td colspan="2">Make any needed changes using the form below, click Save & Continue when done. </td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td class="req_label">First Name:</td>
                              <td> 
                                <input type="text" name="res_first_name" value="<%=rsEditRes("res_first_name")%>" size="31" maxlength="50">
                              </td>
							</tr>
							<tr>
                              <td class="req_label">Last Name:</td>
                              <td> 
                                <input type="text" name="res_last_name" value="<%=rsEditRes("res_last_name")%>" size="31" maxlength="50">
                              </td>
                            </tr>
                            <tr> 
                              <td class="req_label">Address:</td>
                              <td> 
                                <input type="text" name="res_address_one" value="<%=rsEditRes("res_address_one")%>" size="31" maxlength="175">
                              </td>
							</tr>
							<tr>							  
                              <td>Address <font size="1">(more...)</font>:</td>
                              <td> 
                                <input type="text" name="res_address_two" value="<%=rsEditRes("res_address_two")%>" size="31" maxlength="100">
                              </td>
                            </tr>
                            <tr> 
                              <td class="req_label">City:</td>
                              <td> 
                                <input type="text" name="res_city" value="<%=rsEditRes("res_city")%>" size="31" maxlength="50">
                              </td>
							</tr>
							<tr>							  
                              <td class="req_label">State / Country:</td>
                              <td> 
						<SELECT NAME="res_location">
                        <option value="" selected>- Select a Job Location -</option>						
				<% do while not rsLoc.eof %>
						<OPTION	VALUE="<%= rsLoc("loc_code")%>"<% if rsLoc("loc_code") = rsEditRes("res_location") then%>Selected<%end if%>> <%=rsLoc("loc_name") %></OPTION>
					<% rsLoc.MoveNext %>
				<% loop %>	
						</SELECT>
                              </td>
                            </tr>
                            <tr> 
                              <td class="req_label">Zip Code:</td>
                              <td> 
                                <input type="text" name="res_zipcode" value="<%=rsEditRes("res_zipcode")%>" size="31" maxlength="10">
                              </td>
							</tr>
							<tr>							  
                              <td class="req_label">E-mail Address:</td>
                              <td> 
                                <input type="text" name="res_email_address" value="<%=rsEditRes("res_email_address")%>" size="31" maxlength="100" onBlur="IsEmail(this);">
                              </td>
                            </tr>
                            <tr> 
                              <td>Contact Number:</td>
                              <td><input type="text" name="res_phone_number" value="<%=rsEditRes("res_phone_number")%>" size="31" maxlength="25" onBlur="formatPhoneNumber(this);"></td>
							</tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>							
							<tr>
								<td> </td>
                              <td align="left"> <p></p>
                                <input type="hidden" name="num" value="<%=request("id")%>">
                               <input type="button" name="submit_btn" value="Save & Continue" onClick="checkInfo();"></td>
                            </tr>

                          </table>
                        </form>
					
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="175" valign="top"> 
            <p> 
              <!-- #INCLUDE VIRTUAL='/includes/cdc_menu.asp' -->
            </p>
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
rsEditRes.Close
Set rsEditRes = Nothing
Connect.Close
Set Connect = Nothing
%>	
