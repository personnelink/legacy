<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->

<%
Set rsMsgs = Server.CreateObject("ADODB.RecordSet")
rsMsgs.CursorLocation = 3
rsMsgs.Open "SELECT msg_id, mbr_id, msg_is_read, msg_from, msg_subject, msg_date_created FROM tbl_member_messages WHERE mbr_id = " & session("mbrID") & " ORDER BY msg_date_created DESC",Connect
%>

<html>
<head>
<title>Member Message Center - www.personnel.com</title>
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
                <td> <img src="/images/headers/messageCenter.gif" width="328" height="48"> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="8"></td>
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="4">
                          <tr> 
                            <td colspan="3"> 
                              <div align="right"><img src="/images/ico_new_mail.gif" alt="" width="13" height="9" border="0"> - New Message(s)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/images/ico_old_mail.gif" alt="" width="13" height="9" border="0"> - Old Message(s)</div>
                            </td>
                          </tr>
                          <tr bgcolor="#E7E7E7"> 
                            <td><b>Subject:</b></td>
                            <td><b>From:</b></td>
                            <td><b>Date:</b></td>
                          </tr>
<%
if rsMsgs.eof = true and rsMsgs.BOF = true then
%>

						  <tr>
						  	<td colspan="3" align="left"><em>No Messages</em></td>
						  </tr>
<%
Else
%>

						  
<%
do until rsMsgs.eof
%>
                          <tr bgcolor="#FFFFFF"> 
                            <td> 
<%
  if CInt(rsMsgs("msg_is_read")) = 0 then
%>
<img src="/images/ico_new_mail.gif" alt="" width="13" height="9" border="0">				  
<a href="viewMessage.asp?id=<%=rsMsgs("msg_id")%>"><strong><%=rsMsgs("msg_subject")%></strong></a>
<% 
  else 
%>
<img src="/images/ico_old_mail.gif" alt="" width="13" height="9" border="0">	
<a href="viewMessage.asp?id=<%=rsMsgs("msg_id")%>"><%=rsMsgs("msg_subject")%></a>
<% 
  end if 
%>
                            </td>
                            <td><%=rsMsgs("msg_from")%></td>
                            <td><%=rsMsgs("msg_date_created")%></td>
                          </tr>
<%
rsMsgs.MoveNext
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
</body>
</html>
<%
rsMsgs.Close
Set rsMsgs = Nothing
Connect.Close
Set Connect = Nothing
%>
