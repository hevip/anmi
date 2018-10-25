$( function() {
	// 点击提交订单
	$( ".add_order_send" ).click( function() {
		// 收货地址
		var address = $( "input[name='address']" );
		if ( address.val() == 0 || address.val() == '' ) {
			alert( '请选择收货地址!' );
			return false;
		}
		// 付款方式
		var pay_way = $( "input[name='pay_way']" );
		if ( pay_way.val() == "" || ( pay_way.val() != "现金/刷卡" &&  pay_way.val() != "网上支付" ) ) {
			alert( '请选择付款方式!' );
			pay_way.focus();
			return false;
		}
		// 发票类型
		var invoice_type = $( "input[name='invoice_type']" );
		if ( invoice_type.val() == "" ) {
			alert( '请选择发票类型!' );
			invoice_type.focus();
			return false;
		}
		// 发票抬头
		var invoice_top = $( "input[name='invoice_top']" );
		var invoice_top_company = $( "input[name='invoice_top_company']" );
		if ( invoice_type.val() != "不要发票" && invoice_top.val() == "" ) {
			alert( '请选择发票抬头!' );
			invoice_top.focus();
			return false;
		}
		// 发票内容
		var invoice_intro = $( "input[name='invoice_intro']" );
		if ( invoice_type.val() != "不要发票" && invoice_intro.val() == "" ) {
			alert( '请填写发票内容!' );
			invoice_intro.focus();
			return false;
		}
		// 留言内容
		var content = $( "textarea[name='content']" );
		var price = $( "input[name='price']" );
		
		var json = {
			price : price.val(),
			address : address.val(),
			pay_way : pay_way.val(),
			invoice_type : invoice_type.val(),
			invoice_top : invoice_top.val(),
			invoice_top_company : invoice_top_company.val(),
			invoice_intro : invoice_intro.val(),
			content : content.val()
		}
		
		var html = '<div class="popupBg" style="display:block;"></div>';
			html += '<div class="popupImg" style="display:block;">';
			html += '<img src="'+jsObj['images']+'/loading3.gif" />';
			html += '<p style="display:block;">数据交互中...</p>';
			html += '</div>';
		
		$.ajax({
			url : jsObj['root'] + "/FacePay/addOrder/rnd/" + Math.random(),
			data : json,
			type : 'POST',
			async : true,
			dataType : 'json',
			beforeSend : function() {
				$( 'body' ).append( html );
			},
			success : function( data ) {
				if ( data['status'] ) {
					location.href = data['url'];
				} else {
					$( '.popupBg,.popupImg' ).fadeOut();
					setTimeout( function(){ 
						$( '.popupBg,.popupImg' ).remove()
						alert( data['info'] );
					}, 500 );
				}
			}
		});
		
	} );
} );
