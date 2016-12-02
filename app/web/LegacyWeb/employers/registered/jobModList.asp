<% if session("adminAuth") <> "true" then 
response.redirect("/index.asp")
end if
%>
<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
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
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<TITLE>Edit Jobs - Administrative Search Results - Personnel Plus, Inc. - Idaho's Total Staffing Solution</TITLE>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
</HEAD>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->

<table width="100%" border="0" cellspacing="0" cellpadding="0" BGCOLOR="#FFFFFF">
	<tr>
		<td align="center">
			<table width="100%" border="0" cellspacing="0" cellpadding="3">
				<tr>
				<td colspan="7" class="smallTxt" bgcolor="#FFFFFF" align="center">
				<TABLE width="65%" border="0" cellpadding="2" cellspacing="5" bgcolor="#FFFFFF">
					<TR>
		<TD style class="smallTxt" align="center" width="30%"><a href="/company/staff/jobMod.asp?who=1"><strong>&lt;Back to Main Search</a></strong></TD>					
		<TD style class="smallTxt" align="center" width="30%"><a href="/company/staff/jobOrder.asp?who=1"><strong>Post a New Job</a></strong></TD>
		<td style class="smallTxt" align="center" width="30%"><strong><font color="#808080"><em>Edit Job(s)</em></font></strong></td>
					</TR>
					<TR>
					<TD style class="smallTxt" align="center" colspan="3"><strong><font size="3">Job Search Results</font></strong></TD>
					</TR>					
				</TABLE>
				
				</td>
				</tr>
                <tr> 
<% if rsSearch.eof = true and rsSearch.BOF = true then %>
      			<tr> 
                  <td colspan="7" align="center"><strong>Your search results returned no matches.<p></p><a href="javascript:history.go(-1)">Please try a different search.</a></strong></td>
                </tr>
<% else %>
                <tr> 	
                  <td BGCOLOR="#b22222" class="smallTxt">&nbsp;</td>
				  <td bgcolor="#b22222"><strong><font color="#FFFFFF"><em>Status</em></FONT></strong></td>				   							
                  <td BGCOLOR="#b22222"><strong><font color="#FFFFFF">Location</FONT></strong></td>
                  <td BGCOLOR="#b22222"><strong><font color="#FFFFFF">Job Title</FONT></strong></td>
                  <td BGCOLOR="#b22222"><strong><font color="#FFFFFF">Company Name</FONT></strong></td>
                  <td BGCOLOR="#b22222"><strong><font color="#FFFFFF">Date Posted</FONT></strong></td>
                  <td BGCOLOR="#b22222"><strong><font color="#FFFFFF">Job #</FONT></strong></td>
                </tr>
<%
dim index
index = 1
Do Until rsSearch.eof 
%>


				<tr>
				 <td colspan="7" background="/img/spacer_black.gif"></td>
				</tr>
                <tr> 
				  <td style class="smallTxt" align="center"><a href="jobEdit.asp?who=1&?jobID=<%=rsSearch("jobID")%><%=srchStr%>"><strong>EDIT</strong></a></td>
                  <td style class="smallTxt" align="center"><%if rsSearch("jobStatus") = "Closed" then%><!a href="jobOpen.asp?who=1&?jobID=<%=rsSearch("jobID")%><%=srchStr%>"><img src="/img/ico_close.gif" alt="JOB IS CLOSED" width="19" height="23" border="0"></a><%else%><!a href="jobClose.asp?jobID=<%=rsSearch("jobID")%><%=srchStr%>"><img src="/img/ico_open.gif" alt="JOB IS OPEN" width="19" height="23" border="0"></a><%end if%></td>
                  <td style class="smallTxt"><%=rsSearch("jobCity")%>, <%=rsSearch("jobState")%></td>
                  <td style class="smallTxt"><a href="jobEdit.asp?who=1&?jobID=<%=rsSearch("jobID")%><%=srchStr%>"><%=rsSearch("jobTitle")%></a></td>
                  <td style class="smallTxt"><a href="jobEdit.asp?who=1&?jobID=<%=rsSearch("jobID")%><%=srchStr%>"><%=rsSearch("companyName")%></a></td>
                  <td style class="smallTxt"><a href="jobEdit.asp?who=1&?jobID=<%=rsSearch("jobID")%><%=srchStr%>"><%=FormatDateTime(rsSearch("dateCreated"),2)%></a></td>
                  <td style class="smallTxt"><a href="jobEdit.asp?who=1&?jobID=<%=rsSearch("jobID")%><%=srchStr%>"><%=rsSearch("jobNumber")%></a></td>
                </tr>

                   <%		   
index = index + 1
rsSearch.Move + 1
loop
%>
                   <% end if %>
				 <tr>
					<td colspan="7" background="/img/spacer_black.gif"></td>
				 </tr>				   		
  				</table>
				</td>
				</tr>
				</table>				
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
</BODY>
</HTML>
<%
rsSearch.Close
Connect.Close
set Connect = Nothing
%>