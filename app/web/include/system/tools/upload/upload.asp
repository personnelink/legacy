<%Option Explicit%>
<%
dim uploadThis, uploadTitle, toolName
uploadThis = request.ServerVariables("SCRIPT_NAME")
if instr(uploadThis, "upload/timecard/") > 0 then
	uploadThis = "_timecard/"
	uploadTitle = "timecards"
	toolName = "Send Timecard(s)..."
elseif instr(uploadThis, "upload/drug_test/") > 0 then
	uploadThis = "drug testing/"
	uploadTitle = "drug test"
	toolName = "Store Drug Test(s)..."
end if
session("add_css") = ".//include/system/tools/upload/upload.css"
session("user_level") = 0



dim func
response.buffer=true
func = Request("Func")
if func = 2 or func = 3 then session("no_header") = true
%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->

<script type="text/javascript" src="/include/js/global.js"></script>
<%

dim jobid
jobid = request.querystring("jobid")

dim fso

dim objFileSys
dim TheTextStream
dim path
dim S3Temp(1,1)

Function GetField(key)
	dim s1, s2

	s1=InStr(strDataWhole, key)
	s2=InStr(s1+2, strDataWhole, "-----------------------------")

	GetField=mid(strDataWhole, s1+(len(key)+5), s2-(s1+len(key)+7))
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

