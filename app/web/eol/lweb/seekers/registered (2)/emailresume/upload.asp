<!-- #INCLUDE VIRTUAL='/lweb/inc/dbConn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<%

If session("auth") = "true" then

' vars used to handle direction of resume
if request("officeSelector") <> "" then
session("targetOffice") = request("officeSelector")
else session("targetOffice") = "twin@personnel.com"
end if

Set rsPersonalProfile = Server.CreateObject("ADODB.Recordset")
rsPersonalProfile.Open "SELECT seekID,firstName,lastName,addressOne,addressTwo,city,state,zipCode,country,contactPhone,userName,password,emailAddress,numResumes,suspended,dateCreated FROM tbl_seekers WHERE userName ='" & session("userName") & "'", Connect, 3, 3

Set rsPreferences = Server.CreateObject("ADODB.Recordset")
rsPreferences.Open "SELECT seekID,userName,schedule,shift,wageType,wageAmount,qRelocate,relocateAreaOne,relocateAreaTwo,relocateAreaThree,commuteDist,workLegalStatus,workLegalProof,dateCreated FROM tbl_seekers_preferences WHERE seekID ='" & session("seekID") & "'", Connect, 3, 3
 Else
	response.redirect("/index.asp")
End If

%>
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
<!-- INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<!--meta http-equiv="Content-Type" content="text/html; charset=windows-1252"-->
<title>Upload your Resume...</title>
</head>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
<TABLE WIDTH=75% BORDER=0 CELLPADDING=0 CELLSPACING=4 bgcolor="#dcbace">  
	 <tr>
		<td align="center" style="border:1px solid #dcbace;">
			<% if request("error") = "50" then %>
				Please select your resume...<br>
			<% end if %>
		</td>
	</tr>
	 <tr>
		<td align="center" style="border:1px solid #dcbace;">
    		<FORM ENCTYPE="multipart/form-data" METHOD=post id=form1 name=form1 action="/lweb/seekers/registered/emailresume/upload.asp?func=2">
    			<br><br>
				Upload your Resume:&nbsp;<INPUT NAME=File1 SIZE=30 TYPE=file><br><br>
				<input type="submit" value="Email Resume" STYLE="background:#4682b4; border:1 #000000 solid; font-size:9px; color:#FFFFFF;">&nbsp;
				<input type="reset" value="Reset" STYLE="background:#4682b4; border:1 #000000 solid; font-size:9px; color:#FFFFFF;" onClick="javascript:document.emailresume.reset();"></p>
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
    					End If
    
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
    	
    			Response.Write "<h2> The following error occured.</h2>"
    			Response.Write "You must select at least one file to upload"
    			Response.Write "<br><br>Hit the back button, make the needed corrections and resubmit your information."
    			Response.Write "<br><br><input type='button' onclick='history.go(-1)' value='<< Back' id='button'1 name='button'1>"
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
    				Set f = fso.OpenTextFile(server.mappath("/seekers/registered/emailresume/uploads") & "\" & FileName, ForWriting, True)
    					f.Write strFileData
    
						' Get full Path, you need it for deleting the file later  	
    					Dim ThisFile
    				ThisFile = server.MapPath("/seekers/registered/emailresume/uploads") & "/" & filename
    
       			lngNumberUploaded = lngNumberUploaded + 1
    		
    		' destroy f, free memory
  		    set f = nothing
   			
		'Get then next boundry postitions if any
   		lngCurrentBegin = instr(1,strDataWhole,strBoundry)
	    lngCurrentEnd = instr(lngCurrentBegin + 1,strDataWhole,strBoundry) - 1
loop

' // CDO Email the resume to Personnel Inc.

dim cdoConfig,cdoMessage,msgBody
sch = "http://schemas.microsoft.com/cdo/configuration/"
Set cdoConfig = Server.CreateObject("CDO.Configuration")

With cdoConfig.Fields 
      .Item(sch & "sendusing") = 2 ' cdoSendUsingPort 
      .Item(sch & "smtpserver") = "127.0.0.1"
      .Item(sch & "smtpserverport") = 25	  
      .update 
End With 

Set cdoMessage = Server.CreateObject("CDO.Message") 

'Set the Body
msgBody = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">" & vbCrLf _
		& "<html>" & vbCrLf _
		& "<head>" & vbCrLf _
		& " <title>Email Resume</title>" & vbCrLf _
		& " <meta http-equiv=Content-Type content=""text/html; charset=iso-8859-1"">" & vbCrLf _
		& "</head>" & vbCrLf _
		& "<body bgcolor=""#FFFF99"">" & vbCrLf _
		& " <h2>Email Resume</h2>" & vbCrLf _
		& " <p>" & vbCrLf _
		& session("lastName") & ",&nbsp;" & session("firstName") & "<BR>" & vbCrLf _
		& "Resume File: " & ThisFile & "<BR>" & vbCrLf _
		& "  </p>" & vbCrLf _
		& "</body>" & vbCrLf _
		& "</html>" & vbCrLf

With cdoMessage 
  Set .Configuration = cdoConfig
	  .From = session("emailAddress")
'	  .To = "saguilar@personnel.com"
	  .To = session("targetoffice")
	  .Cc = session("emailAddress")
	  .Bcc = "saguilar@personnel.com"
      .HtmlBody = msgBody
	  .AddAttachment ThisFile
      .Subject = "Personnel Plus - Email Resume" & " " & session("lastName") & ", " & session("firstName")
      .Send 
End With 

Set cdoMessage = Nothing 
Set cdoConfig = Nothing 


    ' Now the file in the uploads dir can be deleted
    fso.DeleteFile ThisFile
    
    ' Destroy FileSystemObject, Free memory
    set fso = nothing
        		
			if session("state") = "ID" then
				'is IDAHO resident
				response.redirect("/lweb/seekers/registered/index.asp?who=2&resVal=Yes&resType=int&success=1")
			else
				' not a Idaho resident
				response.redirect("/lweb/seekers/registered/index.asp?who=2&resVal=Yes&resType=ext&success=1")
			end if

    		'Response.Write "Uw mail is verstuurd!</h2>"
    		'Response.Write "<br><br><input type='button' onclick='document.location=" & chr(34) & "sendmail.asp" & chr(34) & "' value='<< Back' id='button'1 name='button'1>"	 						
    	    	
end select	
  
%>    
			</form>
		</td>
	</tr>
</TABLE>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
</BODY>
</HTML>