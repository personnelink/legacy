<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<%=decorateTop("", "notToShort marLR10", "Skill Swap")%>
<div id="accountActivityDetail" class="pad10">
  <%
	dim whichCompany, linkInvoice

	thisConnection = dsnLessTemps(BOI)
	response.write(thisConnection) & "<br>"
	Set setSwapSkills_cmd = Server.CreateObject ("ADODB.Command")
	With setSwapSkills_cmd
		.ActiveConnection = thisConnection
		.Prepared = true
	End With
	On Error Resume Next
	Database.Open MySql
	Set whatToDo = Database.Execute("SELECT source, target FROM SkillSwap")
	Do	while not whatToDo.eof
		sqlSwapSkills = "UPDATE KeysApplicants SET KeywordId = " & whatToDo("target") & " " &_
			"WHERE KeywordId = " &  whatToDo("source") & ";"
		Response.write sqlSwapSkills & "<br>"
		setSwapSkills_cmd.CommandText = sqlSwapSkills
		setSwapSkills_cmd.Execute
		setSwapSkills_cmd.CommandText = "DELETE FROM KeyDictionary WHERE KeywordId = " &  whatToDo("source") & ";"
		response.write setSwapSkills_cmd.CommandText
		setSwapSkills_cmd.Execute
		whatToDo.Movenext
	loop
	Set setSwapSkills_cmd = Nothing
	Database.Close
	%>
</div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
