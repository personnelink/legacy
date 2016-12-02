
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->

<!-- #INCLUDE VIRTUAL='/includes/get_categories.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->
<%
'	*************************  File Description  *************************
'		FileName:		newJob.asp
'		Description:	New job posting form for Employers
'		Created:		Wednesday, March 3, 2004
'		LastMod:		
'		Developer(s):	James Werrbach
'	**********************************************************************
%>
<html>
<head>
<title>Post A New Job - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<script language="javascript">
function checkForm() {

var isGood = true
document.frmNewJob.submit_btn.disabled = true;	

  if (IsBlank(document.frmNewJob.job_company_name.value))
    {  alert("Enter the name of the company/employer to which this jobs pertains."); 
    document.frmNewJob.job_company_name.value = "";		
	document.frmNewJob.job_company_name.focus();
	document.frmNewJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	

  if (IsBlank(document.frmNewJob.job_title.value))
    {  alert("Enter the title for this job."); 
    document.frmNewJob.job_title.value = "";		
	document.frmNewJob.job_title.focus();
	document.frmNewJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	

  if (IsBlank(document.frmNewJob.job_category.value))
    {  alert("Select the closest matching category for this job from the list."); 
	document.frmNewJob.job_category.focus();
	document.frmNewJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
		
  if (IsBlank(document.frmNewJob.job_location.value))
    {  alert("Select the nearest location for this job from the list."); 
	document.frmNewJob.job_location.focus();
	document.frmNewJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}					 			
	
  if (document.frmNewJob.job_location.value == '1')
    {  alert("Please select a State"); 
	document.frmNewJob.job_location.focus();
	document.frmNewJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
  if (document.frmNewJob.job_location.value == '2')
    {  alert("Please select a Province."); 
	document.frmNewJob.job_location.focus();
document.frmNewJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
  if (document.frmNewJob.job_location.value == '3')
    {  alert("Please select a Country"); 
	document.frmNewJob.job_location.focus();
document.frmNewJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
		
  if (IsBlank(document.frmNewJob.job_city.value))
    {  alert("Please specify a city for this job."); 
    document.frmNewJob.job_city.value = "";		
	document.frmNewJob.job_city.focus();
	document.frmNewJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
		
  if (IsBlank(document.frmNewJob.job_description.value))
    {  alert("The job description cannot be left blank."); 
    document.frmNewJob.job_description.value = "";		
	document.frmNewJob.job_description.focus();
	document.frmNewJob.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}					

if (isGood != false)
  {  document.frmNewJob.submit();  }
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
        <tr bgcolor="#EFEFEF"> 
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
              <tr bgcolor="#e7e7e7"> 
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
                            <td width="30">&nbsp;</td>
                            <td valign="bottom">&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
				  	<tr>
						<td colspan="2" align="center" bgcolor="#e7e7e7" class="jobTitle">Post a New Job: enter required information (<strong>bold</strong>) below and click <em>Save</em> when done.</td>
					</tr>
				  	<tr>
						<td colspan="2"><img src="/images/pixel.gif" width="1" height="16"></td>
					</tr>					
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                      <td>
                        <form name="frmNewJob" method="post" action="doNewJob.asp">
                          <table width="90%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td width="24%" align="right" class="req_label">Company/Employer:</td>
                              <td width="76%"><input type="text" name="job_company_name" value="<%=company_name%>" size="66" maxlength="125">
                              </td>
                            </tr>	
                            <tr> 
                              <td width="24%" align="right" class="req_label">Job Title:
                              </td>
                              <td width="76%"> 
                                <input type="text" name="job_title" size="66" maxlength="150">
                              </td>
                            </tr>												  
                            <tr> 
                              <td width="24%" align="right" class="req_label">Category:</td>
                              <td width="76%"> 
						<SELECT NAME="job_category">
                        <option value="" selected>- Select a Job Category -</option>
				<% do while not rsCat.eof %>
						<OPTION	VALUE="<%= rsCat("cat_name")%>"> <%=rsCat("cat_name") %></OPTION>
					<% rsCat.MoveNext %>
				<% loop %>
				<% Set rsCat = Nothing %>				
						</SELECT>
                              </td>
                            </tr>
                            <tr> 
                              <td width="24%" align="right" class="req_label">Location:</td>
                              <td width="76%"> 
						<SELECT NAME="job_location">
                        <option value="" selected>- Select Your Job Location -</option>
				<% do while not rsLoc.eof %>
						<OPTION	VALUE="<%= rsLoc("loc_code")%>"> <%=rsLoc("loc_name") %></OPTION>
					<% rsLoc.MoveNext %>
				<% loop %>
				<% Set rsLoc = Nothing %>
						</SELECT>
                              </td>
                            </tr>
                            <tr> 
                              <td width="24%" align="right" class="req_label">City: </td>
                              <td width="76%"> 
                                <input type="text" name="job_city" size="26" maxlength="50">
                              </td>
                            </tr>
                            <tr> 
                              <td width="24%" align="right" valign="top"><strong>Job Description:</strong><br>
							 <font size="1" class="msgTitle"> (Enter job duties, requirements, and other specifics here)</font>
                              </td>
                              <td width="76%"> 
                                <textarea name="job_description" cols="50" rows="6"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="24%" align="right" class="req_label">Postion Type:
                              </td>
                              <td width="76%"> 
                                <input type="radio" name="job_type" value="PT">
                                Part-Time 
                                <input type="radio" name="job_type" value="FT" CHECKED>
                                Full-Time 
                                <input type="radio" name="job_type" value="FP">
                                Full-Time or Part-Time
                                <input type="radio" name="job_type" value="CT">
                                Contract								
								</td>
                            </tr>
                            <tr> 
                              <td width="24%" align="right" class="req_label">Salary:
                              </td>
                              <td width="76%"><input type="text" name="job_salary" size="25" maxlength="25">
                              </td>
                            </tr>
                            <tr> 
                              <td width="24%">&nbsp;</td>
                              <td width="76%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="24%">&nbsp;</td>
                              <td width="76%"> 
                                <input type="button" value="Save New Job" name="submit_btn" onClick="checkForm();">
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
