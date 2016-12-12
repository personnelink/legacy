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
	}
}


$( document ).ready(function() {

	console.log("ready.");

});

