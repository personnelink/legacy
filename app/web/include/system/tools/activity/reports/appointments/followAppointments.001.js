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

var appointment = {
	newone: function(obj) {
		grayOut(true);
		
		// build up the post string when passing variables to the server side page
		// var PostStr = "variable=value&variable2=value2";
		var PostStr = "do=newappointment&site="+$("#whichCompany").val();
		
		// use the generic function to make the request
		doAJAXCall('/include/system/tools/activity/reports/appointments/ajax/', 'POST', '' + PostStr + '', appointment.setup);

	},
	setup: function(oXML) {
		var PostStr = "";

		doAJAXCall('/include/system/tools/activity/reports/appointments/?isservice=true&appointmentid='+oXML.response, 'POST', '' + PostStr + '', appointment.refresh);
		
		// jQuery(this).prev("li").attr("id","newId");
		$("#appointments").attr('class', 'appointments');
		
		// $("#new_appointment_div").addClass('marB10');	
		// $("#new_appointment").attr('class', 'placements');	
		// $(obj).attr('class', 'hide');
	},
	refresh: function(oXML) {
		var current_stream = $("#appointment_stream").html()
		$("#appointment_stream").html(oXML.response+current_stream);
		grayOut(false);
	},
	comment: {
		focus_edit: function(memoid) {
			
			$('#'+memoid).trigger('onclick');
		},
		edit: function(obj) {
			var oldsource = $(obj).attr("class","hide"); //hide comment span
			var commentid = $(obj).attr('id');
			var newsource = $("#txt_"+commentid); //textarea
			
			newsource.html($(obj).html()); //fill textarea with comment
			newsource.attr('class','memo'); //show textarea
			$("#txt_"+commentid).bind("blur", function() {appointment.comment.update(newsource.attr('id'), commentid)});
			$("#txt_"+commentid).focus();
		},
		update: function(txtObj, spanObj) {
			console.log("inside update");
			var newcomment = $("#"+txtObj).val();
			var txtspan = $("#"+spanObj).html();
			if (txtspan!=newcomment){
				$("#"+txtObj).attr("class","hide");
				$("#tr_"+spanObj).attr("class","updating");
				$("#"+spanObj).attr("class","show");
				$("#"+spanObj).html(newcomment);
				
				var PostStr = "do=updatecomment&appointmentid="+$("#"+txtObj).attr("id")+"&comment="+encodeURI(newcomment)+"&site="+$("#whichCompany").val();

				// use the generic function to make the request
				doAJAXCall('ajax/', 'POST', '' + PostStr + '', this.updated);
			} else {
				console.log('no changes');
			}
			return false;			
		},
		updated: function(oXML) {
			console.log("updated");
				$("#tr_cm"+oXML.response).attr("class","footer");
				$("#cm"+oXML.response).attr("class","description");
		}
	}
}

var look_timer
var do_search // needs global scope otherwise the function lookup.search that calls sets this will throw it away
var clear_search_popup // delay for click event and housekeeping
var params

