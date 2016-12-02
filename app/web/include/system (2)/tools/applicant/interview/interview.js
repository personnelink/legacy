document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

var checkboxHeight = "25";
var radioHeight = "25";
var selectWidth = "190";

document.write('<style type="text/css">input.styled { display: none; } select.styled { position: relative; width: ' + selectWidth + 'px; opacity: 0; filter: alpha(opacity=0); z-index: 5; }</style>');


var Custom = {
	init: function() {
		title_this(document.getElementById('page_title').value);
		var inputs = document.getElementsByTagName("input"), span = Array(), textnode, option, active;
		for(a = 0; a < inputs.length; a++) {
			if(inputs[a].type == "checkbox" || inputs[a].type == "radio") {
				if (inputs[a].className == "styled") {
					span[a] = document.createElement("span");
					span[a].className = inputs[a].type;

					if(inputs[a].checked == true) {
						if(inputs[a].type == "checkbox") {
							position = "0 -" + (checkboxHeight*2) + "px";
							span[a].style.backgroundPosition = position;
						} else {
							position = "0 -" + (radioHeight*2) + "px";
							span[a].style.backgroundPosition = position;
						}
					}
					inputs[a].parentNode.insertBefore(span[a], inputs[a]);
					inputs[a].onchange = Custom.clear;
					span[a].onmousedown = Custom.pushed;
					span[a].onmouseup = Custom.check;
					document.onmouseup = Custom.clear;
				}
				//turn off radio and checkbox auto-completes
				inputs[a].setAttribute("autocomplete", "off");
			}
		}
		inputs = document.getElementsByTagName("select");
		for(a = 0; a < inputs.length; a++) {
			if(inputs[a].className == "styled") {
				option = inputs[a].getElementsByTagName("option");
				active = option[0].childNodes[0].nodeValue;
				textnode = document.createTextNode(active);
				for(b = 0; b < option.length; b++) {
					if(option[b].selected == true) {
						textnode = document.createTextNode(option[b].childNodes[0].nodeValue);
					}
				}
				span[a] = document.createElement("span");
				span[a].className = "select";
				span[a].id = "select" + inputs[a].name;
				span[a].appendChild(textnode);
				inputs[a].parentNode.insertBefore(span[a], inputs[a]);
				inputs[a].onchange = Custom.choose;
			}
		}
		// show or hide conviction explaination textarea
		var init_mf_note = document.interviewFrm.m_or_f;
		var mf_no = 0;
		if (init_mf_note[mf_no].checked == true) {
			hidethis("where_conviction_took_place");
		} else if (init_mf_note[1].checked == true || init_mf_note[2].checked) {
			showthis("where_conviction_took_place");
		}
		
		//safe function to hide or show field based on probation or parole selection
		var porp_field = document.interviewFrm.on_porp;
		if (porp_field[0].checked == true) {
			showthis('porp_work_restrictions_field');
		} else {
			hidethis('porp_work_restrictions_field');
		}
		
		//safe function to hide or show field based on other circumstances selection
		var circumstances = document.interviewFrm.needs_awareness;
		if (circumstances[0].checked == true) {
			showthis('needs_awareness_notes_field');
		} else {
			hidethis('needs_awareness_notes_field');
		}
		
		//safe function to hide or show field based on if they've worked for staffing services
		var circumstances = document.interviewFrm.worked_for_staffing;
		if (circumstances[0].checked == true) {
			showthis('worked_for_staffing_notes_field');
		} else {
			hidethis('worked_for_staffing_notes_field');
		}
	},
	pushed: function() {
		element = this.nextSibling;
		if(element.checked == true && element.type == "checkbox") {
			this.style.backgroundPosition = "0 -" + checkboxHeight*3 + "px";
		} else if(element.checked == true && element.type == "radio") {
			this.style.backgroundPosition = "0 -" + radioHeight*3 + "px";
		} else if(element.checked != true && element.type == "checkbox") {
			this.style.backgroundPosition = "0 -" + checkboxHeight + "px";
		} else {
			this.style.backgroundPosition = "0 -" + radioHeight + "px";
		}
	},
	check: function() {
		element = this.nextSibling;
		if(element.checked == true && element.type == "checkbox") {
			this.style.backgroundPosition = "0 0";
			element.checked = false;
		} else {
			if(element.type == "checkbox") {
				this.style.backgroundPosition = "0 -" + checkboxHeight*2 + "px";
			} else {
				this.style.backgroundPosition = "0 -" + radioHeight*2 + "px";
				group = this.nextSibling.name;
				inputs = document.getElementsByTagName("input");
				for(a = 0; a < inputs.length; a++) {
					if(inputs[a].name == group && inputs[a] != this.nextSibling) {
						inputs[a].previousSibling.style.backgroundPosition = "0 0";
					}
				}
			}
			element.checked = true;
		}
	},
	clear: function() {
		inputs = document.getElementsByTagName("input");
		for(var b = 0; b < inputs.length; b++) {
			if(inputs[b].type == "checkbox" && inputs[b].checked == true && inputs[b].className == "styled") {
				inputs[b].previousSibling.style.backgroundPosition = "0 -" + checkboxHeight*2 + "px";
			} else if(inputs[b].type == "checkbox" && inputs[b].className == "styled") {
				inputs[b].previousSibling.style.backgroundPosition = "0 0";
			} else if(inputs[b].type == "radio" && inputs[b].checked == true && inputs[b].className == "styled") {
				inputs[b].previousSibling.style.backgroundPosition = "0 -" + radioHeight*2 + "px";
			} else if(inputs[b].type == "radio" && inputs[b].className == "styled") {
				inputs[b].previousSibling.style.backgroundPosition = "0 0";
			}
		}
	},
	choose: function() {
		option = this.getElementsByTagName("option");
		for(d = 0; d < option.length; d++) {
			if(option[d].selected == true) {
				document.getElementById("select" + this.name).childNodes[0].nodeValue = option[d].childNodes[0].nodeValue;
			}
		}
	}
}


