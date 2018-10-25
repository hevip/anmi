$( function() {
	$('.delete').click(function(){
		$this = $(this);
		var id = $this.attr('data-id');
		if(confirm("确定要删除数据吗")){
			var $this = $(this);
			var id = $this.attr('data-id');
			$.get(jsObj['root'] + '/MemberCollection/delete',{ id: id, rnd : Math.random() },function(data){
				d_messages( data.msg ,2);
				if(data.status == 1){
					$this.parents('li').remove();
				}
				
			});
	    }else{
	   }		
	});
	$( '#suggest-form' ).submit( function() {
		var nickname = $( 'input[name="nickname"]' );
		if ( nickname.val() == "" ) {
			d_messages('请填写姓名',2);
			nickname.focus();
			return false;
		}
		var tel = $( 'input[name="tel"]' );
		if ( tel.val() == "" ) {
			d_messages('请填写电话',2);
			tel.focus();
			return false;
		}
		var content = $( '#texArea' );
		if ( content.val() == "" ) {
			d_messages('请填写内容',2);
			content.focus();
			return false;
		}
		var action = $("#suggest-form").attr("action");
		$this = $(this);
		if($this.hasClass('ing'))return false;
		$this.addClass('ing');
		$.post(action,$('#suggest-form').serialize(),function(data){
			if(data.status == 1){
				d_messages( '操作成功' ,2);
			}else{
				$this.removeClass('ing');
				d_messages( data.msg ,2);
			}
		});
	})
} );
