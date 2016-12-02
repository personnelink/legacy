<%
session("add_css") = "./report.css"
session("required_user_level") = 2048 'userLevelPPlusStaff
session("window_page_title") = "Timecards Archive - Personnel Plus"
session("no_header") = false
'on error resume next

dim qsBranch
qsBranch = request.querystring("site")

dim qsYear
qsYear = request.querystring("year")

dim path
if len(qsBranch) = 0 then
	path = "\\personnelplus.net.\net_docs\_timecards\"
else
	path = "\\personnelplus.net.\net_docs\_timecards\" & ucase(qsBranch) & "\"
end if

if len(qsYear) > 0 then
	path = path & qsYear & "\"
end if

ListFolderContents(path)

dim httpsPath, folderLevel

'if len(qsBranch) + len(qsYear) > 0 then session("no_header") = true



%>
<!-- #include virtual='/include/core/init_secure_session.asp' -->

<div>
<%



folderYear = 2
folderSite = 3
folderCustCode = 5

sub ListFolderContents(path)

dim folderPart(8)
	folderLevel = folderLevel + 1
	folderPart(folderLevel) = path
	
 dim fs, folder, file, item, url
 set fs = CreateObject("Scripting.FileSystemObject")
 set folder = fs.GetFolder(path)

'Display the target folder and info.

 Response.Write("<ul><b>" & folder.Name & "</b>") '- " _
 '  & folder.Files.Count & " files, ")
 'if folder.SubFolders.Count > 0 then
 '  Response.Write(folder.SubFolders.Count & " directories, ")
 'end if
 'Response.Write(Round(folder.Size / 1024) & " KB total." _
 '  & "</ul>" & vbCrLf)

 Response.Write("<ul>" & vbCrLf)

 'Display a list of sub folders.

 for each item in folder.SubFolders
	if instr(lcase(item.Name), "dfsrprivate") = 0 then 
		ListFolderContents(item)
	end if
 next

 'Display a list of files.

 for each item in folder.Files
	'print folderPart(folderSite) & ":" & folderPart(folderCustCode)
   'url = MapURL(item.path)
   'Response.Write("<li><a href=" & url & ">" & item.Name & "</a> - " _
	httpsPath = replace(item.path," ","%20")
	httpsPath = "https://www.personnelinc.com/net_docs/" & replace(httpsPath, "\\personnelplus.net.\net_docs\", "")
	httpsPath = replace(httpsPath, "\", "/")
	'print httpsPath
	if instr(httpsPath, ".pdf") > 0 or instr(httpsPath, ".txt") > 0 or instr(httpsPath, ".doc") > 0 or instr(httpsPath, "jpg") > 0 then
		Response.Write("<li><a href=""" & httpsPath & """>" & item.Name & "</a>" & "</li>" & vbCrLf)
	end if
 next

 Response.Write("</ul>" & vbCrLf)
 Response.Write("</ul>" & vbCrLf)

 folderLevel = folderLevel - 1
	response.flush
 end sub

function MapURL(path)

 dim rootPath, url

 'Convert a physical file path to a URL for hypertext links.

 rootPath = Server.MapPath("/")
 url = Right(path, Len(path) - Len(rootPath))
 MapURL = Replace(url, "\", "/")

end function

noSocial = true
%>
</div>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->