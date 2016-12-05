<%response.buffer=true%>
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkMbrAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_categories.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->

<%
' A job may have been deleted by the employer while the job seeker was performing this search.
' Redirect job seekers if this has happened.
dim rsJ, sqlJ, numJ
sqlJ = "SELECT COUNT(job_id) as numCounted FROM tbl_jobs WHERE job_id = " & request("id") & " AND job_is_deleted = '0'"
Set rsJ = Connect.Execute(sqlJ)
numJ = rsJ("numCounted")
Set rsJ = Nothing

if numJ = 0 then
  response.redirect("noJob.asp?id=" & request("id"))
end if


' // Get Job Info
dim rsJob, sqlJob
sqlJob = "SELECT job_id, emp_id, job_category, job_title, job_type, job_salary, job_company_name, job_city, job_location, job_number, job_is_deleted, job_view_count, job_date_created, job_description FROM tbl_jobs WHERE job_id= " & Request("id")

Set rsJob = Server.CreateObject("ADODB.RecordSet")
rsJob.CursorLocation = 3
rsJob.Open(sqlJob),Connect
dim job_id			:	job_id = rsJob("job_id")
dim emp_id			:	emp_id = rsJob("emp_id")
dim job_category		:	job_category = rsJob("job_category")
dim job_title			:	job_title = rsJob("job_title")
dim job_type			:	job_type = rsJob("job_type")
dim job_salary			:	job_salary = rsJob("job_salary")
dim job_company_name	:	job_company_name = rsJob("job_company_name")
dim job_city			:	job_city = rsJob("job_city")
dim job_location		:	job_location = rsJob("job_location")
dim job_number			:	job_number = rsJob("job_number")
dim job_view_count		:	job_view_count = rsJob("job_view_count")
dim job_date_created	:	job_date_created = rsJob("job_date_created")
dim job_description		:	job_description = rsJob("job_description")
rsJob.Close
Set rsJob = Nothing

' // Get Employer Info
dim rsEmpInfo, sqlEmpInfo
sqlEmpInfo = "SELECT emp_id, emp_email_address, emp_url, emp_company_profile FROM tbl_employers WHERE emp_id= " & emp_id
Set rsEmpInfo = Server.CreateObject("ADODB.RecordSet")
rsEmpInfo.CursorLocation = 3
rsEmpInfo.Open(sqlEmpInfo),Connect
dim tmp_emp_url				:	tmp_emp_url = rsEmpInfo("emp_url")
dim tmp_emp_profile			:	tmp_emp_profile = rsEmpInfo("emp_company_profile")
dim tmp_emp_email_address	:	tmp_emp_email_address = rsEmpInfo("emp_email_address")
rsEmpInfo.Close
Set rsEmpInfo = Nothing

' Insert HTML line breaks
dim txtJobDesc
txtJobDesc = Replace((job_description),vbCrLf,"<BR>")

' // Get Verbose Location
dim tmp_loc_code	:	tmp_loc_code = job_location
set rsLocName = Server.CreateObject("ADODB.RecordSet")
rsLocName.CursorLocation = 3
rsLocName.Open "SELECT loc_id, loc_code, loc_name FROM tbl_locations WHERE loc_code = '" & tmp_loc_code &"'",Connect
dim loc_name		:	loc_name = rsLocName("loc_name")
rsLocName.Close
Set rsLocName = Nothing

' // Increment job view count
dim rsUpCount, sqlUpCount
sqlUpCount = "UPDATE tbl_jobs SET job_view_count = job_view_count + 1 WHERE job_id= " & job_id
set rsUpCount = Connect.Execute(sqlUpCount)
set rsUpCount = Nothing
%>
<html>
<head>
<title>View Job Details - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript">
function backToSearch()
{
window.location = "/registered/logged/index.asp"; 
}

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
                      <td><img src="/images/headers/searchJobsOnline.gif" width="328" height="48"></td>
                    </tr>
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="30" class="sideMenu"><img src="/images/pixel.gif" width="30" height="8"></td>
                            <td valign="bottom"></td>
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
                            <td width="30"><img src="/images/pixel.gif" width="30" height="8"></td>
                            <td class="sideMenu" valign="bottom">
                              <form name="frmApply" method="post" action="apply.asp">
                                <table width="90%" border="0" cellspacing="0" cellpadding="5">
                                  <tr> 
                                    <td width="26%" nowrap><strong>Job Title</strong>:</td>
                                    <td width="79%" class="jobTitle"><%=job_title%></td>
                                  </tr>								
                                  <tr> 
                                    <td width="26%" nowrap><strong>Company / Agency</strong>:</td>
                                    <td width="79%"><%=job_company_name%> 
                                      <input type="hidden" name="jobID" value="<%=job_id%>">
                                      <input type="hidden" name="jobTitle" value="<%=job_title%>">
									  <input type="hidden" name="locName" value="<%=loc_name%>">								  								  
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="26%" nowrap><strong>Category</strong>:</td>
                                    <td width="79%"> <%=job_category%></td>
                                  </tr>
                                  <tr> 
                                    <td width="26%" nowrap><strong>Location</strong>:</td>
                                    <td width="79%"><%=job_city%>, <%=loc_name%></td>
                                  </tr>
                                  <tr> 
                                    <td width="26%" valign="top" nowrap><strong>Description</strong>:
                                    </td>
                                    <td width="79%"> <%=txtJobDesc%></td>
                                  </tr>
                                  <tr> 
                                    <td width="26%" nowrap><strong>Position Type:</strong>
                                    </td>
                                    <td width="79%"> 
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
                                    <td width="26%" nowrap><strong>Salary</strong>:
                                    </td>
                                    <td width="79%"> <%=job_salary%></td>
                                  </tr>
                                  <tr> 
                                    <td width="26%" nowrap><strong>Job Posted On</strong>:
                                    </td>
                                    <td width="79%"> <%=FormatDateTime(job_date_created,1)%> at <%=FormatDateTime(job_date_created,3)%> PST</td>
                                  </tr>								  
                                  <tr> 
                                    <td width="26%">&nbsp;</td>
                                    <td width="79%">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2"> 
<% if request("confirm") = 1 then %>	
<strong><font color="#b22222">Your application for this position was successfully delivered!</font></strong>
<br>
A copy of your application has also been emailed to you at <%=session("emailAddress")%>.
<p></p><input type="button" name="Button" value="Click here to continue..." onClick="backToSearch();">
<% Else %>	
<input type="submit" name="Submit" value="Apply for <%=job_title%>">
<% End if %>	
<br>
<br>
<img src="/images/tell_a_friend.gif" alt="Tell a friend about this job" width="150" height="25" border="0" onClick="JavaScript:openWin();" class="hand">
<br>
<script language="JavaScript" type="text/javascript">
<!--
function openWin() {
	window.open("/registered/logged/search/tellFriend.asp?id=<%=job_id%>&jLoc=<%=loc_name%>&sEmail=<%=session("emailAddress")%>", "taf", "toolbar=0,location=0,directories=0,status=0,menubar=no,scrollbars=no,resizable=no,width=400,height=412");
}
//-->
</script>
								
                                      
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
<%
Connect.Close
Set Connect = Nothing
%>
</body>
</html>
