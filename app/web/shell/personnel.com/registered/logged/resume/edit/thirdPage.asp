<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->

<%
dim rsResume
set rsResume = Server.CreateObject("ADODB.RecordSet")
rsResume.CursorLocation = 3
rsResume.Open "SELECT * FROM tbl_resumes WHERE mbr_id = " & session("mbrID") & " AND res_id = " & request("num"),Connect
%>

<html>
<head>
<title>Resume Editor - Step 3 of 5 - EDIT WORK HISTORY: - www.personnel.com</title>
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<script language="javascript" src="/includes/scripts/popcalendar.js"></script>
<script language="javascript">
<!--

function checkForm()
{

var Error = 0
document.resumeInfo.submit_btn.disabled = true;	

if (IsBlank(document.resumeInfo.res_comp_name1.value))
  {  
  alert("Please enter the name of your most recent employer."); 
  document.resumeInfo.res_comp_name1.value == "";   
  document.resumeInfo.res_comp_name1.focus();  
  Error = 1 ;
  document.resumeInfo.submit_btn.disabled = false;	
  return false  
  }

if (IsBlank(document.resumeInfo.res_comp_city1.value))
  {  
  alert("Please specify the location of your most recent employer."); 
  document.resumeInfo.res_comp_city1.value == "";     
  document.resumeInfo.res_comp_city1.focus();  
  Error = 1 ;
  document.resumeInfo.submit_btn.disabled = false;	
  return false  
  }
  
if (IsBlank(document.resumeInfo.res_comp_job_title1.value))
  {  
  alert("Please enter the title of your most recent job position."); 
  document.resumeInfo.res_comp_job_title1.value == "";     
  document.resumeInfo.res_comp_job_title1.focus();  
  Error = 1 ;
  document.resumeInfo.submit_btn.disabled = false;	
  return false  
  }  
  
if (IsBlank(document.resumeInfo.res_comp_start_date1.value))
  {  
  alert("Please provide an approximate starting date of your most recent position."); 
  document.resumeInfo.res_comp_start_date1.value == "";     
  document.resumeInfo.res_comp_start_date1.focus();  
  Error = 1 ;
  document.resumeInfo.submit_btn.disabled = false;	
  return false  
  }
  
if (IsBlank(document.resumeInfo.res_comp_end_date1.value))
  {  
  alert("Please provide an approximate ending date for your most recent position."); 
  document.resumeInfo.res_comp_end_date1.value == "";     
  document.resumeInfo.res_comp_end_date1.focus();  
  Error = 1 ;
  document.resumeInfo.submit_btn.disabled = false;	
  return false  
  }    
  
if (IsBlank(document.resumeInfo.res_comp_job_duties1.value))
  {  
  alert("Please describe your last job position and duties in the space provided."); 
  document.resumeInfo.res_comp_job_duties1.value == "";     
  document.resumeInfo.res_comp_job_duties1.focus();  
  Error = 1 ;
  document.resumeInfo.submit_btn.disabled = false;	
  return false  
  }     
  
if (document.resumeInfo.res_comp_location1.value == "1")
  {
  alert("Please select a state from the list.");
  document.resumeInfo.res_comp_location1.focus();
  document.resumeInfo.submit_btn.disabled = false; 
  Error = 1;
  return false
  }  
if (document.resumeInfo.res_comp_location1.value == "2")
  {
  alert("Please select a province from the list.");
  document.resumeInfo.res_comp_location1.focus();
  document.resumeInfo.submit_btn.disabled = false; 
  Error = 1;
  return false
  } 
if (document.resumeInfo.res_comp_location1.value == "3")
  {
  alert("Please select a country from the list.");
  document.resumeInfo.res_comp_location1.focus();
  document.resumeInfo.submit_btn.disabled = false; 
  Error = 1;
  return false
  }   
    
if (Error != 1)
  {  document.resumeInfo.submit();  }
}
//-->
</script>
<!-- #INCLUDE VIRTUAL = '/includes/meta.asp' -->
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
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
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
                        <form name="resumeInfo" method="post" action="doThirdPage.asp">
                          <table width="95%" border="0" cellspacing="0" cellpadding="4">
                            <tr> 
                              <td colspan="4" class="resTitle">Step 3 of 5 - EDIT WORK HISTORY:</td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr bgcolor="#E7E7E7"> 
                              <td colspan="4"> <font size="2"><b>Job One (Last 
                                or Present Job)</b></font></td>
                            </tr>
                            <tr> 
                              <td>Company Name:</td>
                              <td> 
                                <input type="text" name="res_comp_name1" value="<%=rsResume("res_comp_name1")%>"  size="31" maxlength="125">
                              </td>
                              <td>City:</td>
                              <td><input type="text" name="res_comp_city1" value="<%=rsResume("res_comp_city1")%>" maxlength="50">
                              </td>
                            </tr>
							<tr>
								<td>State / Country:</td>
								<td>
						<SELECT NAME="res_comp_location1">
