if (!window.console) console = {log: function() {}};


function addEventHandler(obj, evt, handler) {
    if(obj.addEventListener) {
        // W3C method
        obj.addEventListener(evt, handler, false);
    } else if(obj.attachEvent) {
        // IE method.
        obj.attachEvent('on'+evt, handler);
    } else {
        // Old school method.
        obj['on'+evt] = handler;
    }
}



function grayOut(vis, options) {
	scroll(0,0);
  // Pass true to gray out screen, false to ungray
  // options are optional.  This is a JSON object with the following (optional) properties
  // opacity:0-100         // Lower number = less grayout higher = more of a blackout 
  // zindex: #             // HTML elements with a higher zindex appear on top of the gray out
  // bgcolor: (#xxxxxx)    // Standard RGB Hex color code
  // grayOut(true, {'zindex':'50', 'bgcolor':'#0000FF', 'opacity':'70'});
  // Because options is JSON opacity/zindex/bgcolor are all optional and can appear
  // in any order.  Pass only the properties you need to set.
  var options = options || {}; 
  var zindex = options.zindex || 650;
  var opacity = options.opacity || 70;
  var opaque = (opacity / 100);
  var bgcolor = options.bgcolor || '#000000';
  var dark=document.getElementById('darkenScreenObject');
  if (!dark) {
    // The dark layer doesn't exist, it's never been created.  So we'll
    // create it here and apply some basic styles.
    // if you are getting errors in IE see: http://support.microsoft.com/default.aspx/kb/927917
    var tbody = document.getElementsByTagName("body")[0];
    var tnode = document.createElement('div');           // Create the layer.
        tnode.style.position='fixed';                    // Position fixed
        tnode.style.top='0px';                           // In the top
        tnode.style.left='0px';                          // Left corner of the page
        tnode.style.overflow='hidden';                   // Try to avoid making scroll bars            
        tnode.style.display='none';                      // Start out Hidden
        // tnode.style.backgroundImage="url('/include/images/ajax-loader.gif')";                      // Loader Image
		tnode.id='darkenScreenObject';                   // Name it so we can find it later
   tbody.appendChild(tnode);                            // Add it to the web page


    dark=document.getElementById('darkenScreenObject');  // Get the object.
	}
  if (vis) {
	// Calculate the page width and height 
    if( document.body && ( document.body.scrollWidth || document.body.scrollHeight ) ) {
        var pageWidth = document.body.scrollWidth+'px';
        var pageHeight = document.body.scrollHeight+'px';
    } else if( document.body.offsetWidth ) {
      var pageWidth = document.body.offsetWidth+'px';
      var pageHeight = document.body.offsetHeight+'px';
    } else {
       var pageWidth='100%';
       var pageHeight='100%';
    }   
    //set the shader to cover the entire page and make it visible.
    dark.style.opacity=opaque;                      
    dark.style.MozOpacity=opaque;                   
    dark.style.filter='alpha(opacity='+opacity+')'; 
    dark.style.zIndex=zindex;        
    dark.style.backgroundColor=bgcolor; 
	dark.style.width= pageWidth;
	dark.style.height= pageHeight;
	
	var theWidth, theHeight;
	// Window dimensions:
	if (window.innerWidth) {
	theWidth=(window.innerWidth / 2) - 33;
	}
	else if (document.documentElement && document.documentElement.clientWidth) {
	theWidth=(document.documentElement.clientWidth / 2) - 33;
	}
	else if (document.body) {
	theWidth=(document.body.clientWidth / 2) - 33;
	}
	
	if (window.innerHeight) {
	theHeight=(window.innerHeight / 2) - 33;
	}
	else if (document.documentElement && document.documentElement.clientHeight) {
	theHeight=(document.documentElement.clientHeight / 2) - 33;
	}
	else if (document.body) {
	theHeight=(document.body.clientHeight / 2) - 33;
	}
	
    dark.style.backgroundPosition= theWidth + "px " + theHeight + "px"; // Center Image
    dark.style.backgroundRepeat="no-repeat";      // No Repeat Image

    dark.style.display='block';
	dark.innerHTML = "<div id='hangon'>Hang on...</div>";
	//dark.style.backgroundImage='/include/images/ajax-loader.gif'; 

	setTimeout("grayOutStatus()", 500);
  } else {
     dark.style.display='none';
  }
}

function grayOutStatus() {
	console.log("window.status: " +window.status);
}

// var urlParams = {};
// (function () {
    // var match,
        // pl     = /\+/g,  // Regex for replacing addition symbol with a space
        // search = /([^&=]+)=?([^&]*)/g,
		// console.log(s);
        // decode = function (s) { return decodeURIComponent(s.replace(pl, " ")); },
        // query  = window.location.search.substring(1);

    // while (match = search.exec(query))
       // urlParams[decode(match[1])] = decode(match[2]);
// })();

