<!-- #INCLUDE VIRTUAL='/inc/employerAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->


<%
set rsLastSearch = Server.CreateObject("ADODB.RecordSet")
rsLastSearch.Open "SELECT * FROM tbl_employers WHERE userName='" & session("employerUserName") & "'",Connect,3,3
set rsSearch = Server.CreateObject("ADODB.RecordSet")

dim a,b,c,d,e,keywords
if request("keywords") <> "" then
  keywords = split(request("keywords")," ")
  for i = 0 to uBound(keywords)
    if i < uBound(keywords) then
	  if keywords(i) <> "" then
	    d = d + "title LIKE '%" & keywords(i) & "%' OR objective LIKE '%" & keywords(i) & "%' OR "
      end if
	else
	  if keywords(i) <> "" then
 	    d = d + "title LIKE '%" & keywords(i) & "%' OR objective LIKE '%" & keywords(i) & "%'"
	  end if
	end if
  next
  d = "AND (" & d & ")"
end if

if request("eligible") <> "null" then a = " AND eligible = '" & request("eligible") & "'"
if request("dateAvailable") <> "null" then b = " AND dateAvailable = '" & request("dateAvailable") & "'"
if request("availability") <> "null" then c = " AND availability = '" & request("availability") & "'"
if request("location") <> "null" then e = " AND state = '" & request("location") & "'"

if request("keywords") = "" AND request("eligible") = "null" AND request("dateAvailable") = "null" AND request("availability") = "null" AND request("location") = "null" then
  rsSearch.Open "SELECT * FROM tbl_resumes WHERE active = 'yes' AND deleted = 'no' ORDER BY dateCreated DESC",Connect,3,3
else
  rsSearch.Open "SELECT * FROM tbl_resumes WHERE active='yes'" & a & b & c & e & d & "AND deleted ='no' ORDER BY dateCreated DESC",Connect,3,3
end if
%>

<html>

<head>
<title>Search Results</title>
<link rel="stylesheet" href="../../../css/default.css" type="text/css">
</head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="100%" bgcolor="#000000"> 
      <!-- #INCLUDE VIRTUAL='/inc/top_menu.asp' -->
    </td>
  </tr>
  <tr> 
    <td width="100%" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr bgcolor="EFEFEF"> 
          <td bgcolor="#5187CA"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td rowspan="2" width="216"><img src="/img/logo.gif" width="215" height="76"></td>
                <td width="100%"><img src="/img/pixel.gif" width="100%" height="72"></td>
              </tr>
              <tr> 
                <td height="4" width="100%" bgcolor="#FFFFFF"><img src="/img/pixel.gif" width="1" height="1"></td>
              </tr>
            </table>
          </td>
          <td bgcolor="#5187CA" width="175"><img src="/img/flare_hms.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <!-- #INCLUDE VIRTUAL='/inc/menu.asp' -->
          </td>
          <td width="175">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="E7E7E7"> 
                <td> 
                  <p class="navLinks"> 
                    <!-- #INCLUDE VIRTUAL='/inc/textNav.asp' -->
                  </p>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="../../../img/headers/resumeSearch.gif" width="328" height="48"></td>
                    </tr>
                  </table>
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="../../../img/pixel.gif" width="30" height="8"></td>
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="5">
                          <% if rsSearch.RecordCount < 1 then %>
                          <tr> 
                            <td colspan="3" class="redHead">No results returned</td>
                          </tr>
                          <% else %>
                          <tr> 
                            <td colspan="3" class="redHead">&nbsp;</td>
                          </tr>
                          <tr bgcolor="#DDDDDD"> 
                            <td><b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Resume 
                              Title</b></td>
                            <td width="33%" align="center"><b>Salary</b></td>
                            <td width="33%" nowrap align="center"><b>Preferred 
                              Location</b></td>
                          </tr>
                          <tr> 
                            <td width="58%">&nbsp;</td>
                            <td colspan="2" align="right">&nbsp;</td>
                          </tr>
                          <% 
  index = 1
  Do until rsSearch.eof
    if request("sortDate") = "all" or rsLastSearch("lastSearched") = "never" then
%>
                          <tr> 
                            <td width="58%" bgcolor="#DDDDDD"><b><%=index%>)<font size="1"></font></b> 
                              &nbsp;&nbsp; 
                              <%
							  if rsSearch("fileName") <> "" then %>
                              <a href="viewResume2.asp?id=<%=rsSearch("ID")%>"><%=rsSearch("title")%></a><b><font size="1"></font></b> 
                              <% else %>
                              <a href="viewResume.asp?id=<%=rsSearch("ID")%>"><%=rsSearch("title")%><b><font size="1"></font></b> 
                              </a> 
                              <% end if %>
                            </td>
                            <td bgcolor="#DDDDDD" align="center"><font size="1"><i><b><font size="1"><i><%=rsSearch("salary")%></i></font></b> 
                              </i></font></td>
                            <td bgcolor="#DDDDDD" align="center"><font size="1"><i><b><font size="1"><i><b><font size="1"><i>
							<% if IsNumeric(rsSearch("preferredLocation")) then %>
							     <%=location(rsSearch("preferredLocation")) %>
							<%else %>
							     <%=rsSearch("preferredLocation")%>
							<% end if %>
							   
							   </i></font></b></i></font></b></i></font></td>
                          </tr>
                          <tr> 
                            <td colspan="3"><%=rsSearch("objective")%></td>
                          </tr>
                          <tr> 
                            <td colspan="3">&nbsp;</td>
                          </tr>
                          <%
    else
	  difference = DateDiff("d",rsLastSearch("lastSearched"), rsSearch("dateCreated"))
	  if difference >= 0 then %>
                          <tr> 
                            <td width="58%" bgcolor="#DDDDDD"><b><%=index%>)</b><font size="1"></font> 
                              &nbsp;&nbsp; <a href="viewResume.asp?id=<%=rsSearch("ID")%>"><%=rsSearch("title")%></a></td>
                            <td bgcolor="#DDDDDD" align="center"><font size="1"><i><b><font size="1"><i><%=rsSearch("salary")%></i></font></b> 
                              </i></font></td>
                            <td bgcolor="#DDDDDD" align="center"><font size="1"><i><b><font size="1"><i><b><font size="1"><i><b><font size="1"><i>
                              <% if IsNumeric(rsSearch("preferredLocation")) then %>
                              <%=location(rsSearch("preferredLocation")) %> 
                              <% else %>
                              <%=rsSearch("preferredLocation")%> 
                              <% end if %>
                              </i></font></b></i></font></b></i></font></b></i></font></td>
                          </tr>
                          <tr> 
                            <td colspan="3"><%=rsSearch("objective")%></td>
                          </tr>
                          <tr> 
                            <td colspan="3">&nbsp;</td>
                          </tr>
                          <%end if
  end if
  index = index + 1
  rsSearch.MoveNext
  loop
  rsLastSearch("lastSearched") = now()
  rsLastSearch.Update
  %>
                          <% end if %>
                        </table>
                      </td>
                    </tr>
                  </table>
                  
                <p>&nbsp;</p></td>
              </tr>
            </table>
          </td>
          <td width="175" valign="top"> 
            <!-- #INCLUDE VIRTUAL='/inc/hms_menu.asp' -->
            <p>&nbsp;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="100%" height="10" bgcolor="#5187CA"> 
      <!-- #INCLUDE VIRTUAL='/inc/bottom_menu.asp' -->
    </td>
  </tr>
  <tr> 
    <td height="10" class="legal"><!-- #INCLUDE VIRTUAL='/inc/copyright.inc' --></td>
  </tr>
</table>
</body>

</html>