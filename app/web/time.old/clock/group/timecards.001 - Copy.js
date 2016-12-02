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
	load: {
		customer: function (customercode, qs, sitedb, status) {
	
		// setAttributeClass(document.getElementById(status+"custActivityDiv"+customercode), "loading");
		//setAttributeClass(document.getElementById("ctrlCustomers"+customercode), "ShowLess");

		switch(status) {
			case "closed":
				var PostStr = "do=getorders&id=" + customercode + "&site=" + sitedb + "&status=closed";
				console.log(PostStr);
				
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', activity.show.customer);
				return false;
			case "open":
				var PostStr = qs;
				console.log(PostStr);
				
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', customer.show.customer);
				return false;

			}
		},
		order: function (customercode, qs, sitedb, status) {
		
		}
	},
	show: function (oXML) {
		var activiy_div = document.getElementById("custActivityDiv"+response[1])
	
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

		$("#or"+custcode+reference).slideDown( "slow", function() {
			// Animation complete.
		});

		document.getElementById("ctrl.order."+custcode+"."+reference).onclick = function() {
			order.close(custcode,reference,sitedb);return false; 
		}
		
		var PostStr = "do=getplacements&id=" + reference + "&site=" + sitedb + "&customer=" + custcode;
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', this.showplacements);
		return false;
	},
	showplacements: function (oXML) {
		// get the response text, into a variable
		var response = oXML.responseText.split("<!-- [split] -->");

		// update the Div to show the result from the server
		document.getElementById("or"+response[1]).innerHTML = response[0];
		document.getElementById("or"+response[1]).setAttribute("class", "placements");
		
		$('#or'+response[1]).find('.ShowMore').trigger("click");
		
		return false;
	},
	close: function (custcode, reference, sitedb) {
		setAttributeClass(document.getElementById("ctrl.order."+custcode+"."+reference), "ShowMore");
		var order_div = document.getElementById("or"+custcode+reference);
		
		$(order_div).slideUp( "slow", function() {
			// Animation complete.
			order_div.innerHTML = "";
		});
		
		// if (order_div.getAttribute("className")!=null) {
			// order_div.setAttribute("className", "hide");
		// } else {		
			// order_div.setAttribute("class", "hide");
		// }

		
		document.getElementById("ctrl.order."+custcode+"."+reference).onclick = function() {
			order.getplacements(custcode,reference,sitedb);return false; 
		}

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


var placement = {
	close: function(id, site) {
		if (!confirm("Closing without a final time card?")) {
			//set spinning busy image...
			document.getElementById("Placement"+id).className = "Working";
			//do procedure call
			doAJAXCall('/include/system/tools/activity/reports/etc/ajax/doThings.asp?do=close&id='+id+'&site='+site+'&needfinaltime=true', 'POST', '' + PostStr + '', placement.showexpected);
		} else {
			//set spinning busy image...
			document.getElementById("Placement"+id).className = "Working";
			//do procedure call
			doAJAXCall('/include/system/tools/activity/reports/etc/ajax/doThings.asp?do=close&id='+id+'&site='+site+'&needfinaltime=false', 'POST', '' + PostStr + '', placement.showopen);
		}
		var PostStr = ''
	},
	open: function(id, site) {
		var PostStr = ''
		//set spinning busy image...
		document.getElementById("Placement"+id).className = "Working";
		//do procedure call
		doAJAXCall('/include/system/tools/activity/reports/etc/ajax/doThings.asp?do=close&id='+id+'&site='+site+'&needfinaltime=false', 'POST', '' + PostStr + '', placement.showclose);
	},
	showopen: function(oXML) {
		// get the response text, into a variable
		var response = oXML.responseText;
		
		// shuffle open close page controls to show status and trigger oposite action
		var thisSite = document.getElementById("whichCompany").value
		var thisTrigger = document.getElementById("Placement"+response);
		thisTrigger.className = "ExpectingPlacement";
		thisTrigger.onclick = function(){placement.open(response, thisSite)};
	},
	showexpected: function(oXML) {
		// get the response text, into a variable
		var response = oXML.responseText;
		
		// shuffle open close page controls to show status and trigger oposite action
		var thisSite = document.getElementById("whichCompany").value
		var thisTrigger = document.getElementById("Placement"+response);
		thisTrigger.className = "OpenPlacement";
		thisTrigger.onclick = function(){placement.open(response, thisSite)};
	},
	showclose: function(oXML) {
		// shuffle open close page controls to show status and trigger oposite action
		// get the response text, into a variable
		var response = oXML.responseText;
		
		// shuffle open close page controls to show status and trigger oposite action
		var thisSite = document.getElementById("whichCompany").value
		var thisTrigger = document.getElementById("Placement"+response);
		thisTrigger.className = "ClosePlacement";
		thisTrigger.onclick = function() {placement.close(response, thisSite)};
	}
};



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
		
		$("#timesummarydiv"+placementid).slideDown( "slow", function() {
			// Animation complete.
		});

		$("#TimeSummary"+placementid).attr("onClick","timesummary.close('"+placementid+"','"+sitedb+"')");
		
		//if (row_number%2) {
		//	document.getElementById("line_"+what_row+"_detail").setAttribute("class", "odd");
		//} else {
		//	document.getElementById("line_"+what_row+"_detail").setAttribute("class", "even");
		//}
		//document.getElementById("row_"+what_row+"_summary").setAttribute("class", "detail_summary");

		// return false;
		return false;
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
	close: function (placementid, sitedb) {
		setAttributeClass(document.getElementById("TimeSummary"+placementid), "ShowMore");
		
		var summary_div = document.getElementById("timesummarydiv"+placementid);
		$(summary_div).slideUp( "slow", function() {
			// Animation complete.
			summary_div.innerHTML = "";
		});

		$("#TimeSummary"+placementid).attr("onClick","timesummary.open('"+placementid+"','"+sitedb+"')");
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
	recalc: function(placementid, summaryid, siteid) {
		var grand_total_field = $("#sum_rt_"+placementid+"_"+summaryid);
		var grand_total = 0;
		
		for (var i=1;i<7;i++) {
			grand_total+= $("#sum_d"+i+"_"+summaryid).val();
		}
		
		grand_total.val(grand_total.toFixed(2));
	
	},
	remove: function (placementid, sitedb, summaryid) {
		if (confirm("Confirm deletion of selected week?")) {
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
		}
	},
	approve: function (placementid, sitedb, summaryid) {
		var summary_div = document.getElementById("timesummarydiv"+placementid);
	
		if (summary_div.getAttribute("className")!=null){
			summary_div.setAttribute("className", "approved");
		} else {
			summary_div.setAttribute("class", "approved");
		}
		
		var PostStr = "do=approveweek&id=" + placementid + "&site=" + sitedb + "&summary=" + summaryid;

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
	console.log("thisOjb:"+thisObj);
	if (thisObj != null) {
		if (thisObj.getAttribute("className")!=null) {
			thisObj.setAttribute("className", thisClass);
		} else {		
			thisObj.setAttribute("class", thisClass);
		}
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
		disable_enable(oField);
		
		// check if original time being changed, and track
		changeAudit.compare(oField.className);
		
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
				if (confirm("Entering time directly into a Day summary field will erase all, if any, individual time entry's associated with each respective day of the week. \n\nContinue updating hours?")) {
					oForm.elements["WarnedOverwriteDetail"].value = "yes";
				} else {
					return false;
				}
			}
			
			// var PostStr = "variable=value&variable2=value2";
			var PostStr = "do=updateday&id=" + ids[placementid] + "&site=" + sitedb + "&dn=" + ids[dayofweek] + "&summaryid=" + ids[summaryid] + "&time=" +oField.value;
		}
		timesummary.open(placementid, sitedb);
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timedetail.showchange);
	

		return false;
	},
	changewe: function (frmFieldId, sitedb) {
		oForm = document.forms[0];
		oField = document.getElementById(frmFieldId);
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

		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timedetail.showchangedwe);
		return false;
	},
	showchange: function (oXML) {
		// get the response text, into a variable
		var dayofweek = 1;
		var placementid = 2;
		var summaryid = 3;
		
		var ids = oXML.responseText.split("_");
				
		var wk_total = new Number(0);
		
		for (var wk_day = 1;wk_day<8;wk_day++){
			var day_input = document.getElementById('sum_d'+wk_day+"_"+ids[placementid]+"_"+ids[summaryid])
			if (isNumber(day_input.value)){
				wk_total = wk_total + Number(day_input.value);
				day_input.value = Number(day_input.value).toFixed(2);
			};
		}
		document.getElementById('sum_rt_'+ids[placementid]+"_"+ids[summaryid]).value = wk_total;
		document.getElementById('superT_'+ids[placementid]).innerHTML = wk_total;
		
		var oField = document.getElementById("sum_"+ids[dayofweek]+"_"+ids[placementid]+"_"+ids[summaryid]);
		disable_enable(oField);
	},
	showchangedwe: function (oXML) {
		// get the response text, into a variable
		var dayofweek = 1;
		var placementid = 2;
		var summaryid = 3;
		var ids = oXML.responseText.split("_");
				
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
		
		$(detail_div).slideDown( "slow", function() {
			// Animation complete.
		});

		// build up the post string when passing variables to the server side page
		// var PostStr = "variable=value&variable2=value2";
		var PostStr = "do=timedetail&id=" + placementid + "&site=" + sitedb + "&summary=" + summaryid;
		// use the generic function to make the request
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timedetail.show);
		
		$("#TimeDetail"+id).attr("onClick","timedetail.close('"+id+"','"+sitedb+"')");
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
		// timedetaildiv.innerHTML = "";
	},
	close: function (id, sitedb) {
		setAttributeClass(document.getElementById("TimeDetail"+id), "ShowMore");
		
		var placeandtableid = id.split("_");
		var placementid = placeandtableid[0];
		var summaryid = placeandtableid[1];
		
		var detail_div = document.getElementById("timedetaildiv"+placementid+"_"+summaryid);
				
		$(detail_div).slideUp( "slow", function() {
			// Animation complete.
			detail_div.innerHTML = "";
		});
		
		$("#TimeDetail"+id).attr("onClick","timedetail.open('"+id+"','"+sitedb+"')");
		return false;
	},
	addRow: function (tableID) {
		var ids = tableID.split("_");
		var placementid = ids[1];
		var summaryid = ids[2];
		
		
		var PostStr = "do=addtimedetail&placementid="+placementid+"&summaryid="+summaryid;
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timedetail.appendRow);
		return false;
		
		// var table = document.getElementById(tableID+"_template");
		var table = document.getElementById(tableID);
		setAttributeClass(table, "time_detail");
		console.log(tableID+"_template");
		var newRow = document.getElementById(tableID+"_template").cloneNode(true);
		//modify newRow as appropriate
		table.tBodies[0].appendChild(newRow);
	},
	appendRow: function(oXML) {
		var ResponseArry = oXML.response.split("<!-- [split] -->");
		console.log("timedetaildiv"+ResponseArry[1]);
		var TimeDetailDiv = document.getElementById("timedetaildiv"+ResponseArry[1]);
		var CurrentTimeDetail = TimeDetailDiv.innerHTML;
		var AddRowButton = CurrentTimeDetail.indexOf('<span class="add_detail_row button"');
		
		var beforeAddRow = CurrentTimeDetail.substring(0, AddRowButton);
	
		var AddRowButtomHtml = CurrentTimeDetail.substring(AddRowButton);
		var newRowHtml = ResponseArry[0];
		// TimeDetailDiv.innerHTML = beforeAddRow+newRowHtml+AddRowButtomHtml;
		$(TimeDetailDiv).html(beforeAddRow+newRowHtml+AddRowButtomHtml);
	},
	deleteRow: function (tableID, detailid) {
		console.log("delete row: " +tableID+", detailid: "+detailid);
		if (confirm("Confirm delete time detail entry?")==true) {
			var PostStr = "do=deletetimedetail&detailid="+detailid+"&table="+tableID;
			doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timedetail.removeRow);
		}
		return false;
	},
	removeRow: function(oXML){
		var arry = oXML.response.split("_");
		var placementid = arry[1];
		var summaryid = arry[2];
		var detailid = arry[3];
		
		var TimeDetailDiv = document.getElementById("timedetaildiv"+placementid+"_"+summaryid);
		
		var DetailDivHtml = TimeDetailDiv.innerHTML;
		
		var dropTable = DetailDivHtml.indexOf('<table id="timedetail'+detailid+'" class="time_detail">');
		var nextTable = DetailDivHtml.indexOf('<table id="timedetail',dropTable+1)
		
		console.log('Drop Table: '+dropTable);
		console.log('Next Table: '+nextTable);
		
		// check if last table deleted, if so target add_detail_row button instead of next table
		if (nextTable!=-1) {
			TimeDetailDiv.innerHTML = DetailDivHtml.substring(0, dropTable) + DetailDivHtml.substring(nextTable);
		} else {
			TimeDetailDiv.innerHTML = DetailDivHtml.substring(0, dropTable) + DetailDivHtml.substring(DetailDivHtml.indexOf('<span class="add_detail_row button"'));
		}
	},
	update: function(rowid, v) {
		//update code here
	}
}

