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

//augment native DOM functions a touch, add remove method to prototypes
Element.prototype.remove = function() {
    this.parentElement.removeChild(this);
}
NodeList.prototype.remove = HTMLCollection.prototype.remove = function() {
    for(var i = 0, len = this.length; i < len; i++) {
        if(this[i] && this[i].parentElement) {
            this[i].parentElement.removeChild(this[i]);
        }
    }
}

var customer = {
	hidden: function(oXML) {
		console.log(oXML.responseText);
	},
	hide: function (customercode, sitedb) {
		smoke.quiz("Confirming hide customer code \""+customercode+"\" from view? \n<i class=\"smaller\">Note: Go to Temps / Maintain Customer / Customer Info, to unhide", function(e){
			if (e == "Yes"){
				
				var PostStr = "do=hidecustomer&id=" + customercode + "&site=" + sitedb;
				console.log(PostStr);

				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', customer.hidden);
				document.getElementById(customercode+".row").remove();
				return true;
			} else if (e == "No") {
				return false;
			}
		}, {
			button_1: "Yes",
			button_2: "No",
			button_cancel: "Cancel"
		});
	},
	getorders: function (customercode, sitedb, status) {
	
		setAttributeClass(document.getElementById(status+"ordersdiv"+customercode), "loading");
		setAttributeClass(document.getElementById("ctrlCustomers"+customercode), "ShowLess");

		switch(status) {
			case "closed":
				var PostStr = "do=getorders&id=" + customercode + "&site=" + sitedb + "&status=closed";
				console.log(PostStr);
				
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', customer.showclosedorders);
				return false;
				break;
			case "open":
				var PostStr = "do=getorders&id=" + customercode + "&site=" + sitedb;
				console.log(PostStr);
				
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', customer.showopenorders);
				return false;
				break;
		}
	},	getemployeeorders: function (customercode, sitedb, status) {
	
		setAttributeClass(document.getElementById(status+"ordersdiv"+customercode), "loading");
		setAttributeClass(document.getElementById("ctrlCustomers"+customercode), "ShowLess");

		switch(status) {
			case "closed":
				var PostStr = "do=getemployeeorders&id=" + customercode + "&site=" + sitedb + "&status=closed";
				console.log(PostStr);
				
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', customer.showclosedorders);
				return false;
				break;
			case "open":
				var PostStr = "do=getemployeeorders&id=" + customercode + "&site=" + sitedb;
				console.log(PostStr);
				
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', customer.showopenorders);
				return false;
				break;
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
				break;
			case "open":
				var PostStr = qs;
				console.log(PostStr);
				
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', customer.show.customer);
				return false;
				break;
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
	getemployeeplacements: function (custcode, reference, sitedb) {
		console.log("ctrl.Orders."+custcode+"."+reference);
		setAttributeClass(document.getElementById("or"+custcode+reference), "loading");
		setAttributeClass(document.getElementById("ctrl.order."+custcode+"."+reference), "ShowLess");

		$("#or"+custcode+reference).slideDown( "slow", function() {
			// Animation complete.
		});

		document.getElementById("ctrl.order."+custcode+"."+reference).onclick = function() {
			order.close(custcode,reference,sitedb);return false; 
		}
		
		var PostStr = "do=getemployeeplacements&id=" + reference + "&site=" + sitedb + "&customer=" + custcode;
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
		smoke.quiz("Expecting a final time card?", function(e){
			if (e == "Yes"){
				document.getElementById("Placement"+id).className = "Working";
				//do procedure call
				doAJAXCall('/include/system/tools/activity/reports/etc/ajax/doThings.asp?do=close&id='+id+'&site='+site+'&needfinaltime=true', 'POST', '' + PostStr + '', placement.showexpected);
			} else if (e == "No") {
				document.getElementById("Placement"+id).className = "Working";
				//do procedure call
				doAJAXCall('/include/system/tools/activity/reports/etc/ajax/doThings.asp?do=close&id='+id+'&site='+site+'&needfinaltime=false', 'POST', '' + PostStr + '', placement.showopen);
			}
		}, {
			button_1: "Yes",
			button_2: "No",
			button_cancel: "Cancel"
		});
			
			smoke.prompt("Enter last date worked:", function(e){
			if (e =="Yes")
			{
			return true;
			}
			else
			{
			
			}
			
		}, 
			{
			ok: "Submit",
			cancel: "Cancel",
			classname: "custom-class",
			reverseButtons: true,
			value: ""
			});
			
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
		doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', this.show);
		
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
		// expect id format example: timesummarydiv30128
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
			grand_total+= $("#sum_d"+timeclock.getday(i)+"_"+summaryid).val();
		}
		
		grand_total.val(grand_total.toFixed(2));
	
	},
	remove: function (placementid, sitedb, summaryid) {
		smoke.confirm("Are you sure you want to delete the selected week?", function(e){
			if (e){
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
		}, {
			ok: "Yes",
			cancel: "No",
			classname: "custom-class",
			reverseButtons: true
		});
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

var elementInDocument = function(element) {
    while (element = element.parentNode) {
        if (element == document) {
            return true;
        }
    }
    return false;
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

// create object to hold form variables with global scope
var ajaxTimeDetailBuffer=new Array(1);
	ajaxTimeDetailBuffer[0]=new Array();
	ajaxTimeDetailBuffer[1]=new Array();

	
var timedetail = {
	getdayname: function(weekday) {
		switch (weekday) {
			case 2:
				return "mon";
				break;
			case 3:
				return "tue";
				break;

			case 4:
				return "wed";
				break;

			case 5:
				return "thu";
				break;

			case 6:
				return "fri";
				break;

			case 7:
				return "sat";
				break;

			case 1:
				return "sun";
				break;

			default:
				return false;
		}
	},
	getdayid: function(weekday) {
		switch (weekday) {
			case "mon":
				return 2;
				break;
			case "tue":
				return 3;
				break;

			case "wed":
				return 4;
				break;

			case "thu":
				return 5;
				break;

			case "fri":
				return 6;
				break;

			case "sat":
				return 7;
				break;

			case "sun":
				return 1;
				break;

			default:
				return false;
		}
	},
	setBuffer: function(elem) {
		
	// get 'input' tags
	var subInputs = elem.getElementsByTagName('input');
	  for(var i=0;i<subInputs.length;i++) {
		ajaxTimeDetailBuffer[0][i] = subInputs[i].id;
		ajaxTimeDetailBuffer[1][i] = subInputs[i].value;
	  }
	  var slctOffset = i;
	  
	  // get 'select' tags
	  var subSelects = elem.getElementsByTagName('select');
	  for(var i=0;i<subSelects.length;i++) {
		ajaxTimeDetailBuffer[0][i+slctOffset] = subSelects[i].id;
		ajaxTimeDetailBuffer[1][i+slctOffset] = subSelects[i].value;
		console.log('input id:'+subSelects[i].id+',value:'+subSelects[i].value);
		}
	},		
	restoreBuffer: function() {
		// restore previous values
		for(var i=0;i<ajaxTimeDetailBuffer[0].length;i++) {
			var elem=document.getElementById(ajaxTimeDetailBuffer[0][i]);
			if (elem != null) {
				if(!elem.tagName.toLowerCase().indexOf('workday')===-1) {
					// select input
					for ( var i = 0; i < elem.options.length; i++ ) {
						if (elem.options[i].value == ajaxTimeDetailBuffer[1][i] ) {
							s.options[i].selected = true;
							return;
						}
					}
				} else {// text input
					elem.value=ajaxTimeDetailBuffer[1][i];
				}
			}
		}
		ajaxTimeDetailBuffer[0].length=0;
		ajaxTimeDetailBuffer[1].length=0;
	},
	change: function (frmFieldId, sitedb) {
		oForm = document.forms[0];
		oField = document.getElementById(frmFieldId);
		disable_enable(oField);
		
		// check if original time being changed, and track
		
		var objTimeChangeAudit = {
			auditid: frmFieldId, 
			field: oField.name, 
			newvalue: oField.value,
			oldvalue: oField.defaultValue,
			classes: oField.className,
			cid: -1,
			sid: -1
		};
		
		changeAudit.compare(objTimeChangeAudit);
		
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
			timesummary.open(placementid, sitedb);
			doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', this.showchange);
		} else {
			
			if (oForm.elements["WarnedOverwriteDetail"].value != "yes") {

				smoke.confirm("Entering a time summary will erase individual time entries that are on the same day of this week. Continue entering hours?", function(e){
					if (e){
						oForm.elements["WarnedOverwriteDetail"].value = "yes";
						// var PostStr = "variable=value&variable2=value2";
						var PostStr = "do=updateday&id=" + ids[placementid] + "&site=" + sitedb + "&dn=" + ids[dayofweek] + "&summaryid=" + ids[summaryid] + "&time=" +oField.value;

						doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', this.showchange);
				
					}else{
						return false;
					}
				}, {
					ok: "Yes",
					cancel: "No",
					classname: "custom-class",
					reverseButtons: true
				});	
			
			} else {
			
				// var PostStr = "variable=value&variable2=value2";
				var PostStr = "do=updateday&id=" + ids[placementid] + "&site=" + sitedb + "&dn=" + ids[dayofweek] + "&summaryid=" + ids[summaryid] + "&time=" +oField.value;
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', this.showchange);
			}
		
		}

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
		var siteid = 4;
		
		var ids = oXML.responseText.split("_");
				
		var wk_total = new Number(0);
		
		for (var wk_day = 1;wk_day<8;wk_day++){
			var day_input = document.getElementById('sum_d'+timedetail.getdayname(wk_day)+"_"+ids[placementid]+"_"+ids[summaryid])
			if (isNumber(day_input.value)){
				wk_total = wk_total + Number(day_input.value);
				day_input.value = Number(day_input.value).toFixed(2);
			};
		}
		document.getElementById('sum_rt_'+ids[placementid]+"_"+ids[summaryid]).value = wk_total;
		document.getElementById('superT_'+ids[placementid]).innerHTML = wk_total;
		
		var oField = document.getElementById("sum_"+ids[dayofweek]+"_"+ids[placementid]+"_"+ids[summaryid]);
		var className= $('#TimeDetail'+ids[placementid]+'_'+ids[summaryid]).attr('class');
		console.log(className);
		
		if (className!=='ShowMore') {
			timedetail.open(ids[placementid]+'_'+ids[summaryid], ids[siteid]);
		}
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
	commentRow: function (tableID, detailid) {
	
		console.log("in addRow");
		var ids = tableID.split("_");
		var placementid = ids[1];
		var summaryid = ids[2];
		
		// backup input values
		divTimeDetail=document.getElementById("timedetaildiv"+placementid+"_"+summaryid);
		timedetail.setBuffer(divTimeDetail);
		
		smoke.prompt("Enter comment:", function(e){
			if (e){
				var PostStr = "do=adddetailcomment" +
					"&pid="+placementid +
					"&summary="+summaryid +
					"&detailid="+detailid +
					"&comment="+encodeURIComponent(e) +
					"&site=na";
					
					var user_home = document.getElementById('guid')
					var name_end = user_home.innerHTML.indexOf(" [logged in]", "");
					var user_name = user_home.innerHTML.substring(0, name_end);
					
					var commentdiv = document.getElementById('commentrow_'+placementid+'_'+summaryid+'_'+detailid);
					commentdiv.className="show";
					
					commentdiv.innerHTML = '<span><i>'+e+'&nbsp;-&nbsp;'+user_name+'</i></span>'+commentdiv.innerHTML;
					
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', this.updateComments);
				return true;

			}else{
			
			}
		}, {
			ok: "Add Comment",
			cancel: "Cancel",
			classname: "custom-class",
			reverseButtons: true,
			value: ""
		});
	},
	updateComments: function (oXML) {
		return false;
	},
	addRow: function (tableID) {
		console.log("in addRow");
		var ids = tableID.split("_");
		var placementid = ids[1];
		var summaryid = ids[2];
		
		// backup input values
		divTimeDetail=document.getElementById("timedetaildiv"+placementid+"_"+summaryid);
		timedetail.setBuffer(divTimeDetail);
			
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
		
		// restore previous values
		timedetail.restoreBuffer();

	},
	deleteRow: function (tableID, detailid) {
		
		smoke.confirm("Are you sure you want to delete the time detail entry?", function(e){
			if (e){
				// backup input values
				var table=tableID.replace("plcemntTbl_","timedetaildiv");
				divTimeDetail=document.getElementById(table);
				timedetail.setBuffer(divTimeDetail);
				
				var PostStr = "do=deletetimedetail&detailid="+detailid+"&table="+tableID;
				doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timedetail.removeRow);
				return false;
			}
		}, {
			ok: "Yes",
			cancel: "No",
			classname: "custom-class",
			reverseButtons: true
		});
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
		// check if last table deleted, if so target add_detail_row button instead of next table
		if (nextTable!=-1) {
			TimeDetailDiv.innerHTML = DetailDivHtml.substring(0, dropTable) + DetailDivHtml.substring(nextTable);
			// restore previous values
			timedetail.restoreBuffer();
		} else {
			TimeDetailDiv.innerHTML = DetailDivHtml.substring(0, dropTable) + DetailDivHtml.substring(DetailDivHtml.indexOf('<span class="add_detail_row button"'));
			// restore previous values
			timedetail.restoreBuffer();
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
		compare: function(objAudit) {
			console.log(objAudit.auditid); 
			console.log(objAudit.field);
			console.log(objAudit.value);
			
			
			var changed = true
			var nochange = true
			var canceled = false
			
			// get class aka c and s id
			var changeids = objAudit.classes.split(" ");
			for (var i=0; i < changeids.length; i++){
			
				if (!changeids[i].indexOf("sid")) {
					var sid = parseFloat(changeids[i].substring(3, changeids[i].length));
					
					// console.log("s:"+sid);
				} else if (!changeids[i].indexOf("cid")) {
					var cid = parseFloat(changeids[i].substring(3, changeids[i].length));
					// console.log("c:"+cid);
				}
			}
			
			objAudit.cid=cid;
			objAudit.sid=sid;
			console.log("cid:"+cid)

			if (cid==0) { // change back to cid!==sid later to reengage
				smoke.prompt("What is the reason for the change?", function(e){
					if (e){
						console.log("inside smoke statement");

						// fix-up id with missing day number if being called from summary box
						var patched_day = "";
						if (objAudit.auditid.indexOf("sum_d")>-1){
							var d=objAudit.auditid.indexOf("sum_d");
							patched_day="_"+timedetail.getdayid(objAudit.auditid.substr(d+5, 3));
						}
						
						var PostStr = "do=audittimechange" +
							"&id="+objAudit.auditid+patched_day + 
							"&nvalue="+objAudit.newvalue +
							"&pvalue="+objAudit.oldvalue +
							"&cid="+objAudit.cid +
							"&sid="+objAudit.sid +
							"&field="+objAudit.field +
							"&why="+encodeURIComponent(e) +
							"&site=na";
							
						console.log(e);
						
						doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', changeAudit.noresults);
						objAudit.newvalue=objAudit.oldvalue;
						return changed;
				
					}else{
						document.getElementById(objAudit.auditid).value=objAudit.oldvalue;
						timeclock.updatesummary($(objAudit.we_connector));
						return canceled;
					}
				}, {
					ok: "Change Time",
					cancel: "Cancel",
					classname: "custom-class",
					reverseButtons: true,
					value: ""
				});
					
			} else { // no need to change
				return nochange;
			}
		console.log("outside smoke statement");
		return nochange;
				
		},
		noresults: function(oXML) {
			console.log(oXML.responseText);
		}

	}

var timeclock = {
	getday: function(d) {
		var weekday=new Array(7);
		weekday[0]="sun";
		weekday[1]="mon";
		weekday[2]="tue";
		weekday[3]="wed";
		weekday[4]="thu";
		weekday[5]="fri";
		weekday[6]="sat";
		return weekday[d];
	},
	updatesummary: function(elem) {

		// setBuffer: function(elem) {
			
		// get 'input' tags
		var detailentries = elem.getElementsByClassName('detailentry');
		
		var totalsByDay = new Array();
		for (var i = 0;i<7;i++) {totalsByDay[this.getday(i)]=0}
		
		for(var i=0;i<detailentries.length;i++) {
			var workdays=detailentries[i].getElementsByClassName('detailday');
				var d=workdays[0].options[workdays[0].selectedIndex].innerHTML.toLowerCase();
				
			var totalfield=detailentries[i].getElementsByClassName('detailtotal');
				if (!isNaN(totalfield[0].value)){
					if (isNaN(parseFloat(totalsByDay[d]))) {totalsByDay[d]=0;}
					totalsByDay[d]+=parseFloat(totalfield[0].value);
				}
		}
		console.log(elem.id);
		for(var i=0;i<6;i++){
			console.log('total:'+totalsByDay[this.getday(i)].toFixed(2));
		}
		var daysums = elem.getElementsByClassName('daysum');
		
		for(var i=0;i<daysums.length;i++) {
			
			var sumid=daysums[i].id.split('_');
			var sumbox=document.getElementById('sum_d'+this.getday(i)+'_'+sumid[2]+'_'+sumid[3]);
			sumbox.value=totalsByDay[this.getday(i)].toFixed(2);
		}

		totalsByDay.forEach(function(entry) {
			console.log(entry);
		});
		
	},
	getseconds: function(t1) {
	
		t1 = this.prettyTime(t1); // input string '02:04:33'

		// minutes are worth 60 seconds, hours worth 60 minutes
		var a = t1.split(':'); // split it at the colons
		return s1 = (+a[0]) * 60 * 60 + (+a[1]) * 60; 	
	},	
	gethours: function(t1) {
	
		t1=this.getseconds(t1) / 60 / 60;
		return t1.toFixed(2);
	},	
	tallydiff: function(start, end) {

		start = start.split(":");
		end = end.split(":");
		var startDate = new Date(0, 0, 0, start[0], start[1], 0);
		var endDate = new Date(0, 0, 0, end[0], end[1], 0);
		var diff = endDate.getTime() - startDate.getTime();
		var hours = Math.floor(diff / 1000 / 60 / 60);
		diff -= hours * 1000 * 60 * 60;
		var minutes = Math.floor(diff / 1000 / 60);

		return this.gethours((hours <= 9 ? "0" : "") + hours + ":" + (minutes <= 9 ? "0" : "") + minutes);
	},
	prettyTime: function(t) {
		var t   = t.toLowerCase();
		
		// check if 'a' or 'p' is in input without a ':' and format appropriately
		var am    = t.indexOf('a');
		var pm    = t.indexOf('p');

		var colon = t.indexOf(':');
		if (colon===-1 && am>-1) { // if am
			t=t.substring(0,am)+':00a';
		} else if (colon===-1 && pm>-1) { // if pm
			t=t.t(0,pm)+':00p';
		}
		
		// check if military
		if (t.length===4 && colon===-1) {
			// four number military ':'
			t=t.substring(0,2)+':'+t.substring(2,5);		
			
			// strip leading zero
			if (t.substring(0,1)=='0') {
				t=t.substring(1,6);
			}
		} else if (t.length===3 && colon===-1) {
			// three number military
			t=t.substring(0,1)+':'+t.substring(1,4);		
			
			// strip leading zero
			if (t.substring(0,1)=='0') {
				t=t.substring(1,6);
			}
		}
			
		// will output a time providing leading zeros and minute field
		x=t.split(":");

		for (var i=0; i<2; i++)
		x[i] = (x[i]) ? Array(3-x[i].length).join('0') + x[i] : '00';

		return x.join(":");
	},
	setTime: function(id) {
		elemid=id;
		// console.log(id);
		var timeid        = id.split("_");
		var idtype        = timeid[0]; //type of input selected: In, Out, Total, or Type
		var placementid   = timeid[1];
		var summaryid     = timeid[2];
		var detailid      = timeid[3];
		var workday       = timeid[4];
		// var workday       = document.getElementById(id).value;
		var rowid         = placementid+"_"+summaryid+"_"+detailid+"_"+workday;
		var timeinput     = document.getElementById(id);
		
		// set audit values
		var objTimeChangeAudit = {
			auditid: elemid, 
			we_connector: 'we_connector_'+placementid+'_'+summaryid,
			summaryid: summaryid, 
			field: timeinput.name,
			newvalue: timeinput.value,
			oldvalue: timeinput.defaultValue,
			classes: document.getElementById(elemid).className
		};
				
		var f             = document.getElementById('report_form');
		var timein        = f[timeinput.name][0].value;
		var timeout       = f[timeinput.name][1].value;
		var timetotal     = f[timeinput.name][2].value;
		var timetype      = f[timeinput.name][3].value;
		
		// remarked 2014.2.4, deprecated and orphaned
		// if (workday !== timeid[4]) {
			// if (idtype = "workday") {
				// id = id+"_"+workday;
			// } else {
				// id = id.replace(placementid+"_"+summaryid+"_"+detailid+"_"+timeid[4], placementid+"_"+summaryid+"_"+detailid+"_"+workday);
			// }
		// }
		
		var totalsbox = document.getElementById("total_"+rowid);
		var inselect = document.getElementById("in_"+rowid);
		var outselect = document.getElementById("out_"+rowid);
		var typeselect = document.getElementById("type_"+rowid);
		
		 //instantiate the Audit Detail class
		 var aAuditDetail = new AuditDetail();
		 aAuditDetail.setAuditId(id);
		 aAuditDetail.setFieldChanged(timeinput.name);
		 aAuditDetail.setPreviousValue(timeinput.value);
		
		switch(idtype){
			case "in":
				console.log("in");
				timeinput.value = this.prettyTime(objTimeChangeAudit.newvalue);
				objTimeChangeAudit.id = document.getElementById("in_"+rowid);
				objTimeChangeAudit.newvalue = timeinput.value;
				timein = f[timeinput.name][0].value;
				
				if (changeAudit.compare(objTimeChangeAudit) === true) {
					// var PostStr = "do=updatetimedetail&id=" + id + "&t=" + timein + "&site=na";
					var PostStr = "do=updatetimedetail&id=" + id + "&t=" + objTimeChangeAudit.newvalue + "&site=na";
					doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timeclock.updated);
					if (timein > timeout) {
						totalsbox.value = this.tallydiff(timeout,timein);
					} else {
						totalsbox.value = this.tallydiff(timein,timeout);
					}
				} else {
					console.log('reverting field');
					timeinput.value=timeinput.defaultValue;
				};
				break;
			case "out":
				console.log("out");
				timeinput.value = this.prettyTime(objTimeChangeAudit.newvalue);
				objTimeChangeAudit.id = document.getElementById("out_"+rowid);
				objTimeChangeAudit.newvalue = timeinput.value;
				timeout = f[timeinput.name][1].value;
				if (changeAudit.compare(objTimeChangeAudit) === true) {
					// var PostStr = "do=updatetimedetail&id=" + id + "&t=" + timeout + "&site=na";
					if (objTimeChangeAudit.newvalue!==objTimeChangeAudit.oldvalue) {
						var PostStr = "do=updatetimedetail&id=" + id + "&t=" + objTimeChangeAudit.newvalue + "&site=na";
						doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timeclock.updated);
						if (timein > timeout) {
							totalsbox.value = this.tallydiff(timeout,timein);
						} else {
							totalsbox.value = this.tallydiff(timein,timeout);
						}
					}
				} else {
					console.log('reverting field');
					timeinput.value=timeinput.defaultValue;
				};
				break;
			case "total":
				console.log("total");
				objTimeChangeAudit.id = document.getElementById("total_"+rowid);
				objTimeChangeAudit.pvalue=timetotal;
				if (changeAudit.compare(objTimeChangeAudit) === true) {
					var PostStr = "do=updatetimedetail&id=" + id + "&t=" + timetotal + "&site=na";
					doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timeclock.updated);
					inselect.value = "";
					outselect.value = "";
				} else {
					console.log('reverting field');
					timeinput.value=timeinput.defaultValue;
				};
				break;
			case "type":
				console.log("update TimeDetail Type");
				objTimeChangeAudit.pvalue=timetype;
				if (changeAudit.compare(objTimeChangeAudit) === true) {
					var PostStr = "do=updatetimedetail&id=" + id + "&t=" + timetype + "&site=na";
					doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timeclock.updated);
				} else {
					console.log('reverting field');
					timeinput.value=timeinput.defaultValue;
				};
				break;
			case "workday":
				console.log("in workday");
				if (changeAudit.compare(objTimeChangeAudit) === true) {
					console.log("update TimeDetail workday");
					console.log(id);
					// var PostStr = "do=updatetimedetail&id=" + id + "&t=" + workday + "&site=na";
					var PostStr = "do=updatetimedetail&id=" + id + "&t=" + timeinput.value + "&site=na";
					doAJAXCall('ajax/doThings.asp?', 'POST', '' + PostStr + '', timeclock.updated);
				} else {
					console.log('reverting field');
					timeinput.value=timeinput.defaultValue;
				};
				break;
			default:
				console.log("don't recognize any of the types: " + idtype);
				break;
		}		
	},
	updated: function(oXML) {
		console.log(oXML.responseText);
		var paraStr = oXML.responseText.replace(/[\])}[{(]/g,'').split(","); //remove (){}[] and split into variable
		// var dayid = paraStr[4];
		var placementid = paraStr[1];
		var summaryid = paraStr[2];
		// var newvalue = paraStr[5]
		// var summarybox = document.getElementById("sum_d" + dayid + "_" + placementid + "_" + summaryid);
		// console.log("sum_d" + dayid + "_" + placementid + "_" + summaryid);
		// summarybox.value = newvalue;	
		console.log('id:we_connector_'+placementid+'_'+summaryid);
		
		var summarydiv=document.getElementById('we_connector_'+placementid+'_'+summaryid);
		timeclock.updatesummary(summarydiv);
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

// PetStore.open();

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
