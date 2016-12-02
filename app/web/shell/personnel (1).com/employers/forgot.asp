<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->


<%
'	*************************  File Description  *************************
'		FileName:		forgot.asp
'		Description:	Employer forgot login page.
'						Sends email address to doForgot.asp for lookup
'		Created:		Tuesday, February 17, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************

%>
<html>
<head>
<title>Forgot Password - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<script language = "Javascript">

function checkForm(){
	var emailID=document.forgotPassword.emailAddress
	
	if (IsBlank(emailID.value)){
		alert("Please enter your E-mail Address")
		emailID.focus()
		return false
	}
	if (IsEmail(emailID)==false){
		emailID.focus()
		emailID.value=""

		return false
	}
    document.forgotPassword.submit();		
	return true
 }
</script>
</head>

<body onLoad="javascript:document.forgotPassword.emailAddress.focus();">
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
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td>
                  <form name="forgotPassword" action="doForgot.asp" method="post" onSubmit="noReturn('forgotPassword'); return false">
                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="/images/headers/forgot.gif" width="328" height="48"></td>
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
                        <td width="30"><img src="/images/pixel.gif" width="30" height="8"></td>
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td class="redHead">Enter your e-mail address in the box below and click the Submit button.<br> Your login information will be immediately sent to you.	<p></p>
                                <b>The e-mail address you provide must 
                                be the same address you used during registration.</b>
							 

                              </td>
                            </tr>
<% if request("error") = 1 then %>							
							<tr>
								<td>
									<table border="0" cellspacing="2" cellpadding="4">
										<tr>
											<td><img src="/images/ico_alert.gif" alt="" width="25" height="19" border="0" align="absmiddle"> <font color="#CC0000"><strong>Error:</strong> Please re-enter e-mail address</font>
											</td>
										</tr>
									</table>
								</td>
							</tr>
<% End if %>								
<% if request("error") = 2 then %>							
							<tr>
								<td>
									<table border="0" cellspacing="2" cellpadding="4">
										<tr>
											<td><img src="/images/ico_alert.gif" alt="" width="25" height="19" border="0" align="absmiddle"> <font color="#CC0000"><strong>Error:</strong> Could not find specified e-mail (<%=request("badEmail")%>)</font>
											</td>
										</tr>
									</table>
								</td>
							</tr>
<% End if %>	
<% if request("error") = 3 then %>							
							<tr>
								<td>
									<table border="0" cellspacing="2" cellpadding="4">
										<tr>
											<td><img src="/images/ico_alert.gif" alt="" width="25" height="19" border="0" align="absmiddle"> <font color="#CC0000"><strong>Error:</strong> Invalid Address (<%=request("badEmail")%>)</font>
											</td>
										</tr>
									</table>
								</td>
							</tr>
<% End if %>							
                            <tr> 
                              <td><strong>E-mail Address:</strong> &nbsp;<input type="text" name="emailAddress" maxlength="100" size="28"> <input type="button" name="submit_btn" value="Submit" onClick="checkForm()"></td>
                            </tr>
							<tr>
								<td>
<br><a href="mailto:webmaster@personnel.com?Subject=Employer%20Account%20--%20Problems%20Signing%20In&body=Please%20describe%20your%20problem%20here."><font size="1">CLICK HERE</font></a> <font size="1">if you are still having trouble with your password.</font>
                                <br>								
								
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
<%
Connect.Close
Set Connect = Nothing
%>
</body>
</html>
