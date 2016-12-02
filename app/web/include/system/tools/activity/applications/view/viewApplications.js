document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

function lookup_id() {
		getMessage();
}

var action = {
	inject: function (PostStr){
		grayOut(true);
		// appID=18493&action=inject&company=BUR
		// build up the post string when passing variables to the server side page
		// var PostStr = "variable=value&variable2=value2";
		// use the generic function to make the request
		doAJAXCall('/pdfServer/pdfApplication/createApplication.asp?isservice=true&'+PostStr, 'POST', '' + PostStr + '', action.show);
	},
	show: function (oXML) {
		var PostStr=""
		
		document.getElementById("doneInsertingApp").className = "marLRB10 show"
		// get the response text, into a variable
		var response = oXML.responseText;
		// update the container to show the result from the server
		document.getElementById("whatWasInserted").innerHTML = response;
		
		//extract AppId from response
		AppId = response.slice(response.indexOf("<!-- [AppId:")+12, response.indexOf("] -->"))
	
		doAJAXCall('/include/system/tools/activity/applications/view/viewApplications.asp?isservice=true&appid='+AppId, 'POST', '' + PostStr + '', action.updaterow);
		grayOut(false);
		
	},
	close: function(){
		document.getElementById("whatWasInserted").innerHTML = "";
		document.getElementById("doneInsertingApp").className = "marLRB10 hide";
	},
	updaterow: function(oXML) {
		var response = oXML.responseText;
		
		//extract AppId from response
		AppId = response.slice(response.indexOf("('appID=")+8, response.indexOf("&amp;action"));
		
		// var returnedcells = response.split("td><td")
		// alert(returnedcells.length);
		// for (var i=0; i = returnedcells.length; i++){
			// alert(returnedcells[i]);
		// }
		
		// var table = document.getElementById("applications");
		// var row = getRow(table, "row"+AppId);

		// for (var j = 0, col; col = row.cells[j]; j++) {
			// alert(col.className);
		// }  
	
		// update the table row
		document.getElementById("row"+AppId).innerHTML = response;
	
	}
};


function getRow(table, thisid) {
	for (var i = 0, row; row = table.rows[i]; i++) {
	   if (row.id == thisid) {
		return row
	   }
	}
}