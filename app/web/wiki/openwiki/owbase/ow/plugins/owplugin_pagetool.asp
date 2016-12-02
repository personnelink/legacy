<%
' // $Log: owplugin_pagetool.asp,v $
' // Revision 1.7  2007/01/29 18:41:00  sansei
' // fixed a bug that made the pagetool not working
' //
' // Revision 1.6  2004/09/27 13:48:12  sansei
' // Updated so only 1 pagetool (flash) is displayed per page (else scripts get tired!)
' //
' // Revision 1.5  2004/09/27 13:19:59  sansei
' // added use of parameters.
' // Current parameters:
' // * owvariables - Dump a list of 'safe' variables as html
' //
' // Revision 1.4  2004/09/24 17:07:09  sansei
' // Added dump of OW Variables functionality to Plugin: PageTool
' //
' // Revision 1.3  2004/09/07 09:30:10  sansei
' // added HTML Scripting for the PageTool (using pagetool.js)
' //
' // Revision 1.2  2004/09/05 23:23:30  sansei
' // Updated PLUG: Page Tool
' //
' // Revision 1.1  2004/09/05 14:19:51  sansei
' // First version! --/sEi
' //     Functionality soon to be implemented!
' //     Added now to show functionality of the plugin funnel!
' //
%><!-- #include file="owplugin_pagetool\pagetool_inc.asp" //--><%
' **** ACTIVATION CODE ***
plugins.Add "Page Tool",0
' ************************
' ==================================================================================
'	// PageTool Macro Code by sEi'2004
'
Dim bIsEmpty
Dim FlashToolPresent 'Show only one instance of the flashtool!
FlashToolPresent = false

Sub MacroPageTool
	if plugins.Item("Page Tool") <> 0 then
		Call MacroPageToolP("default")
	end if
End Sub

Sub MacroPageToolP(pParam)
	Dim tabs,astate,fstate,sstate
	if (Trim(pParam)="") then '	// Trap empty parameter//
		bIsEmpty = true
		pParam = "default"
	end if
	if plugins.Item("Page Tool") <> 0 then
		tabs = "  "
		select case ucase(pParam)
			case "OWVARIABLES"
				gMacroReturn = pagetool_fetchVarlist("ow/plugins/owplugin_pagetool/xml/variables.xml") '"<ow:error>NO Error!</ow:error>"
			case "DEFAULT"
				if PAGETOOL_SHOW = 1 then
					sstate = "none"
					astate = "FLASH"
					fstate = "block"
				else
					sstate = "block"
					astate = "BUTTON"
					fstate = "none"
				end if
				if cAllowFlash then
					if FlashToolPresent = true then
						gMacroReturn="<ow:error>Sorry, Only one &lt;pagetool&gt; per page</ow:error>"
					else
						FlashToolPresent=true
						gMacroReturn="<script language=""JavaScript"">" & vbcrlf 
						gMacroReturn=gMacroReturn & "var ACTIVE = """ & astate & """" & vbcrlf
						gMacroReturn=gMacroReturn & "</script>" & vbcrlf
						gMacroReturn=gMacroReturn & "<script src=""ow/plugins/owplugin_pagetool/PageTool.js"" language=""JavaScript"">" & vbcrlf
						gMacroReturn=gMacroReturn & "</script>" & vbcrlf
						gMacroReturn=gMacroReturn & "<span id=""pagetool"">" & vbcrlf
						gMacroReturn=gMacroReturn & tabs & "<button id=""but_flash"" onclick=""oPagetool_DoFSCommand('PageTool', 'ShowHide');"" style=""display:" & fstate & """ title=""Click to display PageTool"">Hide PageTool</button>" & vbcrlf
						gMacroReturn=gMacroReturn & tabs & "<button id=""but_button"" onclick=""oPagetool_DoFSCommand('PageTool', 'ShowHide');"" style=""display:" & sstate & """ title=""Click to display PageTool"">Display PageTool</button>" & vbcrlf
						gMacroReturn=gMacroReturn & tabs & "<object id=""oPagetool"" style=""display:" & fstate & """ classid=""clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"" codebase=""http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0"" width=""550"" height=""400"" align=""middle"" >" & vbcrlf
						gMacroReturn=gMacroReturn & tabs & tabs & "<param name=""allowScriptAccess"" value=""sameDomain"" />" & vbcrlf
						gMacroReturn=gMacroReturn & tabs & tabs & "<param name=""movie"" value=""ow/plugins/owplugin_pagetool/flash/pagetool.swf?parameters=" & pParam & """ />" & vbcrlf
						gMacroReturn=gMacroReturn & tabs & tabs & "<param name=""quality"" value=""high"" />" & vbcrlf
						gMacroReturn=gMacroReturn & tabs & tabs & "<param name=""bgcolor"" value=""#ffffff"" />" & vbcrlf
						gMacroReturn=gMacroReturn & tabs & "<embed src=""ow/plugins/owplugin_pagetool/flash/pagetool.swf?parameters=" & pParam & """ quality=""high"" bgcolor=""#ffffff"" width=""550"" height=""400"" name=""oPagetool"" align=""middle"" allowScriptAccess=""sameDomain"" type=""application/x-shockwave-flash"" pluginspage=""http://www.macromedia.com/go/getflashplayer"" />" & vbcrlf
						gMacroReturn=gMacroReturn & tabs & "</object>" & vbcrlf
						gMacroReturn=gMacroReturn & "</span>" & vbcrlf
						if (bIsEmpty) then
							gMacroReturn=replace(MacroPageToolHelp,"[MACROPageToolHELP_TOKEN]",gMacroReturn) & vbcrlf
							gMacroReturn=replace(gMacroReturn,"[MACROPageToolHELP_TOKEN2]","label=Help|linkpage=Help") & vbcrlf
						end if 
					end if
				else
					gMacroReturn="<ow:error>Sorry, The macro: ""PageTool"" require the use of Flash Movies, and Flash has been disabled in this Wiki.</ow:error>"
				end if
			case else
				gMacroReturn="<ow:error>Sorry, The parameter: [" & pParam & "] is unknown in plugin macro: PageTool</ow:error>"
		end select
	end if
End Sub


function pagetool_fetchVarlist(path)
	'ASP
	dim oXML,url,node,varvalue,str
	dim temp
	set oXML = server.CreateObject("Msxml2.DOMDocument")
	oXML.async = False
	url = server.MapPath(path)
	oXML.load(url)
	str = "<code>" & vbcrlf
	temp = 0
	for each node in oXML.documentElement.childNodes
		on error resume next
		varvalue = eval(node.tagname)
		varvalue = server.HTMLEncode(varvalue)
		str = str & "<b>" & node.tagname & "</b> = " & varvalue & "<br/>" & vbcrlf
	next
	str = str & "</code>"
	pagetool_fetchVarlist = str
	set oXML = nothing
end function
%>