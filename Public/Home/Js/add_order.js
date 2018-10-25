$( function() {
	// 点击提交订单
	$( ".add_order_send" ).click( function() {
		// 收货地址
		var address = $( "input[name='address']" );
		if ( address.val() == 0 || address.val() == '' ) {
			alert( '请选择收货地址!' );
			return false;
		}
		var typeStr = $('.typeStr').val();
		if(typeStr){
			var id = $('.id').val();
			var num = $('.num').val();
		}else{
			var id ='';
			var num = '';
		}
		// 付款方式
		var pay_way = '';
		$('.payWay').each(function(i,v){
			if($(this).find('label').hasClass('checked')){
				pay_way = $(this).find('span').html();
			}
		});
		if ( pay_way == "") {
			d_messages( '请选择付款方式!' );
			$('.payWay').focus();
			return false;
		}
		// 发票类型
		var invoice_type = $( "input[name='invoice_type']" );
		if ( invoice_type.val() == "" ) {
			d_messages( '请选择发票类型!' );
			invoice_type.focus();
			return false;
		}
		// 发票抬头
		var invoice_top = $( "input[name='invoice_top']" );
		var invoice_top_company = $( "input[name='invoice_top_company']" );
		if ( invoice_type.val() != "不要发票" && invoice_top.val() == "" ) {
			d_messages( '请选择发票抬头!' );
			invoice_top.focus();
			return false;
		}
		// 发票内容
		var invoice_intro = $( "input[name='invoice_intro']" );
		if ( invoice_type.val() != "不要发票" && invoice_intro.val() == "" ) {
			d_messages( '请填写发票内容!' );
			invoice_intro.focus();
			return false;
		}
		// 留言内容
		var content = $( "textarea[name='content']" );
		var money = $('input[name="money"]').val();
		var json = {
			address : address.val(),
			pay_way : pay_way,
			invoice_type : invoice_type.val(),
			invoice_top : invoice_top.val(),
			invoice_top_company : invoice_top_company.val(),
			invoice_intro : invoice_intro.val(),
			content : content.val(),
			pro_id:id,
			num:num,
			money:money
		}
		// 判断是否适用钱包支付
		if(money>0){
			$('.popUpBg1').css('display','block');
			$('.passwordCheck').bind('click',function(){
				var password = $('#pswW').val();
				if(password.length != 6){
					d_messages( '密码不合法!' );
					return false;
				}
				var obj = {password:password};
				$.ajax({
					url : jsObj['root'] + "/Member/CheckMoneyPassword/rnd/" + Math.random(),
					data : obj,
					type : 'POST',
					async : false,
					success : function( data ) {
						if ( data == '1' ) {
							sendOrderAjax( json )
						} else {
							d_messages( '密码错误!' );
						}
					}
				});
				
			});
		} else {
			sendOrderAjax( json );
		}	
	} );
	// 提交订单
	function sendOrderAjax( json ) {
		var html = '<div class="popupBg" style="display:block;"></div>';
		html += '<div class="popupImg" style="display:block;">';
		html += '<img src="'+jsObj['images']+'/loading3.gif" />';
		html += '<p style="display:block;">数据交互中...</p>';
		html += '</div>';
	
		$.ajax({
			url : jsObj['root'] + "/Cart/addOrder/rnd/" + Math.random(),
			data : json,
			type : 'POST',
			async : true,
			dataType : 'json',
			beforeSend : function() {
				//$( 'body' ).append( html );
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
	}
} );
