document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

var checkboxHeight = "25";
var radioHeight = "25";
var selectWidth = "190";


document.write('<style type="text/css">input.styled { display: none; } select.styled { position: relative; width: ' + selectWidth + 'px; opacity: 0; filter: alpha(opacity=0); z-index: 15; }</style>');

var Custom = {
	init: function() {
		var inputs = document.getElementsByTagName("input"), span = Array(), textnode, option, active;
		for(a = 0; a < inputs.length; a++) {
			if((inputs[a].type == "checkbox" || inputs[a].type == "radio") && inputs[a].className == "styled") {
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
				document.whoseHereForm.submit();

			}
		}
	}
}

var swipe_timer;
function lookup_id() {
		clearTimeout(swipe_timer);
		
		console.log('lookup_id');
		
		current_site = "";
		current_placement = "";
		current_applicant = "";
		current_customer = "";
		
		swipe_timer = setTimeout("user_info.lookup()",500);
}

// function check_swipe(event) {
	// console.log(event.keyCode);
	// if (event.keyCode == 191) {
		// lookup_id();
	// }
// }

function check_swipe() {
	clearInterval('focus_reset()');
	lookup_id();
}

var server_time_offset = 0;
var serverTime = {
	update: function() {
		console.log('update time offset');
		var PostStr = "do=gettime";
		doAJAXCall('/time/clock/ajax/server.time.asp', 'HEAD', '' + PostStr + '', serverTime.calcOffset);
	},
	calcOffset: function(oXML) {
		// console.log(oXML.response);
	
	    var dateStr = oXML.getResponseHeader('Date');
		// console.log("Date: "+dateStr);
		
		if (!isNaN(dateStr)) {
			var serverTimeMillisGMT = Date.parse(new Date(Date.parse(dateStr)).toUTCString());
			var localMillisUTC = Date.parse(new Date().toUTCString());
			
			server_time_offset = serverTimeMillisGMT -  localMillisUTC;
				// console.log(dateStr);
				// console.log(serverTimeMillisGMT);
				// console.log(localMillisUTC);
		}		// console.log(server_time_offset);
	},
	get: function() {
		var date = new Date();

		date.setTime(date.getTime() + server_time_offset);
		console.log(date);
		return date;
	}
}

setInterval('wall_clock()', 60000 );
setInterval('serverTime.update()', 1800000 ); // Check server every 30 minutes for server time offset
function wall_clock() {
	if (!isNaN(server_time_offset)) {
		// get current time
		var currentTime = new Date ( );
		currentTime.setTime(currentTime.getTime()+server_time_offset);
		
		// extract the hours, minutes and seconds components
		var currentHours = currentTime.getHours ( );
		var currentMinutes = currentTime.getMinutes ( );
		var currentSeconds = currentTime.getSeconds ( );

		var currentDay = currentTime.getDate ( );
		var currentYear = currentTime.getFullYear();
		
		var weekday=new Array(7);
		weekday[0]="Sunday";
		weekday[1]="Monday";
		weekday[2]="Tuesday";
		weekday[3]="Wednesday";
		weekday[4]="Thursday";
		weekday[5]="Friday";
		weekday[6]="Saturday";

		var currentWeekDay = weekday[currentTime.getDay()];
		
		// return month instead of number
		var month=new Array();
		month[0]="January";
		month[1]="February";
		month[2]="March";
		month[3]="April";
		month[4]="May";
		month[5]="June";
		month[6]="July";
		month[7]="August";
		month[8]="September";
		month[9]="October";
		month[10]="November";
		month[11]="December";
		var currentMonth = month[currentTime.getMonth()];
			
		// format the time "HH:MM:SS XX"
		currentMinutes = ( currentMinutes < 10 ? "0" : "" ) + currentMinutes;
		// currentSeconds = ( currentSeconds < 10 ? "0" : "" ) + currentSeconds;

		// fix of time of day to show AM or PM and 12 instead of 0
		var timeOfDay = ( currentHours < 12 ) ? "AM" : "PM";
		currentHours = ( currentHours > 12 ) ? currentHours - 12 : currentHours;
		currentHours = ( currentHours == 0 ) ? 12 : currentHours;
		
		// var currentTimeString = currentHours + ":" + currentMinutes + ":" + currentSeconds + " " + timeOfDay;
		var currentTimeString = currentHours + ":" + currentMinutes + " " + timeOfDay;
		var currentDateString = currentMonth + " " + currentDay + ", " + currentYear + ", " + currentWeekDay;

		document.getElementById("time_span").firstChild.nodeValue = currentTimeString;
		document.getElementById("date_span").firstChild.nodeValue = currentDateString;
	}

}

var success_timer;
success_timer = setTimeout("user_info.clear_success()",2000);
var focus_timer = 5000;

setInterval('focus_reset()',focus_timer);

