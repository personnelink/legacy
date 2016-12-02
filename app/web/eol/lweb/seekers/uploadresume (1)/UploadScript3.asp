<HTML> 
<BODY> 

<%
Set Upload = Server.CreateObject("Persits.Upload.1") 
Upload.Save "\\192.168.0.15\personnelplus-inc.com\resume\" & <%=session("lastName")%> & ", " & <%=session("firstName")%> & ".doc"
On Error Resume Next 
For Each File in Upload.Files 
File.ToDatabase "DSN=data;UID=sa;PWD=xxx;",_
	"insert into Blobs(id, Path, BigBlob)" &_
	"values(12, '" & File.Path & "', ?)"
if Err <> 0 Then 
Response.Write "Error saving the file: " & Err.Description
Else 
File.Delete 
Response.Write "Success!"
End If
Next
%> 
</BODY> 
</HTML>