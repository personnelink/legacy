<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="include/common.asp" -->
<!--#include file="include/calendario.asp" -->
<%
Dim iMonth, iYear
Dim giorno, archivio, mese
iMonth=Request ("month")
iYear=Request ("year")
if iMonth = "" then iMonth = Month(Now)
sMonth=NameFromMonth(iMonth)
if iYear = "" then iYear = Year(Now)
giorno=request.querystring("giorno")
archivio=request.querystring("archivio")
mese=Right(CStr(100+iMonth), 2)

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
Dim msg

page = Request("page")
RecordsInPage = Request("RecordsInPage")
Block = Request("Block")

if Block="" then Block=1 
if RecordsInPage="" then RecordsInPage=intRecordsPerPage
if page="" then page=1

if giorno <> "" then
SQLCount = "SELECT COUNT(*) as totale FROM blog WHERE giorno = '" & giorno & "' AND mese = '" & mese & "' AND anno = '" & iYear & "'"
elseif archivio<>"OK" then
SQLCount = "SELECT COUNT(*) as totale FROM blog WHERE mese = '" & mese & "' AND anno = '" & iYear & "'"
else
SQLCount = "SELECT COUNT(*) as totale FROM blog"
end if
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
    <td colspan="2" align="right"><u><% = strLangSelectArchivesBlog %></u> &nbsp;<img src="immagini/freccia.gif"><img src="immagini/freccia.gif">&nbsp;&nbsp;<font class="arancio"><b> 
      <%If giorno <> "" Then 
	       response.write giorno & "&nbsp;" & Ucase(sMonth) & "&nbsp;" & iYear 
	    elseif archivio<>"OK" then
		   response.write Ucase(sMonth) & "&nbsp;" & iYear 
		else
		   response.write strLangSelectArchivesBlogFull
	   end if %>
      </b></font>&nbsp;</td>
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
    <td valign="top">
<%
intStart = CInt((page-1) * intRecordsPerPage) 
' verifico se la scelta è relativa ad un giorno specifico
' nel caso di giorno<>"" visualizzo tutti i blog relativi al giorno specificato
if giorno <> "" then
strSQL = "SELECT blog.* FROM blog WHERE giorno = '" & giorno & "' AND mese = '" & mese & "' AND anno = '" & iYear & "' ORDER BY blog_id DESC"
strSQL = strSQL & " LIMIT " & intStart & ", " & RecordsInPage
msg = "<div align='center'><br><br><br>" & strLangErrorMessageNoBlog1 &""
msg = msg & "<br><br><a href='index.asp?archivio=OK'>" & strLangNavRedirectErrorNoBlog & "</a></div>"

' verifico se è stato scelto di visualizzare l'archivio completo ed in caso contrario, archivio <>OK, visualizzo i blog relativi al mese richiamato dal calendario
elseif archivio<>"OK" then
strSQL = "SELECT blog.* FROM blog WHERE mese = '" & mese & "' AND anno = '" & iYear & "' ORDER BY blog_id DESC"
strSQL = strSQL & " LIMIT " & intStart & ", " & RecordsInPage
msg = "<div align='center'><br><br><br>" & strLangErrorMessageNoBlog2 &""
msg = msg & "<br><br><a href='index.asp?archivio=OK'>" & strLangNavRedirectErrorNoBlog & "</a></div>"

else
' visualizzo tutto l'archivio blog
strSQL = "SELECT blog.* FROM blog ORDER BY blog_id DESC"
strSQL = strSQL & " LIMIT " & intStart & ", " & RecordsInPage 
msg = "<div align='center'><br><br><br>" & strLangErrorMessageNoBlog3 &""
end if

set rsblog = adoCon.Execute(strSQL)

	
Set rscommenti = Server.CreateObject("ADODB.Recordset")
		
If rsblog.EOF AND rsblog.BOF Then
	Response.Write msg
	Response.End
Else	
	
	
       For i=1 to RecordsInPage

            if Not rsblog.EOF then 
		
		    strSQL = "SELECT Count(commenti.blog_id) AS numerocommenti "
		    strSQL = strSQL & "FROM commenti "
		    strSQL = strSQL & "WHERE commenti.blog_id = " & CLng(rsblog("blog_id")) & ";"
				
		    rscommenti.Open strSQL, adoCon
	