function XHConn() {
  var xmlhttp, bComplete = false;
  try { xmlhttp = new ActiveXObject("Msxml2.XMLHTTP"); }
  catch (e) { try { xmlhttp = new ActiveXObject("MSXML2.ServerXMLHTTP"); }
  catch (e) { try { xmlhttp = new XMLHttpRequest(); }
  catch (e) { xmlhttp = false; }}}
  if (!xmlhttp) return null;
  this.connect = function(sURL, sMethod, sVars, fnDone)
  {
    if (!xmlhttp) return false;
    bComplete = false;
    sMethod = sMethod.toUpperCase();
    try {
      if (sMethod == "GET")
      {
        xmlhttp.open(sMethod, sURL+"?"+sVars, true);
        sVars = "";
      }
      else
      {
        xmlhttp.open(sMethod, sURL, true);
        xmlhttp.setRequestHeader("Method", "POST "+sURL+" HTTP/1.1");
        xmlhttp.setRequestHeader("Content-Type",
          "application/x-www-form-urlencoded");
      }
      xmlhttp.onreadystatechange = function(){
        if (xmlhttp.readyState == 4 && !bComplete)
        {
          bComplete = true;
		  var notsignedintxt = "secure service init failed because session is not signed in";
		  if (xmlhttp.responseText.indexOf(notsignedintxt) != -1) {location.reload();}
        
		fnDone(xmlhttp);
        }};
      xmlhttp.send(sVars);
    }
    catch(z) { return false; }
    return true;
  };
  return this;
}

var doAJAXCall = function (PageURL, ReqType, PostStr, FunctionName) {

	// create the new object for doing the XMLHTTP Request
	var myConn = new XHConn();

	// check if the browser supports it
	if (myConn)	{
	    
	    // XMLHTTPRequest is supported by the browser, continue with the request
	    myConn.connect('' + PageURL + '', '' + ReqType + '', '' + PostStr + '', FunctionName);    
	} 
	else {
	    // Not support by this browser, alert the user
	    alert("XMLHTTP not available. A newer browser is needed for this application to work.");   
	}
}

function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

var g_foruser;
var g_site;
var alarm = {
	check: function (site, foruser) {
		g_foruser = foruser;
		g_site = g_site;
		doAJAXCall('/include/js/ajax/alarmedlast.service.asp?site='+g_site+'&for='+g_foruser, 'GET', '', alarm.okTo);
},
	okTo: function (oXML) {
		//check if okay to alarm
		var okaytoalarm = oXML.responseText;
		
		if (okaytoalarm == 'True') {
			var PostStr = "foruser=" + g_foruser + "&site=" + g_site;

			doAJAXCall('/include/system/tools/alarm/?', 'GET', '' + PostStr + '', alarm.show);

			return false;
		}
	},
	show: function (oXML) {
		// get the response text, into a variable
		
		var response = oXML.responseText;
		console.log(response);
		
		var notifications = response.split("]|[");
		for (var i = 0; i < (notifications.length); i++) {
			if (notifications[0].length > 0) {
				console.log("l: " +notifications.length);
				title = 'Reminder notification!';
				comment = notifications[i];
				icon = 'https://www.personnelinc.com/include/system/tools/activity/reports/activity/?act_when=future&amp;activity_5=1';

				console.log(title, comment, icon);
				notify(title, comment, icon);
			}
		}
	}
}

var check_appointments = function() {
	alarm.check('', '');
}

var alarm_check_frequency = 900000; // 900000 = 15 minutes

setInterval('check_appointments()', alarm_check_frequency);

function notify(title, message, lnkBack) {
	var imgIcon = 'https://www.personnelinc.com/include/images/remind.png'
	var havePermission = window.webkitNotifications.checkPermission();
	var lnkBackww = "https://www.personnelinc.com/include/system/tools/activity/reports/appointments/?onlyactive=1"
		if (title.length > 0) {
			if (havePermission == 0) {
			console.log("* sending notification");
			// 0 is PERMISSION_ALLOWED
			

			var notification = window.webkitNotifications.createNotification(
			  imgIcon,
			  title,
			  message		  
			);

			notification.onclick = function () {
			  if (lnkBackww.length > 0) {
				window.open(lnkBackww);
				notification.close();
				}
		}
		notification.show();
		} else {
			console.log("* not permitted to send notification, requesting permission...");

			window.webkitNotifications.requestPermission();
		}
	}
} 

function title_this(use_this) {
	document.title = use_this;
}

function submitenter(thisfield,e){
	var keycode;
	if (window.event) keycode = window.event.keyCode;
	else if (e) keycode = e.which;
	else return true;
	
	if (keycode == 13)
	   {
	   grayOut(true);
	   thisfield.form.submit();
	   return false;
	   }
	else
	   return true;
}

var areamap = {
	load: function()  {
		var PostStr = "";

		doAJAXCall('area_map/map.htm', 'GET', '' + PostStr + '', areamap.show);		
	},
	show: function(oXML){
		smoke.alert("Select an area from map:\n"+oXML.responseText, function(e){
				// if (e == "Cancel"){
					
					// var PostStr = "do=hidecustomer&id=" + customercode + "&site=" + sitedb;
					// console.log(PostStr);


					// document.getElementById(customercode+".row").remove();
					// return true;
				// } else if (e == "No") {
					// return false;
				// }
			}, {
				ok: "Cancel",
				cancel: "Nope",
				classname: "custom-class"
			});
	
	}
}

var applicant = {
	open_new: function(elem) {
			var uri = elem.getAttribute("data-uri").value;
			console.log("uri:"+uri);
			
		}
		
	}


grayOut(false);

// if (typeof jQuery != 'undefined') {
 
    // alert("jQuery library is loaded!");
 
// }else{
 
    // alert("jQuery library is not found!");
 
// }
