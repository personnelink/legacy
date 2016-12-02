<%
Dim plugins
Set plugins = Server.CreateObject("Scripting.Dictionary")
%>
<!-- #include file="plugins/owpluginfunnel.asp"               //-->
<!-- #include file="plugins/owplugin_forceusername.asp"       //-->
<!-- #include file="plugins/owplugin_captcha.asp"             //-->
<!-- #include file="plugins/owplugin_editrestrictions.asp"  //-->
<!-- #include file="plugins/owplugin_viewrestrictions.asp"  //-->
<!-- #include file="plugins/owplugin_pagehits.asp"            //-->
<!-- #include file="plugins/owplugin_WYSIWYG.asp"             //-->
<!-- #include file="plugins/owplugin_referers.asp"            //-->
<!-- #include file="plugins/owplugin_badlinklist.asp"         //-->
<!-- #include file="plugins/owplugin_macrohelp.asp"           //-->
<!-- #include file="plugins/owplugin_pagetool.asp"            //-->
<!-- #include file="plugins/owplugin_InlineXml.asp"           //-->
<!-- #include file="plugins/owplugin_ShowFile.asp"            //-->
<!-- #include file="plugins/owplugin_UseIncludes.asp"         //-->


<%
' *********************************
' ** Plugin Activation Overrides **
' *********************************
' * Plugins are turned on or off by default in their specific asp control page
' * These settings below will override default settings as a central place to control plugins
' *********************************
plugins.Item("Edit Restrictions") = 1 ' 1 = On  0 = Off
plugins.Item("View Restrictions") = 1 ' 1 = On  0 = Off
plugins.Item("CAPTCHA") = 0             ' 1 = Require CAPTHCA Auth    0 = No Auth
plugins.Item("WYSIWYG Editor") = 1      ' 1 = Use WYSIWYG Toolbar     0 = No Toolbar
plugins.Item("Check for User Name") = 1 ' 1 = Require Username Set    0 = No req.
plugins.Item("Site Referers") = 1       ' 1 = Turn on Site Referers   0 = Off
plugins.Item("Page Hits") = 1           ' 1 = Turn on Hit Monitoring  0 = Off
plugins.Item("Bad Link List") = 1
plugins.Item ("Macro Help") = 1         ' 1 = Turn on Macro Help      0 = Off
plugins.Item ("Page Tool") = 1          ' 1 = Enable PageTool tag     0 = Disable PageTool tag
plugins.Item ("Inline Xml") = 1         ' 1 = Enable InlineXml        0 = Disable InlineXml
plugins.Item ("Show File") = 0          ' 1 = Enable ShowFile (SECURITY RISK!) 0 = (default) Disable ShowFile
plugins.Item ("Use Includes") = 0       ' 1 =  Enable	0 = (default) Disable
%>