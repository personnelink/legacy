<%
'***************************************
' File:	  Upload.asp
' Author: Jacob "Beezle" Gilley
' Email:  avis7@airmail.net
' Date:   12/07/2000
' Comments: The code for the Upload, CByteString, 
'			CWideString	subroutines was originally 
'			written by Philippe Collignon...or so 
'			he claims. Also, I am not responsible
'			for any ill effects this script may
'			cause and provide this script "AS IS".
'			Enjoy!
'****************************************

Class FileUploader
	Public  Files
	Private mcolFormElem
	Public maxSize
	Public maxFileSize
	Public fileExt
	Public error
	Public errorDesc
	
	Private Sub Class_Initialize()
		Set Files = Server.CreateObject("Scripting.Dictionary")
		Set mcolFormElem = Server.CreateObject("Scripting.Dictionary")
	End Sub
	
	Private Sub Class_Terminate()
		If IsObject(Files) Then
			Files.RemoveAll()
			Set Files = Nothing
		End If
		If IsObject(mcolFormElem) Then
			mcolFormElem.RemoveAll()
			Set mcolFormElem = Nothing
		End If
	End Sub

	Public Property Get Form(sIndex)
		Form = ""
		If mcolFormElem.Exists(LCase(sIndex)) Then Form = mcolFormElem.Item(LCase(sIndex))
	End Property
	
	Public Default Sub Upload()
		Dim biData, sInputName
		Dim nPosBegin, nPosEnd, nPos, vDataBounds, nDataBoundPos
		Dim nPosFile, nPosBound

		error = False
		errorDesc = ""
		
		If Not IsNull(maxSize) AND Not IsNumeric(maxSize) Then
			If Request.TotalBytes > maxSize Then
				Error = True
				errorDesc = errorDesc & "La dimensione del file è più grande di <b>" & maxSize & "</b> byte" & "<br>"
				Exit Sub
			End If
		End If

		biData = Request.BinaryRead(Request.TotalBytes)

		nPosBegin = 1
		nPosEnd = InstrB(nPosBegin, biData, CByteString(Chr(13)))
		
		If (nPosEnd-nPosBegin) <= 0 Then Exit Sub
		 
		vDataBounds = MidB(biData, nPosBegin, nPosEnd-nPosBegin)
		nDataBoundPos = InstrB(1, biData, vDataBounds)
		
		counter = 0
		
		Do Until nDataBoundPos = InstrB(biData, vDataBounds & CByteString("--"))
		
		  counter = counter + 1	
			nPos = InstrB(nDataBoundPos, biData, CByteString("Content-Disposition"))
			nPos = InstrB(nPos, biData, CByteString("name="))
			nPosBegin = nPos + 6
			nPosEnd = InstrB(nPosBegin, biData, CByteString(Chr(34)))
			sInputName = CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
			nPosFile = InstrB(nDataBoundPos, biData, CByteString("filename="))
			nPosBound = InstrB(nPosEnd, biData, vDataBounds)
			
			If nPosFile <> 0 And  nPosFile < nPosBound Then
				Dim oUploadFile, sFileName, sFileExt
				Set oUploadFile = New UploadedFile
				
				nPosBegin = nPosFile + 10
				nPosEnd =  InstrB(nPosBegin, biData, CByteString(Chr(34)))
				
				sFileName = CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
				sFileName1 = Right(sFileName, Len(sFileName)-InStrRev(sFileName, "\"))
				
				oUploadFile.FileName = Right(sFileName, Len(sFileName)-InStrRev(sFileName, "\"))
				
				sfileExt = Right(sFileName1, Len(sFileName1) - InStrRev(sFileName1, "."))
				If Not IsNull(fileExt) Then
				  If Instr(fileExt, sFileExt) = 0 Then
				  	Error = True
				  	errorDesc = errorDesc & "File <b>" & oUploadFile.FileName  & "</b>:" & strLangUploadErrorNoImage2 & fileExt & ")" & "<br>"
				  Else
    				nPos = InstrB(nPosEnd, biData, CByteString("Content-Type:"))
    				nPosBegin = nPos + 14
    				nPosEnd = InstrB(nPosBegin, biData, CByteString(Chr(13)))
    				
    				oUploadFile.ContentType = CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
    				
    				nPosBegin = nPosEnd+4
    				nPosEnd = InstrB(nPosBegin, biData, vDataBounds) - 2
    				oUploadFile.FileData = MidB(biData, nPosBegin, nPosEnd-nPosBegin)
    				
    				If (oUploadFile.FileSize > 0) AND (oUploadFile.FileSize <= maxFileSize) Then Files.Add LCase(sInputName), oUploadFile
    
    				If Not IsNull(maxFileSize) Then
      				If oUploadFile.FileSize > maxFileSize Then
    	 			  	Error = True
    				  	errorDesc = errorDesc & "File <b>" & oUploadFile.FileName & "</b>:" & strLangUploadErrorTooBig & " (max: " & maxFileSize/1000 & " kb)" & "<br>"
    				  	'Exit Sub
    				  End If				
    				End If
				  End If
				End If
			Else
				nPos = InstrB(nPos, biData, CByteString(Chr(13)))
				nPosBegin = nPos + 4
				nPosEnd = InstrB(nPosBegin, biData, vDataBounds) - 2
				If Not mcolFormElem.Exists(LCase(sInputName)) Then mcolFormElem.Add LCase(sInputName), CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
			End If

			nDataBoundPos = InstrB(nDataBoundPos + LenB(vDataBounds), biData, vDataBounds)
		Loop
	End Sub

	'String to byte string conversion
	Private Function CByteString(sString)
		Dim nIndex
		For nIndex = 1 to Len(sString)
		   CByteString = CByteString & ChrB(AscB(Mid(sString,nIndex,1)))
		Next
	End Function

	'Byte string to string conversion
	Private Function CWideString(bsString)
		Dim nIndex
		CWideString =""
		For nIndex = 1 to LenB(bsString)
		   CWideString = CWideString & Chr(AscB(MidB(bsString,nIndex,1))) 
		Next
	End Function
End Class

Class UploadedFile
	Public ContentType
	Public FileName
	Public FileData
	
	Public Property Get FileSize()
		FileSize = LenB(FileData)
	End Property

	Public Sub SaveToDisk(sPath)
		Dim oFS, oFile
		Dim nIndex
	
		If sPath = "" Or FileName = "" Then Exit Sub
		If Mid(sPath, Len(sPath)) <> "\" Then sPath = sPath & "\"
	
		Set oFS = Server.CreateObject("Scripting.FileSystemObject")
		If Not oFS.FolderExists(sPath) Then Exit Sub
		
		If oFS.FileExists(sPath & FileName) Then
      oFS.MoveFile sPath & FileName, sPath & "old-" & FileName
		End If

		Set oFile = oFS.CreateTextFile(sPath & FileName, True)
		
		For nIndex = 1 to LenB(FileData)
	    oFile.Write Chr(AscB(MidB(FileData,nIndex,1)))
		Next
		oFile.Close
		
		Set oFS = Nothing
	End Sub
	
	Public Sub SaveToDatabase(ByRef oField)
		If LenB(FileData) = 0 Then Exit Sub
		
		If IsObject(oField) Then
			oField.AppendChunk FileData
		End If
	End Sub

End Class
%>