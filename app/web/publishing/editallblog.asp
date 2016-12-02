<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="include/common.asp" -->
<!--#include file="include/calendario.asp" -->
<%
If Session("admin") = False or IsNull(Session("admin")) = True then
	response.Redirect("login.asp?strmode=edit")
End If
%>
<%
Response.Buffer = True
Dim iMonth, iYear
iMonth=Request ("month")
iYear=Request ("year")
if iMonth = "" then iMonth = Month(Now)
sMonth=NameFromMonth(iMonth)
if iYear = "" then iYear = Year(Now)
Dim rsblog 
Dim rscommenti 
Dim vpage 
Dim page 
Dim Block 
Dim Blocks 
Dim RecordsInPage 
Dim intstart 
Dim i 
Dim totale
Dim maxpages 
Dim PagStart
Dim PagStop
Dim RemainingRecords
Dim NumberLastRecords
Dim SQLCount 
Dim rsCount 

page = Request("page")
RecordsInPage = Request("RecordsInPage")
Block = Request("Block")

if Block="" then Block=1 
if RecordsInPage="" then RecordsInPage=intRecordsPerPage
if page="" then page=1

SQLCount = "SELECT COUNT(*) as totale FROM blog"
set rsCount = adoCon.Execute(SQLCount) 
totale = rsCount("totale") 
rsCount.Close 
set rsCount=Nothing 
%>

<html>
<head>
<title><% = Ublogname %></title>
<!--#include file="include/metatag.inc" -->
<LINK href="include/styles.css" rel=stylesheet>
</head>
<!--#include file="include/header.asp" -->
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
<!--#include file="include/menu.asp" -->
  <tr> 
    <td colspan="2"><div class="hrgreen"><img src="immagini/spacer.gif"></div></td>
  </tr>
  <tr> 
    <td colspan="2" align="right"><u><% = strLangSelectEditDeleteBlog %></u> &nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
</table>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" height="250">
  <tr> 
<!--#include file="include/layer_sx.asp" -->
    <td width="3" rowspan="2" background="immagini/punto.gif"><img src="immagini/bianco.gif"></td>
    <td valign="top" align="center">
	<% = request.querystring("msg") %><br><br>
<%
intStart = CInt((page-1) * intRecordsPerPage) 

strSQL = "SELECT blog.* FROM blog ORDER BY blog_id DESC"
strSQL = strSQL & " LIMIT " & intStart & ", " & RecordsInPage
set rsblog = adoCon.Execute(strSQL)
Set rscommenti = Server.CreateObject("ADODB.Recordset")
		
If rsblog.EOF AND rsblog.BOF Then
	Response.Write "<div align='center'><br><br><br>" & strLangErrorMessageNoBlog3 & "</div>"
	Response.End
