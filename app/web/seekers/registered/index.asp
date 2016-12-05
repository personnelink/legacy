<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
<% if session("employerAuth") = "true" then response.redirect("/employers/registered/index.asp?who=1") end if%>
<% if session("adminAuth") = "true" then response.redirect("/admin/index.asp") end if%>
<% if session("auth") <> "true" then response.redirect("/index.asp?noSeekAuth=") end if%>

<%
IF session ("auth") = "true" THEN

if request("success") = "1" then %>
<!-- #INCLUDE VIRTUAL='/inc/updateresume.asp' -->
<% end if

dim rsMessages,rsAllMessages,rsResumeCount,rstotalJobApps,sqlLocationName,rsLocationName,rstotalStateJobs

set rsMessages = Server.CreateObject("ADODB.RecordSet")
rsMessages.Open "SELECT * FROM tbl_messages WHERE userName = '" & user_name & "' AND accountType='Seeker' AND msgRead='No' ORDER BY msgCreationDate DESC",Connect,3,3

set rsAllMessages = Server.CreateObject("ADODB.RecordSet")
rsAllMessages.Open "SELECT * FROM tbl_messages WHERE userName = '" & user_name & "' AND accountType='Seeker'",Connect,3,3

Set rsResumeCount = Connect.Execute("SELECT count(userName) AS theCount FROM tbl_resumes WHERE userName = '" & user_name & "'")

Set rstotalJobApps = Connect.Execute("SELECT count(userName) AS theCount FROM tbl_applications WHERE userName = '" & user_name & "'")

sqlLocationName = "SELECT locCode, locName, display FROM tbl_locations WHERE locCode = '" & session("state") & "'"
set rsLocationName = Connect.Execute(sqlLocationName)

Set rstotalStateJobs = Connect.Execute("SELECT count(jobState) AS theCount FROM tbl_listings WHERE jobState = '" & session("state") & "'")


 ELSE
response.redirect("/index.asp?noSeekAuth=")
END IF
%>
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<TITLE><%=user_firstname%>&nbsp;<%=user_lastname%>, Welcome to Personnel Plus!</TITLE>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">

