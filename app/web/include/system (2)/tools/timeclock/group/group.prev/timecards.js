document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');


var checkboxHeight = "25";
var radioHeight = "25";
var selectWidth = "240";


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
				document.report_form.submit();

			}
		}
	}
}
var refreshPage = function (this_page) {
	document.getElementById("WhichPage").value=this_page;
	document.report_form.submit();
}
function addslashes (str) {
	return (str + '').replace(/[\\"']/g, '\\$&').replace(/\u0000/g, '\\0');
}

var getInvoice = {
	open: function (row_number, inv_number, site, cust) {
		what_row = row_number;
		document.getElementById("line_"+what_row+"_detail").setAttribute("class", "loading");

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
		document.getElementById("line_"+row_number+"_detail").setAttribute("class", "hide");
		var this_row = document.getElementById("row_for_inv_"+inv_number);
		this_row.innerHTML = "<a href=\"javascript:;\" onclick=\"getInvoice.open('"+row_number+"', '"+inv_number+"', '"+site+"', '"+cust+"');\"><span class=\"plusexpand\">&nbsp;</span></a>";
		return false;
	}
}


var customer = {
	getorders: function (customercode, sitedb, status) {
	
		setAttributeClass(document.getElementById(status+"ordersdiv"+customercode), "loading");
		setAttributeClass(document.getElementById("ctrlCustomers"+customercode), "ShowLess");

		switch(status) {
			case "closed":
				var PostStr = "do=getorders&id=" + customercode + "&site=" + sitedb + "&status=closed";
				console.log(PostStr);
				
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', customer.showclosedorders);
				return false;
			case "open":
				var PostStr = "do=getorders&id=" + customercode + "&site=" + sitedb;
				console.log(PostStr);
				
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', customer.showopenorders);
				return false;

		}
	},
	showopenorders: function (oXML) {
		console.log("in showopenorders ");
		customer.showorders (oXML, "open");
	},
	showclosedorders: function (oXML) {
		console.log("in showclosedorders ");
		customer.showorders(oXML, "closed");
	},
	showorders: function(oXML, status) {
		// get the response text, into a variable
		console.log(oXML.responseText);
		var response = oXML.responseText.split("<!-- [split] -->");

		// update the Div to show the result from the server
		console.log(status+"ordersdiv"+response[1]);
		document.getElementById(status+"ordersdiv"+response[1]).innerHTML = response[0];
		document.getElementById(status+"ordersdiv"+response[1]).setAttribute("class", "");	
		return false;
	},	
	close: function (row_number, inv_number, site, cust) {
		document.getElementById("line_"+row_number+"_detail").setAttribute("class", "hide");
		var this_row = document.getElementById("row_for_inv_"+inv_number);
		this_row.innerHTML = "<a href=\"javascript:;\" onclick=\"getInvoice.open('"+row_number+"', '"+inv_number+"', '"+site+"', '"+cust+"');\"><span class=\"plusexpand\">&nbsp;</span></a>";
		return false;
	},
	add: function (id, sitedb) {
		var placementid = id;
		
		var summary_div = document.getElementById("timesummarydiv"+placementid);
		
		if (summary_div.getAttribute("className")!=null){
			summary_div.setAttribute("className", "loading");
		} else {
			summary_div.setAttribute("class", "loading");
		}
		
		var PostStr = "do=addweek&id=" + placementid + "&site=" + sitedb;

		// use the generic function to make the request
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timesummary.refresh);
		return false;
	},
	remove: function (placementid, sitedb, summaryid) {
		var summary_div = document.getElementById("timesummarydiv"+placementid);
	
		if (summary_div.getAttribute("className")!=null){
			summary_div.setAttribute("className", "loading");
		} else {
			summary_div.setAttribute("class", "loading");
		}
		
		var PostStr = "do=removeweek&id=" + placementid + "&site=" + sitedb + "&summary=" + summaryid;

		// use the generic function to make the request
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timesummary.refresh);
		return false;
	},
	refresh: function (oXML) {
		// get the response text, into a variable
		var response = oXML.responseText.split(":");
		timesummary.open(response[0], response[1]);
	}
}


