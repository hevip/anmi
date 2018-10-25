jQuery(document).ready(function($){
	//open the lateral panel
	/*$('.cd-btn').on('click', function(event){
		event.preventDefault();
		$('.cd-panel').addClass('is-visible');
	});
	//clode the lateral panel
	$('.cd-panel').on('click', function(event){
		if( $(event.target).is('.cd-panel') || $(event.target).is('.cd-panel-close') ) { 
			$('.cd-panel').removeClass('is-visible');
			event.preventDefault();
		}
	});*/
	/**
	 * 删除订单
	 */
	/*$('.removeOrder').bind('click',function(){
		$this = $(this);
		var id = $this.attr('rel');
		$.post('/Order/remove',{id:id},function(data){
			if(data.status == 1){
				$this.parent().parent().parent().remove();
			}else{
				alert(data.info);
			}
		});
	});*/
	
	// --------------------------以上代码为未知的代码，暂无其他的任何作用，先屏蔽------------------------------------
	
	// 删除订单
	var orderObj = $( '.removeOrder' );
	var listObj = $( '.orderlist' );
	orderObj.click( function() {
		var index = orderObj.index( this );
		var id = $( this ).attr( 'rel' );
		if ( id <= 0 ) {
			return false;
		}
		if ( confirm( '您确定要删除此订单吗？删除之后再也无法恢复，请谨慎操作' ) ) {
			$.ajax({
				url : jsObj['root'] + '/Order/remove/rnd/' + Math.random(),
				data : {
					id : id,
				},
				type : 'POST',
				async : false,
				dataType : 'json',
				beforeSend : function() {
					
				},
				success : function( data ) {
					if ( data['status'] ) {
						listObj.eq( index ).slideUp( 'slow', function() {
							listObj.eq( index ).remove();
						} );
					}
				}
			});
		}
	} );
	
	// 确认收货
	var goodObj = $( '.ordergood' );
	var ls_co_ul = $( '.ls_co_ul' );
	goodObj.click( function() {
		var index = goodObj.index( this );
		var id = $( this ).attr( 'rel' );
		if ( id <= 0 ) {
			return false;
		}
		if ( confirm( '您确定已经收到货了吗？请谨慎操作' ) ) {
			$.ajax({
				url : jsObj['root'] + '/Order/good/rnd/' + Math.random(),
				data : {
					id : id,
				},
				type : 'POST',
				async : false,
				dataType : 'json',
				beforeSend : function() {
					
				},
				success : function( data ) {
					if ( data['status'] ) {
						location.href = location.href;
					}
				}
			});
		}
	} );
	
});