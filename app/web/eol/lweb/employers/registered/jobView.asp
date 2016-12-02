<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->

<%
dim tmpViewCount
set rsListings = Server.CreateObject("ADODB.RecordSet")
rsListings.Open "SELECT * FROM tbl_listings WHERE jobID = '" & request("jobID") & "'",Connect,3,3
%>
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<TITLE>View Job Posting - <%=rsListings("jobTitle")%></TITLE>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<SCRIPT language="javascript">
function goResume() {
var isGood = true
document.applyDirect.submit_btn.disabled = true;	

  if (document.applyDirect.officeSelector.value == '')
    {  alert("Please select the nearest office location before continuing."); 
	document.applyDirect.officeSelector.focus();
document.applyDirect.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
  if (isGood != false)
    { document.applyDirect.submit();  }
}
</SCRIPT>
</HEAD>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
 <!-- NAVI TOP START CLSP8 -->
<table width="90%" border="0" cellspacing="0" cellpadding="4" BGCOLOR="#FFFFFF">
<tr> 
<td align="center" bgcolor="#9acd32"><strong>View Posting - <%=rsListings("jobTitle")%></strong></td>
</tr>	
<tr> 
<td width="100%" valign="top" STYLE="border: 1px solid #9acd32;">
	<table width="100%">
	   <tr>
	    <td width="50%">
		<table width="100%">
			<tr>
				<td>Category:</td>
				<td><strong><%=rsListings("jobCategory")%></strong></td>
			</tr>
			<tr>
			<td>Postion Type:</td>
			<td> 
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
				<td>Company:</td>
				<td><strong><%=rsListings("companyName")%></strong></td>
			</tr>
			<tr>
				<td valign="top">Location:</td>
				<td><strong><%=rsListings("jobAddressOne")%><br>
			<% if rsListings("jobAddressTwo") <> "" then %><%=rsListings("jobAddressTwo")%><br><% end if %>
			<%=rsListings("jobCity")%>, <%=rsListings("jobState")%>&nbsp;<%=rsListings("jobZipCode")%></strong></td>
			</tr>	
						
			<tr>
			<td>Contact Phone:</td>
			<td><strong><%=rsListings("jobContactPhone")%></strong></td>
			</tr>	
			
			<tr>
			<td>Contact Email:</td>
			<td><strong><%=rsListings("jobEmailAddress")%></strong></td>
			</tr>																																							
		</table>
	  </td>
	  <td width="50%">
			<table width="100%">
				<tr>
					<td>Break Time:</td>
					<td><strong><%=rsListings("jobTimeBreaks")%></strong></td>
				</tr>			
				<tr>
					<td>Lunch Time:</td>
					<td><strong><%=rsListings("jobTimeLunch")%></strong></td>
				</tr>
				<tr>
					<td>Reports To:</td>
					<td><strong><%=rsListings("jobReportTo")%></strong></td>
				</tr>
				<tr>
					<td>Dress Code:</td>
					<td><strong><%=rsListings("jobDressCode")%></strong></td>
				</tr>	
				<tr>
					<td>Company Contact:</td>
					<td><strong><%=rsListings("companyAgent")%></strong></td>
				</tr>			
				<tr>
					<td>Pay Rate: </td>
					<td><strong>$<%=rsListings("wageAmount")%> - <%=rsListings("wageType")%> </strong></td>		
				</tr>	
				<tr>
					<td colspan="2" align="left"> <% if TRIM(rsListings("jobStartDate")) <> "" then %>Job Duration: <strong><%=rsListings("jobStartDate")%></strong> <% end if %><% if TRIM(rsListings("jobEndDate")) <> "" then %> to <strong><%=rsListings("jobEndDate")%></strong> <% end if %>	</td>
				</tr>	
				<tr>
					<td colspan="2" align="center"><font style class="smallerTxt" color="#a9a9a9">This position has been viewed <strong><%=rsListings("viewCount")%></strong> times by visitors.</font></td>
				</tr>										
			</table>
		</td>
		</tr>
	  </table>
	  </td>
	</tr>														  
    <tr>
		<td><img src="/lweb/img/spacer.gif" alt="" width="1" height="4" border="0"></td>
	</tr>                    						
	<tr> 
<td valign="top" bgcolor="#cccccc"><font class="searchText"><STRONG>Job Requirements / Description:</STRONG></font></td>                    
	</tr>
	<tr> 
		<td align="left" valign="top" STYLE="border: 1px solid #cccccc;"><font class="searchText"><%=rsListings("jobDescription")%></font></td>
	</tr>		
	<tr>
		<td align="center">
		 <table width="100%">
		 <tr>
		 	<td><% if rsListings("jobStatus") = "Closed" then%><a href="jobOpen.asp?who=1&jobID=<%=rsListings("jobID")%>">Re-Open This Job Posting</a><%end if%><% if rsListings("jobStatus") = "Open" then%><a href="jobClose.asp?jobID=<%=rsListings("jobID")%>">Close This Job Posting</a> <%end if%></td>		
					 	<td><a href="jobEdit.asp?who=1&jobID=<%=rsListings("jobID")%>">Edit Job Posting</a></td>
								 	<td><a href="index.asp?who=1">Return To Control Panel</a></td> 
		 </tr>

		 </table>
		</td>		
</tr>														
</table>

<%
rsListings.Close
Connect.Close
set Connect = Nothing
%>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
</body>
</html>

