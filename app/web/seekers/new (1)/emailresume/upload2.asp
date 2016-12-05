<html>
<head>
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
<!-- INCLUDE VIRTUAL='/inc/head.asp' -->
<!--meta http-equiv="Content-Type" content="text/html; charset=windows-1252"-->
<title>Upload your Resume...</title>
</head>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
<TABLE WIDTH=80% BORDER=0 CELLPADDING=0 CELLSPACING=0 bgcolor="#f5f5dc">  
	 <tr>
		<td align="center" style="border:1px solid #333333;">
			<% if request("error") = "50" then %>
				Please select your resume...<br>
			<% end if %>
		</td>
	</tr>
	 <tr>
		<td align="center" style="border:1px solid #333333;">
    		<FORM ENCTYPE="multipart/form-data" METHOD=post id=form1 name=form1 action="/seekers/new/emailresume/upload2.asp?func=2">
    			<br><br>
				<strong>Upload a resume:</strong>&nbsp;<INPUT NAME=File1 SIZE=35 TYPE=file><br><br>
		<strong><font color="#dc143c">Step 4:</font></strong>
		<input type="submit" value="Submit Resume" STYLE="background:#dc143c; border:1 #333333 solid; font-size:10px; color:#FFFFFF;">&nbsp;
			<!--	<input type="reset" value="Reset" STYLE="background:##dc143c; border:1 #333333 solid; font-size:9px; color:#FFFFFF;" onClick="javascript:document.emailresume.reset();"> --> 
</p>
			</form>
		</td>
	</tr>
</TABLE>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
</BODY>
</HTML>
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

msgBody = "Personnel Plus - Direct Online Application" & chr(10) & chr(10)
IF TRIM(job_wanted) <> "" then
msgBody = "Position of Interest: " & job_wanted & chr(10) & chr(10)
end if
msgBody = msgBody & request.cookies("applyDirect")("firstName") & " " & request.cookies("applyDirect")("lastName") & chr(13)
msgBody = msgBody & request.cookies("applyDirect")("addressOne") & chr(13)
if request.cookies("applyDirect")("addressTwo") <> "" then 
msgBody = msgBody & request.cookies("applyDirect")("addressTwo") & chr(13) 
end if
msgBody = msgBody & request.cookies("applyDirect")("city") & ", " & request.cookies("applyDirect")("state") & " " & request.cookies("applyDirect")("zipCode") & chr(13)
if request.cookies("applyDirect")("contactPhone") <> "" then 
msgBody = msgBody & request.cookies("applyDirect")("contactPhone") & chr(13) 
end if
if request.cookies("applyDirect")("emailAddress") <> "" then 
msgBody = msgBody & request.cookies("applyDirect")("emailAddress") & chr(13) 
end if
if request.cookies("applyDirect")("preferred") <> "" then
msgBody = msgBody & "****************************< PREFERRED POSITION AND COMPANY >************************" & chr(13)
msgBody = msgBody & request.cookies("applyDirect")("preferred") & chr(13)
msgBody = msgBody & "**************************************************************************************" & chr(13)
end if
msgBody = msgBody & chr(10) & chr(10)
if request.cookies("applyDirect")("desiredWageAmount") <> "" then 
msgBody = msgBody & "Desired Salary/Wage:" & " " & request.cookies("applyDirect")("desiredWageAmount") & chr(13) 
end if
if request.cookies("applyDirect")("minWageAmount") <> "" then 
msgBody = msgBody & "Minimum Salary/Wage:" & " " & request.cookies("applyDirect")("minWageAmount") & chr(13) 
end if
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "JOB OBJECTIVES / SUMMARY:" & chr(13) & request.cookies("applyDirect")("jobObjective") & chr(10) & chr(10)
msgBody = msgBody & "I am 18 years or older:" & " " & request.cookies("applyDirect")("workAge") & chr(13)
msgBody = msgBody & "Relocating?" & " " & request.cookies("applyDirect")("workRelocate") & chr(13)
if request.cookies("applyDirect")("workValidLicense") <> "" then
msgBody = msgBody & "I have a valid drivers license" & chr(13)
end if
if request.cookies("applyDirect")("workLicenseType") <> "" then
msgBody = msgBody & "I have a" & " " & request.cookies("applyDirect")("workLicenseType") & " " & "license" & chr(13)
end if
msgBody = msgBody & "Convicted of a felony:" & " " & request.cookies("applyDirect")("workConviction") & chr(13)
if request.cookies("applyDirect")("workConvictionExplain") <> "" then
msgBody = msgBody & "Explaination of felony:" & " " & request.cookies("applyDirect")("workConvictionExplain") & chr(13)
end if


