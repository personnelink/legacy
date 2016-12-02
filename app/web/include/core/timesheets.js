<script type="text/JavaScript">
document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

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

function hidediv(id) {
	//safe function to hide an element with a specified id
	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).style.display = 'none';
	}
	else {
		if (document.layers) { // Netscape 4
			document.id.display = 'none';
		}
		else { // IE 4
			document.all.id.style.display = 'none';
		}
	}
}

function showdiv(id) {
	//safe function to show an element with a specified id
		  
	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).style.display = 'inline';
	}
	else {
		if (document.layers) { // Netscape 4
			document.id.display = 'inline';
		}
		else { // IE 4
			document.all.id.style.display = 'inline';
		}
	}
}

function confirmDelete(sheetID)
{
 var where_to= confirm("Do you really want to delete this Timesheet?");
 if (where_to== true)
 {
   window.location="/tools/timemanagement/manageTimesheets.asp?DeleteTimesheet="+sheetID;
 }
}

function checkit(action, formname) {
		document.getElementById('updateStatus').style.display = 'block'
		var act = (action.options[action.selectedIndex].value);

		hidediv(formname);
		if (act == 'change') {
					showdiv(formname);
		}
} 
								function catcalc(cal) {
									var date = cal.date;
									var time = date.getTime()
									// use the _other_ field
									var field = document.getElementById("f_enddate");
									if (field == cal.params.inputField) {
										field = document.getElementById("f_startdate");
										time -= Date.WEEK; // substract one week
									} else {
										time += Date.WEEK; // add one week
									}
									var date2 = new Date(time);
									field.value = date2.print("%m-%d-%Y");
								}
								Calendar.setup({
									inputField : "f_startdate",
									ifFormat : "%m-%d-%Y",
									showsTime : false,
									timeFormat : "24",
									onUpdate : catcalc
								});
								Calendar.setup({
									inputField : "f_enddate",
									ifFormat : "%m-%d-%Y",
									showsTime : false,
									timeFormat : "24",
									onUpdate : catcalc
								});


</script>