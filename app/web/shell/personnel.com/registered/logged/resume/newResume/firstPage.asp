<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->
<%
dim rsMbrData, sqlMbrData
sqlMbrData = "SELECT mbr_id, mbr_first_name, mbr_last_name, mbr_address_one, mbr_address_two, mbr_city, mbr_location, mbr_zipcode, mbr_phone_number, mbr_email_address, mbr_availability, mbr_is_suspended, mbr_num_resumes, mbr_date_created FROM tbl_members WHERE mbr_id =" & session("mbrID")
Set rsMbrData = Connect.Execute(sqlMbrData)

dim mbr_first_name			:	mbr_first_name = rsMbrData("mbr_first_name")
dim mbr_last_name			:	mbr_last_name = rsMbrData("mbr_last_name")
dim mbr_address_one			:	mbr_address_one = rsMbrData("mbr_address_one")
dim mbr_address_two			:	mbr_address_two = rsMbrData("mbr_address_two")
dim mbr_city				:	mbr_city = rsMbrData("mbr_city")
dim mbr_location			:	mbr_location = rsMbrData("mbr_location")
dim mbr_zipcode				:	mbr_zipcode = rsMbrData("mbr_zipcode")
dim mbr_phone_number		:	mbr_phone_number = rsMbrData("mbr_phone_number")
dim mbr_email_address		:	mbr_email_address = rsMbrData("mbr_email_address")

rsMbrData.Close
Set rsMbrData = Nothing
%>

<html>
<head>
<title>Online Resume Builder [STEP I] - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<script language="javascript">
<!--
function checkForm()
{

var Error = 0
document.frmResInfo.submit_btn.disabled = true;	

if ((IsBlank(document.frmResInfo.res_first_name.value)) || (IsBlank(document.frmResInfo.res_last_name.value)) || (IsBlank(document.frmResInfo.res_address_one.value)) || (IsBlank(document.frmResInfo.res_city.value)) || (IsBlank(document.frmResInfo.res_zipcode.value)) || (IsBlank(document.frmResInfo.res_email_address.value)))

  {  alert("Please make sure you filled in all required information."); Error = 1 
document.frmResInfo.submit_btn.disabled = false;	
		    return false  
  }


if (Error != 1)
  {  document.frmResInfo.submit();  }
}
//-->
</script>
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
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                      <td> 
                        <form name="frmResInfo" method="post" action="doFirstPage.asp">
                          <table width="100%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td colspan="4" class="redHead"><strong>STEP I: Personal Information</strong></td>
                            </tr>
                            <tr> 
                              <td colspan="4" bgcolor="#e7e7e7">Here you can change your contact information 
                                as you would like it to appear to employers.</td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td class="req_label">First Name:</td>
                              <td> 
                                <input type="text" size="25" maxlength="50" name="res_first_name" value="<%=mbr_first_name%>">
                              </td>
                              <td class="req_label">Last Name:</td>
                              <td> 
                                <input type="text" size="25" maxlength="50" name="res_last_name" value="<%=mbr_last_name%>">
                              </td>
                            </tr>
                            <tr> 
                              <td class="req_label">Address:</td>
                              <td> 
                                <input type="text" size="25" maxlength="175" name="res_address_one" value="<%=mbr_address_one%>">
                              </td>
                              <td>Address <font size="1">(Continued)</font>:</td>
                              <td> 
                                <input type="text" size="25" maxlength="100" name="res_address_two" value="<%=mbr_address_two%>">
                              </td>
     						</tr>						
                            <tr> 
                              <td class="req_label">City:</td>
                              <td> 
                                <input type="text" size="25" maxlength="50" name="res_city" value="<%=mbr_city%>">
                              </td>
                              <td class="req_label">State/Country:</td>
                              <td> 
						<SELECT NAME="res_location">
				<% do while not rsLoc.eof %>
						<OPTION	VALUE="<%= rsLoc("loc_code")%>"<%if rsLoc("loc_code") = mbr_location then%>SELECTED<%end if%>> <%=rsLoc("loc_name") %></OPTION>
					<% rsLoc.MoveNext %>
				<% loop %>	
						</SELECT>

                              </td>
                            </tr>
                            <tr> 
                              <td class="req_label">Zip Code:</td>
                              <td> 
                                <input type="text" size="25" maxlength="20" name="res_zipcode" value="<%=mbr_zipcode%>">
                              </td>
                              <td class="req_label">E-mail Address:</td>
                              <td> 
                                <input type="text" size="25" maxlength="100" name="res_email_address" value="<%=mbr_email_address%>" onBlur="IsEmail(this);">

                              </td>
                            </tr>
                            <tr> 
                              <td>Contact Number:</td>
                              <td><input type="text" size="25" maxlength="20" name="res_phone_number" value="<%=mbr_phone_number%>" onBlur="formatPhoneNumber(this);"></td>
                              <td>&nbsp;</td>
                              <td> 
                                <input type="button" name="submit_btn" value="Save & Continue" onClick="checkForm();">
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="4"><input type="checkbox" name="res_is_active" value="no">Check here if you would prefer to keep your resume deactive (private) at this time. <br>You can still apply for jobs with a deactive resume. if you want employers to be able to browse your resume you must activate it by visiting the Resume Center.</td>
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
              <!-- #INCLUDE VIRTUAL='/includes/cdc_menu.asp' -->
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
Set rsLoc = Nothing
Connect.Close
Set Connect = Nothing
%>
