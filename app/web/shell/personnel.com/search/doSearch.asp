<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<%
response.buffer = true

const RecordsAllowedPerPage = 10

' Request and QueryString Object Variables
DIM keywords, i, k
DIM job_keywords			:   job_keywords = TRIM(replace(request("job_keywords"),"'","''"))
DIM keyword_type			:	keyword_type = request("keyword_type")
DIM job_type				:	job_type = request("job_type")
DIM job_category			:	job_category = request("job_category")
DIM job_location			:	job_location = request("job_location")
DIM job_city				:	job_city = TRIM(replace(request("job_city"),"'","''"))
DIM order_by				:	order_by = request("order_by")
DIM strPostBack				:	strPostBack="&job_keywords=" & job_keywords & "&keyword_type=" & keyword_type & "&job_type=" & job_type & "&job_category=" & job_category & "&job_location=" & job_location & "&job_city=" & job_city & "&order_by=" & order_by

' Paging Variables
DIM intCountOfRecords
DIM CurrentPage					:	CurrentPage = Request.QueryString("CurrentPage")
DIM PageCount
DIM CurrOffset
DIM RecLow, RecHigh

' SQL variables
DIM rsSrch, sqlSrch
DIM rsCount, sqlCount
DIM sqlWhere, sqlOrder

' *******************************
' START building SELECT statement
' *******************************

' job type
IF job_type <> "" THEN
	IF job_type = "FP" THEN
    sqlWhere = sqlWhere
	Else
	sqlWhere = sqlWhere + " AND job_type='" & job_type & "'"
	END IF
END IF
' job category
IF job_category <> "" THEN
  sqlWhere = sqlWhere + " AND job_category='" & job_category & "'"
  Else
  sqlWhere = sqlWhere
END IF
' job location
IF len(job_location) = 1 THEN
    IF job_location = "1" THEN 
      sqlWhere = sqlWhere + " AND job_location LIKE '%" & ", US" & "%'"  
    END IF
    IF job_location = "2" THEN
      sqlWhere = sqlWhere + " AND job_location LIKE '%" & ", CA" & "%'"  
    END IF
    IF job_location = "3" THEN
      sqlWhere = sqlWhere + " AND job_location NOT LIKE '%" & "," & "%'"  
    END IF
END IF
IF len(job_location) > 1 THEN
      sqlWhere = sqlWhere + " AND job_location='" & job_location & "'"
END IF
' city
IF len(job_city) > 2 THEN
  sqlWhere = sqlWhere + " AND job_city ='" & job_city & "'"
END IF
' keywords
IF len(job_keywords) > 1 THEN 
  keywords = split(request("job_keywords")," ")
  For i = 0 to uBound(keywords)
    IF i < uBound(keywords) THEN
	  IF keywords(i) <> "" THEN
	    k = k + "job_title LIKE '%" & keywords(i) & "%'" & keyword_type 
	  END IF
	else
	  IF keywords(i) <> "" THEN
	    k = k + "job_title LIKE '%" & keywords(i) & "%'"
	  END IF
	END IF
  Next
  sqlWhere = sqlWhere + " AND (" & k & ")"
END IF
' order_by
IF request("order_by") = "date" THEN
  sqlOrder = " ORDER BY job_date_created DESC"
END IF
IF request("order_by") = "title" THEN
  sqlOrder = " ORDER BY job_title"
END IF  
if request("order_by") = "company" THEN
  sqlOrder = " ORDER BY job_company_name"
END IF 
if request("order_by") = "" THEN
  sqlOrder = " ORDER BY job_date_created DESC"
END IF 

' initialize first part of SELECT statement
sqlSrch = "SELECT job_id, emp_id, job_category, job_title, job_type, job_salary, job_company_name, job_city, job_location, job_number, job_is_deleted, job_view_count, job_date_created, job_description FROM tbl_jobs WHERE job_is_deleted = 0" 

' *******************************
' END building SELECT statement
' *******************************