var activity = {
	load: function (customercode, qs, sitedb, status) {
	
		setAttributeClass(document.getElementById(status+"custActivityDiv"+customercode), "loading");
		//setAttributeClass(document.getElementById("ctrlCustomers"+customercode), "ShowLess");

		switch(status) {
			case "closed":
				var PostStr = "do=getorders&id=" + customercode + "&site=" + sitedb + "&status=closed";
				console.log(PostStr);
				
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', customer.showclosedorders);
				return false;
			case "open":
				var PostStr = qs;
				console.log(PostStr);
				
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', customer.showopenorders);
				return false;

		}
	},
	showopenorders: function (oXML) {
		console.log("in showopenorders ");
		customer.showorders (oXML, "open");
	},
	showclosedorders: function (oXML) {
		console.log("in showclosedorders ");
		customer.showorders(oXML, "closed");
	},
	showorders: function(oXML, status) {
		// get the response text, into a variable
		var response = oXML.responseText.split("<!-- [split] -->");

		// update the Div to show the result from the server
		console.log(status+"ordersdiv"+response[1]);
		document.getElementById(status+"ordersdiv"+response[1]).innerHTML = response[0];
		document.getElementById(status+"ordersdiv"+response[1]).setAttribute("class", "");	
		return false;
	},	
	close: function (row_number, inv_number, site, cust) {
		document.getElementById("line_"+row_number+"_detail").setAttribute("class", "hide");
		var this_row = document.getElementById("row_for_inv_"+inv_number);
		this_row.innerHTML = "<a href=\"javascript:;\" onclick=\"getInvoice.open('"+row_number+"', '"+inv_number+"', '"+site+"', '"+cust+"');\"><span class=\"plusexpand\">&nbsp;</span></a>";
		return false;
	},
	add: function (id, sitedb) {
		var placementid = id;
		
		var summary_div = document.getElementById("timesummarydiv"+placementid);
		
		if (summary_div.getAttribute("className")!=null){
			summary_div.setAttribute("className", "loading");
		} else {
			summary_div.setAttribute("class", "loading");
		}
		
		var PostStr = "do=addweek&id=" + placementid + "&site=" + sitedb;

		// use the generic function to make the request
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timesummary.refresh);
		return false;
	},
	remove: function (placementid, sitedb, summaryid) {
		var summary_div = document.getElementById("timesummarydiv"+placementid);
	
		if (summary_div.getAttribute("className")!=null){
			summary_div.setAttribute("className", "loading");
		} else {
			summary_div.setAttribute("class", "loading");
		}
		
		var PostStr = "do=removeweek&id=" + placementid + "&site=" + sitedb + "&summary=" + summaryid;

		// use the generic function to make the request
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timesummary.refresh);
		return false;
	},
	refresh: function (oXML) {
		// get the response text, into a variable
		var response = oXML.responseText.split(":");
		timesummary.open(response[0], response[1]);
	}
}

