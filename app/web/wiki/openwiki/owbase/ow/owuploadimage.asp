<%
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
'
' Adapted for general image upload by Gordon Bamber 20060210
'=============================================================================
%>
<%


Sub ActionImageUpload
If cAllowImageLibrary=0 then
	gAction = "view"
	gRevision=0
	gPage=OPENWIKI_ERRORPAGENAME
	gErrorPageText="Sorry, shared images have been disallowed on this Wiki."
	ActionView
	gActionReturn = True
	Exit Sub
End If

	Response.Expires = -10000
    Server.ScriptTimeOut = OPENWIKI_UPLOADTIMEOUT
	
	Dim vUploadFilename, vUploadFilePath,bSuccess
	bSuccess=False
    Select Case OPENWIKI_UPLOADMETHOD
    
    Case UPLOADMETHOD_ABCUPLOAD 'ABCUpload4 COM Control
    
		Dim theForm, theField
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
			CreateImageFolder()

			vUploadFilename = theField.FileName
			If m(vUploadFilename, gImagePattern, False, True) Then '        // Check its an image type (gif, jpg etc)
			' Save to filesystem.
				theField.Save OPENWIKI_IMAGELIBRARY & "/" & vUploadFilename
				bSuccess=True
			End If
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
    		CreateImageFolder()
    		vUploadFilePath = Server.MapPath(OPENWIKI_IMAGELIBRARY & "/")
			oFileUp.Path = vUploadFilePath 
			vUploadFileName = SafeFileName(oFileUp.Form("file").ShortFilename)
			response.write vUploadFileName
			vUploadFileName = gNamespace.SaveAttachmentMetaData(vUploadFileName, oFileUp.Form("file").TotalBytes , oFileUp.Formex("link"), oFileUp.Formex("hide"), oFileUp.Form("comment"))		
			If m(vUploadFilename, gImagePattern, False, True) Then '        // Check its an image type (gif, jpg etc)
			' Save to filesystem.
				oFileUp.Form("file").Saveas vUploadFileName
				bSuccess=True
			End If

		
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
		'On Error Resume Next
		Dim objUpload

		' Instantiate Upload Class
		Set objUpload = New Upload

		'CPL: This is a bit lame, in that it waits for the upload to complete before showing an error message.
		If objUpload.Fields("file").Length > OPENWIKI_MAXUPLOADSIZE Then

			Response.Write("<b>Error</b>: Maximum upload size is " & OPENWIKI_MAXPLOADSIZE  & ".  Please go <a href='javascript:history.go(-1)'>back</a>.")
			Response.End
		
		ElseIf objUpload.Fields("file").Length > 0 Then

			' If you want to store your files as BLOBs in the database, then you should
			' comment the next line
			CreateImageFolder()

			' Grab the file name
			vUploadFileName = objUpload.Fields("file").FileName 
    
			' Compile path to save file to
			vUploadFilePath = server.MapPath(OPENWIKI_IMAGELIBRARY) & "\" &  vUploadFileName

			If m(vUploadFilename, gImageExtensions, False, True) Then '        // Check its an image type (gif, jpg etc)
			' Save the binary data to the file system
				objUpload("file").SaveAs vUploadFilePath
				bSuccess=True
			End If
		
		End If
		
		' Release upload object from memory
		Set objUpload = Nothing
    
    End Select
    
	gAction = "view"
	gRevision=0
	If bSuccess=true then
		gSuccessPageText="Image " & vUploadFileName & " uploaded successfully.<br>" &_
		"You can link to it by using the syntax {{{sharedimage:" & vUploadFileName & "}}}<br>" &_
		"on any page on this Wiki<br><br>" &_
		"  //[" & gPage & " Return to " & gPage & "] Page//"
		gPage=OPENWIKI_SUCCESSPAGENAME
	else
		gPage=OPENWIKI_ERRORPAGENAME
		gErrorPageText="Sorry, I was unable to upload the image " & vUploadFileName
	End If
	'        // Display it
	ActionView
	gActionReturn = True
End Sub

' Create all the subfolders if they do not exist yet.
Sub CreateImageFolder()
    Dim vFSO, vPosBegin, vPosEnd, vPath
    Set vFSO = Server.CreateObject("Scripting.FileSystemObject")
    If Not vFSO.FolderExists(Server.MapPath(OPENWIKI_IMAGELIBRARY)) Then
        vPath = Server.MapPath(OPENWIKI_UPLOADDIR)
		Call vFSO.CreateFolder(vPath)
    End If
	Set vFSO = Nothing
End Sub

%>