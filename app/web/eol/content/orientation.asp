<%
session("add_css") = "general.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->
<!-- Revision Date: 3.19.2009 -->
<!-- Revision Date: 2.10.2009 -->
 <%
        response.write decorateTop("orientationVideos", "marLR10", "Orientation Videos") &_
			"<ul><span style='color:white'>" & request.serverVariables("REMOTE_ADDR") & "</span>"
		
		dim ClientIP, AddressMask
		ClientIP = Split(Request.ServerVariables("REMOTE_ADDR"), ".")
		AddressMask = ClientIP(0) & "." & ClientIP(1) & "." &ClientIP(2) & ".%"
		Set ClientIP = Nothing
		
		Set getMediaServer_cmd = Server.CreateObject ("ADODB.Command")
		With getMediaServer_cmd
			.ActiveConnection = MySql
			.CommandText = "SELECT media_server FROM tbl_siteips WHERE remote_addr LIKE '" & AddressMask & "';"
			.Prepared = true
		End With
		Set MediaServer = getMediaServer_cmd.Execute
		
		response.write "<div id='notinoffice'><h2 style='color:#587EDC;'>Thank you for your interest in obtaining videos from our site.</h2>" &_
			"<p>To view job safety and orientation videos through this site you may need to be inside one of our offices.</p>" &_
			"<p>To get registered with us please go to our application page located here: " &_
			"<a href='https://secure.personnelplus.net/include/system/tools/submitapplication.asp'>" &_
			"https://secure.personnelplus.net/include/system/tools/submitapplication.asp</a></p>" &_
			"<p>if you prefer to come into one of our offices to register you can find the nearest office here: " &_
			"<a href='http://www.personnelplus-inc.com/include/content/contact.asp'>" &_
			"http://www.personnelplus-inc.com/include/content/contact.asp</a></p>" &_
			"<p>Otherwise you can check current available job postings here: <a href='" &_
			"https://secure.personnelplus.net/include/system/tools/searchJobs.asp'>" &_
			"https://secure.personnelplus.net/include/system/tools/searchJobs.asp</a></p>" &_
			"<p>Thank you again for your interest in our services!</p></div>"

		if MediaServer.eof then 
			mediaSource = "168.103.46.148"
		Else
			mediaSource = MediaServer("media_server")
		end if

		Set getVideos_cmd = Server.CreateObject ("ADODB.Command")
		With getVideos_cmd
			.ActiveConnection = MySql
			.CommandText = "SELECT * FROM tbl_videos;"
			.Prepared = true
		End With
		Set Videos = getVideos_cmd.Execute
		
		if mediaSource = "168.103.46.148" then
			do while not Videos.eof
				response.write "<li><a href=" & Chr(34) & "mms://" &_
					mediaSource & "/" &_
					Videos("filename") & Chr(34) & ">" &_
					Videos("description") & "</a></li>"
				
				Videos.Movenext
			loop	
		else
			do while not Videos.eof
				response.write "<li class=""mirrors"">" & Videos("description") & "<a href=" & Chr(34) & "mms://" &_
					mediaSource & "/" &_
					Videos("filename") & Chr(34) & ">" &_
					" Main </a> " &_
					
					"<a href=" & Chr(34) & "mms://" &_
					"168.103.46.148" & "/" &_
					Videos("filename") & Chr(34) & ">" &_
					" Mirror </a></li>"
				Videos.Movenext
			loop
		end if
		Set Videos = Nothing	
		response.write "</ul>" & decorateBottom()
		%>
<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
