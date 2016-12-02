<%
'
' ---------------------------------------------------------------------------
' Copyright(c) 2000-2002, Laurens Pit 
' All rights reserved.
'
' Redistribution and use in source and binary forms, with or without
' modification, are permitted provided that the following conditions
' are met:
'
'   * Redistributions of source code must retain the above copyright
'     notice, this list of conditions and the following disclaimer.
'   * Redistributions in binary form must reproduce the above
'     copyright notice, this list of conditions and the following
'     disclaimer in the documentation and/or other materials provided
'     with the distribution.
'   * Neither the name of OpenWiki nor the names of its contributors
'     may be used to endorse or promote products derived from this
'     software without specific prior written permission.
'
' THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
' "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
' LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
' FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
' REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
' INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
' BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
' LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
' CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
' LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
' ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
' POSSIBILITY OF SUCH DAMAGE.
'
' ---------------------------------------------------------------------------
'	  $Log: owattach.asp,v $
'	  Revision 1.9  2006/03/18 19:53:19  piixiiees
'	  Point Update 20060304.4
'	  MacroShowSharedImages updated
'	   * cAllowImageLibrary checked
'	   * SyntaxErrorMessage included
'	   * parameters controlled
'	   * gImageExtensions validated
'	   * ow.css style updated: div.figure, div.figure p, img.scaled
'	  Bug attachments fixed:
'	   * CreateFolders routine duplicated. The one in owuploadimage.asp renamed as CreateImageFolder
'	
'	  Revision 1.8  2006/02/16 18:33:16  gbamber
'	  General update:
'	  Rename improved
'	  local: now sharedimage:
'	  New imageupload macro
'	  added file uploadimage.asp
'	  changed owall to fix #includes with attach.asp
'	  new doctypes for google earth
'	  new urltype skype
'	  Userprefs has a password field
'	  Reaname template updated
'	
'	  Revision 1.7  2005/01/24 21:57:04  casper_gasper
'	  Replaced window.navigate with cross-platform window.location property.
'	
'	  Revision 1.6  2005/01/21 15:49:21  sansei
'	  reverted to previous version (before msxml4-fix) - Update had serious errors!
'	
'	  Revision 1.4  2004/10/13 12:17:21  gbamber
'	  Forced updates to make sure CVS reflects current work
'	
'	  Revision 1.3  2004/09/03 18:04:42  gbamber
'	  Log directive added
'	
'      $Source: /cvsroot/openwiki-ng/openwiking/owbase/ow/owattach.asp,v $
'    $Revision: 1.9 $
'      $Author: piixiiees $
' ---------------------------------------------------------------------------
'
'
'
'
'
'       !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'       !!! WARNING: YOU ARE POTENTIALLY RUNNING A SECURITY RISK !!!
'       !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'
'
'
'
' Potentially people can upload files to your server that will be executed
' on your server when they point their browser to the uploaded file.
'
' This is possible because in IIS executables are mapped to file extensions.
' So for example, potentially someone can upload an .asp file, then point their
' browser to that file, after which the file is executed on your server, possibly
' wiping out your entire file system.
'
' In IIS you can view the application mappings by going to the properties of
' your website, choose tab "Home Directory", click on button "Configuration"
' and choose tab "App Mappings".
'
' Besides running a security risk on your server, by allowing people to upload
' files your users might unsuspectedly run into a mallicious file that is
' executed on their machines. For example, it's easy to upload an html file
' with very nasty javascript code; when your users view the html page as is,
' the javascript code will get executed on their machine, and your users might
' get very angry with you. ;)
'
' So in general: it's a bad idea to allow uploads on public websites. Only
' allow it when you trust your users.
'
' ---------------------------------------------------------------------------
'
' PLEASE READ THE BIG LETTERS OF THE OPENWIKI LICENSE AGAIN !
'
' It's printed above for your convenience. ;-)
'
' ---------------------------------------------------------------------------
'
' By default all files uploaded will get the extension .safe, except for files
' with extensions that are defined in the variable gDocExtensions (see file
' owpatterns.asp).
'
' If the variable gNotAcceptedExtensions is defined (see file owpattern.asp),
' then all files uploaded will keep their extensions, except the ones defined
' in the variable; they will still get the .safe extension. When you use this
' method you are advised to add all the extensions for which an application
' mapping is defined for the website in IIS.
'
' ---------------------------------------------------------------------------
'
' The is version 1 of the upload feature.
'
' This version of the upload feature assumes that you have installed the
' upload component ABC Upload version 4 from WebSupergoo. It's "free" and
' easy to install. See http://www.websupergoo.com/abcupload-1.htm.
'
' Using a different component would be quite easy if you know a bit of ASP.
' You'd only have to modify the sub ActionUpload below. Future versions of
' OpenWiki will probably support various upload components.
'
' This version saves the files to the file system. Saving to the database
' is again quite easy if you know a bit of ASP and databases, see comments
' inline the code below (note: you'd also need a separate script to retrieve
' the files). Future versions of OpenWiki will probably support storing
' files as BLOB's in the database.
'
' ---------------------------------------------------------------------------
'
'=============================================================================
' NOTE: See "Case Else 'Assume UPLOADMETHOD_LEWISMOTEN = 0 (Script Upload)" 
'       below in Sub ActionUpload
' Implementation for OpenWiki by Carl Leubsdorf, (carl@carlthewebmaster.com) 
' based in part on samples from Lewis Moten's ToFileSystem.asp.  More info: 
'   http://www.pscode.com/vb/scripts/ShowCode.asp?txtCodeId=7361&lngWId=4
'
'  Upload Class courtesy of:
'	 -----------------------------------------
'		Author:		Lewis Moten
'		Email:		Lewis@Moten.com
'		URL:		http://www.lewismoten.com
'	 -----------------------------------------
' Thanks Lewis!
'=============================================================================
%>
<%

