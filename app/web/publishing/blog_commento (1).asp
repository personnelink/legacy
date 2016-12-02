<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="include/common.asp" -->
<!--#include file="include/calendario.asp" -->
<%
Dim iMonth, iYear, giorno, archivio
iMonth=Request ("month")
iYear=Request ("year")
if iMonth = "" then iMonth = Month(Now)
sMonth=NameFromMonth(iMonth)
if iYear = "" then iYear = Year(Now)
giorno=request.querystring("giorno")
archivio=request.querystring("archivio")


Dim rsblog
Dim rscommenti
Dim blog_id
Dim rscommenticount
Dim commenti_presenti


If isNull(Request.QueryString("blog_id")) = True Or isNumeric(Request.QueryString("blog_id")) = False Then
	Response.redirect "index.asp?month=" & iMonth &"&year=" & iYear &"&giorno=" & giorno & "&archivio="& archivio &""
Else
	blog_id = CLng(Request.QueryString("blog_id"))
	
End If

Set rsblog = Server.CreateObject("ADODB.Recordset")
	
strSQL = "SELECT blog.* FROM blog "
strSQL = strSQL & "WHERE blog.blog_id = " & blog_id
	
rsblog.Open strSQL, adoCon
If NOT rsblog.EOF Then
	commenti_presenti = CBool(rsblog("commenti"))
	Set rscommenticount = Server.CreateObject("ADODB.Recordset")
		
	strSQL = "SELECT Count(commenti.blog_id) AS numerocommenti "
	strSQL = strSQL & "FROM commenti "
	strSQL = strSQL & "WHERE commenti.blog_id = " & CLng(blog_id) & ";"
				
	rscommenticount.Open strSQL, adoCon
	
%>
<html>
<head>
<title><% = Ublogname %></title>
<!--#include file="include/metatag.inc" -->
<LINK href="include/styles.css" rel=stylesheet>
<script  language="JavaScript">
<!--
function CheckForm(){
if (document.formcommenti.nome.value==""){
alert("<% = strLangCheckAuthor %>");
return false;
}
if (document.formcommenti.email.value!=""){
		if (document.formcommenti.email.value.indexOf("@")==-1){
			alert("<% = strLangCheckEmail %>");
			return false;
		}	
	    if (document.formcommenti.email.value.indexOf(".")==-1){
			alert("<% = strLangCheckEmail %>");
			return false;
		}	
	}
if (document.formcommenti.commento.value==""){
alert("<% = strLangCheckText %>");
return false;
}
return true;
}

function AddMessageCode(code,promptText, InsertText) {

	if (code != "") {
		insertCode = prompt(promptText + "\n[" + code + "]xxx[/" + code + "]", InsertText);
			if ((insertCode != null) && (insertCode != "")){
				document.formcommenti.commento.value += "[" + code + "]" + insertCode + "[/"+ code + "] ";
			}
	}		
	document.formcommenti.commento.focus();
}

function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}


