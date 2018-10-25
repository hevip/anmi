$(function () {
    /*好评、中评、差评*/
    $(".estimate > dl > dd.estimateChoose > ul >li").click(function(){
    	if ( $( this ).hasClass( 'click' ) ) {
    		return;
    	}
        $(this).addClass("click").siblings("li").stop(true).removeClass("click");
        var order_id = $( this ).attr( 'data-id' );
        $( '.main input[name="type"]' ).val( order_id );
    });
    
    // 评价表单提交
    $( 'form.main' ).on( 'submit', function() {
    	// 订单ID
    	var order_id = $( this ).find( 'input[name="order_id"]' );
    	if ( !order_id.val() || isNaN( order_id.val() ) ) {
    		d_messages( '订单id有误!' );
    		return false;
    	}
    	// 商品ID
    	var pro_id = $( this ).find( 'input[name="pro_id"]' );
    	if ( !pro_id.val() || isNaN( pro_id.val() ) ) {
    		d_messages( '商品id有误!' );
    		return false;
    	}
    	// 总体评价
    	var type = $( this ).find( 'input[name="type"]' );
    	if ( !type.val() || isNaN( type.val() ) || type.val() > 3 || type.val() < 1 ) {
    		d_messages( '亲，请给一个感受度!' );
    		return false;
    	}
    	// 评价内容
    	var content = $( this ).find( 'textarea[name="content"]' );
    	if ( content.val().length < 15 || content.val().length > 200 ) {
    		d_messages( '亲，评论内容只能填写15-200个字哦!' );
    		return false;
    	}
    	var json = $( this ).serialize();
    	$.post(
    		jsObj['root'] + '/CommodityComment/add',
    		json,
    		function( data ) {
    			if ( data['status'] ) {
    				location.href = jsObj['root'] + '/Order/comments';
    			}
    			d_messages( data['info'] );
    		}
    	);
    	return false;
    } );
    
});
// Uploads/comments/2016-10-14/5800ac633395a.png|Uploads/comments/2016-10-14/5800ac6544758.png
// 东西不错，和网上描述一致！物流超快，360个赞
/*'<div id="' + file.id + '" class="getData">' +
'	<i class="iconfont">&#xe669;</i>' +
'	<div class="pic"><img></div>' +
'	<div class="info">' + file.name + '</div>' +
'</div>'*/