<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		index.asp
'		Description:	Account Options main page for Employers
'		Created:		Wednesday, February 18, 2004
'		Lastmod:
'		Developer(s):	James Werrbach
'	**********************************************************************

dim rsAccount, sqlAccount

sqlAccount = "SELECT emp_id, emp_company_name, emp_contact_name, emp_job_email_address, emp_account_type, emp_address_one, emp_address_two, emp_city, emp_location, emp_zipcode, emp_phone_number, emp_fax_number, emp_url, emp_is_suspended, emp_date_searched, emp_company_profile, emp_date_created FROM tbl_employers WHERE emp_id= " & session("empID")

Set rsAccount = Server.CreateObject("ADODB.RecordSet")
rsAccount.CursorLocation = 3
rsAccount.Open(sqlAccount),Connect

dim emp_company_name				:	emp_company_name = rsAccount("emp_company_name")
dim emp_contact_name				:	emp_contact_name = rsAccount("emp_contact_name")
dim emp_job_email_address			:	emp_job_email_address = rsAccount("emp_job_email_address")
dim emp_address_one					:	emp_address_one = rsAccount("emp_address_one")
dim emp_address_two					:	emp_address_two = rsAccount("emp_address_two")
dim emp_city						:	emp_city = rsAccount("emp_city")
dim emp_location					:	emp_location = rsAccount("emp_location")
dim emp_zipcode						:	emp_zipcode = rsAccount("emp_zipcode")
dim emp_phone_number				:	emp_phone_number = rsAccount("emp_phone_number")
dim emp_fax_number					:	emp_fax_number = rsAccount("emp_fax_number")
dim emp_url							:	emp_url = rsAccount("emp_url")
dim emp_company_profile				:	emp_company_profile = rsAccount("emp_company_profile")

rsAccount.Close
Set rsAccount = Nothing
%>