var order = {
	getplacements: function (custcode, reference, sitedb) {
		console.log("ctrl.Orders."+custcode+"."+reference);
		setAttributeClass(document.getElementById("or"+custcode+reference), "loading");
		setAttributeClass(document.getElementById("ctrl.order."+custcode+"."+reference), "ShowLess");

		// build up the post string when passing variables to the server side page
		// var PostStr = "variable=value&variable2=value2";
		var PostStr = "do=getplacements&id=" + reference + "&site=" + sitedb + "&customer=" + custcode;
		// use the generic function to make the request
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', order.showplacements);
		return false;
	},
	showplacements: function (oXML) {
		// get the response text, into a variable
		var response = oXML.responseText.split("<!-- [split] -->");

		// update the Div to show the result from the server
		document.getElementById("or"+response[1]).innerHTML = response[0];
		document.getElementById("or"+response[1]).setAttribute("class", "placements");	
		return false;
	},
	close: function (row_number, inv_number, site, cust) {
		document.getElementById("line_"+row_number+"_detail").setAttribute("class", "hide");
		var this_row = document.getElementById("row_for_inv_"+inv_number);
		this_row.innerHTML = "<a href=\"javascript:;\" onclick=\"getInvoice.open('"+row_number+"', '"+inv_number+"', '"+site+"', '"+cust+"');\"><span class=\"plusexpand\">&nbsp;</span></a>";
		return false;
	},
	add: function (id, sitedb) {
		var placementid = id;
		
		var summary_div = document.getElementById("timesummarydiv"+placementid);
		
		if (summary_div.getAttribute("className")!=null){
			summary_div.setAttribute("className", "loading");
		} else {
			summary_div.setAttribute("class", "loading");
		}
		
		var PostStr = "do=addweek&id=" + placementid + "&site=" + sitedb;

		// use the generic function to make the request
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timesummary.refresh);
		return false;
	},
	remove: function (placementid, sitedb, summaryid) {
		var summary_div = document.getElementById("timesummarydiv"+placementid);
	
		if (summary_div.getAttribute("className")!=null){
			summary_div.setAttribute("className", "loading");
		} else {
			summary_div.setAttribute("class", "loading");
		}
		
		var PostStr = "do=removeweek&id=" + placementid + "&site=" + sitedb + "&summary=" + summaryid;

		// use the generic function to make the request
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timesummary.refresh);
		return false;
	},
	refresh: function (oXML) {
		// get the response text, into a variable
		var response = oXML.responseText.split(":");
		timesummary.open(response[0], response[1]);
	}
}


function catcalc(cal) {
	var date = cal.date;
	var time = date.getTime()
	var field = cal.params.inputField
	// ) {
		// field = document.getElementById("f_date_a");
		// time -= Date.WEEK; // substract one week
	// } else {
		// time += Date.WEEK; // add one week
	// }
	// var date2 = new Date(time);
	// field.value = date2.print("%Y-%m-%d %H:%M");
}

var timesummary = {
	open: function (placementid, sitedb) {
		setAttributeClass(document.getElementById("timesummarydiv"+placementid), "loading");
		setAttributeClass(document.getElementById("TimeSummary"+placementid), "ShowLess");
		console.log(sitedb);
		// build up the post string when passing variables to the server side page
		// var PostStr = "variable=value&variable2=value2";
		var PostStr = "do=timesummary&id=" + placementid + "&site=" + sitedb;
		// use the generic function to make the request
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timesummary.show);
		return false;

		//if (row_number%2) {
		//	document.getElementById("line_"+what_row+"_detail").setAttribute("class", "odd");
		//} else {
		//	document.getElementById("line_"+what_row+"_detail").setAttribute("class", "even");
		//}
		//document.getElementById("row_"+what_row+"_summary").setAttribute("class", "detail_summary");

		// return false;
	},
	show: function (oXML) {
		// get the response text, into a variable
		var response = oXML.responseText.split("<!-- [split] -->");

		// update the Div to show the result from the server
		document.getElementById("timesummarydiv"+response[1]).innerHTML = response[0];
		document.getElementById("timesummarydiv"+response[1]).setAttribute("class", "timesummaries");

		//get id to attach Calendar event trigger
		
		var trigger_images = response[0].split("id=\"slct_we_");
		console.log(trigger_images.length);
		
		for (var i=1; i<trigger_images.length; i++){
			//console.log("slct_we_"+trigger_images[i].substring(0, trigger_images[i].indexOf("\"")));
			
			Calendar.setup({
				// onUpdate      : catcalc,
				// onSelect      : catcalc,
				inputField    : "slct_we_"+trigger_images[i].substring(0, trigger_images[i].indexOf("\"")),
				button        : "calBtn"+trigger_images[i].substring(0, trigger_images[i].indexOf("\"")),
				align         : "B1"
			});
			
		}
		return false;
	},
	close: function (row_number, inv_number, site, cust) {
		document.getElementById("line_"+row_number+"_detail").setAttribute("class", "hide");
		var this_row = document.getElementById("row_for_inv_"+inv_number);
		this_row.innerHTML = "<a href=\"javascript:;\" onclick=\"getInvoice.open('"+row_number+"', '"+inv_number+"', '"+site+"', '"+cust+"');\"><span class=\"plusexpand\">&nbsp;</span></a>";
		return false;
	},
	add: function (id, sitedb) {
		var placementid = id;
		
		var summary_div = document.getElementById("timesummarydiv"+placementid);
		
		if (summary_div.getAttribute("className")!=null){
			summary_div.setAttribute("className", "loading");
		} else {
			summary_div.setAttribute("class", "loading");
		}
		
		var PostStr = "do=addweek&id=" + placementid + "&site=" + sitedb;

		// use the generic function to make the request
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timesummary.refresh);
		return false;
	},
	remove: function (placementid, sitedb, summaryid) {
		var summary_div = document.getElementById("timesummarydiv"+placementid);
	
		if (summary_div.getAttribute("className")!=null){
			summary_div.setAttribute("className", "loading");
		} else {
			summary_div.setAttribute("class", "loading");
		}
		
		var PostStr = "do=removeweek&id=" + placementid + "&site=" + sitedb + "&summary=" + summaryid;

		// use the generic function to make the request
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timesummary.refresh);
		return false;
	},
	refresh: function (oXML) {
		// get the response text, into a variable
		var response = oXML.responseText.split(":");
		timesummary.open(response[0], response[1]);
	}
}

