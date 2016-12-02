<!--#include file="include/common.asp" -->
<!--#include file="include/clsImageSize.asp" -->
<!--#include file="include/clsUpload.asp" -->
<%
Dim Uploader, File, nome_file, strMode, msg
Set Uploader = New FileUploader
Uploader.maxFileSize = maxsizefile

Uploader.fileExt = kinkoffile

Uploader.Upload()

strMode = Uploader.Form("strMode")
msg = ""
strPath2 = Server.MapPath(strPathShort) & "\"

If Uploader.Files.Count = 0 Then
   If Uploader.Error Then
    msg = "<b>" & strLangUploadError & ":</b><br><br>" & Uploader.ErrorDesc
   End if 
msg = msg & "<br><div align=""center""><b>" & strLangUploadErrorNoFileSend & "</b></div><br><br><br><br>"
Else
   If Uploader.Error Then
   msg = "<b>" & strLangUploadError & ":</b><br><br>" & Uploader.ErrorDesc & "<br><br><br><br><br>"
   End if
   For Each File In Uploader.Files.Items
     File.SaveToDisk strPath2
	 nome_file = File.FileName
       If Not IsImage(StrPathShort & File.FileName) Then
         msg = "<b>" & strLangUploadError & ":</b><br><br><b>" & File.FileName & "</b> " & strLangUploadErrorNoImage & "<br><br><br><br><br>"
	     Set fso = CreateObject("Scripting.FileSystemObject")
            If fso.FileExists(strPath2 & File.FileName) Then fso.DeleteFile(strPath2 & File.FileName)
         Set fso = Nothing
       End if
   Next
End If
%>
<html>
<head>
<title><% = strLangAltAddCodeUploadIMG %></title>
<% If msg="" Then 
        If strMode="new" AND Ublogtype="open" Then %>
          <script  language="JavaScript">
	           window.opener.document.formblog.blog_testo.focus();
	           window.opener.document.formblog.blog_testo.value += '[IMG]http://<% = Request.ServerVariables("HTTP_HOST") & StrPathShort & nome_file %>[/IMG]';
	           window.close();
          </script>
		<% Else %>
          <script  language="JavaScript">
	           window.opener.document.formblog.blog_testo.focus();
	           window.opener.document.formblog.blog_testo.value += '<img src="http://<% = Request.ServerVariables("HTTP_HOST") & StrPathShort & nome_file %>" border="0">';
	           window.close();
          </script>
		<% End if
  End if%>
<!--#include file="include/metatag.inc" -->
<LINK href="include/styles.css" rel=stylesheet>
</head>
<body>
<table width="95%" border="0" cellspacing="0" cellpadding="1" align="center" height="53">
  <tr> 
    <td align="center" height="17"><font class="green"><b><% = UCase(strLangAltAddCodeUploadIMG) %></b></font></td>
  </tr>
  <tr>
    <td align="center" height="39"><a href="JavaScript:onClick=window.close()"><% = strLangSelectCloseWindow %></a><font class="green"> | </font><a href="javascript:history.go(-1)"><% = strLangNavBackPrevPage %></a></td>
  </tr>
</table>

<table width="95%" border="0" cellspacing="0" cellpadding="0" class="tablemenu" align="center">
        <tr> 
          <td width="100%">&nbsp;</td>
        </tr>
        <tr>
          <td width="100%"><%=msg%></td>
        </tr>
        <tr>
          <td width="100%">&nbsp;</td>
        </tr>	
</table>
<table width="95%" border="0" cellspacing="0" cellpadding="1" align="center">
  <tr>
    <td align="center" height="39"><a href="JavaScript:onClick=window.close()"><% = strLangSelectCloseWindow %></a><font class="green"> | </font><a href="javascript:history.go(-1)"><% = strLangNavBackPrevPage %></a></td>
  </tr>
</table>
</body>
</html>
