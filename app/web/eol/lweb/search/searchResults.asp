<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<% response.buffer=true %>

<%
Dim rsSearch, sqlSearch
set rsSearch = Server.CreateObject("ADODB.RecordSet")
Dim keywords		:	keywords = ConvertString(request("keywords"))
Dim jobSchedule		:	jobSchedule = request("jobSchedule")
Dim jobCategory		:	jobCategory = request("jobCategory")
Dim jobLocation		:	jobLocation = request("jobLocation")
Dim orderBy			:	orderBy = request("orderBy")
Dim searchFlag		:	searchFlag = request("searchFlag")
Dim jobCity, jobState

' Split City and State IF a location is selected by user
If jobLocation <> "" Then

Dim arrLoc
arrLoc = split(Request("jobLocation"), ",")
jobCity = TRIM(Cstr(arrLoc(0)))
jobState = TRIM(Cstr(arrLoc(1)))

End If



' Was Search All Records options chosen?
if searchFlag = "All" then
sqlSearch = "SELECT jobID, jobCategory, jobState, jobCity, jobSchedule, companyName, deleted, jobStatus, jobNumber, jobTitle, dateCreated FROM tbl_listings WHERE jobStatus = 'Open' ORDER BY dateCreated DESC"
' Otherwise, assume normal search pattern
else
' parse out SELECT sql string when keywords are present
	if keywords <> "" then
	sqlSearch = "SELECT jobID, jobCategory, jobState, jobCity, jobSchedule, companyName, deleted, jobStatus, jobNumber, jobTitle, dateCreated FROM tbl_listings WHERE jobStatus = 'Open' AND "	
Dim sqlKeyWords
Dim tmpKeywords	:	tmpKeyWords = ConvertString(request("keywords"))
keywords = split((tmpKeywords)," ")
  for i = 0 to uBound(keywords)
    if i < uBound(keywords) then
	  if keywords(i) <> "" then
	    sqlKeyWords = "jobTitle LIKE '%" & keywords(i) & "%' OR jobDescription LIKE '%" & keywords(i) & "%' OR "
	  end if
	else
	  if keywords(i) <> "" then
        sqlKeyWords = "jobTitle LIKE '%" & keywords(i) & "%' OR jobDescription LIKE '%" & keywords(i) & "%'"
	  end if
	end if
	sqlSearch = sqlSearch + sqlKeyWords	
  next
'  response.write(i)
	end if
	if i = 0 then	
	sqlSearch = "SELECT * FROM tbl_listings WHERE jobStatus = 'Open'"	
	end if	
	
' set basic SELECT
if jobSchedule <> "" then
sqlSearch = sqlSearch + " AND jobSchedule='" & jobSchedule & "'"
end if
if jobCategory <> "" then
sqlSearch = sqlSearch + " AND jobCategory='" & jobCategory & "'"
end if
if jobCity <> "" then
sqlSearch = sqlSearch + " AND jobCity='" & jobCity & "'"
end if
if jobState <> "" then
sqlSearch = sqlSearch + " AND jobState='" & jobState & "'"
end if

' parse ORDER BY
if jobState <> "" and orderBy = "jobState" then
orderBy = "jobCity"
end if
if jobState = "" and orderBy = "jobState" then
orderBy = "jobState,jobCity"
end if
if orderBy = "dateCreated" then
Dim strDesc	:	strDesc = " DESC"
end if
' add the appropiate ORDER BY
sqlSearch = sqlSearch + " ORDER BY " & orderBy & strDesc
End if

'response.write(sqlSearch)
set rsSearch = Connect.Execute(sqlSearch)
%>

<HTML>
<HEAD>
<SCRIPT>
function checkLoginInfo()	  
{
var isGood = true
if ((document.loginInfo.uN.value.length < 4) || (document.loginInfo.uN.value.length > 30))
  {
isGood=false
mesg2 = "You have entered " + document.loginInfo.uN.value.length + " character(s) for the user name.\n"
mesg2 = mesg2 + "Valid user names are 4 or more characters long.\n"
mesg2 = mesg2 + "Please verify your entry and try again."
alert(mesg2);
document.loginInfo.uN.value = "";
document.loginInfo.uN.focus();
return false;
  }
if ((document.loginInfo.uNer.value.length < 5) || (document.loginInfo.uNer.value.length > 30))
    {
isGood=false
mesg = "You have entered " + document.loginInfo.uNer.value.length + " character(s) for the password.\n"
mesg = mesg + "Valid passwords are 5 or more characters long.\n"
mesg = mesg + "Please verify your entry and try again."
alert(mesg);
document.loginInfo.uNer.value = "";
document.loginInfo.uNer.focus();
return false;
    }  
  if (isGood==true) {

    document.loginInfo.submit()
  }  
}

</SCRIPT>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<TITLE>Search Results from Job Listings - Personnel Plus, Inc.</TITLE>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
</HEAD>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->

<table width="100%" border="0" cellspacing="0" cellpadding="0" BGCOLOR="#FFFFFF">
	<tr>
		<td align="center">
			<table width="100%" border="0" cellspacing="0" cellpadding="3">