function AuditDetail() {
  //properties/fields
  var auditid = "";
  var lastChangerId = 0;
  var changedby = 0;
  var field_changed = "";
  var previous_value = "";
  var new_value = "";
  var changed_why = "";

  return {
    setAuditId: function(newAuditId) {auditid=newAuditId;},
	getAuditId: function() {return auditid;},
    setLastChangerId: function(newlastChangerId) {lastChangerId=newlastChangerId;},
	getLastChangerId: function() {return lastChangerId;},
    setChangedById: function(newchangedby) {changedby=newchangedby;},
    getChangedById: function() {return changedby;},
	setFieldChanged: function(newFieldChanged) {field_changed=newFieldChanged;},
    getFieldChanged: function() {return field_changed;},
	setPreviousValue: function(newPreviousValue) {previous_value=newPreviousValue;},
    getPreviousValue: function() { return previous_value; },
	setNewValue: function(newNewValue) {new_value=newNewValue;},
    getNewValue: function() { return new_value; },
	setChangedWhy: function(newChangedWhy) {changed_why=newChangedWhy;},
    getChangedWhy: function() { return changed_why;}
	};
}

var changeAudit = {
		compare: function(objAudit, classes) {
			console.log(auditid); 
			console.log(field);
			console.log(value);
			
			// get class aka c and s id
			alert(classes);
			var changeids = classes.split(" ");
			for (var i=0; i < changeids.length; i++){
			
				if (!changeids[i].indexOf("sid")) {
					auditdetail.setChangedById = parseFloat(changeids[i].substring(3, changeids[i].length));
					
					console.log("s:"+sid);
				} else if (!changeids[i].indexOf("cid")) {
					auditdetail.setLastChangerId = parseFloat(changeids[i].substring(3, changeids[i].length));
					console.log("c:"+cid);
				}
			}
			
			if (cid!==sid) {
				var changeWhy=prompt("Please enter reason for change","Missed swipe");

				if (changeWhy!=null) {
					auditdetail.setChangedWhy=changeWhy;
				} else {
					auditdetail.setChangedWhy="No reason given";
				}
				
				console.log("Change reason: "+auditdetail.getChangedWhy);
				
				
				var PostStr = "do=audittimechange" +
					"&id="+auditdetail.getAuditId + 
					"&nvalue="+auditdetail.getNewValue +
					"&pvalue="+auditdetail.getPreviousValue +
					"&cid="+auditdetail.getLastChangerId +
					"&sid="+auditdetail.getChangedById +
					"&field="+auditdetail.getFieldChanged +
					"&why="+auditdetail.getChangedWhy +
					"&site=na";
					
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', changeAudit.noresults);
			
			}
		},
		noresults: function(oXML) {
			console.log(oXML.responseText);
		}
	}
	
