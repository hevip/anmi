<extend name="Base/common1" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/bind_phone.css">
<style type="text/css">
	.yzm_img
	{height:3rem; width:6rem; margin-left:1.2rem;}
	.popupBg
	{width:100%; height:100%; display:none; position:fixed; top:0px; left:0px; background:#ffffff; opacity:0.8;}
	.popupImg
	{width:100px; height:40px; display:none; position:fixed; top:50%; left:50%; margin-top:-20px; margin-left:-50px;}
	.popupImg p
	{line-height:30px; color:#f00; font-size:12px; text-align:center; display:none;}
</style>
</block>

<block name="jscript">
<script type="text/javascript" src="__JS__/jquery.min.js"></script>
<script type="text/javascript" src="__JS__/communal.js"></script>
<script type="text/javascript">
var jsObj = {
	'root' : '__ROOT__/',
	'images' : '__IMAGES__',
	'login_url' : '{:U('Login/login')}',
	'is_login' : '<if condition="session('member_auth')">1<else />0</if>',
};
$( function() {
	//验证手机正则
	var phoneReg = /^13[0-9]{9}|17[0-9]{9}|14[0-9]{9}|15[0-9]{9}|18[0-9]{9}$/;
	// 表单验证
	$( '.user-register' ).submit( function() {
		// 电话号码
		var username = $( 'input[name="phone"]' );
		if ( !phoneReg.test( username.val() ) ) {
			alert( '电话号码格式填写有误!' );
			username.focus();
			return false;
		} else {
			var usernameResult = checkPhone( username );
			if ( !usernameResult['status'] ) {
				alert( usernameResult['info'] );
				username.focus();
				return false;
			}
		}
		// 图片验证码
		var verify = $( 'input[name="verify"]' );
		if ( verify.val().length != 4 ) {
			alert( '请填写验证码' );
			verify.focus();
			return false;
		} else {
			var verifyResult = checkVerify( verify );
			if ( !verifyResult['status'] ) {
				alert( verifyResult['info'] );
				verify.focus();
				return false;
			}
		}
		// 短信验证码
		var sms_code = $( 'input[name="smscode"]' );
		if ( sms_code.val().length != 6 ) {
			alert( '请填写短信验证码!' );
			sms_code.focus();
			return false;
		} else {
			var sms_flag = false;
			var sms_info = '';
			$.ajax({
				url : jsObj['root'] + 'Verification/checkSMS.html?rnd=' + Math.random(),
				data : {
					code : sms_code.val(),
					phone: $('input[name="phone"]').val()
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
				alert( sms_info );
				sms_code.focus();
				return false;
			}
		}
	} );
	
	// 图片验证码
	function checkVerify( verify ) {
		var newArray = new Array();
		$.ajax({
			url : jsObj['root'] + 'Verification/checkVerify.html?rnd=' + Math.random(),
			data : {
				code : verify.val()
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
	
	// 手机号码验证
	function checkPhone( username ) {
		var newArray = new Array();
		$.ajax({
			url : jsObj['root'] + 'Verification/checkPhone.html?rnd=' + Math.random(),
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
		var phone = $( 'input[name="phone"]' );
		if ( phone.val() == '' ) {
			alert( '您先填写电话号码' );
			phone.focus();
            return false;
		}
		if ( !phoneReg.test( phone.val() ) ) {
            alert( '您输入电话号码有误' );
			phone.focus();
            return false;
        }
		var usernameResult = checkPhone( phone );
		if ( !usernameResult['status'] ) {
			alert( usernameResult['info'] );
			phone.focus();
			return false;	
		} else {
			var verify = $( 'input[name="verify"]' );
			var verifyResult = checkVerify( verify );
			if ( verify.val() == '' ) {
				alert( '您先填写图形验证码' );
				verify.focus();
	            return false;
			}
			if ( !verifyResult['status'] ) {
				alert( verifyResult['info'] );
				verify.focus();
				return false;
			} else {
				$.ajax({
					url : jsObj['root'] + 'Verification/sendSMS.html?rnd=' + Math.random(),
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
							alert( data['info'] );
						}
					}
				});
			}
		}
	} );
	
} );
</script>

</block>
<block name="main">

<body class="">
	
    <header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>绑定手机号</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>
	
	<!-- 内容 -->
	<div class="main" style="background:#fff;">
		<div class="user-center user-login">
			<form id="#mainForm1" class="user-register" action="{:U('Member/phone_bind')}" method="post">
			
				<div class="text-all dis-box j-text-all">
					<div class="box-flex input-text">
						<input type="tel" class="phone j-input-text" name="phone" maxlength="11" placeholder="请输入绑定手机号">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
				</div>
				
				<div class="text-all dis-box j-text-all">
					<div class="box-flex input-text">
						<input type="number" class="yzm" maxlength="4" name="verify" placeholder="请输入图形验证码">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
					<img src="{:U('Member/verify')}" class="yzm_img" onclick="this.src='{:U("Member/verify")}?rnd='+Math.random();" />
				</div>
				
				<div class="text-all dis-box j-text-all">
					<div class="box-flex input-text">
						<input type="number" class="c_code_msg" maxlength="6" name="smscode" placeholder="请输入短信验证码">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
					<input type="button" value="获取验证码" class="msgs send_smscode ipt-check-btn" />
				</div>

				<input type="submit" value="确定" class="btn-submit" />
				
			</form>
		</div>
	</div>

	<div class="popupBg"></div>
	<div class="popupImg">
		<img src="__IMAGES__/loading3.gif" />
		<p>短信发送中...</p>
	</div>
</block>