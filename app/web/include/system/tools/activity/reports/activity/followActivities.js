document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

var checkboxHeight = "25";
var radioHeight = "25";
var selectWidth = "240";

/* No need to change anything after this */

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
				grayOut(true);
				document.activity_form.submit();

			}
		}
	}
}

var choose = {
	all: function () {
		$('#nonsystem input[type="checkbox"]').prop('checked', true);
	},
	none: function () {
		$('#nonsystem input[type="checkbox"]').prop('checked', false);
	}

}

function act_refresh () {
	grayOut(true);
	
	console.log("test");
	document.getElementById("activity_form").submit();
	console.log("test");

	}

function arc(this_custcode) {
	act_refresh_customer (this_custcode);
}

function act_refresh_customer (this_custcode) {
	grayOut(true);
	document.getElementById("WhichCustomer").value=this_custcode
	act_refresh();
}

function act_refresh_order (this_order) {
	document.getElementById("WhichOrder").value=this_order
	act_refresh();
}

function act_refresh_page (this_page) {
	document.getElementById("WhichPage").value=this_page
	act_refresh();
}

function enter_date(trueorfalse) {
	if (trueorfalse == 'true'){
		document.getElementById('enter_dates').className = "show"
	} else {
		document.getElementById('enter_dates').className = "hide"
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

var dispositions = {
	show: function(id) {
		//show dispositions selection box
		document.getElementById("disposition"+id).className = "hide";
		document.getElementById("setdisposition"+id).className = "disposition";
		selbox = document.getElementById("setdisp"+id);
		selbox.size = selbox.options.length;
		selbox.style.position='absolute';
		selbox.style.height='auto';
		selbox.focus();
		//hide current disposition status
	},
	set: function(id) {
		selbox = document.getElementById("setdisp"+id);
		document.getElementById("disposition"+id).innerHTML = selbox.options[selbox.value].text;
		document.getElementById("disposition"+id).className = "disposition";
		//show current disposition status

		//hide dispositions selection box
		selbox = document.getElementById("setdisp"+id)
		document.getElementById("setdisposition"+id).className = "hide";

		//set spinning busy image...
		document.getElementById("disposition"+id).className = "working";

		//get Appointment Type Code
		ApptType = document.getElementById("AppTypeCode"+id).value
		var site = document.getElementById("whichCompany").value;
		var thisdisposition = document.getElementById("setdisp"+id).value

		//do procedure call
		var PostStr = "";
		doAJAXCall('ajax/doThings.asp?do=change&id='+id+'&site='+site+'&disposition='+selbox.value+'&apptype='+ApptType, 'POST', '' + PostStr + '', dispositions.setidle);
	},
	hide: function(id) {
		//hide current disposition status
		document.getElementById("disposition"+id).className = "disposition";
		
		//hide dispositions selection box
		selbox = document.getElementById("setdisp"+id)
		document.getElementById("setdisposition"+id).className = "hide";
	
	},
	setidle: function(oXML) {
		var id = oXML.responseText;
		
		//clear spinning busy image...
		document.getElementById("disposition"+id).className = "idle";

		//hide current disposition status
		document.getElementById("disposition"+id).className = "disposition";
		
		//hide dispositions selection box
		selbox = document.getElementById("setdisp"+id)
		document.getElementById("setdisposition"+id).className = "hide";
	}
};

function lookup_id() {
		getMessage();
}

// launched from button click 
var getMessage = function () {

	// build up the post string when passing variables to the server side page
	// var PostStr = "variable=value&variable2=value2";
	var PostStr = "";
	
	// use the generic function to make the request
	doAJAXCall('/include/system/tools/activity/viewApplicants.asp?isservice=true'+PostStr, 'POST', '' + PostStr + '', showMessageResponse);
}


function setApplicantId(thisId, thisName) {
	var search = document.getElementById("signApplicantIn");
	search.value = thisId;
	document.getElementById("lookup_applicant").innerHTML = "<p><em><i>"+thisName+"</i></em></p>";
	document.getElementById("signInComment").focus();
}

var search_input_timer;
function lookup_id(search_input) {
		console.log('calling input name:' + search_input.name);
		
		clearTimeout(search_input_timer);		
		search_input_timer = setTimeout(function() {
			getSearch(search_input);
			}, 500);

}

function check_enter(event) {
	if (event.keyCode == 13) {
		sign_in();
	}
}

function sign_in() {
	document.whoseHereForm.action.value='signin';
	document.whoseHereForm.submit();
}

// launched from button click 
var getSearch = function (search_input) {
	clearTimeout(search_input_timer);	

	var whichdsn = document.getElementById("whichCompany").value
	
	var PostStr = "do=lookup&use_qs=1&lookup="+search_input.name+"&site="+whichdsn+"&search="+search_input.value+"&hide_mark=1";
	
	// use the generic function to make the request
	doAJAXCall('/include/system/tools/activity/reports/activity/ajax/?'+PostStr, 'GET', '', showMessageResponse);
}

// The function for handling the response from the server
var showMessageResponse = function (oXML) { 
    
    // get the response text, into a variable
    var response = oXML.responseText;
    
    // update the Div to show the result from the server
	document.getElementById("lookup_applicant").innerHTML = response;
};


// The function for handling the response from the server
var showMessageResponse = function (oXML) { 
    
    // get the response text, into a variable
    var response = oXML.responseText;
    
    // update the Div to show the result from the server
	document.getElementById("lookup_response").innerHTML = response;
};

window.onload = Custom.init;


$( document ).ready(function() {
	console.log( "ready!" );

	
	// show basic filters top div filter and hide trigger
	$( "#show_basic_filters" ).click(function() {
		  $('#show_basic_filters').removeClass('show').addClass('hide');
		  $('#hide_basic_filters').removeClass('hide').addClass('show')
		  // $('#what_activities').removeClass('hide').addClass('show');
		  $('#basic_filters').slideDown();
		  $( "#show_what_activities" ).trigger('click');
		  $( "#show_system_activities" ).trigger('click');
		  
	});
	
	// hide what activities div filter and hide trigger
	$( "#hide_basic_filters" ).click(function() {
		  $('#hide_basic_filters').removeClass('show').addClass('hide')
		  $('#show_basic_filters').removeClass('hide').addClass('show')
		  $('#basic_filters').slideUp();
		  // $('#what_activities').removeClass('hide').addClass('show');
	});

	
	// show what activities div filter and hide trigger
	$( "#show_what_activities" ).click(function() {
		  $('#show_what_activities').removeClass('show').addClass('hide');
		  // $('#what_activities').removeClass('hide').addClass('show');
		  $('#what_activities').slideDown();
	});
	
	// hide what activities div filter and hide trigger
	$( "#hide_what_activities" ).click(function() {
		  $('#what_activities').slideUp();
		  $('#show_what_activities').removeClass('hide').addClass('show')
		  // $('#what_activities').removeClass('hide').addClass('show');
	});

	
	// show system specific filter and hide trigger
	$( "#show_system_activities" ).click(function() {
		  $('#show_system_activities').removeClass('show').addClass('hide');
		  $('#system_specific_activities').slideDown();
	});

	// hide system specific filters
	$( "#hide_system_activities" ).click(function() {
		  $('#system_specific_activities').slideUp();
		  $('#show_system_activities').removeClass('hide').addClass('show');
	});


});

