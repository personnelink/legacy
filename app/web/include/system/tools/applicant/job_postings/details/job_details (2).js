document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

function addmeta() {

}

window.onload = function(){
	title_this(document.getElementById('WebTitle').innerHTML);
	var meta;
	if (document.createElement && (meta = document.createElement('meta'))) {
	// set properties
	var meta_name = document.jobform.elements['itemprop_name'].value;
	var meta_desc = document.jobform.elements['itemprop_desc'].value;
	
	meta.name = meta_name;
	meta.content = meta_desc;
	// now add the meta element to the head
	document.getElementsByTagName('head').item(0).appendChild(meta);
	}

};