var setAttributeClass = function(thisObj, thisClass) {
	if (thisObj.getAttribute("className")!=null) {
		thisObj.setAttribute("className", thisClass);
	} else {		
		thisObj.setAttribute("class", thisClass);
	}
}

function disable_enable(oField){
	if (oField.disabled == true) {
		oField.disabled = false;
	} else {
		oField.disabled=true;
	}
}

var timedetail = {
	change: function (frmFieldId, sitedb) {
		oForm = document.forms[0];
		oField = document.getElementById(frmFieldId);
		console.log(oField.name);
		disable_enable(oField);
		
		var dayofweek = 1;
		var placementid = 2;
		var summaryid = 3;
		var oFieldName = oField.name;
				
		var ids = oFieldName.split("_");
				
		// alert(objField.name + "\n\n \
			// " + "Day of week: " + ids[dayofweek] + "\n\n \
			// " + "Placement Id: " + ids[placementid] + "\n\n \
			// " +"Summary Id: "  + ids[summaryid] + "\n\n \
			// " + "Field Value: " + objField.value);
		
		// Status widget container was dropped
		// var objStatus = document.getElementById("Status_" + ids[placementid] + "_" + ids[summaryid]);
		
		// setAttributeClass(objStatus, "Working");
		
		if (ids[dayofweek]=="rt"){
			alert("Changing Total Sub-Routine");
		} else if (ids[dayofweek]=="we"){
			// Changing Week Ending

			// build up the post string when passing variables to the server side page
			// var PostStr = "variable=value&variable2=value2";
			var PostStr = "do=updateweek&id=" + ids[placementid] + "&site=" + sitedb + "&dn=" + ids[dayofweek] + "&summaryid=" + ids[summaryid] + "&we=" +oField.value;
		} else {
			
			if (oForm.elements["WarnedOverwriteDetail"].value != "yes") {
				if (confirm("Entering time directly into a Day summary field will erase all, if any, individual time entrys associated with each respectives day of the week. \n\nContinue updating hours?")) {
					oForm.elements["WarnedOverwriteDetail"].value = "yes";
				} else {
					return false;
				}
			}
			
			// var PostStr = "variable=value&variable2=value2";
			var PostStr = "do=updateday&id=" + ids[placementid] + "&site=" + sitedb + "&dn=" + ids[dayofweek] + "&summaryid=" + ids[summaryid] + "&time=" +oField.value;
		}
		console.log(PostStr);
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timedetail.showchange);
		return false;
	},
	changewe: function (frmFieldId, sitedb) {
		oForm = document.forms[0];
		oField = document.getElementById(frmFieldId);
		console.log(oField.name);
		disable_enable(oField);
		
		var dayofweek = 1;
		var placementid = 2;
		var summaryid = 3;
		var oFieldName = oField.name;
		var ids = oFieldName.split("_");
		if (ids[dayofweek]=="rt"){
			alert("Changing Total Sub-Routine");
		} else if (ids[dayofweek]=="we"){
			// Changing Week Ending

			// build up the post string when passing variables to the server side page
			// var PostStr = "variable=value&variable2=value2";
			var PostStr = "do=updateweek&id=" + ids[placementid] + "&site=" + sitedb + "&dn=" + ids[dayofweek] + "&summaryid=" + ids[summaryid] + "&we=" +oField.value;
		} else {
			
			if (oForm.elements["WarnedOverwriteDetail"].value != "yes") {
				if (confirm("Entering time directly into a Day summary field will erase all, if any, individual time entrys associated with each respectives day of the week. \n\nContinue updating hours?")) {
					oForm.elements["WarnedOverwriteDetail"].value = "yes";
				} else {
					return false;
				}
			}
			
			// var PostStr = "variable=value&variable2=value2";
			var PostStr = "do=updateday&id=" + ids[placementid] + "&site=" + sitedb + "&dn=" + ids[dayofweek] + "&summaryid=" + ids[summaryid] + "&time=" +oField.value;
		}
		console.log(PostStr);
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timedetail.showchangedwe);
		return false;
	},
	showchange: function (oXML) {
		// get the response text, into a variable
		var dayofweek = 1;
		var placementid = 2;
		var summaryid = 3;
		var ids = oXML.responseText.split("_");
				
		console.log("sum_"+ids[dayofweek]+"_"+ids[placementid]+"_"+ids[summaryid]);
		var wk_total = new Number(0);
		
		for (var wk_day = 1;wk_day<8;wk_day++){
			console.log("input value: "+document.getElementById('sum_d'+wk_day+"_"+ids[placementid]+"_"+ids[summaryid]).value);
			var day_input = document.getElementById('sum_d'+wk_day+"_"+ids[placementid]+"_"+ids[summaryid])
			if (isNumber(day_input.value)){
				wk_total = wk_total + Number(day_input.value);
				day_input.value = Number(day_input.value).toFixed(2);
			};
 			console.log("total:"+wk_total);
		}
		document.getElementById('sum_rt_'+ids[placementid]+"_"+ids[summaryid]).value = wk_total;
		
		
		var oField = document.getElementById("sum_"+ids[dayofweek]+"_"+ids[placementid]+"_"+ids[summaryid]);
		disable_enable(oField);
	},
	showchangedwe: function (oXML) {
		// get the response text, into a variable
		var dayofweek = 1;
		var placementid = 2;
		var summaryid = 3;
		var ids = oXML.responseText.split("_");
				
		console.log("slct_we_" + ids[placementid] + "_" + ids[summaryid]);
		var oField = document.getElementById("slct_we_" + ids[placementid] + "_" + ids[summaryid]);
		disable_enable(oField);
	},
	open: function (id, sitedb) {
		setAttributeClass(document.getElementById("TimeDetail"+id), "ShowLess");
		console.log("we_connector_"+id);
		
		setAttributeClass(document.getElementById("we_connector_"+id), "weekendings");

		var placeandtableid = id.split("_");
		var placementid = placeandtableid[0];
		var summaryid = placeandtableid[1];
		
		var detail_div = document.getElementById("timedetaildiv"+placementid+"_"+summaryid);
		
		if (detail_div.getAttribute("className")!=null) {
			detail_div.setAttribute("className", "loading");
		} else {		
			detail_div.setAttribute("class", "loading");
		}

		// build up the post string when passing variables to the server side page
		// var PostStr = "variable=value&variable2=value2";
		var PostStr = "do=timedetail&id=" + placementid + "&site=" + sitedb + "&summary=" + summaryid;
		// use the generic function to make the request
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timedetail.show);
		return false;

		//if (row_number%2) {
		//	document.getElementById("line_"+what_row+"_detail").setAttribute("class", "odd");
		//} else {
		//	document.getElementById("line_"+what_row+"_detail").setAttribute("class", "even");
		//}
		//document.getElementById("row_"+what_row+"_summary").setAttribute("class", "detail_summary");

		return false;
	},
	show: function (oXML) {
		// get the response text, into a variable
		var response = oXML.responseText.split("<!-- [split] -->");
		
		// update the Div to show the result from the server
		var timedetaildiv = document.getElementById("timedetaildiv"+response[1]);
		timedetaildiv.innerHTML = response[0];
		if (timedetaildiv.getAttribute("className") != null) {
			timedetaildiv.setAttribute("className", "timedetails");	
		} else {
			timedetaildiv.setAttribute("class", "timedetails");	
		}
	
	},
	close: function (row_number, inv_number, site, cust) {
		document.getElementById("line_"+row_number+"_detail").setAttribute("class", "hide");
		var this_row = document.getElementById("row_for_inv_"+inv_number);
		this_row.innerHTML = "<a href=\"javascript:;\" onclick=\"getInvoice.open('"+row_number+"', '"+inv_number+"', '"+site+"', '"+cust+"');\"><span class=\"plusexpand\">&nbsp;</span></a>";
		return false;
	},
	addRow: function (tableID) {
		var copyrow      = 1;
		var weekdaycol   = 1;
		var timeincol    = 2;
		var timeoutcol   = 3;
		var hourtotalcol = 4;
		
		// var table = document.getElementById(tableID+"_template");
		var table = document.getElementById(tableID);
		setAttributeClass(table, "time_detail");
		console.log(tableID+"_template");
		var newRow = document.getElementById(tableID+"_template").cloneNode(true);
		//modify newRow as appropriate
		table.tBodies[0].appendChild(newRow);
		
		
		// var rowCount = table.rows.length;
		// var row = table.insertRow(rowCount);

		// var colCount = table.rows[copyrow].cells.length;

		// for(var i=0; i<colCount; i++) {
			// console.log(i);
			// var newcell = row.insertCell(i);

			// newcell.innerHTML = table.rows[copyrow].cells[i].innerHTML;
			// //alert(newcell.childNodes);
			// switch(newcell.childNodes[0].type) {
				// case "text":
						// newcell.childNodes[0].value = "";
						// console.log("text: "+i+newcell.className);

						// break;
				// case "checkbox":
						// newcell.childNodes[0].checked = false;
						// console.log("checkbox: "+i+newcell.className);
						// break;
				// case "select-one":
						// newcell.childNodes[0].selectedIndex = 0;
						// console.log("select-one: "+i+newcell.className);
						// break;
			// }
			
			// switch(i) {
				// case weekdaycol:
					// setAttributeClass(newcell, "weekday");
					// break;
				// case timeincol,timeoutcol:
					// setAttributeClass(newcell, "timeinput");
					// break;
				// case 4:
					// setAttributeClass(newcell, "hourstotal");
					// break;
			// }
		// }
	},
	deleteRow: function (tableID) {
		console.log("delete row: " +tableID)
		try {
			var table = document.getElementById(tableID);
			var rowCount = table.rows.length;
			console.log("trying...");
			for(var i=0; i<rowCount; i++) {
				var row = table.rows[i];
				var chkbox = row.cells[0].childNodes[0];
				if(null != chkbox && true == chkbox.checked) {
					if(rowCount <= 1) {
						alert("Cannot delete all the rows.");
						break;
					}
					table.deleteRow(i);
					rowCount--;
					i--;
				}
			}
		} catch(e) {
			alert(e);
        }
	},
	update: function(rowid, v) {
		//update code here
	}
}

