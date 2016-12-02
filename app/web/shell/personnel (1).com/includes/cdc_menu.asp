<%
'	*************************  File Description  *************************
'		FileName:		cdc_menu.asp
'		Description:	Include file - counts messages and completed resumes, displays
'						links to each if available. Also sets count of each item
'						into Session variables: numMsg, numRes for use in all
'						pages which include this file.
'		Created:		Wednesday, January 21, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************

' // Member Messages
dim rsNewMsgCount, sqlNewMsgCount, msgCount
sqlNewMsgCount = "SELECT COUNT(msg_id) AS number FROM tbl_member_messages WHERE mbr_id = " & session("mbrID") & " AND msg_is_read = 0"
Set rsNewMsgCount = Connect.Execute(sqlNewMsgCount)
msgCount = rsNewMsgCount("number")
session("numMsg") = msgCount
rsNewMsgCount.Close
Set rsNewMsgCount = Nothing

if msgCount > 0 then
  dim rsNewMsgs, sqlNewMsgs
  sqlNewMsgs = "SELECT msg_id, mbr_id, msg_subject, msg_is_read FROM tbl_member_messages WHERE mbr_id =" & session("mbrID") & " AND msg_is_read = 0"
  Set rsNewMsgs = Connect.Execute(sqlNewMsgs)
end if

' // Member Resumes
' NOTE: if a resume does not have a completion flag value of 5 then it is incomplete and
' we ignore it. We also don't display if res_is_deleted = 1 (a deleted resume)

dim rsCountMbrRes, sqlCountMbrRes, countOfRes, rsLoadResIds, sqlLoadResIds
sqlCountMbrRes = "SELECT COUNT(res_id) AS number FROM tbl_resumes WHERE mbr_id=" & session("mbrID") & " AND res_completion_flag = 5 AND res_is_deleted = 0"
Set rsCountMbrRes = Connect.Execute(sqlCountMbrRes)
countOfRes = rsCountMbrRes("number")
session("numRes") = countOfRes
rsCountMbrRes.Close
Set rsCountMbrRes = Nothing

if countOfRes > 0 then ' get resume ID numbers
sqlLoadResIds = "SELECT res_id, mbr_id, res_is_deleted, res_title, res_is_active, res_filename, res_view_count FROM tbl_resumes WHERE mbr_id=" & session("mbrID") & " AND res_is_deleted = 0"
Set rsLoadResIds = Connect.Execute(sqlLoadResIds)
end if

qString = request.serverVariables("QUERY_STRING")

qString = replace(qstring,"menu=change","")
qString = replace(qstring,"&smMessages=open","")
qString = replace(qstring,"&smMessages=close","")
qString = replace(qstring,"&smResume=open","")
qString = replace(qstring,"&smResume=close","")
qString = replace(qstring,"&smJobAgents=open","")
qString = replace(qstring,"&smJobAgents=close","")
qString = replace(qstring,"&smJobTracker=open","")
qString = replace(qstring,"&smJobTracker=close","")

