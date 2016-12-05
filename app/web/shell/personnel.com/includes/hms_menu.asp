<%
'	*************************  File Description  *************************
'		FileName:		hms_menu.asp
'		Description:	Include file - counts messages and resume applications, displays
'						links to each if available.
'		Created:		Wednesday, February 18, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************

qString = request.serverVariables("QUERY_STRING")

qString = replace(qstring,"menu=change","")
qString = replace(qstring,"&smMessages=open","")
qString = replace(qstring,"&smMessages=close","")
qString = replace(qstring,"&smAppointments=open","")
qString = replace(qstring,"&smAppointments=close","")
qString = replace(qstring,"&smApplicantTracker=open","")
qString = replace(qstring,"&smApplicantTracker=close","")

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
          <td bgcolor="E7E7E7" class="header">
		    <%if request("smMessages") = "open" then session("smMessages") = "open"%>
			<%if request("smMessages") = "close" or session("smMessages") = "close" then
		      session("smMessages") = "close"%>
			  &nbsp;&nbsp;<a href="<%=thePage%>smMessages=open"><img src="/images/plus.gif" width="11" height="11" align="absmiddle" border="0"></a>
			  &nbsp;&nbsp;
			  <font color="#000000">New Messages</font>
			<%else
			  session("smMessages") = "open"%>
			  &nbsp;&nbsp;<a href="<%=thePage%>smMessages=close"><img src="/images/minus.gif" width="11" height="11" align="absmiddle" border="0"></a>
			  &nbsp;&nbsp;
			  <font color="#000000">New Messages</font>
			<%end if%></td>
        </tr>
		<%if session("smMessages") = "open" then%>
        <tr> 
          <td width="100%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="6">
              <tr>
                <td class="sideMenu">
                  <table width="100%" border="0" cellspacing="2" cellpadding="1">
					<tr> 
                      <td class="sideMenu">
					    <%=session("numMsg")%>&nbsp;New Message(s)</td>
                    </tr>
                    <% if msgCount > 0 then %>
                    <tr> 
                      <td class="sideMenu" bgcolor="E7E7E7">Subject</td>
                    </tr>
                    <% do until rsNewMsgs.eof %>
                    <tr> 
                      <td class="sideMenu"><A HREF='/employers/logged/messages/viewMessage.asp?ID=<%=rsNewMsgs("msg_id")%>'><FONT Color=gray><%=rsNewMsgs("msg_subject")%></font></A></td>
                    </tr>
                    <% rsNewMsgs.MoveNext
					    loop
					 end if
				 	 %>
					<tr>
					  <td><hr noshade size="1" color="#e7e7e7">
                        <a href="/employers/logged/messages/index.asp" class="sideLink">Message 
                        Center</a></td>
					</tr>  
                  </table>
                  
                </td>
              </tr>
            </table>
            
          </td>
        </tr>
		<%end if%>
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
                      
          <td bgcolor="E7E7E7" class="header">
		    <%if request("smApplicantTracker") = "open" then session("smApplicantTracker") = "open"%>
			<%if request("smApplicantTracker") = "close" or session("smApplicantTracker") = "close" then
		      session("smApplicantTracker") = "close"%>
			  &nbsp;&nbsp;<a href="<%=thePage%>smApplicantTracker=open"><img src="/images/plus.gif" width="11" height="11" align="absmiddle" border="0"></a>
			  &nbsp;&nbsp;
			  <font color="#000000">Applicant Tracker</font>
			<%else
			  session("smApplicantTracker") = "open"%>
			  &nbsp;&nbsp;<a href="<%=thePage%>smApplicantTracker=close"><img src="/images/minus.gif" width="11" height="11" align="absmiddle" border="0"></a>
			  &nbsp;&nbsp;
			  <font color="#000000">Applicant Tracker</font>
			<%end if%></td>
        </tr>
		<%if session("smApplicantTracker") = "open" then%>
        <tr> 
          <td width="100%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="6">
              <tr>
                <td class="sideMenu">
                  <table width="100%" border="0" cellspacing="2" cellpadding="1">
					<tr> 
                      <td class="sideMenu">
					    <%=session("numApps")%>&nbsp;Job Application(s) Received</td>
                    </tr>
                    <% if numApps > 0 then %>
                    <tr> 
                      <td class="sideMenu" bgcolor="E7E7E7">Subject</td>
                    </tr>
                    <% do until rsApps.eof %>
                    <tr> 
                      <td class="sideMenu"><A HREF='/employers/logged/messages/viewMessage.asp?ID=<%=rsApps("msg_id")%>'><FONT Color=gray><%=rsApps("msg_subject")%></font></A></td>
                    </tr>
                    <% rsApps.MoveNext
					    loop
					rsApps.Close
					Set rsApps = Nothing
					 end if
				 	 %>
					<tr>
					  <td><hr noshade size="1" color="#e7e7e7">
                        <a href="/employers/logged/resumes/index.asp" class="sideLink">Applicant Manager</a></td>
					</tr>  
                  </table>
                  
                </td>
              </tr>
            </table>
            
          </td>
        </tr>
		<%end if%>
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


