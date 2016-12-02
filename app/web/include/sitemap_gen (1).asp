<%
' sitemap_gen.asp
' A simple script to automatically produce sitemaps for a webserver, in the Google Sitemap Protocol (GSP)
' by Francesco Passantino
' www.iteam5.net/francesco/sitemap_gen
' v0.1  04.06.05
' v0.2  05.06.05 Listing a directory tree recursively improvement
' v0.3b 09.06.05 File exclusion by Calvin Dunkley
' v0.4  17.06.05 iso8601dates http://www.tumanov.com/projects/scriptlets/iso8601dates.asp
' v0.4b 18.06.05 vdrir bug fixed
' v0.4c 13.07.05 phisical dir patch for some windows systems
'
' BSD 2.0 license,
' http://www.opensource.org/licenses/bsd-license.php


'modify this to change website, virtual directory and phisical directory
session("server")="http://www.personnelplus-inc.com/"
vDir = "/"
phisicalDir = Request.ServerVariables("APPL_PHYSICAL_PATH")

'see http://www.time.gov/ for utcOffset
utcOffset=1


set objfso = CreateObject("Scripting.FileSystemObject")
root = Server.MapPath(vDir)

response.ContentType = "text/xml"
response.write "<?xml version='1.0' encoding='UTF-8'?>"
response.write "<!-- generator='http://www.iteam5.net/francesco/sitemap_gen'-->"
response.write "<urlset xmlns='http://www.google.com/schemas/sitemap/0.84'>"

Set objFolder = objFSO.GetFolder(root)
'response.write getfilelink(objFolder.Path,objFolder.dateLastModified)
Set colFiles = objFolder.Files
For Each objFile In colFiles
	response.write getfilelink(objFile.Path,objfile.dateLastModified)
Next
ShowSubFolders(objFolder)

response.write "</urlset>"
set fso = nothing


Sub ShowSubFolders(objFolder)
	Set colFolders = objFolder.SubFolders
	For Each objSubFolder In colFolders
		if folderpermission(objSubFolder.Path) then
			response.write getfilelink(objSubFolder.Path,objSubFolder.dateLastModified)
			Set colFiles = objSubFolder.Files
			For Each objFile In colFiles
				response.write getfilelink(objFile.Path,objFile.dateLastModified)
			Next
			ShowSubFolders(objSubFolder)
		end if
	Next
End Sub


Function getfilelink(file,data)
	file=replace(file,phisicalDir,"")
	file=replace(file,"\","/")
	If FileExtensionIsBad(file) then Exit Function
	If FileNameIsBad(file) then Exit Function
	filelmdate=iso8601date(data,utcOffset)

	getfilelink = "<url><loc>"&server.htmlencode(session("server")&file)&"</loc><lastmod>"&filelmdate&"</lastmod><priority>1.0</priority></url>"
	session("URLS")=session("URLS")+1
	Response.Flush
End Function


Function Folderpermission(pathName)
	'modify this to exclude path
	PathExclusion=Array("\temp","\_vti_cnf","\_vti_pvt","\_vti_log","\cgi-bin","\eol","\personnel.com\stats","\pdfServer")
	Folderpermission =True
	for each PathExcluded in PathExclusion
		if instr(ucase(pathName),ucase(PathExcluded))>0 then
			Folderpermission = False
			exit for
		end if
	next
End Function


Function FileExtensionIsBad(sFileName)
	Dim sFileExtension, bFileExtensionIsValid, sFileExt
	'http://www.googleguide.com/file_type.html
	Extensions = Array("png","gif","jpg","zip","pdf","ps","html","htm","asp","wk1","wk2","wk3","wk4","wk5","wki","wks","wku","lwp","mw","xls","ppt","doc","wks","wps","wdb","wri","rtf","ans","txt")

	if len(trim(sFileName)) = 0 then
		FileExtensionIsBad = true
		Exit Function
	end if

	sFileExtension = right(sFileName, len(sFileName) - instrrev(sFileName, "."))
	bFileExtensionIsValid = false	'assume extension is bad
	for each sFileExt in extensions
		if ucase(sFileExt) = ucase(sFileExtension) then
			bFileExtensionIsValid = True
			exit for
		end if
	next
	FileExtensionIsBad = not bFileExtensionIsValid
End Function

Function FileNameIsBad(sFileName)
        if len(trim(sFileName)) = 0 then
                FileNameIsBad = true
                Exit Function
        end if
        Filename = Array("/alive.asp","/404.asp","/500.asp","/sitemap_gen.asp")
        FileNameNumber = ubound(Filename)
        for i=0 to FileNameNumber
                if Filename(i) = sFileName then
                        FileNameIsBad = True
                end if
        next
End Function

Function iso8601date(dLocal,utcOffset)
	Dim d
	' convert local time into UTC
	d = DateAdd("H",-1 * utcOffset,dLocal)

	' compose the date
	iso8601date = Year(d) & "-" & Right("0" & Month(d),2) & "-" & Right("0" & Day(d),2) & "T" & _
		Right("0" & Hour(d),2) & ":" & Right("0" & Minute(d),2) & ":" & Right("0" & Second(d),2) & "Z"
End Function
%>