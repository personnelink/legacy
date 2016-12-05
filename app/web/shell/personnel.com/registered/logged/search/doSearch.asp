<% response.buffer = true %>
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkMbrAuth.asp' -->
<%
dim rsSrch, sqlSrch, sqlExtra, keywords, k
dim job_keywords			:   job_keywords = TRIM(replace(request("job_keywords"),"'","''"))
dim keyword_type			:	keyword_type = request("keyword_type")
dim job_type				:	job_type = request("job_type")
dim job_category			:	job_category = request("job_category")
dim job_location			:	job_location = request("job_location")
dim job_city				:	job_city = TRIM(replace(request("job_city"),"'","''"))
dim order_by				:	order_by = request("order_by")

' initial SQL string
sqlSrch = "SELECT job_id, emp_id, job_category, job_title, job_type, job_salary, job_company_name, job_city, job_location, job_number, job_is_deleted, job_view_count, job_date_created, job_description FROM tbl_jobs WHERE job_is_deleted = '0'" 

' job type check
if job_type <> "" then
	if job_type = "FP" then
    sqlSrch = sqlSrch
	Else
	sqlSrch = sqlSrch + " AND job_type='" & job_type & "'"
	end if
End if

' job category check
if job_category <> "" then
  sqlSrch = sqlSrch + " AND job_category='" & job_category & "'"
  Else
  sqlSrch = sqlSrch
end if

' job location check
if len(job_location) = 1 then
    if job_location = "1" then 
      sqlSrch = sqlSrch + " AND job_location LIKE '%" & ", US" & "%'"  
    end if
    if job_location = "2" then
      sqlSrch = sqlSrch + " AND job_location LIKE '%" & ", CA" & "%'"  
    end if
    if job_location = "3" then
      sqlSrch = sqlSrch + " AND job_location NOT LIKE '%" & "," & "%'"  
    end if
end if
if len(job_location) > 1 then
      sqlSrch = sqlSrch + " AND job_location='" & job_location & "'"
end if

' city check
if len(job_city) > 2 then
  sqlSrch = sqlSrch + " AND job_city ='" & job_city & "'"
end if

' keywords check
if len(job_keywords) > 1 then 
  keywords = split(request("job_keywords")," ")
  for i = 0 to uBound(keywords)
    if i < uBound(keywords) then
	  if keywords(i) <> "" then
	    k = k + "job_title LIKE '%" & keywords(i) & "%'" & keyword_type 
	  end if
	else
	  if keywords(i) <> "" then
	    k = k + "job_title LIKE '%" & keywords(i) & "%'"
	  end if
	end if
  next
  sqlSrch = sqlSrch + " AND (" & k & ")"
end if


' order by check
if request("order_by") = "date" then
  sqlSrch = sqlSrch + " ORDER BY job_date_created DESC"
end if
if request("order_by") = "title" then
  sqlSrch = sqlSrch + " ORDER BY job_title"
End if  
if request("order_by") = "company" then
  sqlSrch = sqlSrch + " ORDER BY job_company_name"
End if 

set rsSrch = Server.CreateObject("ADODB.RecordSet")
rsSrch.CursorLocation = 3
rsSrch.Open(sqlSrch),Connect
dim numMatched	: numMatched = rsSrch.RecordCount

'response.write(numMatched)
'response.end
%>

<html>

<head>
<title>Job Search Results - www.personnel.com</title>
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
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_cdc.gif" width="175" height="76"></td>
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
              <tr bgcolor="E7E7E7"> 
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
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="/images/headers/searchJobsOnline.gif" width="328" height="48"></td>
                    </tr>
<% if numMatched < 1 then %>		
                    <tr> 
                      <td align="left">
<form name="blankForm" Method="post" action="index.asp">
<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td>No matching results were found.
		<br>
		<input type="submit" name="btn_back" value="&lt;&lt; Back To Search"></td>
	</tr>
</table>
</form>
						</td>
                    </tr>	
<% End if %>					
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="30" class="sideMenu"><img src="/images/pixel.gif" width="30" height="8"></td>
                            <td class="sideMenu" valign="bottom">&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="15"><img src="/images/pixel.gif" width="15" height="1"></td>
                            <td> 
<table width="100%" bgcolor="#EEEEEE" border="0" cellspacing="0" cellpadding="0">
<% if numMatched > 0 then %>	
	<tr> 
		<td bgcolor="#FFFFFF">
Your search found 
<%
response.write("<STRONG>" & numMatched & "</STRONG>")
if numMatched > 1 then
response.write(" matches")
Else
response.write(" match")
end if
%>
</td>
	</tr>	
	<tr>
		<td width="100%">
		<table border="0" cellspacing="0" cellpadding="3" width="100%" bgcolor="#5187CA" style="border: 1px solid #000000;">
		<tr>
			<td width="14%" class="empJobMgrHead" align="left"><strong>Location</strong></td>
			<td width="36%" class="empJobMgrHead" align="left"><strong>Title</strong></td>			
			<td width="40%" class="empJobMgrHead" align="left"><strong>Company</strong></td>	
			<td width="10%" class="empJobMgrHead" align="center"><strong>Date</strong></td>								 						  
		</tr>
		</table>
		</td>
	</tr>
<% 
  index = 1
  Do until rsSrch.eof
%>
                          <tr>
						    <td width="100%">
							  <table border="0" cellspacing="0" cellpadding="2" width="100%" style="border: 1px solid #000000;">
							  <tr>
							     <td class="empJobMgrList" bgcolor="#FFFFFF" width="14%" align="left"><strong><%=rsSrch("job_location")%></strong>,<br clear="all"> <strong><%=rsSrch("job_city")%></strong></td>
							     <td class="empJobMgrList" bgcolor="#FFFFFF" width="36%" valign="top" align="left"><a href="viewJob.asp?id=<%=rsSrch("job_id")%>"><%=rsSrch("job_title")%></a></td>								 
							     <td class="empJobMgrList" bgcolor="#FFFFFF" width="40%" valign="top" align="left"><strong><%=rsSrch("job_company_name")%></strong></td>
							     <td class="empJobMgrList" bgcolor="#FFFFFF" width="10%" valign="top" align="right"><%=FormatDateTime(rsSrch("job_date_created"),2)%></td>								  
							  </tr>
                          	  <tr>
						    	 <td bgcolor="#e7e7e7" colspan="4" class="empJobMgrList" width="100%" align="left">
<strong><%
	Select Case rsSrch("job_type")
	  Case "FP"
	    Response.write("Full/Part-Time")
	  Case "FT"
	    Response.write("Full-Time")
	  Case "PT"
	    Response.write("Part-Time")
	  Case "CT"
	    Response.write("Contractor")		
	End Select
%></strong>: 
<% if len(rsSrch("job_description")) > 120 then %>
<%=LEFT(rsSrch("job_description"),350)%> <a href="viewJob.asp?id=<%=rsSrch("job_id")%>" class="sidemenu">...More</a>
<% Else %>
<%=rsSrch("job_description")%>
<% End if %>
								 </td>
                          	  </tr>				  
							  </table>							  
							</td>						
                          </tr>
							  <tr>
							  	<td bgcolor="#ffffff"><img src="/images/pixel.gif" width="1" height="10"></td>
							  </tr>						  
<%
  index = index + 1
  rsSrch.MoveNext
  loop
end if
%>
                              </table>
                            </td>
                          </tr>
								  
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="175" valign="top"> 
            <!-- #INCLUDE VIRTUAL='/includes/cdc_menu.asp' -->
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
rsSrch.Close
set rsSrch = Nothing
Connect.Close
set Connect = Nothing
%>

</body>
</html>