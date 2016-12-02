<%
' // $Log: owplugin_InlineXml.asp,v $
' // Revision 1.5  2005/02/24 19:29:43  sansei
' // Added optional second parameter to use for userdefined XSL stylesheet
' //
' // Revision 1.4  2005/01/18 13:53:04  sansei
' // moved function OWGetFile(filepath) from The InlineXml plug to macroes.asp - because its a public function
' //
' // Revision 1.3  2004/09/26 18:16:19  sansei
' // Added plugin: InlineXml security
' //
' // Revision 1.2  2004/09/26 13:48:17  sansei
' // Minor 'standard' fix - Plug user-configuration left in the funnel!
' //
' // Revision 1.1  2004/09/26 10:51:36  sansei
' // Added plugin: InlineXml (macro)
' //
' // First version! --/sEi
' //
' **** ACTIVATION CODE ***
plugins.Add "Inline Xml",0
' ************************
' ==================================================================================
'	// InlineXml Macro Code by sEi'2004
'
' 
DIM INLINEXML_INUSE		'Ensure that only one instance of code is inserted.
INLINEXML_INUSE = false	'DO NOT change this value!

Sub MacroInlineXml
	if plugins.Item("Inline Xml") <> 0 then
		Call MacroInlineXmlP("")
	end if
End Sub

Sub MacroInlineXmlP(pParam)
	Call MacroInlineXmlPP(pParam,"")
End Sub


