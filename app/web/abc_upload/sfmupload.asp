<% @Language="VBScript" %>
<html>
<body>
<% 
Set theForm = Server.CreateObject("ABCUpload4.XForm")
theForm.AbsolutePath = True
Set theField = theForm.Files("file")
If theField.FileExists Then 
  theField.Save "C:\" & theField.SafeFileName
  Response.Write "File uploaded..."
Else
  Response.Write "No file uploaded..."
End If
%>
</body>
</html>
