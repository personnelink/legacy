<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->

<html>
<head>
<title>Resume Builder [STEP 5] - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
</head>

<body onLoad="javascript:document.frmResInfo5.res_refer_name1.focus();">
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
                <td width="100%"><img src="/images/pixel.gif" width="1" height="72"></td>
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
                      <td><img src="/images/headers/resumeCenter.gif" width="328" height="48"></td>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                      <td> 
                        <form name="frmResInfo5" method="post" action="doFifthPage.asp">
						<input type="hidden" name="inc_res_id" value="<%=request.querystring("inc_id")%>">						
                          <table width="100%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td colspan="4" class="redHead"><strong>STEP V: Work References</strong></td>
                            </tr>
                            <tr> 
                              <td colspan="4"><i>Supply up to three professional work references.</i></td>
                            </tr>							
                            <tr bgcolor="#E7E7E7"> 
                              <td colspan="4"><b><font size="2">Work Reference One</font></b></td>
                            </tr>
                            <tr> 
                              <td>Name:</td>
                              <td> 
                                <input type="text" name="res_refer_name1" size="30" maxlength="75">
                              </td>
                              <td>Job Title:</td>
                              <td> 
                                <input type="text" name="res_refer_title1" size="30" maxlength="100">
                              </td>
                            </tr>
                            <tr> 
                              <td>Company Name:</td>
                              <td> 
                                <input type="text" name="res_refer_company1" size="30" maxlength="100">
                              </td>
							  <td>Contact Phone:</td>
							  <td><input type="text" name="res_refer_phone1" size="20" maxlength="25"  onBlur="formatPhoneNumber(this);"></td>
                            </tr>
                            <tr bgcolor="#E7E7E7"> 
                              <td colspan="4"><b><font size="2">Work Reference Two</font></b></td>
                            </tr>
                            <tr> 
                              <td>Name:</td>
                              <td> 
                                <input type="text" name="res_refer_name2" size="30" maxlength="75">
                              </td>
                              <td>Job Title:</td>
                              <td> 
                                <input type="text" name="res_refer_title2" size="30" maxlength="100">
                              </td>
                            </tr>
                            <tr> 
                              <td>Company Name:</td>
                              <td> 
                                <input type="text" name="res_refer_company2" size="30" maxlength="100">
                              </td>
							  <td>Contact Phone:</td>
							  <td><input type="text" name="res_refer_phone2" size="20" maxlength="25" onBlur="formatPhoneNumber(this);"></td>							  
                            </tr>
                            <tr bgcolor="#E7E7E7"> 
                              <td colspan="4"><b><font size="2">Work Reference Three</font></b></td>
                            </tr>
                            <tr> 
                              <td>Name:</td>
                              <td> 
                                <input type="text" name="res_refer_name3" size="30" maxlength="75">
                              </td>
                              <td>Job Title:</td>
                              <td> 
                                <input type="text" name="res_refer_title3" size="30" maxlength="100">
                              </td>
                            </tr>
                            <tr> 
                              <td>Company Name:</td>
                              <td> 
                                <input type="text" name="res_refer_company3" size="30" maxlength="100">
                              </td>
							  <td>Contact Phone:</td>
							  <td><input type="text" name="res_refer_phone3" size="20" maxlength="25"  onBlur="formatPhoneNumber(this);"></td>									  
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td> 
                                <input type="submit" name="Submit" value="Save & View Resume">
                              </td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
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
Connect.Close
Set Connect = Nothing
%>
