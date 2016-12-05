<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpAuth.asp' -->
<%
'	*************************  File Description  *************************
'		FileName:		index.asp
'		Description:	Main help page for employers
'		Created:		Monday, February 16, 2004
'		LastMod:
'		Developer(s):	James Werrbach
'	**********************************************************************
%>
<html>
<head>
<title>Online Help for Employers - www.personnel.com</title>
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
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_hms.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <!-- #INCLUDE VIRTUAL='/includes/menu.asp' -->
          </td>
          <td width="175">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#E7E7E7"> 
                <td> 
                  <p class="navLinks"> 
                    <!-- #INCLUDE VIRTUAL='/includes/textNav.asp' -->
                  </p>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="3">
                    <tr> 
                      <td colspan="2" class="menu"><img src="/images/headers/helpSystem.gif" width="328" height="48"></td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td> 
                        <p>The help system is broken down into the following sections. 
                          Please choose a heading and you will be directed to 
                          that section.</p>
                        <ul>
                          <li><a href="#account">Account Information</a></li>	
                          <li><a href="#applicant">Applicants</a></li>		
                          <li><a href="#listing">Job Listings</a></li>						  				  					
                          <li><a href="#message">Message Center</a></li>
                          <li><a href="#resume">Resume Search</a></li>						  



                        </ul>
                        <p>if you are unable to find an answer to your question(s) here, please feel free 
                          to <a href="mailto:webmaster@personnel.com">contact 
                          us</a>.
                        </p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <hr width="90%" noshade size="1">
                      </td>
                    </tr>
<tr> 
                      <td colspan="2" class="hlpHeading"><a name="account"></a><a href="/employers/logged/account/index.asp">Account Information</a></td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td width="100%" valign="top">This is where 
                        you can change all your personal settings such as your password, contact information, and preferences. </td>
                    </tr>
                    <tr> 
                      <td colspan="2">
                        <hr width="90%" noshade size="1">
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2" class="hlpHeading"><a name="applicant"></a><a href="/employers/logged/resumes/index.asp">Applicants</a></td>
                    </tr>	
                    <tr> 
                      <td>&nbsp;</td>
                      <td width="100%" valign="top">The applicants section displays any resumes that have been submitted for your review. You will be able to view each applicants 
                        resume and what job(s) they are associated 
                        with. </td>
                    </tr>	
                    <tr> 
                      <td colspan="2">
                        <hr width="90%" noshade size="1">
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2" class="hlpHeading"><a name="listing"></a><a href="/employers/logged/listing/index.asp">Job Listings</a></td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td width="100%" valign="top"> 
                        <p>This is probably the most important tool at your disposal. 
                          In the job listings section you can add, edit, and view 
                          current job listings. You can also view how many times a particular listing has been viewed by job seekers.</p>
                        <p><STRONG>Add a New Job Listing</STRONG><br>
                          From the Job 
                          Listings</a> section click on the <strong>Post New Job</strong> link. 
                          The system will take you through the process of creating 
                          one or more job listings. After you have added a new listing you will be 
                          able to view, edit, or delete the listing.</p>
                        <p><STRONG>Edit a Job Listing</STRONG><br>
                          From the Job 
                          Listings section select the job you wish 
                          to edit and click the <strong>Edit</strong> link from the list of options. You will then be brought to an area that allows you to edit and save any changes you make.</p>
                        <p><STRONG>View a Job Listing</STRONG><br>
                          From the Job 
                          Listings section select the job you wish 
                          to view and click on the <strong>View</strong> option. You will be presented with 
                          a detailed view of your job listing.</p>
                        <p><STRONG>Delete a Job Listing</STRONG><br>
                          From the Job 
                          Listings section scroll down to the job you wish 
                          to delete and click on the <strong>Delete</strong> option. You will be 
                          brought to a screen that will show you the job information 
                          and give you a final confirmation before the listing 
                          is deleted.</p>
                        </td>
                    </tr>
                    <tr> 
                      <td colspan="2">
                        <hr width="90%" noshade size="1">
                      </td>
                    </tr>																											
                    <tr> 
                      <td colspan="2" class="hlpHeading"><a name="message"></a><a href="/employers/logged/messages/index.asp">Message Center</a></td>
                    </tr>					
                    <tr> 
                      <td><img src="/images/pixel.gif" width="25" height="10"></td>
                      <td width="100%" valign="top"> 
                        <p>The message center 
                          serves as a place for you to track your communications with potential employees. From time to time we may also use the message center to notify you about system changes or new features.</p>
                        <p><STRONG>Saving Messages</STRONG><br>
                          You can keep messages in your message box as long as 
                          needed. We do not perform any kind of automatic cleaning of 
                          your message box.</p>
                        <p><STRONG>Deleting Messages</STRONG><br>
                          You can delete a message after it has been read. To delete a message, choose the 
                          delete option while you have the message opened 
                          for viewing.</p>
                        <p><STRONG>Reading Messages</STRONG><br>
                          Your new messages will be marked in <STRONG>bold</STRONG> and marked as (<img src="/images/ico_new_mail.gif" alt="" width="13" height="9" border="0">).
<br>
Previously read messages are indicated in plain type and marked as (<img src="/images/ico_old_mail.gif" alt="" width="13" height="9" border="0">).<br> To 
                          view a message click on the message subject line.</p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2">
                        <hr width="90%" noshade size="1">
                      </td>
                    </tr>                    
                    <tr> 
                      <td colspan="2" class="hlpHeading"><a name="resume"></a><a href="/employers/logged/search/index.asp">Resume Search</a></td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td width="100%" valign="top">Another very useful tool is the Resume Search feature. Here, you can search our expanding resume database. Any resume that a job seeker has set to allow browsing will be viewable. The database can be searched using keywords, geographic location, availability, and eligibility.</td>
                    </tr>
					<tr>
						<td colspan="2" align="center"><br><p><STRONG>[ <a href="#top">Back to Top</a> ]</STRONG></p></td>
					</tr>													
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="175" valign="top"> 
            <!-- #INCLUDE VIRTUAL='/includes/hms_menu.asp' -->
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
Connect.Close
Set Connect = Nothing
%>