msgBody = msgBody & "I'd prefer" & " " & request.cookies("applyDirect")("workTypeDesired") & " " & "work." & chr(13)
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & chr(10) & chr(10)
if request.cookies("applyDirect")("referenceNameOne") <> "" or request.cookies("applyDirect")("referenceNameTwo") <> "" or request.cookies("applyDirect")("referenceNameThree") <> "" then
msgBody = msgBody & "WORK REFERENCES:" & chr(13)
msgBody = msgBody & request.cookies("applyDirect")("referenceNameOne") & " " & request.cookies("applyDirect")("referencePhoneOne") & chr(13)
msgBody = msgBody & request.cookies("applyDirect")("referenceNameTwo") & " " & request.cookies("applyDirect")("referencePhoneTwo") & chr(13)
msgBody = msgBody & request.cookies("applyDirect")("referenceNameThree") & " " & request.cookies("applyDirect")("referencePhoneThree") & chr(13)
end if
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "LEVEL OF EDUCATION:" & " " & request.cookies("applyDirect")("eduLevel") & chr(13)
msgBody = msgBody & chr(10) & chr(10)
msgBody = msgBody & "ADDITIONAL INFORMATION:" & " " & request.cookies("applyDirect")("additionalInfo") & chr(10) & chr(10)
msgBody = msgBody & "Date/Time of Application:" & " " & now() & chr(10) & chr(10)


dim emailAddress : emailAddress = request.cookies("applyDirect")("emailAddress")
dim emailToAddress : emailToAddress = request.cookies("applyDirect")("emailToAddress")
dim txt_Subject : txt_Subject = "Personnel Plus - Direct Email Application: " & request.cookies("applyDirect")("lastName") & ", " & request.cookies("applyDirect")("firstName")

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
	mySmartMail.SenderAddress = emailAddress
	
'	-- To
	mySmartMail.Recipients.Add emailToAddress, emailToAddress
'	mySmartMail.Recipients.Add "yourfriend1@anydomain.com", "Friend1's name"

'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"

'	-- Blind carbon copy
	mySmartMail.BCCs.Add "ghaner@personnel.com", ""
	mySmartMail.BCCs.Add "tmayer@personnel.com", ""
'	mySmartMail.BCCs.Add "jwerrbach@cableone.net", ""
	
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
	
	response.redirect"/seekers/new/emailresume/upload2.asp?func=3"        		


		case 3
%>
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<TITLE><%=request.cookies("applyDirect")("firstName")%>&nbsp;<%=request.cookies("applyDirect")("lastName")%>, Welcome to Personnel Plus!</TITLE>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
</HEAD>

<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->

<TABLE width="90%" BORDER="0" CELLPADDING="2" CELLSPACING="2" BGCOLOR="#ffffff">
	<TR>
		<TD>
		<!-- greeting start -->

Your application was sent directly to the Personnel Plus office closest to   <%=request.cookies("applyDirect")("city")%>,&nbsp;<%=request.cookies("applyDirect")("state")%>!
<p></p>
Please allow up to two full business days for us to review your information.
<br>
You will then be contacted either via email <strong><%=request.cookies("applyDirect")("emailAddress")%></strong> <%if TRIM(Request.cookies("applyDirect")("contactPhone")) <> "" then %> and/or by phone <strong><%=request.cookies("applyDirect")("contactPhone")%></strong>  <% End if %> to arrange a convenient time to complete your application with us in person.
<p></p>
<%if TRIM(request.cookies("applyDirect")("emailAddress")) <> "" then %>
For your records, a copy of your application has also been sent to your email address. It is not necessary to send multiple online applications. Once you've completed our entire application process, we may have many different job openings for you to consider depending on your individual skills.
<% end if %>
<p></p>
Feel free to contact your local Personnel Plus <a href="/company/offices.asp"><strong>Office</strong></a> if you have any additional questions.
<p></p>
Thank you <%=request.cookies("applyDirect")("firstName")%>, we look forward to meeting with you soon!
<p></p>
<%%>


- The
<% Select Case session("targetOffice") %>
<% Case "boise@personnel.com" %>
Boise
<% Case "burley@personnel.com" %>
Burley
<% Case "nampa@personnel.com" %>
Nampa
<% Case "twin@personnel.com" %>
Twin Falls
<% End Select %>
Personnel Plus Staff

		</TD>
	</TR>
</TABLE>


<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
</BODY>
</HTML>
<% end select %>