function hideallids(){
	//loop through the array and hide each element by id
	for (var i=0;i<ids.length;i++){
		hidediv(ids[i]);
	}		  
}

function hidethis(id) {
	//safe function to hide an element with a specified id
	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).className = 'hide';
	}
}

function showthis(id) {
	//safe function to show an element with a specified id
		  
	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).className = 'show';
	}
}

function cycle_days_field(fieldvalue) {
	//safe function to select/deselect days of week available field based on selection
	var any = 0;
	var days_field = document.interviewFrm.days_available;
	
	if (fieldvalue == "128") {
		for (i=0; i<8; i++)
			days_field[i].checked = true;
	} else {
		for (i=0; i<8; i++) {
			if (days_field[i].checked == false) {
				days_field[any].checked = false;
			}
		}
	}
}

function cycle_which_shifts(fieldvalue) {
	//safe function to hide or show field based on probation or parole selection
	
	if (fieldvalue == "n") {
		showthis('available_for_which_shifts');
	} else if (fieldvalue == "y") {
		hidethis('available_for_which_shifts');
	}
}

function cycle_mf_field(fieldvalue) {
	//safe function to hide or show field based on misdemeanor or felony selection
	var mf_no = 0;
	var misdem = 1;
	var felony = 2;
	var mf_short = document.interviewFrm.m_or_f;
	
	if (fieldvalue == "n") {
		for (i=1; i<3; i++)
			mf_short[i].checked = false;
		hidethis('where_conviction_took_place');
	} else if (mf_short[misdem].checked || mf_short[felony].checked) {
		mf_short[mf_no].checked = false;
		showthis('where_conviction_took_place');
	}
}