var timeclock = {
	setTime: function(id) {
		elemid=id;
		// console.log(id);
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
		
		// console.log(workday);
		
		if (workday != timeid[4]) {
			if (idtype = "workday") {
				id = id+"_"+workday;
			} else {
				id = id.replace(placementid+"_"+summaryid+"_"+detailid+"_"+timeid[4], placementid+"_"+summaryid+"_"+detailid+"_"+workday);
			}
		}
		
		// console.log("workday value: "+workday);
		// console.log(urlParams);

		// console.log("-----");

		var totalsbox = document.getElementById("total_"+rowid);
		var inselect = document.getElementById("in_"+rowid);
		var outselect = document.getElementById("out_"+rowid);
		var typeselect = document.getElementById("type_"+rowid);
		
		
		// //instantiate the Audit Detail class
		// var aAuditDetail = new AuditDetail();
		// aAuditDetail.setAuditId(id);
		// aAuditDetail.setFieldChanged(timeinput.name);
		// aAuditDetail.setPreviousValue(timeinput.value);
		
		var objTimeChangeAudit = {
			auditid: elemid, 
			field: timeinput.name, 
			value: timeinput.value
		};
	
		// check if original time being changed, and track
		console.log("elem: "+elemid);
		var theseclasses = document.getElementById(elemid).className
		console.log("classname: "+theseclasses);
		changeAudit.compare(objTimeChangeAudit, theseclasses);
		
		console.log("here");
				
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
		console.log("sum_d" + dayid + "_" + placementid + "_" + summaryid);
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
