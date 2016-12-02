<%@ Language=VBScript EnableSessionState=False %>
<!-- #include file="../ow/owpreamble.asp" //-->
<!-- #include file="../ow/owpatterns.asp" //-->
<!-- #include file="../ow/owconfig_default.asp" //-->
<!-- #include file="../ow/owvector.asp" //-->
<!-- #include file="../ow/owado.asp" //-->
<!-- #include file="../ow/owattach.asp" //-->
<!-- #include file="../ow/my/mymacros.asp" //-->
<!-- #include file="../ow/my/mywikify.asp" //-->
<%
' ***************************************************************************************************************
' $Log: imageupload.asp,v $
' Revision 1.3  2006/03/27 16:50:40  gbamber
' OPENWIKI_MAXIMUMUPLOADSIZE changed to OPENWIKI_MAXUPLOADSIZE
'
' Revision 1.2  2005/01/24 00:06:15  casper_gasper
' Fix for cross-platform file uploading.
'
' Revision 1.1  2004/08/17 00:08:48  carlthewebmaste
' New Image Library Upload.  Permits uploads to OPENWIKI_IMAGELIBRARY if cAllowImageLibrary = 1.
'
' Revision 1.3  2004/08/13 18:21:57  gbamber
' Added CVS Log directive
'
' ***************************************************************************************************************
'
' This page uploads images to the image library defined as OPENWIKI_IMAGELIBRARY
'
' Get various global variables
Call InitLinkPatterns
Dim vImageLibraryPath, vImageLibraryPathTranslated

vImageLibraryPath = "../" & OPENWIKI_IMAGELIBRARY
vImageLibraryPathTranslated = server.MapPath(vImageLibraryPath)

Response.Expires = -10000
Server.ScriptTimeOut = OPENWIKI_UPLOADTIMEOUT

Dim vUploadFilename, vUploadFilePath

Call DisplayTop()

if cAllowImageLibrary <> 1 then 

	Response.Write "<h3>Image Library Disabled!</h3>  Please use 'cAllowImageLibrary' setting in owconfig_default.asp to enable.<br>"
	Call DisplayBottom()
	Response.End
End If

Select Case OPENWIKI_UPLOADMETHOD
    
