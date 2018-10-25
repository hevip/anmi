/**
 * Created by Administrator on 2016/8/24 0024.
 */
$(function(){

    /*订单状态导航切换效果*/
    var _index = 0;
    /*$(".orderNav > li").click(function(){
        _index = $(this).index();
        $(this).addClass("click").siblings("li").stop(true).removeClass("click");
        $(".switchPool > .itemBox").eq(_index).addClass("show").siblings(".itemBox").stop(true).removeClass("show");
    });*/

    $(".switchPool > .itemBox > ul.itemUl > li > .btnBox >a.delete").click(function(){
        var $this = $(this);
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
							$this.parents('li').remove();
					}
				}
			});
		}
    });
    $('.ensureGet').click(function(){
		var id = $(this).parents('li').find('input[name="order_id"]').val();
		var $this = $(this);
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
				if ( data['status']  == 1 ) {
					d_messages(data.info);
					$this.parents('li').remove();
				}else{
					d_messages(data.info);
				}
			}
		});
	})
});