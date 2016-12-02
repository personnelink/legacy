<%Option Explicit%>
<!-- #INCLUDE VIRTUAL='/vms/include/core/init_secure_session.asp' -->
    <!-- Revised: 12.17.2008 -->
    <style type="text/css">
p {margin:.75em 1em 1.5em}

input
{
text-align:right
color: #003466;
border: 1px solid #C7D2E0;
padding: .2em .2em .2em;
margin-bottom:1em;
height:2.5em;
background:url('/vms/include/style/images/normalTitleBackground.gif') repeat-x bottom;
}
fieldset
{
border: none;
margin: 0 1em 1em;
width: auto;
}

fieldset ul {
display:inline;
float:left; 
clear:both;
margin:0 auto 1em;
}

fieldset li {display: block;clear: right;float:left;
}

label
{
float: left;
text-align: left;
margin-right: 0.5em;
display: block
}
p, label {color:#003466}

#resumeupload ul li {width:30em;display:inline; vertical-align:left;}
#resumeupload label, #resumeupload input {width:28em}

#zipcode {width:10px;color:red;height:1.5em;}

</style>
    <%
' Start attachment save and send.
	
	response.buffer=true
    Func = Request("Func")
    	
	if isempty(Func) then
    		Func = 1
	end if

    Select case Func
		case 1
%>
    <div id="uploadResumeForm" class="clearfix">
      <div class="tb">
        <div>
          <div></div>
        </div>
      </div>
      <div class="mb clearfix">
        <h4> Upload My Current Resume </h4>
        <% if request("error") = "50" then %>
        <p>Please select your resume...</p>
        <% end if %>
        <form enctype="multipart/form-data" method=post id="form1" name="form1" action="/vms/tools/emailResume.asp?func=2">
          <fieldset id="resumeupload">
          <ul>
            <li>
              <label for="File1">Select your resume to upload</label>
              <input name="File1" size="35" type=file>
            </li>
            <li>
              <label for="zipcode">In what zip code region are you looking for work?</label>
              <input name="zipcode" type="text" style="width:15em;height:1.5em;" value"<%=user_zip%>">
            </li>
          </ul>
          <input type="hidden" value="Submit Resume">
          &nbsp;
          </fieldset>
        </form>
      </div>
      <div class="bb">
        <div>
          <div></div>
        </div>
      </div>
      <div class="buttonwrapper" style="padding:10px 0 10px 0;"> <a class="squarebutton" href="javascript:document.form1.submit();" style="margin-left: 6px" onclick="document.form1.submit();"><span>Upload Resume</span></a> <a class="squarebutton" href="/vms/userHome.asp" onclick="history.back();"><span>Return</span></a> </div>
      <!-- End of Site content -->
    </div>
    <!-- #INCLUDE VIRTUAL='/vms/include/core/pageFooter.asp' -->
<%
		case 2
			ForWriting = 2
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
    
    'Creates a raw data file for with all data sent. Uncomment for debuging.	
    	'Set fso = CreateObject("Scripting.FileSystemObject")
    	'Set f = fso.OpenTextFile(server.mappath(".") & "\raw.txt", ForWriting, True)
    	'f.Write strDataWhole
    	'set f = nothing
    	'set fso = nothing
    
    'get the boundry indicator
    strBoundry = Request.ServerVariables ("HTTP_CONTENT_TYPE")
    if len(strBoundry) >0 then
		lngBoundryPos = instr(1,strBoundry,"boundary=") + 8 
    	strBoundry = "--" & right(strBoundry,len(strBoundry)-lngBoundryPos)
    
    	'Get first file boundry positions.
    	lngCurrentBegin = instr(1,strDataWhole,strBoundry)
    	lngCurrentEnd = instr(lngCurrentBegin + 1,strDataWhole,strBoundry) - 1
	end if

do while lngCurrentEnd > 0
			'Get the data between current boundry and remove it from the whole.
			strData = mid(strDataWhole,lngCurrentBegin, lngCurrentEnd - lngCurrentBegin)
				strDataWhole = replace(strDataWhole,strData,"")
    			
			'Get the full path of the current file.
    		lngBeginFileName = instr(1,strdata,"filename=") + 10
    			lngEndFileName = instr(lngBeginFileName,strData,chr(34)) 
    
			'Make sure they selected at least one file.	
    		if lngBeginFileName = lngEndFileName and lngNumberUploaded = 0 then
    	
    			response.write "<h2> The following error occured.</h2>"
    			response.write "You must select a resume to upload"
    			response.write "<br><br>Hit the back button, make the needed corrections and resubmit your information."
    			response.write "<br><br><input type='button' onclick='history.go(-1)' value='<< Back' id='button'1 name='button'1>"
    			Response.End 
    	
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
    				tmpLng = instr(PrevPos + 1,strFilename,"\")
    			loop
    		
    				FileName = right(strFilename,len(strFileName) - PrevPos)
    	
			'Get the begining position of the file data sent.
			'if the file type is registered with the browser then there will be a Content-Type
    			lngCT = instr(1,strData,"Content-Type:")
    	
    				if lngCT > 0 then
    					lngBeginPos = instr(lngCT,strData,chr(13) & chr(10)) + 4
    						
    						else
    			 				lngBeginPos = lngEndFileName
    				end if
    
			'Get the ending position of the file data sent.
    		lngEndPos = len(strData) 
    		
			'Calculate the file size.	
    		lngDataLenth = lngEndPos - lngBeginPos
				'Get the file data	
    			strFileData = mid(strData,lngBeginPos,lngDataLenth)
				
				' Create the file, change the path to the path U use for temp storage of the file
				' make sure you have the IUSR_YOURCOMPUTER granted WRITE access to the uploads dir
    			Set fso = CreateObject("Scripting.FileSystemObject")
    				Set f = fso.OpenTextFile(server.mappath("\pdfServer\pdfApplication\generated") & "\" & FileName, ForWriting, True)
    					f.Write strFileData
    
						' Get full Path, you need it for deleting the file later  	
    					dim ThisFile
    				ThisFile = server.MapPath("\pdfServer\pdfApplication\generated") & "\" & filename
    
       			lngNumberUploaded = lngNumberUploaded + 1
    		
    		' destroy f, free memory
  		    set f = nothing
   			
		'Get then next boundry postitions if any
   		lngCurrentBegin = instr(1,strDataWhole,strBoundry)
	    lngCurrentEnd = instr(lngCurrentBegin + 1,strDataWhole,strBoundry) - 1
loop

	Database.Open dbProvider
	dim msgSubject, msgBody, zipcode
	dim resumeCity, resumeState, resumeZip
	
	Set region = Database.Execute("Select address, city, state, zip From tbl_addresses Where addressID=" & addressId)
	resumeCity = region("city")
	resumeState = region("state")
	resumeZip = region("zip")
	
	msgBody = "Personnel Plus - Resume For: " & resumeCity & ", " & resumeState & " " & resumeZip & chr(10) & chr(10)
	msgBody = msgBody & "This resume was submitted:" & " " & now() & chr(10) & chr(10)
	msgSubject = "Personnel Plus - Resume For " & resumeCity & ", " & resumeState & " " & resumeZip

	dim mySmartMail, deliveryLocation
	
	Set dbQuery = Database.Execute("Select email From list_zips Where zip=" & resumeZip)
	if Not dbQuery.eof then
		deliveryLocation = dbQuery("email")
	Else
		deliveryLocation = "twinfalls@personnel.com"
	end if

	Set mySmartMail = Server.CreateObject("aspSmartMail.SmartMail")
	With mySmartMail
		.Server = "127.0.0.1"
		.ServerTimeOut = 35
		.Organization = "Personnel Plus Inc."
		.ReturnReceipt = true
		.ConfirmRead = false
		.XMailer = "emailResumeApplication"
		.SenderName = "Personnel Plus Online - Resume Delivery"
		.SenderAddress = system_email
		.Recipients.Add deliveryLocation, "Branch Resume Delivery"
		.Subject = msgSubject
		.Body = msgBody
		.Organization = "Personnel Plus Inc"
		.Priority = 3
		.ContentType = "text/plain"
		.Charset = "us-ascii"
		.Encoding = "base64"
		.Attachments.Add ThisFile,, false
	End With
	mySmartMail.SendMail


'	-- Error handling
	if err.number <> 0 then
		response.write("Error n° " &  err.number - vbobjecterror & " = " & err.description  & "<br>")
	end if

	set mySmartMail = nothing

    ' Now the file in the uploads dir can be deleted
    fso.DeleteFile ThisFile
    
    ' Destroy FileSystemObject, Free memory
    set fso = nothing
	response.redirect"/vms/tools/emailResume.asp?func=3"        		

Case 3
	session("homeMessageHeading") = "Resume Submitted"
	session("homeMessageBody") = "<strong> Thank you for keeping us updated!</strong>" &_
		"<p>Your resume has been placed into our applicant pool database so that we can better find you and match you up with job oppurtunities that meet " &_
		"your key quilifications and interests!</p><p>Please remember to keep your application with us current and up to date, we only keep applications and " &_
		"resumes on file for 180 days.</p><p>Feel free to contact your nearest <a href='/include/content/contact.asp'><strong>office location</strong></a>" &_
		"if you have any additional questions.</p><p></p><p>- Personnel Plus</p>"
	Response.Redirect("/vms/userHome.asp")
End select %>
