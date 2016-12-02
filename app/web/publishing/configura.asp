<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="include/common.asp" -->
<!--#include file="include/calendario.asp" -->
<!--#include file="include/funzioni_filtro.asp" -->
<%
Response.Buffer = True
Dim iMonth, iYear
iMonth=Request ("month")
iYear=Request ("year")
if iMonth = "" then iMonth = Month(Now)
sMonth=NameFromMonth(iMonth)
if iYear = "" then iYear = Year(Now)
Dim rsconfigurazione 
Dim operazione
Dim username
Dim password
Dim nomeblog
Dim email_address
Dim email_notify
Dim n_record
Dim cookie
Dim tipologia
    
      
If Session("admin") = False or IsNull(Session("admin")) = True then
	Response.Redirect"login.asp?strMode=config"
End If

username = Request.Form("username")
password = Request.Form("password")
nomeblog = Request.Form("nomeblog")
email_address = Request.Form("email_address")

' remove tag
username = removeAllTags(username)
password = removeAllTags(password)
nomeblog = removeAllTags(nomeblog)
email_address = removeAllTags(email_address)

email_notify = Request.Form("email_notify")
n_record = CInt(Request.Form("n_record"))
cookie = Request.Form("cookie")
tipologia = Request.Form("tipologia")
operazione = Request.Form("mode")

If operazione = "change" Then
strSQL = "UPDATE configurazione SET username = '"&username&"',password = '"&password&"',nomeblog = '"&nomeblog&"',email_address = '"&email_address&"',email_notify = '"&email_notify&"',n_record = '"&n_record&"',cookie = '"&cookie&"',tipologia = '"&tipologia&"';"
adoCon.Execute strSQL

Else

Set rsconfigurazione = Server.CreateObject("ADODB.Recordset")
strSQL = "SELECT configurazione.* FROM configurazione;"
rsconfigurazione.CursorType = 3
rsconfigurazione.Open strSQL, adoCon

    If NOT rsconfigurazione.EOF Then
	   username = rsconfigurazione.Fields("username")
	   password = rsconfigurazione.Fields("password")
	   nomeblog = rsconfigurazione.Fields("nomeblog")
	   email_address = rsconfigurazione.Fields("email_address")
	   email_notify = rsconfigurazione.Fields("email_notify")
	   n_record = rsconfigurazione.Fields("n_record")	
	   cookie = rsconfigurazione.Fields("cookie")
	   tipologia = rsconfigurazione.Fields("tipologia")
    End If
rsconfigurazione.Close
Set rsconfigurazione = Nothing

End If
%>

