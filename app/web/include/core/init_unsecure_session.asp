<% 
dim global_debug
select case request.querystring("debugging")
case "1"
	global_debug = true
case else
	global_debug = false
end select

if global_debug then
	dim  objFS, debug_log
	set objFS=Server.CreateObject("Scripting.FileSystemObject")
	const FilePath = "c:\vmsDebug\vms_debug.txt"
	if objFS.FileExists(FilePath) then
		set debug_log=objFS.OpenTextFile(FilePath, 8) '8 = Appending
	else
		set debug_log=objFS.CreateTextFile("c:\vmsDebug\vms_debug.txt",true)
	end if
		
	debug_log.WriteLine("--- Start Logging ---")
end if
%>
<!-- #INCLUDE VIRTUAL='include/core/html_header.asp' -->
<!-- #INCLUDE VIRTUAL='include/core/html_styles.asp' -->
<!-- #INCLUDE VIRTUAL='include/core/navi_top_menu.asp' -->

<%
if session("no_header") <> true then 
	response.write header_response & ie_ifs
	if session("no-flush") <> true then response.Flush()
else
	session("no_header") = false
end if 

%>