setInterval('shift_background()',30000);
function shift_background() {
	// screen saver / scroll background
	var obj = document.getElementsByTagName('body')[0];
	var att=['backgroundPosition']
	getStyle(obj,att);
	var bgpos = obj[att[0]].split('%');
	var newXpos = (parseFloat(bgpos[0]) +0.1);
	if (newXpos >100){newXpos = 0};
	document.body.style.backgroundPosition = newXpos.toFixed(1)+"% 0%";
}

function focus_reset(){
	$("#siteid_applicantid").focus();
	// $("#siteid_applicantid").select();
}

function getStyle(obj,att){
	for(var i=0;i<att.length;i++){
		if(window.getComputedStyle){
		obj[att[i]]=window.getComputedStyle(obj,null)[att[i]];
		}
		else if(obj.currentStyle){
		obj[att[i]]=obj.currentStyle[att[i]];
		}
	}
}

supports_html5_storage();
function supports_html5_storage() {
  try {
    return 'localStorage' in window && window['localStorage'] !== null;
	console.log('local storage available');
 	} catch (e) {
  
	console.log('local storage not available');
  return false;
  }
}

var current_site = "";
var current_placement = "";
var current_applicant = "";
var current_customer = "";


var user_info_timer;
var user_info = {
	lookup: function () {
		grayOut(true);
		
		var link = document.getElementById('id_container');
		link.style.display = 'none';
		
		// $("#id_container").slideUp( "slow", function() {
			// // Animation complete.
		// });
		
		//suspend focus reset card swipe until ajax completes
		clearInterval('focus_reset()');
		
		//clear previous action artifacts if present
		document.getElementById("clock_action_results").style.display="none";
		
		//get swipe input
		var search = document.getElementById("siteid_applicantid").value;

		// %000020021PERPERSON;
		if(search==='%000020021000AGEXPR?%000020021000AGEXPR?#000020021000AGEXPR?'){search='%000020021PERPERSON;';} // me
		else if (search==='jerche'){search='%000029944PERJERCHE;';} // employee test user
		else if (search==='gus'){search='%000020021PERPERSON;;';} // employee test user
		// (my id) else if (search==='%000026533IDAIDANAM?'){search='%000020021PERPERSON;';} // random card found in desk that had data encoded on it and used for debugging
		
		// basic error correction, from three encoded tracks grab longest and assume most complete =)
		var idcard = search.split("?");
		var longest_swipe = "";
		
		for (var i=0;i<idcard.length;i++){
			if (idcard[i].length > longest_swipe.length) {
				longest_swipe = idcard[i];
			}
		
		}
		
		var applicant = Number(longest_swipe.substring(1, 10));
		var site = longest_swipe.substring(10, 13);
		var customer = longest_swipe.substring(13, 19);
		
		current_customer = customer;
		current_site = site;
		current_applicant = applicant;
		
		console.log(applicant);
		console.log(site);
		console.log(customer);
		
		$("#siteid_applicantid").val("");
		
		if (isNaN(applicant)!=true){
			// var PostStr = "do=getuserdetail&site=0&id=20021"+search.value;
			var PostStr = "";
			var GetStr = "do=getuserdetail&use_qs=1&site="+site+"&applicantid="+applicant+"&customer="+customer;
			doAJAXCall('/time/clock/ajax/', 'GET', '' + GetStr + '', user_info.update);
			// window.location.replace(document.URL+"do/"); // alternate clock method, paused in leu of perl application being built
		} else {
			document.getElementById("cost_center").innerHTML = $("#readerror").html();
			grayOut(false);
			clearTimeout(user_info_timer);		
			user_info_timer = setTimeout("user_info.clear()", 2000);

		}
		return false;
		
	},
	update: function (oXML) {
		var response = oXML.responseText;
		if (response.indexOf('Microsoft OLE DB Provider for ODBC Drivers error') != 0) {

		document.getElementById("user_info_div").innerHTML = response;
		
		var PostStr = "";
		console.log("customer: "+current_customer);
		var GetStr = "do=getcostcenters&use_qs=1&site="+current_site+"&applicantid="+current_applicant+"&customer="+current_customer;
		doAJAXCall('/time/clock/ajax/', 'GET', '' + GetStr + '', cost_centers.update);
		
		} else {
			document.getElementById("user_info_div")
		}
		clearTimeout(user_info_timer);		
		user_info_timer = setTimeout("user_info.clear()", 2000);
		return false;
	},
	clear: function() {
		document.getElementById("user_info_div").innerHTML = "";
		document.getElementById("cost_center").innerHTML = "";
		document.getElementById("chose_action").innerHTML = "";
		document.getElementById("clock_action_results").innerHTML = "";
		var siteid = document.getElementById("siteid_applicantid");
		siteid.value = "";
		siteid.focus();
		
		clearTimeout(user_info_timer);
		this.clear_success;
		
		// $("#id_container").slideDown( "slow", function() {
			// // Animation complete.
		// });
		var link = document.getElementById('id_container');
		link.style.display = 'block';

		grayOut(false);
		

	},	
	clear_success: function() {
		console.log("clearing success...");
		grayOut(false);
		
		
		// $("#id_container").slideDown( "slow", function() {
			// // Animation complete.
		// });
		
		var link = document.getElementById('id_container');
		link.style.display = 'block';
		
		clearTimeout(success_timer);
		var success_div = document.getElementById("clock_action_results")
		
		if (typeof success_div!='undefined' && success_div !=null) {
			success_div.style.display="none";
		}
	}
}

