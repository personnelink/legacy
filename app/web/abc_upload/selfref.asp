<% @Language="VBScript" %>
<% 
Set theForm = Server.CreateObject("ABCUpload4.XForm")
If theForm.Count > 0 Then
   theForm.Overwrite = True
   Set theField = theForm.Files("filefield")
   If theField.FileExists Then
      theField.Save "myupload.dat"
   End If
End If
%>  
<html>
<body>
<form method="post" action="selfref.asp" enctype="multipart/form-data">
<input type="file" name="filefield"><br>
<input type="submit" name="submit" value="submit">
</form>
<body>
</html>
