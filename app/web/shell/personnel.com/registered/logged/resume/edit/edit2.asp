<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->
<%
dim rsResume
set rsResume = Server.CreateObject("ADODB.RecordSet")
rsResume.CursorLocation = 3
rsResume.Open "SELECT res_id, mbr_id, res_first_name, res_last_name, res_address_one, res_address_two, res_city, res_location, res_zipcode, res_phone_number, res_email_address, res_title, res_date_available, res_is_eligible, res_availability, res_will_relocate, res_pref_location, res_pref_salary, res_description, res_body, res_is_active, res_filename, res_completion_flag, res_view_count, res_date_created FROM tbl_resumes WHERE mbr_id = " & session("mbrID") & " AND res_id = " & request("id"),Connect
%>

<html>
<head>
<title>Resume Editor - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL = '/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<script language="javascript">
<!--
function checkForm()
{

var Error = 0
document.frmEditRes.submit_btn.disabled = true;	

if (IsBlank(document.frmEditRes.res_title.value))
  {  
  alert("Please enter a title for your online resume."); 
  document.frmEditRes.res_title.value = "";     
  document.frmEditRes.res_title.focus();  
  Error = 1 ;
  document.frmEditRes.submit_btn.disabled = false;	
  return false  
  }   
  
if (IsBlank(document.frmEditRes.res_date_available.value))
  {  
  alert("Please indicate when you will be available to start work.");     
  document.frmEditRes.res_date_available.focus();  
  Error = 1 ;
  document.frmEditRes.submit_btn.disabled = false;	
  return false  
  }  
  
if (IsBlank(document.frmEditRes.res_availability.value))
  {  
  alert("Please indicate when you will be available to start work.");     
  document.frmEditRes.res_availability.focus();  
  Error = 1 ;
  document.frmEditRes.submit_btn.disabled = false;	
  return false  
  }    
        
if (document.frmEditRes.res_pref_location.value == "1")
  {
  alert("Please select a state from the list.");
  document.frmEditRes.res_pref_location.focus();
  document.frmEditRes.submit_btn.disabled = false; 
  Error = 1;
  return false
  }  
if (document.frmEditRes.res_pref_location.value == "2")
  {
  alert("Please select a province from the list.");
  document.frmEditRes.res_pref_location.focus();
  document.frmEditRes.submit_btn.disabled = false; 
  Error = 1;
  return false
  } 
if (document.frmEditRes.res_pref_location.value == "3")
  {
  alert("Please select a country from the list.");
  document.frmEditRes.res_pref_location.focus();
  document.frmEditRes.submit_btn.disabled = false; 
  Error = 1;
  return false
  }  
if (IsBlank(document.frmEditRes.res_body.value))
  {  
  alert("No resume information has been entered!"); 
  document.frmEditRes.res_body.value = "";     
  document.frmEditRes.res_body.focus();  
  Error = 1 ;
  document.frmEditRes.submit_btn.disabled = false;	
  return false  
  }    

if (Error != 1)
  {  document.frmEditRes.submit();  }
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
                        <form name="frmEditRes" method="post" action="doEdit2.asp">
						<input type="hidden" name="id" value="<%=request("id")%>">
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" style="border: 1px solid #666666;">
							<tr>
						<td bgcolor="#e7e7e7"><font size="3"><strong>Edit Your Resume:</strong></font></td>
							<td align="right" bgcolor="#e7e7e7"><input type="button" name="submit_btn" value="Save Changes" onClick="checkForm();"></td>
							</tr>							  
                            <tr> 
                              <td width="34%"><b>Title:<br>
                                </b><span class="smallDesc">This will be 
                                the first thing an employer <br>
                                sees when they browse resumes.</span></td>
                              <td width="55%"> 
                                <input type="text" name="res_title" size="50" value="<%=rsResume("res_title")%>" maxlength="150">
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label"><strong>I am eligible to work in the 
                                United States:</strong></td>
                              <td valign="top">Yes 
                                <input type="radio" name="res_is_eligible" value="1" <%if Cint(rsResume("res_is_eligible")) = 1 then%>Checked<%end if%>>
                                &nbsp;&nbsp;&nbsp;No 
                                <input type="radio" name="res_is_eligible" value="0" <%if Cint(rsResume("res_is_eligible")) = 0 then%>Checked<%end if%>>
                              </td>
                            </tr>								
                            <tr> 
                              <td  width="34%"><b>Preferred Location:</td>
                              <td> 
						<SELECT NAME="res_pref_location">
<%do while not rsLoc.eof %>
						<OPTION	VALUE="<%= rsLoc("loc_code")%>" <%if rsLoc("loc_code") = rsResume("res_pref_location") then%>SELECTED<% end if%>> <%=rsLoc("loc_name") %></OPTION>
<% rsLoc.MoveNext
loop
set rsLoc = Nothing

%>	
				
						</SELECT>	
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label"><strong>Date Available to 
                                work:</strong></td>
                              <td valign="top"> 
                                <select name="res_date_available">
                                  <option value="">- Select Option -</option>									
                                  <option value="asap" <%if rsResume("res_date_available") = "asap" then%>SELECTED<%end if%>>As soon as possible</option>
                                  <option value="onemonth" <%if rsResume("res_date_available") = "onemonth" then%>SELECTED<%end if%>>Within 1 month</option>
                                  <option value="twomonths" <%if rsResume("res_date_available") = "twomonths" then%>SELECTED<%end if%>>1 to 2 months</option>
                                  <option value="threemonths" <%if rsResume("res_date_available") = "threemonths" then%>SELECTED<%end if%>>3 or more months</option>
                                </select>
                              </td>
                            </tr>	
                            <tr> 
                              <td width="34%" class="req_label"><strong>Availability:</strong></td>
                              <td valign="top"> 
                                <select name="res_availability">
                                  <option value="">- Select Option -</option>								
                                  <option value="FT" <%if rsResume("res_availability") = "FT" then%>SELECTED<%end if%>>Full Time</option>
                                  <option value="PT" <%if rsResume("res_availability") = "PT" then%>SELECTED<%end if%>>Part Time</option>
                                  <option value="FP" <%if rsResume("res_availability") = "FP" then%>SELECTED<%end if%>>Both</option>								  
                                </select>
                              </td>
                            </tr>							
                            <tr> 
                              <td width="34%" class="req_label"><strong>Are you willing to relocate:</strong></td>
                              <td valign="top">Yes 
                                <input type="radio" name="res_will_relocate" value="1" <%if Cint(rsResume("res_will_relocate")) = 1 then%>Checked<%end if%>>
                                &nbsp;&nbsp;&nbsp;No 
                                <input type="radio" name="res_will_relocate" value="0" <%if Cint(rsResume("res_will_relocate")) = 0 then%>Checked<%end if%>>
                              </td>
                            </tr>	
                            <tr> 
                              <td width="34%" class="req_label"><strong>Desired Salary:</strong></td>
                              <td valign="top"> 
                                <input type="text" name="res_pref_salary" size="30" maxlength="20" value="<%=rsResume("res_pref_salary")%>">
                              </td>
                            </tr>																					
							
                            <tr> 
                              <td valign="top"><strong>Description:</strong> <span class="smallDesc"><br>
                               (Optional) This will serve as your Cover Letter if you wish to create one.</span></td>
                              <td valign="top"> 
                                <textarea name="res_description" cols="40" rows="6"><%=rsResume("res_description")%></textarea>
                              </td>
                            </tr>
							<tr>
                              <td colspan="2" align="center"> 
							  <strong>Your current resume - make changes or simply paste a new resume below:</strong><br>
                                <textarea name="res_body" cols="68" rows="40"><%=rsResume("res_body")%></textarea>
                              </td>
                            </tr>								

                            <tr> 
                              <td width="34%">&nbsp;</td>
                              <td> 
                                
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
