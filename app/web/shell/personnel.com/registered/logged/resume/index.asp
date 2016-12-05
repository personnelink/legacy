<% Response.Buffer = true %>
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrCookie.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->

<%
dim rsQres
Set rsQRes = Server.CreateObject("ADODB.RecordSet")
rsQRes.CursorLocation = 3
rsQRes.Open "SELECT res_id, mbr_id, res_is_deleted, res_filename, res_title, res_view_count, res_is_active, res_completion_flag, res_date_created FROM tbl_resumes WHERE mbr_id = " & session("mbrID") & " AND res_is_deleted = 0", Connect
%>

<html>
<head>
<title>Resume Center - www.personnel.com</title>
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
                <td bgcolor="E7E7E7"><a href="/index.asp" class="navLinks"> 
                    <!-- #INCLUDE VIRTUAL='/includes/textNav.asp' -->
                    </a>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="/images/headers/resumeCenter.gif" width="328" height="48"></td>
                      <td valign="bottom" align="right"></td>
                    </tr>
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="30" class="sideMenu"><img src="/images/pixel.gif" width="30" height="1"></td>
                            <td class="sideMenu" valign="bottom"> 
                              <table border="0" cellspacing="13" cellpadding="0">
                                <tr align="center"> 
                                  <td> 
                                    <table border="0" cellspacing="0" cellpadding="0">
                                      <tr> 
                                        <td align="left" width="10"><img src="/images/buttonL.gif" width="10" height="21"></td>
                                        <td bgcolor="#5187CA" align="center" nowrap class="buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a href="newResume/index.asp" class="buttons">Add 
                                          a New Resume</a>&nbsp;&nbsp;&nbsp;&nbsp; 
                                        </td>
                                        <td align="right" width="10"><img src="/images/buttonR.gif" width="10" height="21"></td>
                                      </tr>
                                    </table>
                                  </td>
                                  <td> 
                                    <table border="0" cellspacing="0" cellpadding="0">
                                      <tr> 
                                        <td align="left" width="10"><img src="/images/buttonL.gif" width="10" height="21"></td>
                                        <td bgcolor="#5187CA" align="center" nowrap class="buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a href="../career/index.asp" class="buttons">Resume 
                                          Advice/Info </a>&nbsp;&nbsp;&nbsp;&nbsp; 
                                        </td>
                                        <td align="right" width="10"><img src="/images/buttonR.gif" width="10" height="21"></td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td class="sideMenu" valign="bottom" align="right">&nbsp;</td>
                    </tr>
                  </table>
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">		  
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                      <td> 
                        <table width="100%" border="0" cellspacing="3" cellpadding="0">
<%
if rsQres.RecordCount = 0 then
%>						
<tr>
	<td align="left">No resume(s) have been created</td>
</tr>
<%
Else
%>		

<% Do Until rsQRes.eof %>
<tr> 
<td width="50" valign="top">
<% if rsQRes("res_filename") <> "empty" then %>
<a href="viewResume2.asp?id=<%=rsQRes("res_id")%>"><img src="/images/resumeIconLarge.gif" width="37" height="42" border="0"></a>
<% Else %>
<a href="viewResume.asp?id=<%=rsQRes("res_id")%>"><img src="/images/resumeIconLarge.gif" width="37" height="42" border="0"></a>
<% End if %>
</td>
<td colspan="4"> 
<table border="0" cellspacing="3" cellpadding="0" width="100%">
<tr> 
<td width="20%" nowrap><strong>Title:</strong></td>
<td width="80%" class="resTitle">
<% if rsQRes("res_filename") <> "empty" then %>
<a href=viewResume2.asp?id=<%=rsQRes("res_id")%>><%=rsQRes("res_title")%></a>
<% Else %>
<a href=viewResume.asp?id=<%=rsQRes("res_id")%>><%=rsQRes("res_title")%></a>
<% End if %>
</td>
</tr>
<tr> 
<td width="20%"><strong>Created On:</strong></td>
<td width="80%"><%=FormatDateTime(rsQRes("res_date_created"),1)%></td>
</tr>
<tr> 
<td width="20%"><strong>Employer Views:</strong></td>
<td width="80%">
<% 
if CInt(rsQRes("res_completion_flag")) <> 5 then 
response.write("<EM><STRONG><FONT color='#b22222'>Resume is incomplete!</FONT></STRONG></EM>")
 Else
response.write(rsQRes("res_view_count"))
end if
%>
</td>
</tr>
<tr>
<td width="20%"><strong>Resume Options:</strong></td>
<td width="80%">
<% if CInt(rsQRes("res_completion_flag")) <> 5 then %>
								  
<% Select Case CInt(rsQRes("res_completion_flag")) %>
<% Case 1 %>
 <a href="newResume/secondPage.asp?inc_id=<%=rsQRes("res_id")%>">Complete Resume</a> | <a href="deleteResume.asp?id=<%=rsQRes("res_id")%>">Delete</a>
<% Case 2 %>
<a href="newResume/thirdPage.asp?inc_id=<%=rsQRes("res_id")%>">Complete Resume</a> | <a href="deleteResume.asp?id=<%=rsQRes("res_id")%>">Delete</a>
<% Case 3 %>
<a href="newResume/fourthPage.asp?inc_id=<%=rsQRes("res_id")%>">Complete Resume</a> | <a href="deleteResume.asp?id=<%=rsQRes("res_id")%>">Delete</a>
<% Case 4 %>
<a href="newResume/fifthPage.asp?inc_id=<%=rsQRes("res_id")%>">Complete Resume</a> | <a href="deleteResume.asp?id=<%=rsQRes("res_id")%>">Delete</a>
<% End Select %>
	
<% Else %>	
<% if rsQRes("res_filename") <> "empty" then %>
<a href="viewResume2.asp?id=<%=rsQRes("res_id")%>">View</a>
<% Else %>
<a href="viewResume.asp?id=<%=rsQRes("res_id")%>">View</a> 
<% End if %>
|
<% if rsQRes("res_filename") <> "empty" then %>
<a href="edit/edit2.asp?id=<%=rsQRes("res_id")%>">Edit</a>
<% Else %>
<a href="edit/index.asp?id=<%=rsQRes("res_id")%>">Edit</a>
<% End if %>	
|
<% if rsQRes("res_filename") <> "empty" then %>
<a href="deleteResume2.asp?id=<%=rsQRes("res_id")%>&title=<%=rsQRes("res_title")%>">Delete</a>
<% Else %>
<a href="deleteResume.asp?id=<%=rsQRes("res_id")%>&title=<%=rsQRes("res_title")%>">Delete</a>
<% End if %>
|
<% Select Case CInt(rsQRes("res_is_active"))
   Case 1 %>
<a href="doChangeActive.asp?id=<%=rsQRes("res_id")%>">Deactivate</a> 
<% Case 0 %>
<a href="doChangeActive.asp?id=<%=rsQRes("res_id")%>">Activate</a> 
<% End Select %>


<% End if %>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td colspan="2"><br><br></td>
</tr>
<% rsQRes.MoveNext
   loop
end if
%>
                        </table>
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
<%
rsQRes.Close
Set rsQRes = Nothing
Connect.Close
Set Connect = Nothing
%>
</body>
</html>
