<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->
<%
dim tmp_location	:	tmp_location = Request("locName")

' // Get Job Info
dim rsJob, sqlJob
Set rsJob = Server.CreateObject("ADODB.RecordSet")
rsJob.CursorLocation = 3
sqlJob = "SELECT job_id, emp_id, job_category, job_title, job_type, job_salary, job_company_name, job_city, job_location, job_number, job_is_deleted, job_view_count, job_date_created, job_description FROM tbl_jobs WHERE job_id=" & Request("jobID")
rsJob.Open(sqlJob),Connect
dim job_id				:	job_id = rsJob("job_id")
dim emp_id				:	emp_id = rsJob("emp_id")
dim job_category		:	job_category = rsJob("job_category")
dim job_title			:	job_title = rsJob("job_title")
dim job_type			:	job_type = rsJob("job_type")
dim job_salary			:	job_salary = rsJob("job_salary")
dim job_company_name	:	job_company_name = rsJob("job_company_name")
dim job_city			:	job_city = rsJob("job_city")
dim job_location		:	job_location = rsJob("job_location")
dim job_number			:	job_number = rsJob("job_number")
dim job_is_deleted		:	job_is_deleted = rsJob("job_is_deleted")
dim job_view_count		:	job_view_count = rsJob("job_view_count")
dim job_date_created	:	job_date_created = rsJob("job_date_created")
dim job_description		:	job_description = rsJob("job_description")
rsJob.Close
Set rsJob = Nothing


' // Count Resumes
dim rsRes, sqlRes, rsCountRes, sqlCountRes, numRes
sqlCountRes = "SELECT COUNT(res_id) as number FROM tbl_resumes WHERE mbr_id=" & session("mbrID") & " AND res_completion_flag = 5 AND res_is_deleted = 0"
Set rsCountRes = Connect.Execute(sqlCountRes)
numRes = rsCountRes("number")
if numRes > 0 then
sqlRes = "SELECT res_id, res_title FROM tbl_resumes WHERE res_completion_flag = 5 AND mbr_id=" & session("mbrID") & " AND res_is_deleted = 0"
Set rsRes = Connect.Execute(sqlRes)
end if
%>

<html>
<head>
<title>Job Applications - Choose a Resume - www.personnel.com</title>

