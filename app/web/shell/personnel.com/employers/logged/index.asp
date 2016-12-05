<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->

<%
' // Employer Messages
dim rsNewMsgCount, sqlNewMsgCount, msgCount
sqlNewMsgCount = "SELECT COUNT(msg_id) AS number FROM tbl_employer_messages WHERE emp_id = " & session("empID") & " AND msg_is_read = 0"
Set rsNewMsgCount = Connect.Execute(sqlNewMsgCount)
msgCount = rsNewMsgCount("number")
session("numMsg") = msgCount
rsNewMsgCount.Close
Set rsNewMsgCount = Nothing

if msgCount > 0 then
  dim rsNewMsgs, sqlNewMsgs
  sqlNewMsgs = "SELECT msg_id, emp_id, msg_subject, msg_is_read FROM tbl_employer_messages WHERE emp_id =" & session("empID") & " AND msg_is_read = 0"
  Set rsNewMsgs = Connect.Execute(sqlNewMsgs)
end if


' // Job Applications
dim rsAppCount, sqlAppCount, numApps
sqlAppCount = "SELECT COUNT(app_id) as number FROM tbl_applications WHERE emp_id =" & session("empID") & " AND app_is_deleted = 0"
Set rsAppCount = Connect.Execute(sqlAppCount)
session("numApps") = rsAppCount("number")
rsAppCount.Close
Set rsAppCount = Nothing

if numApps > 0 then
  dim rsApps, sqlApps
sqlApps = "SELECT app_id, job_id, res_id, emp_id, mbr_id, app_is_deleted, app_date_created from tbl_applications WHERE emp_id = " & session("empID")
Set rsApps = Server.CreateObject("ADODB.RecordSet")
rsApps.CursorLocation = 3
rsApps.Open(sqlApps),Connect
end if
%>

<html>
<head>
<title>Employer Home Page - www.personnel.com</title>
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
                    <!-- #INCLUDE VIRTUAL='/includes/textNav.asp' -->
               
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="2" cellpadding="2">
              <tr>
			    <td><img src="/images/pixel.gif" width="8" height="1"></td>
                <td> 
<table width="80%" cellpadding="3" cellspacing="2" border="0">
<tr>				
	<td colspan="2"><p>Welcome, <strong><%=company_name%></strong>.</p>
	</td>
					
</tr>
<tr>
	<td colspan="2"><img src="/images/pixel.gif" width="1" height="10"></td>
</tr>
<tr>
	<td align="left"><a href="/employers/logged/account/index.asp">Account Options</a></td>
	
	<td align="left"><a href="/employers/logged/resumes/index.asp">Applicant Manager</a></td>
</tr>
<tr>
	<td valign="top">Modify your online information and modify your account preferences. Be sure to keep your information up-to-date so you can get the most from Personnel.com's services.</td>
	<td valign="top">Using the Applicant Manager you can quickly and easily view applicants that have applied for your job postings and choose the best person for the job.</td>
</tr>
<tr>
	<td colspan="2"><hr size="1" noshade color="#AAAAAA"></td>
</tr>
<tr>
	<td align="left"><a href="listing/index.asp">Job Listings Manager</a></td>
	
	<td align="left"><a href="listing/newJob.asp">Post a New Job!</a></td>
</tr>

<tr>
	<td valign="top">Use the Job Listings Manager to add, remove, delete, and edit your job listings. Expose your job positions to the world.</td>

	<td valign="top">Need a job position filled? Post a new job to be accessed by one of the many qualified applicants seeking for employment on Personnel.com.</td>
</tr>
<tr>
	<td colspan="2"><hr size="1" noshade color="#AAAAAA"></td>
</tr>
<tr>
	<td align="left"><a href="/employers/logged/search/index.asp">Resume Search</a></td>
	
	<td align="left"><a href="/search/index.asp">Search Existing Jobs</a></td>
</tr>


<tr>
	<td valign="top">Browse the rapidly growing database of resumes submitted by the qualified applicants registered on Personnel.com.</td>
	<td valign="top">Search the currently posted jobs from all employers, view your own postings from the perspective of the job seekers.</td>
</tr>
<tr>
	<td colspan="2"><img src="/images/pixel.gif" width="1" height="10"></td>
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
<%
Connect.Close
Set Connect = Nothing
%>
</body>
</html>
