<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->


<html>
<head>
<title>Resume Builder [STEP 4] - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<script language="javascript">
<!--
function checkForm()
{

var Error = 0
document.frmResInfo4.submit_btn.disabled = true;	

if (IsBlank(document.frmResInfo4.res_hs_name.value))
  {  
  alert("Please enter the name of your high school."); 
  document.frmResInfo4.res_hs_name.value = "";   
  document.frmResInfo4.res_hs_name.focus();  
  Error = 1 ;
  document.frmResInfo4.submit_btn.disabled = false;	
  return false  
  }

if (IsBlank(document.frmResInfo4.res_hs_city.value))
  {  
  alert("Please enter the city or town for your high school."); 
  document.frmResInfo4.res_hs_city.value = "";     
  document.frmResInfo4.res_hs_city.focus();  
  Error = 1 ;
  document.frmResInfo4.submit_btn.disabled = false;	
  return false  
  }
  
if (document.frmResInfo4.res_hs_location.value == "1" || document.frmResInfo4.res_hs_location.value == "2" || document.frmResInfo4.res_hs_location.value == "3")
  {
  alert("Please select a state or country from the list.");
  document.frmResInfo4.res_hs_location.focus();
  document.frmResInfo4.submit_btn.disabled = false; 
  Error = 1;
  return false
  }  
  
if (IsBlank(document.frmResInfo4.res_hs_location.value))
  {  
  alert("Please select your high school state or country from the list.");   
  document.frmResInfo4.res_hs_location.focus();  
  Error = 1 ;
  document.frmResInfo4.submit_btn.disabled = false;	
  return false  
  }
  
      
if (IsBlank(document.frmResInfo4.res_hs_diploma.value))
  {  
  alert("Please indicate if you graduated from high school.");     
  document.frmResInfo4.res_hs_diploma.focus();  
  Error = 1 ;
  document.frmResInfo4.submit_btn.disabled = false;	
  return false  
  }  

  
if (Error != 1)
  {  document.frmResInfo4.submit();  }
}
//-->
</script>
</head>

<body onLoad="javascript:document.frmResInfo3.res_college_name1.focus();">
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
              <tr bgcolor="#E7E7E7"> 
                <td bgcolor="#E7E7E7"> 
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
                        <form name="frmResInfo4" method="post" action="doFourthPage.asp">
						<input type="hidden" name="inc_res_id" value="<%=request.querystring("inc_id")%>">						
                          <table width="100%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td colspan="4" class="redHead"><strong>STEP IV: Educational Background</strong></td>
                            </tr>
                            <tr> 
                              <td colspan="4"><i>Please enter your educational background as 
                                it applies to you.</i></td>
                            </tr>
                            <tr> 
                              <td width="25%">&nbsp;</td>
                              <td width="25%">&nbsp;</td>
                              <td width="25%">&nbsp;</td>
                              <td width="25%">&nbsp;</td>
                            </tr>
                            <tr bgcolor="#E7E7E7"> 
                              <td colspan="4"><b>College / University Experience</b></td>
                            </tr>
                            <tr> 
                              <td width="25%">School Name:</td>
                              <td> 
                                <input type="text" name="res_college_name1" size="30" maxlength="100">
                              </td>
                              <td>State / Country:</td>
                              <td> 
						<SELECT NAME="res_college_location1">
<OPTION VALUE="">SELECT STATE / COUNTRY</OPTION>						
<%
dim rsLoc1, sqlLoc1
sqlLoc1 = "SELECT loc_id, loc_code, loc_name FROM tbl_locations"
set rsLoc1 = Connect.Execute(sqlLoc1)			
				 do while not rsLoc1.eof %>
						<OPTION	VALUE="<%= rsLoc1("loc_code")%>"> <%=rsLoc1("loc_name") %></OPTION>
