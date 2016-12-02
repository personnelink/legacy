<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="include/common.asp" -->
<!--#include file="include/calendario.asp" -->
<%
Response.Buffer = True
Dim iMonth, iYear
iMonth=Request ("month")
iYear=Request ("year")
if iMonth = "" then iMonth = Month(Now)
sMonth=NameFromMonth(iMonth)
if iYear = "" then iYear = Year(Now)
Dim blog_id
Dim rscommenti
Dim commento_autore
Dim commento_email
Dim commento_testo
Dim data
commento_id = Request.Querystring("commento_id")

If Session("admin") = False or IsNull(Session("admin")) = True then
	Response.Redirect"login.asp?strMode=edit"
End If


Set rscommenti = Server.CreateObject("ADODB.Recordset")
	
strSQL = "SELECT commenti.* "
strSQL = strSQL & "FROM commenti "
strSQL = strSQL & "WHERE commenti.commento_id = " & CLng(Request.QueryString("commento_id")) & ";"
	
rscommenti.Open strSQL, adoCon

If NOT rscommenti.EOF then
	
	commento_autore = rscommenti("commento_autore")
	commento_email = rscommenti("commento_email")
	data = rscommenti("data")
	commento_testo = rscommenti("commento_testo")
	blog_id = CLng(rscommenti("blog_id"))
End If

commento_testo = Replace(commento_testo, "<br>", vbCrLf)

rscommenti.Close
Set rscommenti = Nothing
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

function AddMessageCode(code, promptText, InsertText) {

	if (code != "") {
			insertCode = prompt(promptText + "\n<" + code + ">xxx</" + code + ">", InsertText);
				if ((insertCode != null) && (insertCode != "")){
					document.formcommenti.commento.value += "<" + code + ">" + insertCode + "</" + code + ">";
				}
	}
	document.formcommenti.commento.focus();
}

// rollover
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
    <td colspan="2" align="right"><a href="editallcommenti.asp?blog_id=<% = blog_id %>"><% = strLangNavBackCommentsPage %></a> | <u><% = strLangNavEditCommmentNumber %> <font class="arancio"><b><% = commento_id %> </b></font></u>&nbsp;
  </td>
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
<form method="post" name="formcommenti" action="modifica_commento.asp" onSubmit="return CheckForm();">
        <table width="85%" border="0" cellspacing="1" cellpadding="4" align="center" class="tablemenu">
          <tr> 
            <td colspan="2" align="center"><font class="green"><b><% = UCase(strLangFormEditComment) %></b></font></td>
          </tr>
          <tr> 
            <td colspan="2"><div class="hrarancio"><img src="immagini/spacer.gif"></div></td>
          </tr>
          <tr align="left"> 
            <td colspan="2"><% = strLangFormRequiredFields %></td>
          </tr>
          <tr> 
            <td align="right" width="35%"><% = strLangFormAuthor %> (*) : </td>
            <td width="81%"> <input name="nome" type="text" class="form" size="25" maxlength="50" value="<% = commento_autore %>"> 
            </td>
          </tr>
          <tr> 
            <td align="right" width="35%"><% = strLangFormEmail %> :</td>
            <td width="81%"> <input type="text" name="email" size="25" maxlength="50" class="form" value="<% = commento_email %>"> 
            </td>
          </tr>
          <tr> 
            <td valign="top" align="right" width="35%">&nbsp;</td>
            <td width="81%" valign="bottom">&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top" align="right" width="35%">&nbsp;</td>
            <td width="81%" valign="bottom"> 
			  <a href="JavaScript:AddMessageCode('B','<% = strLangAddCodeB %>', '')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','immagini/bolddown.gif',1)"><img name="Image1" border="0" src="immagini/boldup.gif" alt="<% = strLangAltAddCodeB %>" align="absmiddle"></a> 
              <a href="JavaScript:AddMessageCode('I','<% = strLangAddCodeI %>', '')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','immagini/italicdown.gif',1)"><img name="Image2" border="0" src="immagini/italicup.gif" alt="<% = strLangAltAddCodeI %>" align="absmiddle"></a> 
              <a href="JavaScript:AddMessageCode('U','<% = strLangAddCodeU %>', '')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','immagini/underdown.gif',1)"><img name="Image3" border="0" src="immagini/underup.gif" alt="<% = strLangAltAddCodeU %>" align="absmiddle"></a> 
            </td>
          </tr>
          <tr> 
            <td valign="top" align="right" width="35%"><% = strLangFormComment %> (*) :<br>
              <br>
              <font class="green">html code</font><br><br><font class="arancio"><strike>ubb code</strike></font>
              <br>
              <br></td>
            <td width="81%" valign="top"> <textarea name="commento" cols="55" rows="10" class="form"><% = commento_testo %></textarea> 
            </td>
          </tr>
          <tr> 
            <td  align="right" width="35%" >&nbsp;</td>
            <td width="81%" valign="top">&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top" align="right" width="35%">&nbsp; </td>
            <td width="81%"> 
              <input name="commento_id" type="hidden" value="<% = commento_id %>"> 
              <input name="blog_id" type="hidden" value="<% = blog_id %>"> 
			  <input name="data" type="hidden" value="<% = data %>"> 
              <input type="submit" name="Submit" value="<% = LCase(strLangFormEditComment) %>" class="form"> 
            </td>
          </tr>
        </table>
</form>


	</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<% 
Set adoCon = Nothing
Set strCon = Nothing
%>
<!--#include file="include/footer.asp" -->
