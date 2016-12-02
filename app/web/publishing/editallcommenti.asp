<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="include/common.asp" -->
<!--#include file="include/calendario.asp" -->
<%
If Session("admin") = False or IsNull(Session("admin")) = True then
	response.Redirect("login.asp?strMode=edit")
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
Dim blog_id
blog_id =  Request.QueryString("blog_id")

page = Request("page")
RecordsInPage = Request("RecordsInPage")
Block = Request("Block")

if Block="" then Block=1 
if RecordsInPage="" then RecordsInPage=intRecordsPerPage
if page="" then page=1

SQLCount = "SELECT COUNT(*) as totale FROM commenti WHERE commenti.blog_id =" & blog_id
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
    <td colspan="2" align="right"><u><% = strLangSelectEditDeleteComments %> <font class="arancio"><b><% = blog_id %></b></font></u> &nbsp;</td>
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
strSQL = "SELECT commenti.* FROM commenti WHERE commenti.blog_id =" & blog_id
strSQL = strSQL & " LIMIT " & intStart & ", " & RecordsInPage
set rscommenti = adoCon.Execute(strSQL)
		
If rscommenti.EOF AND rscommenti.BOF Then
	Response.Write "<div align='center'><br><br><br>" & strLangErrorMessageNoComments & "<br><br><a href=""editallblog.asp"">" & strLangNavRedirectErrorNoComments & "</a></div>"
	Response.End
Else	

%>
<div><% = UCase(strLangGlobNumberOfComment) %>:  <font class="arancio"><b><% = totale %></b></font></div>
<br>
		  <table width="80%" border="0" cellspacing="0" cellpadding="2" class="tablemenu">
                    <tr valign="middle"> 
                      <td width="40%" align="center"><b><% = strLangGlobTableComment1 %></b></td>
                      <td width="40%" align="center"><b><% = strLangGlobTableComment2 %></b></td>
                      <td width="20%" align="center"><b><% = strLangGlobTableComment3 %></b></td>
                    </tr>
  <%
       For i=1 to RecordsInPage

           if Not rscommenti.EOF then 
	%>
                    <tr valign="middle"> 
                      <td align="center"><% = rscommenti("commento_autore")%></td>
                      <td align="center"><% =rscommenti("data")%></td>
                      <td align="center"><a href="edit_commento.asp?commento_id=<% = rscommenti("commento_id")%>"><img src="immagini/edit.gif" alt="<% = strLangCheckAltEditCommments %>" border="0"></a>&nbsp;&nbsp;&nbsp;<a href="del_commento.asp?commento_id=<% = rscommenti("commento_id")%>&blog_id=<% = blog_id %>" onClick="return confirm('<% = strLangCheckDelComments %>');"><img src="immagini/del.gif" alt="<% = strLangCheckAltDelComment %>" border="0"></a></td>
                    </tr>
  <%
        else
        exit for
        end if 
   rscommenti.movenext
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
           Response.Write "<A href='editallcommenti.asp?Block=" & _
           (Block-1)& "&page=" & vpage-1 & _
           "&RecordsInPage=" & intRecordsPerPage & "&blog_id=" & blog_id &"' title='" & strLangNavAltPagePrev & "'>" & _
           "<img src='immagini/frecciasx.gif' border='0'><img src='immagini/frecciasx.gif' border='0'></A>&nbsp;&nbsp;"
        end if
        
        RemainingRecords = totale-(vpage*intRecordsPerPage)  
        if RemainingRecords > 0 then 
           Response.Write "<A href='editallcommenti.asp?Block=" & Block & _
           "&page=" & vpage & "&RecordsInPage=" & _
           intRecordsPerPage & "&blog_id=" & blog_id &"'>" & vpage & "</A> "
        else 
           NumberLastRecords = intRecordsPerPage+RemainingRecords
           Response.Write "<A href='editallcommenti.asp?Block=" & Block & _
           "&page=" & vpage & "&RecordsInPage=" & _
           NumberLastRecords & "&blog_id=" & blog_id &"'>" & vpage & "</A> "
           exit for
        end if
        
        if vpage=PagStop AND Blocks>1 and int(Block-1)<int(Blocks) then 
           Response.Write "<A href='editallcommenti.asp?Block=" & (Block+1) & _
		   "&page=" & vpage+1 &  "&RecordsInPage=" & intRecordsPerPage & "&blog_id=" & blog_id &"' title='" & strLangNavAltPageNext & "'>" & _ 
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
rscommenti.Close
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
