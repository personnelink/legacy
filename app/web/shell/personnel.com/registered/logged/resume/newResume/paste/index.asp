<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkMbrAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->
<%
' Get member contact information to populate resume table with...
dim rsMbrInfo, sqlMbrInfo
sqlMbrInfo = "SELECT mbr_first_name, mbr_last_name, mbr_address_one, mbr_address_two, mbr_city, mbr_location, mbr_zipcode, mbr_phone_number, mbr_email_address FROM tbl_members WHERE mbr_id = " & session("mbrID")
Set rsMbrInfo = Server.CreateObject("ADODB.RecordSet")
rsMbrInfo.CursorLocation = 3
rsMbrInfo.Open(sqlMbrInfo),Connect

dim mbr_first_name	:	mbr_first_name = rsMbrInfo("mbr_first_name")
dim mbr_last_name	:	mbr_last_name = rsMbrInfo("mbr_last_name")
dim mbr_address_one	:	mbr_address_one = rsMbrInfo("mbr_address_one")
dim mbr_address_two	:	mbr_address_two = rsMbrInfo("mbr_address_two")
dim mbr_city		:	mbr_city = rsMbrInfo("mbr_city")
dim mbr_location	:	mbr_location = rsMbrInfo("mbr_location")
dim mbr_zipcode		:	mbr_zipcode = rsMbrInfo("mbr_zipcode")
dim mbr_phone_number	:	mbr_phone_number = rsMbrInfo("mbr_phone_number")
dim mbr_email_address	:	mbr_email_address = rsMbrInfo("mbr_email_address")

rsMbrInfo.Close
Set rsMbrInfo = Nothing

%>
<html>
<head>
<title>Upload Resume - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<script language="javascript">
<!--
function checkForm()
{

var Error = 0
document.frmPasteResume.submit_btn.disabled = true;	

if (IsBlank(document.frmPasteResume.res_title.value))
  {  
  alert("Please enter a title for your online resume."); 
  document.frmPasteResume.res_title.value = "";     
  document.frmPasteResume.res_title.focus();  
  Error = 1 ;
  document.frmPasteResume.submit_btn.disabled = false;	
  return false  
  }   
  
if (IsBlank(document.frmPasteResume.res_date_available.value))
  {  
  alert("Please indicate when you will be available to start work.");     
  document.frmPasteResume.res_date_available.focus();  
  Error = 1 ;
  document.frmPasteResume.submit_btn.disabled = false;	
  return false  
  }  
  
if (IsBlank(document.frmPasteResume.res_availability.value))
  {  
  alert("Please indicate when you will be available to start work.");     
  document.frmPasteResume.res_availability.focus();  
  Error = 1 ;
  document.frmPasteResume.submit_btn.disabled = false;	
  return false  
  }    
        
if (document.frmPasteResume.res_pref_location.value == "1")
  {
  alert("Please select a state from the list.");
  document.frmPasteResume.res_pref_location.focus();
  document.frmPasteResume.submit_btn.disabled = false; 
  Error = 1;
  return false
  }  
if (document.frmPasteResume.res_pref_location.value == "2")
  {
  alert("Please select a province from the list.");
  document.frmPasteResume.res_pref_location.focus();
  document.frmPasteResume.submit_btn.disabled = false; 
  Error = 1;
  return false
  } 
if (document.frmPasteResume.res_pref_location.value == "3")
  {
  alert("Please select a country from the list.");
  document.frmPasteResume.res_pref_location.focus();
  document.frmPasteResume.submit_btn.disabled = false; 
  Error = 1;
  return false
  }  
if (IsBlank(document.frmPasteResume.res_body.value))
  {  
  alert("No resume information has been entered!"); 
  document.frmPasteResume.res_body.value = "";     
  document.frmPasteResume.res_body.focus();  
  Error = 1 ;
  document.frmPasteResume.submit_btn.disabled = false;	
  return false  
  }    

if (Error != 1)
  {  document.frmPasteResume.submit();  }
}
//-->
</script>
</head>

<body onLoad="javascript:document.frmPasteResume.res_title.focus();">
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

                  <table width="95%" border="0" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                      <td valign="top">
<form name="frmPasteResume" method="post" action="doPaste.asp">
<input type="hidden" name="mbr_first_name" value="<%=mbr_first_name%>">
<input type="hidden" name="mbr_last_name" value="<%=mbr_last_name%>">
<input type="hidden" name="mbr_address_one" value="<%=mbr_address_one%>">
<input type="hidden" name="mbr_address_two" value="<%=mbr_address_two%>">
<input type="hidden" name="mbr_city" value="<%=mbr_city%>">
<input type="hidden" name="mbr_location" value="<%=mbr_location%>">
<input type="hidden" name="mbr_zipcode" value="<%=mbr_zipcode%>">
<input type="hidden" name="mbr_phone_number" value="<%=mbr_phone_number%>">
<input type="hidden" name="mbr_email_address" value="<%=mbr_email_address%>">
                          <table width="100%" border="0" cellspacing="0" cellpadding="4" style="border: 1px solid #666666;">
							<tr>
						<td bgcolor="#e7e7e7" colspan="2"><font size="3"><strong>Paste Your Resume:</strong></font></td>
							</tr>						  
                            <tr> 
                              <td valign="top"><strong>Title:</strong> <span class="smallDesc">(Employers will see this first when they browse resumes. Use <a href="/registered/logged/resume/resumeHelp/help.asp">keywords</a> that describe your skills or areas of expertise).</span></td>
                              <td valign="top"> 
                                <input type="text" name="res_title" size="60" maxlength="150">
                              </td>
                            </tr>
                            <tr> 
                              <td width="34%" class="req_label"><strong>I am eligible to work in the 
                                United States:</strong></td>
                              <td valign="top">Yes 
                                <input type="radio" name="res_is_eligible" value="1" checked>
                                &nbsp;&nbsp;&nbsp;No 
                                <input type="radio" name="res_is_eligible" value="0">
                              </td>
                            </tr>							
                            <tr> 
                              <td><strong>Preferred 
                                Job Location:</strong></td>
                              <td valign="top"> 
						  
					<SELECT NAME="res_pref_location">
<%do while not rsLoc.eof %>
						<OPTION	VALUE="<%= rsLoc("loc_code")%>" <%if rsLoc("loc_code") = mbr_location then%>SELECTED<% end if%>> <%=rsLoc("loc_name") %></OPTION>
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
                              <td width="34%" class="req_label"><strong>Desired Salary:</strong></td>
                              <td valign="top"> 
                                <input type="text" name="res_pref_salary" size="30" maxlength="20">
                              </td>
                            </tr>													
                            <tr> 
                              <td valign="top"><strong>Description:</strong> (Optional)<span class="smallDesc"><br>
                               This will serve as your Cover Letter if you wish to create one.</span></td>
                              <td valign="top"> 
                                <textarea name="res_description" cols="40" rows="6"></textarea>
                              </td>
                            </tr>
							<tr>
                              <td colspan="2" align="center"> 
							  <strong>Paste your resume below:</strong><br>
                                <textarea name="res_body" cols="68" rows="30"></textarea>
                              </td>
                            </tr>							
                            <tr> 
                              <td valign="top">&nbsp;</td>
                              <td valign="top" align="right"> 
                                <input type="button" name="submit_btn" value="Save This Resume" onClick="checkForm();">
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
Connect.Close
Set Connect = Nothing
%>