var cost_centers = {
	update: function (oXML) {
		var response = oXML.responseText;
		document.getElementById("cost_center").innerHTML = response;
		console.log(response.indexOf("swipe processing error"));
		if (response.indexOf("swipe processing error") ==-1) {
		
			var startPlacemntId = response.indexOf("<!-- first placement id=[")+25;
			
			current_placement = response.substring(startPlacemntId, response.indexOf("] -->"));
			
			console.log(current_placement)
		
			cost_centers.get_actions(current_placement, current_applicant, current_site, current_customer);

		} else {
			grayOut(false);
		}
		clearTimeout(user_info_timer);		
		user_info_timer = setTimeout("user_info.clear()", 2000);
		setInterval('focus_reset()',focus_timer);

},
	get_actions: function(placementid, applicantid, siteid, customer){
		// var PostStr = "do=getuserdetail&site=0&id=20021"+search.value;
		var PostStr = "";
		var GetStr = "do=gettimeclock&use_qs=1&site="+siteid+"&id="+placementid+"&applicantid="+applicantid+"&customer="+customer;
		doAJAXCall('/time/clock/ajax/', 'GET', '' + GetStr + '', timeclock.show_actions);
	},
	show_action: function(){

	},
	set: function(placementid, applicantid, siteid, customer) {
		cost_centers.get_actions(placementid, applicantid, siteid, customer);
	}
	
}

var timeclock = {
	show_actions: function (oXML) {
		var action_div = document.getElementById("chose_action")
		
		action_div.style.display="block";
		action_div.innerHTML = oXML.responseText;
		grayOut(false);

		// give user time extension
		clearTimeout(user_info_timer);		
		user_info_timer = setTimeout("user_info.clear()", 2000);
		
	},
	clockin: function(placementid, siteid, customer, applicantid){
		grayOut(true);

		// var PostStr = "do=getuserdetail&site=0&id=20021"+search.value;
		var PostStr = "do=doclockin&site="+siteid+"&id="+placementid+"&applicantid="+applicantid+"&customer="+customer;
		doAJAXCall('/time/clock/ajax/', 'POST', '' + PostStr + '', timeclock.show_status);
	},
	clockout: function(placementid, siteid, customer, applicantid) {
		grayOut(true);

		// var PostStr = "do=getuserdetail&site=0&id=20021"+search.value;
		var PostStr = "do=doclockout&site="+siteid+"&id="+placementid+"&applicantid="+applicantid+"&customer="+customer;
		doAJAXCall('/time/clock/ajax/', 'POST', '' + PostStr + '', timeclock.show_status);	
	},
	show_status: function(oXML) {
		grayOut(false);
		document.getElementById("cost_center").innerHTML = "";
		document.getElementById("chose_action").innerHTML = "";
		var clock_action_results = document.getElementById("clock_action_results");
		clock_action_results.style.display="block";	
		clock_action_results.innerHTML = oXML.responseText;
		focus_reset();
	},
	update: function (oXML) {
		var response = oXML.responseText;
		document.getElementById("user_info_div").innerHTML = response;
		
		clearTimeout(user_info_timer);		
		user_info_timer = setTimeout("user_info.clear()", 2000);
		return false;
	},
	clear: function() {
		console.log("clearing...");
		document.getElementById("user_info_div").innerHTML = "";
		document.getElementById("cost_center").innerHTML = "";
		document.getElementById("chose_action").innerHTML = "";

		// $("#id_container").slideDown( "slow", function() {
			// // Animation complete.
		// });

		var link = document.getElementById('id_container');
		link.style.display = 'block';

		clearTimeout(user_info_timer);

	}
}

function hideAddressBar(){
  if(document.documentElement.scrollHeight<window.outerHeight/window.devicePixelRatio)
    document.documentElement.style.height=(window.outerHeight/window.devicePixelRatio)+'px';
  setTimeout("window.scrollTo(1,1)",0);
}
// window.onload = Custom.init;

$(document).ready(function () {

    $("#siteid_applicantid").bind('paste', function(event) {
        var _this = this;
        // Short pause to wait for paste to complete
        setTimeout("lookup_id()", 100);
    });

	window.addEventListener("load",function(){hideAddressBar();});
	window.addEventListener("orientationchange",function(){hideAddressBar();});
	serverTime.update();
	
	wall_clock();
	
	$("#readerror").hide();	
	$("#siteid_applicantid").focus();
	
	$("#siteid_applicantid").keyup(check_swipe);

});
