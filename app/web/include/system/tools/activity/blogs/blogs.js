document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');


var change = {
	hide: function(id) {
		var PostStr = ''
		//set spinning busy image...
		document.getElementById("Status"+id).className = "Working";
		//do procedure call
		doAJAXCall('ajax/doThings.asp?do=hide&id='+id, 'POST', '' + PostStr + '', change.done);
	},
	show: function(id) {
		var PostStr = ''
		//set spinning busy image...
		document.getElementById("Status"+id).className = "Working";
		//do procedure call
		doAJAXCall('ajax/doThings.asp?do=show&id='+id, 'POST', '' + PostStr + '', change.done);
	},
	done: function(oXML) {
		// get the response text, into a variable
		var response = oXML.responseText;
		//set idle busy image...
		document.getElementById("Status"+response).className = "Idle";
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


