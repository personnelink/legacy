document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');


function querystring(key) {
   var re=new RegExp('(?:\\?|&)'+key+'=(.*?)(?=&|$)','gi');
   var r=[], m;
   while ((m=re.exec(document.location.search)) != null) r.push(m[1]);
   return r;
}


$(document).ready(function () {

	$('#display_html').bind('change', function(){
		var params = [
			"blogid="+querystring("blogid"),
			"id="+querystring("id"),
			"site="+querystring("site"),
			"formatting=html"
		];

		window.location.href = "https://" + window.location.host + window.location.pathname + '?' + params.join('&');
	});

	$('#display_text').bind('change', function(){
		var params = [
			"blogid="+querystring("blogid"),
			"id="+querystring("id"),
			"site="+querystring("site"),
			"formatting=text"
		];

		window.location.href = "https://" + window.location.host + window.location.pathname + '?' + params.join('&');
	});


	if (querystring("formatting")!='html') {
		tinymce.init({selector:'textarea'});
	}
});


