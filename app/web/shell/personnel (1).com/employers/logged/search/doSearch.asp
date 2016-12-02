<% response.buffer = true %>
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->
<%
' ** 06-20-2004: Fix for multiple step OLEDB error added   **
' ** Solution is to declare a client side cursor location  **

const RecordsAllowedPerPage = 30

' Request and QueryString Object Variables

dim keyword_type			:	keyword_type = Request("keyword_type")
dim job_keywords			:   job_keywords = TRIM(Replace(Request("job_keywords"),"'","''"))
dim res_date_created		:	res_date_created = Request("res_date_created") ' 0, 3, 7, 14, 28
dim job_location			:	job_location = Request("job_location") ' 1,2,3, xx,xxx
dim res_is_eligible			:	res_is_eligible = Request("res_is_eligible") ' 0 = No, 1 = Yes
dim res_date_available		:	res_date_available = Request("res_date_available") ' onemonth, twomonths...
dim res_availability		:	res_availability = Request("res_availability") ' FP, FT, FT
dim order_by				:	order_by = Request("order_by") 'date, location

dim strPostBack				:	strPostBack="&keyword_type=" & keyword_type & "&job_keywords=" & job_keywords & "&res_date_created=" & res_date_created & "&job_location=" & job_location & "&res_date_available=" & res_date_available & "&res_availability=" & res_availability & "&order_by=" & order_by

' Paging variables
dim intCountOfRecords
dim CurrentPage					:	CurrentPage = Request.QueryString("CurrentPage")
dim PageCount
dim CurrOffset
dim RecLow, RecHigh

' SQL variables
dim rsSrch, sqlSrch
dim rsCount, sqlCount
dim sqlWhere, sqlOrder

' *******************************
' START building SELECT statement
' *******************************

' keywords
dim keywords, k
if len(job_keywords) > 1 then 
  keywords = split(request("job_keywords")," ")
  for i = 0 to uBound(keywords)
    if i < uBound(keywords) then
	  if keywords(i) <> "" then
	    k = k + "res_title LIKE '%" & keywords(i) & "%'" & keyword_type 
	  end if
	else
	  if keywords(i) <> "" then
	    k = k + "res_title LIKE '%" & keywords(i) & "%'"
	  end if
	end if
  next
  sqlWhere = sqlWhere + " AND (" & k & ")"
end if

' date created
if res_date_created <> "" then
'  sqlWhere = sqlWhere + " AND res_date_created='" & res_date_created & "'"
'  Else
'  sqlWhere = sqlWhere
end if

' location
if len(job_location) = 1 then
    if job_location = "1" then 
      sqlWhere = sqlWhere + " AND res_location LIKE '%" & ", US" & "%'"  
    end if
    if job_location = "2" then
      sqlWhere = sqlWhere + " AND res_location LIKE '%" & ", CA" & "%'"  
    end if
    if job_location = "3" then
      sqlWhere = sqlWhere + " AND res_location NOT LIKE '%" & "," & "%'"  
    end if
end if
if len(job_location) > 1 then
      sqlWhere = sqlWhere + " AND res_location='" & job_location & "'"
end if

' res_date_available
if res_date_available <> "" then
	sqlWhere = sqlWhere + " AND res_date_available='" & res_date_available & "'"
end if

' availability check
if res_availability <> "" then
	sqlWhere = sqlWhere + " AND res_availability='" & res_availability & "'"
End if

' order by check
if request("order_by") = "date" then
  sqlOrder = sqlOrder + " ORDER BY res_date_created DESC"
end if
if request("order_by") = "location" then
  sqlOrder = sqlOrder + " ORDER BY res_location"
end if

' initialize first part of SELECT statement
sqlSrch = "SELECT res_id, res_is_deleted, res_first_name, res_last_name, res_city, res_location, res_title, res_date_available, res_is_eligible, res_availability, res_is_active, res_filename, res_completion_flag, res_date_created, res_description, res_objective FROM tbl_resumes WHERE res_is_deleted = 0 AND res_is_active = 1 AND res_completion_flag = 5"

' *******************************
' END building SELECT statement
' *******************************


' Count how many baseline records we have to deal with
sqlCount = "SELECT COUNT(*) AS records FROM tbl_resumes WHERE res_is_deleted = 0 AND res_is_active = 1 AND res_completion_flag = 5" & sqlWhere
SET rsCount = Connect.Execute(sqlCount)
intCountOfRecords = int(rsCount("records"))
rsCount.Close
SET rsCount = NOTHING

' Let the paging begin...
CurrentPage = CInt(Request.QueryString("CurrentPage")) 
 
IF CurrentPage = "" or (len(CurrentPage)>0 and not isnumeric(CurrentPage)) THEN _
	CurrentPage = 1 
	CurrentPage = Cint(CurrentPage) 
 
    PageCount = intCountOfRecords \ RecordsAllowedPerPage 
 
    IF intCountOfRecords mod RecordsAllowedPerPage <> 0 THEN PageCount = PageCount + 1 
    IF CurrentPage < 1 THEN CurrentPage = 1 
    IF CurrentPage > PageCount THEN CurrentPage = PageCount 

        IF isNumeric(CurrentPage) THEN 
                CurrentPage = CInt(CurrentPage)
                CurrOffset = CInt(CurrentPage*RecordsAllowedPerPage) - RecordsAllowedPerPage
                
        END IF
		
        IF CurrentPage = "" OR CurrentPage = "0" THEN
                CurrentPage = 1
                CurrOffset = 0
        END IF

        RecLow = CurrOffset

        IF CurrentPage = PageCount THEN
                RecHigh = intCountOfRecords
        ELSE
                RecHigh = CurrOffset + RecordsAllowedPerPage
        END IF

        IF RecLow = 0 THEN RecLow = 1

