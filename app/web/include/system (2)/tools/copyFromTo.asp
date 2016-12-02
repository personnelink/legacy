<% session("add_css") = "shortForms.asp.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/searchForm.js"></script>
<!-- Created: 2008.12.15 -->
<!-- Revised: 2009.03.18 -->
<!-- Revised: 2009.09.04 - Added noise prepocessor for search -->

<%=decorateTop("searchForm", "notToShort marLR10", "Who do you want to copy?")%>
<form method="POST" action="copyFromTo.asp" name="frmSearch" id="frmSearch">
  <fieldset id="copysource">
  <label>Enter Source Applicant ID:</label>
    <input type="text" maxlength="255" name="whatPerson" id="whatPerson" size="50" value='<%=request.Form("whatPerson")%>'>
    <input type="submit" value="Search" name="B1" class="hide">
	</fieldset>
	<%
	dim fromWhere
	fromWhere = request.form("fromWhere")
	if len(fromWhere & "") = 0 then fromWhere = "PER" %>
    <fieldset id="copyfromwhere">
	<legend>Copy from:</legend>
	<ol>
	<li>
	<label>BOI</label>
    <input name="fromWhere" class="styled" type="radio" value="BOI" <% if fromWhere = "BOI" then Response.write "checked=""checked""" %> />
	</li>
    <li><label>BUR</label>
	<input name="fromWhere" class="styled" type="radio" value="BUR" <% if fromWhere = "BUR" then Response.write "checked=""checked""" %>></li>
    <li><label>PER</label>
    <input name="fromWhere" class="styled" type="radio" value="PER" <% if fromWhere = "PER" then Response.write "checked=""checked""" %>></li>
    <li><label>PPI</label>
    <input name="fromWhere" class="styled" type="radio" value="PPI" <% if fromWhere = "PPI" then Response.write "checked=""checked""" %>></li>
    <li><label>IDA</label>
    <input name="fromWhere" class="styled" type="radio" value="IDA" <% if fromWhere = "IDA" then Response.write "checked=""checked""" %>></li>
	</ol></fieldset>
	

<%
	dim toWhere
	toWhere = request.form("toWhere")
	if len(toWhere & "") = 0 then toWhere = "PER" %>
    <fieldset id="copytowhere">
	<legend>Copy to:</legend>
    <ol>
	<li><label>BOI</label>
	<input name="toWhere" class="styled" type="radio" value="BOI" <%if toWhere = "BOI" then Response.write("checked=" & Chr(34) & "checked" & Chr(34)) %> ></li>
	<li><label>BUR</label>
    <input name="toWhere" class="styled" type="radio" value="BUR" <%if toWhere = "BUR" then Response.write("checked=" & Chr(34) & "checked" & Chr(34)) %> ></li>
	<li>
	<label>PER</label>
   <input name="toWhere" class="styled" type="radio" value="PER" <%if toWhere = "PER" then Response.write("checked=" & Chr(34) & "checked" & Chr(34)) %> >
</li><li><label>PPI</label>
<input name="toWhere" class="styled" type="radio" value="PPI" <%if toWhere = "PPI" then Response.write("checked=" & Chr(34) & "checked" & Chr(34)) %> >
</li><li><label>IDA</label><input name="toWhere" class="styled" type="radio" value="IDA" <%if toWhere = "IDA" then Response.write("checked=" & Chr(34) & "checked" & Chr(34)) %> >
</li>
</ol></fieldset>

  <div class="searchButton"><a class="squarebutton" href="#" style="float:none" onclick="document.forms['frmSearch'].submit();"><span> ... Copy ... </span></a></div>
  <div id="searchResults">
    
