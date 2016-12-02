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

var lookup_delay
var global_srch
var company = {
	lookup: function(obj) {
		clearTimeout(lookup_delay);
		global_srch = obj;
		lookup_delay = setTimeout("company.dolookup()",750);
		return false;
	},
	dolookup: function() {
		var PostStr = "do=lookupcustomer&search="+global_srch.value+"&site=0";
		console.log(PostStr);

		doAJAXCall('ajax/?', 'POST', '' + PostStr + '', this.suggest);
		return false;
	},
	suggest: function(oXML){
		var results = document.getElementById("CompanyLookUp");
		results.style.display='block';
		results.innerHTML = oXML.response;
	},
	clear: function(obj) {
		var results = document.getElementById("CompanyLookUp");
		results.innerHTML="";
		results.style.display='none';
	}
}



function lookup_id() {
		clearTimeout(swipe_timer);
		console.log('lookup_id');
		swipe_timer = setTimeout("user_info.lookup()",500);
}

$(document).ready(function() {
    $("#ordertabs").bind('paste', function(event) {
        var _this = this;
        // Short pause to wait for paste to complete
        setTimeout("lookup_id()", 100);
    });
});

function check_swipe(event) {
	console.log(event.keyCode);
	if (event.keyCode == 191) {
		lookup_id();
	}
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

var tabs = {
	show: function(oXML) {
		$("div#jobtabs").html(oXML.response);
	}
}

var job = {
	load: function(site, jobref, dept) {
		$("#tab_"+jobref+"_"+dept).css("background","url('tabs.png') no-repeat bottom right");  

		var PostStr = "do=getjoborder&jobref="+jobref+"&dept="+dept+"&site="+site;
		console.log(PostStr);

		doAJAXCall('ajax/?', 'POST', '' + PostStr + '', this.show);
		
		job.loadplacements(site, jobref, dept);
		
		return false;
	
	},
	show: function(oXML){
		console.log('ready for show');
	
		var joborder ={}; // new job order object		
		var orderdata = function(info){
		
			var vars = info.split('&');
			for (var i = 0; i < vars.length; i++) {
			var pair = vars[i].split('=');
			var jobkey = decodeURIComponent(pair[0])
			var jobdata = decodeURIComponent(pair[1])
			joborder[jobkey] = jobdata;
			if($("#"+jobkey).length != 0) {
				// find out what it is
				
				if ($("#"+jobkey).is("input")) {
					$("#"+jobkey).val(joborder[jobkey]); //true or false			
				} else if ($("#"+jobkey).is("textarea")) {
					$("#"+jobkey).html(joborder[jobkey]); //true or false			
				} else if ($("#"+jobkey).is("select")) {
					$("#"+jobkey).val(joborder[jobkey]); //true or false			
				} if ($("#"+jobkey).is("span")) {
					$("#"+jobkey).html(joborder[jobkey]); //true or false			
				}
			} else {
			  //it doesn't exist
				console.log("doesn't exist: "+jobkey);
		  }

			}
		}
		orderdata(oXML.response);
	},
	update: function(site, jobref, dept, obj) {

	var PostStr = "do=saveorderinfo&jobref="+jobref+"&dept="+dept+"&site="+site;
		console.log(PostStr);

		doAJAXCall('ajax/?', 'POST', '' + PostStr + '', this.show);
		return false;
	},
	loadplacements: function(site, jobref, dept) {


		var PostStr = "whichCompany="+site+"&dept="+dept+"&jobref="+jobref+"&app=joborder";
		doAJAXCall('/include/system/tools/activity/reports/appointments/?isservice=true', 'POST', '' + PostStr + '', this.showplacements);

	},
	showplacements: function(oXML) {
		$("div#orderactivities").html(oXML.response);
	}
}





// window.onload = Custom.init;

$(document).ready(function () {
	
	$("#searchbox").focus();
	
	var PostStr = "do=getordertabs&site=0";
	console.log(PostStr);

	doAJAXCall('ajax/?', 'POST', '' + PostStr + '', tabs.show);

});
