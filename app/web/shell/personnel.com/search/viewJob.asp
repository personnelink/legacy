<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->

<%
dim rsJobs, rsLocName, jobCount
set rsJobs = Server.CreateObject("ADODB.RecordSet")
rsJobs.CursorLocation = 3
rsJobs.Open "SELECT job_id, emp_id, job_category, job_title, job_type, job_salary, job_company_name, job_city, job_location, job_number, job_is_deleted, job_view_count, job_date_created, job_description FROM tbl_jobs WHERE job_id = " & request("id"),Connect

' // Redirect if recordset is empty or job has been deleted
if rsJobs.RecordCount = 0 or rsJobs("job_is_deleted") <> "0" then
  response.redirect("noJob.asp?id=" & request("id"))
end if

' // Insert HTML line breaks
dim txtJobDesc
txtJobDesc = Replace(rsJobs("job_description"),vbCrLf,"<BR>")

' // Get verbose location name
dim tmp_loc_code		:	tmp_loc_code = rsJobs("job_location")
set rsLocName = Server.CreateObject("ADODB.RecordSet")
rsLocName.CursorLocation = 3
rsLocName.Open "SELECT loc_code, loc_name FROM tbl_locations WHERE loc_code = '" & tmp_loc_code &"'",Connect
dim tmp_loc_name		: tmp_loc_name = rsLocName("loc_name")
rsLocName.Close
Set rsLocName = Nothing

' // Increment job view count
dim rsUpCount, sqlUpCount
sqlUpCount = "UPDATE tbl_jobs SET job_view_count = job_view_count + 1 WHERE job_id= " & Request("id")
set rsUpCount = Connect.Execute(sqlUpCount)
set rsUpCount = Nothing

' // remember/update job id and title every time this page is executed
session("jobID") = rsJobs("job_id")
session("jobTitle") = rsJobs("job_title")

%>
<html>
<head>
<title>View Job Details - www.personnel.com</title>
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
        <tr> 
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
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_srn_w.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <!-- #INCLUDE VIRTUAL='/includes/menu.asp' -->
          </td>
          <td width="175" bgcolor="#000000">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" bgcolor="#E7E7E7"> 
            <!--#include virtual="/includes/pub_greybar.asp" -->
          </td>
          <td rowspan="2" valign="top"> 
            <!-- #INCLUDE VIRTUAL='/includes/pub_menu.asp' -->
          </td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="/images/headers/searchJobsOnline.gif" width="328" height="48"></td>
                    </tr>
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="30" class="sideMenu"><img src="/images/pixel.gif" width="30" height="8"></td>
                            <td class="sideMenu" valign="bottom">&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="30" class="sideMenu"><img src="/images/pixel.gif" width="30" height="8"></td>
                            <td valign="bottom"> 
                              <table width="90%" border="0" cellspacing="0" cellpadding="5">
                                <tr valign="top"> 
                                  <td width="26%" class="req_label">Job Title:
                                  </td>
                                  <td width="79%" class="jobTitle"> <%=rsJobs("job_title")%></td>
                                </tr>
                                <tr valign="top"> 
                                  <td width="26%" class="req_label">Company:
                                  </td>
                                  <td width="79%"> <%=rsJobs("job_company_name")%></td>
                                </tr>								
                                <tr valign="top"> 
                                  <td width="26%" class="req_label">Location:</td>
                                  <td width="79%"><%=rsJobs("job_city")%>, <%=tmp_loc_name%></td>
                                </tr>

                                <tr valign="top"> 
                                  <td width="26%" class="req_label">Category:</td>
                                  <td width="79%"> <%=rsJobs("job_category")%></td>
                                </tr>								
                                <tr valign="top"> 
                                  <td width="26%" class="req_label">Description:
                                  </td>
                                  <td width="79%"> <%=txtJobDesc%></td>
                                </tr>
                                <tr valign="top"> 
                                  <td width="26%" class="req_label">Postion Type:
                                  </td>
                                  <td width="79%"> 
<%
	Select Case rsJobs("job_type")
	  Case "FP"
	    response.write("Full Time or Part Time")
	  Case "FT"
	    response.write("Full Time")
	  Case "PT"
	    response.write("Part Time")
	  Case "CT"
	    response.write("Contractor")		
	End Select
%>
                                  </td>
                                </tr>
                                <tr valign="top"> 
                                  <td width="26%" class="req_label">Salary:
                                  </td>
                                  <td width="79%"> <%=rsJobs("job_salary")%></td>
                                </tr>	
                                  <tr> 
                                    <td width="26%" class="req_label">Job Posted:
                                    </td>
                                    <td width="79%"> <%=FormatDateTime(rsJobs("job_date_created"),2)%></td>
                                  </tr>														
                              </table>
                              <p><b><font size="3">Apply for this Job:</b>
                              To apply for this job you must 
                                login first</font>.</p> 
<table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td align="left" width="10"><img src="/images/buttonL.gif" width="10" height="21"></td>
                                  <td bgcolor="#5187CA" align="center" nowrap class="buttons">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/registered/login.asp" class="buttons">Member 
                                    Login</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                  <td align="right" width="10"><img src="/images/buttonR.gif" width="10" height="21"></td>
                                </tr>
                              </table>	
							  <p>
Not a member yet?
                                <a href="/registered/newuser/index.asp"><b><font size="2">Create a free account</font></b></a>!							  
							  </p>							
                              </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>

                </td>
              </tr>
            </table>
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
rsJobs.Close
Set rsJobs = Nothing
Connect.Close
Set Connect = Nothing
%>
</body>
</html>
