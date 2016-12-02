<% @Language="VBScript" %>
<% 
Set theForm = Server.CreateObject("ABCUpload4.XForm")
theForm.Overwrite = True
Set theField = theForm.Files("image1")
If theField.FileExists Then theField.Save theField.FileName
Set theField = theForm.Files("image2")
If theField.FileExists Then theField.Save theField.FileName
%>
<html>
<body>
Images uploaded...
</body>
</html>
