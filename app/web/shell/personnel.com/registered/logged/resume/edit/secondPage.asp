<!-- #INCLUDE VIRTUAL = 'includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = 'includes/checkMbrAuth.asp' -->
<!-- #INCLUDE VIRTUAL = 'includes/get_locations.asp' -->

<%
dim rsResume
set rsResume = Server.CreateObject("ADODB.RecordSet")
rsResume.CursorLocation = 3
rsResume.Open "SELECT * FROM tbl_resumes WHERE mbr_id = " & session("mbrID") & " AND res_id = " & request("num"),Connect
%>

<html>
<head>
<title>Resume Editor - Step 2 of 5 - EDIT OBJECTIVE, PREFERENCES, AND SKILLS: - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL = '/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<script language="javascript">
<!--
function checkInfo()
{

var Error = 0
document.resumeInfo.submit_btn.disabled = true;	

if ((IsBlank(document.resumeInfo.res_title.value)) || (IsBlank(document.resumeInfo.res_objective.value)) || (IsBlank(document.resumeInfo.res_pref_salary.value)) || (IsBlank(document.resumeInfo.res_date_available.value)) || (IsBlank(document.resumeInfo.res_availability.value)))
  {  
  alert("Please make sure you have entered all required information (in Bold)"); 
  Error = 1 ;
  document.resumeInfo.submit_btn.disabled = false;	
  return false  
  }

if (document.resumeInfo.res_pref_location.value == "1")
  {
  alert("Please select a preferred state from the list.");
  document.resumeInfo.res_pref_location.focus();
  document.resumeInfo.submit_btn.disabled = false; 
  Error = 1;
  return false
  }  
if (document.resumeInfo.res_pref_location.value == "2")
  {
  alert("Please select a preferred province from the list.");
  document.resumeInfo.res_pref_location.focus();
  document.resumeInfo.submit_btn.disabled = false; 
  Error = 1;
  return false
  } 
if (document.resumeInfo.res_pref_location.value == "3")
  {
  alert("Please select a preferred country from the list.");
  document.resumeInfo.res_pref_location.focus();
  document.resumeInfo.submit_btn.disabled = false; 
  Error = 1;
  return false
  }   
  
if (Error != 1)
  {  document.resumeInfo.submit();  }
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
        <tr bgcolor="#EFEFEF"> 
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
                        <form name="resumeInfo" method="post" action="doSecondPage.asp">
                          <table width="100%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td colspan="2" class="resTitle">Step 2 of 5 - EDIT OBJECTIVE, PREFERENCES, AND SKILLS:</td>
                            </tr>
                            <tr> 
                              <td width="34%">&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label">Resume Title:</td>
                              <td> 
                                <input type="text" name="res_title" size="60" value="<%=rsResume("res_title")%>" maxlength="150">
                              </td>
                            </tr>
                            <tr> 
                              <td valign="top" width="34%" class="req_label">Resume Objective:</td>
                              <td> 
                                <textarea name="res_objective" cols="35" rows="6"><%=rsResume("res_objective")%></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label">Preferred Location:</td>
                              <td valign="top"> 
						<SELECT NAME="res_pref_location">
                        <option value="" selected>- Select a Job Location -</option>						
				<% do while not rsLoc.eof %>
						<OPTION	VALUE="<%= rsLoc("loc_code")%>"<% if rsLoc("loc_code") = rsResume("res_pref_location") then%>Selected<%end if%>> <%=rsLoc("loc_name") %></OPTION>
					<% rsLoc.MoveNext %>
				<% loop %>	
						</SELECT>
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label">Date Available to 
                                work:</td>
                              <td> 
                                <select name="res_date_available">
                                  <option value="asap" <% if rsResume("res_date_available") = "asap" then %>SELECTED<% End if %>>As soon 
                                  as possible</option>
                                  <option value="onemonth" <% if rsResume("res_date_available") = "onemonth" then %>SELECTED<% End if %>>Under 
                                  1 month</option>
                                  <option value="twomonths" <% if rsResume("res_date_available") = "twomonths" then %>SELECTED<% End if %>>1 
                                  to 2 months</option>
                                  <option value="threemonths" <% if rsResume("res_date_available") = "threemonths" then %>SELECTED<% End if %>>3 
                                  or more months</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label">Availability:</td>
                              <td>
                                <select name="res_availability">
                                  <option value="FP" <% if rsResume("res_availability") = "FP" then %>SELECTED<% End if %>>Full Time 
                                  and/or Part Time</option>
                                  <option value="FT" <% if rsResume("res_availability") = "FT" then %>SELECTED<% End if %>>Full 
                                  Time</option>
                                  <option value="PT" <% if rsResume("res_availability") = "PT" then %>SELECTED<% End if %>>Part 
                                  Time</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label">Are you willing to relocate:</td>
                              <td>Yes 
                                <input type="radio" name="res_will_relocate" value="1" <% if CInt(rsResume("res_will_relocate")) = 1 then response.write("checked") End if %>>
                                &nbsp;&nbsp;&nbsp;No 
                                <input type="radio" name="res_will_relocate" value="0" <% if CInt(rsResume("res_will_relocate")) = 0 then response.write("checked") end if%>>
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label">I am eligible to work in the 
                                US:</td>
                              <td> Yes 
                                <input type="radio" name="res_is_eligible" value="1" <% if CInt(rsResume("res_is_eligible")) = 1 then response.write("checked") end if%>>
                                &nbsp;&nbsp;&nbsp;No 
                                <input type="radio" name="res_is_eligible" value="0" <% if CInt(rsResume("res_is_eligible")) = 0 then response.write("checked") end if%>>
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label">Ideal Salary Range:</td>
                              <td> 
                                <input type="text" name="res_pref_salary" size="20" value="<%=rsResume("res_pref_salary")%>" maxlength="20">
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" valign="top" class="req_label">Skills / Hobbies:</td>
                              <td> 
                                <textarea name="res_skills" cols="35" rows="6"><%=rsResume("res_skills")%></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%"> 
                                <input type="hidden" name="num" value="<%=request("num")%>">
                              </td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="34%">&nbsp;</td>
                              <td> 
                                <input type="button" name="submit_btn" value="Save & Continue" onClick="checkInfo();">
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
rsResume.Close
Set rsResume = Nothing
Connect.Close
Set Connect = Nothing
%>