Sub ActionAttach
    ActionView()
End Sub


Sub ActionUpload
    Response.Expires = -10000
    Server.ScriptTimeOut = OPENWIKI_UPLOADTIMEOUT
	
	Dim vUploadFilename, vUploadFilePath
	
    Select Case OPENWIKI_UPLOADMETHOD
    
    Case UPLOADMETHOD_ABCUPLOAD 'ABCUpload4 COM Control
    
		Dim theForm, theField
		On Error Resume Next
		Err.Number = 0
		Set theForm = Server.CreateObject("ABCUpload4.XForm")
		If Err.Number <> 0 Then
			Response.Write("<b>Error</b>: Missing component ABCUpload4. You can download this component from <a href='http://www.websupergoo.com/downloadftp.htm'>websupergoo.com</a>")
			Response.End
		End If
		On Error Goto 0
		theForm.MaxUploadSize = OPENWIKI_MAXUPLOADSIZE
		theForm.Overwrite = True
		theForm.AbsolutePath = False
		' TODO: maybe implement pop-up progress-bar
		'theForm.ID = Request.QueryString("ID")

		'On Error Resume Next
		Set theField = theForm("file")(1)
		If theField.FileExists Then
			' If you want to store your files as BLOBs in the database, then you should
			' comment the next line
			CreateFolders()

			vUploadFilename = theField.SafeFileName
			vUploadFilename = gNamespace.SaveAttachmentMetaData(vUploadFilename, theField.Length, theForm("link"), theForm("hide"), theForm("comment"))

			' Save to filesystem.
			theField.Save OPENWIKI_UPLOADDIR & gPage & "/" & vUploadFilename
		End If
		
		set theField = nothing
    
    Case UPLOADMETHOD_SAFILEUP 'SA FileUp COM COntrol

		Dim oFileUp
		
		Set oFileUp = Server.CreateObject("SoftArtisans.FileUp")
		oFileUp.MaxBytesToCancel = OPENWIKI_MAXUPLOADSIZE
		oFileUp.OverWriteFiles = True
		
		If Err.Number <> 0 Then
			Response.Write("<b>Error</b>: Missing component SoftArtisans.FileUp. You can download this component from <a href='http://fileup.softartisans.com/'>fileup.SoftArtisans.com</a>")
			Response.End
		End If
	    
	    
		If Not oFileUp.Form("file").IsEmpty Then
    		CreateFolders()
    		vUploadFilePath = Server.MapPath(OPENWIKI_UPLOADDIR & gPage & "/")
			oFileUp.Path = vUploadFilePath 
			vUploadFileName = SafeFileName(oFileUp.Form("file").ShortFilename)
			response.write vUploadFileName
			vUploadFileName = gNamespace.SaveAttachmentMetaData(vUploadFileName, oFileUp.Form("file").TotalBytes , oFileUp.Formex("link"), oFileUp.Formex("hide"), oFileUp.Form("comment"))		
			oFileUp.Form("file").Saveas vUploadFileName
		end if

		set oFileUp = nothing

	'TODO: Add this and other upload methods
	'Case UPLOADMETHOD_ASPSMARTUPLOAD
	
		'Dim mySmartUpload
		'Dim intCount
		        
		'  Object creation
		'  ***************
		'Set mySmartUpload = Server.CreateObject("aspSmartUpload.SmartUpload")

		'  Upload
		'  ******
		'mySmartUpload.Upload

		'  Save the files with their original names in a virtual path of the web server
		'  ****************************************************************************
		'intCount = mySmartUpload.Save("/aspSmartUpload/Upload")
		' sample with a physical path 
		' intCount = mySmartUpload.Save("c:\temp\")

	
    Case Else 'Assume UPLOADMETHOD_LEWISMOTEN = 0 (Script Upload)
		' On Error Resume Next
		Dim objUpload

		' Instantiate Upload Class
		Set objUpload = New Upload

		'CPL: This is a bit lame, in that it waits for the upload to complete before showing an error message.
		If objUpload.Fields("file").Length > OPENWIKI_MAXUPLOADSIZE Then

			Response.Write("<b>Error</b>: Maximum upload size is " & OPENWIKI_MAXIMUMUPLOADSIZE & ".  Please go <a href='javascript:history.go(-1)'>back</a>.")
			Response.End
		
		ElseIf objUpload.Fields("file").Length > 0 Then

			' If you want to store your files as BLOBs in the database, then you should
			' comment the next line
			CreateFolders()

			' Grab the file name
			'Note hard-coded form field name of "file" from ow/skins/<skin name>/owattach.xsl, line 158
			vUploadFileName = objUpload.Fields("file").FileName 

			' Set "safe" filename linked to page
			vUploadFileName = gNamespace.SaveAttachmentMetaData(objUpload.Fields("file").FileName, objUpload.Fields("file").Length, objUpload("link").Value, objUpload("hide").Value, objUpload("comment").Value)

			' Compile path to save file to
			vUploadFilePath = server.MapPath(OPENWIKI_UPLOADDIR & gPage ) & "\" &  vUploadFileName

			' Save the binary data to the file system
			objUpload("file").SaveAs vUploadFilePath
		
		End If
		
		' Release upload object from memory
		Set objUpload = Nothing
    
    End Select
    
    gActionReturn = True
    Response.Write "<script language=javascript>window.location = '" & gScriptName & _
     "?p=" & Server.URLEncode(gPage) & "&a=attach" & "';</script>"
    'Response.Redirect(gScriptName & "?p=" & Server.URLEncode(gPage) & "&a=attach")
    Response.End
