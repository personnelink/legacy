<HTML> 
<BODY> 
<%@ Language=VBScript %>

<!-- #include file="upload.asp" -->
<%
'NOTE - YOU MUST HAVE VBSCRIPT v5.0 INSTALLED ON YOUR WEB SERVER
'	FOR THIS LIBRARY TO FUNCTION CORRECTLY. YOU CAN OBTAIN IT
'	FREE FROM MICROSOFT WHEN YOU INSTALL INTERNET EXPLORER 5.0
'	OR LATER.

' Create the FileUploader
dim Uploader, File
Set Uploader = New FileUploader
' This starts the upload process
Uploader.Upload()
'******************************************
' Use [FileUploader object].Form to access 
' additional form variables submitted with
' the file upload(s). (used below)
'******************************************
response.write "<b>Thank you for your upload " & Uploader.Form("fullname") & "</b><br>"
' Check if any files were uploaded
if Uploader.Files.Count = 0 then
 response.write "File(s) not uploaded."
Else
 ' loop through the uploaded files
 For Each File In Uploader.Files.Items
  
  ' Check where the user wants to save the file
  if Uploader.Form("saveto") = "disk" then
 
   ' Save the file
   File.SaveToDisk "E:\UploadedFiles\"
 
  elseif Uploader.Form("saveto") = "database" then
   
   ' Open the table you are saving the file to
   Set RS = Server.CreateObject("ADODB.Recordset")
   RS.Open "MyUploadTable", "CONNECT STRING OR ADO.Connection", 2, 2
   RS.AddNew ' create a new record
   
   RS("filename")	= File.FileName
   RS("filesize")   = File.FileSize
   RS("contenttype") = File.ContentType
  
   ' Save the file to the database
   File.SaveToDatabase RS("filedata")
   
   ' Commit the changes and close
   RS.Update
   RS.Close
  end if
  
  ' Output the file details to the browser
  response.write "File Uploaded: " & File.FileName & "<br>"
  response.write "Size: " & File.FileSize & " bytes<br>"
  response.write "Type: " & File.ContentType & "<br><br>"
 Next
end if
%> 
</BODY> 
</HTML>