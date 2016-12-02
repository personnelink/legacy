document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

function catcalc(cal) {
    var date = cal.date;
    var time = date.getTime()
    var field = cal.params.inputField
}

var approval = {
	boot: function (summaryid) {		
		smoke.confirm("Really want to un-approve this time?", function(e){
			if (e){
				grayOut(true);
				var PostStr = "do=unapproveweek&id=" + summaryid;
				// use the generic function to make the request
				doAJAXCall('/include/system/tools/timecards/group/ajax/doThings.asp?', 'POST', '' + PostStr + '', approval.booted);
				return false;
			}
				grayOut(false);
		}, {
			ok: "Yes",
			cancel: "No",
			classname: "custom-class",
			reverseButtons: true
		});
	},
	booted: function(oXML) {
		grayOut(false);
		location.reload(); 
	}
}