Else	
%>
<div><% = UCase(strLangGlobBlogInDb) %> :  <font class="arancio"><b><% = totale %></b></font></div>
<br>
		  <table width="95%" border="0" cellspacing="0" cellpadding="2" class="tablemenu">
                    <tr align="center" valign="middle"> 
                      <td width="25%" align="center"><b><% = strLangGlobTableBlog1 %></b></td>
                      <td width="25%" align="center"><b><% = strLangGlobTableBlog2 %></b></td>
					  <td width="20%" align="center"><b><% = strLangGlobTableBlog3 %></b></td>
                      <td width="15%" align="center"><b><% = strLangGlobTableBlog4 %></b></td>
                      <td width="15%" align="center"><b><% = strLangGlobTableBlog5 %></b></td>
                    </tr>
  <%
       For i=1 to RecordsInPage

           if Not rsblog.EOF then 
		
		   strSQL = "SELECT Count(commenti.blog_id) AS numerocommenti "
		   strSQL = strSQL & "FROM commenti "
		   strSQL = strSQL & "WHERE commenti.blog_id = " & CLng(rsblog("blog_id")) & ";"
				
		   rscommenti.Open strSQL, adoCon
	%>
                    <tr align="center" valign="middle"> 
                      <td align="center"><%
                                            strText = rsblog("blog_titolo")
                                            Response.write anteprima(strText, 3)
                                          %>

                      </td>
                      <td align="center"><%If rsblog("blog_email") <> "" Then Response.Write("<a href=""mailto:" & rsblog("blog_email") & """ >" &  rsblog("blog_autore") & "</a>") Else Response.Write(rsblog("blog_autore")) %></td>
					  <td align="center">
					    <% If CBool(rsblog("commenti")) = True Then 
                              If NOT rscommenti.EOF Then 
					                 Response.Write rscommenti("numerocommenti")
	                       	  Else
	                                 Response.Write  "0"
	                          End If
						   Else
						   Response.Write  strLangGlobNoComment
						   End If
                                         %>
                      </td>
                      <td align="center">
					  <% If rscommenti("numerocommenti") <>"0" Then %>
					  <a href="editallcommenti.asp?blog_id=<% = rsblog("blog_id")%>"><img src="immagini/edit2.gif" alt="<% = strLangCheckAltEditCommentsBlog %> '<% = rsblog("blog_titolo")%>'" border="0"></a>
					  <% else %>
					  &nbsp;
					  <%end if%></td>
                      <td align="center"><a href="edit_blog.asp?blog_id=<% = rsblog("blog_id")%>"><img src="immagini/edit.gif" alt="<% = LCase(strLangNavEditBlog) %>" border="0"></a>&nbsp;&nbsp;&nbsp;<a href="del_blog.asp?blog_id=<% = rsblog("blog_id")%>" onClick="return confirm('<% = strLangCheckDelBlog %>');"><img src="immagini/del.gif" alt="<% = strLangCheckAltDelBlog %>" border="0"></a></td>
                    </tr>
  <%
		  rscommenti.Close
        else
        exit for
        end if 
   rsblog.movenext
Next 
RecordsInPage=intRecordsPerPage
%>
</table>
<br><br>
<%
Response.Write "<table width=""90%""  align=""center"" border=""0"" cellspacing=""0"" cellpadding=""0"" height=""20""><tr><td align=""center"" width=""30%"">"
maxpages = int(totale / RecordsInPage)
if (totale mod RecordsInPage) <> 0 then 
   maxpages = maxpages + 1 
end if 

Blocks=0
Blocks = int(maxpages / PagesPerBlock)
if (maxpages mod PagesPerBlock) <> 0 then 
	Blocks = Blocks + 1 
end if 

Response.Write "" & strLangGlobPage & " " &  page &  " " & strLangGlobOf & " " & maxpages & "</td><td align=""center"" width=""70%"">"

PagStop=Block*PagesPerBlock
PagStart=(PagStop-PagesPerBlock)+1

i=0
if maxpages>1 then 
	For vpage=PagStart to PagStop
        i=i+1 
        if Block=1 then i=0    
        
        if i=1 and Block>1 then 
           Response.Write "<A href='editallblog.asp?Block=" & _
           (Block-1)& "&page=" & vpage-1 & _
           "&RecordsInPage=" & intRecordsPerPage & "' title='" & strLangNavAltPagePrev & "'>" & _
           "<img src='immagini/frecciasx.gif' border='0'><img src='immagini/frecciasx.gif' border='0'></A>&nbsp;&nbsp;"
        end if
        
        RemainingRecords = totale-(vpage*intRecordsPerPage)  
        if RemainingRecords > 0 then 
           Response.Write "<A href='editallblog.asp?Block=" & Block & _
           "&page=" & vpage & "&RecordsInPage=" & _
           intRecordsPerPage & "'>" & vpage & "</A> "
        else 
           NumberLastRecords = intRecordsPerPage+RemainingRecords
           Response.Write "<A href='editallblog.asp?Block=" & Block & _
           "&page=" & vpage & "&RecordsInPage=" & _
           NumberLastRecords & "'>" & vpage & "</A> "
           exit for
        end if
        
        if vpage=PagStop AND Blocks>1 and int(Block-1)<int(Blocks) then 
           Response.Write "<A href='editallblog.asp?Block=" & (Block+1) & _
		   "&page=" & vpage+1 &  "&RecordsInPage=" & intRecordsPerPage & "' title='" & strLangNavAltPageNext & "'>" & _ 
		   "&nbsp;&nbsp;<img src='immagini/freccia.gif' border='0'><img src='immagini/freccia.gif' border='0'></A>"
           exit for
        end if
	Next
end if
end if

Response.Write "</td></tr></table>"
%>
 <br>
<br>	
<% 
rsblog.Close
Set rsblog = Nothing
Set rscommenti = Nothing
Set strCon = Nothing
Set adoCon = Nothing
%>
	
	
	</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<!--#include file="include/footer.asp" -->
