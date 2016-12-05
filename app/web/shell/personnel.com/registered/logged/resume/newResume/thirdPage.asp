<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->
<html>
<head>
<title>Resume Builder [STEP 3] - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/popcalendar.js"></script>
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<script language="javascript">
<!--
function checkForm()
{

var Error = 0
document.frmResInfo3.submit_btn.disabled = true;	

if (IsBlank(document.frmResInfo3.res_comp_name1.value))
  {  
  alert("Please enter the name of your most recent employer."); 
  document.frmResInfo3.res_comp_name1.value = "";   
  document.frmResInfo3.res_comp_name1.focus();  
  Error = 1 ;
  document.frmResInfo3.submit_btn.disabled = false;	
  return false  
  }

if (IsBlank(document.frmResInfo3.res_comp_city1.value))
  {  
  alert("Please specify the location of your most recent employer."); 
  document.frmResInfo3.res_comp_city1.value = "";     
  document.frmResInfo3.res_comp_city1.focus();  
  Error = 1 ;
  document.frmResInfo3.submit_btn.disabled = false;	
  return false  
  }
  
if (IsBlank(document.frmResInfo3.res_comp_job_title1.value))
  {  
  alert("Please enter the title of your most recent job position."); 
  document.frmResInfo3.res_comp_job_title1.value = "";     
  document.frmResInfo3.res_comp_job_title1.focus();  
  Error = 1 ;
  document.frmResInfo3.submit_btn.disabled = false;	
  return false  
  }  
  
if (IsBlank(document.frmResInfo3.res_comp_start_date1.value))
  {  
  alert("Please provide an approximate starting date of your most recent position."); 
  document.frmResInfo3.res_comp_start_date1.value = "";     
  document.frmResInfo3.res_comp_start_date1.focus();  
  Error = 1 ;
  document.frmResInfo3.submit_btn.disabled = false;	
  return false  
  }
  
if (IsBlank(document.frmResInfo3.res_comp_end_date1.value))
  {  
  alert("Please provide an approximate ending date for your most recent position."); 
  document.frmResInfo3.res_comp_end_date1.value = "";     
  document.frmResInfo3.res_comp_end_date1.focus();  
  Error = 1 ;
  document.frmResInfo3.submit_btn.disabled = false;	
  return false  
  }    
  
if (IsBlank(document.frmResInfo3.res_comp_job_duties1.value))
  {  
  alert("Please describe your last job position and duties in the space provided."); 
  document.frmResInfo3.res_comp_job_duties1.value = "";     
  document.frmResInfo3.res_comp_job_duties1.focus();  
  Error = 1 ;
  document.frmResInfo3.submit_btn.disabled = false;	
  return false  
  }     
  
if (IsBlank(document.frmResInfo3.res_comp_location1.value))
  {
  alert("Please select a state, province or country from the list.");
  document.frmResInfo3.res_comp_location1.focus();
  document.frmResInfo3.submit_btn.disabled = false; 
  Error = 1;
  return false
  }   
if (document.frmResInfo3.res_comp_location1.value == "1")
  {
  alert("Please select a state from the list.");
  document.frmResInfo3.res_comp_location1.focus();
  document.frmResInfo3.submit_btn.disabled = false; 
  Error = 1;
  return false
  }  
if (document.frmResInfo3.res_comp_location1.value == "2")
  {
  alert("Please select a province from the list.");
  document.frmResInfo3.res_comp_location1.focus();
  document.frmResInfo3.submit_btn.disabled = false; 
  Error = 1;
  return false
  } 
if (document.frmResInfo3.res_comp_location1.value == "3")
  {
  alert("Please select a country from the list.");
  document.frmResInfo3.res_comp_location1.focus();
  document.frmResInfo3.submit_btn.disabled = false; 
  Error = 1;
  return false
  }  
  
  
  
if (document.frmResInfo3.res_comp_location2.value == "1")
  {
  alert("Please select a state from the list.");
  document.frmResInfo3.res_comp_location2.focus();
  document.frmResInfo3.submit_btn.disabled = false; 
  Error = 1;
  return false
  }  
if (document.frmResInfo3.res_comp_location2.value == "2")
  {
  alert("Please select a province from the list.");
  document.frmResInfo3.res_comp_location2.focus();
  document.frmResInfo3.submit_btn.disabled = false; 
  Error = 1;
  return false
  } 
if (document.frmResInfo3.res_comp_location2.value == "3")
  {
  alert("Please select a country from the list.");
  document.frmResInfo3.res_comp_location2.focus();
  document.frmResInfo3.submit_btn.disabled = false; 
  Error = 1;
  return false
  }  
  
  
  
if (document.frmResInfo3.res_comp_location3.value == "1")
  {
  alert("Please select a state from the list.");
  document.frmResInfo3.res_comp_location3.focus();
  document.frmResInfo3.submit_btn.disabled = false; 
  Error = 1;
  return false
  }  
if (document.frmResInfo3.res_comp_location3.value == "2")
  {
  alert("Please select a province from the list.");
  document.frmResInfo3.res_comp_location3.focus();
  document.frmResInfo3.submit_btn.disabled = false; 
  Error = 1;
  return false
  } 
if (document.frmResInfo3.res_comp_location3.value == "3")
  {
  alert("Please select a country from the list.");
  document.frmResInfo3.res_comp_location3.focus();
  document.frmResInfo3.submit_btn.disabled = false; 
  Error = 1;
  return false
  }      
  
if (Error != 1)
  {  document.frmResInfo3.submit();  }
}
//-->
</script>
</head>