Sub MacroInlineXmlPP(pParam,sParam)
	Dim tabs
	dim oXml
	dim webrootmap
	dim weburlmap
	dim isInside
	dim temp
	
	webrootmap = server.MapPath(".")
	weburlmap = Request.ServerVariables("URL")
	weburlmap = replace(weburlmap,"/ow.asp","")
	weburlmap = replace(weburlmap,"/default.asp","")
	'Response.Write(weburlmap & "<br/>")
	
	Set oXML = server.CreateObject("Msxml2.DOMDocument")
	oXML.async = False
	
	if plugins.Item("Inline Xml") <> 0 then
		tabs = "  "
		if (Trim(pParam)="") then '	// Trap empty parameter//
			bIsEmpty = true
			pParam = "default"
		end if
		if len(sParam)<1 then 'only use this code when using default xsl
			if INLINEXML_INUSE = false then
				gMacroReturn = gMacroReturn & InlineXml_basecode()
				INLINEXML_INUSE = true
			end if
		end if
		Select case ucase(pParam)' Check what parameter the user have used
			case "HELP"
				oXML.load(server.MapPath("ow/plugins/owplugin_InlineXml/help.xml"))
				gMacroReturn=gMacroReturn & InlineXml_TransformData(oXml.xml)
			case "ABOUT"
				oXML.load(server.MapPath("ow/plugins/owplugin_InlineXml/about.xml"))
				gMacroReturn=gMacroReturn & InlineXml_TransformData(oXml.xml)
			case else 'Is NOT a hardcoded parameter
				if instr(server.MapPath(pParam),webrootmap)>0 then
					isInside = true
				else
					isInside = false
				end if
				
				if len(sParam)>0 then 'check second parameter if any
					if instr(server.MapPath(sParam),webrootmap)<1 then
						isInside = false
					end if
				end if
				
				if (isInside=false)and(INLINEXML_ALLOWBEHINDROOT=false) then
					gMacroReturn=gMacroReturn & "<ow:error>Display of files below the wiki's directory is not allowed</ow:error>" & vbcrlf
					gMacroReturn=gMacroReturn & "<ow:error>You can change this setting in file: <i>\ow\plugins\owpluginfunnel.asp</i></ow:error>" & vbcrlf
				else
					oXML.load(server.MapPath(pParam))
					if len(oXML.xml)<1 then 'loaded file empty!
						gMacroReturn=gMacroReturn & "<ow:error>ERROR - File empty, not exist or not valid xhtml format!</ow:error>" & vbcrlf
						temp = server.MapPath(pParam)
						temp = replace(temp,webrootmap,weburlmap)
						temp = replace(temp,"\","/")
						gMacroReturn=gMacroReturn & "<ow:error>Fileurl: " & temp & "</ow:error>" & vbcrlf
					else 'Loaded file contains valid xhtml
						gMacroReturn=gMacroReturn & InlineXml_TransformData(oXml.xml,sParam)
					end if
				end if
		end select
		if (bIsEmpty) then 'Dont know how to invoke this - but i leave code here anyway!
			gMacroReturn="<ow:error>(bIsEmpty) Macro: Inline Xml is under development - Check back later</ow:error>" & vbcrlf
		end if
	end if
	Set oXML = nothing
end sub

function InlineXml_basecode()
	dim str
	str= "<STYLE type=""text/css"">" & vbcrlf
	str= str& "  BODY {font:x-small 'Verdana'; margin-right:1.5em}" & vbcrlf
	str= str& "  .c  {cursor:hand}" & vbcrlf
	str= str& "  .b  {color:red; font-family:'Courier New'; font-weight:bold; text-decoration:none}" & vbcrlf
	str= str& "  .e  {margin-left:1em; text-indent:-1em; margin-right:1em}" & vbcrlf
	str= str& "  .k  {margin-left:1em; text-indent:-1em; margin-right:1em}" & vbcrlf
	str= str& "  .t  {color:#990000}" & vbcrlf
	str= str& "  .xt {color:#990099}" & vbcrlf
	str= str& "  .ns {color:red}" & vbcrlf
	str= str& "  .m  {color:blue}" & vbcrlf
	str= str& "  .tx {font-weight:bold}" & vbcrlf
	str= str& "  .db {text-indent:0px; margin-left:1em; margin-top:0px; margin-bottom:0px;" & vbcrlf
	str= str& "       padding-left:.3em; border-left:1px solid #CCCCCC; font:small Courier}" & vbcrlf
	str= str& "  .di {font:small Courier}" & vbcrlf
	str= str& "  .d  {color:blue}" & vbcrlf
	str= str& "  .pi {color:blue}" & vbcrlf
	str= str& "  .cb {text-indent:0px; margin-left:1em; margin-top:0px; margin-bottom:0px;" & vbcrlf
	str= str& "       padding-left:.3em; font:small Courier; color:#888888}" & vbcrlf
	str= str& "  .ci {font:small Courier; color:#888888}" & vbcrlf
	str= str& "  PRE {margin:0px; display:inline}" & vbcrlf
	str= str& "</STYLE>" & vbcrlf
	str= str& "		<SCRIPT type=""text/javascript"">" & vbcrlf
	str= str& "			<!--" & vbcrlf
	str= str& "  // Detect and switch the display of CDATA and comments from an inline view" & vbcrlf
	str= str& "  //  to a block view if the comment or CDATA is multi-line." & vbcrlf
	str= str& "  function f(e)" & vbcrlf
	str= str& "  {" & vbcrlf
	str= str& "    // if this element is an inline comment, and contains more than a single" & vbcrlf
	str= str& "    //  line, turn it into a block comment." & vbcrlf
	str= str& "    if (e.className == ""ci"") {" & vbcrlf
	str= str& "      if (e.children(0).innerText.indexOf(""\n"") > 0)" & vbcrlf
	str= str& "        fix(e, ""cb"");" & vbcrlf
	str= str& "    }" & vbcrlf
	str= str& "    // if this element is an inline cdata, and contains more than a single" & vbcrlf
	str= str& "    //  line, turn it into a block cdata." & vbcrlf
	str= str& "    if (e.className == ""di"") {" & vbcrlf
	str= str& "      if (e.children(0).innerText.indexOf(""\n"") > 0)" & vbcrlf
	str= str& "        fix(e, ""db"");" & vbcrlf
	str= str& "    }" & vbcrlf
	str= str& "    // remove the id since we only used it for cleanup" & vbcrlf
	str= str& "    e.id = """";" & vbcrlf
	str= str& "  }" & vbcrlf
	str= str& "  // Fix up the element as a ""block"" display and enable expand/collapse on it" & vbcrlf
	str= str& "  function fix(e, cl)" & vbcrlf
	str= str& "  {" & vbcrlf
	str= str& "    // change the class name and display value" & vbcrlf
	str= str& "    e.className = cl;" & vbcrlf
	str= str& "    e.style.display = ""block"";" & vbcrlf
	str= str& "    // mark the comment or cdata display as a expandable container" & vbcrlf
	str= str& "    j = e.parentElement.children(0);" & vbcrlf
	str= str& "    j.className = ""c"";" & vbcrlf
	str= str& "    // find the +/- symbol and make it visible - the dummy link enables tabbing" & vbcrlf
	str= str& "    k = j.children(0);" & vbcrlf
	str= str& "    k.style.visibility = ""visible"";" & vbcrlf
	str= str& "    k.href = ""#"";" & vbcrlf
	str= str& "  }" & vbcrlf
	str= str& "  // Change the +/- symbol and hide the children.  This function works on ""element""" & vbcrlf
	str= str& "  //  displays" & vbcrlf
	str= str& "  function ch(e)" & vbcrlf
	str= str& "  {" & vbcrlf
	str= str& "    // find the +/- symbol" & vbcrlf
	str= str& "    mark = e.children(0).children(0);" & vbcrlf
	str= str& "    // if it is already collapsed, expand it by showing the children" & vbcrlf
	str= str& "    if (mark.innerText == ""+"")" & vbcrlf
	str= str& "    {" & vbcrlf
	str= str& "      mark.innerText = ""-"";" & vbcrlf
	str= str& "      for (var i = 1; i < e.children.length; i++)" & vbcrlf
	str= str& "        e.children(i).style.display = ""block"";" & vbcrlf
	str= str& "    }" & vbcrlf
	str= str& "    // if it is expanded, collapse it by hiding the children" & vbcrlf
	str= str& "    else if (mark.innerText == ""-"")" & vbcrlf
	str= str& "    {" & vbcrlf
	str= str& "      mark.innerText = ""+"";" & vbcrlf
	str= str& "      for (var i = 1; i < e.children.length; i++)" & vbcrlf
	str= str& "        e.children(i).style.display=""none"";" & vbcrlf
	str= str& "    }" & vbcrlf
	str= str& "  }" & vbcrlf
	str= str& "  // Change the +/- symbol and hide the children.  This function work on ""comment""" & vbcrlf
	str= str& "  //  and ""cdata"" displays" & vbcrlf
	str= str& "  function ch2(e)" & vbcrlf
	str= str& "  {" & vbcrlf
	str= str& "    // find the +/- symbol, and the ""PRE"" element that contains the content" & vbcrlf
	str= str& "    mark = e.children(0).children(0);" & vbcrlf
	str= str& "    contents = e.children(1);" & vbcrlf
	str= str& "    // if it is already collapsed, expand it by showing the children" & vbcrlf
	str= str& "    if (mark.innerText == ""+"")" & vbcrlf
	str= str& "    {" & vbcrlf
	str= str& "      mark.innerText = ""-"";" & vbcrlf
	str= str& "      // restore the correct ""block""/""inline"" display type to the PRE" & vbcrlf
	str= str& "      if (contents.className == ""db"" || contents.className == ""cb"")" & vbcrlf
	str= str& "        contents.style.display = ""block"";" & vbcrlf
	str= str& "      else contents.style.display = ""inline"";" & vbcrlf
	str= str& "    }" & vbcrlf
	str= str& "    // if it is expanded, collapse it by hiding the children" & vbcrlf
	str= str& "    else if (mark.innerText == ""-"")" & vbcrlf
	str= str& "    {" & vbcrlf
	str= str& "      mark.innerText = ""+"";" & vbcrlf
	str= str& "      contents.style.display = ""none"";" & vbcrlf
	str= str& "    }" & vbcrlf
	str= str& "  }" & vbcrlf
	str= str& "  // Handle a mouse click" & vbcrlf
	str= str& "  function cl()" & vbcrlf
	str= str& "  {" & vbcrlf
	str= str& "    e = window.event.srcElement;" & vbcrlf
	str= str& "    // make sure we are handling clicks upon expandable container elements" & vbcrlf
	str= str& "    if (e.className != ""c"")" & vbcrlf
	str= str& "    {" & vbcrlf
	str= str& "      e = e.parentElement;" & vbcrlf
	str= str& "      if (e.className != ""c"")" & vbcrlf
	str= str& "      {" & vbcrlf
	str= str& "        return;" & vbcrlf
	str= str& "      }" & vbcrlf
	str= str& "    }" & vbcrlf
	str= str& "    e = e.parentElement;" & vbcrlf
	str= str& "    // call the correct funtion to change the collapse/expand state and display" & vbcrlf
	str= str& "    if (e.className == ""e"")" & vbcrlf
	str= str& "      ch(e);" & vbcrlf
	str= str& "    if (e.className == ""k"")" & vbcrlf
	str= str& "      ch2(e);" & vbcrlf
	str= str& "  }" & vbcrlf
	str= str& "  // Erase bogus link info from the status window" & vbcrlf
	str= str& "  function h()" & vbcrlf
	str= str& "  {" & vbcrlf
	str= str& "    window.status="" "";" & vbcrlf
	str= str& "  }" & vbcrlf
	str= str& "  // Set the onclick handler" & vbcrlf
	str= str& "  document.onclick = cl;" & vbcrlf
	str= str& "//-->" & vbcrlf
	str= str& "		</SCRIPT>" & vbcrlf
	InlineXml_basecode = str
end function

function InlineXml_TransformData(xml,xslpath)
	dim xsl
	if len(xslpath)<1 then
		xsl = "ow/plugins/owplugin_InlineXml/TransformData.xsl"
	else
		xsl = xslpath
	end if
	dim oXML
	dim oXSL
	dim oXslTemplate
	dim proc

	Set oXML		= server.CreateObject("Msxml2.DOMDocument")
	set oXslTemplate = server.CreateObject("MSXML2.XSLTemplate")


	Set oXSL		= server.CreateObject("MSXML2.FreeThreadedDOMDocument")
	oXSL.async		= False

	oXML.loadXML (xml)
 
	oXSL.load (server.MapPath(xsl))

	set oXslTemplate.stylesheet = oXSL 'xsl
	set proc = oXslTemplate.createProcessor()

	proc.input = oXML
	
	'Add a parameter (pt. not needed)
	''proc.addParameter "name","value"

	'Do the transform
	proc.transform

	InlineXml_TransformData = proc.output
	Set oXML = nothing
	Set oXSL = nothing
	set oXslTemplate = nothing
end function
%>