<%Option Explicit%>
<%
session("add_css") = "./general.asp.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #include virtual='/include/system/functions/applicants.asp' -->
<!-- Revision Date: 3.25.2009 -->
<!-- Revised: 2.11.2009 -->
<script type="text/javascript" src="/include/js/createNewUser.js"></script>

<%
dim page_title

Sub maintainApplicantForm
%>

<form name="maintain" method="post" action="<%=post_to%>?where=<%=where_friendly%>&who=<%=who%>">
  <div id="left_form">
    <div id="applicantMain">
      <h5>Applicant Details</h5><%
      page_title = lastnameFirst
	  response.write  make_input("lastnameFirst", "Name", lastnameFirst, 1, "p") &_
					  make_input("addressline", "Address", addressline, 2, "p") &_
					  make_input("cityline", "City line", cityline, 3, "p") &_
					  make_input("telephone", "Telephone", telephone, 4, "p") &_
					  make_input("sec_telephone", "2nd Telephone", sec_telephone, 5, "p") &_
					  make_input("sec_telephone_type", "2nd Telephone Description", sec_telephone_type, 6, "p") &_
					  make_input("email", "e-mail", email, 6, "p") &_
					  make_input("ssn", "SSN", ssn, 8, "p") &_
					  make_input("memo", "Memo", memo, 9, "p") %>
	  
      <script type="text/javascript"><!-- 
							document.maintain.lastnameFirst.focus()
								//--></script>
    <br />
<div class="buttonwrapper"><%=updated%>
	<a class="squarebutton" href="#" style="margin-left: 6px" onClick="document.maintain.action.value='update';document.maintain.submit();"><span> Update </span></a> </div>	</div>
    <div id="applicantSkills">
      <h5>Applicant's Selected Skills</h5>
      <div>
	  <ul>
        <%=app_skills%>
      </ul></div>
    </div>
  </div>
  <div id="right_form"><%
	dim inSystem, notInSystem
	inSystem = "class=""inSystem"" "
	notInSystem = "class=""notInSystem"" "

	dim inIDA, inBOI, inPER, inBUR, inPOC, inPPI, inORE, inWYO
	inIDA = notInSystem
	inBOI = notInSystem
	inPER = notInSystem
	inBUR = notInSystem
	inPOC = notInSystem
	inPPI = notInSystem
	
	'print enrolledSites.inIDA
	dim inAtLeastOne
	if len(enrolledSites.inIDA) > 0 then
		inIDA = inSystem
		inAtLeastOne = true
	end if
	
	if Not VarType(enrolledSites.inPER) = 1 then
		inPER = inSystem
		inAtLeastOne = true
	end if

	if Not VarType(enrolledSites.inBOI) = 1 then
		inBOI = inSystem
		inAtLeastOne = true
	end if
	
	if Not VarType(enrolledSites.inBUR) = 1 then
		inBUR = inSystem
		inAtLeastOne = true
	end if
	
	if Not VarType(enrolledSites.inPOC) = 1 then
		inBUR = inSystem
		inAtLeastOne = true
	end if
	
	if Not VarType(enrolledSites.inPPI) = 1 then
		inBUR = inSystem
		inAtLeastOne = true
	end if

	dim ajaxlink : ajaxlink = "javascript:;"" onclick=""action.inject('appID=" & CStr(enrolledSites.applicationID)
		
	%>
