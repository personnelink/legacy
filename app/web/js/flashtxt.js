<script language="JavaScript1.2" type="text/javascript">

/***********************************************
* Flashing Link Script- © Dynamic Drive (www.dynamicdrive.com)
* This notice must stay intact for use
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/

var flashlinks=new Array()

function changelinkcolor(){
for (i=0; i< flashlinks.length; i++){
var flashtype=document.getElementById? flashlinks[i].getAttribute("flashtype")*1 : flashlinks[i].flashtype*1
var flashcolor=document.getElementById? flashlinks[i].getAttribute("flashcolor") : flashlinks[i].flashcolor
if (flashtype==0){
if (flashlinks[i].style.color!=flashcolor)
flashlinks[i].style.color=flashcolor
else
flashlinks[i].style.color=''
}
else if (flashtype==1){
if (flashlinks[i].style.backgroundColor!=flashcolor)
flashlinks[i].style.backgroundColor=flashcolor
else
flashlinks[i].style.backgroundColor=''
}
}
}

function init(){
var i=0
if (document.all){
while (eval("document.all.flashlink"+i)!=null){
flashlinks[i]= eval("document.all.flashlink"+i)
i++
} 
}
else if (document.getElementById){
while (document.getElementById("flashlink"+i)!=null){
flashlinks[i]= document.getElementById("flashlink"+i)
i++
}
}
setInterval("changelinkcolor()", 1000)
}

if (window.addEventListener)
window.addEventListener("load", init, false)
else if (window.attachEvent)
window.attachEvent("onload", init)
else if (document.all)
window.onload=init
</script>