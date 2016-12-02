//here you place the ids of every element you want.
var ids=new Array('employeePane','employerPane','orientationPane');

function switchid(id){	
	hideallids();
	showdiv(id);
}

function hideallids(){
	//loop through the array and hide each element by id
	for (var i=0;i<ids.length;i++){
		hidediv(ids[i]);
	}		  
}

function setAllweekdays() {
	var weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
	var iteration = 0;
	if (document.form1.weekending.options != null) {
		var weekending = document.form1.weekending.options;
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

function computeAllTime() {
	var totaltimeids = parseInt(document.getElementById("totaltimeids").value - 0);
	for(z = 1; z < totaltimeids; z++) {
		var hourstotal = 0;
		var regulartotal = 0;
		var othertotal = 0;
		for(i = 0; i < 7; i++) {
			var timein = parseFloat(document.getElementById("id"+ z +".day" + (i+1) + ".in").value - 0);
			var timeout = parseFloat(document.getElementById("id"+ z +".day" + (i+1) + ".out").value - 0);
			var lunchout = parseFloat(document.getElementById("id"+ z +".day" + (i+1) + ".luout").value - 0);
			var lunchin = parseFloat(document.getElementById("id"+ z +".day" + (i+1) + ".luin").value - 0);
		
			var total = parseFloat((timeout - timein)-(lunchin-lunchout));
			if (total > 0 ) {

				
				document.getElementById("id" + z + ".day" + (i+1) + ".total").value = total;
				document.getElementById("id" + z + ".day" + (i+1) + ".regular").value = (total - document.getElementById("id" + z + ".day" + (i+1) + ".other").value);
				
			} else {
				// document.getElementById(day[i]+".total").innerHTML = "&nbsp;";
			}
			hourstotal = hourstotal + total;
			regulartotal = regulartotal + parseFloat(document.getElementById("id"+ z +".day" + (i+1) + ".regular").value - 0);
			othertotal = othertotal + parseFloat(document.getElementById("id"+ z +".day" + (i+1) + ".other").value - 0);
		}
	document.getElementById("id" + z + ".hours.total").innerHTML = regulartotal + othertotal;
	document.getElementById("id" + z + ".regular.total").innerHTML = regulartotal;
	document.getElementById("id" + z + ".other.total").innerHTML = othertotal;
	}
}


function updateAllTime(){
	grayOut(true);
	document.form1.formAction.value='save';
	document.form1.submit();
}

function buildClockOptions(id, selected) {
   var selectitems = document.getElementById(id);
   var items = selectitems.getElementsByTagName("option");
	if (items.length < 3) {
		var clockData = new Array();
		var z = 0;
		var i = 0;
		
		for(z = 0; z < 24; z = z + 0.25) {
			var MinuteSlice = (z - parseInt(z)) * 60;
			if (MinuteSlice==0) {
				TimeMinute =  ":00";
			} else {
				TimeMinute = ":" + MinuteSlice;
			}
			
			if (z >= 12) {
				if (z-12 < 1) {
					DisplayTime = "12" + TimeMinute + "pm";
				} else {
					DisplayTime = (parseInt(z)-12) + TimeMinute + "pm";
				}
			} else {
				if (z < 1) {
					DisplayTime = "12" +  TimeMinute + "am";
				} else {
					DisplayTime = parseInt(z) +  TimeMinute + "am";
				}
			}
			//Build Options
			//clockData[i] = "<option value='" + z + "'>"
			var newTimePiece = document.createElement("option");
			newTimePiece.setAttribute("value", z);
			document.getElementById(id).options.add(newTimePiece);
			newTimePiece.text = DisplayTime;
			if (selected == z) {
				newTimePiece.selected = true;
			}		
		}
	}
}

function initapprovalform () {
	setAllweekdays();
	computeAllTime();
	
}

