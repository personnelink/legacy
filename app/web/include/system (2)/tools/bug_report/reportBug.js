document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

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

function check_field (formfield) {
	if (formfield.value == "") {
		field_is.bad(formfield.name);
	} else {
		field_is.good(formfield.name);
	}
}


function complete_report() {
	var okSoFar=true;
	var problems_are = "<b>Some of the bug report questions below were missed.</b><br /><span id=\"review\">Please review the following areas:</span>";
	var frmBugForm = document.messageBugForm
	
	//bug report Contact Information
	if (frmBugForm.bugContact.value == "")	{
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Please include contact info.</span>" + "<br>";
		field_is.bad('bugContact');
	} else {
		field_is.good('bugContact');
	}

	//bug report Subject
	if (frmBugForm.bugSubject.value == "")	{
		okSoFar=false;
		problems_are = problems_are + "<span class=\"badFields\">* Please enter a brief subject.</span>" + "<br>";
		field_is.bad('bugSubject');
	} else {
		field_is.good('bugSubject');
	}

	// //bug report Message
	// if ($(frmBugForm.bugBody).val() == "")	{
		// okSoFar=false;
		// problems_are = problems_are + "<span class=\"badFields\">* Please include some detail about the problem.</span>" + "<br>";
		// field_is.bad('bugBody');
	// } else {
		// field_is.good('bugBody');
	// }

	//send the bug report
	if (okSoFar != false){ 
		grayOut(true)
		document.messageBugForm.submit();
	
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

$(document).ready(function () {

	tinymce.init({
		selector:'textarea',
        mode : "textareas",
        plugins : "fullpage",
        theme_advanced_buttons3_add : "fullpage"
});

});