'    Case UPLOADMETHOD_ABCUPLOAD 'ABCUpload4 COM Control
'    
'		Dim theForm, theField
'		On Error Resume Next
'		Err.Number = 0
'		Set theForm = Server.CreateObject("ABCUpload4.XForm")
'		If Err.Number <> 0 Then
'			Response.Write("<b>Error</b>: Missing component ABCUpload4. You can download this component from <a href='http://www.websupergoo.com/downloadftp.htm'>websupergoo.com</a>")
'			Response.End
'		End If
'		On Error Goto 0
'		theForm.MaxUploadSize = OPENWIKI_MAXUPLOADSIZE
'		theForm.Overwrite = True
'		theForm.AbsolutePath = False
'		' TODO: maybe implement pop-up progress-bar
'		'theForm.ID = Request.QueryString("ID")
'
'		'On Error Resume Next
'		Set theField = theForm("file")(1)
'		If theField.FileExists Then
'			' If you want to store your files as BLOBs in the database, then you should
'			' comment the next line
'			CreateFolders()
'
'			vUploadFilename = theField.SafeFileName
'			vUploadFilename = gNamespace.SaveAttachmentMetaData(vUploadFilename, theField.Length, theForm("link"), theForm("hide"), theForm("comment"))
'
'			' Save to filesystem.
'			theField.Save OPENWIKI_UPLOADDIR & gPage & "/" & vUploadFilename
'		End If
'		
'		set theField = nothing
'    
'    Case UPLOADMETHOD_SAFILEUP 'SA FileUp COM COntrol
'
'		Dim oFileUp
'		
'		Set oFileUp = Server.CreateObject("SoftArtisans.FileUp")
'		oFileUp.MaxBytesToCancel = OPENWIKI_MAXUPLOADSIZE
'		oFileUp.OverWriteFiles = True
'		
'		If Err.Number <> 0 Then
'			Response.Write("<b>Error</b>: Missing component SoftArtisans.FileUp. You can download this component from <a href='http://fileup.softartisans.com/'>fileup.SoftArtisans.com</a>")
'			Response.End
'		End If
'	    
'	    
'		If Not oFileUp.Form("file").IsEmpty Then
'    		CreateFolders()
'    		vUploadFilePath = Server.MapPath(OPENWIKI_UPLOADDIR & gPage & "/")
'			oFileUp.Path = vUploadFilePath 
'			vUploadFileName = SafeFileName(oFileUp.Form("file").ShortFilename)
'			response.write vUploadFileName
'			vUploadFileName = gNamespace.SaveAttachmentMetaData(vUploadFileName, oFileUp.Form("file").TotalBytes , oFileUp.Formex("link"), oFileUp.Formex("hide"), oFileUp.Form("comment"))		
'			oFileUp.Form("file").Saveas vUploadFileName
'		end if
'
'		set oFileUp = nothing
'
'	'TODO: Add this and other upload methods
'	'Case UPLOADMETHOD_ASPSMARTUPLOAD
'	
'		'Dim mySmartUpload
'		'Dim intCount
'		        
'		'  Object creation
'		'  ***************
'		'Set mySmartUpload = Server.CreateObject("aspSmartUpload.SmartUpload")
'
'		'  Upload
'		'  ******
'		'mySmartUpload.Upload
'
'		'  Save the files with their original names in a virtual path of the web server
'		'  ****************************************************************************
'		'intCount = mySmartUpload.Save("/aspSmartUpload/Upload")
'		' sample with a physical path 
'		' intCount = mySmartUpload.Save("c:\temp\")
'
'	
    Case Else 'Assume UPLOADMETHOD_LEWISMOTEN = 0 (Script Upload)
		
		If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
		
		Dim objUpload

		' Instantiate Upload Class
		Set objUpload = New Upload
		
		If objUpload.Fields("password").Value=gAdminPassword then

			'CPL: This is a bit lame, in that it waits for the upload to complete before showing an error message.
			If objUpload.Fields("file").Length > OPENWIKI_MAXUPLOADSIZE Then

				Response.Write("<b>Error</b>: Maximum upload size is " & OPENWIKI_MAXUPLOADSIZE & ".  Please go <a href='javascript:history.go(-1)'>back</a>.")
				Response.End
			
			ElseIf objUpload.Fields("file").Length > 0 Then

				' Grab the file name
				vUploadFileName = objUpload.Fields("file").FileName 
				
				if IsImageFileName(vUploadFileName) then 'ok to save
				
					' Compile path to save file to
					vUploadFilePath = vImageLibraryPathTranslated & "\" &  vUploadFileName

					' Save the binary data to the file system
					objUpload("file").SaveAs vUploadFilePath
					Response.Write "Image " & vUploadFileName & " saved to " & vUploadFilePath & ".<br><br>"
					Response.Write "<table border=2><tr><td><a href='" & vImageLibraryPath & vUploadFileName & "'><img src='" & vImageLibraryPath & vUploadFileName & "'></a></td></tr></table><br>"
					
				else
				
					'Error
					Response.Write "<h3>Unsafe Filename!</h3>  Please only load images with one of the following extensions: <br><B>" & replace(gImageExtensions,"|",", ") & "</b><br><br><hr noshade=""noshade"" size=""1"" />"
					
				end if 
				
			End If
		
    
		Else
		
			Response.Write "<h3>Bad Password!</h3>  Please enter the admin password to upload images.<br><br><hr noshade=""noshade"" size=""1"" />"
			
		End If 'objUpload.Fields("submitted")="yes" AND (objUpload.Fields("password")=gAdminPassword) 

		' Release upload object from memory
		Set objUpload = Nothing
	
		Else 'not POST
		End If
		
    End Select
    
    Call DisplayForm
		
    Call DisplayBottom

	


' Check that the filename has an extension that is defined in gImageExtensions
Function IsImageFileName(pFilename)
    Dim vPos, vExtension
    IsImageFileName = FALSE
    vPos = InStrRev(pFilename, ".")
    If vPos > 0 Then
        vExtension = lcase(Mid(pFilename, vPos + 1))
        ' accept nothing, except the ones enumerated in gImageExtensions
        If InStr("|" & lcase(gImageExtensions) & "|", "|" & vExtension & "|") > 0 Then
            IsImageFileName = TRUE
        End If
    End If
End Function 'IsImageFileName

Sub DisplayTop 'Display Top Of Page
%>
<html>
	<head>
		<title>Image Library Upload</title>
		<link rel="stylesheet" type="text/css" href="../ow/skins/default/ow.css" />
		<link rel="stylesheet" type="text/css" href=".ow/ow/skins/default/wysiwyg.css" />	
	</head>
	<body>
	<table class="regions" ID="Table1"><tr valign="top"><td class="regionheader" valign="top" /></tr><tr valign="top"><td valign="top"><table valign="top" class="regionmiddle" ID="Table2"><tr valign="top"><td class="regionleft" valign="top" /><td class="regioncenter" valign="top" ondblclick="location.href='ow.asp?p=Welcome&amp;a=edit'">
		<a href="../ow.asp"><img src="../ow/images/logo.gif" align="right" border="0" alt="OpenWiki" /></a><h1>Image 
			Library Upload</h1>
		<hr noshade="noshade" size="1" />
		<p></p>
<%
End Sub 'DisplayTop

Sub DisplayForm
'Display upload form
%>
		<!-- Upload by Carl Leubsdorf: fake progress bar to display some kind of activity during long uploads -->
		<!-- // Thanks to Brendan Tompkins for the fake progress bar flash movie and the technique!!
			 // http://dotnetjunkies.com/WebLog/bsblog/archive/2004/02/25/7929.aspx -->
		<span style="visibility:hidden;border-right: activeborder thin outset; border-top: activeborder thin outset; font-size: x-small; z-index: 1003;border-left: activeborder thin outset;border-bottom: activeborder thin outset;font-family: Verdana, Arial;position: absolute;border-collapse: collapse;background-color: #F0F0E9;width: 200px;	height: 50px;text-align: center;" ID="progressBar">
			<p>Loading Data. Please Wait...</p>
			<OBJECT codeBase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0"  height="7" width="78" align="middle" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" ID="Shockwaveflash1" VIEWASTEXT>
				<PARAM NAME="Movie" VALUE="../ow/images/loading.swf"></PARAM>
			</OBJECT>
		</span>
        <span ID="uploadFormTable">
        
        To upload an Image to the library, enter the full path to a file stored on
        your computer, or select "Browse" or "Choose" to find and select a file.
		<form name="fup" method="post" enctype="multipart/form-data" ID="Form1">
        
			<input type="hidden" name="submitted" value="yes" ID="Hidden1"> 
			
        
          <table cellspacing="0" cellpadding="2" border="0" ID="Table4">
            <tr>
              <td>File:</td>
              <td><input type="file" name="file" size="60" ID="File1"/></td>
            </tr>
            <tr>
              <td>Admin password:</td>
              <td><input type="password" name="password" ID="Password1"> (required)</td>
            </tr>
              <td>&#160;</td>
              <td>
<input type="button" value="Upload" onClick="javascript:if(document.getElementById('progressBar')) document.getElementById('progressBar').style.visibility='visible';
if(document.getElementById('uploadFormTable')) document.getElementById('uploadFormTable').style.visibility='hidden';
this.form.submit();" ID="Button1" NAME="Button1" />
                
                &#160;
                <input type="button" name="cancel" value="Cancel" onClick="javascript:window.location='{/ow:wiki/ow:scriptname}?p={$name}';" ID="Button2"/>
              </td>
            </tr>
          </table>
        </form>
		</span>

		<%
End Sub 'DisplayForm

Sub DisplayBottom
%>
		</p>
		<hr noshade="noshade" size="1" /><table cellspacing="0" cellpadding="0" border="0" width="100%" ID="Table3"><tr><td align="left" class="n">&nbsp;
		<a class="bookmarks" href="../ow.asp">Welcome Page</a> | <a class="bookmarks" href="ow.asp?TitleIndex">Title Index</a> | <a class="bookmarks" href="ow.asp?Help">Help</a></td><td align="right" rowspan="2"><a href="http://openwiki.com"><img src="../ow/images/poweredby.gif" width="88" height="31" border="0" alt="" /></a></td></tr>
		<tr><td align="left" class="n">&nbsp;
       
       </td><td align="right"><a href="http://validator.w3.org/check/referer"><img src="../ow/images/valid-xhtml10.gif" alt="Valid XHTML 1.0!" width="88" height="31" border="0" /></a><a href="http://jigsaw.w3.org/css-validator/validator?uri=http://localhost/openwiking/owbase/ow.css"><img src="../ow/images/valid-css.gif" alt="Valid CSS!" width="88" height="31" border="0" /></a></td></tr></table></td><td class="regionright" valign="top" /></tr></table></td></tr><tr valign="top"><td class="regionfooter" valign="top" /></tr></table>
	</body>
</html>
<%
End Sub 'DisplayBottom
%>