<html>
<head>
<title>Edit Employer Account Information - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<script language="javaScript">
function checkInfo()  {

var isGood = true
document.frmEditEmpInfo.submit_btn.disabled = true;	

  if (IsBlank(document.frmEditEmpInfo.emp_contact_name.value))
    {  alert("Please provide your name or a contact name."); 
document.frmEditEmpInfo.emp_contact_name.value = "";	
document.frmEditEmpInfo.emp_contact_name.focus();
document.frmEditEmpInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}		
  if (IsBlank(document.frmEditEmpInfo.emp_company_name.value))
    {  alert("Please provide a company name."); 
document.frmEditEmpInfo.emp_company_name.value = "";	
document.frmEditEmpInfo.emp_company_name.focus();
document.frmEditEmpInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}					
				  		   		
  if (IsBlank(document.frmEditEmpInfo.emp_address_one.value))
    {  alert("Please provide your company address."); 
document.frmEditEmpInfo.emp_address_one.value = "";	
document.frmEditEmpInfo.emp_address_one.focus();
document.frmEditEmpInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}	
		
  if (IsBlank(document.frmEditEmpInfo.emp_city.value))
    {  alert("Please provide a city or township."); 
document.frmEditEmpInfo.emp_city.value = "";	
document.frmEditEmpInfo.emp_city.focus();
document.frmEditEmpInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}	
		
  if (IsBlank(document.frmEditEmpInfo.emp_zipcode.value))
    {  alert("Please provide your zip or postal code"); 
document.frmEditEmpInfo.emp_zipcode.value = "";	
document.frmEditEmpInfo.emp_zipcode.focus();
document.frmEditEmpInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}	
		
  if (IsBlank(document.frmEditEmpInfo.emp_phone_number.value))
    {  alert("Please provide your primary contact phone number."); 
document.frmEditEmpInfo.emp_phone_number.value = "";	
document.frmEditEmpInfo.emp_phone_number.focus();
document.frmEditEmpInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}	
		
									 			
  if (document.frmEditEmpInfo.emp_location.value == '1')
    {  alert("Please indicate which state you live in."); 
document.frmEditEmpInfo.emp_location.focus();
document.frmEditEmpInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
  if (document.frmEditEmpInfo.emp_location.value == '2')
    {  alert("Please indicate which province you live in."); 
document.frmEditEmpInfo.emp_location.focus();
document.frmEditEmpInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}
  if (document.frmEditEmpInfo.emp_location.value == '3')
    {  alert("Please indicate which country you live in."); 
document.frmEditEmpInfo.emp_location.focus();
document.frmEditEmpInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}				 
 
  if (document.frmEditEmpInfo.emp_zipcode.value == '' && document.frmEditEmpInfo.emp_location.value.length > 2)
    {  alert("Please enter your zip or postal code."); 
	document.frmEditEmpInfo.emp_zipcode.focus();
document.frmEditEmpInfo.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
  if (document.frmEditEmpInfo.emp_zipcode.value.length < 5 && document.frmEditEmpInfo.emp_location.value.length > 2)
    {  alert("Please enter your complete zip or postal code."); 
	document.frmEditEmpInfo.emp_zipcode.focus();
document.frmEditEmpInfo.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}			
					 	
							
  if (isGood != false)
    {  document.frmEditEmpInfo.submit();  }
}

function MM_goToURL() { 
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
</script>

</head>

<body>
<form name="frmEditEmpInfo" method="post" action="doAccountInfo.asp">
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
                        <td><img src="/images/headers/accountOptions.gif" width="328" height="48"></td>
                      </tr>
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td width="30">&nbsp;</td>
                              <td valign="bottom" class="sideLink">Other Options:&nbsp;<a href="changePwd.asp">Change Account Password</a> | <a href="changeEmail.asp">Change E-mail Address</a></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                    <br>
                    <table width="95%" border="0" cellspacing="0" cellpadding="0">					
                      <tr> 
                         <td colspan="2"></td>
                      </tr>						
                      <tr> 
                        <td width="30"><img src="/images/pixel.gif" width="30" height="8"></td>
                        <td>
                          <table width="95%" border="0" cellspacing="0" cellpadding="4" style="border: 1px solid #666666;">
                            <tr> 
                              <td colspan="2" bgcolor="#e7e7e7" align="center"><strong>Use the form below to change your employer account information</strong></td>
                            </tr>
                            <tr> 
                              <td width="40%" class="req_label">Contact Name:</td>
                              <td width="60%"> 
                                <input type="text" name="emp_contact_name" value="<%=emp_contact_name%>" size="31" maxlength="50">
                              </td>
                            </tr>
                            <tr> 
                              <td width="40%" class="req_label">Company Name:</td>
                              <td width="60%"> 
                                <input type="text" name="emp_company_name" value="<%=emp_company_name%>" size="48" maxlength="100">
                              </td>
                            </tr>
                            <tr> 
                              <td width="41%">Job E-mail Address:<br>
                                <font size="1">(<u>Optional</u> - used by 
                                job seekers to contact you.)</font></td>
                              <td width="59%" valign="top"> 
                                <input type="text" name="emp_job_email_address" size="31" value="<%=emp_job_email_address%>" maxlength="100" onBlur="IsEmail(this);">
                              </td>
                            </tr>
                            <tr> 
                              <td width="41%" class="req_label" valign="top"> Company Address:</td>
                              <td width="59%"> 
                                <input type="text" name="emp_address_one" size="31" value="<%=emp_address_one%>" maxlength="175">
<br>
<input type="text" name="emp_address_two" size="31" value="<%=emp_address_two%>" maxlength="100">
                              </td>
                            </tr>
                            <tr> 
                              <td width="41%" class="req_label">City:</td>
                              <td width="59%"> 
                                <input type="text" name="emp_city" size="31" value="<%=emp_city%>" maxlength="50">
                              </td>
                            </tr>
                            <tr> 
                              <td width="41%" class="req_label">State / Country:</td>
                              <td width="59%"> 
						<SELECT NAME="emp_location">
                        <option value="" selected>- Select a Job Location -</option>						
				<% do while not rsLoc.eof %>
						<OPTION	VALUE="<%= rsLoc("loc_code")%>"<% if rsLoc("loc_code") = emp_location then%>Selected<%end if%>> <%=rsLoc("loc_name") %></OPTION>
					<% rsLoc.MoveNext %>
				<% loop %>	
						</SELECT>
                              </td>
                            </tr>
                            <tr> 
                              <td width="41%" class="req_label">Zip Code:</td>
                              <td width="59%"> 
                                <input type="text" name="emp_zipcode" size="12" value="<%=emp_zipcode%>" maxlength="10">
                              </td>
                            </tr>
                            <tr> 
                              <td width="41%" class="req_label">Phone Number:</td>
                              <td width="59%"> 
                                <input type="text" name="emp_phone_number" size="20" value="<%=emp_phone_number%>" maxlength="25" onBlur="formatPhoneNumber(this);">
                              </td>
                            </tr>
                            <tr> 
                              <td width="41%">Fax Number:</td>
                              <td width="59%"> 
                                <input type="text" name="emp_fax_number" size="20" value="<%=emp_fax_number%>" maxlength="25" onBlur="formatPhoneNumber(this);">
                              </td>
                            </tr>
                            <tr> 
                              <td width="41%">Company URL:</td>
                              <td width="59%"> 
                                <input type="text" name="emp_url" size="40" value="<%=emp_url%>" maxlength="25" onBlur="IsURL(this);">
                              </td>
                            </tr>	
                            <tr> 
                              <td width="41%" valign="top">Company Description:<br><font size="1">(Describe corporate focus / history)</font></td>
                              </td>
							  <td width="59%" valign="top"><textarea cols="30" rows="4" name="emp_company_profile"><%=emp_company_profile%></textarea></td>
                            </tr>														
                            <tr> 
                              <td colspan="2" align="center">
<input type="button" value="Save Changes" onClick="checkInfo();" name="submit_btn">&nbsp;&nbsp;
<input type="button" value="Cancel" onClick="MM_goToURL('parent','../index.asp');return document.MM_returnValue" name="button" tabindex="-1">
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
</form>
<%
Set rsLoc = Nothing
Connect.Close
Set Connect = Nothing
%>

</body>
</html>
