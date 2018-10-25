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


</block>
<block name="main">

<body>
	<section id="BiaoD" style="margin-top: 7.2rem;">
		<form action="" method="post">
		<div class="tianxie_bd">
			<p>
				<input placeholder="请输入手机号码" type="text" name="username" value="" />
			</p>
			<p>
				<a href="javascript:void(0);" id="sendsms">获取验证码</a>
				<small>
					<input placeholder="请输入验证码" type="text" name="smscode" value="" />
				</small>
			</p>
		</div>			
			<input style="margin-bottom: .6rem;" class="btn-th" type="button" value="确认修改"/>
		</form>
	</section>
	
</body>

<script>


$( function() {
	//验证手机正则
	var phoneReg =  /^1[3|4|5|7|8][0-9]\d{8}$/;
	var username = $("input[name=username]");
	var smscode = $("input[name=smscode]");
	
	var flaf = 1;
	$("#sendsms").click(function() {
		// console.log(checkPhone());return;


		if($(this).attr('state')){
			return false;
		}else if (checkPhone()== 0) {
			return false;
		}else{
			// console.log(checkPhone());return;
			$.ajax({
				url : '/Verification/sendSMS.html?rnd=' + Math.random(),
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
		}
		
	})

	$(".btn-th").click(function() {
		if (checkSMS() == 0) {
			return;
		}else if(checkPhone() == 0){
			return;
		}else{
			$.ajax({
				url: 'phone_bind',
				type: 'POST',
				dataType: 'json',
				data: {username: username.val()},
			})
			.done(function(data) {
				if (data.status == 1) {
				window.location.href = 'update';

				}
			})
		}
		

		
	})



	function checkPhone() {
		var state = 1;
		if (username.val() == '') {
			layer.open({
	            content: '手机号不能为空'
	            ,skin: 'msg'
	            ,time: 2 //2秒后自动关闭
	        });
			username.focus();
			flag = 0;
			return flag;
		}
	
		if (!phoneReg.test( username.val() ) ) {
			layer.open({
                        content: '手机号格式不正确'
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
			username.focus();
			flag = 0;
			return flag;
		}
	

		$.ajax({
			url: '/Verification/checkPhone.html?rnd=' + Math.random(),
			type: 'POST',
			dataType: 'json',
			data: {username: username.val()},
			async:false,
		})
		.done(function(data) {
			if (data.status == 0) {
				layer.open({
                        content: data.info
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
				username.focus();
				state = 0;
			}
		})
		return state;
		
		
	}



	function checkSMS() {
		var smscode = $("input[name=smscode]");
		var state = 1;

		$.ajax({
			url: '/Verification/checkSMS.html?rnd=' + Math.random(),
			type: 'POST',
			dataType: 'json',
			data: {code: smscode.val(),phone:username.val()},
			async:false,
		})
		.done(function(data) {
			if (data.status == 0) {
				layer.open({
                        content: data.info
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
				smscode.focus();
				state = 0;
			
			}
		})
		return state;
		
	}


})
		
</script>
</block>