<script type="text/javascript"><!-- 
						document.frmSearch.whatPerson.focus()
							//--></script>
	<%
	

	dim sqlWhatPerson, whatPerson
	whatPerson = request.form("whatPerson")
	if len(whatPerson) <> 0 then
		Select Case fromWhere
		Case "PER"
			thisConnection = dsnLessTemps(PER)
		Case "BUR"
			thisConnection = dsnLessTemps(BUR)
		Case "BOI"
			thisConnection = dsnLessTemps(BOI)
		Case "IDA"
			thisConnection = dsnLessTemps(IDA)
		Case "PPI"
			thisConnection = dsnLessTemps(PPI)
		Case Else
			Response.End()
		End Select
		
		dim thisDestination
		Select Case toWhere
		Case "PER"
			thisDestination = dsnLessTemps(PER)
		Case "BUR"
			thisDestination = dsnLessTemps(BUR)
		Case "BOI"
			thisDestination = dsnLessTemps(BOI)
		Case "IDA"
			thisDestination = dsnLessTemps(IDA)
		Case "PPI"
			thisDestination = dsnLessTemps(PPI)
		Case Else
			Response.End()
		End Select
		
		Set getWhatPerson_cmd = Server.CreateObject ("ADODB.Command")
		With getWhatPerson_cmd
			.ActiveConnection = thisConnection
			.CommandText = "SELECT * " &_
				"FROM Applicants WHERE ApplicantID=" & Trim(whatPerson)
			.Prepared = true
		End With
		Set getWhatPerson = getWhatPerson_cmd.Execute
		
		Set getWhatEmployee_cmd = Server.CreateObject ("ADODB.Command")
		With getWhatEmployee_cmd
			.ActiveConnection = thisConnection
			.CommandText = "SELECT * " &_
				"FROM PR3MSTR WHERE ApplicantID=" & Trim(whatPerson)
			.Prepared = true
		End With
		Set getWhatEmployee = getWhatEmployee_cmd.Execute
		
		Set putThatPerson_cmd = Server.CreateObject ("ADODB.Connection")
		putThatPerson_cmd.Open thisDestination
		
		Set putThatEmployee_cmd = Server.CreateObject ("ADODB.Connection")
		putThatEmployee_cmd.Open thisDestination

		ApplicantID_cmd = putThatPerson_cmd.Execute("SELECT Max(Applicants.ApplicantID) + 1 As MaxApplicantID FROM Applicants")
		
		ApplicantID = ApplicantID_cmd("MaxApplicantID")

		sqlThatPerson = "INSERT INTO Applicants (LastnameFirst, Address, City, State, Zip, ApplicantStatus, ApplicantID, Telephone, 2ndTelephone, " &_
			"2ndTeleDescription, SSNumber, Sex, MaritalStatus, FederalExemptions, TaxJurisdiction, ShortMemo, EntryDate, " &_
			"LastAssignCust, EmployeeNumber, k, AppChangedBy, EmailAddress, LocationId) VALUES (" &_
			"'" & getWhatPerson("LastnameFirst") & "', " &_
			"'" & getWhatPerson("Address") & "', " &_
			"'" & getWhatPerson("City") & "', " &_
			"'" & getWhatPerson("State") & "', " &_
			"'" & getWhatPerson("Zip") & "', " &_
			"" & getWhatPerson("ApplicantStatus") & ", " &_
			"" & ApplicantID & ", " &_
			"'" & getWhatPerson("Telephone") & "', " &_
			"'" & getWhatPerson("2ndTelephone") & "', " &_
			"'" & getWhatPerson("2ndTeleDescription") & "', " &_
			"'" & getWhatPerson("SSNumber") & "', " &_
			"'" & getWhatPerson("Sex") & "', " &_
			"'" & getWhatPerson("MaritalStatus") & "', " &_
			"" & getWhatPerson("FederalExemptions") & ", " &_
			"'" & getWhatPerson("TaxJurisdiction") & "', " &_
			"'" & getWhatPerson("ShortMemo") & "', " &_
			"#" & getWhatPerson("EntryDate") & "#, " &_
			"'" & getWhatPerson("LastAssignCust") & "', " &_
			"'" & getWhatPerson("EmployeeNumber") & "', " &_
			"'" & getWhatPerson("k") & "', " &_
			"'" & getWhatPerson("AppChangedBy") & "', " &_
			"'" & getWhatPerson("EmailAddress") & "', " &_
			"'" & getWhatPerson("LocationId") & "')"

			if Not getWhatPerson.eof then
				response.write sqlThatPerson
				Set WhatPerson = putThatPerson_cmd.Execute(sqlThatPerson)
			Else		
				response.write "No record was found for <i>" & whatPerson & "</i>"
			end if

		
		sqlThatPerson = "INSERT INTO PR3MSTR (EmployeeNumber, Birthdate, Sex, " &_
			"MaritalStatus, ActivityStatus, FedExemptions, StateExemptions, StateExemptAmount, PayPeriod, PayType, " &_
			"TaxJurisdiction, FixedFederalTax, FixedStateTax, FedTaxPak, StateTaxPak, SSTaxPak, MediTaxPak, SUITaxPak, Payrate1, Payrate2, " &_
			"Payrate3, GlAcct1, GlAcct2, GlAcct3, EmpChangedBy, FederalTaxPackageId, TaxJurisdictionTaxPackageId, " &_
			"ApplicantId) VALUES (" &_
			"'" & getWhatEmployee("EmployeeNumber") & "', " &_
			"#" & getWhatEmployee("Birthdate") & "#, " &_
			"'" & getWhatEmployee("Sex") & "', " &_
			"'" & getWhatEmployee("MaritalStatus") & "', " &_
			"'" & getWhatEmployee("ActivityStatus") & "', " &_
			"'" & getWhatEmployee("FedExemptions") & "', " &_
			"'" & getWhatEmployee("StateExemptions") & "', " &_
			"'" & getWhatEmployee("StateExemptAmount") & "', " &_
			"'" & getWhatEmployee("PayPeriod") & "', " &_
			"'" & getWhatEmployee("PayType") & "', " &_
			"'" & getWhatEmployee("TaxJurisdiction") & "', " &_
			"'" & getWhatEmployee("FixedFederalTax") & "', " &_
			"'" & getWhatEmployee("FixedStateTax") & "', " &_
			"'" & getWhatEmployee("FedTaxPak") & "', " &_
			"'" & getWhatEmployee("StateTaxPak") & "', " &_
			"'" & getWhatEmployee("SSTaxPak") & "', " &_
			"'" & getWhatEmployee("MediTaxPak") & "', " &_
			"'" & getWhatEmployee("SUITaxPak") & "', " &_
			"'" & getWhatEmployee("Payrate1") & "', " &_
			"'" & getWhatEmployee("Payrate2") & "', " &_
			"'" & getWhatEmployee("Payrate3") & "', " &_
			"'" & getWhatEmployee("GlAcct1") & "', " &_
			"'" & getWhatEmployee("GlAcct2") & "', " &_
			"'" & getWhatEmployee("GlAcct3") & "', " &_
			"'" & getWhatEmployee("EmpChangedBy") & "', " &_
			"'" & getWhatEmployee("FederalTaxPackageId") & "', " &_
			"'" & getWhatEmployee("TaxJurisdictionTaxPackageId") & "', " &_
			"" & ApplicantID & ")" 
			
			if Not getWhatEmployee.eof then
				response.write "<br /><br />" & sqlThatPerson
				Set WhatPerson = putThatPerson_cmd.Execute(sqlThatPerson)
			Else		
				response.write "No record was found for <i>" & whatPerson & "</i>"
			end if
		
		putThatPerson_cmd.Close
		putThatEmployee_cmd.Close
		Set getWhatPerson_cmd = Nothing
		Set getWhatPerson = Nothing
		Set getWhatEmployee_cmd = Nothing
		Set getWhatEmployee = Nothing
		Set putThatPerson_cmd = Nothing
		Set putThatEmployee_cmd = Nothing
		Set ApplicantID_cmd = Nothing
	end if
%>

  </div>
</form>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