<script language="javaScript">
function checkForm()
{
document.pickResume.submit_btn.disabled = true;
Error = 0;
if (document.pickResume.resID.value == 'null')
  {  Error = 1; alert("Please select a resume.");  
	document.pickResume.submit_btn.disabled = false;  
  }

if (Error != 1)
  {  document.pickResume.submit();  }
}
</script>
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
                      <td><img src="/images/headers/searchJobsOnline.gif" width="328" height="48"></td>
                    </tr>
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="30" class="sideMenu"><img src="/images/pixel.gif" width="30" height="1"></td>
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
                        <form name="pickResume" method="post" action="doApply.asp">
                          <table width="90%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td width="26%"><b>Job Title:</b></td>
                              <td colspan="2" class="jobTitle"><%=job_title%>&nbsp;&nbsp; 
                                <font color="#808080" size="2">[# <%=job_number%>]</font></td>
                            </tr>						  
                            <tr> 
                              <td width="26%"><b>Company / Agency:</b></td>
                              <td colspan="2"><%=job_company_name%></td>
                            </tr>
                            <tr> 
                              <td width="26%"><b>Category:</b></td>
                              <td colspan="2"><%=job_category%></td>
                            </tr>								
                            <tr> 
                              <td width="26%"><b>Location:</b></td>
                              <td colspan="2"><%=job_city%>, <%=tmp_location%></td>
                            </tr>							

                            <tr> 
                              <td width="26%" valign="top"><b>Description:</b></td>
                              <td colspan="2"><%=job_description%></td>
                            </tr>
                            <tr> 
                              <td width="26%"><b>Position Type:</b></td>
                              <td colspan="2">
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
                              <td width="26%"><b>Salary:</b></td>
                              <td colspan="2"><%=job_salary%></td>
                            </tr>															
                            <tr> 
                              <td width="26%" nowrap><strong>Job Posted On</strong>:</td>
                              <td width="79%"> <%=FormatDateTime(job_date_created,1)%> at <%=FormatDateTime(job_date_created,3)%> PST</td>
                            </tr>					
                            <tr> 
                              <td colspan="3"> 
                                <hr noshade color="#CCCCCC" size="1">
                              </td>
                            </tr>
                            <% if numRes = 0 then %>
                            <tr> 
                              <td valign="top" width="26%"><b>Apply Online:</b></td>
                              <td colspan="2" valign="top"> <b><font color="#FF0000">NOTE: 
                                </font></b>You have not completed an online resume. You will be unable to apply for jobs until you 
                                create a new resume using the <a href="../resume/index.asp">Resume 
                                Center</a>. </td>
                            </tr>
                            <tr> 
                              <td width="26%">&nbsp;</td>
                              <td colspan="2">&nbsp;</td>
                            </tr>					
							<% Else %>
                            <tr> 
                              <td width="26%"><b>Apply Online: 
                                </b></td>
                              <td colspan="2"><font size="2">Choose 
                                a resume below for your job application:</font></td>
                            </tr>
                            <tr> 
                              <td width="26%">
                                <input type="hidden" name="jobID" value="<%=job_id%>">
                                <input type="hidden" name="empID" value="<%=emp_id%>">
                                <input type="hidden" name="jobTitle" value="<%=job_title%>">	
                                <input type="hidden" name="jobNumber" value="<%=job_number%>">		
                                <input type="hidden" name="jobCity" value="<%=job_city%>">	
                                <input type="hidden" name="jobLocation" value="<%=job_location%>">																							
                              </td>
                              <td width="41%">
                                <select name="resID">
                                  <option value="null" selected>- Choose a Resume 
                                  -</option>
                                  <% Do Until rsRes.eof%>
                                  <option value="<%=rsRes("res_id")%>"><%=rsRes("res_title")%></option>
                                  <%
								  rsRes.MoveNext
								  loop 
								  rsRes.Close
								  Set rsRes = Nothing
								  %>
                                </select>
                              </td>
                              <td width="33%">					   
<input type="button" name="submit_btn" value="Apply Now!" onClick="checkForm();">							
                              </td>
                            </tr>
							<% End if %>
							<% if request("error") = "2" then %>
							<tr>
								<td colspan="3">There was a problem locating your resume. Please verify that you have completed an online resume and try again.</td>
							</tr>
							<% end if%>
                            <tr> 
                              <td width="26%">&nbsp; </td>
                              <td width="41%"><br><br>
                              </td>
                              <td width="33%">&nbsp;</td>
                            </tr>

                            <tr> 
                              <td width="26%"><img src="/images/pixel.gif" width="135" height="20"></td>
                              <td colspan="2"> 
                                <table border="0" cellspacing="0" cellpadding="0">
                                  <tr align="center"> 
                                    <td> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td align="left" width="10"><img src="/images/buttonL.gif" width="10" height="21"></td>
                                          <td bgcolor="#5187CA" align="center" nowrap class="buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a href="../resume/newResume/index.asp" class="buttons">Add 
                                            a New Resume</a>&nbsp;&nbsp;&nbsp;&nbsp; 
                                          </td>
                                          <td align="right" width="10"><img src="/images/buttonR.gif" width="10" height="21"></td>
                                        </tr>
                                      </table>
                                    </td>
                                    
                                    <td><img src="/images/pixel.gif" width="15" height="10"> 
                                    </td>
                                    <td> 
                                      <table border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td align="left" width="10"><img src="/images/buttonL.gif" width="10" height="21"></td>
                                          <td bgcolor="#5187CA" align="center" nowrap class="buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a href="../resume/index.asp" class="buttons">Resume 
                                            Center </a>&nbsp;&nbsp;&nbsp;&nbsp; 
                                          </td>
                                          <td align="right" width="10"><img src="/images/buttonR.gif" width="10" height="21"></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                </table>
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
Set rsCountRes = Nothing
Connect.Close
Set Connect = Nothing
%>