<SCRIPT language="javascript">
function goResume() {
var isGood = true
document.applyOnline.submit_btn.disabled = true;	

  if (document.applyOnline.officeSelector.value == '')
    {  alert("Please select the nearest city before proceeding."); 
	document.applyOnline.officeSelector.focus();
document.applyOnline.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
  if (isGood != false)
    { document.applyOnline.submit();  }
}

function goResume2() {
document.applyOnline2.submit();
}

</SCRIPT>
</HEAD>

<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->

<TABLE width="90%" BORDER="0" CELLPADDING="2" CELLSPACING="2" BGCOLOR="#ffffff">
	<TR>
		<TD>
		<!-- greeting start -->
<% if request("resVal") = "Yes" then%> 
<STRONG>Your resume was 
 <% if request("resType") = "int" then%> sent directly to the office closest to (or within) <%=session("city")%>, <%=session("state")%>! Please allow up to two business days for it to be processed. You will be contacted either at your email address (<%=session("emailAddress")%>) or phone number (<%=session("contactPhone")%>) when a job match/opportunity arises.
 <% end if%> 
 <% if request("resType") = "ext" then%> saved successfully!<p></p> <% end if%></STRONG>
<% end if%>		
<p></p>		
<font size="2">Welcome, <STRONG><%=user_firstname%>&nbsp;<%=user_lastname%></STRONG> to Personnel Plus!<br> We <u>thank you</u> for taking the time to create your own personalized account with us!</font>
<p></p>
This is your <strong>account startup page</strong> - each time you sign back in to this website you will arrive here first.
<p></p>
Here you will be able to check for new messages, change your account profile, update your resume information, and view an ongoing summary of your account status. 
<em>Further enhancements to help you connect with employers in <%= rsLocationName("locName") %> are planned to be added soon, so check back often!</em><p></p> 
		</TD>
		<!-- greeting end -->		
	</TR>
<% if session("numResumes") = "0" and rsLocationName("locCode") = "ID" and request("resVal") <> "Yes" then %>	
		<!--  resume start -->
	<TR>
		<TD>

			<TABLE width="100%" border="0" cellpadding="3" cellspacing="3" style="border: 1px solid #b22222;">
				<TR>
					<TD>


<FORM name="applyOnline" action="applyOnline.asp" method="POST">
<% if request("apply") = "1" then%>
<strong><font color="#003366" size="+1"><%=session("lastJobTitle")%></font></strong> <br>
<% end if %>
<strong><font color="#b22222">PLEASE NOTE:</strong></font> <strong><em>You will be unable to apply for jobs without first creating an online resume</em>.</font></strong><p></p> <font color="#b22222"><strong>To create a resume now, select the office location nearest you from the following list:</strong></font> 
<SELECT name="officeSelector" size="1">
	<option value="">- Select a City -</option>
	<option value="boise@personnel.com">Boise</option>
	<option value="burley@personnel.com">Burley</option>	
	<option value="nampa@personnel.com">Caldwell</option>
	<option value="burley@personnel.com">Jerome</option>	
	<option value="nampa@personnel.com">Nampa</option>
	<option value="rupert@personnel.com">Rupert</option>	
	<option value="twin@personnel.com">Twin Falls</option>
	<option value="twin@personnel.com">- Not Sure -</option>
</SELECT>
<br>
<font color="#b22222"><strong>When finished with your selection</strong></font> <INPUT TYPE="button" style="background:#b22222; border:1 #000000 solid; font-size:9px; font-weight:bold; color:#FFFFFF" NAME="submit_btn" VALUE="click here to continue..." onClick="goResume()">.
</form>
					</TD>
				</tr>
			</table>
			</td>
			</tr>
<% elseif session("numResumes") = "0" and rsLocationName("locCode") <> "ID" and request("resVal") <> "Yes" then %>
	<TR>
		<TD>

			<TABLE width="100%" border="0" cellpadding="3" cellspacing="3" style="border: 1px solid #b22222;">
				<TR>
					<TD>
<% if request("apply") = "1" then%>
<strong><font color="#003366" size="+1"><%=session("lastJobTitle")%></font></strong> <br>
<% end if %>					
<FORM  method="POST" name="applyOnline2" action="applyOnline.asp?seekID=<%=session("seekID")%>&geoLoc=<%=rsLocationName("locCode")%>">

<strong><font color="#b22222">PLEASE NOTE:</strong></font> <strong>You will be unable to apply for jobs without first creating an online resume.</font></strong><p></p> <font color="#b22222">To create a resume now</font>  <INPUT TYPE="button" style="background:#b22222; border:1 #000000 solid; font-size:9px; font-weight:bold; color:#FFFFFF" NAME="submit_btn2" VALUE="click here to continue..." onClick="goResume2()">
<p></p>

</FORM>


					</TD>
				</TR>
			</TABLE>
	
		</TD>
	</TR>
<% End if %>		
		<!--  resume end -->		
<% if user_name = "Spike" then %>	
		<!-- messages start -->							
	<TR>
		<TD>

	
			<TABLE width="100%" border="0" cellpadding="3" cellspacing="3" style="border: 1px solid #b0c4de;">
				<TR>
					<TD colspan="3" bgcolor="#b0c4de"><strong>MESSAGES:</strong> <strong><%=rsAllMessages.RecordCount%></strong> Total Message(s), <strong><%=rsMessages.RecordCount%></strong> <em>New </em>Message(s)</TD>					
				</TR>
				<TR>
				<TD align="left" style class="smallerTxt" BGCOLOR="#ffffff" height="12">Subject:</TD>
				<TD align="left" style class="smallerTxt" BGCOLOR="#ffffff" height="12">From:</TD>
				<TD align="left" style class="smallerTxt" BGCOLOR="#ffffff" height="12">Received:</TD>
				
				</TR>
<% if rsMessages.RecordCount <> 0 then %>
<% do until rsMessages.eof %>
                 <TR> 
                     <TD BGCOLOR="#f5f5dc"><A HREF="messages/viewMessage.asp?msgID=<%=rsMessages("MSGID")%>"><img src="/img/msgNew.gif" alt="" width="18" height="12" border="0"></A> <A HREF="messages/viewMessage.asp?msgID=<%=rsMessages("MSGID")%>"><%=rsMessages("msgSubject")%></A></TD>
                     <TD ALIGN="left" BGCOLOR="#f5f5dc"><%=rsMessages("msgFrom")%></TD>
                     <TD BGCOLOR="#f5f5dc"><%=FormatDateTime(rsMessages("msgCreationDate"),1)%></TD>
                  </TR>
<!-- temp spot -->				  
				  <TR>
				  	<TD colspan="3">
<A HREF="resume/viewResume.asp?resID=<%=rsResume("resID")%>">
<%=user_firstname%>, you have applied for  <STRONG><%=rsTotalJobApps("theCount")%></STRONG> job<% if rsTotalJobApps("theCount") = 1 then %> <% else %>s <% end if %> since <%=FormatDateTime(rsResume("dateCreated"),1)%>.<BR>
Currently, there are <STRONG><%=rstotalStateJobs("theCount")%></STRONG> open jobs in <%= rsLocationName("locName") %>.<BR>
Resume viewed: <%=rsResume("hitCount")%> times by Employers
 					
					</TD>
				  </TR>
<!-- temp spot -->				  
				  		  
<% rsMessages.MoveNext
   loop %>
<% end if %>
			</TABLE>
	
		</TD>
	
	</TR>	
		<!-- messages end -->	
<% End if %>			
	<TR>
		<TD VALIGN="top" WIDTH="100%" ALIGN="center" COLSPAN="2">

					
		</TD>
	</TR>	
</TABLE>
 
					
					

                          




<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
</BODY>
</HTML>
