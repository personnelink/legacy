<%Option Explicit%>
<%
session("add_css") = "emailResume.asp.css" 

dim func
response.buffer=true
func = Request("Func")
dim fso

dim objFileSys
dim TheTextStream
dim path
dim S3Temp(1,1)

if func = 2 or func = 3 then session("no_header") = true
%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->

<script type="text/javascript" src="/include/js/global.js"></script>

<!-- Revised: 2010.1.1 -->
<!-- Revised: 12.17.2008 -->

    <%

' Start attachment save and send.
	
	response.buffer=true
    func = Request("Func")
    	
	if isempty(Func) then
    		Func = 1
	end if

    Select case Func
		case 1

response.write decorateTop("uploadResumeForm", "marLR10", "Upload Current Resume...")
%>
        <form enctype="multipart/form-data" method="post" id="form1" name="form1" action="/include/system/tools/emailResume.asp?func=2">
          <p>
            <label for="File1">Select your resume to upload</label>
            <input id="filename" name="File1" size="45" type="file">
          </p>
          <p>
            <label for="whoareyou">What is your Name?</label>
            <input id="whoareyou" name="whoareyou" type="text" value"<%=session("whoareyou")%>">
          </p>
          <p>
            <label for="zipcode">In what zip code region are you looking for work?</label>
            <input id="zipcode" name="zipcode" type="text" value"<%=user_zip%>">
          </p>
          <input type="hidden" value="Submit Resume">
          &nbsp;
        </form>
      <div class="buttonwrapper" style="padding:10px 0 10px 0;"> <a class="squarebutton" href="javascript:grayOut(true);document.form1.submit();" style="margin-left: 6px" onclick="grayOut(true);document.form1.submit();"><span>Upload Resume</span></a> </div>
<%=decorateBottom()%>
<% TheEnd

		case 2
			dim adLongVarChar, lngNumberUploaded, noBytes, binData, RST, LenBinary, strDataWhole, strBoundry, lngCurrentEnd, lngBoundryPos
			dim lngCurrentBegin, strData, lngBeginFileName, lngEndFileName, strFilename, tmpLng, PrevPos, FileName, lngCT, lngBeginPos
			dim lngEndPos, lngDataLenth, strFileData, f
    			adLongVarChar = 201
    			lngNumberUploaded = 0
    	
				'Get binary data from form		
    			noBytes = Request.TotalBytes 
    				binData = Request.BinaryRead (noBytes)
    
				'convert the binary data to a string
    			Set RST = CreateObject("ADODB.Recordset")
    				LenBinary = LenB(binData)
    	
    					if LenBinary > 0 then
    						RST.Fields.Append "myBinary", adLongVarChar, LenBinary
    							RST.Open
    								RST.AddNew
    									RST("myBinary").AppendChunk BinData
    								RST.Update
    						strDataWhole = RST("myBinary")
    					end if
    
    
    'get the boundry indicator
    strBoundry = Request.ServerVariables ("HTTP_CONTENT_TYPE")
    if len(strBoundry) >0 then
		lngBoundryPos = instr(1,strBoundry,"boundary=") + 8 
    	strBoundry = "--" & right(strBoundry,len(strBoundry)-lngBoundryPos)
    
    	'Get first file boundry positions.
    	lngCurrentBegin = instr(1, strDataWhole, strBoundry)
    	lngCurrentEnd = instr(lngCurrentBegin + 1, strDataWhole, strBoundry) - 1
	end if

