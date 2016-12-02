<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		deleteJob.asp
'		Description:	Display-only page for a single job_id. Allows employer the option to review the job information before choosing to delete.
'						the record 
'		Created:		Monday, February 16, 2004
'		LastMod:
'		Developer(s):	James Werrbach
'	**********************************************************************

dim rsListing, sqlListing
sqlListing = "SELECT job_id, emp_id, job_category, job_title, job_type, job_salary, job_company_name, job_city, job_location, job_number, job_is_deleted, job_view_count, job_date_created, job_description FROM tbl_jobs WHERE job_id= " & request("id") & " AND emp_id = " & session("empID")
Set rsListing = Connect.Execute(sqlListing)

dim job_category		:	job_category = rsListing("job_category")
dim job_title			:	job_title = rsListing("job_title")
dim job_type			:	job_type = rsListing("job_type")
dim job_salary			:	job_salary = rsListing("job_salary")
dim job_company_name	:	job_company_name = rsListing("job_company_name")
dim job_city			:	job_city = rsListing("job_city")
dim job_location		:	job_location = rsListing("job_location")
dim job_date_created	:	job_date_created = rsListing("job_date_created")
dim job_description		:	job_description = rsListing("job_description")

'rsListing.Close
Set rsListing = Nothing

dim rs,sql,tmp_loc_name
sql = "SELECT loc_id, loc_code, loc_name FROM tbl_locations WHERE loc_code = '" & job_location & "'"
Set rs = Server.CreateObject("ADODB.RecordSet")
rs.CursorLocation = 3
rs.Open(sql),Connect
tmp_loc_name = rs("loc_name")
rs.Close
Set rs = Nothing
%>
<html>
<head>
<title>Delete Job Listing - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="JavaScript">
<!--
function MM_goToURL() { 
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
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
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_hms.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <!-- #INCLUDE VIRTUAL='/includes/menu.asp' -->
          </td>
          <td width="175">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="E7E7E7"> 
                <td> 
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
                      <td><img src="/images/headers/jobListingsManager.gif" width="328" height="48"></td>
                    </tr>
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="30" class="sideMenu">&nbsp;</td>
                            <td class="sideMenu" valign="bottom">&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="8"></td>
                      <td>
                        <form action="doDeleteJob.asp">
                          <p> 
                            <input type="hidden" name="id" value="<%=Request("id")%>">
                          </p>
                          <table width="100%" border="0" cellspacing="1" cellpadding="3">
                            <tr> 
                              <td width="30%" class="req_label">Job Title:
                              </td>
                              <td width="70%" class="jobTitle"> <%=job_title%></td>
                            </tr>						  
                            <tr> 
                              <td width="30%" class="req_label">Employer:</td>
                              <td width="70%"> <%=job_company_name%></td>
                            </tr>
                            <tr> 
                              <td width="30%" class="req_label">Location:</td>
                              <td width="70%"><%=job_city%>, <%=tmp_loc_name%></td>
                            </tr>													  
                            <tr> 
                              <td width="30%" class="req_label">Category:</td>
                              <td width="70%"> <%=job_category%></td>
                            </tr>

                            <tr> 
                              <td width="30%" valign="top" class="req_label">Description:
                              </td>
                              <td width="70%"> <%=job_description%></td>
                            </tr>
                            <tr> 
                              <td width="30%" class="req_label">Postion Type:
                              </td>
                              <td width="70%"> 
<%
	Select Case job_type
	  Case "FP"
	    response.write("Full-Time or Part-Time")
	  Case "FT"
	    response.write("Full-Time")
	  Case "PT"
	    response.write("Part-Time")
	End Select
	%>
                              </td>
                            </tr>
                            <tr> 
                              <td width="30%" class="req_label">Salary:
                              </td>
                              <td width="70%"> <%=job_salary%></td>
                            </tr>
                            <tr> 
                              <td width="30%" class="req_label">Posted:
                              </td>
                              <td width="70%"> <%=FormatDateTime(job_date_created,0)%></td>
                            </tr>							
							<tr>
								<td colspan="2"><img src="/images/pixel.gif" width="1" height="10"></td>
							</tr>
                            <tr>
								<td width="30%"><font color="#2f4f4f"><strong>Permanently delete this job?</strong></font></td>
							  <td width="70%" align="left"><input type="button" value="Cancel" onClick="MM_goToURL('parent','index.asp');return document.MM_returnValue" name="button">&nbsp;&nbsp;&nbsp; <input type="submit" value="Delete" name="btn_submit"></td>
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
            <!-- #INCLUDE VIRTUAL='/includes/hms_menu.asp' -->
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
<%
Connect.Close
Set Connect = Nothing	
%>
</body>
</html>
