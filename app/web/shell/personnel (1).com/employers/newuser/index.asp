<%
if session("empAuth") = "true" then 
response.redirect("/employers/login.asp?error=3")
end if
%>
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<html>
<head>
<title>Create Employer Account [Step 1] - www.personnel.com</title>
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
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_srn_w.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <!-- #INCLUDE VIRTUAL='/includes/menu.asp' -->
          </td>
          <td width="175">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
			  <tr>
			  	<td colspan="2"><img src="/images/hdr_new_emp_reg.gif" alt="" width="328" height="48" border="0"></td>
			  </tr>
              <tr>
			    <td><img src="/images/pixel.gif" width="20" height="1"></td> 
                <td> 
                  <form name="accountInfo" method="post" action="firstPage.asp">
                    <table width="90%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td colspan="3">
						
						<strong>* Note: at this time all Employer services are available at no charge. </strong> <p></p>
                        </td>
                      </tr>
                      <tr> 
                        <td colspan="3" bgcolor="#e7e7e7"><p><strong>Which best describes your company? </strong></p></td>
                      </tr>
                      <tr> 
					  	<td width="25"><img src="/images/pixel.gif" width="25" height="1"></td>
                        <td valign="top" width="150"><input type="radio" name="emp_account_type" value="0" checked> Direct Employer</td>
                        <td valign="top" width="150"><input type="radio" name="emp_account_type" value="1"> Third Party Recruiter</td>						
                      </tr> 
					  <tr>
					  	<td colspan="3"><img src="/images/pixel.gif" width="1" height="15"></td>
					  </tr>
                      <tr> 
                        <td colspan="3" bgcolor="#e7e7e7"><p><strong>Select the option below that best suits your posting requirements:</STRONG></td>
                      </tr>					  
					  <tr>
					  	<td width="25"></td>					  
					  	<td align="left" width="150"><input type="radio" name="emp_account_size" value="0" checked> Small</td>
					  	<td align="left" width="150"><input type="radio" name="emp_account_size" value="1"> Large</td>					  
					  </tr>
					  <tr>
					  	<td width="25"></td>					  
					  	<td valign="top">
<ul type="square">
<li>This type of account is designed for employers who desire to post on a one time only basis. </li>
<p></p>* You would be charged per job posting
</ul>						
						</td>
					  	<td valign="top">
<ul type="square">
<li>This type of account is designed for employers who desire to post multiple or on-going job postings.</li>
<p></p>* You would be billed on a montly basis no matter how many jobs you post.
</ul>						
						</td>
					  </tr>

                      <tr> 
					  	<td width="25"></td>
                        <td width="100%" colspan="2"> 
                          <input type="submit" name="Submit" value="Continue...">
                        </td>
                      </tr>
                    </table>
                  </form>
                </td>
              </tr>
            </table>
          </td>
          <td width="175" valign="top"> 
            <!-- #INCLUDE VIRTUAL='/includes/pub_menu.asp' -->
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
Set Connect = Nothing
%>
