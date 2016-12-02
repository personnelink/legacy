document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

function setDays(form)
{
  year = parseInt(form.year.options[form.year.selectedIndex].value);
  month = form.month.selectedIndex;
  day = form.day.selectedIndex;
  form.day.options.length = 0;
  var days = new Array(31, ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0 ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  for(i = 0; i < days[month]; i++)
  {
    form.day.options.length = form.day.options.length + 1;
    form.day.options[i].value = i + 1;
    form.day.options[i].text = i + 1;
  }
  form.day.selectedIndex = (day < form.day.options.length) ? day : form.day.options.length - 1;
}

function setweekdays() {
	var weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
	var iteration = 0;
	if (document.timecardForm.weekending.options != null) {
		var weekending = document.timecardForm.weekending.options;
		var weekends = new Date(weekending[weekending.selectedIndex].value);
	}
	for (i = 7; i >= 1; i--) {
		weekday = weekends.getDay() - iteration;
		if (weekday < 0) {
			weekday = weekday + 7;
		}
		document.getElementById("name.day" + i + ".row1").innerHTML = weekdays[weekday];
		iteration++;
	}
}

function computeTime() {
	var day = new Array('day1.row1', 'day2.row1', 'day3.row1', 'day4.row1', 'day5.row1', 'day6.row1', 'day7.row1');
	var hourstotal = 0;
	var regulartotal = 0;
	var othertotal = 0;
	
	for(i = 0; i < 7; i++) {
		// Reset Clocks - disabled
		//if (document.getElementById(day[i]+".regular").value > "") {
		//	document.getElementById(day[i]+".in").selectedIndex = 0;
		//	document.getElementById(day[i]+".luout").selectedIndex = 0;
		//	document.getElementById(day[i]+".luin").selectedIndex = 0;
		//	document.getElementById(day[i]+".out").selectedIndex = 0;
		//	}
		var timein = parseFloat(document.getElementById(day[i]+".in").value - 0);
		var timeout = parseFloat(document.getElementById(day[i]+".out").value - 0);
		var lunchout = parseFloat(document.getElementById(day[i]+".luout").value - 0);
		var lunchin = parseFloat(document.getElementById(day[i]+".luin").value - 0);
		
		var total = parseFloat((timeout - timein)-(lunchin-lunchout));
		if (total > 0 ) {
			document.getElementById(day[i]+".total").value = total;
			document.getElementById(day[i]+".regular").value = (total - document.getElementById(day[i]+".other").value);
			
		} else {
			// document.getElementById(day[i]+".total").innerHTML = "&nbsp;";
		}
		hourstotal = hourstotal + total;
		regulartotal = regulartotal + parseFloat(document.getElementById(day[i]+".regular").value - 0);
		othertotal = othertotal + parseFloat(document.getElementById(day[i]+".other").value - 0);
	}
	document.getElementById("hours.total").innerHTML = regulartotal + othertotal;
	document.getElementById("regular.total").innerHTML = regulartotal;
	document.getElementById("other.total").innerHTML = othertotal;
}

function adjustclocks(day) {
	var In = document.getElementById(day + ".in").options;
	var	LuOut = document.getElementById(day + ".luout").options;
	var	LuIn = document.getElementById(day + ".luin").options;
	var	Out = document.getElementById(day + ".out").options;
		
	if (LuOut.selectedIndex < In.selectedIndex) {
		LuOut.selectedIndex = In.selectedIndex;
		Out.selectedIndex = In.selectedIndex;
		}
	if (LuIn.selectedIndex < LuOut.selectedIndex) {
		LuIn.selectedIndex = LuOut.selectedIndex;
		Out.selectedIndex = LuOut.selectedIndex;
		}
		
	if (Out.selectedIndex < LuIn.selectedIndex) {
		Out.selectedIndex = LuIn.selectedIndex;
		}

	if (Out.selectedIndex < In.selectedIndex) {
		Out.selectedIndex = In.selectedIndex;
		}
	document.getElementById(day + ".regular").value = ""
	computeTime();
}	

function addElement() {
  var likethis = document.getElementById('day1.row1').innerHTML;
  modifiedthis=likethis;
  modifiedthis.replace("id=\"row1\"", "id=\"row2\"");
  document.getElementById('day1').innerHTML = likethis + modifiedthis;
}	

function submitTime(){	
	grayOut(true)
	var agree=confirm("PLEASE NOTE: After submitting your time card you will no longer be able to make changes and you agree to be bound by Personnel Plus's Policies and Procedures. Okay to submit time for approval?");
	if (agree)
		{
		document.timecardForm.formAction.value='submit';
		document.timecardForm.submit();
		}
	else {
		grayOut(false)
	}
}

function deleteTime(){	
	grayOut(true)
	var agree=confirm("YOU CANNOT undo this! By selecting 'Ok' the current time card will be permamently deleted from the system. Okay to delete current time card?");
	if (agree)
		{
		document.timecardForm.formAction.value='delete';
		document.timecardForm.submit();
		}
	else {
		grayOut(false)
	}
}

function saveTime (){
	grayOut(true)
	document.timecardForm.formAction.value='save';
	document.timecardForm.submit();
}

function hidetable(id) {
	//safe function to hide an element with a specified id
	document.getElementById('toggle' + id).innerHTML="[more]";
	document.getElementById('toggle' + id).href="JavaScript:showtable(" + id + ");";
	document.getElementById('detail' + id).style.display = 'none';
	document.getElementById('comment' + id).style.display = 'none';
}

function showtable(id) {
	//safe function to show an element with a specified id
	document.getElementById('toggle' + id).innerHTML="[less]";
	document.getElementById('toggle' + id).href="JavaScript:hidetable(" + id + ");";
	document.getElementById('detail' + id).style.display = 'block';
	document.getElementById('comment' + id).style.display = 'block';
}

function changeTime(statusValue, id) {
	if (statusValue=="c") {
		document.getElementById('editDetail' + id).style.display = 'block';
	}
	else {
		document.getElementById('editDetail' + id).style.display = 'none';
	}
}

function getSlowerContent(empCode, isInternal) {
	//setup environment and offload some of the slower http crap for now ;)
	//var agree=confirm("/include/system/tools/timecards/getPlacements.asp?empcode="+empCode+"&status=0&isint="+isInternal);
	var xmlhttp=new XMLHttpRequest()
	if (window.XMLHttpRequest) {
	  placements=new XMLHttpRequest();
	} else { 
	// Internet Explorer 5/6  
	  placements=new ActiveXObject("MSXML2.ServerXMLHTTP");
	}
	placements.open("GET", "https://www.personnelinc.com/include/system/tools/timecardEmp.asp?timecardID=517", false);
	placements.send("");
	blob = placements.responseXML;
	document.getElementById('placementBlob').innerHTML = blob;
}

function initform(empCode, isInternal) {
	setweekdays();
	computeTime();
	getSlowerContent(empCode, isInternal);

}

// timecardSup.asp - ajax calls start
function get_client_orders(custcode, whichcompany) {
	var orders_element = document.getElementById("putOrdersHere");
	if (orders_element != null){
		get_orders(custcode, whichcompany);
	}
	return false;
}

var get_orders = function (custcode, whichcompany) {
	doAJAXCall('/include/system/tools/timecards/getClientOrders.asp?isservice=true&customer='+custcode+'&company='+whichcompany, 'POST', '', show_orders);
}

var show_orders = function (oXML) { 
	var response = oXML.responseText;
	document.getElementById("putOrdersHere").innerHTML = response;
};