<% if rsSearch.EOF = true and rsSearch.BOF = true then %>
      			<tr> 
                  <td colspan="6" align="center"><strong>Your search results returned no matches.<p></p><a href="javascript:history.go(-1)">Please try a different search.</a></strong></td>
                </tr>
<% else %>
                <tr> 	
                  <td BGCOLOR="#D1DCEB">&nbsp;</td>				   							
                  <td BGCOLOR="#D1DCEB"><strong>Location</strong></td>
                  <td BGCOLOR="#D1DCEB"><strong>Job Title</strong></td>
                  <td BGCOLOR="#D1DCEB"><strong>Company Name</strong></td>
                  <td BGCOLOR="#D1DCEB"><strong>Date Posted</strong></td>
                  <td BGCOLOR="#D1DCEB"><strong>Job #</strong></td>
                </tr>
<%
Dim index
index = 1
Do Until rsSearch.eof 
%>
				<tr>
				 <td colspan="6" background="/lweb/img/spacer_black.gif"></td>
				</tr>
                <tr> 
                  <td style class="smallTxt"><%=index%>)</td>
                  <td style class="smallTxt"><%=rsSearch("jobCity")%>, <%=rsSearch("jobState")%></td>
                  <td style class="smallTxt"><a href="viewJob.asp?jobID=<%=rsSearch("jobID")%>"><%=rsSearch("jobTitle")%></a></td>
                  <td style class="smallTxt"><a href="viewJob.asp?jobID=<%=rsSearch("jobID")%>"><%=rsSearch("companyName")%></a></td>
                  <td style class="smallTxt"><a href="viewJob.asp?jobID=<%=rsSearch("jobID")%>"><%=FormatDateTime(rsSearch("dateCreated"),2)%></a></td>
                  <td style class="smallTxt"><a href="viewJob.asp?jobID=<%=rsSearch("jobID")%>"><%=rsSearch("jobNumber")%></a></td>
                </tr>

                   <%
index = index + 1
rsSearch.Move + 1
loop
%>
                   <% end if %>
				 <tr>
					<td colspan="6" background="/lweb/img/spacer_black.gif"></td>
				 </tr>				   
                 <tr> 								
                     <td style BGCOLOR="#FFFFFF" colspan="6" align="center">
<% ' NO AUTH START 
if session("auth") <> "true" and session("employerAuth") <> "true" and session("adminAuth") <> "true" then 
%>
<FORM NAME="loginInfo" method="post" action="/lweb/seekers/registered/setSession.asp?who=2">
<input type="hidden" name="pgOrig" value="sj">
			<TABLE WIDTH="300" BORDER="0" CELLSPACING="0" CELLPADDING="0">
				<TR>
					<TD BGCOLOR="#FFFFFF" COLSPAN="2">&nbsp;<br></TD>
				</TR>
				<TR>
				<TD BGCOLOR="#003366" ALIGN="left" HEIGHT="22"><IMG SRC="/lweb/img/tab_top_left.gif" ALT="" WIDTH="11" HEIGHT="22" BORDER="0"></TD>
<TD BGCOLOR="#003366" HEIGHT="22" align="right"><FONT COLOR="#FFFFFF"><STRONG>Already have an Account?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</STRONG></FONT><IMG SRC="/lweb/img/tab_top_right.gif" ALT="" WIDTH="11" HEIGHT="22" BORDER="0" ALIGN="absmiddle"></TD>
				</TR>
				<TR>
					<TD colspan="2" align="center"  STYLE="border: 1px solid #D1DCEB;">
					<TABLE BORDER="0" CELLSPACING="5" CELLPADDING="0">
                            <TR> 
                              <TD ALIGN="right"><FONT STYLE CLASS="searchText"><STRONG>User Name:</STRONG></FONT></TD>
                              <TD> <INPUT TYPE="text" NAME="uN" SIZE="16" MAXLENGTH="30"></TD>
                            </TR>
                            <TR> 
                              <TD ALIGN="right"><FONT STYLE CLASS="searchText"><STRONG>Password:</STRONG></FONT></TD>
                              <TD> <INPUT TYPE="password" NAME="uNer" SIZE="16" MAXLENGTH="30"></TD>
							</TR>
						
							<TR>
							  <TD COLSPAN="2" ALIGN="center"><INPUT TYPE="button" style="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" NAME="Button" VALUE="Login" onClick="checkLoginInfo();"></TD>
							</TR>
							<TR>
								<TD COLSPAN="2"><hr width="95%"></TD>
							</TR>
							<TR>
                              <TD COLSPAN="2" ALIGN="center"><strong><font size="3">New to this site?</font> <br>You'll need an account to apply for jobs.</strong><p></p><a href="/lweb/seekers/new/newAcct1.asp"><strong>Create your free account now...</strong></a></TD>
                            </TR>							
					</TABLE>
					</TD>
				</TR>								
			</TABLE>
</FORM>
<% ' NO AUTH END
end if 
%>					 
					 
					 </td>
                   </tr>			
  				</table>
				</td>
				</tr>
				</table>				
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
</BODY>
</HTML>
<%
rsSearch.Close
Connect.Close
set Connect = Nothing
%>