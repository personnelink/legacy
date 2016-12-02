<!-- #include file="owplugin_UseIncludes/Includes.asp" //-->
<%
' // $Log: owplugin_UseIncludes.asp,v $
' // Revision 1.1  2005/02/24 23:13:36  sansei
' // NEW PLUGIN: UseIncludes - To include userdefined data and expose it for the XSL.
' //
' //
' // First version! --/sEi'2005
' //
' **** ACTIVATION CODE ***
plugins.Add "Use Includes",0
' ************************
' ==================================================================================
' // Plugin Use Includes Code by sEi'2005
'
' 
Private function PlugUseIncludes()
	PlugUseIncludes = "<ow:includes>" & PlugIncludes() & "</ow:includes>"
end function
%>