if qString <> "" AND left(qString,1) <> "&" then mark = "&"
thePage = request.serverVariables("URL") & "?menu=change" & mark & qString & "&"
%>               
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="1" height="1" bgcolor="#E7E7E7"><img src="/images/pixel.gif" width="1" height="1"></td>
    <td height="1" bgcolor="#E7E7E7"><img src="/images/pixel.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td width="1" bgcolor="#E7E7E7"><img src="/images/pixel.gif" width="1" height="1"></td>
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">

        <tr> 
          <td bgcolor="#E7E7E7" class="header">
		    <% if request("smMessages") = "open" then session("smMessages") = "open"%>
			<% if request("smMessages") = "close" or session("smMessages") = "close" then
		      session("smMessages") = "close"%>
			  &nbsp;&nbsp;<a href="<%=thePage%>smMessages=open"><img src="/images/plus.gif" width="11" height="11" align="absmiddle" border="0"></a>
			  &nbsp;&nbsp;
			  <font color="#000000">New Messages</font>
			<% Else
			  session("smMessages") = "open"%>
			  &nbsp;&nbsp;<a href="<%=thePage%>smMessages=close"><img src="/images/minus.gif" width="11" height="11" align="absmiddle" border="0"></a>
			  &nbsp;&nbsp;
			  <font color="#000000">New Messages</font>
			<% End if %></td>
        </tr>
		<% if session("smMessages") = "open" then %>
        <tr> 
          <td width="100%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="8">
              <tr>
                <td class="sideMenu">
                  <table width="100%" border="0" cellspacing="2" cellpadding="1">
                    <tr> 
                      <td class="sideMenu"><%=msgCount%>&nbsp;New 
                        Message(s)</td>
                    </tr>
                    <% if msgCount > 0 then 

					%>
                    <tr> 
                      <td bgcolor="#E7E7E7" class="sideMenu">Subject</td>
                    </tr>
                    <% Do Until rsNewMsgs.eof %>
                    <tr> 
                      <td class="sideMenu"><A HREF="/registered/logged/messages/viewMessage.asp?id=<%=rsNewMsgs("msg_id")%>"><%=rsNewMsgs("msg_subject")%></A></td>
                    </tr>
                    <% rsNewMsgs.MoveNext
					    loop
					rsNewMsgs.Close
					Set rsNewMsgs = Nothing
					 end if
				 	 %>
					<tr>
					  <td>
                        <hr size="1" color="#E7E7E7" noshade>
                        <a HREF="/registered/logged/messages/index.asp" class="sidelink">Message 
                        Center</a></td>
					</tr>
                  </table>
                </td>
              </tr>
            </table>
            
          </td>
        </tr>
		<% End if %>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="1" height="1" bgcolor="#E7E7E7"><img src="/images/pixel.gif" width="1" height="1"></td>
    <td height="1" bgcolor="#E7E7E7"><img src="/images/pixel.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td width="1" height="1"><img src="/images/pixel.gif" width="1" height="1"></td>
    <td height="6"><img src="/images/pixel.gif" width="1" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="1" height="1" bgcolor="#E7E7E7"><img src="/images/pixel.gif" width="1" height="1"></td>
    <td height="1" bgcolor="#E7E7E7"><img src="/images/pixel.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td width="1" bgcolor="#E7E7E7"><img src="/images/pixel.gif" width="1" height="1"></td>
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
		    <td bgcolor="#E7E7E7" class="header">
			<%if request("smResume") = "open" then session("smResume") = "open"%>
			<%if request("smResume") = "close" or session("smResume") = "close" then
		      session("smResume") = "close"%>
			  &nbsp;&nbsp;<a href="<%=thePage%>smResume=open"><img src="/images/plus.gif" width="11" height="11" align="absmiddle" border="0"></a>
			  &nbsp;&nbsp;
			  <font color="#000000">Resume Tracker</font>
			<%else
			  session("smResume") = "open"%>
			  &nbsp;&nbsp;<a href="<%=thePage%>smResume=close"><img src="/images/minus.gif" width="11" height="11" align="absmiddle" border="0"></a>
			  &nbsp;&nbsp;
			  <font color="#000000">Resume Tracker</font>
			<%end if%>
			</td>
        </tr>
		<%if session("smResume") = "open" then%>
        <tr> 
          <td width="100%">
            <table width="100%" border="0" cellspacing="0" cellpadding="8">
              <tr> 
                <td class="sideMenu"> 
                  <table width="100%" border="0" cellspacing="2" cellpadding="1">
                    <tr> 
                      <td class="sideMenu"><%=countOfRes%>&nbsp;<font color="#000000">Resume(s) 
                        Online</font> </td>
                      <td width="15%" class="sideMenu">&nbsp;</td>
                    </tr>
                    <% if countOfRes > 0 then %>
                    <tr> 
                      <td class="sideMenu" bgcolor="#E7E7E7">Title</td>
                      <td width="15%" class="sideMenu" bgcolor="#E7E7E7">Hits</td>
                    </tr>
                    <% do until rsLoadResIds.eof %>
                    <tr> 
                      <td class="sideMenu">
<% if rsLoadResIds("res_filename") = "empty" then %>					  
<A HREF="/registered/logged/resume/viewResume.asp?id=<%=rsLoadResIds("res_id")%>"><%=rsLoadResIds("res_title")%></A>
<% Else %>
<A HREF="/registered/logged/resume/viewResume2.asp?id=<%=rsLoadResIds("res_id")%>"><%=rsLoadResIds("res_title")%></A>
<% End if %>
</td>
                      <td width="15%" align=center class="sideMenu"><%=rsLoadResIds("res_view_count")%></td>
                    </tr> <% rsLoadResIds.MoveNext
					    loop
					 rsLoadResIds.Close
					 Set rsLoadResIds = Nothing
					 end if%>
                    <tr> 
                      <td colspan="2">
                        <hr size="1" color="#E7E7E7" noshade>
                        <a href="/registered/logged/resume/index.asp" class="sideLink">Resume 
                        Center</a></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
		<% End if %>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="1" height="1" bgcolor="#E7E7E7"><img src="/images/pixel.gif" width="1" height="1"></td>
    <td height="1" bgcolor="#E7E7E7"><img src="/images/pixel.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td width="1" height="1"><img src="/images/pixel.gif" width="1" height="1"></td>
    <td height="6"><img src="/images/pixel.gif" width="1" height="1"></td>
  </tr>
</table>

         