var timeclock = {
	setTime: function(id) {
		console.log(id)
		var timeid        = id.split("_");
		var idtype        = timeid[0]; //type of input selected: In, Out, Total, or Type
		var placementid   = timeid[1];
		var summaryid     = timeid[2];
		var detailid      = timeid[3];
		// var workday       = timeid[4];
		var workday       = document.getElementById(id).value;
		var rowid         = placementid+"_"+summaryid+"_"+detailid+"_"+workday;
		var timeinput     = document.getElementById(id);
		var f             = document.getElementById('report_form');
		var timein        = f[timeinput.name][0].value;
		var timeout       = f[timeinput.name][1].value;
		var timetotal     = f[timeinput.name][2].value;
		var timetype      = f[timeinput.name][3].value;
		
		console.log(workday);
		
		if (workday != timeid[4]) {
			if (idtype = "workday") {
				id = id+workday;
			} else {
				id = id.replace(placementid+"_"+summaryid+"_"+detailid+"_"+timeid[4], placementid+"_"+summaryid+"_"+detailid+"_"+workday);
			}
		}
		console.log("workday value: "+workday);
		// console.log(urlParams);

		console.log("-----");

		var totalsbox = document.getElementById("total_"+rowid);
		var inselect = document.getElementById("in_"+rowid);
		var outselect = document.getElementById("out_"+rowid);
		var typeselect = document.getElementById("type_"+rowid);
		
		switch(idtype){
			case "in":
				console.log("in");
				var PostStr = "do=updatetimedetail&id=" + id + "&t=" + timein + "&site=na";
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timeclock.updated);
				var tot = getFieldValue(timeout) - getFieldValue(timein);
				totalsbox.value = tot.toFixed(2);
				break;
			case "out":
				console.log("out");
				var PostStr = "do=updatetimedetail&id=" + id + "&t=" + timeout + "&site=na";
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timeclock.updated);
				var tot = getFieldValue(timeout) - getFieldValue(timein);
				totalsbox.value = tot.toFixed(2);
				break;
			case "total":
				console.log("total");
				var PostStr = "do=updatetimedetail&id=" + id + "&t=" + timetotal + "&site=na";
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timeclock.updated);
				inselect.value = "-1";
				outselect.value = "-1";
				break;
			case "type":
				console.log("make call to update TimeDetail Type");
				var PostStr = "do=updatetimedetail&id=" + id + "&t=" + timetype + "&site=na";
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timeclock.updated);
				break;
			case "workday":
				console.log("make call to update TimeDetail workday");
				console.log(id);
				var PostStr = "do=updatetimedetail&id=" + id + "&t=" + workday + "&site=na";
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timeclock.updated);
				break;
			default:
				console.log("don't recognize any of the types: " + idtype);
				break;
		}		
	},
	updated: function(oXML) {
		console.log(oXML.responseText);
		var paraStr = oXML.responseText.replace(/[\])}[{(]/g,'').split(","); //remove (){}[] and split into variable
		var dayid = paraStr[4];
		var placementid = paraStr[1];
		var summaryid = paraStr[2];
		var newvalue = paraStr[5]
		var summarybox = document.getElementById("sum_d" + dayid + "_" + placementid + "_" + summaryid);
		
		summarybox.value = newvalue;		
	}
}