' Start attachment save and send.
	
	response.buffer=true
    func = Request("Func")
    	
	if isempty(Func) then
    		Func = 1
	end if

    Select case Func
		case 1
			dim strTempName, strTempZip
			if user_firstname <> "Guest" then
				strTempName = user_firstname & " " & user_lastName
				strTempZip = user_zip
			end if
						
			response.write decorateTop("uploadResumeForm", "marLR10", toolName)
			%>
				   <form enctype="multipart/form-data" method="post" id="form1" name="form1" action="upload.asp?func=2&jobid=<%=jobid%>">
					<p>
					  <label for="File1" class="resumeform">Attach <%=uploadTitle%>?</label>
					  <input id="filename" class="resumeform" name="File1" size="25" type="file">
					</p>
					<p>
					  <label for="whoareyou" class="resumeform">What is your Name?</label>
					  <input id="whoareyou" class="resumeform" name="whoareyou" type="text" value="<%=strTempName%>">
					</p>
					<% if not uploadTitle = "drug test" then %>
					<p>
					  <label for="zipcode" class="resumeform">Zip code?</label>
					  <input id="zipcode" class="resumeform" name="zipcode" type="text" value="<%=strTempZip%>">
					</p>
					<% end if %>
					<input type="hidden" value="Upload <%=pcase(replace(uploadThis, "/", ""))%>">
					&nbsp;
				   </form>
				 <div id="upload_resume" class="buttonwrapper"> <a class="squarebutton" href="javascript:grayOut(true);document.form1.submit();" style="margin-left: 6px" onclick="grayOut(true);document.form1.submit();"><span>Upload</span></a> </div>
			<%=decorateBottom()%>
			<% TheEnd

		case 2
			dim lngNumberUploaded, noBytes, binData, RST, LenBinary, strDataWhole, strBoundry, lngCurrentEnd, lngBoundryPos
			dim lngCurrentBegin, strData, lngBeginFileName, lngEndFileName, strFilename, tmpLng, PrevPos, FileName, lngCT, lngBeginPos
			dim lngEndPos, lngDataLenth, strFileData, f
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
    			response.write "You must select a " & uploadTitle & " to upload"
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
				ThisFilePath = "\\personnelplus.net.\net_docs\" & replace(uploadThis, "/", "s\") & "_received\"
			
				'print uploadThis
				if uploadTitle = "drug test" then
					ThisFilePath = replace(ThisFilePath, "drug testings\", "Drug Testing\")
				end if
			
				'print ThisFilePath
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
	dim region, resumeCity, resumeState, resumeZip, resumeWho
	
	On Error Resume Next
	Database.Open MySql
	Set region = Database.Execute("Select address, city, state, zip From tbl_addresses Where addressID=" & addressId)
	resumeCity = region("city")
	resumeState = region("state")
	resumeZip = GetField("zipcode")
	if isempty(resumeZip) then resumeZip = region("zip")
	resumeWho = GetField("whoareyou")


	if len(jobid) > 0 then
	
		dim getJobDetails
		Set GetJobDetails = Server.CreateObject("ADODB.Connection")

		dim deliveryLocation
		select case lcase(left(jobid, 3))
		case "bur"
			deliveryLocation = "burley@personnel.com"
			GetJobDetails.Open dsnLessTemps(BUR)
			case "boi"
			deliveryLocation = "boise@personnel.com;nampa@personnel.com"
			GetJobDetails.Open dsnLessTemps(BOI)
		case "per"
			deliveryLocation = "twin@personnel.com"
			GetJobDetails.Open dsnLessTemps(PER)
		case else
			deliveryLocation = "twin@personnel.com"
		end select
	
		dim JobDetails
		Set JobDetails = getJobDetails.Execute("SELECT Def1, Def2 FROM OtherOrders WHERE Reference=" & right(jobid, len(jobid)-3))

		dim JobSubject, JobDescription
		if not JobDetails.eof then
			JobSubject = " " & """" & JobDetails("Def2") & """"
			JobDescription = "<br /><br /> " & JobDetails("Def1")
		end if
				
		GetJobDetails.Close
		Set JobDetails = nothing
		Set GetJobDetails = nothing
		

		
		if len(resumeWho) = 0 then
			msgBody = "A " & uploadTitle & " has been uploaded for Job ID: <b style=""color:red"">" & jobid & "</b>" & JobDescription
	
			msgSubject = pcase(ruploadTitle) & " received from " & resumeCity & ", " & resumeState & " " & resumeZip &_
				" interested in Job ID: " & jobid & JobSubject

		else
			msgBody = resumeWho & " uploaded a " & uploadTitle & " for Job ID: <b style=""color:red"">" & jobid & "</b>" & JobDescription
		
			msgSubject = resumeWho & " uploaded a " & uploadTitle & " for Job ID: " & jobid & JobSubject

			'break len(msgSubject)'msgSubject = "A resume for " & resumeWho & " was received from " & resumeCity & ", " & resumeState & " " & resumeZip
		end if
	else
		if len(resumeWho) = 0 then
			msgBody = "A " & pcase(uploadTitle) & " from " & resumeCity & ", " & resumeState & " " & resumeZip
			msgSubject = pcase(uploadTitle) & " received from " & resumeCity & ", " & resumeState & " " & resumeZip

		else
			msgBody = resumeWho & " uploaded a " & uploadTitle & " for " & resumeCity & ", " & resumeState & " " & resumeZip
			msgSubject = resumeWho & " uploaded a " & uploadTitle & "."

			'break len(msgSubject)'msgSubject = "A resume for " & resumeWho & " was received from " & resumeCity & ", " & resumeState & " " & resumeZip
		end if
	end if
	
	msgBody = msgBody &_
		"<br /><br />" & pcase(replace(uploadThis, "/", "")) & " was uploaded on " & now() & "<br />" &_
		"The file name is: " & FileName & "<br />" &_
		pcase(uploadTitle) & "s are delivered to the 'Received' folder located here: &lt;" & ThisFilePath & "&gt;<br />"

	if len(deliveryLocation) = 0 then
		Set dbQuery = Database.Execute("Select email From list_zips Where zip='" & resumeZip & "'")
		if Not dbQuery.eof then
			deliveryLocation = dbQuery("email")
		Else
			deliveryLocation = "twin@personnel.com"
		end if
	end if
	
	Call SendEmail (deliveryLocation, system_email, msgSubject, "<send_as_html>" & msgBody, "")
 

    ' Now the file in the uploads dir can be deleted
    'fso.DeleteFile ThisFile
    
    ' Destroy FileSystemObject, Free memory
	set fso = nothing
	On Error Goto 0
	
	dim home_message, rtemp
	if instr(uploadThis, "timecard") > 0 then  

		response.redirect("/userHome.asp?ast=ts")
		
	elseif instr(uploadTitle, "drug test") > 0 then 
	
		call set_session("homeMessageHeading", "Drug Test Seizure Successful")
		response.redirect("/userHome.asp?ast=ds")
	
	end if
	
	
	' response.redirect"/include/system/tools/upload/upload.asp?func=3"


Case 3

	print  request.ServerVariables("SCRIPT_NAME")
	rtemp = set_session("homeMessageHeading", "Resume Submitted")
	response.redirect("/userHome.asp")
End select %>
