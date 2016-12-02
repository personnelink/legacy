<%
'        $Log: owpluginfunnel.asp,v $
'        Revision 1.10  2005/02/24 23:13:36  sansei
'        NEW PLUGIN: UseIncludes - To include userdefined data and expose it for the XSL.
'
'        Revision 1.9  2005/01/18 19:14:46  sansei
'        Moved plugspecific code from MAIN code to owpluginfunnel.asp
'        -- Thats the task for the funnel! (= expose MAINCODE to the plugins!)
'
'        Revision 1.8  2005/01/18 15:28:38  sansei
'        Added new PLUGIN macro: ShowFile
'        Allows dump of a file from the server.
'        Default setting allow to dump all files in 'owbase' BUT not 'owconfig_default.asp'
'        See settings in 'owpluginfunnel.asp'.
'
'        Revision 1.7  2004/09/26 18:16:19  sansei
'        Added plugin: InlineXml security
'
'        Revision 1.6  2004/09/26 14:58:06  sansei
'        Made installed plugins appear in gMacro even if NOT active. (For MacroHelp if installed to show that a plugin is installed and NOT active.)
'
'        Revision 1.5  2004/09/26 13:48:17  sansei
'        Minor 'standard' fix - Plug user-configuration left in the funnel!
'
'        Revision 1.4  2004/09/26 10:51:36  sansei
'        Added plugin: InlineXml (macro)
'
'        Revision 1.3  2004/09/24 17:07:09  sansei
'        Added dump of OW Variables functionality to Plugin: PageTool
'
'        Revision 1.2  2004/09/05 23:23:04  sansei
'        fixed 'work only if plug active' bug
'
'        Revision 1.1  2004/09/05 14:21:22  sansei
'        First version! --/sEi'2004
'
'----- Plugin Funnel is EXPERIMENTAL
' // PLUGIN SETTINGS HERE

' // InlineXml //
' SECURITY NOTE: If you set this constant (INLINEXML_ALLOWBEHINDROOT) to true you allow the user 
'                to fetch files outside the folder that OW is installed in! - This exposes a 
'                security risk if OW is installed on a local network or on a webserver!
CONST INLINEXML_ALLOWBEHINDROOT = false '(false = default)
'				 true = allow to fetch XML outside 'owbase'
'				 false = (default) only show XML files from inside 'owbase'
' // ShowFile //
' SECURITY NOTE: If you set this constant (SHOWFILE_ALLOWBEHINDROOT) to true you allow the user 
'                to fetch files outside the folder that OW is installed in (all over the server!) - This exposes a 
'                MAJOR security risk if OW is installed on a local network or on a webserver!
CONST SHOWFILE_ALLOWBEHINDROOT = false '(false = default)
'				 true = allow to fetch files outside 'owbase' (MAJOR SECURITY RISK - Allow to see all files on server)
'				 false = (default) only show files from inside 'owbase'
' SECURITY NOTE: If you set this constant (SHOWFILE_HIDECONFIG) to false you allow the user to see the
'				 owconfig_default.asp file.
CONST SHOWFILE_HIDECONFIG = true '(true = default)
'				 true = (default) Disallow dump of qwconfig.default.asp
'				 false = Allow dump (SECURITY RISK - eq. enable user to view passwords!)

' // PageTool //
CONST PAGETOOL_SHOW = 0	'0 = show minimized, 1 = show maximized

' // Your custom plugin settings here...//



' // MACROPATTERN SERVICE ALL PLUGINS //
Function PlugMacroPatterns()
	dim str
	
	' // PageTool code start 
		 str = str & "PageTool|"
	' // PageTool code end
		
	' // InlineXml code start 
		 str = str & "InlineXml|"
	' // InlineXml code end

	' // ShowFile code start 
		 str = str & "ShowFile|"
	' // ShowFile code end

	' // Your plugincode start
		 'str = str & "YourTag|OtherYourTag|"
	' // Your plugincode end



	' #### // finale service
	if right(str,1)="|" then
		str = mid(str,1,len(str)-1)
	end if
	
	PlugMacroPatterns = str
end function

Function PlugsToOwXml()
	dim strReturn
	strReturn = ""
	'-- PLUG: BADGE
	if cAllowBadge <> 0 then
		strReturn = strReturn & "<ow:badgeslist>" & FetchBadgeslistAsXml().xml & "</ow:badgeslist>"
	end if
	'-- PLUG: UseIncludes
	if plugins.Item("Use Includes") <> 0 then
		'strReturn = strReturn & "<ow:includes><myfooter><b>in bold</b></myfooter></ow:includes>"
		strReturn = strReturn & PlugUseIncludes()
	end if
	'--
	'// Your plugspecific code here...
	
	' #### // Finale
	PlugsToOwXml = strReturn
end function
%>