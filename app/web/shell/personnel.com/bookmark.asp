<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->

<html>
<head>
<title>Bookmark / Add To Favorites - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
          <td bgcolor="#5187CA" width="175" valign="top">
            <% if session("auth") = "true" then %>
            <img src='/images/flare_cdc.gif' width='175' height='76'>
            <% elseif session("employersAuth") = "true" then %>
            <img src='/images/flare_hms.gif' width='175' height='76'>
            <% else %>
            <img src='/images/flare_srn_w.gif' width='175' height='76'>
            <% end if %>
          </td>
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
                <td bgcolor="#E7E7E7"> 
                  <p class="navLinks"> 
                    <!-- #INCLUDE VIRTUAL='/includes/textNav.asp' -->
                  </p>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td> <font color="#6699CC"><b><font size="3"><br>
                  Bookmark Us</font></b></font> 
                  <p><b>For Netscape Navigator or Netscape Communicator: </b></p>
                  <ol>
                    <li>Right click on this link: <a href="http://www.personnel.com"> 
                      http://www.personnel.com</a></li>
                    <li>From the pop up menu click &quot; Add Bookmark. &quot; 
                    </li>
                  </ol>
                  <p>Personnel.com should now appear in your Netscape Bookmarks 
                    list.</p>
                  <p><b>For Microsoft Internet Explorer: </b></p>
                  <ol>
                    <li>Right click on this link <a href="http://www.personnel.com%20">http://www.personnel.com</a> 
                    </li>
                    <li>From the pop up menu click &quot; Add to Favorites. &quot; 
                    </li>
                    <li>Click the OK button to confirm your selection.</li>
                  </ol>
                  <p>Personnel.com should now appear in your Internet Explorer 
                    Favorites list.</p>
                  <blockquote>&nbsp;</blockquote>
                </td>
              </tr>
            </table>
          </td>
          <td width="175" valign="top"> 
            <p> 
              <%
			  if session("auth") = "true" then%>
              <!-- #INCLUDE VIRTUAL='/includes/cdc_menu.asp' -->
              <% elseif session("employersAuth") = "true" then%>
              <!-- #INCLUDE VIRTUAL='/includes/hms_menu.asp' -->
              <% else %>
              <!-- #INCLUDE VIRTUAL='/includes/pub_menu.asp' -->
              <% end if
			%>
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
    <td height="10" class="legal"><!-- #INCLUDE VIRTUAL='/includes/copyright.inc' --></td>
  </tr>
</table>
</body>
</html>
