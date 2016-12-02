<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%

Response.Expires = -1
Response.ExpiresAbsolute = Now() -1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"


dim thisConnection, getApplicants_cmd, Applicants, selectedID, applicantID

Select Case Replace(Trim(Request.QueryString("companyid")), "'", "")
Case "PER"
	thisConnection = TempsPlus(PER)
Case "BUR"
	thisConnection = TempsPlus(BUR)
Case "BOI"
	thisConnection = TempsPlus(BOI)
Case "IDA"
	thisConnection = TempsPlus(IDA)
Case Else
	Response.write "<option value=''>-- Select Company From Above --</option>"
	Response.End()
End Select

Set getApplicants_cmd = Server.CreateObject ("ADODB.Command")
With getApplicants_cmd
	.ActiveConnection = thisConnection
	.CommandText = "SELECT ApplicantID, LastnameFirst FROM Applicants ORDER By LastnameFirst Asc"
	.Prepared = true
End With
Set Applicants = getApplicants_cmd.Execute
	
selectedID = Replace(Trim(Request.QueryString("selected")), "'", "")
do while not Applicants.eof
	applicantID = Applicants("ApplicantID")
	Response.write "<option value=" & Chr(34) & applicantID & Chr(34) & " "
	if applicantID = selectedID then Response.write "selected"
	Response.write "> " & Applicants("LastnameFirst") & " </option>"
	Applicants.Movenext
loop

Applicants.Close
Set getApplicants_cmd = nothing
Set Applicants = nothing

%>
