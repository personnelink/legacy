<%
if session("mbrAuth") = "true" then
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td class="header">&nbsp;&nbsp;<%=user_firstname%>&nbsp;<%=user_lastname%> 
      - <%=FormatDateTime(now(),1)%></td>
    <td align="right" class="header"><a href="/index.asp"><font color="#FFFFFF">Home</font></a> 
      &nbsp;|&nbsp; <a href="/registered/logged/logout.asp"><font color="#FFFFFF">Logout</font></a>&nbsp; 
      |&nbsp;<font color="#333333"> <a href="/registered/logged/help/index.asp" class=help><font color="#FFFFFF">Help</font></a></font>&nbsp;&nbsp;</td>
  </tr>
</table>
<%
elseif session("empAuth") = "true" then
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td class="header">&nbsp;&nbsp;<%=company_name%> 
      - <%=FormatDateTime(now(),1)%></td>
    <td align="right" class="header"><a href="/index.asp"><font color="#FFFFFF">Home</font></a> 
      &nbsp;|&nbsp; <a href="/employers/logged/logout.asp"><font color="#FFFFFF">Logout</font></a>&nbsp; 
      |&nbsp; <font color="#333333"><a href="/employers/logged/help/index.asp" class=help><font color="#FFFFFF">Help</font></a></font>&nbsp;&nbsp;</td>
  </tr>
</table>
<%
elseif session("admAuth") = "true" then
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td class="header">&nbsp;&nbsp;<%=FormatDateTime(now(),1)%></td>
    <td align="right" class="header"><a href="/index.asp"><font color="#FFFFFF">Home</font></a> 
      &nbsp;|&nbsp; <a href="/admin/logged/logout.asp"><font color="#FFFFFF">Logout</font></a>&nbsp; 
      |&nbsp; <font color="#333333"> <a href="/help/index.asp" class=help><font color="#FFFFFF">Help</font></a></font>&nbsp;&nbsp;</td>
  </tr>
</table>
<%
else
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td class="header">&nbsp;&nbsp;<%=FormatDateTime(now(),1)%></td>
    <td align="right" class="header"><a href="/index.asp"><font color="#FFFFFF">Home</font></a> 
      &nbsp;|&nbsp;&nbsp;<a href="/chooseLogin.asp"><font color="#FFFFFF">Login</font></a>&nbsp; 
      |&nbsp; <a href="/help/index.asp" class=help><font color="#FFFFFF">Help</font></a>&nbsp;&nbsp;</td>
  </tr>
</table>
<%
end if
%>