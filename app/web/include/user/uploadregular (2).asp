<!-- #INCLUDE VIRTUAL='/include/core/html_header.asp' -->
<!-- #INCLUDE VIRTUAL='/include/core/html_styles.asp' -->
<!-- Revised: 12.1.2008 -->
<style type="text/css">
.createAccount table {width:100%;margin:35px 0 50px 0}
.createAccount table tr td {width:50%;text-align:center}
.createAccount div table tr td a span {display:block;text-align:center}
</style>
<!-- #INCLUDE VIRTUAL='/include/core/navi_top_menu.asp' -->
	<%
Response.Expires = -1000 'Makes the browser not cache this page
Response.Buffer = true 'Buffers the content so our Response.Redirect will work

session("SignedIn") = false

%>
  <style type="text/css">
p {margin:.75em 1em 1.5em}

input
{
text-align:right
color: #003466;
border: 1px solid #97A4B3;
padding: .2em .2em .2em;
margin-bottom:1em;
height:2.5em;
background:url('/include/style/images/normalTitleBackground.gif') repeat-x bottom;
}
fieldset
{
border: none;
margin: 0 1em 1em;
width: auto;
}

fieldset ul {
display:block;
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

#resumeupload ul li {width:18em; height:3em; display:block; vertical-align:middle;}
#resumeupload label, #PersonalInformation input {width:16.5em}


</style>
  <%
dim objFileSys
dim TheTextStream
dim path
dim S3Temp(1,1)

Function GetField(key)
	s1=InStr(strDataWhole, key)
	s2=InStr(s1+2, strDataWhole, "¬|")
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
    <FORM ENCTYPE="multipart/form-data" METHOD=post id="form1" name="form1" action="/include/user/uploadregular.asp?func=2">
   <fieldset id="resumeupload">
      <ul><li><label for="File1">Select your resume to upload</label>
	  <INPUT NAME=File1 SIZE=35 TYPE=file></li></ul>
      <input type="hidden" value="Submit Resume" STYLE="background:#dc143c; border:1 #333333 solid; font-size:10px; color:#FFFFFF;">
      &nbsp;
      <!--	<input type="reset" value="Reset" STYLE="background:##dc143c; border:1 #333333 solid; font-size:9px; color:#FFFFFF;" onClick="javascript:document.emailresume.reset();"> -->
      </p></fieldset>
    </form>
  </div>
  <div class="bb">
    <div>
      <div></div>
    </div>
</div>
  <div class="buttonwrapper" style="padding:10px 0 10px 0;"> <a class="squarebutton" href="javascript:document.form1.submit();" style="margin-left: 6px" onClick="document.form1.submit();"><span>Upload Resume</span></a> <a class="squarebutton" href="/userHome.asp" onClick="history.back();"><span>Return</span></a> 
  <!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
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
    lngBoundryPos = instr(1,strBoundry,"boundary=") + 8 
    strBoundry = "--" & right(strBoundry,len(strBoundry)-lngBoundryPos)
    
    'Get first file boundry positions.
    lngCurrentBegin = instr(1,strDataWhole,strBoundry)
    lngCurrentEnd = instr(lngCurrentBegin + 1,strDataWhole,strBoundry) - 1

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
    				Set f = fso.OpenTextFile(server.mappath("/seekers/new/emailresume/uploads") & "\" & FileName, ForWriting, True)
    					f.Write strFileData
    
						' Get full Path, you need it for deleting the file later  	
    					dim ThisFile
    				ThisFile = server.MapPath("/seekers/new/emailresume/uploads") & "/" & filename
    
       			lngNumberUploaded = lngNumberUploaded + 1
    		
    		' destroy f, free memory
  		    set f = nothing
   			
		'Get then next boundry postitions if any
   		lngCurrentBegin = instr(1,strDataWhole,strBoundry)
	    lngCurrentEnd = instr(lngCurrentBegin + 1,strDataWhole,strBoundry) - 1
loop

' // CDO Email the resume to Personnel Inc.

'dim cdoConfig,cdoMessage,msgBody
'sch = "http://schemas.microsoft.com/cdo/configuration/"
'Set cdoConfig = Server.CreateObject("CDO.Configuration")

'With cdoConfig.Fields 
'      .Item(sch & "sendusing") = 2 ' cdoSendUsingPort 
'      .Item(sch & "smtpserver") = "127.0.0.1" 
'      .update 
'End With 

'Set cdoMessage = Server.CreateObject("CDO.Message") 

'Set the Body

	
Database.Open MySql
	Set region = Database.Execute("Select address, city, state, zip From tbl_addresses Where " & addressId)

msgBody = "Personnel Plus - Resume For: " & region("city") & ", " & region("state") & " " & region("zip") & chr(10) & chr(10)
msgBody = msgBody & "Date/Time of Application:" & " " & now() & chr(10) & chr(10)

dim emailAddress : emailAddress = request.cookies("applyDirect")("emailAddress")
dim emailToAddress : emailToAddress = request.cookies("applyDirect")("emailToAddress")
dim txt_Subject : txt_Subject = "Personnel Plus - Resume For " & region("city") & ", " & region("state") & " " & region("zip")
Database.Close

' ---- / aspSmartMail ----
'	On error resume next

	dim mySmartMail
	Set mySmartMail = Server.CreateObject("aspSmartMail.SmartMail")

'	-- Mail Server
	mySmartMail.Server = "127.0.0.1"
'	mySmartMail.ServerPort = 25

	mySmartMail.ServerTimeOut = 35
	
'	-- From
'	mySmartMail.SenderName = "Your Name"
	mySmartMail.SenderAddress = "resumes@personnel.com"
	
'	-- To
	mySmartMail.Recipients.Add "resumes@personnel.com", "Resume Delivery"

'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"

'	-- Blind carbon copy
'	mySmartMail.BCCs.Add "ghaner@personnel.com", ""
	
'	-- Reply To
'	mySmartMail.ReplyTos.Add "webmaster@personnelplus-inc.com", "Personnel Plus Webmaster"

'	-- Message
	mySmartMail.Subject = txt_Subject
	mySmartMail.Body = msgBody

'	-- Optional Parameters
	mySmartMail.Organization = "Personnel Plus Inc"
'	mySmartMail.XMailer = "Your Web App Name"
	mySmartMail.Priority = 3
	mySmartMail.ReturnReceipt = false
	mySmartMail.ConfirmRead = false
	mySmartMail.ContentType = "text/plain"
	mySmartMail.Charset = "us-ascii"
	mySmartMail.Encoding = "base64"

'	-- Attached file
	mySmartMail.Attachments.Add ThisFile,, false
' Server.MapPath("\aspSmartMail\sample.txt")	
' ThisFile
'	-- Send the message
	mySmartMail.SendMail

'	-- Error handling
	if err.number <> 0 then
		response.write("Error n° " &  err.number - vbobjecterror & " = " & err.description  & "<br>")
	else
'		response.write "aspSmartMail has sent your message with this file as attachment : <br>"
'		response.write mySmartMail.Attachments.Item(1).FilePathName
	end if

	set mySmartMail = nothing
' ---- aspSmartMail / ----


' ====================
'With cdoMessage 
'  Set .Configuration = cdoConfig
'      .From = emailAddress
'      .To = emailToAddress
'      .To = "saguilar@personnel.com"
'     .Cc = emailAddress
'      .BCC = "saguilar@personnel.com"
'      .TextBody = msgBody
'	  .AddAttachment ThisFile
'      .Subject = txt_Subject
'      .Send 
'End With 

'Set cdoMessage = Nothing 
'Set cdoConfig = Nothing 
' ========================

    ' Now the file in the uploads dir can be deleted
    fso.DeleteFile ThisFile
    
    ' Destroy FileSystemObject, Free memory
    set fso = nothing
	
	response.redirect"/user/uploadregular.asp?func=3"        		


		case 3

%>

<div id="resumeReceivedConfirmation" class="clearfix">
<div class="tb">
  <div>
    <div></div>
  </div>
</div>
<div class="mb clearfix">
  <h4> Resume Received </h4>

  <strong> Thank you for keeping us updated!</strong>
  <p>Your resume has been placed into our applicant pool database so that we can better find you and match you up with job oppurtunities that meet your key quilifications and interests!</p>
  <p>Please remember to keep your application with us current and up to date, we only keep applications and resumes on file for 180 days.</p>
  <p>Feel free to contact your nearest <a href="/include/content/contact.asp"><strong>office location</strong></a> if you have any additional questions.</p>
  <p></p>
  <p>- Personnel Plus</p>
</div>
<div class="bb">
  <div>
    <div></div>
  </div>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
<% end select %>
