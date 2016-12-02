<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->

<html>
<head>
<title>Search Online Resumes - www.personnel.com</title>
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
                <td width="100%"><img src="/images/pixel.gif" width="1" height="72"></td>
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
              <tr bgcolor="#E7E7E7"> 
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
                      <td><img src="/images/headers/resumeSearch.gif" width="328" height="48"></td>
                    </tr>
                  </table>
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="8"></td>
                      <td>
                        <form name="frmSearchRes" method="post" action="doSearch.asp">					
                          <table width="90%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td colspan="4">Please choose 
                                from the options below to narrow down your search.
								<br>
                                (Leave all fields unchanged 
                                to browse entire listing)
								</td>
                            </tr>
                            <tr> 
                              <td width="26%">&nbsp;</td>
                              <td width="7%">&nbsp;</td>
                              <td width="42%">&nbsp;</td>
                              <td width="25%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td colspan="2"><strong>Keywords:</strong><br>
                                      <font size="1" color="#666666">(Optional - enter words to match with <strong>resumes titles</strong>
                                      and <strong>descriptions</strong>.)</font></td>
                              <td colspan="2">
<input type="radio" name="keyword_type" value=" AND " checked> Exact Phrase &nbsp;
<input type="radio" name="keyword_type" value=" OR "> Any Word(s)
<br>							  
<input type="text" name="job_keywords" size="38" maxlength="125">
                              </td>
                            </tr>							
                            <tr> 
                              <td colspan="2" class="req_label">Search by Date:</td>
                              <td colspan="2"> 
							  
                                <select name="res_date_created">
                                  <option value="0" selected>- All Resumes -</option>	  
                                  <option value="3">Resumes received within 3 days</option>
                                  <option value="7">Resumes received within 7 days</option>	
                                  <option value="14">Resumes received within 14 days</option>	
                                  <option value="28">Resumes received within 28 days</option>								  							  							  							  
                                </select>
                              </td>
                            </tr>
                            <tr valign="top"> 
                              <td colspan="2" class="req_label">State / Country:</td>
                              <td colspan="2"> 
						<SELECT NAME="job_location">
                        <option value="" selected>- All Locations -</option>
				<% do while not rsLoc.eof %>
						<OPTION	VALUE="<%= rsLoc("loc_code")%>"> <%=rsLoc("loc_name") %></OPTION>
					<% rsLoc.MoveNext %>
				<% loop %>
						</SELECT>
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="2" class="req_label">Availability:</td>
                              <td colspan="2"> 
                                <select name="res_date_available">
                                  <option value="" selected>- All -</option>
                                  <option value="asap">As soon as possible</option>
                                  <option value="onemonth">Under 1 month</option>
                                  <option value="twomonths">1 to 2 months</option>
                                  <option value="threemonths">3 or more months</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="2" class="req_label">Type of Work:</td>
                              <td colspan="2"> 
                                <select name="res_availability">
                                  <option value="" selected>- All -</option>
                                  <option value="FP">Full Time / Part Time</option>
                                  <option value="FT">Full Time</option>
                                  <option value="PT">Part Time</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="2" class="req_label">Sort Results By:</td>
                              <td colspan="2"> 
<input type="radio" name="order_by" value="date" checked> Date
<input type="radio" name="order_by" value="location"> Location

                              </td>
                            </tr>							
                            <tr> 
                              <td colspan="2">&nbsp;</td>
                              <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td colspan="2">&nbsp;</td>
                              <td colspan="2"> 
                                <input type="submit" name="Submit" value="Search Now...">
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
Set rsLoc = Nothing
Connect.Close
Set Connect = Nothing
%>
</body>
</html>
