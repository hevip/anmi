$( function() {
	$( '#login-form' ).submit( function() {
		var username = $( this ).find( 'input[name="username"]' );
		var telreg =  /^13[0-9]{9}|17[0-9]{9}|14[0-9]{9}|15[0-9]{9}|18[0-9]{9}$/;
		if ( !telreg.test( username.val() ) ) {
			alert( '用户名必须为手机号码' );
			username.focus();
			return false;
		}
		var password = $( this ).find( 'input[name="password"]' );
		if ( password.val().length < 6 || password.val().length > 20 ) {
			alert( '密码必须为6-20位之间' );
			password.focus();
			return false;
		}
//		var verify = $( this ).find( 'input[name="verify"]' );
//		if ( verify.val().length != 4 ) {
//			alert( '验证码填写有误' );
//			verify.focus();
//			return false;
//		}
	} );
} );
