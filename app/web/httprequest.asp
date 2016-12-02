<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>HTTP Request, Javascript</title>
</head>
<script type="text/javascript">

function getHttpObject() {
	var xhttp=new XMLHttpRequest();
	if (window.XMLHttpRequest){
		xhttp=new XMLHttpRequest();
	} else {
		xhttp=new ActiveXObject("MSXML2.ServerXMLHTTP");
	}
	xhttp.open("GET","httpresponse.asp",false);
	xhttp.send("");
	xmlDoc=xhttp.responseXML; 

	//document.getElementById("to").innerHTML=xmlDoc
	document.getElementById("to").innerHTML=xmlDoc.getElementsByTagName("to")[0].childNodes[0].nodeValue;
	document.getElementById("from").innerHTML=xmlDoc.getElementsByTagName("from")[0].childNodes[0].nodeValue;
	document.getElementById("message").innerHTML=xmlDoc.getElementsByTagName("message")[0].childNodes[0].nodeValue;
}
</script>

<body onload="getHttpObject()">
<table>
<tr><td id="to"></td><td id="from"></td></tr>
<tr><td id="message"></td><td id="body"></td></tr></table>
</body>
</html>