var lookup = {
	show: function(context, appointmentid) {
		clearTimeout(clear_search_popup);
		
		var context_flag = context.substring(1,1); // switching for div showing and hiding
		var divid = appointmentid;
		console.log(("#"+context+"_"+divid));

		$("#"+context+"_"+divid).removeClass( "hide" );
		$("#"+context_flag+"srch_"+divid).html($("#"+context_flag+"span_"+divid)); // grab any value already there and populate input with it
		$("#"+context+"_"+divid).addClass('search_div show'); // show floating div
		$("#inp_"+context+"_"+divid).focus(); // focus cursor
		console.log('expanding appointments...');
		$("#g_appointments_pane").height("+=18");
		
	},
	destroy: function(context, appointmentid) {
		clearTimeout(clear_search_popup);
		
		var context_flag = context.substring(1,1); // switching for div showing and hiding
		var divid = appointmentid;

		console.log('clearing input box... '+'inp_'+context+'_'+appointmentid);
	
		var elem = document.getElementById("inp_"+context+"_"+divid);
		
		var appointmentid = elem.getAttribute("data-appointmentid");
		var context = elem.getAttribute("data-type");
		
		var context_flag = context.substring(1,1); // switching for div showing and hiding
		var divid = appointmentid;
		$("#"+context_flag+"span_"+divid).attr('class', 'show'); // reshow original
		$("#"+context+"_"+divid).attr('class', 'hide'); // hide lookup contain
		// $("#inp_"+context+"_"+appointmentid).value="";
		$("#"+context+"LookUp_"+appointmentid).innerHTML="";

		// update temps
		var PostStr = "do=setvalue&context="+context+"&apptid="+appointmentid+"&ifc=&q="+encodeURI(elem.value)+"";
		console.log(PostStr);
		
		doAJAXCall('ajax/?', 'POST', '' + PostStr + '', lookup.suggest);
	},
	search: function(elem) {
		clearTimeout(do_search);
		clearTimeout(clear_search_popup);
		do_search = setTimeout(function () {
			
			var site = elem.getAttribute("data-site");
			var appointment = elem.getAttribute("data-appointmentid");
			var context = elem.getAttribute("data-type");
		
			var search = elem.value;
			var if_customer = document.getElementById("inp_customer_"+appointment).value;
			
			// var PostStr = "do=lookupcustomer&search="+obj.value+"&site="+user_site+"&apptid="+apptid;
			var PostStr = "do=lookup&context="+context+"&apptid="+appointment+"&ifc="+if_customer+"&q="+encodeURI(search)+"&use_qs=1";
			console.log(PostStr);
			
			doAJAXCall('ajax/?', 'POST', '' + PostStr + '', lookup.suggest);
			return false;

			// handle server response to lookup request and update results div
		}, 100);
	},
	suggest: function(oXML){
		search_results = oXML.responseText.split("<here>");
		
		var search_context = search_results[1];
		var fetch_table_id = search_results[2];
		console.log("sticking it here: "+search_context+"LookUp_"+fetch_table_id);
		var stick_results_here = document.getElementById(search_context+"LookUp_"+fetch_table_id);
		stick_results_here.innerHTML = search_results[0];
		console.log(search_results[0]);
		
	},
	set_value: function(context, appointmentid, code, description) {
		
		code = code.replace("<b>", "").replace("</b>", "");
		description = decodeURI(description.replace("<b>", "").replace("</b>", ""));
		
		console.log('setting value #inp_'+context+'_'+appointmentid);
		var input_box = document.getElementById("inp_"+context+"_"+appointmentid);
		input_box.value=code;
		console.log(code+"&nbsp;:&nbsp;"+description);
		console.log("#"+context.substr(0,1)+"span_"+appointmentid);
		
		document.getElementById(context.substr(0,1)+"span_"+appointmentid).innerHTML=code+"&nbsp;:&nbsp;"+description;
		this.set_self_destruct(context, appointmentid);
		// cspan_107354
				
		// inp_order_107354
	},
	set_self_destruct: function(context, appointmentid) {
		clear_search_popup = setTimeout(function() {lookup.destroy(context, appointmentid);}, 250);
	}
}


var company = {
	showlookup: function(divid) {
		$("#cspan_"+divid).attr('class', 'hide');
		$("#csrch_"+divid).html($("#cspan_"+divid));
		$("#customer_"+divid).attr('class', 'show');
		
		
	},
	hidelookup: function(divid) {
		$("#cspan_"+divid).attr('class', 'show');
		$("#customer_"+divid).attr('class', 'hide');
	},
	lookup: function(obj, apptid) {
			var oobbj = $("#csrch_"+apptid);
				var PostStr = "do=lookupcustomer&search="+obj.value+"&site="+user_site+"&apptid="+apptid;
				console.log(PostStr);
				
				doAJAXCall('ajax/?', 'POST', '' + PostStr + '', this.suggest);
				return false;
	},
	suggest: function(oXML){
		var results = document.getElementById("companyLookUp");
		results.style.display='block';
		results.innerHTML = oXML.response;
	}
}


var order = {
	showlookup: function(divid) {
		$("#jspan_"+divid).attr('class', 'hide');
		$("#job_"+divid).attr('class', 'show');
	},
	hidelookup: function(divid) {
		$("#jspan_"+divid).attr('class', 'show');
		$("#job_"+divid).attr('class', 'hide');
	},
	lookup: function () {
	}
}

var lookup_timer
var applicant = {
	showlookup: function(divid) {
		$("#aspan_"+divid).attr('class', 'hide');
		$("#applicant_"+divid).attr('class', 'show');
	},
	hidelookup: function(divid) {
		$("#aspan_"+divid).attr('class', 'show');
		$("#applicant"+divid).attr('class', 'hide');
	},
	lookup: function(obj) {
				var PostStr = "do=lookupcustomer&search="+obj.value+"&site=0";
				console.log(PostStr);
				
				doAJAXCall('ajax/?', 'POST', '' + PostStr + '', this.suggest);
				return false;
	},
	suggest: function(oXML){
		var results = document.getElementById("CompanyLookUp");
		results.style.display='block';
		results.innerHTML = oXML.response;
	},
	applicant: {
		showinput: function() {
			$("#newApplicantId").attr("class","show");
		},
		getinfo: function() {
			clearTimeout(lookup_timer);	
			var search = document.getElementById("newApplicantId");
			var PostStr = "do=applicantlookup&search="+search.value;
			
			// use the generic function to make the request
			doAJAXCall('/include/system/tools/activity/reports/appointments/ajax/?'+PostStr, 'POST', '' + PostStr + '', showMessageResponse);	
		},
		showinfo: function(oXML){
 			// get the response text, into a variable
			var response = oXML.responseText;
			
			// update the Div to show the result from the server
			$("#lookup_applicant").html(response);
		}
	},
	
}