<%
dim rsLoc1, sqlLoc1
sqlLoc1 = "SELECT loc_id, loc_code, loc_name FROM tbl_locations"
set rsLoc1 = Connect.Execute(sqlLoc1)			
				 do while not rsLoc1.eof %>
						<OPTION	VALUE="<%= rsLoc1("loc_code")%>"<% if rsResume("res_comp_location1") = rsLoc1("loc_code") then %>SELECTED <% End if %>> <%=rsLoc1("loc_name") %></OPTION>
<% rsLoc1.MoveNext
loop
set rsLoc1 = Nothing
%>	
				
						</SELECT>										
								</td>
							</tr>
                            <tr> 
                              <td> Job Title:</td>
                              <td colspan="3"> 
                                <input type="text" name="res_comp_job_title1" size="50" value="<%=rsResume("res_comp_job_title1")%>" maxlength="125">
                              </td>
                            </tr>
                            <tr> 
                              <td>Start Date:</td>
                              <td><input type="text" name="res_comp_start_date1" value="<%=rsResume("res_comp_start_date1")%>" size="10" maxlength="10">
    <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<input type=button onclick='popUpCalendar(this, resumeInfo.res_comp_start_date1, \"mm/dd/yyyy\")' value='select date' style='font-size:11px'>")
							}
						//-->
	</script>
                              </td>
                              <td>End Date:</td>
                              <td><input type="text" name="res_comp_end_date1" value="<%=rsResume("res_comp_end_date1")%>" size="10" maxlength="10">
    <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<input type=button onclick='popUpCalendar(this, resumeInfo.res_comp_end_date1, \"mm/dd/yyyy\")' value='select date' style='font-size:11px'>")
							}
						//-->
	</script>
                              </td>
                            </tr>
                            <tr> 
                              <td valign="top">Job Duties:</td>
                              <td colspan="3"> 
                                <textarea name="res_comp_job_duties1" rows="4" cols="50"><%=rsResume("res_comp_job_duties1")%>
</textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr bgcolor="#E7E7E7"> 
                              <td colspan="4"> <font size="2"><b>Job Two</b></font></td>
                            </tr>
                            <tr> 
                              <td>Company Name:</td>
                              <td> 
                                <input type="text" name="res_comp_name2" value="<%=rsResume("res_comp_name2")%>"  size="31" maxlength="125">
                              </td>
                              <td>City:</td>
                              <td><input type="text" name="res_comp_city2" value="<%=rsResume("res_comp_city2")%>" maxlength="50">
                              </td>
                            </tr>
							<tr>
								<td>State / Country:</td>
								<td>
						<SELECT NAME="res_comp_location2">
<%
dim rsLoc2, sqlLoc2
sqlLoc2 = "SELECT loc_id, loc_code, loc_name FROM tbl_locations"
set rsLoc2 = Connect.Execute(sqlLoc2)			
				 do while not rsLoc2.eof %>
						<OPTION	VALUE="<%= rsLoc2("loc_code")%>"<% if rsResume("res_comp_location2") = rsLoc2("loc_code") then %>SELECTED <% End if %>> <%=rsLoc2("loc_name") %></OPTION>