<div id="applicantDates">
      <table>
        <tr>
          <th colspan="8">Enrolled into:</th>
        </tr>
        <tr>
          <td class="inCompany small"><a <%=inBOI%>href=""" & ajaxlink & "&amp;action=inject&amp;company=BOI')"">BOI</a></td>
          <td class="inCompany small"><a <%=inPPI%>href=""" & ajaxlink & "&amp;action=inject&amp;company=PPI')"">PPI</a></td>
          <td class="inCompany small"><a <%=inPER%>href=""" & ajaxlink & "&amp;action=inject&amp;company=PER')"">PER</a></td>
          <td class="inCompany small"><a <%=inBUR%>href=""" & ajaxlink & "&amp;action=inject&amp;company=BUR')"">BUR</a></td>
          <td class="inCompany small"><a <%=inPOC%>href=""" & ajaxlink & "&amp;action=inject&amp;company=POC')"">POC</a></td>
          <td class="inCompany small"><a <%=inIDA%>href=""" & ajaxlink & "&amp;action=inject&amp;company=IDA')"">IDA</a></td>
          <td class="inCompany small"><a <%=inWYO%>href=""" & ajaxlink & "&amp;action=inject&amp;company=WYO')"">WYO</a></td>
          <td class="inCompany small"><a <%=inORE%>href=""" & ajaxlink & "&amp;action=inject&amp;company=ORE')"">ORE</a></td>
        </tr>
      </table>
    </div>

	<div id="applicantDates">
      <table>
        <tr>
          <th>Employee Number</th>
          <td><%=EmployeeNumber%></td>
          <th>Status</th>
          <td><%=applicant_status%></td>
        </tr>
        <tr>
          <th>Entry Date</th>
          <td><%=entry_date%></td>
          <th>Available</th>
          <td><%=DateAvailable%></td>
        </tr>
        <tr>
          <th>Last Assigned</th>
          <td><%=LastAssignDate%></td>
          <th>To</th>
          <td><%=LastAssignCust%></td>
        </tr>
      </table>
    </div>
    <div id="applicantScores">
      <table>
        <tr>
          <th class="battery"><h5>Test Battery</h5></th>
          <th class="results"><h5>Results</h5></th>
        </tr>
        <tr>
          <th>Attit/Inititive</th>
          <td><input name="UserNumeric1" type="text" value="<%=test_results(0)%>" /></td>
        </tr>
        <tr>
          <th>Comm/Langua</th>
          <td><input name="UserNumeric2" type="text" value="<%=test_results(1)%>" /></td>
        </tr>
        <tr>
          <th>Appearance</th>
          <td><input name="UserNumeric3" type="text" value="<%=test_results(2)%>" /></td>
        </tr>
        <tr>
          <th>Work Hist.</th>
          <td><input name="UserNumeric4" type="text" value="<%=test_results(3)%>" /></td>
        </tr>
        <tr>
          <th>Criminal</th>
          <td><input name="UserNumeric5" type="text" value="<%=test_results(4)%>" /></td>
        </tr>
        <tr>
          <th>Math</th>
          <td><input name="UserNumeric6" type="text" value="<%=test_results(5)%>" /></td>
        </tr>
        <tr>
          <th>Clerical</th>
          <td><input name="UserNumeric7" type="text" value="<%=test_results(6)%>" /></td>
        </tr>
        <tr>
          <th>Read/Comp</th>
          <td><input name="UserNumeric8" type="text" value="<%=test_results(7)%>" /></td>
        </tr>
        <tr>
          <th>Drivers Lic</th>
          <td><input name="UserNumeric9" type="text" value="<%=test_results(8)%>" /></td>
        </tr>
      </table>
	  <div class="buttonwrapper"><%=updated%><a class="squarebutton" href="#" style="margin:0.6em 0 0 0" onClick="document.maintain.action.value='update';document.maintain.submit();"><span> Update </span></a> </div>
    </div>
    <div id="applicantOptions">
		<a href="/pdfServer/pdfApplication/createApplication.asp?appID=<%=enrolledSites.applicationID%>&amp;action=review">Un-Signed Forms</a>
		<a href="/pdfServer/pdfApplication/createApplication.asp?appID=<%=enrolledSites.applicationID%>&amp;action=review&amp;giveme=justapp">Application (copy)</a>
		<a href="/include/system/tools/applicant/interview/?app_id=<%=enrolledSites.applicationID%>">Interview</a>
		<a href="/include/system/tools/attachments/?attachment=a<%=who & where_friendly%>">Attachments</a>
		<a href="/include/system/tools/applicant/checkHistory/?who=<%=who%>&where=<%=where_friendly%>">Check History</a>
		<a href="/include/system/tools/search/?<%=resume_ctrl%>">Resume</a>
		<a href="/include/system/tools/whoseHere.asp?who=<%=who%>&where=<%=where_friendly%>">Sign-In Applicant</a>
	</div>
	
	<div id="applicantActivities">
      <h5>Applicant Activities</h5>
	  <div>
	  <%
		getActivities(ApplicantId)
		%></div>
    </div>
  </div>
		  <div id="new_activity" class="buttonwrapper"><a class="squarebutton" href="#" style="margin-left: 6px" onClick="document.maintain.action.value='new_activity';document.maintain.submit();"><span> New Activity </span></a> </div>

  <div id="applicantNotes">
    <label for="notes">Notes</label>
    <textarea name="notes" id="notes"><%=notes%></textarea>
  <div id="update_notes" class="buttonwrapper"><%=updated%><a class="squarebutton" href="#" style="margin-left: 6px" onClick="document.maintain.action.value='update_note';document.maintain.submit();"><span> Update </span></a> </div>

  </div>
  
  
  <div id="applicantAttachments"></div>

  </div><div style="clear:both">
 
  <div style="clear:both">
  
  <input class="hide" name="action" value="" type="hidden" />
  <input class="hide" name="ApplicantId" value="<%=ApplicantId%>" type="hidden" />
  <input class="hide" name="applicant_status" value="<%=applicant_status%>" type="hidden" />
  <input class="hide" name="EntryDate" value="<%=entry_date%>" type="hidden" />
  <input class="hide" name="LastAssignDate" value="<%=LastAssignDate%>" type="hidden" />
  <input class="hide" name="LastAssignCust" value="<%=LastAssignCust%>" type="hidden" />
  <input class="hide" name="DateAvailable" value="<%=DateAvailable%>" type="hidden" />
  <input class="hide" name="EmployeeNumber" value="<%=EmployeeNumber%>" type="hidden" />
  <input id="page_title" name="page_title" type="hidden" class="hidden" value="<%=page_title%>">
  </div>

  
  
</form>
<div style="clear:both"> </div>
<%
End Sub
%>
<!-- #INCLUDE VIRTUAL='include/core/pageFooter.asp' -->
<%
if Err.Number <>0 then
	Resonse.Write Err.Description
end if
%>
