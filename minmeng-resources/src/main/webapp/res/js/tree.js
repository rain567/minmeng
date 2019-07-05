	$(function() {

		$('.tree').find('li').each(function(){
			$(this).find('ul').hide();
			var li = $(this);

			if(//!li.find('div:first').find('a.folder').size()>0
					//&& 
					!li.find('div:first').find('a.opened').size()>0
					//&& !li.find('div:first').find('a.folder-closed').size()>0
					&& !li.find('div:first').find('a.closed').size()>0){
				//var typeView = $('<a>&nbsp;</a>');
				//	li.find('div:first').prepend(typeView);
				
				var handler = $('<a>&nbsp;</a>');
					li.find('div:first').prepend(handler);
				handler.addClass('opened');

				var ul = li.find('ul:first');
				if(ul.size()>0){	
					//typeView.removeClass('folder');		
					//typeView.addClass('folder-closed');
					
					handler.removeClass('opened');			
					handler.addClass('closed');
					handler.click(function(){
						if(ul.css("display") == "none"){
							
							//typeView.removeClass('folder-closed');
							//typeView.addClass('folder');	
							
							handler.removeClass('closed');
							handler.addClass('opened');
							ul.slideDown(500);
						}else{
							//typeView.removeClass('folder');			
							//typeView.addClass('folder-closed');
							
							handler.addClass('closed');
							handler.removeClass('opened');
							ul.slideUp(300);
						}
						
					});	
				}//else{	
					//typeView.addClass('file');
				//}
				
			}
			
		});
		if(!($.browser.msie)) { 
			resizeT()
		}
		$(window).resize(function() {
			resizeT()
		}); 
		function resizeT(){
			$('.item').each(function(){
				$(this).width($(document.body).width()- $(this).offset().left - 170);

			});
		}
		 $('li').click(function(){
			resizeT()
		})
		
		
	});
