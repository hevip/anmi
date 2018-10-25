$( function() {
	//验证手机正则
	var phoneReg =  /^13[0-9]{9}|17[0-9]{9}|14[0-9]{9}|15[0-9]{9}|18[0-9]{9}$/;
	// 表单验证
	$( '.user-register' ).submit( function() {
		// 电话号码
		var username = $( 'input[name="username"]' );
		if ( username == '' ) {
			d_messages( '您先填写电话号码!' );
			username.focus();
			return false;
		} else if ( !phoneReg.test( username.val() ) ) {
			d_messages( '您输入电话号码有误!' );
			username.focus();
			return false;
		} else {
			var usernameResult = checkPhone( username );
			if ( !usernameResult['status'] ) {
				d_messages( usernameResult['info'] );
				username.focus();
				return false;
			}
		}
		// 图片验证码
//		var verify = $( 'input[name="verify"]' );
//		if ( verify.val().length != 4 ) {
//			alert( '请填写验证码' );
//			verify.focus();
//			return false;
//		} else {
//			var verifyResult = checkVerify( verify );
//			if ( !verifyResult['status'] ) {
//				alert( verifyResult['info'] );
//				verify.focus();
//				return false;
//			}
//		}
		// 短信验证码
		var sms_code = $( 'input[name="smscode"]' );
		if ( sms_code.val().length != 6 ) {
			d_messages( '请填写短信验证码!' );
			sms_code.focus();
			return false;
		} else {
			var sms_flag = false;
			var sms_info = '';
			$.ajax({
				url : jsObj['root'] + '/Verification/checkSMS.html?rnd=' + Math.random(),
				data : {
					code : sms_code.val(),
					phone : username.val(),
				},
				type : 'POST',
				async : false,
				dataType : 'json',
				success : function( data ) {
					if ( data['status'] ) {
						sms_flag = true;
					}
					sms_info = data['info'];
				}
			});
			if ( !sms_flag ) {
				d_messages( sms_info );
				sms_code.focus();
				return false;
			}
		}
	} );
	
	// 图片验证码
//	function checkVerify( verify ) {
//		var newArray = new Array();
//		$.ajax({
//			url : jsObj['root'] + '/Verification/checkVerify.html?rnd=' + Math.random(),
//			data : {
//				code : verify.val()
//			},
//			type : 'POST',
//			async : false,
//			dataType : 'json',
//			success : function( data ) {
//				newArray = data;
//			}
//		});
//		return newArray;
//	}
	
	// 手机号码验证
	function checkPhone( username ) {
		var newArray = new Array();
		$.ajax({
			url : jsObj['root'] + '/Verification/checkPhone.html?rnd=' + Math.random(),
			data : {
				username : username.val(),
			},
			type : 'POST',
			async : false,
			dataType : 'json',
			success : function( data ) {
				newArray = data;
			}
		});
		return newArray;
	}
	
	// 发送短信验证码
	var smscodeObj = $( '.send_smscode' );
	smscodeObj.click( function() {
		var phone = $( 'input[name="username"]' );
		if ( phone.val() == '' ) {
			d_messages( '您先填写电话号码' );
			phone.focus();
            return false;
		}
		if ( !phoneReg.test( phone.val() ) ) {
            d_messages( '您输入电话号码有误' );
			phone.focus();
            return false;
        }
		var usernameResult = checkPhone( phone );
		if ( !usernameResult['status'] ) {
			d_messages( usernameResult['info'] );
			phone.focus();
			return false;	
		} else {
//			var verify = $( 'input[name="verify"]' );
//			var verifyResult = checkVerify( verify );
//			if ( verify.val() == '' ) {
//				alert( '您先填写图形验证码' );
//				verify.focus();
//	            return false;
//			}
//			if ( !verifyResult['status'] ) {
//				alert( verifyResult['info'] );
//				verify.focus();
//				return false;
//			} else {
				$.ajax({
					url : jsObj['root'] + '/Verification/sendSMS.html?rnd=' + Math.random(),
					data : {
						phone : phone.val(),
					},
					type : 'POST',
					async : true,
					dataType : 'json',
					beforeSend : function() {
						$( '.popupBg,.popupImg' ).show();
					},
					success : function( data ) {
						if ( data['status'] ) {
							setTimeout( function() {
								$( '.popupBg,.popupImg' ).fadeOut();
							}, 1000 );
							smscodeObj.prop( 'disabled', true ).val( '60秒后重发' ).addClass( 'noSendSms' );
							var seconds = 60;
							var auto = setInterval( function(){
								seconds --;
								if ( seconds > 0 ) {
									smscodeObj.val( seconds + '秒后重发' );
								} else {
									smscodeObj.prop( 'disabled', false ).val( '重新获取' ).removeClass( 'noSendSms' );
									clearInterval( auto );
								}
							}, 1000 );
						} else {
							$( '.popupBg,.popupImg' ).hide();
							d_messages( data['info'] );
						}
					}
				});
//			}
		}
	} );
} );
