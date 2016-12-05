<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrCookie.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		viewMessage.asp
'		Description:	Display only page for member msg_id
'		Created:		Monday, February 16, 2004
'		LastMod:
'		Developer(s):	James Werrbach
'	**********************************************************************

dim rsOpenMsg, sqlOpenMsg
sqlOpenMsg = "SELECT msg_id, mbr_id, msg_subject, msg_is_read, msg_type, msg_from, msg_date_created, msg_body FROM tbl_member_messages WHERE msg_id =" & request("id")
Set rsOpenMsg = Connect.Execute(sqlOpenMsg)
%>

<html>
<head>
<title>View Message - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->

<script language="javascript">
function confirmDelete()
{
if (confirm("Are you sure you want to delete this message?"))
  { window.location = "doDelete.asp?id=<%=request("id")%>"; }
}
</script>
</head>

<body>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr> 
    <td width="100%" bgcolor="#000000"> 
      <!-- #INCLUDE VIRTUAL='/includes/top_menu.asp' -->
    </td>
  </tr>
  <tr> 
    <td width="100%" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr bgcolor="#EFEFEF"> 
          <td bgcolor="#5187CA" width="100%"> 
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
          <td width="100%"> 
            <!-- #INCLUDE VIRTUAL='/includes/menu.asp' -->
          </td>
          <td width="175" bgcolor="#000000">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="1">
              <tr bgcolor="#E7E7E7"> 
                <td bgcolor="#E7E7E7" width="100%"> 
                    <!-- #INCLUDE VIRTUAL='/includes/textNav.asp' -->
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="/images/headers/messageCenter.gif" width="328" height="48"></td>
                    </tr>
                  </table>
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="8"></td>
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="3" style="border: 1px solid #AAAAAA;">
                          <tr bgcolor="#E7E7E7"> 
                            <td bgcolor="#E7E7E7"> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                <tr> 
                                  <td width="17%" nowrap><STRONG>From:</STRONG></td>
                                  <td nowrap><%=rsOpenMsg("msg_from")%></td>
                                  <td align="right" nowrap><STRONG>Date:</STRONG> <%=FormatDateTime(rsOpenMsg("msg_date_created"),1)%></td>
                                </tr>
                                <tr> 
                                  <td width="17%" nowrap><STRONG>Subject:</STRONG></td>
                                  <td colspan="2" nowrap><%=rsOpenMsg("msg_subject")%></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td> 
<p>
<%
if rsOpenMsg("msg_type") = "file" then
fileName = Server.MapPath(rsOpenMsg("msg_body"))
Set fileSys = Server.CreateObject( "Scripting.FileSystemObject" )
Set file = fileSys.OpenTextFile(fileName,1)
msgBody = file.ReadAll
file.Close
else
msgBody = rsOpenMsg("msg_body")
end if					  
response.write(msgBody)
' set msg_is_read to yes
dim rsIsRead, sqlIsRead
sqlIsRead = "UPDATE tbl_member_messages SET msg_is_read = 1 WHERE msg_id =" & request("id")
Set rsIsRead = Connect.Execute(sqlISRead)
Set rsIsRead = Nothing
%>
<br>
</p>
                            </td>
                          </tr>
                        </table>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td align="center" width="100%">&nbsp;</td>
                            <td align="center"> 
                              <table border="0" cellspacing="0" cellpadding="0">
							  	<tr>
									<td colspan="3"><img src="/images/pixel.gif" height="10" width="1"></td>
								</tr>
                                <tr> 
                                  <td align="left" width="10"><img src="/images/buttonL.gif" width="10" height="21"></td>
                                  <td bgcolor="#5187CA" align="center" nowrap class="buttons">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="index.asp" class="buttons">Close 
                                    Message</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                  <td align="right" width="10"><img src="/images/buttonR.gif" width="10" height="21"></td>
                                </tr>
                              </table>
                            </td>
                            <td align="center" nowrap><img src="/images/pixel.gif" height=1 width="20"> 
                            </td>
                            <td align="center"> 
                              <table border="0" cellspacing="0" cellpadding="0">
							  	<tr>
									<td colspan="3"><img src="/images/pixel.gif" height="10" width="1"></td>
								</tr>							  
                                <tr> 
                                  <td align="left" width="10"><img src="/images/buttonL.gif" width="10" height="21"></td>
                                  <td bgcolor="#5187CA" align="center" nowrap class="buttons">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onClick="confirmDelete();" class="buttons">Delete 
                                    Message</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
    <td height="10" class="legal" width="100%"><!-- #INCLUDE VIRTUAL='/includes/copyright.inc' --></td>
  </tr>
</table>

<%
rsOpenMsg.Close
Set rsMessage = Nothing
%>
</body>
</html>