'do while lngCurrentEnd > 0
			'Get the data between current boundry and remove it from the whole.
			strData = mid(strDataWhole,lngCurrentBegin, lngCurrentEnd - lngCurrentBegin)
				strDataWhole = replace(strDataWhole,strData,"")
    			
			'Get the full path of the current file.
    		lngBeginFileName = instr(1,strdata,"filename=") + 10
    			lngEndFileName = instr(lngBeginFileName,strData,chr(34)) 
    
			'Make sure they selected at least one file.	
    		if lngBeginFileName = lngEndFileName and lngNumberUploaded = 0 then
    	
    			response.write decorateTop("uploadError", "marLR10", "The following error occured...")
    			response.write "You must select a resume to upload"
    			response.write "<br><br>Hit the back button, make the needed corrections and resubmit your information."
    			response.write "<br><br><input type='button' onclick='history.go(-1)' value='<< Back' id='button'1 name='button'1>"
    			response.write decorateBottom()
    			TheEnd()
    	
    		end if
    
			'There could be one or more empty file boxes.	
    		strFilename = mid(strData,lngBeginFileName,lngEndFileName - lngBeginFileName)
    
			'Creates a raw data file with data between current boundrys. Uncomment for debuging.	
    		'Set fso = CreateObject("Scripting.FileSystemObject")
    		'Set f = fso.OpenTextFile(server.mappath(".") & "\raw_" & lngNumberUploaded & ".txt", ForWriting, True)
    		'f.Write strData
    		'set f = nothing
    		'set fso = nothing
    		
			'Loose the path information and keep just the file name.	
    		tmpLng = instr(1,strFilename,"\")
    			
    			do while tmpLng > 0
    				PrevPos = tmpLng
    				tmpLng = instr(PrevPos + 1, strFilename,"\")
    			loop
    		
    				FileName = right(strFilename,len(strFileName) - PrevPos)
			'Get the begining position of the file data sent.
			'if the file type is registered with the browser then there will be a Content-Type
    			lngCT = instr(1, strData, "Content-Type:")
    	
    				if lngCT > 0 then
    					lngBeginPos = instr(lngCT, strData, chr(13) & chr(10)) + 4
					else
						lngBeginPos = lngEndFileName
    				end if
    
			'Get the ending position of the file data sent.
    		lngEndPos = len(strData) 
    		
			'Calculate the file size.	
    		lngDataLenth = lngEndPos - lngBeginPos
				'Get the file data	
    			strFileData = mid(strData,lngBeginPos,lngDataLenth)
				
				dim ThisFile, ThisFilePath
				ThisFilePath = "\\personnelplus.net.\net_docs\resumes\Received\"
				' Create the file, change the path to the path U use for temp storage of the file
				' make sure you have the IUSR_YOURCOMPUTER granted WRITE access to the uploads dir
    			Set fso = CreateObject("Scripting.FileSystemObject")

				dim tStamp, dStamp, ms, ds, ys
				
				dStamp = Date
				ms = CStr(Month(dStamp))
				if len(ms) = 1 then ms = "0" & ms
				
				ds = CStr(Day(dStamp))
				if len(ds) = 1 then ds = "0" & ds

				ys = CStr(Year(dStamp))

				dStamp = ys & "." & ms & "." & ds

				tStamp = Time
				tStamp = replace(tStamp, ":", ".")
				tStamp = replace(tStamp, " ", "")
				
				FileName = dStamp & "_" & tStamp & "-" & FileName
				
				Set f = fso.OpenTextFile(ThisFilePath & FileName, ForWriting, True)
					f.Write strFileData
    
					' Get full Path, you need it for deleting the file later  	
					'ThisFile = "C:\Received\" & FileName
					ThisFile = ThisFilePath & FileName
    
       			lngNumberUploaded = lngNumberUploaded + 1
    		
    		' destroy f, free memory
  		    set f = nothing
   			
		'Get then next boundry postitions if any
   		lngCurrentBegin = instr(1, strDataWhole, strBoundry)
	    lngCurrentEnd = instr(lngCurrentBegin + 1, strDataWhole, strBoundry) - 1
'loop

	dim msgSubject, msgBody, zipcode
	dim region, resumeCity, resumeState, resumeZip
	
	On Error Resume Next
	Database.Open MySql
	Set region = Database.Execute("Select address, city, state, zip From tbl_addresses Where addressID=" & addressId)
	resumeCity = region("city")
	resumeState = region("state")
	resumeZip = region("zip")
	
	msgBody = "A Resume from " & resumeCity & ", " & resumeState & " " & resumeZip &_
		" was submitted " & " " & now() & chr(10) & chr(10)
		"Resumes are located in the resumes folder here: \\personnelplus.net.\net_docs\resumes " & chr(10) & chr(10)
		"The resumes can be searched using either the online Resume Search tool or by " &_
		"pointing your operating systems built in search tool to the above location." & chr(10)
	
	msgSubject = "Resume submitted from " & resumeCity & ", " & resumeState & " " & resumeZip

	dim mySmartMail, deliveryLocation
	
	Set dbQuery = Database.Execute("Select email From list_zips Where zip='" & resumeZip & "'")
	if Not dbQuery.eof then
		deliveryLocation = dbQuery("email")
	Else
		deliveryLocation = "twinfalls@personnel.com"
	end if
	
	Call SendEmail (deliveryLocation, system_email, msgSubject, msgBody, "")
 

    ' Now the file in the uploads dir can be deleted
    'fso.DeleteFile ThisFile
    
    ' Destroy FileSystemObject, Free memory
    set fso = nothing
	On Error Goto 0
	
	response.redirect"/include/system/tools/emailResume.asp?func=3"        		

Case 3
	dim rtemp
	rtemp = set_session("homeMessageHeading", "Resume Submitted")
	response.redirect("/userHome.asp")
End select

Function GetField(key)
	s1=InStr(strDataWhole, key)
	s2=InStr(s1+2, strDataWhole, "�|")
	GetField=(mid(strDataWhole, s1+(len(key)+1), s2-(s1+len(key)+3)))
End Function
	
Function URLDecode(S3Decode)

	S3In  = S3Decode
	S3Out = ""
	S3In  = Replace(S3In, "+", " ")
	S3Pos = Instr(S3In, "%")
	
	do while S3Pos
		S3Len = len(S3In)
		if S3Pos > 1 then S3Out = S3Out & Left(S3In, S3Pos - 1)
		S3Temp(0,0) = Mid(S3In, S3Pos + 1, 1)
		S3Temp(1,0) = Mid(S3In, S3Pos + 2, 1)
		
		For S3i = 0 to 1
			if Asc(S3Temp(S3i,0)) > 47 And Asc(S3Temp(S3i, 0)) < 58 then
				S3Temp(S3i, 1) = Asc(S3Temp(S3i, 0)) - 48
			Else
				S3Temp(S3i, 1) = Asc(S3Temp(S3i, 0)) - 55
			end if
		Next
		
		S3Out = S3Out & Chr((S3Temp(0,1) * 16) + S3Temp(1,1))
		S3In  = Right(S3In, (S3Len - (S3Pos + 2)))
		S3Pos = Instr(S3In, "%")
	loop

	URLDecode = S3Out & S3In
End Function

%>
