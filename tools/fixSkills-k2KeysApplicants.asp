<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<%=decorateTop("", "notToShort marLR10", "Fix Skills")%>
<div id="accountActivityDetail" class="pad10">
<%
	server.ScriptTimeOut = 3600
  
	dim cmd, rs, k_rs
	set cmd = server.createobject("ADODB.command")
	  
	dim TempsCodes, code
		dim str
		str = "PER, BOI , PPI, BUR, IDA"
	
		TempsCodes = split(str, ",")
	
	On Error Resume Next
	for each code in TempsCodes
		print "Working on this code: " & code
		with cmd
			.ActiveConnection = dsnLessTemps(getTempsDSNbyCode(code))
			print .ActiveConnection
			.CommandText = "SELECT Max(KeysApplicants.ApplicantId) AS MaxOfApplicantId FROM KeysApplicants;"
			.CommandType = adCmdText
			.Prepared = true
		end with
		set rs = cmd.Execute

		if not rs.eof then
			with cmd
				.CommandText = "SELECT ApplicantId, k FROM Applicants WHERE ApplicantId > " & rs(0)
			end with
			set rs_k = cmd.Execute
		end if
		print "Max Applicant: " & rs(0)
		
		response.write "<pre>"
		do while not rs_k.eof
			print "Applicant id: " & rs_k("ApplicantId")
			k_Skills = Split(rs_k("k"), ".") 'split the skills up
			
			for each Skill in k_Skills
				if not isnull(skill) and len(Skill) > 0 then
					with cmd
						.CommandText = "" &_
							"INSERT INTO KeysApplicants (ApplicantId, KeywordId) " &_
							"VALUES (" & rs_k("ApplicantId") & ", " & Skill & ")"
						.Execute()
					end with
				end if
				response.write Skill & "&nbsp;&nbsp;"
				response.flush()
				
			next
			respone.write "</pre>"

			rs_k.Movenext
		loop
	next
%>
 </div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
