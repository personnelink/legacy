<%
    dim customer, tempPath, url
	url = "192.168.0.1"
	
	customer = request.QueryString("customer")
	customer = replace(customer, "'", "''")
	customer = replace(customer, """", "''")
	if len(customer) = 0 or len(customer) > 8 then response.End()

	tempPath = "\\personnelplus.net.\net_docs\Resumes\Received"
	
	set oWshell = CreateObject("WScript.Shell") 
	'set objCmd = oWshell.Exec("ping  * /s /a /b")

	set objCmd = oWshell.Exec("%comspec% /c ""dir \\personnelplus.net.\net_docs\Timecards\" & customer & "* /s /a /b """)
    strPResult = objCmd.StdOut.Readall() 
	set oWshell = nothing: Set ojbCmd = nothing
	
	dim foundTimecards
	foundTimecards = Split(strPResult, "\\personnelplus.net.\net_docs\Timecards\")
	
	for each item in foundTimecards
		response.write item & "<br>"
	next

	'response.write strPResult
	Response.End()
	
	' Create a filesystem object
	dim fso
	set fso = server.createObject("Scripting.FileSystemObject")
	
	if fso.FileExists(Filename) then
		' Get a handle to the file
		dim filehandle    
		set filehandle = FSO.GetFile(Filename)
	
		' Open the file
		dim TextStream, line
		Set TextStream = filehandle.OpenAsTextStream(ForReading, TristateUseDefault)
		do while not TextStream.AtEndOfStream
			line = TextStream.readline
			response.write line & "<br>"
		loop
		Set TextStream = nothing
	end if
	Set fso = nothing
	
	
'getPDF = ReadBinaryFile("c:\Network Storage\Net_docs\Jerome Check List.pdf")
'Response.ContentType = "application/pdf"
'Response.AddHeader "Content-Type", "application/pdf"
'Response.AddHeader "Content-Disposition", "inline;filename=new.pdf"
'Response.BinaryWrite getPDF
'Response.End


Function ReadBinaryFile(FileName)
  const adTypeBinary = 1
  
  'Create Stream object
  dim BinaryStream
  Set BinaryStream = CreateObject("ADODB.Stream")
  
  'Specify stream type - we want To get binary data.
  BinaryStream.Type = adTypeBinary
  
  'Open the stream
  BinaryStream.Open
  
  'Load the file data from disk To stream object
  BinaryStream.LoadFromFile FileName
  
  'Open the stream And get binary data from the object
  ReadBinaryFile = BinaryStream.Read
End Function
	
		%>