' Count how many records we have to deal with
sqlCount = "SELECT COUNT(*) AS records FROM tbl_jobs WHERE job_is_deleted = 0" & sqlWhere
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
SET rsSrch = Connect.Execute(sqlSrch)
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
        <tr> 
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
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_srn_w.gif" width="175" height="76"></td>
        </tr>
        <tr> 
          <td bgcolor="#000000"> 
            <%
		    response.write("<table width=100% border=0 cellspacing=0 cellpadding=3><tr><td>" & VBCRLF)
            response.write("<FONT COLOR=WHITE>")
            response.write("&nbsp;&nbsp;<a href='/search/index.asp' class=headmenu>Search Jobs</a>&nbsp;&nbsp;")
            response.write(" &#149; &nbsp;&nbsp;<A HREF='/chooseLogin.asp' class=headmenu>Login Now!</A>&nbsp;&nbsp;")
            response.write(" &#149; &nbsp;&nbsp;<A HREF='/registered/login.asp' class=headmenu>Post a Resume</A>&nbsp;&nbsp;")
            response.write(" &#149; &nbsp;&nbsp;<A HREF='/employers/login.asp' class=headmenu>Post a Job</A>&nbsp;&nbsp;")
            response.write(" &#149; &nbsp;&nbsp;<A HREF='/help/index.asp' class=headmenu>First Time Users</A>&nbsp;&nbsp;")
            response.write("</font></td></tr></table>" & VBCRLF)
			%>
          </td>
          <td width="175" bgcolor="#000000">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" bgcolor="#E7E7E7"><!--#include virtual="/includes/pub_greybar.asp" --></td>
          <td rowspan="2" valign="top"> 
            <p>
              <!-- #INCLUDE VIRTUAL='/includes/pub_menu.asp' -->
            </p>
          </td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="/images/headers/searchJobsOnline.gif" width="328" height="48"></td>
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
                            <td width="30"><img src="/images/pixel.gif" width="30" height="8"></td>
                            <td valign="bottom">&nbsp;</td>
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
		<td bgcolor="#FFFFFF">Showing <%=intCountOfRecords%> Matching Result(s)</td>
		<td align="right">
<%
' Create the paging links
response.write("<strong>Page:</strong> ")
For i = 1 to PageCount
  IF i = CurrentPage THEN
    response.write "<b>[" & i & "]</b> "
  Else
    response.write "<a href=""doSearch.asp?CurrentPage=" & i & strPostBack & """>"
    response.write i
    response.write "</a> "
  END IF
Next
%>
</td>
	</tr>					  
	<tr>
		<td width="100%" colspan="2">
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
  Do until rsSrch.eof
%>
                          <tr>
						    <td width="100%" colspan="2">
							  <table border="0" cellspacing="0" cellpadding="2" width="100%" style="border: 1px solid #000000;">
							  <tr>
							     <td class="empJobMgrList" bgcolor="#FFFFFF" width="14%" align="left"><strong><%=rsSrch("job_location")%></strong> -<br clear="all"> <strong><%=rsSrch("job_city")%></strong></td>
							     <td bgcolor="#FFFFFF" width="36%" valign="top" align="left">&nbsp;&nbsp;<a href="viewJob.asp?id=<%=rsSrch("job_id")%>" class="jobSearchTitle"><%=rsSrch("job_title")%></a></td>								 
							     <td class="empJobMgrList" bgcolor="#FFFFFF" width="40%" valign="top" align="left"><strong><%=rsSrch("job_company_name")%></strong></td>
							     <td class="empJobMgrList" bgcolor="#FFFFFF" width="10%" valign="top" align="center"><strong><%=FormatDateTime(rsSrch("job_date_created"),2)%></strong>
</td>								  
							  </tr>
                          	  <tr>
						    	 <td bgcolor="#eeeeee" colspan="4" class="empJobMgrList" width="100%" align="left">
<strong><%
	Select Case rsSrch("job_type")
	  Case "FP"
	    Response.write("F/T & P/T")
	  Case "FT"
	    Response.write("F/T")
	  Case "PT"
	    Response.write("P/T")
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
<%
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
SET rsSrch = NOTHING
Connect.Close
SET Connect = NOTHING
%>
</body>
</html>