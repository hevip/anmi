<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>

<block name="jscript">
</block>

<block name="main">
  <style type="text/css">
    	.tianxie_bd p{
    		margin-bottom: 1rem !important;
    	}
    	.tianxie_bd p a{
    		float: right;
    		width: 28%;
    		padding: 0;
    		margin: 0;
    		display: block;
    		text-align: center;
    		color: #0064BE;
    		height: 4rem;
    		line-height: 4rem;
    		border: 0;
    		overflow: hidden;
    	}
    	.tianxie_bd p a img{
    		display: block;
    		width: 100%;
    		height: 100%;
    		overflow: hidden;
    	}
    	.tianxie_bd p small{
    		display: block;
    		float: left;
    		width: 70%;
    		overflow: hidden;
    	}
    	.tianxie_bd p b{
    		display: block;
    		font-weight: normal;
    		color: #999999;
    		font-size: 1rem;
    		margin-top: .2rem;
    	}
	  .back{
		  width: 92.2%;
		  overflow: hidden;
		  display: block;
		  background: #89c6ff;
		  color: #FFFFFF;
		  height: 4.3rem;
		  line-height: 4.3rem;
		  text-align: center;
		  border-radius: 2rem;
		  font-size: 1.4rem;
		  margin: 1.6rem auto;
		  margin-bottom: .6rem;
	  }
    </style>
<body>
	<section id="BiaoD" style="margin-top: 7.2rem;">
		<form action="" method="post">
		<div class="tianxie_bd">
			<p>
				<input placeholder="请输入您的代号" type="text" name="personal_code" value="" />
			</p>
			<p>
				<input placeholder="请输入手机号码" type="text" name="username" value="" />
			</p>
			<p>
				<a href="javascript:void(0);" id="sendsms" >获取验证码</a>
				<small>
					<input placeholder="请输入验证码" type="text" name="smscode" value="" />
				</small>
			</p>
			<p>
				<input placeholder="请输入新密码6-12位" type="password" name="password" value="" />

			</p>
			<p>
				<input placeholder="再次确认密码" type="password" name="passwords" value="" />

			</p>
			<!-- <script src="js/XuanZe.js" type="text/javascript"></script> -->
		</div>			
			<input style="margin-bottom: .6rem;" class="btn-th" type="button" value="确认修改"/>
			<!--<a href="javascript:history.back(-1)" class="back" >返回</a>-->
		</form>
		<script src="__JS__/XuanZe.js" type="text/javascript"></script>
	</section>
	
</body>
<script>
var flaf = 1;
$( function() {
	//验证手机正则
	var phoneReg =  /^13[0-9]{9}|17[0-9]{9}|14[0-9]{9}|15[0-9]{9}|18[0-9]{9}$/;
	var username = $("input[name=username]");
	var smscode = $("input[name=smscode]");


	$("#sendsms").click(function() {

		if($(this).attr('state')){
			return false;
		}
//		if(checkPhone() == 0){
//			return false;
//			return;
//		}
		checkPhone();
		$.ajax({
			url : '/Verification/passSendSMS.html?rnd=' + Math.random(),
			data : {
				phone : username.val(),
			},
			type : 'POST',
			async : true,
			dataType : 'json',
			// beforeSend : function() {
			// 	$( '.popupBg,.popupImg' ).show();
			// },
			success : function( data ) {
				if ( data['status'] == 1 ) {
					$('#sendsms').attr('state', '1').html( '60秒后重发' ).css("color","grey");
					var seconds = 60;
					var auto = setInterval( function(){
						seconds --;
						if ( seconds > 0 ) {
							$('#sendsms').html( seconds + '秒后重发' );
						} else {
							// smscodeObj.prop( 'disabled', false ).val( '重新获取' ).removeClass( 'noSendSms' );
							$('#sendsms').removeAttr('state').html( '重新获取' ).css('color', "#0064BE");
							clearInterval( auto );
						}
					}, 1000 );
				} else {
					$( '.popupBg,.popupImg' ).hide();
				}
			}
		});
	})

	function checkPhone() {
		var state = 1;
		if (username.val() == '') {
			layer.open({
				content: '手机号不能为空'
				, skin: 'msg'
				, time: 2 //2秒后自动关闭
			});
			username.focus();
			flag = 0;
			return flag;
		}
		if (!phoneReg.test(username.val())) {
			layer.open({
				content: '手机号格式不正确'
				, skin: 'msg'
				, time: 2 //2秒后自动关闭
			});
			username.focus();
			flag = 0;
			return flag;
		}
		return state;
	}

	function checkPassword(){
		var password = $("input[name=password]");
		var passwords = $("input[name=passwords]");
			var state =1;
		if (password.val() == ''){
			layer.open({
				content: '密码不能为空'
				,skin: 'msg'
				,time: 2 //2秒后自动关闭
			});
			password.focus();
			flag = 0;
			return ;
		}
		if (password.val() !=passwords.val()) {
			layer.open({
				content: '两次密码不一致'
				,skin: 'msg'
				,time: 2 //2秒后自动关闭
			});
			password.focus();
			flag = 0;
			return flag;
		}
		if (password.val().length<6) {
			layer.open({
				content: '密码不能少于六位'
				,skin: 'msg'
				,time: 2 //2秒后自动关闭
			});
			password.focus();
			flag = 0;
			return flag;
		}
		return state;
	}

	$('.btn-th').click(function() {
		var p_code = $("input[name=personal_code]");
		var pas = $("input[name=password]");
		var pass = $("input[name=passwords]");
		var state = 1
		var smscode = $("input[name=smscode]");
		$.ajax({
					url: '/Verification/updatePassword.html?rnd=' + Math.random(),
					type: 'POST',
					dataType: 'json',
					data: {code: smscode.val(),phone:username.val(),p_code:p_code.val(),password:pas.val(),passwords:pass.val()},
				})
				.done(function(data) {
					if (data.status == 1) {
						alert('修改成功');
//						layer.open({
//							content: data.info
//							,skin: 'msg'
//							,time: 12
//						});
//						smscode.focus();
//						state = 0;
						window.location.href= '/Login/login';
					}
					if (data.status == 0) {
						layer.open({
							content: data.info
							,skin: 'msg'
							,time: 2
						});
						return false;
					}
				})
		return state;
	})



})
		
</script>
	
</block>