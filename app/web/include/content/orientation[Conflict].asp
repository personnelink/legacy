<%
session("add_css") = "general.asp.css" 
session("window_page_title") = "Orientation Videos - Personnel Plus"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->

 <%
 dim debug_mode  : if request.QueryString("debug") = 1 then debug_mode = true
 
        response.write decorateTop("orientationVideos", "marLR10", "Orientation Videos") &_
			"<ul><span style='color:white'>" & request.serverVariables("REMOTE_ADDR") & "</span>"
		
		dim ClientIP, AddressMask, ProxyForwarder
		ProxyForwarder = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
		if Len(ProxyForwarder) > 0 then
			If debug_mode then print "ProxyForwarder Length is " & Len(ProxyForwarder)
			if instr(ProxyForwarder, ",") > 0 then
				If debug_mode then print  "A comma is present in forwarder"
				ProxyForwarder = trim(Right(ProxyForwarder, len(ProxyForwarder) - Instr(ProxyForwarder, ",")))
			If debug_mode then print "ProxyForwarder Value is: " & ProxyForwarder
			end if
			If debug_mode then print "Forward greater than zero and this is after comma check"
			ClientIP =Split(ProxyForwarder, ".")
		else
			If debug_mode then print "Proxy Forwarder is not greater than zero length; evaluating as non-forwarded IP"
			ClientIP = Split(Request.ServerVariables("REMOTE_ADDR"), ".")
		end if
		
		If debug_mode then
			print "Parsing IP"
			dim x
			for each x in ClientIP
				print x
			next
			print "Forwarded IP Value: " & Request.ServerVariables("HTTP_X_FORWARDED_FOR")
			print  "Remote IP Value: " & request.serverVariables("REMOTE_ADDR") 
		end if
		
		if debug_mode then print "ProxyForwarder Value: " & ProxyForwarder & ". ProxyForwarder Length: " & Len(ProxyForwarder)
		if ProxyForwarder <> "" then
			AddressMask = ClientIP(0) & "." & ClientIP(1) & "." &ClientIP(2) & ".%"
		end if
		Set ClientIP = Nothing
		
		Set getMediaServer_cmd = Server.CreateObject ("ADODB.Command")
		With getMediaServer_cmd
			.ActiveConnection = MySql
			.CommandText = "SELECT media_server FROM tbl_siteips WHERE remote_addr LIKE '" & AddressMask & "';"
			.Prepared = true
		End With
		Set MediaServer = getMediaServer_cmd.Execute
		
		response.write "<div id='notinoffice'><h2 style='color:#587EDC;'>Training and orientation videos</h2>" &_
			"<p>If you have trouble viewing orientation videos you may need to come into one of our offices.</p>" &_
			"<p>To get registered with us please go to our application page located here:  " &_
			"<a href='/include/system/tools/submitapplication.asp'>" &_
			"<em>Employment Application</em></a>.</p>" &_
			"<p>if you prefer to come into one of our offices to register you can find the nearest office here:  " &_
			"<a href='http://www.personnelplus-inc.com/include/content/contact.asp'>" &_
			"<em>Contacts</em></a>.</p>" &_
			"<p>Otherwise you can check current available job postings here:  <a href='" &_
			"/include/system/tools/applicant/job_postings/'>" &_
			"<em>Job Postings</em></a></p>" &_
			"<p>Thank you again for your interest in our services!</p></div>"

		if MediaServer.eof then 
			mediaSource = "168.103.46.148"
			If debug_mode then print "mediaSource is EOF"
		Else
			mediaSource = MediaServer("media_server")
		end if
		If debug_mode then print "The final mediaSource value is: " & mediaSource
		
		Set getVideos_cmd = Server.CreateObject ("ADODB.Command")
		With getVideos_cmd
			.ActiveConnection = MySql
			.CommandText = "SELECT * FROM tbl_videos;"
			.Prepared = true
		End With
		Set Videos = getVideos_cmd.Execute
		
		if Request.ServerVariables("REMOTE_ADDR")  = "168.103.46.148" then
			mediaSource = "192.168.4.6"
		end if
		
		do while not Videos.eof
			response.write "<li class=""mirrors""><table><tr><td>" & _
				"<a href=" & Chr(34) & "mms://" & mediaSource & "/" & Videos("filename") & Chr(34) & ">" & " Main </a>"
	
			if mediaSource <> "168.103.46.148" and ProxyForwarder <> "168.103.46.148" then
				response.write " | <a href=" & Chr(34) & "mms://" & "168.103.46.148" & "/" & Videos("filename") & Chr(34) & ">" & " Mirror </a>"
			end if	
			
			response.write "&nbsp;&nbsp;</td><td>" & Videos("description") & "</td></tr></table></li>"
			
			Videos.Movenext
		loop
		Set Videos = Nothing	
		response.write "</ul>" & decorateBottom()
		%>
<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