var getFieldValue = function(thisvalue) {
	if (!isNaN(thisvalue)) {if (thisvalue > -1){return thisvalue;} else {return 0;} } else {return 0;}
}

var getFieldAsTime = function(fieldvalue) {
	
}


function valCat(f) {
	// f - form object
	for (var i=0; i<f['cat[]'].length; ++i)
	if (f['cat[]'].checked) 
	alert('Yup, cat ' + f['cat[]'][i].value + ' is checked!');
	else alert('Nope, cat ' + f['cat[]'][i].value + ' is not checked.');
	}


var buildClockOptions = function (){
	//build select stuff here
}
var PetStore = function () {

    var dog = 'Oliver';
    var cat = 'Gombotz';
    var hamster = 'Ralph';

    return {
        playDate: function (petA, petB) {
            console.log(petA + ' is playing with ' + petB + '(aww!)');
        },
        feed: function (pet) {
            console.log(pet + ' is enjoying some delicious chow');
        },
        open: function () {

            this.feed(dog);
            this.feed(cat);
            this.feed(hamster);

            this.playDate(dog, cat);
        }
    };

}();

PetStore.open();

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
	document.getElementById("line_"+response[1]+"_detail").innerHTML = response[0];
	document.getElementById("line_"+response[1]+"_detail").setAttribute("class", "loaded");
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
