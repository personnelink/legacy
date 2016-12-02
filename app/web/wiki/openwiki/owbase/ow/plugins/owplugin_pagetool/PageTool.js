<!--
var isInternetExplorer = navigator.appName.indexOf("Microsoft") != -1;
var intval=""
//var ACTIVE = "BUTTON"
var running = false
// PageTool by sEi'2004 ---------------
function oPagetool_DoFSCommand(command, args) {
	var oPagetoolObj = isInternetExplorer ? document.all.oPagetool : document.oPagetool;
	switch (command.toUpperCase()){
		case "ALERT":
			alert(args);
			break;
		case "PAGETOOL":
			PageTool(args);
			break;
		case "POPUP":
			window.open(args, "PageToolWin", "width=500,height=300");
			break;
		default:
			alert("ERROR\n Command:*["+command+"]\nargs:["+args+"]");
	}
}
function PageTool(args){
	switch (args.toUpperCase()){
		case "SHOWHIDE":
			ShowHide()
		break;
		default:
		alert("ERROR\n function PageTool(*["+args+"])");
	}
}

function ShowHide(){
	if (running == false) 
	{
		switch (ACTIVE){
			case "BUTTON":
				var x=document.getElementById("oPagetool")
				if (navigator.appName && navigator.appName.indexOf("Microsoft") != -1 && navigator.userAgent.indexOf("Windows") != -1 && navigator.userAgent.indexOf("Windows 3.1") == -1) {
					// - Use the BUG (IE) for something funny
					//alert(x.width)
					x.width = 13.75
					x.height = 10
					running = true		
					intval=window.setInterval("Grow(4)",1)
				}
				x.style.display = "block"
				var xx=document.getElementById("but_flash")
				xx.style.display = "block"
				var xx=document.getElementById("but_button")
				xx.style.display = "none"
				ACTIVE = "FLASH"
			break;
			case "FLASH":
				//alert("!")
				if (navigator.appName && navigator.appName.indexOf("Microsoft") != -1 && navigator.userAgent.indexOf("Windows") != -1 && navigator.userAgent.indexOf("Windows 3.1") == -1) {
					running = true
					intval=window.setInterval("Grow(-4)",1)
				}else{			
					var xx=document.getElementById("oPagetool")
					xx.style.display = "none"			
				}
				var xx=document.getElementById("but_flash")
				xx.style.display = "none"
				var xx=document.getElementById("but_button")
				xx.style.display = "block"
				ACTIVE = "BUTTON"
			break
			default:
			alert("ERROR\n function ShowHide(*["+args+"])");
		}
	}
}
function Grow(dir){
	//alert("Hi")
	var x=document.getElementById("oPagetool")
	if ((Number(x.height)+(dir*4))>400){
		//alert("klar!")
		running = false
		window.clearInterval(intval)
		x.width = 550
		x.height = 400
	}else{
		if ((Number(x.height)+(dir*4))<10){
			window.clearInterval(intval)		
			var xx=document.getElementById("oPagetool")
			xx.style.display = "none"
			running = false
		}else{
			x.width = Number(x.width)+(dir*5.5)
			x.height =Number(x.height)+(dir*4)
		}		
	}

}
// Hook for the major BUG (Internet Explorer).
if (navigator.appName && navigator.appName.indexOf("Microsoft") != -1 && navigator.userAgent.indexOf("Windows") != -1 && navigator.userAgent.indexOf("Windows 3.1") == -1) {
	document.write('<script language=\"VBScript\"\>\n');
	document.write('On Error Resume Next\n');
	document.write('Sub oPagetool_FSCommand(ByVal command, ByVal args)\n');
	document.write('	Call oPagetool_DoFSCommand(command, args)\n');
	document.write('End Sub\n');
	document.write('</script\>\n');
}
//-->