<% rsLoc2.MoveNext
loop
set rsLoc2 = Nothing
%>	
				
						</SELECT>										
								</td>
							</tr>
                            <tr> 
                              <td> Job Title:</td>
                              <td colspan="3"> 
                                <input type="text" name="res_comp_job_title2" size="50" value="<%=rsResume("res_comp_job_title2")%>" maxlength="125">
                              </td>
                            </tr>
                            <tr> 
                              <td>Start Date:</td>
                              <td><input type="text" name="res_comp_start_date2" value="<%=rsResume("res_comp_start_date2")%>" size="10" maxlength="10">
    <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<input type=button onclick='popUpCalendar(this, resumeInfo.res_comp_start_date2, \"mm/dd/yyyy\")' value='select date' style='font-size:11px'>")
							}
						//-->
	</script>
                              </td>
                              <td>End Date:</td>
                              <td><input type="text" name="res_comp_end_date2" value="<%=rsResume("res_comp_end_date2")%>" size="10" maxlength="10">
    <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<input type=button onclick='popUpCalendar(this, resumeInfo.res_comp_end_date2, \"mm/dd/yyyy\")' value='select date' style='font-size:11px'>")
							}
						//-->
	</script>
                              </td>
                            </tr>
                            <tr> 
                              <td valign="top">Job Duties:</td>
                              <td colspan="3"> 
                                <textarea name="res_comp_job_duties2" rows="4" cols="50"><%=rsResume("res_comp_job_duties2")%>
</textarea>
                              </td>
                            </tr>                            
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr bgcolor="#E7E7E7"> 
                              <td colspan="4"> <font size="2"><b>Job Three</b></font></td>
                            </tr>
                            <tr> 
                              <td>Company Name:</td>
                              <td> 
                                <input type="text" name="res_comp_name3" value="<%=rsResume("res_comp_name3")%>" size="31" maxlength="125">
                              </td>
                              <td>City:</td>
                              <td><input type="text" name="res_comp_city3" value="<%=rsResume("res_comp_city3")%>" maxlength="50">
                              </td>
                            </tr>
							<tr>
								<td>State / Country:</td>
								<td>
						<SELECT NAME="res_comp_location3">
<%
dim rsLoc3, sqlLoc3
sqlLoc3 = "SELECT loc_id, loc_code, loc_name FROM tbl_locations"
set rsLoc3 = Connect.Execute(sqlLoc3)			
				 do while not rsLoc3.eof %>
						<OPTION	VALUE="<%= rsLoc3("loc_code")%>"<% if rsResume("res_comp_location3") = rsLoc3("loc_code") then %>SELECTED <% End if %>> <%=rsLoc3("loc_name") %></OPTION>
<% rsLoc3.MoveNext
loop
rsLoc3.Close
set rsLoc3 = Nothing
%>	
				
						</SELECT>										
								</td>
							</tr>
                            <tr> 
                              <td> Job Title:</td>
                              <td colspan="3"> 
                                <input type="text" name="res_comp_job_title3" size="50" value="<%=rsResume("res_comp_job_title3")%>" maxlength="125">
                              </td>
                            </tr>
                            <tr> 
                              <td>Start Date:</td>
                              <td><input type="text" name="res_comp_start_date3" value="<%=rsResume("res_comp_start_date3")%>" size="10" maxlength="10">
    <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<input type=button onclick='popUpCalendar(this, resumeInfo.res_comp_start_date3, \"mm/dd/yyyy\")' value='select date' style='font-size:11px'>")
							}
						//-->
	</script>
                              </td>
                              <td>End Date:</td>
                              <td><input type="text" name="res_comp_end_date3" value="<%=rsResume("res_comp_end_date3")%>" size="10" maxlength="10">
    <script language="javascript">
						<!--
							if (!document.layers) {
								document.write("<input type=button onclick='popUpCalendar(this, resumeInfo.res_comp_end_date3, \"mm/dd/yyyy\")' value='select date' style='font-size:11px'>")
							}
						//-->
	</script>
                              </td>
                            </tr>
                            <tr> 
                              <td valign="top">Job Duties:</td>
                              <td colspan="3"> 
                                <textarea name="res_comp_job_duties3" rows="4" cols="50"><%=rsResume("res_comp_job_duties3")%>
</textarea>
                              </td>
                            </tr>                            
                            <tr> 
                              <td> 
                                <input type="hidden" name="num" value="<%=request("num")%>">
                              </td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td> 
                                <input type="button" name="submit_btn" onClick="checkForm();" value="Save & Continue">
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