// launched from button click 
var source = {
	edit: function(sourceid) {
		var oldsource = document.getElementById("from"+sourceid);
		var newsource = document.getElementById("new"+sourceid);
		
		oldsource.style.display='none';
		newsource.value = oldsource.innerHTML;
		newsource.style.display='block';
		newsource.select();
	},
	check: function(event, sourceid) {
		if (event.keyCode == 13) {
			source.update(sourceid);
		}
	},		
	update: function(sourceid) {
	console.log("souce id: "+sourceid);
		var oldsource = document.getElementById("from"+sourceid);
		var newsource = document.getElementById("new"+sourceid);
		
		newsource.style.display='none';
		
		var PostStr = "do=update&heard=" + oldsource.innerHTML + "&now=" + newsource.value;
		
		oldsource.innerHTML = newsource.value;
		oldsource.style.display='block';

		
		// use the generic function to make the request
		doAJAXCall('ajax/', 'POST', '' + PostStr + '', source.updated);
		return false;
	},
	updated: function(oXML) {
		console.log("updated");
	}
}


function check_enter(event) {
	if (event.keyCode == 13) {
		sign_in();
	}
}

function setApplicantId(thisId, thisName) {
	var search = document.getElementById("signApplicantIn");
	search.value = thisId;
	document.getElementById("lookup_applicant").innerHTML = "<p><em><i>"+thisName+"</i></em></p>";
	document.getElementById("signInComment").focus();
}

// from whose_here.js
function sign_in() {
	document.whoseHereForm.action.value='signin';
	document.whoseHereForm.submit();
}

// -->

// activity types and status classes


function triggerEvent(el, type) {
    if ((el[type] || false) && typeof el[type] == 'function')
    {
        el[type](el);
    }
}

var assignto = {
	show: function(id) {
		//show dispositions selection box
		document.getElementById("span_assignto_"+id).className = "hide";
		document.getElementById("assignto_"+id).className = "disposition";
		selbox = document.getElementById("assign_"+id);
		
		selbox.size = 5;
		selbox.style.position='absolute';
		selbox.style.height='auto';
		selbox.focus();
		//hide current disposition status
	},
	set: function(id) {

		selbox = document.getElementById("assign_"+id);
		document.getElementById("span_assignto_"+id).innerHTML = selbox.options[selbox.value].text;
		document.getElementById("span_assignto_"+id).className = "disposition";
		//show current disposition status

		//hide dispositions selection box
		selbox = document.getElementById("assign_"+id)
		document.getElementById("assignto_"+id).className = "hide";

		//set spinning busy image...
		// document.getElementById("dloader"+id).className = "working";

		var site = document.getElementById("whichCompany").value;
		var thisdisposition = document.getElementById("setdisp"+id).value

		//do procedure call
		
		var PostStr = "do=setvalue&context=assignto&apptid="+appointmentid+"&ifc=&q="+encodeURI(selbox.value)+"";

		
		
		doAJAXCall('/include/system/tools/activity/reports/appointments/ajax/', 'POST', '' + PostStr + '', this.setidle);
	},
	hide: function(id) {
		//hide current disposition status
		document.getElementById("span_assignto_"+id).className = "disposition";
		
		//hide dispositions selection box
		selbox = document.getElementById("assign_"+id)
		document.getElementById("assignto_"+id).className = "hide";
	},
	setidle: function(oXML) {

	}
};

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
		var PostStr = 'do=changedisp&id='+id+'&site='+site+'&disposition='+selbox.value;
		doAJAXCall('/include/system/tools/activity/reports/appointments/ajax/', 'POST', '' + PostStr + '', dispositions.setidle);
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
		debugger 
		id = response[0];
		comment = response[1] 
		
		//clear spinning busy image...
		console.log("dloader"+id);
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
			
		document.getElementById("appointment"+id).innerHTML = selbox.options[selbox.selectedIndex].innerHTML;
		// document.getElementById("appointment"+id).innerHTML = selbox.options[selbox.value-2].text;
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
		var PostStr = 'do=changeappt&id='+id+'&site='+site+'&appointment='+selbox.value;
		doAJAXCall('/include/system/tools/activity/reports/appointments/ajax/', 'POST', '' + PostStr + '', appttype.setidle);
	},
	hide: function(id) {
		//hide current disposition status
		document.getElementById("appointment"+id).className = "disposition";
		
		//hide dispositions selection box
		selbox = document.getElementById("setappt"+id)
		document.getElementById("setappointment"+id).className = "hide";
	
	},
	setidle: function(oXML) {
		var response = oXML.response.split("[:]");
		console.log(oXML.response);
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


var user_site;
$(document).ready(function () {
	
	user_site = $("#whichCompany").val();
	// $("#siteid_applicantid").focus();

});

window.onload = Custom.init;

