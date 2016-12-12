document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');
		
		
function get_appointments() {
	var appointments_element = document.getElementById("appointments");
	if (appointments_element != null){
		getAppointments();
		// window.setInterval(getAppointments, 900000);
		window.setInterval(getAppointments, 900000);
	}
}

var getAppointments = function () {
	document.getElementById("appointments").className = "working";
	document.getElementById("busyoverlay").style.display="block";
	foruser = document.getElementById("onlyme");
	var tUser = "";
	if (foruser.checked) {
		tUser = document.getElementById("tUser_Id").value;
	}
	doAJAXCall('/include/system/tools/activity/reports/appointments/?isservice=true&onlyactive=1&for='+tUser, 'GET', '', showAppointmentsResponse);

}


//we need to check to see if who = unemployment, if = unemployment then smoke.alert Please contact PP at office. If not unemployment then What kind of work. 
//we need to connect "unemployment" to the actual database and make certain that it is equalling correctly!!!!!!!!!!!!
/* function get_unemployment() {
var employable = document.getElementById("signApplicantIn").value;
	if (employable = "3710") {
	smoke.alert("Please contact us at PPlus");
	
	} else {
		smoke.prompt("What kind of work are you looking for?", function(e){
			if (e =="Yes"){
		
				return true;			
			} else {
				
			}, 
			{
				ok: "Submit",
				cancel: "Cancel",
				classname: "custom-class",
				reverseButtons: true,
				value: ""
			});
		}
	}
} */
	
function retrieve_messages() {
	var messages_element = document.getElementById("messages");
	if (messages_element != null){
		getMessages();
	}
}

var getMessages = function () {
	var PostStr = "";
	doAJAXCall('/include/system/tools/activity/blogs/?isservice=true'+PostStr, 'POST', '' + PostStr + '', showMessageResponse);
}


var showMessageResponse = function (oXML) { 
    var response = oXML.responseText;
	document.getElementById("messages").innerHTML = response;
};

var showAppointmentsResponse = function (oXML) { 
    var response = oXML.responseText;
	if (response.length > 0) {
		document.getElementById("appointmentsheader").className = "show";
		var Appointments = document.getElementById("appointments")
		document.getElementById("busyoverlay").style.display="none";
		Appointments.className = "show";
		Appointments.innerHTML = response;
		if (response.indexOf("<i>No appointments or placement follow-ups</i>") > 0) {
				Appointments.className = "noappointments";
		} else {
				Appointments.className = "appointments";
		}
		alarm.check('', '');
	}
};

var drugtest = {
	upload: function () {
		grayOut(true);
	}
}

var retrieve = {
	w2: function() {
		var year = prompt("Retrieve for which W2 year?");
		var site = prompt("Which company code?");
		var w2id = prompt("What is the applicant id?");
		console.log("thank you");
		if (year!=null || site!=null ||w2id!=null) {
			window.location.href = "https://www.personnelinc.com/pdfServer/pdfW2/?year="+year+"&site="+site+"&id="+w2id+"&action=agreeanddownload";
		} else {
			alert("Missing some info, aborting.");
		}
	},
	invoice:  function() {
				
		var site = prompt("Retrieve for which company code?");
		var customer = prompt("Retrieve for which customer code?");
		var invoice = prompt("Which invoice?");
		console.log("thank you");
		if (site!=null || customer!=null ||invoice!=null) {
			window.location.href = "https://www.personnelinc.com/include/system/services/sendPDF.asp?site="+site+"&customer="+customer+"&id="+invoice+"&cat=inv";
		} else {
			alert("Missing some info, aborting.");
		}
	}
};

var slide = {
	closed: function(trigger_elem, target_elem) {
		$("#"+target_elem).slideUp();
		$("#"+target_elem).onclick = slide.open(trigger_elem, target_elem);
	},
	open: function(trigger_elem, target_elem) {
		$("#"+target_elem).slideUp();
		$("#"+target_elem).onclick = slide.open(trigger_elem, target_elem);
	}
};



$( document ).ready(function() {
	// debugger
	// $("hm_p_58_1").onclick = function() { slide.closed('hm_span_68_1','hm_p_58_1'); };
	// $("hm_p_58_1").trigger("onclick");
	get_appointments();
	console.log("ready.");

});

