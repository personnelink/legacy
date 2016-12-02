<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->

<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_categories.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		editJob.asp
'		Description:	Single form page for user-defined changes to a job_id
'		Created:		Monday, February 16, 2004
'		LastMod:		Thursday, March 04, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************

dim rsEditJob, sqlEditJob
sqlEditJob = "SELECT job_id, emp_id, job_category, job_title, job_type, job_salary, job_company_name, job_city, job_location, job_number, job_is_deleted, job_view_count, job_date_created, job_description FROM tbl_jobs WHERE job_id= " & request("id") & " AND emp_id = " & session("empID")

Set rsEditJob = Connect.Execute(sqlEditJob)

dim job_category		:	job_category = rsEditJob("job_category")
dim job_title			:	job_title = rsEditJob("job_title")
dim job_type			:	job_type = rsEditJob("job_type")
dim job_salary			:	job_salary = rsEditJob("job_salary")
dim job_company_name	:	job_company_name = rsEditJob("job_company_name")
dim job_city			:	job_city = rsEditJob("job_city")
dim job_location		:	job_location = rsEditJob("job_location")
dim job_date_created	:	job_date_created = rsEditJob("job_date_created")
dim job_description		:	job_description = rsEditJob("job_description")

rsEditJob.Close
Set rsEditJob = Nothing

%>


<html>
<head>
<title>Edit Job Listing - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<script language="javascript">
<!--
function MM_goToURL() {
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->

function checkForm() {

var isGood = true
document.frmEditJob.submit_btn.disabled = true;	

  if (IsBlank(document.frmEditJob.job_title.value))
    {  alert("Enter the title for this job."); 
    document.frmEditJob.job_title.value = "";		
	document.frmEditJob.job_title.focus();
	document.frmEditJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
		
  if (IsBlank(document.frmEditJob.job_company_name.value))
    {  alert("Enter the name of the company/employer to which this jobs pertains."); 
    document.frmEditJob.job_company_name.value = "";		
	document.frmEditJob.job_company_name.focus();
	document.frmEditJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	

  if (IsBlank(document.frmEditJob.job_city.value))
    {  alert("Please enter a city."); 
	document.frmEditJob.job_city.focus();
	document.frmEditJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}				 			
	
  if (document.frmEditJob.job_location.value == '1')
    {  alert("Please select a State"); 
	document.frmEditJob.job_location.focus();
	document.frmEditJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
  if (document.frmEditJob.job_location.value == '2')
    {  alert("Please select a Province."); 
	document.frmEditJob.job_location.focus();
document.frmEditJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
  if (document.frmEditJob.job_location.value == '3')
    {  alert("Please select a Country"); 
	document.frmEditJob.job_location.focus();
document.frmEditJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	

  if (IsBlank(document.frmEditJob.job_description.value))
    {  alert("Please enter a job description"); 
	document.frmEditJob.job_description.focus();
	document.frmEditJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
		
  if (IsBlank(document.frmEditJob.job_salary.value))
    {  alert("Please enter a salary amount"); 
	document.frmEditJob.job_salary.focus();
	document.frmEditJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}			
				
if (isGood != false)
  {  document.frmEditJob.submit();  }
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
                        <form name="frmEditJob" method="post" action="doEditJob.asp">
                          <input type="hidden" name="id" value="<%=request("id")%>">
                          <table width="100%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td width="26%" class="req_label">Job Title:
                              </td>
                              <td width="74%"><input type="text" name="job_title" size="66" maxlength="150" value="<%=job_title%>"> </td>
                            </tr>
                            <tr> 
                              <td width="26%" class="req_label">Employer:
                              </td>
                              <td width="74%"><input type="text" name="job_company_name" size="66" maxlength="125" value="<%=job_company_name%>"> </td>
                            </tr>												  

                            <tr> 
                              <td width="26%" class="req_label">Location:</td>
                              <td width="74%">
						<SELECT NAME="job_location">					
				<% do while not rsLoc.eof %>
						<OPTION	VALUE="<%= rsLoc("loc_code")%>"<% if rsLoc("loc_code") = job_location then %>Selected<%end if%>> <%=rsLoc("loc_name") %></OPTION>
					<% rsLoc.MoveNext %>
				<% loop %>	
						</SELECT>						  
							  
							  </td>
                            </tr>							
                            <tr> 
                              <td width="26%" class="req_label">City: </td>
                              <td width="74%"><input type="text" name="job_city" size="30" maxlength="50" value="<%=job_city%>"></td>
                            </tr>
                            <tr> 
                              <td width="26%" class="req_label">Category:</td>
                              <td width="74%">
						<SELECT NAME="job_category">					
				<% do while not rsCat.eof %>
						<OPTION	VALUE="<%= rsCat("cat_name")%>"<% if rsCat("cat_name") = job_category then %>Selected<%end if%>> <%=rsCat("cat_name") %></OPTION>
					<% rsCat.MoveNext %>
				<% loop %>	
						</SELECT>							  
							  </td>
                            </tr>
                            <tr> 
                              <td width="26%" class="req_label" valign="top">Description:
                              </td>
                              <td width="74%"><textarea name="job_description" cols="50" rows="11"><%=job_description%></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="26%" class="req_label">Postion Type:
                              </td>
                              <td width="74%"> 
<input type="radio" name="job_type" value="PT" <%if job_type="PT" then%>CHECKED<%end if%>>
Part Time 
<input type="radio" name="job_type" value="FT" <%if job_type="FT" then%>CHECKED<%end if%>>
Full time 
<input type="radio" name="job_type" value="FP" <%if job_type="FP" then%>CHECKED<%end if%>>
Both Part and Full Time
<input type="radio" name="job_type" value="CT" <%if job_type="CT" then%>CHECKED<%end if%>>
Contractor
</td>
                            </tr>
                            <tr> 
                              <td width="26%" class="req_label">Salary:
                              </td>
                              <td width="74%"> 
                                <input type="text" name="job_salary" value="<%=job_salary%>" size="25" maxlength="25">
                              </td>
                            </tr>
                            <tr> 
                              <td width="26%" class="req_label">Date Posted:
                              </td>
                              <td width="74%"><%=FormatDateTime(job_date_created,0)%>
                              </td>
                            </tr>							
                            <tr> 
                              <td width="26%">&nbsp;</td>
                              <td width="74%"> 
<input type="button" value="Save Changes" name="submit_btn" onClick="checkForm();">&nbsp;&nbsp;&nbsp;
<input type="button" value="Cancel" onClick="MM_goToURL('parent','index.asp');return document.MM_returnValue" name="button">
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
