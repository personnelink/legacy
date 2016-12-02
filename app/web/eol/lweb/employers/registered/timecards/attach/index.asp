<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
	<% if session("employerAuth") <> "true" then response.redirect("/lweb/index2.asp") end if%>
	<%
		dim sqlLocation,rsLocation,rsTotalListings,rsTotalApps,rsJobListings
		' get states and provinces
		sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
		set rsLocation = Connect.Execute(sqlLocation)
		' count job listings
		Set rsTotalListings = Connect.Execute("SELECT count(companyUserName) AS listingsCount FROM tbl_listings WHERE companyUserName = '" & session("companyUserName") & "'")
		' count job applications
		Set rsTotalApps = Connect.Execute("SELECT count(companyUserName) AS appsCount FROM tbl_applications WHERE companyUserName = '" & session("companyUserName") & "'")
		' get employer job listings
		set rsJobListings = Server.CreateObject("ADODB.RecordSet")
		rsJobListings.Open "SELECT jobID, empID, jobTitle, jobStatus, viewCount, dateCreated FROM tbl_listings WHERE companyUserName = '" & session("companyUserName") & "' ORDER BY dateCreated DESC",Connect,3,3
		' get employer profile
		set rsEmployerProfile = Server.CreateObject("ADODB.RecordSet")
		rsEmployerProfile.Open "SELECT * FROM tbl_employers WHERE empID = '" & session("empID") & "'",Connect,3,3
	 %>
<html>
<head>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<meta http-equiv="Content-Language" content="en-us">
<title>Submit your Time Cards...</title>
</head>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/advertise/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->

<%

response.cookies("timecards")("time") = now

dim cdoConfig,cdoMessage,msgBody

' Start attachment save and send.
	
	response.buffer=true
    Func = Request("Func")
    	
	if isempty(Func) then
    		Func = 1
	end if

    Select case Func
		case 1
%>
<TABLE WIDTH=750 BORDER=0 CELLPADDING=0 CELLSPACING=0 bgcolor="#dcbace">
    <FORM ENCTYPE="multipart/form-data" METHOD=post id=form1 name=form1 action="/lweb/employers/registered/timecards/attach/index.asp?func=2"> 
		<tr>
			<td align="center" style="border:1px solid #dcbace;">
    			Make sure that you have filled out the time card sheet completely, and have approved all time issued.<br>
    			<br>After you have verified the time card sheet and approve all time, scan the time card into a<br>JPG or BMP
    			file.  Once you have the file, select your time card and click "Email Time Card" to send.<br><br>
				<table border="0" width="700" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center"><INPUT NAME=File1 SIZE=30 TYPE=file></td>
					</tr>
				</table>
				<br>
				<input type="submit" value="Email Time Card" STYLE="background:#4682b4; border:1 #000000 solid; font-size:9px; color:#FFFFFF;">&nbsp;
				<input type="reset" value="Reset" STYLE="background:#4682b4; border:1 #000000 solid; font-size:9px; color:#FFFFFF;" onClick="javascript:document.emailresume.reset();"></p>
			</td>
		</tr>
	</form>
</TABLE>
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
    			Response.Write "You must select at least one time card to upload"
    			Response.Write "<br><br>Hit the back button, make the needed corrections and resubmit your information."
    			Response.Write "<br><br><input type='button' onclick='/employers/registered/timecards/attach/index.asp?func=1' value='<< Back' id='button'1 name='button'1>"
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
    				Set f = fso.OpenTextFile(server.mappath("/employers/registered/timecards/uploads") & "\" & FileName, ForWriting, True)
    					f.Write strFileData
    
						' Get full Path, you need it for deleting the file later  	
    					Dim ThisFile
    				ThisFile = server.MapPath("/employers/registered/timecards/uploads") & "/" & filename
    
       			lngNumberUploaded = lngNumberUploaded + 1
    		
    		' destroy f, free memory
  		    set f = nothing
   			
		'Get then next boundry postitions if any
   		lngCurrentBegin = instr(1,strDataWhole,strBoundry)
	    lngCurrentEnd = instr(lngCurrentBegin + 1,strDataWhole,strBoundry) - 1
loop

' // CDO Email to Personnel Inc.

sch = "http://schemas.microsoft.com/cdo/configuration/"
Set cdoConfig = Server.CreateObject("CDO.Configuration")

With cdoConfig.Fields 
      .Item(sch & "sendusing") = 2 ' cdoSendUsingPort 
      .Item(sch & "smtpserver") = "127.0.0.1" 
      .update 
End With 

Set cdoMessage = Server.CreateObject("CDO.Message") 

'Set the Body
msgBody = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">" & vbCrLf _
		& "<html>" & vbCrLf _
		& "<head>" & vbCrLf _
		& " <title>Timecard Submittal from " & session("companyName") & "</title>" & vbCrLf _
		& " <meta http-equiv=Content-Type content=""text/html; charset=iso-8859-1"">" & vbCrLf _
		& "</head>" & vbCrLf _
		& "<body bgcolor=""#FFFF99"">" & vbCrLf _
		& " <h2>Timecard Submittal from " & session("companyName") & " at " & request.cookies("timecard")("time") & "</h2>" & vbCrLf _
		& " <p>" & vbCrLf _
		& "Timecard File: " & ThisFile & "<BR>" & vbCrLf _
		& "  </p>" & vbCrLf _
		& "</body>" & vbCrLf _
		& "</html>" & vbCrLf

With cdoMessage 
  Set .Configuration = cdoConfig
	  .From = session("emailAddress")
'	  .To = "saguilar@personnel.com"
	  .To = request.cookies("emailTo")
	  .Cc = session("emailAddress")
	  .Bcc = "saguilar@personnel.com"
      .HtmlBody = msgBody
	  .AddAttachment ThisFile
      .Subject = "Personnel Plus - Timecard Submittal from " & session("companyName")
'      .Send 
End With 

response.write "cookie(emailTo): " & request.cookies("emailTo") & "<BR>"
response.write "session(officeSelector): " & session("officeSelector") & "<BR>"
response.write "From: " & cdoMessage.From & "<BR>"
response.write "TO: " & cdoMessage.To & "<BR>"
response.write "Cc: " & cdoMessage.Cc & "<BR>"
response.write "Bcc: " & cdoMessage.Bcc & "<BR>"
response.write "Subject: " & cdoMessage.Subject & "<BR>"
response.write "HtmlBody: " & cdoMessage.HtmlBody & "<BR>"

Set cdoMessage = Nothing 
Set cdoConfig = Nothing 


    ' Now the file in the uploads dir can be deleted
    fso.DeleteFile ThisFile
    
    ' Destroy FileSystemObject, Free memory
    set fso = nothing
        		
    		Response.Write "Your time card has been sent.</h2>"
    		Response.Write "<br><br><input type='button' onclick='document.location=" & chr(34) & "/employers/registered/timecards/attach/index.asp?func=1" & chr(34) & "' value='<< Send Another?' id='button'1 name='button'1>"
    		Response.Write "<br><br><input type='button' onclick='window.close()' value='<< Finished >>'>"

end select %>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/advertise/inc/navi_btm.asp' -->
</BODY>
</HTML>