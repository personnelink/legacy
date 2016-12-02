<% if session("adminAuth") <> "true" then 
response.redirect("/index.asp")
end if
%>
<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<%
dim rsSearch, sqlSearch
set rsSearch = Server.CreateObject("ADODB.RecordSet")
dim keywords		:	keywords = ConvertString(request("keywords"))
dim jobSchedule		:	jobSchedule = request("jobSchedule")
dim jobCategory		:	jobCategory = request("jobCategory")
dim jobState		:	jobState = request("jobState")
dim jobCity			:	jobCity = TRIM(request("jobCity"))
dim orderBy			:	orderBy = request("orderBy")

dim srchStr			:	srchStr = "&keywords=" & keywords & "&jobSchedule=" & jobSchedule & "&jobCategory=" & jobCategory & "&jobCity=" & jobCity & "&jobState=" & jobState & "&orderBy=" & orderBy

'  parse out SELECT sql string when keywords are present
	if keywords <> "" then
	sqlSearch = "SELECT jobID, jobCategory, jobState, jobCity, jobSchedule, companyName, deleted, jobStatus, jobNumber, jobTitle, dateCreated FROM tbl_listings WHERE jobStatus = 'Open' AND "	
dim sqlKeyWords
keywords = split(request("keywords")," ")
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
	sqlSearch = "SELECT * FROM tbl_listings WHERE 1=1"	
	end if	
	
' set basic SELECT sql
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

' fine tune ORDER BY sql
if jobState <> "" and orderBy = "jobState" then
orderBy = "jobCity"
end if
if jobState = "" and orderBy = "jobState" then
orderBy = "jobState,jobCity"
end if
if orderBy = "dateCreated" then
dim strDesc	:	strDesc = " DESC"
end if
' sort options
sqlSearch = sqlSearch + " ORDER BY " & orderBy & strDesc


'response.write(sqlSearch)
set rsSearch = Connect.Execute(sqlSearch)
%>

<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<TITLE>Edit Jobs - Administrative Search Results - Personnel Plus, Inc. - Idaho's Total Staffing Solution</TITLE>
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
				<tr>
				<td colspan="6" class="smallTxt" bgcolor="#FFFFFF" align="center">
				<TABLE width="65%" border="0" cellpadding="2" cellspacing="5" bgcolor="#FFFFFF">
					<TR>
		<TD style class="smallTxt" align="center" width="30%"><a href="/lweb/company/staff/jobMod.asp"><strong>&lt;Back to Search Page</a></strong></TD>					
		<TD style class="smallTxt" align="center" width="30%"><a href="/lweb/company/staff/jobOrder.asp"><strong>Post a New Job</a></strong></TD>
		<td style class="smallTxt" align="center" width="30%"><strong><font color="#808080"><em>Edit Job(s)</em></font></strong></td>
					</TR>
					<TR>
					<TD style class="smallTxt" align="center" colspan="3"><strong><font size="3">Job Search Results:</font></strong></TD>
					</TR>					
				</TABLE>
				
				</td>
				</tr>
                <tr> 
<% if rsSearch.EOF = true and rsSearch.BOF = true then %>
      			<tr> 
                  <td colspan="6" align="center"><strong><font color="#b22222">Your search did not return any matches</font><p></p><a href="/lweb/company/staff/jobMod.asp">Please try a different search or simplify your criteria.</a></strong></td>
                </tr>
<% else %>
                <tr> 	
				  <td BGCOLOR="#b22222"><strong><font color="#FFFFFF"><em>Job Status:</em></FONT></strong></td>				   							
                  <td BGCOLOR="#b22222"><strong><font color="#FFFFFF">Location:</FONT></strong></td>
                  <td BGCOLOR="#b22222"><strong><font color="#FFFFFF">Job Title:</FONT></strong></td>
                  <td BGCOLOR="#b22222"><strong><font color="#FFFFFF">Company:</FONT></strong></td>
                  <td BGCOLOR="#b22222"><strong><font color="#FFFFFF">Date Posted:</FONT></strong></td>
                  <td BGCOLOR="#b22222"><strong><font color="#FFFFFF">Options:</FONT></strong></td>
                </tr>
<%
dim index
index = 1
Do Until rsSearch.eof 
%>


				<tr>
				 <td colspan="6" background="/lweb/img/spacer_black.gif"></td>
				</tr>
                <tr> 
                  <td style class="smallTxt" align="left">
<%if rsSearch("jobStatus") = "Open" then%>
<font color="#008000"><strong>Open</strong></font>
<%else%>
<font color="#FF0000"><strong>Closed</strong></font>
<%end if%></td>
                  <td style class="smallTxt"><%=rsSearch("jobCity")%>, <%=rsSearch("jobState")%></td>
                  <td style class="smallTxt"><a href="jobEdit.asp?jobID=<%=rsSearch("jobID")%><%=srchStr%>"><%=rsSearch("jobTitle")%></a></td>
                  <td style class="smallTxt"><a href="jobEdit.asp?jobID=<%=rsSearch("jobID")%><%=srchStr%>"><%=rsSearch("companyName")%></a></td>
                  <td style class="smallTxt"><a href="jobEdit.asp?jobID=<%=rsSearch("jobID")%><%=srchStr%>"><%=FormatDateTime(rsSearch("dateCreated"),2)%></a></td>
                  <td style class="smallTxt"><a href="jobEdit.asp?jobID=<%=rsSearch("jobID")%><%=srchStr%>"><img src="/lweb/img/ico_edit.gif" alt="EDIT" width="15" height="15" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="jobDelete.asp?jobID=<%=rsSearch("jobID")%><%=srchStr%>"><img src="/lweb/img/ico_del.gif" alt="DELETE" width="17" height="16" border="0"></a>
</td>
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