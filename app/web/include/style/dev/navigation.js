window.onerror = null;
var bName = navigator.appName;
var bVer = parseInt(navigator.appVersion);
var NS4 = (bName == "Netscape" && bVer >= 4);
var IE4 = (bName == "Microsoft Internet Explorer" && bVer >= 4);
var NS3 = (bName == "Netscape" && bVer < 4);
var IE3 = (bName == "Microsoft Internet Explorer" && bVer < 4);
var menuActive = 0;
var menuOn = 0;
var onLayer;
var timeOn = null;
var currentTab;
var oldTab;

function showLayer(layerName,aa){
	var x = aa;
	var tt =findPosX(x);
	var ww =findPosY(x)+18;
	
	if(aa.id == 'homeTab'){
		aa.id = 'homeTabOver';
	}
	if(aa.id == 'jobSearchTab'){
		aa.id = 'jobSearchTabOver';
	}
	if(aa.id == 'jobSeekersTab'){
		aa.id = 'jobSeekersTabOver';
	}
	if(aa.id == 'careerCentralTab'){
		aa.id = 'careerCentralTabOver';
	}
	if(aa.id == 'aboutUsTab'){
		aa.id = 'aboutUsTabOver';
	}
	if(aa.id == 'advertisingTab'){
		aa.id = 'advertisingTabOver';
	}
	if(aa.id == 'employersTab'){
		aa.id = 'employersTabOver';
	}
	
	if (NS4 || IE4) {
		if (timeOn != null) {
			clearTimeout(timeOn);
			hideLayer(onLayer);
		}
	
		if (IE4) {
			var layers = eval('document.all["'+layerName+'"].style');
			layers.left = tt;
			layers.top = ww;
			eval('document.all["'+layerName+'"].style.visibility="visible"');
		}
		
		if (NS4) {
			if(document.getElementById){
			var elementRef = document.getElementById(layerName);
				if((elementRef.style)&& (elementRef.style.visibility!=null)){
					elementRef.style.visibility = 'visible';
					elementRef.style.left = tt;
					elementRef.style.top = ww;
				}
			}
		}
	}

	onLayer = layerName
}

function hideLayer(layerName){
	if (menuActive == 0){
		if (IE4){
			eval('document.all["'+layerName+'"].style.visibility="hidden"');
			
		}
		if (NS4){
			if(document.getElementById){
				var elementRef = document.getElementById(layerName);
				if((elementRef.style)&& (elementRef.style.visibility!=null)){
				
					elementRef.style.visibility = 'hidden';
				}
			}
		}
	}
}

function btnTimer(tab) {
	ttabOff(tab);
	timeOn = setTimeout("btnOut()",100);
}

function btnOut(layerName){
	if (menuActive == 0){
		hideLayer(onLayer)
		
	}
}

var item;

function tabOver(itemName){
	clearTimeout(timeOn);
	menuActive = 1
}

function tabOut(itemName){
	menuActive = 0
	timeOn = setTimeout("hideLayer(onLayer)", 100)
}

function menuOver(itemName){
	if(itemName.id == 'trOut'){
		itemName.id='trOver';
	}
	else if(itemName.id == 'trOutEmp'){
		itemName.id='trOverEmp';
	}
	
	clearTimeout(timeOn);
	menuActive = 1
}

function menuOut(itemName){
	if(itemName.id == 'trOver'){
		itemName.id='trOut';
	}
	else if(itemName.id == 'trOverEmp'){
		itemName.id='trOutEmp';
	}
	
	menuActive = 0
	timeOn = setTimeout("hideLayer(onLayer)", 100)
}

function ttabOver(tab){
	if (IE4){
		if(tab=='homeTab'){
			eval('document.all["homeTab"].id="homeTabOver"');
		}
		if(tab=='jobSearchTab'){
			eval('document.all["jobSearchTab"].id="jobSearchTabOver"');
		}
		if(tab=='jobSeekersTab'){
			eval('document.all["jobSeekersTab"].id="jobSeekersTabOver"');
		}
		if(tab=='careerCentralTab'){
			eval('document.all["careerCentralTab"].id="careerCentralTabOver"');
		}
		if(tab=='aboutUsTab'){
			eval('document.all["aboutUsTab"].id="aboutUsTabOver"');
		}
		if(tab=='advertisingTab'){
			eval('document.all["advertisingTab"].id="advertisingTabOver"');
		}
		if(tab=='employersTab'){
			eval('document.all["employersTab"].id="employersTabOver"');
		}
		
	}
	if (NS4){
		if(document.getElementById){
			if(tab=='homeTab'){
				var elementRef = document.getElementById('homeTab');
				elementRef.id = 'homeTabOver'
			}
			if(tab=='jobSearchTab'){
				var elementRef = document.getElementById('jobSearchTab');
				elementRef.id = 'jobSearchTabOver'
			}
			if(tab=='jobSeekersTab'){
				var elementRef = document.getElementById('jobSeekersTab');
				elementRef.id = 'jobSeekersTabOver'
			}
			if(tab=='careerCentralTab'){
				var elementRef = document.getElementById('careerCentralTab');
				elementRef.id = 'careerCentralTabOver'
			}
			if(tab=='aboutUsTab'){
				var elementRef = document.getElementById('aboutUsTab');
				elementRef.id = 'aboutUsTabOver'
			}
			if(tab=='advertisingTab'){
				var elementRef = document.getElementById('advertisingTab');
				elementRef.id = 'advertisingTabOver'
			}
			if(tab=='employersTab'){
				var elementRef = document.getElementById('employersTab');
				elementRef.id = 'employersTabOver'
			}
		}
	}
}

