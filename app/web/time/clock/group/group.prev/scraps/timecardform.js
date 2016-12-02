document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');


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
	placements.open("GET", "/include/system/tools/timecardEmp.asp?timecardID=517", false);
	placements.send("");
	blob = placements.responseXML;
	document.getElementById('placementBlob').innerHTML = blob;
}

function initform(empCode, isInternal) {
//	setweekdays();
//	computeTime();
//	getSlowerContent(empCode, isInternal);

}


// timecardSup.asp - ajax calls start
function get_client_orders(custcode, whichcompany) {
	grayOut(true);
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
	grayOut(false);
};
