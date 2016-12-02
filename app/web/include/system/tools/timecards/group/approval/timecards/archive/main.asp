<%Option Explicit%>

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



'if len(qsBranch) + len(qsYear) > 0 then session("no_header") = true

dim customer
customer = request.querystring("customer")

dim whichCompany
whichCompany = request.querystring("whichCompany")

if len(whichCompany) = 0 then whichCompany = getTempsCompCode(company_dsn_site)

dim site_temps_code : site_temps_code = whichCompany


%>
<!-- #include virtual='/include/core/init_secure_session.asp' -->
<form method="get" name="reportform" id="reportform" />
<div id="whoseHereList"><%	if userLevelRequired(userLevelPPlusStaff) then %>
	<p><%=objCompanySelector(site_temps_code, false, "javascript:document.reportform.submit();")%>
		<a style="float:right;margin:.25em 1em .25em" class="squarebutton" href="#" onclick="act_refresh('<%=customer%>');"><span>Refresh View</span></a>
	</p>
	<p>
	<label for "customer" id="customerLbl">Enter customer code to search time card archive for:
	<input name="customer" id="customer" type="text" value="<%=customer%>"/></label></p><% 
	else
	
		customer = company_custcode
	
	
	end if %>
</form>

<div style="width:100%; clear:both;">
<%
response.flush()


const folderBranch = 1
const folderYear = 2
const folderSite = 3
const folderCustCode = 4

dim httpsPath







' note these comments below for finishing script later, the three variables below will be needed to navigate path



dim folderDepth
folderDepth = -1

dim folderParts(8)

' to filter folder artifacts, replace the "response.writes" with a string, then put a trap in to check if the folder depth is the same
' or got lower, if the folder depth got lower then check response string for present of hyperlink, 
' if hyperlink present then a timecard was found, otherwise, no card was found and string blob can be thrown away.
'





if len(customer) > 0 then
	ListFolderContents(path)
end if

sub ListFolderContents(path)
	dim fs, folder, file, item, url
	set fs = CreateObject("Scripting.FileSystemObject")
	set folder = fs.GetFolder(path)
	
	folderDepth = folderDepth + 1
	folderParts(folderDepth) = folder.Name

	'print "d:" & folderDepth & ", " & folderParts(folderDepth) & ", parts:" & folderParts(0) & ":" & folderParts(1) & ":" & folderParts(2) & ":" & folderParts(3) & ":" & folderParts(4) & ":" & folderParts(5) & ":" & folderParts(6) & ":" & folderParts(7) & ":" & folderParts(8) & ":" 


'Display the target folder and info.

 Response.Write("<ul><b>" & folder.Name & "</b>") '- " _
 '  & folder.Files.Count & " files, ")
 'if folder.SubFolders.Count > 0 then
 '  Response.Write(folder.SubFolders.Count & " directories, ")
 'end if
 'Response.Write(Round(folder.Size / 1024) & " KB total." _
 '  & "</ul>" & vbCrLf)

 Response.Write("<ul>" & vbCrLf)

 'Display a list of sub folders and filter by company code.

	if folderDepth > 1 and lcase(folderParts(folderBranch)) = lcase(site_temps_code) then 
		for each item in folder.SubFolders
			if instr(lcase(item.Name), "dfsrprivate") = 0 then 
				call ListFolderContents(item)
			end if
		next
	elseif folderDepth < 2 then
		for each item in folder.SubFolders
			if instr(lcase(item.Name), "dfsrprivate") = 0 then 
				call ListFolderContents(item)
			end if
		next
	end if

'Display a list of files if they match company code criteria.
 for each item in folder.Files
	'print folderPart(folderSite) & ":" & folderPart(folderCustCode)
   'url = MapURL(item.path)
   'Response.Write("<li><a href=" & url & ">" & item.Name & "</a> - " _
  if instr(lcase(item.Name), lcase(customer)) > 0 then
		httpsPath = item.path
		if filterFileExtensions(httpsPath) and (instr(lcase(httpsPath), lcase(customer)) > 0) then
			httpsPath = replace(httpsPath," ","%20")
			httpsPath = "https://www.personnelinc.com/net_docs/" & replace(httpsPath, "\\personnelplus.net.\net_docs\", "")
			httpsPath = replace(httpsPath, "\", "/")
			'print httpsPath
			Response.Write("<li><a href=""" & httpsPath & """>" & item.Name & "</a>" & "</li>" & vbCrLf)
		end if
	end if
 next

 Response.Write("</ul>" & vbCrLf)
 Response.Write("</ul>" & vbCrLf)

 folderDepth = folderDepth - 1
	response.flush
 end sub

function MapURL(path)

 dim rootPath, url

 'Convert a physical file path to a URL for hypertext links.

 rootPath = Server.MapPath("/")
 url = Right(path, Len(path) - Len(rootPath))
 MapURL = Replace(url, "\", "/")

end function

function filterFileExtensions(filetofilter)
	'check if extension is present in file
	if instr(filetofilter, ".pdf") = 0 and instr(filetofilter, ".txt") = 0 and instr(filetofilter, ".doc") = 0 and instr(filetofilter, "jpg") = 0 then
		filterFileExtensions = false
	else
		filterFileExtensions = true
	end if

end function


noSocial = true
%>
</div></div>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->