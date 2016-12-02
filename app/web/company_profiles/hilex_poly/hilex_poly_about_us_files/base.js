$(function(){

	if(typeof console === "undefined") {
		console = { log: function() { } };
	}
	
	var $ = jQuery;
	
	var HILEX	= {
		
		nav: function() {
			$('.node_careers a').attr('target', '_blank');
		},
		
		sidebar: function() {
			$('#sidebarTabs a').click(function(){
				tab = $(this).attr('rel');
				$('#sidebarTabs .active').removeClass('active');
				$(this).addClass('active');
				$('#sidebarContent .active').removeClass('active');
				$('#'+tab).addClass('active');
				return false;
			});
		},
		
		init: function() {
			HILEX.nav();
			HILEX.sidebar();
		},
		
	};
	
	HILEX.init();
	
		
	});

jQuery(document).ready(function(){

	jQuery(".account").click(function(){
		var X=jQuery(this).attr('id');
		if(X==1)
		{
			jQuery(".divisions").hide();
			jQuery(this).attr('id', '0'); 
		}
		else
		{
			jQuery(".divisions").show();
			jQuery(this).attr('id', '1');
		}

	});

	//Mouse click on sub menu
	jQuery(".divisions").mouseup(function(){
		return false
	});

	//Mouse click on my account link
	jQuery(".account").mouseup(function(){
		return false
	});


	//Document Click
	jQuery(document).mouseup(function(){
		jQuery(".divisions").hide();
		jQuery(".account").attr('id', '');
	});
});