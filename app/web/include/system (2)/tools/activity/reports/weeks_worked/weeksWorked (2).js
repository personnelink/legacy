document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');


var checkboxHeight = "25";
var radioHeight = "25";
var selectWidth = "190";

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
				document.whoseHereForm.submit();

			}
		}
	}
}

function addslashes (str) {
	return (str + '').replace(/[\\"']/g, '\\$&').replace(/\u0000/g, '\\0');
}

var getInvoice = {
	open: function (row_number, inv_number, site, cust) {
		what_row = row_number;
		var objDetailLine = document.getElementById("line_"+what_row+"_detail")
		
		if (objDetailLine.getAttribute("className")!=null) { // ie bs
			objDetailLine.setAttribute("className", "loading");
		} else { // real browsers
			objDetailLine.setAttribute("class", "loading");
		}

		look_up_inv(row_number, inv_number, site, cust);
		//alert("<a href=\"javascript:;\" onclick=\"getInvoice('"+row_number+"', '"+inv_number+"', '"+site+"', '"+cust+"');"">");
		var this_row = document.getElementById("row_for_inv_"+inv_number);
		this_row.innerHTML = "<a href=\"javascript:;\" onclick=\"getInvoice.close('"+row_number+"', '"+inv_number+"', '"+site+"', '"+cust+"');\"><span class=\"minusshrink\">&nbsp;</span></a>";
	
		//if (row_number%2) {
		//	document.getElementById("line_"+what_row+"_detail").setAttribute("class", "odd");
		//} else {
		//	document.getElementById("line_"+what_row+"_detail").setAttribute("class", "even");
		//}
		//document.getElementById("row_"+what_row+"_summary").setAttribute("class", "detail_summary");

		return false;
	},
	close: function (row_number, inv_number, site, cust) {
		var objDetailLine = document.getElementById("line_"+row_number+"_detail");
		if (objDetailLine.getAttribute("className")!=null) {
			objDetailLine.setAttribute("className", "hide");
		} else {
			objDetailLine.setAttribute("class", "hide");
		}
		var this_row = document.getElementById("row_for_inv_"+inv_number);
		this_row.innerHTML = "<a href=\"javascript:;\" onclick=\"getInvoice.open('"+row_number+"', '"+inv_number+"', '"+site+"', '"+cust+"');\"><span class=\"plusexpand\">&nbsp;</span></a>";
		return false;
	}
}

// launched from button click 
var look_up_inv = function(row_number, inv_number, site, cust) {

	// build up the post string when passing variables to the server side page
	// var PostStr = "variable=value&variable2=value2";
	var PostStr = "inv=" + inv_number + "&site=" + site + "&cust=" + cust + "&row=" + row_number;
	// use the generic function to make the request
	doAJAXCall('ajax/getInvoice.asp?'+PostStr, 'POST', '' + PostStr + '', showMessageResponse);
	return false;
}

// The function for handling the response from the server
var showMessageResponse = function (oXML) { 
  
    // get the response text, into a variable
    var response = oXML.responseText.split("<!-- [split] -->");
    
    // update the Div to show the result from the server
	var objDetailLine = document.getElementById("line_"+response[1]+"_detail")
	objDetailLine.innerHTML = response[0];
	
	if (objDetailLine.getAttribute('className')!=null) { // IE bs
		objDetailLine.setAttribute("className", "loaded");
	} else { // real browsers
		objDetailLine.setAttribute("class", "loaded");
	}
}


function change_all_boxes(toThis) {
	// var how_many = document.getElementById("how_many_invoices").value;
	var objCheckBoxes =  document.forms["viewActivityForm"].elements["ck_boxes"];
	if (!objCheckBoxes)
		return false;
		
	var how_many = objCheckBoxes.length
	var pay_amount
	
	if (!how_many)
		objCheckBoxes.checked = toThis;
	else
		for (var i = 0; i < how_many; i++)
			objCheckBoxes[i].checked = toThis;

	setPayAmount();
}

function setPayAmount () {
	var objCheckBoxes =  document.forms["viewActivityForm"].elements["ck_boxes"];

	var pay_amount = 0
	var how_many_boxes = objCheckBoxes.length;
	var intInvAmount
	
	if (!how_many_boxes)
		document.getElementById("amount").value = "0.00";
	else {
		for (var i = 0; i < how_many_boxes; i++) {
			if (objCheckBoxes[i].checked == true) {
				intInvAmount = document.forms["viewActivityForm"].elements["inv_"+objCheckBoxes[i].value].value;
				pay_amount = pay_amount + parseFloat(intInvAmount)
			}
		}
	}
	document.getElementById("amount").value = "$" + pay_amount.toFixed(2);
}

var payment = {
	show: function() {
		// unhide the sub-form
		setPayAmount();
		var hide_payment = document.getElementById("mkPayment")
		hide_payment.innerHTML = '<a href="javascript:;" onclick="payment.hide();">Hide Payment</a>'
		document.getElementById("make_payment").style.display = 'block';
	
		// document.getElementById("account_balance").className = 'hide';
		return false;
	},
	hide: function() {
		var show_payment = document.getElementById("mkPayment")
		show_payment.innerHTML = '<a href="javascript:;" onclick="payment.show();">Make a payment</a>'
		document.getElementById("make_payment").style.display = 'none';
	},
	check: function(fieldtocheck) {
				if (fieldtocheck.value == "") {
			document.getElementById(fieldtocheck.name+"Lbl").style.color = 'red';
			is_okay = false;
		}
	},
	process: function() {	
		var process_action = document.getElementById("process_action");
		var is_okay = true;	
		process_action.value = "send";
		document.viewActivityForm.submit();
	}
}


function act_refresh () {
	document.report_form.submit();
}

function setpage(thisPage) {
	document.getElementById("Page").value = thisPage;
	act_refresh();
}

window.onload = Custom.init;