' Append our LIMIT statement to the SELECT and Execute it
sqlSrch = sqlSrch + sqlWhere + sqlOrder + " LIMIT " & CurrOffset & ", " & RecordsAllowedPerPage & ""

Set rsSrch = Server.CreateObject("ADODB.RecordSet")
rsSrch.CursorLocation = 3
rsSrch.Open(sqlSrch),Connect
%>

<html>

<head>
<title>Resume Search Results - www.personnel.com</title>
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
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="/images/headers/resumeSearch.gif" width="328" height="48"></td>
                    </tr>

<% IF rsSrch.eof or rsSrch.BOF THEN %>		
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
<% END IF %>					
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="15" class="sideMenu"><img src="/images/pixel.gif" width="15" height="8"></td>
                            <td class="sideMenu" valign="bottom">&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="30"><img src="/images/pixel.gif" width="30" height="8"></td>
                            <td class="sideMenu" valign="bottom"> 
<table width="100%" cellspacing="0" cellpadding="1" bgcolor="#FFFFFF">
<% if intCountOfRecords > 0 THEN %>	
	<tr> 
		<td bgcolor="#FFFFFF">
		<strong> <%=intCountOfRecords%> Record<% if intCountOfRecords > 1 then %>s<% END IF %> Found</strong>

		</td>
		<td align="right">
<%
' Create paging links
response.write("<strong>PAGE:</strong> ")
For i = 1 to PageCount
  IF i = CurrentPage THEN
    response.write "<STRONG>[" & i & "]</STRONG> "
  Else
    response.write "<a href=""doSearch.asp?CurrentPage=" & i & strPostBack & """>"
    response.write i
    response.write "</a> "
  END IF
Next
%>
		<%IF intCountOfRecords > 0 THEN %> &nbsp;|&nbsp; <A HREF="index.asp">NEW SEARCH</A> <% END IF %>
							</td>
						  </tr>	
	
						  <tr>
							<td width="100%" colspan="2">
							<table border="0" cellspacing="0" cellpadding="2" width="100%" style="border: 1px solid #000000;">
								<tr>
									<td width="14%" class="empJobMgrHead" align="left"><strong>Location</strong></td>
									<td width="40%" class="empJobMgrHead" align="left"><strong>Resume Title</strong></td>			
									<td width="36%" class="empJobMgrHead" align="left"><strong>Name</strong></td>	
									<td width="10%" class="empJobMgrHead" align="center"><strong>Date</strong></td>								 						  
								</tr>
							</table>
							</td>
						  </tr>
<% 
  Do until rsSrch.eof
%>
                          <tr>
						    <td width="100%" colspan="2">
							  <table border="0" cellspacing="0" cellpadding="1" width="100%" style="border: 1px solid #000000;">
							  <tr>
							     <td class="empJobMgrList" bgcolor="#FFFFFF" width="14%" align="left" valign="top"><strong><%=rsSrch("res_location")%></strong> - <br clear="all"> <strong><%=rsSrch("res_city")%></strong></td>
							     <td class="empJobMgrList" bgcolor="#FFFFFF" width="40%" valign="top" align="left">

<% if rsSrch("res_filename") = "empty" then %>
<a href="viewResume.asp?id=<%=rsSrch("res_id")%>" class="jobSearchTitle"><%=rsSrch("res_title")%></a>
<% Else %>
<a href="viewResume2.asp?id=<%=rsSrch("res_id")%>" class="jobSearchTitle"><%=rsSrch("res_title")%></a>
<% end if%>
</td>								 
							     <td class="empJobMgrList" bgcolor="#FFFFFF" width="36%" valign="top" align="left"><strong><%=rsSrch("res_first_name")%>&nbsp;<%=rsSrch("res_last_name")%></strong></td>
							     <td class="empJobMgrList" bgcolor="#FFFFFF" width="10%" valign="top" align="right"><%=FormatDateTime(rsSrch("res_date_created"),2)%></td>								  
							  </tr>
                          	  <tr>
						    	 <td bgcolor="#e7e7e7" colspan="4" class="empJobMgrList" width="100%" align="left">
Seeking 
<%
Select Case rsSrch("res_availability")
	  Case "FP"
	    Response.write("F/T or P/T")
	  Case "FT"
	    Response.write("F/T")
	  Case "PT"
	    Response.write("P/T")	
End Select
%>
work: 

<% if TRIM(rsSrch("res_filename")) = "paste" then %>
<%=LEFT(rsSrch("res_description"),300)%><A HREF="viewResume2.asp?id=<%=rsSrch("res_id")%>">...</A>
<% Else %>
<%=LEFT(rsSrch("res_objective"),300)%><A HREF="viewResume.asp?id=<%=rsSrch("res_id")%>">...</A>
<% end if%>

								 </td>
                          	  </tr>				  
							  </table>							  
							</td>						
                          </tr>
<%
  rsSrch.MoveNext
  loop

' Close recordset after loop is completed
rsSrch.Close
set rsSrch = Nothing


%>
						  <tr>
						  	<td colspan="2" align="center">
<%
' Create paging links
response.write("<strong>PAGE:</strong> ")
For i = 1 to PageCount
  IF i = CurrentPage THEN
    response.write "<STRONG>[" & i & "]</STRONG> "
  Else
    response.write "<a href=""doSearch.asp?CurrentPage=" & i & strPostBack & """>"
    response.write i
    response.write "</a> "
  END IF
Next
%>

<%IF intCountOfRecords > 0 THEN %> &nbsp;|&nbsp; <A HREF="index.asp">NEW SEARCH</A> <% END IF %>

<%
End if ' End loop
%>							
							
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
set Connect = Nothing
%>

</body>
</html>