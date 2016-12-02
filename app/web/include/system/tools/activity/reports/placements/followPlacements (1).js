document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

var checkboxHeight = "25";
var radioHeight = "25";
var selectWidth = "240";

/* No need to change anything after this */

document.write('<style type="text/css">input.styled { display: none; } select.styled { position: relative; width: ' + selectWidth + 'px; opacity: 0; filter: alpha(opacity=0); z-index: 15; }</style>');

var Custom = {
	init: function() {
		title_this(document.getElementById('page_title').value);
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
		if (document.getElementById("page_title").value == "Start Page - Personnel Plus") {
			get_appointments();
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

function etc_refresh () {
	document.whoseHereForm.submit();
}

function etc_refresh_customer (this_custcode) {
	document.getElementById("WhichCustomer").value=this_custcode
	document.whoseHereForm.submit();
}

function etc_refresh_order (this_order) {
	document.getElementById("WhichOrder").value=this_order
	document.whoseHereForm.submit();
}

function etc_refresh_page (this_page) {
	document.getElementById("WhichPage").value=this_page
	document.whoseHereForm.submit();
}

function enter_date(trueorfalse) {
	if (trueorfalse == 'true'){
		document.getElementById('enter_dates').className = "show"
	} else {
		document.getElementById('enter_dates').className = "hide"
	}
}

function triggerEvent(el, type)
{
    if ((el[type] || false) && typeof el[type] == 'function')
    {
        el[type](el);
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
		document.getElementById("dloader"+id).className = "working";

		var site = document.getElementById("whichCompany").value;
		var thisdisposition = document.getElementById("setdisp"+id).value

		//do procedure call
		var PostStr = "";
		doAJAXCall('/include/system/tools/activity/reports/placements/ajax/doThings.asp?do=changedisp&id='+id+'&site='+site+'&disposition='+selbox.value, 'POST', '' + PostStr + '', dispositions.setidle);
	},
	hide: function(id) {
		//hide current disposition status
		document.getElementById("disposition"+id).className = "disposition";
		
		//hide dispositions selection box
		selbox = document.getElementById("setdisp"+id)
		document.getElementById("setdisposition"+id).className = "hide";
	
	},
	setidle: function(oXML) {
		var response = oXML.responseText.split("[:]");
		
		id = response[0];
		comment = response[1] 
		
		//clear spinning busy image...
		document.getElementById("dloader"+id).className = "idle";

		//refresh the comment
		document.getElementById("cm"+id).innerHTML = comment
		
		//hide current disposition status
		document.getElementById("disposition"+id).className = "disposition";
		
		//hide dispositions selection box
		selbox = document.getElementById("setdisp"+id)
		document.getElementById("setdisposition"+id).className = "hide";
	}
};

var appttype = {
	show: function(id) {
		//show dispositions selection box
		document.getElementById("appointment"+id).className = "hide";
		document.getElementById("setappointment"+id).className = "disposition";
		selbox = document.getElementById("setappt"+id);
		selbox.size = selbox.options.length;
		selbox.style.position='absolute';
		selbox.style.height='auto';
		selbox.focus();
		//hide current disposition status
	},
	set: function(id) {
		selbox = document.getElementById("setappt"+id);
		document.getElementById("appointment"+id).innerHTML = selbox.options[selbox.value].text;
		document.getElementById("appointment"+id).className = "disposition";
		//show current disposition status

		//hide dispositions selection box
		selbox = document.getElementById("setappt"+id)
		document.getElementById("setappointment"+id).className = "hide";

		//set spinning busy image...
		document.getElementById("aloader"+id).className = "working";

		var site = document.getElementById("whichCompany").value;
		var thisdisposition = document.getElementById("setappt"+id).value

		//do procedure call
		var PostStr = "";
		doAJAXCall('/include/system/tools/activity/reports/placements/ajax/doThings.asp?do=changeappt&id='+id+'&site='+site+'&appointment='+selbox.value, 'POST', '' + PostStr + '', appttype.setidle);
	},
	hide: function(id) {
		//hide current disposition status
		document.getElementById("appointment"+id).className = "disposition";
		
		//hide dispositions selection box
		selbox = document.getElementById("setappt"+id)
		document.getElementById("setappointment"+id).className = "hide";
	
	},
	setidle: function(oXML) {
		var response = oXML.responseText.split("[:]");

		id = response[0];

		//clear spinning busy image...
		document.getElementById("aloader"+id).className = "idle";

		//hide current disposition status
		document.getElementById("appointment"+id).className = "disposition";
		
		//hide dispositions selection box
		selbox = document.getElementById("setappt"+id)
		document.getElementById("setappointment"+id).className = "hide";
	}
};


// launched from button click 
var getMessage = function () {

	// build up the post string when passing variables to the server side page
	// var PostStr = "variable=value&variable2=value2";
	var PostStr = "";
	
	// use the generic function to make the request
	doAJAXCall('/include/system/tools/activity/viewApplicants.asp?isservice=true'+PostStr, 'POST', '' + PostStr + '', showMessageResponse);
}

// The function for handling the response from the server
var showMessageResponse = function (oXML) { 
    
    // get the response text, into a variable
    var response = oXML.responseText;
    
    // update the Div to show the result from the server
	document.getElementById("lookup_applicant").innerHTML = response;
};

window.onload = Custom.init;
