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
%>

<html>
<head>
<title><% = Ublogname %></title>
<!--#include file="include/metatag.inc" -->
<LINK href="include/styles.css" rel=stylesheet>
<script  language="JavaScript">
<!-- 
function CheckForm(){
if (document.form_login.txtUserName.value==""){
alert("<% = strLangCheckUsername %>");
return false;
}
if (document.form_login.txtUserPass.value==""){
alert("<% = strLangCheckPassword %>");
return false;
}
return true;
}
// -->
</script>
</head>
<!--#include file="include/header.asp" -->
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
<!--#include file="include/menu.asp" -->
  <tr> 
    <td colspan="2"><div class="hrgreen"><img src="immagini/spacer.gif"></div></td>
  </tr>
  <tr> 
    <td colspan="2" align="right"><u><% = strLangSelectAdminLogin %></u>&nbsp;</td>
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
<%= request.querystring("msg") %><br>
<form name="form_login" method="post" action="verifica_accesso.asp" onSubmit="return CheckForm();">
        <table width="380" border="0" align="center" cellspacing="0" cellpadding="0" class="tablemenu">
                <tr> 
            <td align="right" height="46"  width="94"><% = strLangFormUsername %>:&nbsp;
            </td>
            <td height="46" width="172"> <input name="txtUserName" type="text" class="form" AUTOCOMPLETE = "off"> 
            </td>
          </tr>
          <tr> 
            <td align="right" valign="bottom">&nbsp;</td>
            <td valign="bottom" >&nbsp;</td>
          </tr>
          <tr> 
            <td align="right" width="94" ><% = strLangFormPassword %>:&nbsp;
            </td>
            <td width="172"> <input name="txtUserPass" type="password" class="form" AUTOCOMPLETE = "off"> 
            </td>
          </tr>
          <tr> 
            <td align="right" height="44" width="94"><input name="strMode" type="hidden" value="<% =request.QueryString("strMode")%>"></td>
            <td height="44" width="172"> &nbsp; <input type="submit" name="Submit" value="<% = strLangFormEnter %>" class="FORM"> 
              &nbsp;&nbsp;&nbsp;&nbsp; <input type="reset" name="Submit2" value="<% = strLangFormReset %>" class="form"> 
            </td>
          </tr>
        </table>
  </form>
<br>
      <U><% = strLangInfoActiveCookieJav %></U></td>
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
