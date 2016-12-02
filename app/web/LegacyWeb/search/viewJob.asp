<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->

<%
dim tmpViewCount
set rsListings = Server.CreateObject("ADODB.RecordSet")
rsListings.Open "SELECT * FROM tbl_listings WHERE jobID = '" & request("jobID") & "'",Connect,3,3
' increment view count
tmpViewCount = cint(rsListings("viewCount")) + 1

' place job id and title into session scope for re-use
session("lastJobID") = rsListings("jobID")
session("lastJobTitle") = rsListings("jobTitle")
%>
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<TITLE>View Job Details - Personnel Plus, Inc. - Idaho's Total Staffing Solution</TITLE>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
</HEAD>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
 <!-- NAVI TOP START CLSP8 -->
  <%'=session("lastJobID")%><%'=session("lastJobTitle")%>   
<table width="85%" border="0" cellspacing="0" cellpadding="5" BGCOLOR="#FFFFFF">
<tr> 
<td colspan="2" align="center" bgcolor="#cccccc"><strong><font size="3"><%=rsListings("jobTitle")%></font></strong></td>
</tr>	
<tr> 
<td colspan="2" align="center">
	<table width="100%">
		<tr>
		<td>Category: <strong><%=rsListings("jobCategory")%></strong></td>
		<td>Location: <strong><%=rsListings("jobCity")%>, <%=rsListings("jobState")%></strong></td>
		</tr>
	
		
		<tr>
		<td>Company Name: <strong><%=rsListings("companyName")%></strong></td>
		<td>Postion Type: 
		<%
			Select Case rsListings("jobSchedule")
			  Case "FP"
			    response.write("<STRONG>Full/Part-Time</STRONG>")
			  Case "FT"
			    response.write("<STRONG>Full-Time</STRONG>")
			  Case "PT"
			    response.write("<STRONG>Part-Time</STRONG>")
			  Case "SE"
			    response.write("<STRONG>Seasonal</STRONG>")		
			  Case "TP"
			    response.write("<STRONG>Temp</STRONG>")							
			End Select
			%></td>		
		</tr>	
			
		<tr>
		<td>Company Contact: <strong><%=rsListings("companyAgent")%></td>
		<td><%=rsListings("wageType")%> Pay: <strong>$<%=rsListings("wageAmount")%></strong></td>		
		</tr>	
<% if session("auth") = "true" and TRIM(session("state")) <> "ID" then %>		
		<tr>
		<td>Company Phone: <%=rsListings("jobContactPhone")%></td>
		<td>Company Email: <%=rsListings("jobEmailAddress")%></td>
		</tr>	
<% end if %>																																								
	</table>
	
</td>
</tr>														  
                                						
<tr> 
<td colspan="2" align="left" valign="top"><font class="searchText"><STRONG>Job Requirements / Description:</STRONG></font></td>
                            
</tr>
<tr> 
<td colspan="2" align="left" valign="top"><font class="searchText"><%=rsListings("jobDescription")%></font></td>
</tr>	
<% if TRIM(rsListings("jobStartDate")) <> "" or TRIM(rsListings("jobEndDate")) <> "ID" then %>		
		<tr>
		<td>
 <% if TRIM(rsListings("jobStartDate")) <> "" then %>				
		 Job Begins: <strong><%=rsListings("jobStartDate")%></strong>
 <% end if %>			
 <% if TRIM(rsListings("jobEndDate")) <> "" then %>				
		<br>
		 Job Ends: <strong><%=rsListings("jobEndDate")%></strong>
 <% end if %>		 
		 </td>
		<td align="right"><font style class="smallerTxt" color="#a9a9a9">This position has been viewed <strong><%=rsListings("viewCount")%></strong> times.</font></td>
		</tr>	
<% end if %>	
						
<%
rsListings("viewCount") = tmpViewCount
rsListings.Update
'response.write(tmpViewCount)
%>
<tr> 
<td colspan="2" align="center" bgcolor="#D1DCEB"> 
<% if session("auth") = "true" then%>
<p></p>
<STRONG><font size="3"><A HREF="/seekers/registered/index.asp?who=2&?jobID=<%=rsListings("jobID") %>&apply=1">Apply for this position</A></font></STRONG>
<% else %>
<strong>* To apply for this job you will need to login first.</strong><br> New to this site? <a href="/seekers/new/newAcct1.asp">Create your FREE account now and apply within minutes.</a>	
<br>
<% end if %>							  		
</td>
</tr>															
</table>

<%
rsListings.Close
Connect.Close
set Connect = Nothing
%>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
</body>
</html>

