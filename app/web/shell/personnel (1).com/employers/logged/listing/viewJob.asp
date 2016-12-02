<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->
<%
dim rsViewJob, sqlListings
sqlListings = "SELECT job_id, emp_id, job_category, job_title, job_type, job_salary, job_company_name, job_city, job_location, job_number, job_is_deleted, job_view_count, job_date_created, job_description FROM tbl_jobs WHERE job_id = " & Request("id") & " AND emp_id = " & session("empID")
Set rsViewJob = Server.CreateObject("ADODB.RecordSet")
rsViewJob.CursorLocation = 3
rsViewJob.Open(sqlListings),Connect
dim job_category		:	job_category = rsViewJob("job_category")
dim job_title			:	job_title = rsViewJob("job_title")
dim job_type			:	job_type = rsViewJob("job_type")
dim job_salary			:	job_salary = rsViewJob("job_salary")
dim job_company_name	:	job_company_name = rsViewJob("job_company_name")
dim job_city			:	job_city = rsViewJob("job_city")
dim job_location		:	job_location = rsViewJob("job_location")
dim job_number			:	job_number = rsViewJob("job_number")
dim job_view_count		:	job_view_count = rsViewJob("job_view_count")
dim job_date_created	:	job_date_created = rsViewJob("job_date_created")
dim job_description		:	job_description = rsViewJob("job_description")

rsViewJob.Close
Set rsViewJob = Nothing

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
<title>View Job Listing - www.personnel.com</title>
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
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="8"></td>
                      <td>
                        <table width="90%" border="0" cellspacing="0" cellpadding="5">
                          <tr> 
                            <td width="32%" class="req_label">Job Title:
                            </td>
                            <td width="68%" valign="top" class="jobTitle"> <%=job_title%></td>
                          </tr>						
                          <tr> 
                            <td width="32%" class="req_label">Employer:</td>
                            <td width="68%" valign="top"> <%=job_company_name%></td>
                          </tr>	
                          <tr> 
                            <td width="32%" class="req_label">Location:</td>
                            <td width="68%" valign="top"><%=job_city%>, <%=tmp_loc_name%></td>
                          </tr>						  					
                          <tr> 
                            <td width="32%" class="req_label">Category:</td>
                            <td width="68%" valign="top"> <%=job_category%></td>
                          </tr>
                          <tr> 
                            <td width="32%" valign="top" class="req_label">Description:
                            </td>
                            <td width="68%" valign="top"> <%=job_description%></td>
                          </tr>
                          <tr> 
                            <td width="32%" class="req_label">Postion Type:
                            </td>
                            <td width="68%"> 
                              <%
	Select Case job_type
	  Case "FP"
	    response.write("Full-Time or Part-Time")
	  Case "FT"
	    response.write("Full-Time")
	  Case "PT"
	    response.write("Part-Time")
	  Case "CT"
	    response.write("Contractor")		
	End Select
	%>
                            </td>
                          </tr>
                          <tr> 
                            <td width="32%" valign="top" class="req_label">Salary:
                            <td width="68%" valign="top"> <%=job_salary%></td>
                          </tr>
                          <tr> 
                            <td width="32%" valign="top" class="req_label">Posted:
                            <td width="68%" valign="top"><%=FormatDateTime(job_date_created,0)%></td>
                          </tr>						  
                        </table>
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
