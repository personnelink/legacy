document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

var checkboxHeight = "25";
var radioHeight = "25";
var selectWidth = "20";

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


// The function for handling the response from the server
var showMessageResponse = {
	wcustcode: function (oXML) {
    // get the response text, into a variable
    var response = oXML.responseText;
   	var indicator = document.getElementById("status_"+response);
   	indicator.setAttribute("class", "notupdating");
		custcode.sync(response) 
    // update the Div to show the result from the server
	//document.getElementById("line_"+what_row+"_detail").innerHTML = response;
	//document.getElementById("line_"+what_row+"_detail").setAttribute("class", "loaded");
	}
}

var custcode = {
	showsave: function(custid) {
		// unhide the save button
		var save_button = document.getElementById("status_"+custid)
		save_button.className = "save";
		return false;
	},
	hidesave: function(custid) {
		// unhide the save button
		var save_button = document.getElementById("status_"+custid)
		save_button.className = "hide";
		return false;
	},
	compare: function(this_field) {
		var inpToCompWith = document.getElementById(this_field.name+"_x");
		if (this_field.value != inpToCompWith.value) {
			var fieldname = new String(this_field.name);
			if (fieldname.indexOf("sitefor", 0) > -1) {
					var custid = fieldname.slice(7);
			} else if (fieldname.indexOf("dayfor", 0) > -1) {
					var custid = fieldname.slice(6);
			} else {
					var custid = fieldname;
			}
			/* custcode.capitol(this_field); */
			custcode.showsave(custid);
		}
		return false;
	},
	keypressed: function(custid) {
		custcode.showsave(custid.name);
		return false;
	},
	sync: function(this_field_name) {
		var inpToSync = document.getElementById(this_field_name+"_x");
		inpToSync.value = document.getElementById(this_field_name).value;
		return false;
	},
	process: function() {	
		var process_action = document.getElementById("process_action");
		var is_okay = true;	
		process_action.value = "send";
		document.viewActivityForm.submit();
		return false;
	},
	update: function(custid) {
		var custcode = document.getElementById(custid).value;
		var site = document.getElementById("sitefor"+custid).value;
		var weekends = document.getElementById("dayfor"+custid).value;
		var indicator = document.getElementById("status_"+custid);
		indicator.setAttribute("class", "updating");

		var QueryStr = "proc=update&id="+custid+"&cust="+custcode+"&site="+site+"&weekends="+weekends;
		var PostStr = "";

		// use the generic function to make the request
		doAJAXCall('ajax/doThings.asp?'+QueryStr, 'POST', '' + PostStr + '', showMessageResponse.wcustcode);
		return false;
	}
}

Custom.init;
