<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->

<html>
<head>
<title>Resume Builder [STEP II] - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<script language="javascript">
<!--
function checkForm()
{

var Error = 0
document.frmResInfo2.submit_btn.disabled = true;	

if ((IsBlank(document.frmResInfo2.res_title.value)) || (IsBlank(document.frmResInfo2.res_objective.value)) || (IsBlank(document.frmResInfo2.res_pref_salary.value)) || (IsBlank(document.frmResInfo2.res_date_available.value)) || (IsBlank(document.frmResInfo2.res_availability.value)) || (IsBlank(document.frmResInfo2.res_skills.value)))
  {  
  alert("Be sure you have entered all required information (in bold)"); 
  Error = 1 ;
  document.frmResInfo2.submit_btn.disabled = false;	
  return false  
  }

if (document.frmResInfo2.res_pref_location.value == "1")
  {
  alert("Please select a preferred state from the list.");
  document.frmResInfo2.res_pref_location.focus();
  document.frmResInfo2.submit_btn.disabled = false; 
  Error = 1;
  return false
  }  
if (document.frmResInfo2.res_pref_location.value == "2")
  {
  alert("Please select a preferred province from the list.");
  document.frmResInfo2.res_pref_location.focus();
  document.frmResInfo2.submit_btn.disabled = false; 
  Error = 1;
  return false
  } 
if (document.frmResInfo2.res_pref_location.value == "3")
  {
  alert("Please select a preferred country from the list.");
  document.frmResInfo2.res_pref_location.focus();
  document.frmResInfo2.submit_btn.disabled = false; 
  Error = 1;
  return false
  }   
  
if (Error != 1)
  {  document.frmResInfo2.submit();  }
}
//-->
</script>

</head>

<body onLoad="javascript:document.frmResInfo2.res_title.focus();">
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
          <td bgcolor="#5187CA" width="194"><img src="/images/flare_cdc.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <!-- #INCLUDE VIRTUAL='/includes/menu.asp' -->
          </td>
          <td width="194" bgcolor="#000000">&nbsp;</td>
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
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                      <td> 
                        <form name="frmResInfo2" method="post" action="doSecondPage.asp">
						<input type="hidden" name="inc_res_id" value="<%=request.querystring("inc_id")%>">						
                          <table width="100%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td colspan="2"><strong>STEP II: Work Objective & Preferences</strong></td>
                            </tr>
                            <tr> 
                              <td width="34%">&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="34%"> 
                                <p><strong>Resume Title:</strong><br>
                                  <font size="1">(Employers will see this when searching resumes)</font>
                                </p>
                                </td>
                              <td valign="top"> 
                                <input type="text" name="res_title" size="45" maxlength="150">
                              </td>
                            </tr>
                            <tr> 
                              <td valign="top" width="34%"><strong>Work Objective:</strong><br>
                                  <font size="1">(Short description of your immediate and future employment goals, desires)</font>
                                </p></td>
                              <td valign="top"> 
                                <textarea name="res_objective" cols="35" rows="4"></textarea>
                              </td>
                            </tr>
                            <tr>
                              <td width="34%"><strong>Preferred Location:</strong><br>
                                  <font size="1">(Where would you most like to work)</font></td>
                              <td valign="top"> 
						<SELECT NAME="res_pref_location">
				<% do while not rsLoc.eof %>
						<OPTION	VALUE="<%= rsLoc("loc_code")%>"<% if request.Querystring("loc") = rsLoc("loc_code") then %> SELECTED<% end if%>> <%=rsLoc("loc_name") %></OPTION>
					<% rsLoc.MoveNext %>
				<% loop %>	
						</SELECT>
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label"><strong>Date Available to 
                                work:</strong></td>
                              <td valign="top"> 
                                <select name="res_date_available">
                                  <option value="">- Select Option -</option>									
                                  <option value="asap">As soon as possible</option>
                                  <option value="onemonth">Within 1 month</option>
                                  <option value="twomonths">1 to 2 months</option>
                                  <option value="threemonths">3 or more months</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label"><strong>Availability:</strong></td>
                              <td valign="top"> 
                                <select name="res_availability">
                                  <option value="">- Select Option -</option>								
                                  <option value="FT">Full Time</option>
                                  <option value="PT">Part Time</option>
                                  <option value="FP">Both</option>								  
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label"><strong>Are you willing to relocate:</strong></td>
                              <td valign="top">Yes 
                                <input type="radio" name="res_will_relocate" value="1">
                                &nbsp;&nbsp;&nbsp;No 
                                <input type="radio" name="res_will_relocate" value="0" checked>
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label"><strong>I am eligible to work in the 
                                US:</strong></td>
                              <td valign="top">Yes 
                                <input type="radio" name="res_is_eligible" value="1" checked>
                                &nbsp;&nbsp;&nbsp;No 
                                <input type="radio" name="res_is_eligible" value="0">
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label"><strong>Desired Salary / Payrate:</strong></td>
                              <td valign="top"> 
                                <input type="text" name="res_pref_salary" size="30" maxlength="20">
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" valign="top" class="req_label">Skills / Hobbies:</td>
                              <td valign="top"> 
                                <textarea name="res_skills" cols="35" rows="4"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%">&nbsp;</td>
                              <td valign="top">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="34%">&nbsp;</td>
                              <td valign="top"> 
                                <input type="button" name="submit_btn" value="Save & Continue" onClick="checkForm();">
                              </td>
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
          <td width="194" valign="top"> 
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
