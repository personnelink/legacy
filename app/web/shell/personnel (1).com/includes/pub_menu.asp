<%
qString = request.serverVariables("QUERY_STRING")

qString = replace(qstring,"menu=change","")
qString = replace(qstring,"&smJobSeekers=open","")
qString = replace(qstring,"&smJobSeekers=close","")
qString = replace(qstring,"&smEmployers=open","")
qString = replace(qstring,"&smEmployers=close","")

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
          <td background="/images/td_bkg_22b.gif" class="header"> 
            <%if request("smJobSeekers") = "open" then session("smJobSeekers") = "open"%>
            <%if request("smJobSeekers") = "close" or session("smJobSeekers") = "close" then
		      session("smJobSeekers") = "close"%>
            &nbsp;&nbsp;<a href="<%=thePage%>smJobSeekers=open"><img src="/images/plus.gif" width="11" height="11" align="absmiddle" border="0" alt="Show Menu"></a> 
            &nbsp;&nbsp; <font color="#ffffff">Applicant Tools</font> 
            <%else
			  session("smJobSeekers") = "open"%>
            &nbsp;&nbsp;<a href="<%=thePage%>smJobSeekers=close"><img src="/images/minus.gif" width="11" height="11" align="absmiddle" border="0" alt="Hide Menu"></a> 
            &nbsp;&nbsp; <font color="#ffffff">Applicant Tools</font> 
            <%end if%>
          </td>
        </tr>
        <%if session("smJobSeekers") = "open" then%>
        <tr> 
          <td width="100%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
              <tr> 
                <td class=sideMenu>
<a href="/help/index.asp"><font color="#000000">&#149;&nbsp; First-Time Users</font></a>
<br>
<a href="/registered/login.asp"><font color="#000000">&#149;&nbsp; Applicant Login</font></a>
<br>
<a href="/registered/newuser/index.asp"><font color="#000000">&#149;&nbsp; Post a Resume</font></a>
<br>
<a href="/registered/newuser/index.asp"><font color="#000000">&#149;&nbsp; Register For Free</font></a>
<br>
<a href="/search/index.asp"><font color="#000000">&#149;&nbsp; Search Jobs Online</font></a>
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
    <td width="1" height="1" bgcolor="#999999"><img src="/images/pixel.gif" width="1" height="1"></td>
    <td height="1" bgcolor="#999999"><img src="/images/pixel.gif" width="1" height="1"></td>
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
          <td background="/images/td_bkg_22b.gif" class="header"> 
            <%if request("smEmployers") = "open" then session("smEmployers") = "open"%>
            <%if request("smEmployers") = "close" or session("smEmployers") = "close" then
		      session("smEmployers") = "close"%>
            &nbsp;&nbsp;<a href="<%=thePage%>smEmployers=open"><img src="/images/plus.gif" width="11" height="11" align="absmiddle" border="0" alt="Show Menu"></a> 
            &nbsp;&nbsp;&nbsp;<font color="#ffffff">Employer Tools</font> 
            <%else
			  session("smEmployers") = "open"%>
            &nbsp;&nbsp;<a href="<%=thePage%>smEmployers=close"><img src="/images/minus.gif" width="11" height="11" align="absmiddle" border="0" alt="Hide Menu"></a> 
            &nbsp;&nbsp; <font color="#ffffff"> Employer Tools</font> 
            <%end if%>
          </td>
        </tr>
        <%if session("smEmployers") = "open" then%>
        <tr> 
          <td width="100%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
              <tr> 
                <td class=sideMenu> 
<a href="/employers/login.asp"><font color="#000000">&#149;&nbsp; Employer Login</font></a>
<br>	
<a href="/help/index.asp"><font color="#000000">&#149;&nbsp; First-Time Users</font></a>
<br>
<a href="/employers/login.asp"><font color="#000000">&#149;&nbsp; Post a Job</font></a>
<br>		
<a href="/employers/newuser/index.asp"><font color="#000000">&#149;&nbsp; Register For Free</font></a>
				  <br>
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
    <td width="1" height="1" bgcolor="#999999"><img src="/images/pixel.gif" width="1" height="1"></td>
    <td height="1" bgcolor="#999999"><img src="/images/pixel.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td width="1" height="1"><img src="/images/pixel.gif" width="1" height="1"></td>
    <td height="6"><img src="/images/pixel.gif" width="1" height="1"></td>
  </tr>
</table>
            