End Sub


Sub ActionHidefile
    Call gNamespace.HideAttachmentMetaData(Request("file"), Request("rev"), 1)
    Response.Redirect(gScriptName & "?p=" & Server.URLEncode(gPage) & "&a=attach")
    Response.End
End Sub

Sub ActionUndohidefile
    Call gNamespace.HideAttachmentMetaData(Request("file"), Request("rev"), 0)
    Response.Redirect(gScriptName & "?p=" & Server.URLEncode(gPage) & "&a=attach")
    Response.End
End Sub

Sub ActionTrashfile
    Call gNamespace.TrashAttachmentMetaData(Request("file"), Request("rev"), 1)
    Response.Redirect(gScriptName & "?p=" & Server.URLEncode(gPage) & "&a=attach")
    Response.End
End Sub

Sub ActionUndotrashfile
    Call gNamespace.TrashAttachmentMetaData(Request("file"), Request("rev"), 0)
    Response.Redirect(gScriptName & "?p=" & Server.URLEncode(gPage) & "&a=attach")
    Response.End
End Sub

Sub ActionAttachchanges
    Call gTransformer.Transform(gNamespace.GetPageAndAttachments(gPage, 0, False, True).ToXML(0))
    gActionReturn = True
End Sub



' If you want to store your files as BLOBs in the database, then you'd need
' to change this function.
'
' IN:
'   pPagename : page that has the attachment
'   pFilename : filename of the attachment
' RETURN: full URL to view/download the attachment
Function GetAttachmentLink(pPagename, pFilename)
    GetAttachmentLink = gServerRoot & OPENWIKI_UPLOADDIR & pPagename & "/" & pFilename
End Function


' Create all the subfolders if they do not exist yet.
Sub CreateFolders()
    ' On Error Resume Next
    Dim vFSO, vPosBegin, vPosEnd, vPath

    Set vFSO = Server.CreateObject("Scripting.FileSystemObject")
    
    If Not vFSO.FolderExists(Server.MapPath(OPENWIKI_UPLOADDIR & gPage & "/")) Then
        vPosBegin = 1
        vPath = Server.MapPath(OPENWIKI_UPLOADDIR)

        Do While True
            vPosEnd = InStr(vPosBegin, gPage, "/")
            If vPosEnd > vPosBegin Then
                vPath = vPath & "\" & Mid(gPage, vPosBegin, vPosEnd - vPosBegin)
                If Not vFSO.FolderExists(vPath) Then
                    Call vFSO.CreateFolder(vPath)
                End If
                vPosBegin = vPosEnd + 1
            Else
                vPath = vPath & "\" & Mid(gPage, vPosBegin)
                If Not vFSO.FolderExists(vPath) Then
                    Call vFSO.CreateFolder(vPath)
                End If
                Exit Do
            End If
        Loop
    End If

End Sub

%>