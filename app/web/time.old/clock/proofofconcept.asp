<%

getPDF = ReadBinaryFile("c:\Network Storage\Net_docs\Jerome Check List.pdf")

Response.ContentType = "application/pdf"
Response.AddHeader "Content-Type", "application/pdf"
Response.AddHeader "Content-Disposition", "inline;filename=new.pdf"
Response.BinaryWrite getPDF
Response.End


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