<% rsLoc1.MoveNext
loop
set rsLoc1 = Nothing
%>	
				
						</SELECT>									
                              </td>							  
                            </tr>
                            <tr> 
                              <td width="25%">City / Town:</td>
                              <td width="25%"> 
                                <input type="text" name="res_college_city1" size="20" maxlength="50">
                              </td>
                              <td width="25%">Degree Obtained:<br>
                              </td>
                              <td width="25%"> 
                                <input type="text" name="res_college_degree1" size="30" maxlength="50">
                              </td>							  
                            </tr>
                            <tr> 
                              <td colspan="4" valign="top">&nbsp; </td>
                            </tr>
							
                            <tr> 
                              <td width="25%">School Name:</td>
                              <td> 
                                <input type="text" name="res_college_name2" size="30" maxlength="100">
                              </td>
                              <td>State / Country:</td>
                              <td> 
						<SELECT NAME="res_college_location2">
<OPTION VALUE="">SELECT STATE / COUNTRY</OPTION>							
<%
dim rsLoc2, sqlLoc2
sqlLoc2 = "SELECT loc_id, loc_code, loc_name FROM tbl_locations"
set rsLoc2 = Connect.Execute(sqlLoc2)			
				 do while not rsLoc2.eof %>
						<OPTION	VALUE="<%= rsLoc2("loc_code")%>"> <%=rsLoc2("loc_name") %></OPTION>
<% rsLoc2.MoveNext
loop
set rsLoc2 = Nothing
%>	
				
						</SELECT>									
                              </td>							  
                            </tr>
                            <tr> 
                              <td width="25%">City / Town:</td>
                              <td width="25%"> 
                                <input type="text" name="res_college_city2" size="30" maxlength="50">
                              </td>
                              <td width="25%">Degree Obtained:<br>
                              </td>
                              <td width="25%"> 
                                <input type="text" name="res_college_degree2" size="30" maxlength="50">
                              </td>							  
                            </tr>
                            <tr> 
                              <td colspan="4" valign="top">&nbsp; </td>
                            </tr>
							
							<!--  -->
                            <tr> 
                              <td width="25%" valign="top">&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr bgcolor="#E7E7E7"> 
                              <td colspan="4" valign="top"><b>High 
                                School Experience</b></td>
                            </tr>
                            <tr> 
                              <td width="25%">School Name:</td>
                              <td> 
                                <input type="text" name="res_hs_name" size="30" maxlength="100">
                              </td>
<td>State / Country:</td>
                              <td> 
						<SELECT NAME="res_hs_location">
<OPTION VALUE="">SELECT STATE / COUNTRY</OPTION>							
<%
dim rsLoc3, sqlLoc3
sqlLoc3 = "SELECT loc_id, loc_code, loc_name FROM tbl_locations"
set rsLoc3 = Connect.Execute(sqlLoc3)			
				 do while not rsLoc3.eof %>
						<OPTION	VALUE="<%= rsLoc3("loc_code")%>"> <%=rsLoc3("loc_name") %></OPTION>
<% rsLoc3.MoveNext
loop
set rsLoc3 = Nothing
%>	
				
						</SELECT>									
                              </td>							  
                            </tr>
                            <tr> 
                              <td width="25%">City / Town:</td>
                              <td> 
                                <input type="text" name="res_hs_city" maxlength="50">
                              </td>
 <td width="25%">Did you graduate?</td>
                              <td>
							  <SELECT name="res_hs_diploma">
							  <option value="">- Please Select -</option>							  
							  <option value="1">Yes (Diploma or GED)</option>
							  <option value="0">No</option>
							  </SELECT>
                              </td>
                            </tr>
                            <tr> 
                              <td width="25%">&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="25%">&nbsp;</td>
                             <td>&nbsp;</td>							  
                              <td> 
                                <input type="button" name="submit_btn" value="Next..." onClick="checkForm();">
                              </td>
 
                              <td>&nbsp;</td>
                            </tr>
                          </table>
                        </form>
                      </td>
                    </tr>
                  </table>
                  <p>&nbsp;</p>
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
Connect.Close
Set Connect = Nothing
%>
