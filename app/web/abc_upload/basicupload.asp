<% @Language="VBScript" %>
<% 
Set theForm = Server.CreateObject("ABCUpload4.XForm")
theForm.Overwrite = True
If theForm.Files("filefield").FileExists Then
   theForm.Files("filefield").Save "myupload.dat"
End If
%>
<html>
<body>
File uploaded...
</body>
</html>