function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</head>
<!--#include file="include/header.asp" -->
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
<!--#include file="include/menu.asp" -->
  <tr> 
    <td colspan="2"><div class="hrgreen"><img src="immagini/spacer.gif"></div></td>
  </tr>
  <tr> 
    <td colspan="2" align="right"><u><% = strLangNavBlogDetails %></u> &nbsp;<img src="immagini/freccia.gif"><img src="immagini/freccia.gif">&nbsp;&nbsp;<font class="arancio"><b> 
      <% = rsblog("data") %>
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
            
      <table width="85%" border="0" cellspacing="0" cellpadding="2" align="center" class="tablemenu">
        <tr> 
          <td width="70%"><b><% = UCase(rsblog("blog_titolo")) %></b>&nbsp;&nbsp;<% = strLangGlobBy %>&nbsp;<b><%If rsblog("blog_email") <> "" Then Response.Write("<a href=""mailto:" & rsblog("blog_email") & """ >" & rsblog("blog_autore") & "</a>") Else Response.Write(rsblog("blog_autore")) %>
            </b> </td>
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
<% = rsblog("blog_testo")%>
          </td>
        </tr>
        <tr> 
          <td colspan="2"> 
           <div class="hrgreen"><img src="immagini/spacer.gif"></div>
          </td>
        </tr>
        <tr> 
          <td width="50%" colspan="2">
		 <% If commenti_presenti = True Then  
	            	If NOT rscommenticount.EOF Then 
	            		Response.Write "&nbsp;[ " & strLangGlobNumberOfComment & " " & rscommenticount("numerocommenti") & " ]"
	            	Else
	            		Response.Write  "&nbsp;[ " & strLangGlobNumberOfComment & " 0 ]"
	            	End If
			End If
                     %>
			</td>
        </tr>
      </table>
	   <% If commenti_presenti = True Then %>
	        <br>
            <br>
            <table width="85%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr> 
                <td>
	  <% If NOT rscommenticount.EOF Then %>
				  <div class="hrgreen"><img src="immagini/spacer.gif"></div>
				<B><% = UCase(strLangNavAddComment) %> : :  &nbsp;&nbsp;<font class="arancio"><% = rsblog("blog_titolo") %></font></B>
       <% end if %>
				<div class="hrgreen"><img src="immagini/spacer.gif"></div>
            <div class="back2"><a href="#commento"><% = strLangGlobAddComment %></a></div>
            <div class="hrgreen"><img src="immagini/spacer.gif"></div>
                </td>
              </tr>
            </table>
	<% end if %>
	  <%

rsblog.Close
Set rsblog = Nothing
rscommenticount.Close
Set rscommenticount = Nothing


End If

%>
<% If commenti_presenti = True Then %>
<%
Set rscommenti = Server.CreateObject("ADODB.Recordset")
strSQL = "SELECT commenti.* FROM commenti WHERE commenti.blog_id = " & blog_id & " ORDER BY data DESC;"
rscommenti.Open strSQL, adoCon

Do While NOT rscommenti.EOF
%>
      <br>
      <br>
		    <table width="85%" border="0" cellspacing="0" cellpadding="2" align="center" class="tablemenu">
        <tr> 
          <td width="60%"> 
          <% = strLangGlobPostedBy %> &nbsp;&nbsp;<b><%If rscommenti("commento_email") <> "" Then Response.Write("<a href=""mailto:" & rscommenti("commento_email") & """ >" & rscommenti("commento_autore") & "</a>") Else Response.Write(rscommenti("commento_autore")) %></b>
          </td>
          <td align="right"><% = FormatDateTime(rscommenti("data"), vbShortDate) %>&nbsp;<% = strLangGlobAt %>&nbsp;<% = FormatDateTime(rscommenti("data"),vbShortTime) %>
          </td>
        </tr>
        <tr> 
          <td colspan="2"> 
            <div class="hrgreen"><img src="immagini/spacer.gif"></div>
          </td>
        </tr>
              <tr> 
                <td align="JUSTIFY" colspan="2"> 
                   <% = rscommenti("commento_testo") %>
                </td>
              </tr>
        <tr> 
          <td colspan="2"> 
           <div class="hrgreen"><img src="immagini/spacer.gif"></div>
          </td>
        </tr>
            </table>
      <br>
      <br>
<%
	rscommenti.MoveNext

Loop

rscommenti.Close
Set rscommenti = Nothing
Set strCon = Nothing
Set adoCon = Nothing
%>
<br><br>
<form method="post" name="formcommenti" action="add_commento.asp?blog_id=<% = blog_id %>&month=<%= iMonth %>&year=<%= iYear %>&giorno=<% = giorno %>&archivio=<% = archivio %>" onSubmit="return CheckForm();" onReset="return confirm('<% = strLangCheckResetForm %>');">
        <table width="85%" border="0" cellspacing="1" cellpadding="4" align="center" class="tablemenu">
          <tr> 
            <td colspan="2" align="center"><font class="green"><b><a name="commento"></a><% = UCase(strLangFormSubmitComment) %></b></font></td>
          </tr>
          <tr> 
            <td colspan="2"><div class="hrarancio"><img src="immagini/spacer.gif"></div></td>
          </tr>
          <tr align="left"> 
            <td colspan="2"><% = strLangFormRequiredFields %></td>
          </tr>
          <tr> 
            <td align="right" width="35%"><% = strLangFormAuthor %> (*) : </td>
            <td width="81%"> <input name="nome" type="text" class="form" size="25" maxlength="50"> 
            </td>
          </tr>
          <tr> 
            <td align="right" width="35%"><% = strLangFormEmail %> :</td>
            <td width="81%"> <input type="text" name="email" size="25" maxlength="50" class="form" > 
            </td>
          </tr>
          <tr> 
            <td valign="top" align="right" width="35%">&nbsp;</td>
            <td width="81%" valign="bottom">&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top" align="right" width="35%">&nbsp;</td>
            <td width="81%" valign="bottom"> <a href="JavaScript:AddMessageCode('B','<% = strLangAddCodeB %>', '')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','immagini/bolddown.gif',1)"><img name="Image1" border="0" src="immagini/boldup.gif" alt="<% = strLangAltAddCodeB %>" align="absmiddle"></a> 
              <a href="JavaScript:AddMessageCode('I','<% = strLangAddCodeI %>', '')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','immagini/italicdown.gif',1)"><img name="Image2" border="0" src="immagini/italicup.gif" alt="<% = strLangAltAddCodeI %>" align="absmiddle"></a> 
              <a href="JavaScript:AddMessageCode('U','<% = strLangAddCodeU %>', '')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','immagini/underdown.gif',1)"><img name="Image3" border="0" src="immagini/underup.gif" alt="<% = strLangAltAddCodeU %>" align="absmiddle"></a> 
            </td>
          </tr>
          <tr> 
            <td valign="top" align="right" width="35%"><% = strLangFormComment %> (*) :<br>
              <br>
              <font class="arancio"><strike>html code</strike></font><br><br><font class="green">ubb code</font>
              <br>
              <br> </td>
            <td width="81%" valign="top"> <textarea name="commento" cols="55" rows="10" class="form"></textarea> 
            </td>
          </tr>
          <tr> 
            <td  align="right" width="35%" >&nbsp;</td>
            <td width="81%" valign="top">&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top" align="right" width="35%">&nbsp; </td>
            <td width="81%"> <input type="submit" name="Submit" value="<% = strLangFormSubmitComment %>" class="form"> 
              <input type="reset" name="Reset" value="<% = strLangFormReset %>" class="form"> 
            </td>
          </tr>
        </table>
</form>
<% end if %>
	</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<!--#include file="include/footer.asp" -->