function cycle_porp_field(fieldvalue) {
	//safe function to hide or show field based on probation or parole selection
	
	if (fieldvalue == "y") {
		showthis('porp_work_restrictions_field');
	} else if (fieldvalue == "n") {
		hidethis('porp_work_restrictions_field');
	}
}

function cycle_awareness_field(fieldvalue) {
	//safe function to hide or show field based on other circumstances we need to be aware of selection
	
	if (fieldvalue == "y") {
		showthis('needs_awareness_notes_field');
	} else if (fieldvalue == "n") {
		hidethis('needs_awareness_notes_field');
	}
}


function cycle_staffing_field(fieldvalue) {
	//safe function to hide or show field based on past work with other staffing services before
	
	if (fieldvalue == "y") {
		showthis('worked_for_staffing_notes_field');
	} else if (fieldvalue == "n") {
		hidethis('worked_for_staffing_notes_field');
	}
}


/**
 * DHTML phone number validation script. Courtesy of SmartWebby.com (http://www.smartwebby.com/dhtml/)
 */

// Declaring required variables
var digits = "0123456789";
// non-digit characters which are allowed in phone numbers
var phoneNumberDelimiters = "()- ";
// characters which are allowed in international phone numbers
// (a leading + is OK)
var validWorldPhoneChars = phoneNumberDelimiters + "+";
// Minimum no of digits in an international phone no.
var minDigitsInIPhoneNumber = 10;

function isInteger(s)
{   var i;
	for (i = 0; i < s.length; i++)
	{   
		// Check that current character is number.
		var c = s.charAt(i);
		if (((c < "0") || (c > "9"))) return false;
	}
	// All characters are numbers.
	return true;
}

function stripCharsInBag(s, bag)
{   var i;
	var returnString = "";
	// Search through string's characters one by one.
	// if character is not in bag, append to returnString.
	for (i = 0; i < s.length; i++)
	{   
		// Check that current character isn't whitespace.
		var c = s.charAt(i);
		if (bag.indexOf(c) == -1) returnString += c;
	}
	return returnString;
}

function ismaxlength(obj){
	var mlength=obj.getAttribute? parseInt(obj.getAttribute("maxlength")) : ""
	if (obj.getAttribute && obj.value.length>mlength)
	obj.value=obj.value.substring(0,mlength)
}

var field_is = {
	good: function(id) {
		//document.getElementById("lbl_"+id).setAttribute("font-weight", "normal");
		//document.getElementById("lbl_"+id).setAttribute("color", "");
		document.getElementById("lbl_"+id).className='fieldIsGood';	
		return false;
	},
	bad: function(id) {
		//document.getElementById("lbl_"+id).setAttribute("font-weight", "bold");
		//document.getElementById("lbl_"+id).setAttribute("color", "red");
		document.getElementById("lbl_"+id).className = 'fieldIsBad';
		return false;
	}
}

