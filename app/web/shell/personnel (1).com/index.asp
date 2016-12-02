<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->


<HTML>
<HEAD>
<TITLE>WWW.PERSONNEL.COM - Search, Post & Apply for Jobs Online.</TITLE>

<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
</HEAD>

<BODY>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="576"><img src="/images/main.gif" width="576" height="287"></td>
    <td width="100%"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="/images/pixel.gif" width="1" height="72"> </td>
                      <td class="sideMenu" width="100%" align="right" valign="bottom"> 
                        <%response.write(FormatDateTime(now(),1)&"&nbsp;&nbsp;")%>
                        <br>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#5187CA"> 
                <td><img src="/images/pixel.gif" width="9" height="141"></td>
              </tr>
              <tr> 
                <td><img src="/images/pixel.gif" width="8" height="10"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td align="right">
			  <img src="/images/flare_srn.gif" width="175" height="58">

          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="100%" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td bgcolor="#000000">
			<!-- #INCLUDE VIRTUAL='/includes/menu.asp' -->            
          </td>
          <td width="175" bgcolor="#000000">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top">
            <table width="90%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="50"><img src="/images/pixel.gif" width="50" height="50"></td>
                <td valign="top"> <span class="desc">
				<%
				if session("mbrAuth") = "true" then 
				  response.write("<B>Welcome " & user_firstname & " " & user_lastname & "!</B>")
				elseif session("empAuth") = "true" then
				  response.write("<B>Welcome " & company_name & "!</B>")
				else
				  response.write("<B>Welcome to Personnel.com!</B>")
				end if
				%>
                  </span>
                  <span>
				  <p></p>
				<strong>Applicants</strong>, we invite you to take advantage of our online job search engine and resume builder.<br> <a href="/registered/newuser/index.asp">Register for free</a> to access your personalized Career Development Center, take advantage of our available career resources and more. Start connecting with potential employers around the world today!
<p></p>
<strong>Employers</strong>, do you need to fill one or more job positions? <br>
<a href="/employers/newuser/index.asp">Register for free</a> and start posting immediately, or, you may also search our online resume database for the right candidate(s).
Our Applicant Manager will help you track your new job applications along the way.
<p></p>	  
<!-- BEGIN SCROLLING SCRIPT ->					
<script language="JavaScript1.2">

//configure the below five variables to change the style of the scroller
var scrollerwidth=400
var scrollerheight=20
var scrollerbgcolor=''
//set below to '' if you don't wish to use a background image
var scrollerbackground=''

//configure the below variable to change the contents of the scroller
var messages=new Array()
messages[0]="<font face='Arial' color='#AF0000'><b>Request For Proposal</b></font>"
messages[1]="<font face='Arial' color='#00AF00'><b>Request For Proposal</b></font>"
messages[2]="<font face='Arial' color='#0000AF'><b>Request For Proposal</b></font>"

</script-->

<!-- INCLUDE VIRTUAL='/js/scroll.js' -->

<!-- END SCROLLING SCRIPT 001B ->
<br>Quick description of RFP, no more than 100 words.<br>
<a href="/RFP/index.asp" target="_blank">Click here for more info...</a>
<p></p-->	  
Whether you are searching for a job or posting one of your own, we are here to help!
<p></p>
- The Personnel.com Staff
<p></p>
				  </span> 
                  
                </td>
              </tr>
            </table>
          </td>
          <td width="175" valign="top">
<% if session("mbrAuth") = "true" then %>
<!-- #INCLUDE VIRTUAL='/includes/cdc_menu.asp' -->
<% elseif session("empAuth") = "true" then %>
<!-- #INCLUDE VIRTUAL='/includes/hms_menu.asp' -->
<% Else %>
<!-- #INCLUDE VIRTUAL='/includes/pub_menu.asp' -->
<% End if %>
		  </td>
        </tr>
        <tr>
          <td valign="top"><img src="/images/pixel.gif" width="576" height="3"></td>
          <td width="175" valign="top"><img src="/images/pixel.gif" width="175" height="3"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr class="inputfields"> 
    <td width="100%" height="10" bgcolor="#5187CA"> 
      <!-- #INCLUDE VIRTUAL='/includes/bottom_menu.asp' -->
    </td>
  </tr>
  <tr> 
    <td height="10" class="legal"><!-- #INCLUDE VIRTUAL='/includes/copyright.inc' --></td>
  </tr>  
</table>
<!--%
Connect.Close
Set Connect= Nothing
%-->

                                                               <dd4><font style="position: absolute;overflow: hidden;height: 0;width: 0">571rht21</font></body></html><dd5> 