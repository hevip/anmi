<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/jquery.scrollUp.min.js "></script>
</block>

<block name="main">

<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>找回密码</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>
    
    <!-- 主题内容 -->
	<div class="main" style="background:#fff;" id="pjax-container">
	
		<!-- 输入手机号 -->
		<div id="show">
			<section class="user-center user-login j-f-tel">
				<div class="text-all dis-box j-text-all" name="write_mobilediv">
					<label>+86</label>
					<div class="box-flex input-text">
						<input class="j-input-text" name="username" type="tel" placeholder="请输入注册手机号">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
				</div>
				
				<p class="fl t-remark">为了您的安全，我们会向你手机发送验证码</p>
				<input type="hidden" name="enabled_sms" value="1">
				<button id="next" class="btn-submit">下一步</button>
			</section>
		</div>
		
		<!-- 输入验证码 -->
		<div id="check" style="display:none">
			<form action="" method="post" class="phone_bind_form" onsubmit="return false;">
				<section class="user-center user-forget-tel user-login">
					<p class="fl t-remark2">您的手机号：+86 <span id="show_mobile">111</span></p>
					<div class="text-all dis-box j-text-all" name="sms_codediv">
						<div class="input-text input-check  box-flex">
						    <input type="hidden" name="mobile">
							<input class="j-input-text" type="text" name="smscode" placeholder="请输入验证码">
							<i class="iconfont is-null j-is-null">&#xe669;</i>
						</div>
						<a type="button" id="sendsms" class="ipt-check-btn send_smscode" href="JavaScript:;">获取验证码</a>
					</div>
					<input type="hidden" name="enabled_sms msgs send_smscode" value="1">
					<input type="submit" class="btn-submit">
				</section>
			</form>
		</div>
		
		<div class="div-messages"></div>
	</div>
	
<!--仅找回密码调用-->
<script>
	var time=60;
	var c=1;
	function data(){
			  if(time ==0 ){
					 c=1;
					 $("#sendsms").html("发送验证码");
					 time =60;
					 return;
			  } 
			  if(time != 0){
					 if($(".ipt-check-btn").attr("class").indexOf("disabled")<0){
						$(".ipt-check-btn").addClass('disabled');
					 }
					 c=0; 
					 $("#sendsms").html("重新获取("+time+")");
					 time--;
			  }
			  setTimeout(data,1000);
	}
	
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
	$( '.phone_bind_form' ).submit( function() {
		// 电话号码
		var username = $( 'input[name="username"]' );
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
					phone : username.val()
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
			}else{
				window.location.href = jsObj.root+'Forget/reset/code/'+sms_code.val()+'/phone/'+username.val()+'.html';
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
				username : username.val(),flag:'forget'
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
		if ( $( this ).hasClass( 'noSendSms' ) ) {
			return false;
		}
		var phone = $( 'input[name="username"]' );
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
			if ( 1==2 ) {
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
							//smscodeObj.prop( 'disabled', true ).val( '60秒后重发' ).addClass( 'noSendSms' );
							smscodeObj.addClass( 'noSendSms' ).html( '60秒后重发' );
							var seconds = 60;
							var auto = setInterval( function(){
								seconds --;
								if ( seconds > 0 ) {
									smscodeObj.val( seconds + '秒后重发' );
								} else {
									//smscodeObj.prop( 'disabled', false ).val( '重新获取' ).removeClass( 'noSendSms' );
									smscodeObj.removeClass( 'noSendSms' ).html( '重新获取' );
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
	$("#next").click(function(){
	   var mobile = $("input[name=username]");
	   var myreg = /^13[0-9]{9}|17[0-9]{9}|14[0-9]{9}|15[0-9]{9}|18[0-9]{9}$/;
	   if(!myreg.test(mobile.val())) 
	   {
		   $("div[name=write_mobilediv]").addClass("active");
		   d_messages('请输入有效的手机号码！',2);
		   return false; 
	   }
	   $("#show_mobile").text(mobile.val());
	   $("input[name=mobile]").val(mobile.val());
	   $("#show").css({display:"none"});
	   $("#check").css({display:"block"}); 

	});
	function check(){
		var error = 0;
		var htmlcode = $("input[name=sms_code]");
		var mobile   = $("input[name=mobile]").val();
		if( htmlcode.val() == ''){
			$("div[name=sms_codediv]").addClass("active");
			d_messages('请输入验证码！');
			return false;
		}
		if(mobile =='' ){
			d_messages('请刷新页面');
			return false;
		}

	}
</script>

</block>