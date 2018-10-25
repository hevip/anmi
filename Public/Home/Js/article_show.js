$( function() {
	
	// 点赞
	$( ".goodJob" ).bind('click', function() {	
			var id = $('.theId').val();
			var $this = $(this);
			if($this.hasClass('ing'))return false;
			$this.addClass('ing');
			$.post(jsObj['root']+'/Article/goodjob',{id:id},function(data){
					d_messages(data.info);
					if(data.url){
						window.location.href = data.url;
					}
					$this.removeClass('ing');
			});
	} );
} );