function ttabOff(tab){
	if (IE4){
		if(tab=='homeTab'){
			eval('document.all["homeTabOver"].id="homeTab"');
		}
		if(tab=='jobSearchTab'){
			eval('document.all["jobSearchTabOver"].id="jobSearchTab"');
		}
		if(tab=='jobSeekersTab'){
			eval('document.all["jobSeekersTabOver"].id="jobSeekersTab"');
		}
		if(tab=='careerCentralTab'){
			eval('document.all["careerCentralTabOver"].id="careerCentralTab"');
		}
		if(tab=='aboutUsTab'){
			eval('document.all["aboutUsTabOver"].id="aboutUsTab"');
		}
		if(tab=='advertisingTab'){
			eval('document.all["advertisingTabOver"].id="advertisingTab"');
		}
		if(tab=='employersTab'){
			eval('document.all["employersTabOver"].id="employersTab"');
		}
	}
	if (NS4){
		if(document.getElementById){
			if(tab=='homeTab'){
				var elementRef = document.getElementById('homeTabOver');
				elementRef.id = 'homeTab'
			}
			if(tab=='jobSearchTab'){
				var elementRef = document.getElementById('jobSearchTabOver');
				elementRef.id = 'jobSearchTab'
			}
			if(tab=='jobSeekersTab'){
				var elementRef = document.getElementById('jobSeekersTabOver');
				elementRef.id = 'jobSeekersTab'
			}
			if(tab=='careerCentralTab'){
				var elementRef = document.getElementById('careerCentralTabOver');
				elementRef.id = 'careerCentralTab'
			}
			if(tab=='aboutUsTab'){
				var elementRef = document.getElementById('aboutUsTabOver');
				elementRef.id = 'aboutUsTab'
			}
			if(tab=='advertisingTab'){
				var elementRef = document.getElementById('advertisingTabOver');
				elementRef.id = 'advertisingTab'
			}
			if(tab=='employersTab'){
				var elementRef = document.getElementById('employersTabOver');
				elementRef.id = 'employersTab'
			}
		}
	}
}

function findPosX(obj){
	var curleft = 0;
	if (obj.offsetParent){
		while (obj.offsetParent){
			curleft += obj.offsetLeft
			obj = obj.offsetParent;
		}
	}
	else if (obj.x)
		curleft += obj.x;
	return curleft;
}

function findPosY(obj){
	var curtop = 0;
	if (obj.offsetParent){
		while (obj.offsetParent){
			curtop += obj.offsetTop
			obj = obj.offsetParent;
		}
	}
	else if (obj.y)
		curtop += obj.y;
	return curtop;
}

/******* CODE FOR FIXING PNG GRAPHICS *********/
var arVersion = navigator.appVersion.split("MSIE")
var version = parseFloat(arVersion[1])
if ((version >= 5.5)) 
{
   window.attachEvent("onload", correctPNG);
}
function correctPNG() // correctly handle PNG transparency in Win IE 5.5 & 6.
{
   if ((version >= 5.5) && (document.body.filters)) 
   {
      for(var i=0; i<document.images.length; i++)
      {
         var img = document.images[i]
         var imgName = img.src.toUpperCase()
         if (imgName.substring(imgName.length-3, imgName.length) == "PNG")
         {
            var imgID = (img.id) ? "id='" + img.id + "' " : ""
            var imgClass = (img.className) ? "class='" + img.className + "' " : ""
            var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' "
            var imgStyle = "display:inline-block;" + img.style.cssText 
            if (img.align == "left") imgStyle = "float:left;" + imgStyle
            if (img.align == "right") imgStyle = "float:right;" + imgStyle
            if (img.parentElement.href) imgStyle = "cursor:hand;" + imgStyle
            var strNewHTML = "<span " + imgID + imgClass + imgTitle
            + " style=\"" + "width:" + img.width + "px; height:" + img.height + "px;" + imgStyle + ";"
            + "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
            + "(src=\'" + img.src + "\', sizingMethod='image');\"></span>" 
            img.outerHTML = strNewHTML
            i = i-1
         }
      }
   }    
}

