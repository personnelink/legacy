<%
' // $Log: owplugin_ShowFile.asp,v $
' // Revision 1.5  2005/01/20 17:48:36  sansei
' // ups had wrong setting - corrected!
' //
' // Revision 1.4  2005/01/20 17:43:01  sansei
' // minor update - added linenumbers to ShowFile dumps.
' //
' // Revision 1.3  2005/01/18 20:00:44  sansei
' // show userinput - instead of filepath! (security issue)
' //
' // Revision 1.2  2005/01/18 18:43:17  sansei
' // added so PLUGIN macro: ShowFile is present in the editor (Macros/other...) IF the ShowFile plugin is ON.
' //
' // Revision 1.1  2005/01/18 15:28:38  sansei
' // Added new PLUGIN macro: ShowFile
' // Allows dump of a file from the server.
' // Default setting allow to dump all files in 'owbase' BUT not 'owconfig_default.asp'
' // See settings in 'owpluginfunnel.asp'.
' //
' //
' // First version! --/sEi
' //
' **** ACTIVATION CODE ***
plugins.Add "Show File",0
' ************************
' ==================================================================================
'	// ShowFile Macro Code by sEi'2005
'
' 

Sub MacroShowFile
	if plugins.Item("Show File") <> 0 then
		Call MacroShowFileP("")
	end if
End Sub

Sub MacroShowFileP(pParam)
	dim webrootmap
	dim weburlmap
	dim isInside
	dim temp
	dim TheFile

	if plugins.Item("Show File") <> 0 then 'plugin active?
		webrootmap = server.MapPath(".")
		weburlmap = Request.ServerVariables("URL")
		weburlmap = replace(weburlmap,"/ow.asp","")
		weburlmap = replace(weburlmap,"/default.asp","")
		
		if plugins.Item("Show File") <> 0 then
			if (Trim(pParam)="") then '	// Trap empty parameter//
				bIsEmpty = true
				pParam = "default"
			end if

			Select case ucase(pParam)' Check what parameter the user have used if any
				case "HELP"
					'show some help here
					gMacroReturn="<ow:error>ShowFile macro has pt. no build in help</ow:error>"
				case else 'Is NOT a hardcoded parameter
					if instr(server.MapPath(pParam),webrootmap)>0 then
						isInside = true
					else
						isInside = false
					end if
					if (isInside=false)and(SHOWFILE_ALLOWBEHINDROOT=false) then
						gMacroReturn=gMacroReturn & "<ow:error>Display of files below the wiki's directory is not allowed</ow:error>" & vbcrlf
						gMacroReturn=gMacroReturn & "<ow:error>You can change this setting in file: <i>\ow\plugins\owpluginfunnel.asp</i></ow:error>" & vbcrlf
					else
						if SHOWFILE_HIDECONFIG and (ucase(right(pParam,20))=ucase("owconfig_default.asp")) then
							gMacroReturn=gMacroReturn & "<ow:error>Display of the file: owconfig_default.asp is not allowed</ow:error>" & vbcrlf
						else
							TheFile = OWGetFile(server.MapPath(pParam),1)
							if len(TheFile)<1 then 'loaded file empty!
								gMacroReturn=gMacroReturn & "<ow:error>ERROR - File empty or not exist</ow:error>" & vbcrlf
								temp = server.MapPath(pParam)
								temp = replace(temp,webrootmap,weburlmap)
								temp = replace(temp,"\","/")
								gMacroReturn=gMacroReturn & "<ow:error>Fileurl: " & temp & "</ow:error>" & vbcrlf
							else 'Loaded file contains something
								'now show it
								gMacroReturn="<table border=""1""><tr><td>"
								gMacroReturn=gMacroReturn & "FILE: " & pParam
								gMacroReturn=gMacroReturn & "</td></tr><tr><td>"
								gMacroReturn=gMacroReturn & "<pre>" & server.HTMLEncode(TheFile) & "</pre>"
								gMacroReturn=gMacroReturn & "</td></tr></table>"
							end if
						end if
					end if
			end select
			if (bIsEmpty) then 'Dont know how to invoke this - but i leave code here anyway!
				gMacroReturn="<ow:error>(bIsEmpty) Macro: ShowFile is under development - Check back later</ow:error>" & vbcrlf
			end if
		end if
	end if
End Sub

%>