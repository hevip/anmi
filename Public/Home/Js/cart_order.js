$( function() {
	$( '#payment_form' ).submit( function() {
		// 付款方式
		var pay_way = false;
		$( 'input[name="pay_way"]' ).each( function() {
			if ( $( this ).prop( 'checked' ) ) {
				pay_way = true;
			}
		} );
		if ( !pay_way ) {
			alert( '请选择支付方式' );
			return false;
		}
		// 发票类型
		var invoice_type = false;
		$( 'input[name="invoice_type"]' ).each( function() {
			if ( $( this ).prop( 'checked' ) && $( this ).val() == "无" ) {
				invoice_type = false;
			} else {
				invoice_type = true;
			}
		} );
//		if ( !invoice_type ) {
//			alert( '请选择发票类型' );
//			return false;
//		}
		// 发票抬头
		var invoice_top = false;
		$( 'input[name="invoice_top"]' ).each( function() {
			if ( $( this ).prop( 'checked' ) ) {
				if ( $( this ).val() == "单位" && $( 'input[name="invoice_top_company"]' ).val() == "" && invoice_type ) {
				} else {
					invoice_top = true;
				}
			}
		} );
		if ( !invoice_top && invoice_type ) {
			alert( '请选择发票抬头' );
			return false;
		}
		// 发票内容
		var invoice_intro = false;
		if ( $( 'input[name="invoice_intro"]' ).val() == "" && invoice_type ) {
			$( 'input[name="invoice_intro"]' ).focus();
			alert( '请填写发票内容' );
			return false;
		} else {
			invoice_intro = true;
		}
		// 判断是否填写完整
		if ( invoice_type ) {
			if ( pay_way && invoice_top && invoice_intro ) {
				return true;
			} else {
				return false;
			}
		} else {
			return true;
		}
//		if ( pay_way && invoice_type && invoice_top && invoice_intro ) {
//			$( 'input[name="pay_way"]' ).prop( 'disabled', true );
//			$( 'input[name="invoice_top"]' ).prop( 'disabled', true );
//			$( 'input[name="invoice_type"]' ).prop( 'disabled', true );
//			$( 'input[name="invoice_top_company"]' ).prop( 'disabled', true );
//			$( 'input[name="invoice_intro"]' ).prop( 'disabled', true );
//			$( this ).hide();
//			return true;
//		} else {
//			return false;
//		}
	} );
	
	// 取消
//	$( '.cancel_pay' ).click( function() {
//		$( 'input[name="pay_way"]' ).prop( 'disabled', false );
//		$( 'input[name="invoice_top"]' ).prop( 'disabled', false );
//		$( 'input[name="invoice_type"]' ).prop( 'disabled', false );
//		$( 'input[name="invoice_top_company"]' ).prop( 'disabled', false );
//		$( 'input[name="invoice_intro"]' ).prop( 'disabled', false );
//		$( '.save_pay' ).show();
//	} );
	
} );
