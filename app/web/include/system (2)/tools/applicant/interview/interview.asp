<%Option Explicit%>
<%
session("add_css") = "./interview.asp.css"
session("required_user_level") = 2048 'userLevelRegistered

session("additionalHeading") = "<meta http-equiv=""Cache-Control"" content=""No-Cache"">" &_
	"<meta http-equiv=""Cache-Control"" content=""No-Store"">" &_
	"<meta http-equiv=""Pragma"" content=""No-Cache"">" &_
	"<meta http-equiv=""Expires"" content=""0"">"

dim frmAction
frmAction = request.form("frmAction")
if frmAction = "completed" then session("no_header") = true

%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/functions/common.asp' -->

<script type="text/javascript" src="interview.js"></script>

<!-- #include file='interview.doStuff.asp' -->

<form class="interview" name="interviewFrm" id="interviewFrm" action="" method="post">
	<%=decorateTop("missing_stuff", "marLR10 hide", "Some questions were missed")%>
	<div id="missed_items"%>&nbsp;</div>
	<%=decorateBottom()%>
	
	<%=decorateTop("", "marLR10", "Applicant Interview Questions")%>
    <div class="interview_questions">
	<input type="hidden" id="page_title" name="page_title" value="Interview Applicant"/>
	<input type="hidden" name="frmAction" value=""/>
	<input type="hidden" name="app_id" value="<%=app_id%>"/>
	<input type="hidden" name="int_id" value="<%=interviewId%>"/>
	<input type="hidden" name="return_QS" value="<%=return_QS%>"/>
	<input type="hidden" name="interviewerId" value="<%=interviewerId%>"/>
	
	<!-- What kind of work are you looking for -->	
	<fieldset>
		<legend id="lbl_kind_of_work">What kind of work are you looking for?</legend>
		<textarea name="kind_of_work" id="kind_of_work"><%=kind_of_work%></textarea>
	</fieldset>
		
	<!-- Are you willing to accept full-time AND/OR part-time work -->
	<fieldset>
		<legend id="lbl_full_or_part_time">Are you willing to accept full-time AND/OR part-time work?</legend>
		<label><input type="checkbox" id="full_or_part_time" name="full_or_part_time" value="f" <% if instr(full_or_part_time, "f") > 0 then checked%>/> Full-Time</label>
		<label><input type="checkbox" id="full_or_part_time" name="full_or_part_time" value="p" <% if instr(full_or_part_time, "p") > 0 then checked%>/> Part-Time</label>
	</fieldset>
	<%=application_says_full_or_part_time%>

	<!-- Are you willing to accept temporary assignments (short-term or “day jobs”)? -->
	<fieldset>
		<legend id="lbl_accept_temporary">Are you willing to accept temporary assignments (short-term or “day jobs”)?</legend>
		<label><input type="radio" name="accept_temporary" value="y" <% if accept_temporary = "y" then checked%>/> Yes</label>
		<label><input type="radio" name="accept_temporary" value="n" <% if accept_temporary = "n" then checked%>/> No</label>
	</fieldset>

	<!-- Are you willing to accept long-term or temp-to-hire positions -->
	<fieldset>
		<legend id="lbl_accept_longterm">Are you willing to accept long-term or temp-to-hire positions?</legend>
		<label><input type="radio" name="accept_longterm" value="y" <% if accept_longterm = "y" then checked%>/> Yes</label>
		<label><input type="radio" name="accept_longterm" value="n" <% if accept_longterm = "n" then checked%>/> No</label>
	</fieldset>
	
	<!-- What days of the week are you available -->
	<fieldset>
		<legend id="lbl_days_available">What days of the week are you available?</legend>
		<label><input type="checkbox" name="days_available" value="128" onclick="cycle_days_field(this.value)" <% if cbool(days_available and 128) then checked %>/> <i>Any</i></label>
		<label><input type="checkbox" name="days_available" value="1" onclick="cycle_days_field(this.value)" <% if cbool(days_available and 1) or cbool(days_available and 128) then checked %>/> Mon</label>
		<label><input type="checkbox" name="days_available" value="2" onclick="cycle_days_field(this.value)" <% if cbool(days_available and 2) or cbool(days_available and 128) then checked %> /> Tue</label>
		<label><input type="checkbox" name="days_available" value="4" onclick="cycle_days_field(this.value)" <% if cbool(days_available and 4) or cbool(days_available and 128) then checked %>/> Wed</label>
		<label><input type="checkbox" name="days_available" value="8" onclick="cycle_days_field(this.value)" <% if cbool(days_available and 8) or cbool(days_available and 128) then checked %>/> Thu</label>
		<label><input type="checkbox" name="days_available" value="16" onclick="cycle_days_field(this.value)" <% if cbool(days_available and 16) or cbool(days_available and 128) then checked %>/> Fri</label>
		<label><input type="checkbox" name="days_available" value="32" onclick="cycle_days_field(this.value)" <% if cbool(days_available and 32) or cbool(days_available and 128) then checked %>/> Sat</label>
		<label><input type="checkbox" name="days_available" value="64" onclick="cycle_days_field(this.value)" <% if cbool(days_available and 64) or cbool(days_available and 128) then checked %>/> Sun</label>
	</fieldset>

	
	<!-- Can you work any shift -->
	<fieldset>
		<legend id="lbl_work_any_shift">Can you work any shift?</legend>
		<label><input type="radio" name="work_any_shift" value="y" onclick="cycle_which_shifts(this.value)" <% if work_any_shift = "y" then checked%>/> Yes</label>
		<label><input type="radio" name="work_any_shift" value="n" onclick="cycle_which_shifts(this.value)" <% if work_any_shift = "n" then checked%>/> No</label>
	</fieldset>

	
	<!-- If 'No' which shift are you available for (day/swing/graveyard)? -->
	<fieldset id="available_for_which_shifts" class="hide">
		<legend>If 'No' which shift are you available for (day/swing/graveyard)?</legend>
		<label><input type="checkbox" name="which_shifts" value="d" <% if instr(full_or_part_time, "d") > 0 then checked%>/> Day</label>
		<label><input type="checkbox" name="which_shifts" value="s" <% if instr(full_or_part_time, "s") > 0 then checked%>/> Swing</label>
		<label><input type="checkbox" name="which_shifts" value="g" <% if instr(full_or_part_time, "g") > 0 then checked%>/> Graveyard</label>
	</fieldset>	

	
	<!-- How soon will you be available to go to work? -->
	<fieldset>
		<legend id="lbl_special_availability">Any special circumstances regarding your work availability?</legend>
		<textarea name="special_availability" id="special_availabilty"><%=special_availability%></textarea><br>
		<p><i>An example of this is that often you may have one day of the week where you
			can’t work the same hours as the other days, etc., etc., or maybe you can work any day AND any shift up until when
			you go back to school, & will then only be available for a swing shift, etc.</i></p>
	</fieldset>
	

	<!-- What hourly wage are you willing to start at -->
	<fieldset>
		<legend id="lbl_wage_willing">What hourly wage are you willing to start at?</legend>
		<textarea name="wage_willing" id="wage_willing" maxlength="32" onkeyup="return ismaxlength(this)"><%=wage_willing%></textarea>
	</fieldset>
	<%=application_says_wage_willing%>

	
	<!-- Do you have a valid driver’s license -->
	<fieldset>
		<legend id="lbl_valid_dl">Do you have a valid driver’s license?</legend>
		<label><input type="radio" name="valid_dl" value="y" <% if valid_dl = "y" then checked%>/> Yes</label>
		<label><input type="radio" name="valid_dl" value="n" <% if valid_dl = "n" then checked%>/> No</label>
	</fieldset>
	<%=application_says_valid_dl%>
	
	<!-- Do you have proof of insurance? -->
	<fieldset>
		<legend id="lbl_proof_insured">Do you have proof of insurance?</legend>
		<label><input type="radio" name="proof_insured" value="y" <% if proof_insured = "y" then checked%>/> Yes</label>
		<label><input type="radio" name="proof_insured" value="n" <% if proof_insured = "n" then checked%>/> No</label>
	</fieldset>
	<%=application_says_proof_insured%>
	
	
	<!-- Do you have your own vehicle to use for getting to work?  If not, how do you plan to get to work -->
	<fieldset>
		<legend id="lbl_getting_there">Do you have your own vehicle to use for getting to work?  If not, how do you plan to get to work?</legend>
		<textarea name="getting_there" id="getting_there" maxlength="255" onkeyup="return ismaxlength(this)"><%=getting_there%></textarea>
	</fieldset>
	
	
	<!-- Are you looking for work only in the surrounding area, or how far are you willing to commute for work? -->
	<fieldset>
		<legend id="lbl_commute_willingness">Are you looking for work only in the surrounding area, or how far are you willing to commute for work?</legend>
		<textarea name="commute_willingness" id="commute_willingness" maxlength="255" onkeyup="return ismaxlength(this)"><%=commute_willingness%></textarea>
	</fieldset>
	
	<fieldset>
		<legend id="lbl_m_or_f">Do you have any misdemeanors or felonies?</legend>
		<label><input type="checkbox" name="m_or_f" value="n" onclick="cycle_mf_field(this.value)" <% if instr(m_or_f, "n") > 0 then checked%>/> No</label>
		<label><input type="checkbox" name="m_or_f" value="m" onclick="cycle_mf_field(this.value)" <% if instr(m_or_f, "m") > 0 then checked%>/> Misdemeanor</label>
		<label><input type="checkbox" name="m_or_f" value="f" onclick="cycle_mf_field(this.value)" <% if instr(m_or_f, "f") > 0 then checked%>/> Felony</label>
	</fieldset>
	<%=application_says_m_or_f%>
	
	<fieldset id="where_conviction_took_place" class="hide">
		<legend>When & where did the conviction(s) take place? <i>[this field will auto-hide/show]</i></legend>
		<textarea name="about_criminal" id="about_criminal" maxlength="255" onkeyup="return ismaxlength(this)"><%=about_criminal%></textarea>
	</fieldset>
	<%=application_says_about_criminal%>
	
	<fieldset>
		<legend id="lbl_on_porp">Are you currently on probation or parole?</legend>
		<label><input type="radio" name="on_porp" value="y" onclick="cycle_porp_field(this.value)" <% if on_porp = "y" then checked%>/> Yes</label>
		<label><input type="radio" name="on_porp" value="n" onclick="cycle_porp_field(this.value)" <% if on_porp = "n" then checked%>/> No</label>
	</fieldset>

	<fieldset id="porp_work_restrictions_field" class="hide"> 
		<legend>Do you have any work restrictions, mandatory meetings, appointments, or classes for Probation and/or Parole?</i></legend>
		<textarea name="porp_restrictions" id="porp_restrictions" maxlength="255" onkeyup="return ismaxlength(this)"><%=porp_restrictions%></textarea>
	</fieldset>
	
	<!-- Are you currently employed? -->
	<fieldset>
		<legend id="lbl_currently_employed">Are you currently employed?</legend>
		<label><input type="radio" name="currently_employed" value="y" <% if currently_employed = "y" then checked%>/> Yes</label>
		<label><input type="radio" name="currently_employed" value="n" <% if currently_employed = "n" then checked%>/> No</label>
	</fieldset>
	<%=application_says_currently_employed%>
	
	<!-- Can you pass a pre-employment drug screen? -->
	<fieldset>
		<legend id="lbl_pass_drug_screen">Can you pass a pre-employment drug screen?</legend>
		<label><input type="radio" name="pass_drug_screen" value="y" <% if pass_drug_screen = "y" then checked%>/> Yes</label>
		<label><input type="radio" name="pass_drug_screen" value="n" <% if pass_drug_screen = "n" then checked%>/> No</label>
	</fieldset>
	
	<!-- When would you be available to start work -->
	<fieldset>
		<legend id="lbl_can_start_work">When would you be available to start work?</legend>
		<textarea name="can_start_work" id="can_start_work" maxlength="32" onkeyup="return ismaxlength(this)"><%=can_start_work%></textarea>
	</fieldset>

	
	<!-- Do you have any other circumstances that we need to be aware of?  -->
	<fieldset>
		<legend id="lbl_needs_awareness">Do you have any other circumstances that we need to be aware of?</legend>
		<label><input type="radio" name="needs_awareness" value="y" onclick="cycle_awareness_field(this.value)" <% if needs_awareness = "y" then checked%>/> Yes</label>
		<label><input type="radio" name="needs_awareness" value="n" onclick="cycle_awareness_field(this.value)" <% if needs_awareness = "n" then checked%>/> No</label>
	</fieldset>
	
	<fieldset id="needs_awareness_notes_field" class="hide"> 
		<legend>What other circumstances do we need to be aware of?</i></legend>
		<textarea name="needs_awareness_notes" maxlength="255" onkeyup="return ismaxlength(this)"><%=needs_awareness_notes%></textarea>
	</fieldset>
	
	<!-- Review work history: -->
	<fieldset>
		<legend id="lbl_work_history">Review work history:</legend>
		<textarea name="work_history" id="work_history" maxlength="512" onkeyup="return ismaxlength(this)"><%=work_history%></textarea>
	</fieldset>
	<%=application_says_work_history%>
	
	<!-- Have you ever worked for a staffing service, or services, before?  -->
	<fieldset>
		<legend id="lbl_worked_for_staffing">Have you ever worked for a staffing service, or services, before?</legend>
		<label><input type="radio" name="worked_for_staffing" value="y" onclick="cycle_staffing_field(this.value)" <% if worked_for_staffing = "y" then checked%>/> Yes</label>
		<label><input type="radio" name="worked_for_staffing" value="n" onclick="cycle_staffing_field(this.value)" <% if worked_for_staffing = "n" then checked%>/> No</label>
	</fieldset>
	
	<fieldset id="worked_for_staffing_notes_field" class="hide"> 
		<legend>What other staffing services have you worked for [list supervisors names if known]?</i></legend>
		<textarea name="worked_for_staffing_notes" maxlength="255" onkeyup="return ismaxlength(this)"><%=worked_for_staffing_notes%></textarea>
	<p><i>Please list each staffing service on it's own line and list supervisors inside "[" brackets "]".<br>
			For example: Personnel Plus [Tony Mayer]</i></p>
	</fieldset>
	
	
	<!-- ask questions about gaps in employment, why they quit/were term’d, etc., what their job duties were, & make notes. -->
	<fieldset>
		<legend id="lbl_employment_gaps">Ask questions about gaps in employment, why they quit/were term’d, etc., what their job duties were, & make notes.</legend>
		<textarea name="employment_gaps" id="employment_gaps" maxlength="255" onkeyup="return ismaxlength(this)"><%=employment_gaps%></textarea>
	</fieldset>
	
	<!-- If they have any job skills that are evident from their work history that they did not mark on their skills inventory, add those. -->
	<fieldset>
		<legend id="lbl_more_skills">If they have any job skills that are evident from their work history that they did not mark on their skills inventory, add those.</legend>
		<textarea name="more_skills" id="more_skills" maxlength="255" onkeyup="return ismaxlength(this)"><%=more_skills%></textarea>
	</fieldset>

	<!-- Certifications or any high-skill areas? -->
	<fieldset>
		<legend id="lbl_certifications">Certifications or any high-skill areas?</legend>
		<textarea name="certifications" id="certifications" maxlength="255" onkeyup="return ismaxlength(this)"><%=certifications%></textarea>
	</fieldset>

	<!-- Resume? -->
	<fieldset>
		<legend id="lbl_have_resume">Resume? <i>[if yes, a "future" option to upload will drop in]</i></legend>
		<label><input type="radio" name="have_resume" value="y" <% if have_resume = "y" then checked%>/> Yes</label>
		<label><input type="radio" name="have_resume" value="n" <% if have_resume = "n" then checked%>/> No</label>
	</fieldset>
 
	<!-- Make sure all paperwork is filled out correctly & signed (including education info & emergency contact on back of app). -->
	<fieldset>
		<legend id="lbl_paperwork_completed">Make sure all paperwork is filled out correctly & signed (including education info & emergency contact on back of app).</legend>
		<label><input type="checkbox" name="paperwork_completed" value="y" <% if paperwork_completed = "y" then checked%>/> Completed</label>
	</fieldset>

	<!-- Review W4, verify information and that it has been filled out correctly & signed. -->
	<fieldset>
		<legend id="lbl_w4_reviewed">Review W4, verify information and that it has been filled out correctly & signed.</legend>
		<label><input type="checkbox" name="w4_reviewed" value="y" <% if w4_reviewed = "y" then checked%>/> Completed</label>
	</fieldset>

	<!-- Review I9, verify information and that it has been filled out correctly & signed. -->
	<fieldset>
		<legend id="lbl_i9_reviewed">Review I9, verify information and that it has been filled out correctly & signed.</legend>
		<label><input type="checkbox" name="i9_reviewed" value="y" <% if i9_reviewed = "y" then checked%>/> Completed</label>
	</fieldset>

	<!-- Ask if they have any questions on any of the policy statements or any documents they’ve signed. -->
	<fieldset>
		<legend id="lbl_any_questions">Ask if they have any questions on any of the policy statements or any documents they’ve signed.</legend>
		<label><input type="checkbox" name="any_questions" value="y" <% if any_questions = "y" then checked%>/> Asked</label>
	</fieldset>
	
	<!-- Give them a 'Welcome Packet', including a timesheet, & explain pay period & paydays; offer check, paycard or direct deposit. -->
	<fieldset>
		<legend id="lbl_welcome_given">Give them a 'Welcome Packet' [including a timesheet] & explain pay periods & paydays; offer check, paycard or direct deposit.</legend>
		<label><input type="checkbox" name="welcome_given" value="y" <% if welcome_given = "y" then checked%>/> Given</label>
	</fieldset>
 
	<!-- Give business card with phone numbers & explain about calling in for work. -->
	<fieldset>
		<legend id="lbl_calling_explained">Give business card with phone numbers & explain about calling in for work.</legend>
		<label><input type="checkbox" name="calling_explained" value="y" <% if calling_explained = "y" then checked%>/> Given and Explained</label>
	</fieldset>

	</div>
	<div id="complete_interview" class="buttonwrapper">
		<a class="squarebutton" href="#" onClick="complete_interview()">
		<span> Complete Interview </span></a></div>


   <%=decorateBottom()%>
</form>

<% noSocial = true %>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
