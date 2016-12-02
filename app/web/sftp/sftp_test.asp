<%
dim Sftp
set Sftp = Server.CreateObject("WeOnlyDo.wodSFTPCom.1")

'Authenticate with server using hostname, login, password.
with Sftp
	.HostName = "your_hostname"
	.Login = "your_login"
	.Password = "your_password"
	.Blocking = True  'Use synchronous connections
	.Connect
end with

'After connection with server is successful upload the file from your local system using only one method.
Sftp.PutFile "c:\somefile.txt", "/home/somefolder/"

%>