function complete_interview() {
	var okSoFar=true;
	var problems_are = "<b>Some of the interview questions below were missed.</b><br /><span id=\"review\">Review the following questions:</span>";

	//kind_of_work
	if (document.interviewFrm.kind_of_work.value == "")	{
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* What kind of work are you looking for?</span>" + "<br>";
		field_is.bad('kind_of_work');
	} else {
		field_is.good('kind_of_work');
	}

	//full_or_part_time
	var this_box = document.interviewFrm.full_or_part_time
	if (this_box[0].checked == false && this_box[1].checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Are you willing to accept full-time AND/OR part-time work?</span>" + "<br>";
		field_is.bad('full_or_part_time');
	} else {
		field_is.good('full_or_part_time');
	}		

	//accept_temporary
	var this_box = document.interviewFrm.accept_temporary
	if (this_box[0].checked == false && this_box[1].checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Are you willing to accept temporary assignments (short-term or “day jobs”)?</span>" + "<br>";
		field_is.bad('accept_temporary');
	} else {
		field_is.good('accept_temporary');
	}		

	//accept_longterm
	var this_box = document.interviewFrm.accept_longterm
	if (this_box[0].checked == false && this_box[1].checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Are you willing to accept long-term or temp-to-hire positions?</span>" + "<br>";
		field_is.bad('accept_longterm');
	} else {
		field_is.good('accept_longterm');
	}		

	//work_any_shift
	var this_box = document.interviewFrm.work_any_shift
	if (this_box[0].checked == false && this_box[1].checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Can you work any shift?</span>" + "<br>";
		field_is.bad('work_any_shift');
	} else {
		field_is.good('work_any_shift');
	}		

	//special_availability
	if (document.interviewFrm.special_availability.value == "")	{
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Any special circumstances regarding your work availability??</span>" + "<br>";
		field_is.bad('special_availability');
	} else {
		field_is.good('special_availability');
	}

	//wage_willing
	if (document.interviewFrm.wage_willing.value == "")	{
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* What hourly wage are you willing to start at?</span>" + "<br>";
		field_is.bad('wage_willing');
	} else {
		field_is.good('wage_willing');
	}
	
	//valid_dl
	var this_box = document.interviewFrm.valid_dl
	if (this_box[0].checked == false && this_box[1].checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Can you work any shift?</span>" + "<br>";
		field_is.bad('valid_dl');
	} else {
		field_is.good('valid_dl');
	}		
	
	//proof_insured
	var this_box = document.interviewFrm.proof_insured
	if (this_box[0].checked == false && this_box[1].checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Do you have proof of insurance?</span>" + "<br>";
		field_is.bad('proof_insured');
	} else {
		field_is.good('proof_insured');
	}		

	//getting_there
	if (document.interviewFrm.getting_there.value == "")	{
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Do you have your own vehicle to use for getting to work?  If not, how do you plan to get to work?</span>" + "<br>";
		field_is.bad('getting_there');
	} else {
		field_is.good('getting_there');
	}

	//commute_willingness
	if (document.interviewFrm.commute_willingness.value == "")	{
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Are you looking for work only in the surrounding area, or how far are you willing to commute for work?</span>" + "<br>";
		field_is.bad('commute_willingness');
	} else {
		field_is.good('commute_willingness');
	}
	
	//m_or_f
	var this_box = document.interviewFrm.m_or_f
	if (this_box[0].checked == false && this_box[1].checked == false && this_box[2].checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Do you have any misdemeanors or felonies?</span>" + "<br>";
		field_is.bad('m_or_f');
	} else {
		field_is.good('m_or_f');
	}

	//on_porp
	var this_box = document.interviewFrm.on_porp
	if (this_box[0].checked == false && this_box[1].checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Are you currently on probation or parole?</span>" + "<br>";
		field_is.bad('on_porp');
	} else {
		field_is.good('on_porp');
	}		

	//currently_employed
	var this_box = document.interviewFrm.currently_employed
	if (this_box[0].checked == false && this_box[1].checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Are you currently employed?</span>" + "<br>";
		field_is.bad('currently_employed');
	} else {
		field_is.good('currently_employed');
	}
	
	//pass_drug_screen
	var this_box = document.interviewFrm.pass_drug_screen
	if (this_box[0].checked == false && this_box[1].checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Can you pass a pre-employment drug screen?</span>" + "<br>";
		field_is.bad('pass_drug_screen');
	} else {
		field_is.good('pass_drug_screen');
	}

	//can_start_work
	if (document.interviewFrm.can_start_work.value == "")	{
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Are you looking for work only in the surrounding area, or how far are you willing to commute for work?</span>" + "<br>";
		field_is.bad('can_start_work');
	} else {
		field_is.good('can_start_work');
	}

	//needs_awareness
	var this_box = document.interviewFrm.needs_awareness
	if (this_box[0].checked == false && this_box[1].checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Do you have any other circumstances that we need to be aware of?</span>" + "<br>";
		field_is.bad('needs_awareness');
	} else {
		field_is.good('needs_awareness');
	}
	
	//work_history
	if (document.interviewFrm.work_history.value == "")	{
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Review work history.</span>" + "<br>";
		field_is.bad('work_history');
	} else {
		field_is.good('work_history');
	}

	//worked_for_staffing
	var this_box = document.interviewFrm.worked_for_staffing
	if (this_box[0].checked == false && this_box[1].checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Have you ever worked for a staffing service before?</span>" + "<br>";
		field_is.bad('worked_for_staffing');
	} else {
		field_is.good('worked_for_staffing');
	}

	//employment_gaps
	if (document.interviewFrm.employment_gaps.value == "")	{
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Ask questions about gaps in employment, why they quit/were term’d, etc., what their job duties were, & make notes.</span>" + "<br>";
		field_is.bad('employment_gaps');
	} else {
		field_is.good('employment_gaps');
	}

	//more_skills
	if (document.interviewFrm.more_skills.value == "")	{
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* If they have any job skills that are evident from their work history that they did not mark on their skills inventory, add those.</span>" + "<br>";
		field_is.bad('more_skills');
	} else {
		field_is.good('more_skills');
	}
	
	//certifications
	if (document.interviewFrm.certifications.value == "")	{
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Certifications or any high-skill areas?</span>" + "<br>";
		field_is.bad('certifications');
	} else {
		field_is.good('certifications');
	}

	//have_resume
	var this_box = document.interviewFrm.have_resume
	if (this_box[0].checked == false && this_box[1].checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Resume?</span>" + "<br>";
		field_is.bad('have_resume');
	} else {
		field_is.good('have_resume');
	}

	//paperwork_completed
	var this_box = document.interviewFrm.paperwork_completed
	if (this_box.checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Make sure all paperwork is filled out correctly & signed.</span>" + "<br>";
		field_is.bad('paperwork_completed');
	} else {
		field_is.good('paperwork_completed');
	}
	
	//w4_reviewed
	var this_box = document.interviewFrm.w4_reviewed
	if (this_box.checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Make sure W4 has been filled out correctly & signed.</span>" + "<br>";
		field_is.bad('w4_reviewed');
	} else {
		field_is.good('w4_reviewed');
	}
	
	//i9_reviewed
	var this_box = document.interviewFrm.i9_reviewed
	if (this_box.checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Make sure I9 has been filled out correctly & signed.</span>" + "<br>";
		field_is.bad('i9_reviewed');
	} else {
		field_is.good('i9_reviewed');
	}
	
	//any_questions
	var this_box = document.interviewFrm.any_questions
	if (this_box.checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Ask if they have any questions on any of the policy statements or any documents they’ve signed.</span>" + "<br>";
		field_is.bad('any_questions');
	} else {
		field_is.good('any_questions');
	}

	//welcome_given
	var this_box = document.interviewFrm.welcome_given
	if (this_box.checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Welcome packet given?</span>" + "<br>";
		field_is.bad('welcome_given');
	} else {
		field_is.good('welcome_given');
	}
	
	//calling_explained
	var this_box = document.interviewFrm.calling_explained
	if (this_box.checked == false){
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Give business card with phone numbers & explain about calling in for work.</span>" + "<br>";
		field_is.bad('calling_explained');
	} else {
		field_is.good('calling_explained');
	}

	if (okSoFar != false){ 
		grayOut(true)
		var agree=confirm("Ready to complete the interview?");
			if (agree){
				document.interviewFrm.frmAction.value='completed';
				document.interviewFrm.submit();
			} else {
				grayOut(false)
				return false;
			}
	
	} else {
		document.getElementById('missing_stuff').className = 'show marLR10';
		document.getElementById("missed_items").innerHTML = problems_are;
		return false;
	} 
}

function saveApplication(gohere){	
	grayOut(true)
	document.application.formAction.value='save';
	document.application.wheretogo.value=gohere;
	document.application.submit();
}


window.onload = Custom.init;