<body onLoad="javascript:document.frmResInfo3.res_comp_name1.focus();">
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
                  <p class="navLinks"><!-- #INCLUDE VIRTUAL='/includes/textNav.asp' --></p>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
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
                        <form name="frmResInfo3" method="post" action="doThirdPage.asp">
						<input type="hidden" name="inc_res_id" value="<%=request.querystring("inc_id")%>">
                          <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td colspan="4" class="redHead"><strong>STEP III: Employment History</strong></td>
                            </tr>
                            <tr> 
                              <td colspan="4"><i>List the details of your last three employers below.</i></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr bgcolor="#E7E7E7"> 
                              <td colspan="4"> <strong>Job One - Most Recent 
                                or Present Job</strong></td>
                            </tr>
                            <tr> 
                              <td>Company Name:</td>
                              <td> 
                                <input type="text" name="res_comp_name1" size="28" maxlength="125">
                              </td>
                              <td> Job Title:</td>
                              <td> 
                                <input type="text" name="res_comp_job_title1" size="28" maxlength="125">
                              </td>
                            </tr>
                            <tr>
                              <td>City:</td>
                              <td> 
                                <input type="text" name="res_comp_city1" size="20" maxlength="50">
                              </td>
							  <td>State / Country:</td>
							  <td>
						<SELECT NAME="res_comp_location1">
<OPTION VALUE="">SELECT STATE / COUNTRY </OPTION>							
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
                              <td>Start Date:</td>
                              <td> 
    <input type="text" size="12" maxlength="10" name="res_comp_start_date1">
    <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<input type=button onclick='popUpCalendar(this, frmResInfo3.res_comp_start_date1, \"mm/dd/yyyy\")' value='select date' style='font-size:11px'>")
							}
						//-->
	</script>
                              </td>
                              <td>End Date:</td>
                              <td> 
    <input type="text" size="12" maxlength="10" name="res_comp_end_date1">
    <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<input type=button onclick='popUpCalendar(this, frmResInfo3.res_comp_end_date1, \"mm/dd/yyyy\")' value='select date' style='font-size:11px'>")
							}
						//-->
	</script>
                              </td>
                            </tr>
                            <tr> 
                              <td valign="top">Job Duties:</td>
                              <td colspan="3"> 
                                <textarea name="res_comp_job_duties1" rows="4" cols="50"></textarea>
                              </td>
                            </tr>
                            <tr bgcolor="#E7E7E7"> 
                              <td colspan="4"><strong>Job Two</strong></td>
                            </tr>
                            <tr> 
                              <td>Company Name:</td>
                              <td> 
                                <input type="text" name="res_comp_name2" size="28" maxlength="125">
                              </td>
                              <td> Job Title:</td>
                              <td> 
                                <input type="text" name="res_comp_job_title2" size="28" maxlength="125">
                              </td>
                            </tr>
                            <tr> 
                              <td>City:</td>
                              <td> 
                                <input type="text" name="res_comp_city2" size="20" maxlength="50">
                              </td>							

							  <td>State / Country:</td>
							  <td>
						<SELECT NAME="res_comp_location2">
<OPTION VALUE="">SELECT STATE / COUNTRY </OPTION>							
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
                              <td>Start Date:</td>
                              <td> 
    <input type="text" size="12" maxlength="10" name="res_comp_start_date2">
    <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<input type=button onclick='popUpCalendar(this, frmResInfo3.res_comp_start_date2, \"mm/dd/yyyy\")' value='select date' style='font-size:11px'>")
							}
						//-->
	</script>
                              </td>
                              <td>End Date:</td>
                              <td> 
    <input type="text" size="12" maxlength="10" name="res_comp_end_date2">
    <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<input type=button onclick='popUpCalendar(this, frmResInfo3.res_comp_end_date2, \"mm/dd/yyyy\")' value='select date' style='font-size:11px'>")
							}
						//-->
	</script>
                              </td>
                            </tr>
                            <tr> 
                              <td valign="top">Job Duties:</td>
                              <td colspan="3"> 
                                <textarea name="res_comp_job_duties2" rows="4" cols="50"></textarea>
                              </td>
                            </tr>
                            <tr bgcolor="#E7E7E7"> 
                              <td colspan="4"><strong>Job Three</strong></td>
                            </tr>
                            <tr> 
                              <td>Company Name:</td>
                              <td> 
                                <input type="text" name="res_comp_name3" size="28" maxlength="125">
                              </td>
                              <td> Job Title:</td>
                              <td> 
                                <input type="text" name="res_comp_job_title3" size="28" maxlength="125">
                              </td>
                            </tr>
                            <tr> 
                              <td>City:</td>
                              <td> 
                                <input type="text" name="res_comp_city3" size="20" maxlength="50">
                              </td>							

							  <td>State / Country:</td>
							  <td>
						<SELECT NAME="res_comp_location3">
<OPTION VALUE="">SELECT STATE / COUNTRY </OPTION>						
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
                              <td>Start Date:</td>
                              <td> 
    <input type="text" size="12" maxlength="10" name="res_comp_start_date3">
    <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<input type=button onclick='popUpCalendar(this, frmResInfo3.res_comp_start_date3, \"mm/dd/yyyy\")' value='select date' style='font-size:11px'>")
							}
						//-->
	</script>
                              </td>
                              <td>End Date:</td>
                              <td> 
    <input type="text" size="12" maxlength="10" name="res_comp_end_date3">
    <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<input type=button onclick='popUpCalendar(this, frmResInfo3.res_comp_end_date3, \"mm/dd/yyyy\")' value='select date' style='font-size:11px'>")
							}
						//-->
	</script>
                              </td>
                            </tr>
                            <tr> 
                              <td valign="top">Job Duties:</td>
                              <td colspan="3"> 
                                <textarea name="res_comp_job_duties3" rows="4" cols="50"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td> 
                                <input type="button" name="submit_btn" value="Save & Continue" onClick="checkForm();">
                              </td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
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
set Connect = Nothing
%>