<html>
<head>
<title><% = Ublogname %></title>
<!--#include file="include/metatag.inc" -->
<LINK href="include/styles.css" rel=stylesheet>
<script  language="JavaScript">
<!-- 
function CheckForm(){
if (document.form_config.nomeblog.value==""){
alert("<% = strLangCheckConfigAppname %>");
return false;
}
if (document.form_config.username.value==""){
alert("<% = strLangCheckConfigUsername %>");
return false;
}
if (document.form_config.password.value==""){
alert("<% = strLangCheckConfigPassword %>");
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
    <td colspan="2" align="right"><u><% = strLangSelectConfigBlog %></u>&nbsp;</td>
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
<form method="post" name="form_config" action="configura.asp" onSubmit="return CheckForm();">
  <table border="0" align="center" cellpadding="4" cellspacing="1" width="85%" class="tablemenu">
          <tr> 
            <td colspan="2" align="center"><font class="green"><b><% = UCase(strLangSelectConfigBlog) %></b></font> </td>
           </tr>
					    <tr> 
                        <td colspan="2"><div class="hrarancio"><img src="immagini/spacer.gif"></div></td>
                      </tr>
    <tr> 
            <td colspan="2"><% = strLangFormRequiredFields %></td>
    </tr>
          <tr> 
            <td valign="top"><% = strLangFormUblogTitle %> :*</td>
            <td valign="top" ><input name="nomeblog" type="text" class="form" value="<% = nomeblog %>" size="30" maxlength="255"></td>
          </tr>
    <tr> 
            <td width="60%" valign="top"><% = strLangFormUsernameAdmin %> :*</td>
      <td valign="top" > <input type="text" name="username" maxlength="30" value="<% = username %>" class="form"> 
      </td>
    </tr>
    <tr> 
            <td valign="top"><% = strLangFormPasswordAdmin %> :*</td>
      <td valign="top" > <input type="text" name="password" maxlength="30" value="<% = password %>" class="form"> 
      </td>
    </tr>
    <tr> 
            <td valign="top"><% = strLangFormEmailAdmin %> :</td>
      <td valign="top" ><input name="email_address" type="text" class="form" value="<% = email_address  %>" maxlength="50"></td>
    </tr>
    <tr> 
            <td valign="top"><% = strLangFormEmailNotify %> :</td>
            <td valign="top" ><% = strLangFormYes %> 
                             <input type="radio" name="email_notify" value="True" <% If email_notify = "True" Then Response.Write "checked" %>> 
                              &nbsp;&nbsp;&nbsp;<% = strLangFormNo %> 
                            <input type="radio" name="email_notify" value="False" <% If email_notify = "False" Then Response.Write "checked" %>> 
      </td>
    </tr>
    <tr> 
            <td valign="top"><% = strLangFormNumberOfRecords %> : </td>
      <td valign="top" > <select name="n_record" class="form">
          <option value="1" <% If n_record = 1 Then Response.Write("selected") %>>1</option>
          <option value="2" <% If n_record = 2 Then Response.Write("selected") %>>2</option>
          <option value="3" <% If n_record = 3 Then Response.Write("selected") %>>3</option>
          <option value="4" <% If n_record = 4 Then Response.Write("selected") %>>4</option>
          <option value="5" <% If n_record = 5 Then Response.Write("selected") %>>5</option>
          <option value="6" <% If n_record = 6 Then Response.Write("selected") %>>6</option>
          <option value="7" <% If n_record = 7 Then Response.Write("selected") %>>7</option>
          <option value="8" <% If n_record = 8 Then Response.Write("selected") %>>8</option>
          <option value="9" <% If n_record = 9 Then Response.Write("selected") %>>9</option>
          <option value="10" <% If n_record = 10 Then Response.Write("selected") %>>10</option>
          <option value="12" <% If n_record = 12 Then Response.Write("selected") %>>12</option>
          <option value="14" <% If n_record = 14 Then Response.Write("selected") %>>14</option>
          <option value="18" <% If n_record = 18 Then Response.Write("selected") %>>18</option>
          <option value="20" <% If n_record = 20 Then Response.Write("selected") %>>20</option>
        </select> </td>
    </tr>
    <tr> 
            <td valign="top"><% = strLangFormAntiSpam %> :<br>
             <% = strLangFormAntiSpamMessage %></td>
      <td valign="top" ><% = strLangFormYes %> 
	                   <input type="radio" name="cookie" value="True" <% If cookie = "True" Then Response.Write "checked" %>> 
        &nbsp;&nbsp;&nbsp;<% = strLangFormNo %> 
		              <input type="radio" name="cookie" value="False" <% If cookie = "False" Then Response.Write "checked" %>> 
      </td>
    </tr>
    <tr> 
            <td valign="top"><% = strLangFormTypeOfUblog %> :<br> 
			<% = strLangFormTypeOfUblogmessage %></td>
           <td valign="top"><select name="tipologia" class="form">
          <option value="open" <% If tipologia = "open" Then Response.Write("selected") %>><% = strLangFormOpenUblog %></option>
          <option value="closed" <% If tipologia = "closed" Then Response.Write("selected") %>><% = strLangFormClosedUblog %></option>
		  </select>
      </td>
    </tr>
                <tr> 
                  <td valign="top" align="right" >&nbsp;</td>
                  <td align="left">&nbsp; </td>
                </tr>
    <tr align="center"> 
      <td colspan="2" valign="top" > <input type="hidden" name="mode" value="change"> 
              <input type="submit" name="Submit" value="<% = strLangFormEditConfigUblog %>" class="form"> 
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
