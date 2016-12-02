<%
session("add_css") = "reports.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
session("window_page_title") = "Current Unemployment - Personnel Plus"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/tools/activity/reports/common_reports.asp' -->
<script type="text/javascript" src="/include/js/reports.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%=decorateTop("reportform", "notToShort marLR10", "Current Unemployment")%>
<div id="formlist">
  <form id="reportform" name="reportform" action="<%=aspPageName%>" method="post">
    <table id="formOptions">
      <tr>
        <td><label class="flcl" for="whichCompany">Select Location</label>
        </td>
        <td><label class="flcl" for="whichCompany">Select Year</label>
        </td>
      </tr>
      <tr>
        <td><%=objCompanySelector(whichCompany, false, "javascript:document.reportform.submit();")%>
        </td>
        <td><select name="whichYear" id="whichYear" class="styled" onchange="javascript:document.reportform.submit();">
            <option value="">-- Year --</option>
            <option value="2010" <% if whichYear = "2010" then Response.write "selected" %>>2010</option>
            <option value="2011" <% if whichYear = "2011" then Response.write "selected" %>>2011</option>
			<option value="2012" <% if whichYear = "2012" then Response.write "selected" %>>2012</option>
            <option value="2013" <% if whichYear = "2013" then Response.write "selected" %>>2013</option>
			<option value="2014" <% if whichYear = "2014" then Response.write "selected" %>>2014</option>
            <option value="2015" <% if whichYear = "2015" then Response.write "selected" %>>2015</option>
          </SELECT>
        </td>
      </tr>
    </table>
  </form>
  <%
	if len(whichCompany & "") > 0 then
		thisConnection = useThisCompany(whichCompany)
		Set WhoseHere = Server.CreateObject ("ADODB.RecordSet")
		With WhoseHere
			.CursorLocation = 3 ' adUseClient
			dim sqlCommandText
			sqlCommandText = "SELECT Applicants.LastnameFirst, Applicants.City, Applicants.State, Applicants.Zip, " &_
				"Applicants.Telephone, Applicants.k, KeyDictionary.KeywordId, Applicants.ApplicantId " &_
				"FROM KeyDictionary " &_
				"INNER JOIN (Applicants INNER JOIN KeysApplicants ON Applicants.ApplicantID = KeysApplicants.ApplicantId) " &_
				"ON KeyDictionary.KeywordId = KeysApplicants.KeywordId " &_
				"WHERE (((KeyDictionary.KeywordId)=3710)) " &_
				"ORDER BY Applicants.LastnameFirst DESC;"
			.Open sqlCommandText, thisConnection
			.PageSize = nItemsPerPage
			'print sqlCommandText
		End With

	if not WhoseHere.eof then nPageCount = WhoseHere.PageCount

	if nPage < 1 Or nPage > nPageCount then
		nPage = 1
	end if
	
	response.write rs_navigation(whichCompany, rsQuery, 0)

	' Position recordset to the correct page
	if not WhoseHere.eof then WhoseHere.AbsolutePage = nPage

		dim whichYearAggregate, inthis
		whichYearAggregate = useThisKeyId(whichYear, "year")
		
		tableHeader = "<table style='width:100%'><tr>" &_
			"<th class=""alignL"">Year</th>" &_
			"<th class=""alignL"">Lastname, First</th>" &_
			"<th class=""alignL"">City</th>" &_
			"<th class=""alignL"">State</th>" &_
			"<th class=""alignL"">Zip</th>" &_
			"<th class=""alignL"">Telephone</th>" &_
			"</tr>"
				
		Response.write tableHeader
		do while not ( WhoseHere.Eof Or WhoseHere.AbsolutePage <> nPage )
			inthis = WhoseHere("k")
			if instr(inthis, whichYearAggregate) > 0 then
				if WhoseHere.eof then
					WhoseHere.Close
					' Clean up
					' Do the no results HTML here
					response.write "No Items found."
						' Done
					Response.End 
				end if
				
				applicantid = WhoseHere("ApplicantID")
				maintain_link = "<a href=""" & resourcelink & "who=" & applicantid & "&where=" & whichCompany & """>##</a>"
				sTelephone = FormatPhone(WhoseHere("Telephone"))
				sTelephone = replace(maintain_link, "##", sTelephone)
						
				tableRecord = "<tr>" &_
					"<td>" & replace(maintain_link, "##", whichYear) & "</td>" &_
					"<td>" & replace(maintain_link, "##", WhoseHere("LastnameFirst")) & "</td>" &_
					"<td>" & replace(maintain_link, "##", WhoseHere("City")) & "</td>" &_
					"<td>" & replace(maintain_link, "##", WhoseHere("State")) & "</td>" &_
					"<td>" & replace(maintain_link, "##", WhoseHere("Zip")) & "</td>" &_
					"<td>" & sTelephone & "</td>" &_
				"</tr>"
	
				Response.write tableRecord
			end if
			WhoseHere.MoveNext
		loop
		Response.write "</table>"
		Set WhoseHere = nothing
		
	response.write rs_navigation(whichCompany, rsQuery, 0)
	end if
%>
</div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
