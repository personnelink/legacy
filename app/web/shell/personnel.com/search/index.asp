<%
if session("mbrAuth") = "true" then
  response.redirect("/registered/logged/search/index.asp")
end if
%>
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkMbrCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_locations.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/get_categories.asp' -->

<html>
<head>
<title>Job Search - www.personnel.com</title>
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
        <tr>
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
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_srn_w.gif" width="175" height="76"></td>
        </tr>
        <tr>
          <td bgcolor="#000000">
            <%
		    response.write("<table width=100% border=0 cellspacing=0 cellpadding=3><tr><td>" & VBCRLF)
            response.write("<FONT COLOR=WHITE>")
            response.write("&nbsp;&nbsp;<a href='/search/index.asp' class=headmenu>Search Jobs</a>&nbsp;&nbsp;")
            response.write(" &#149; &nbsp;&nbsp;<A HREF='/chooseLogin.asp' class=headmenu>Login Now!</A>&nbsp;&nbsp;")
            response.write(" &#149; &nbsp;&nbsp;<A HREF='/registered/login.asp' class=headmenu>Post a Resume</A>&nbsp;&nbsp;")
            response.write(" &#149; &nbsp;&nbsp;<A HREF='/employers/login.asp' class=headmenu>Post a Job</A>&nbsp;&nbsp;")
            response.write(" &#149; &nbsp;&nbsp;<A HREF='/help/index.asp' class=headmenu>First Time Users</A>&nbsp;&nbsp;")
            response.write("</font></td></tr></table>" & VBCRLF)
			%>
          </td>
          <td width="175" bgcolor="#000000">&nbsp;</td>
        </tr>
        <tr>
          <td valign="top" bgcolor="#E7E7E7">
            <!--#include virtual="/includes/pub_greybar.asp" -->
          </td>
          <td rowspan="2" valign="top">
            <!-- #INCLUDE VIRTUAL='/includes/pub_menu.asp' -->
          </td>
        </tr>
        <tr>
          <td valign="top">
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
                            <td class="sideMenu" valign="bottom">&nbsp;</td>
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
                            <td width="30" class="sideMenu"><img src="/images/pixel.gif" width="30" height="8"></td>
                            <td class="sideMenu" valign="bottom">
                              <form name="searchCriteria" method="post" action="doSearch.asp">
                                <table width="100%" border="0" cellspacing="0" cellpadding="5">
                                  <tr>
                                    <td colspan="4"><span class="redHead">Please
                                      select from the options below to narrow
                                      down your search.</span><br>
                                      <span class="required">(Leave all fields
                                      blank to view all jobs)</span></td>
                                  </tr>
                                  <tr>
                                    <td width="25%">&nbsp;</td>
                                    <td width="9%">&nbsp;</td>
                                    <td width="43%">&nbsp;</td>
                                    <td width="23%">&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td colspan="2" valign="top"><STRONG>Search Keywords:</STRONG><br>
                                      <i>This is an optional field where you can
                                      enter words to match with <strong>job titles</strong>
                                      and <strong>objectives</strong>.</i><br>


                                    </td>
                                    <td colspan="2" valign="top">
									<input type="radio" name="keyword_type" value=" AND " checked> Exact Phrase &nbsp;
									<input type="radio" name="keyword_type" value=" OR "> Any Word(s)
									<br>
									<input type="text" name="job_keywords" size="34" maxlength="100">
									<% if request("kwd") = "inv" then %>
									<br> Keyword is too general
									<% end if%>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td colspan="2">&nbsp;</td>
                                    <td colspan="2">&nbsp; </td>
                                  </tr>
                                  <tr>
                                    <td colspan="2" valign="top"><STRONG>Job Availability:</STRONG></td>
                                    <td colspan="2">
									<input type="radio" name="job_type" value="FP" checked>Full / Part-Time
									<input type="radio" name="job_type" value="FT">Full-Time
									<input type="radio" name="job_type" value="PT">Part-Time
									<input type="radio" name="job_type" value="CT">Contract									

                                    </td>
                                  </tr>
                                  <tr>
                                    <td colspan="2"><STRONG>Job Category:</STRONG></td>
                                    <td colspan="2">
						<SELECT NAME="job_category">
                        <option value="" selected>- Select a Job Category -</option>
                        <option value="">ALL CATEGORIES</option>
				<% do while not rsCat.eof %>
						<OPTION	VALUE="<%= rsCat("cat_name")%>"> <%=rsCat("cat_name") %></OPTION>
					<% rsCat.MoveNext %>
				<% loop %>
						</SELECT>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td colspan="2"><STRONG>Job Location:</STRONG></td>
                                    <td colspan="2">
						<SELECT NAME="job_location">
                        <option value="" selected>- Select a Job Location -</option>
				<% do while not rsLoc.eof %>
						<OPTION	VALUE="<%= rsLoc("loc_code")%>"> <%=rsLoc("loc_name") %></OPTION>
					<% rsLoc.MoveNext %>
				<% loop %>
						</SELECT>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td colspan="2"><STRONG>City:</STRONG></td>
                                    <td colspan="2">
						<input type="text" name="job_city" size="22" maxlength="50">
                                    </td>
                                  </tr>


                                  <tr>
                                    <td colspan="2"><STRONG>Sort Results By:</STRONG></td>
                                    <td colspan="2">
						<SELECT NAME="order_by">
                        <option value="date" selected>Date Posted</option>
                        <option value="title">Job Title</option>
                        <option value="company">Company Name</option>
						</SELECT>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td colspan="2">&nbsp;</td>
                                    <td colspan="2">&nbsp; </td>
                                  </tr>
                                  <tr>
                                    <td colspan="2">&nbsp;</td>
                                    <td colspan="2">
                                      <input type="submit" name="submit_btn" value="Start Search">
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
rsLoc.Close
Set rsLoc = Nothing
rsCat.Close
Set rsCat = Nothing
%>
</body>
</html>