%>
            
      <table width="85%" border="0" cellspacing="0" cellpadding="2" align="center" class="tablemenu">
        <tr> 
          <td width="70%"> <b> 
            <% = UCase(rsblog("blog_titolo")) %></b>&nbsp;&nbsp;<% = strLangGlobBy %><b>&nbsp;<%If rsblog("blog_email") <> "" Then Response.Write("<a href=""mailto:" & rsblog("blog_email") & """ >" & rsblog("blog_autore") & "</a>") Else Response.Write(rsblog("blog_autore")) %></b> </td>
          <td align="right"><% = rsblog("data")%>&nbsp;<% = strLangGlobAt %>&nbsp;<% = FormatDateTime(rsblog("ora"),vbShortTime) %>
          </td>
        </tr>
        <tr> 
          <td colspan="2"> 
            <div class="hrgreen"><img src="immagini/spacer.gif"></div>
          </td>
        </tr>
        <tr> 
          <td ALIGN="JUSTIFY" colspan="2">
<%
strText = rsblog("blog_testo")
Response.write anteprima(strText, 40)
%>
          </td>
        </tr>
        <tr> 
          <td colspan="2"> 
          <div class="hrgreen"><img src="immagini/spacer.gif"></div>
          </td>
        </tr>
        <tr> 
          <td> 
            <%
                  
		If CBool(rsblog("commenti")) = True Then  
                  
                  %>
            <a href="blog_commento.asp?blog_id=<% = rsblog("blog_id") %>&month=<% = iMonth %>&year=<% = iYear %>&giorno=<% = giorno %>&archivio=<% = archivio %>&#commento"><% = strLangFormSubmitComment %></a> 
            <% 
                                                                          
	            	If NOT rscommenti.EOF Then 
	            		Response.Write "&nbsp;[ " & strLangGlobNumberOfComment & " " & rscommenti("numerocommenti") & " ]"
	            	Else
	            		Response.Write  "&nbsp;[ " & strLangGlobNumberOfComment & " 0 ]"
	            	End If
		End If
                     %>
          </td>
          <td align="right" class="back2"><img src="immagini/dettagli.gif">&nbsp; 
            <a href="blog_commento.asp?blog_id=<% = rsblog("blog_id") %>&month=<% = iMonth %>&year=<% = iYear %>&giorno=<% = giorno %>&archivio=<% = archivio %>"><% = strLangGlobReadAll %></a> </td>
        </tr>
      </table>
	<br><br>
            
<%
		  rscommenti.Close
        else
        exit for
        end if 
   rsblog.movenext
Next 
RecordsInPage=intRecordsPerPage
%>
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
           Response.Write "<A href='index.asp?Block=" & _
           (Block-1)& "&page=" & vpage-1 & _
           "&RecordsInPage=" & intRecordsPerPage & "&month="& mese &"&year="& iYear &"&giorno=" & giorno & "&archivio="& archivio &"' title='" & strLangNavAltPagePrev & "'>" & _
           "<img src='immagini/frecciasx.gif' border='0'><img src='immagini/frecciasx.gif' border='0'></A>&nbsp;&nbsp;"
        end if
        
        RemainingRecords = totale-(vpage*intRecordsPerPage)  
        if RemainingRecords > 0 then 
           Response.Write "<A href='index.asp?Block=" & Block & _
           "&page=" & vpage & "&RecordsInPage=" & _
           intRecordsPerPage & "&month="& mese &"&year="& iYear &"&giorno=" & giorno & "&archivio="& archivio &"'>" & vpage & "</A> "
        else 
           NumberLastRecords = intRecordsPerPage+RemainingRecords
           Response.Write "<A href='index.asp?Block=" & Block & _
           "&page=" & vpage & "&RecordsInPage=" & _
           NumberLastRecords & "&month="& mese &"&year="& iYear &"&giorno=" & giorno & "&archivio="& archivio &"'>" & vpage & "</A> "
           exit for
        end if
        
        if vpage=PagStop AND Blocks>1 and int(Block-1)<int(Blocks) then 
           Response.Write "<A href='index.asp?Block=" & (Block+1) & _
		   "&page=" & vpage+1 &  "&RecordsInPage=" & intRecordsPerPage & "&month="& mese &"&year="& iYear &"&giorno=" & giorno & "&archivio="& archivio &"' title='" & strLangNavAltPageNext & "'>" & _ 
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
