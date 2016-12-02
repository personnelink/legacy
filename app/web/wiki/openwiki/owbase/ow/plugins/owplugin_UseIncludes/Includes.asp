<%
' // $Log: Includes.asp,v $
' // Revision 1.1  2005/02/24 23:13:36  sansei
' // NEW PLUGIN: UseIncludes - To include userdefined data and expose it for the XSL.
' //
' //
' // First version! --/sEi'2005
' //
' ### This file appends every include to the ow dom
' ###
' ### The data can then be used by the skin template
' ###
' ### EXAMPLE:
' ### Syntax for the skin template to display the data from the myfooter:
' ### <xsl:copy-of select="ow:includes/myfooter/*"/>
%>
<!-- #include file="Includes/myfooter.asp" //-->
<%
private function PlugIncludes()
	dim strReturn
	'-- append:  myfooter
	strReturn = strReturn & "<myfooter>" '<-- name of tag used for referencing in the skin template!
	strReturn = strReturn & Includes_myfooter() 'returns XHTML compliant text
	strReturn = strReturn & "</myfooter>" '<-- same name here!
	'-- append more here...

	
	
	'--
	PlugIncludes = strReturn
end function
%>