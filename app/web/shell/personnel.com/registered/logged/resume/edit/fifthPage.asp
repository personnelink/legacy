<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->

<%
set rsResume = Server.CreateObject("ADODB.RecordSet")
rsResume.CursorLocation = 3
rsResume.Open "SELECT * FROM tbl_resumes WHERE mbr_id = " & session("mbrID") & " AND res_id = " & request("num"),Connect
%>

<html>
<head>
<title>Resume Editor - Step 5 of 5 - EDIT WORK REFERENCES: - www.personnel.com</title>
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
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="/images/headers/resumeCenter.gif" width="328" height="48"></td>
                    </tr>
                  </table>
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                      <td> 
                        <form name="resumeInfo" method="post" action="doFifthPage.asp">
                          <table width="100%" border="0" cellspacing="0" cellpadding="2">
                            <tr> 
                              <td colspan="4" class="resTitle">Step 5 of 5 - EDIT WORK REFERENCES:</td>
                            </tr>
                            <tr> 
                              <td colspan="4" bgcolor="#E7E7E7"><strong>Reference One</strong></td>
                            </tr>
                            <tr> 
                              <td>Name:</td>
                              <td> 
                                <input type="text" name="res_refer_name1" value="<%=rsResume("res_refer_name1")%>" maxlength="75">
                              </td>
                              <td>Job Title:</td>
                              <td> 
                                <input type="text" name="res_refer_title1" value="<%=rsResume("res_refer_title1")%>" maxlength="100">
                              </td>
                            </tr>
                            <tr> 
                              <td>Company Name:</td>
                              <td colspan="3"> 
                                <input type="text" name="res_refer_company1" size="50" value="<%=rsResume("res_refer_company1")%>" maxlength="100">
                              </td>
                            </tr>
                            <tr> 
                              <td>Phone Number:</td>
                              <td> 
                                <input type="text" name="res_refer_phone1" value="<%=rsResume("res_refer_phone1")%>" maxlength="25">
                              </td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td colspan="4" bgcolor="#E7E7E7"><strong>Reference Two</strong></td>
                            </tr>
                            <tr> 
                              <td>Name:</td>
                              <td> 
                                <input type="text" name="res_refer_name2" value="<%=rsResume("res_refer_name2")%>" maxlength="75">
                              </td>
                              <td>Job Title:</td>
                              <td> 
                                <input type="text" name="res_refer_title2" value="<%=rsResume("res_refer_title2")%>" maxlength="100">
                              </td>
                            </tr>
                            <tr> 
                              <td>Company Name:</td>
                              <td colspan="3"> 
                                <input type="text" name="res_refer_company2" size="50" value="<%=rsResume("res_refer_company2")%>" maxlength="100">
                              </td>
                            </tr>
                            <tr> 
                              <td>Phone Number:</td>
                              <td> 
                                <input type="text" name="res_refer_phone2" value="<%=rsResume("res_refer_phone2")%>" maxlength="25">
                              </td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td colspan="4" bgcolor="#E7E7E7"><strong>Reference Three</strong></td>
                            </tr>
                            <tr> 
                              <td>Name:</td>
                              <td> 
                                <input type="text" name="res_refer_name3" value="<%=rsResume("res_refer_name3")%>" maxlength="75">
                              </td>
                              <td>Job Title:</td>
                              <td> 
                                <input type="text" name="res_refer_title3" value="<%=rsResume("res_refer_title3")%>" maxlength="100">
                              </td>
                            </tr>
                            <tr> 
                              <td>Company Name:</td>
                              <td colspan="3"> 
                                <input type="text" name="res_refer_company3" size="50" value="<%=rsResume("res_refer_company3")%>" maxlength="100">
                              </td>
                            </tr>
                            <tr> 
                              <td>Phone Number:</td>
                              <td> 
                                <input type="text" name="res_refer_phone3" value="<%=rsResume("res_refer_phone3")%>" maxlength="25">
                              </td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td> 
                                <input type="hidden" name="num" value="<%=request("num")%>">
                              </td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td> 
                                <input type="submit" name="Submit" value="Save & Finish">
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
            <p> 
              <!-- #INCLUDE VIRTUAL='/includes/cdc_menu.asp' -->
            </p>
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
rsResume.Close
Set rsResume = Nothing
Connect.Close
Set Connect = Nothing
%>
</body>
</html>
