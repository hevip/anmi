<extend name="Base/common1" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">
</block>
<block name="main"> 
<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>密码管理</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		<section class="user-wallet-pw">
			<form method="post" action="{:U('updatechange')}">
				<input name="reffer" value="{$Think.server.http_referer}" type="hidden" />
				<!-- 说明 -->
				<p class="wallet-pw-txt">将发送短信验证码到{$member['tel']?$member['tel']:$member['username'] }</p>
				
				<!-- 手机号 -->
				<input id="mobile_phone" name="mobile" type="hidden" value="{$member['tel']?$member['tel']:$member['username'] }">
				
				<!-- 验证码 -->
				<div class="text-all dis-box j-text-all" name="mobile_codediv">
					<div class="box-flex input-text">
						<input class="j-input-text" name="mobile_code" type="number" placeholder="请输入验证码">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
					<a href="#" type="button" class="ipt-check-btn" id="sendsms">发送验证码</a>
				</div>
				
				<!-- 密码 -->
				<div class="text-all dis-box j-text-all" name="smspassworddiv">
					<div class="box-flex input-text">
						<input class="j-input-text" name="smspassword" type="password" placeholder="请输入密码">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
					<i class="iconfont is-yanjing j-yanjing disabled">&#xe668;</i>
				</div>
				
				<!-- 确认密码 -->
				<div class="text-all dis-box j-text-all" name="repassworddiv">
					<div class="box-flex input-text">
						<input class="j-input-text" name="repassword" type="password" placeholder="请重新输入密码">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
					<i class="iconfont is-yanjing j-yanjing disabled">&#xe668;</i>
				</div>
				
				<!-- 确定按钮 -->
				<div class="user-recharge-btn">
					<button type="submit" id = 'goChange' class="btn-submit"  name="submit" value="sub">确定</button>
				</div>
			</form>
		</section>
		
	</div>
	
<script>
	$(":input").keyup(function(){
		   var box=this.name+"div";
		   var div=$("div[name="+box+"]");
		   var value=div.attr("class").indexOf("active")
		   if ( value > 0 ){
			  div.removeClass("active");
		   }
		});
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
					 $("#sendsms").html("<span>重新获取("+time+")</span>");
					 time--;
			  }
			  setTimeout(data,1000);
	}
	
	$("#sendsms").click(function(){
		if(c==0){ 
			 d_messages('发送频繁');
			 return;
		}
		var mobile     ={$member['tel']?$member['tel']:$member['username']};
		var myreg =  /^13[0-9]{9}|17[0-9]{9}|14[0-9]{9}|15[0-9]{9}|18[0-9]{9}$/;
		if( mobile==''){
			d_messages('请输入手机号');
			$("div[name=mobilediv]").addClass("active");
			return false;
		}else if(!myreg.test(mobile)){
				 d_messages('请输入有效的手机号',2);
				 $("div[name=mobilediv]").addClass("active");
				 return false;

		}
		data();
		$.ajax({
			url : jsObj['root'] + '/Verification/sendSMS.html?rnd=' + Math.random(),
			data : {
				phone : mobile,
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
	 })
	 $("#goChange").click(function(){
	 	 var mobile     =$("input[name=mobile]");
		 var mobile_code=$("input[name=mobile_code]");
		 var smspassword=$("input[name=smspassword]");
		 var repassword =$("input[name=repassword]");
		 var sms_code   =$("input[name=sms_code]");
		 var return_code=$("input[name=return_code]").val();
		 var myreg =  /^13[0-9]{9}|17[0-9]{9}|14[0-9]{9}|15[0-9]{9}|18[0-9]{9}$/;
		 if( mobile.val() == ''){
			 d_messages('请输入手机号',2);
			 $("div[name=mobilediv]").addClass("active");
			 return false;
		 }else if(!myreg.test(mobile.val())){
			 d_messages('请输入有效的手机号',2);
			 $("div[name=mobilediv]").addClass("active");
			 return false;

		 }
		 if( mobile_code.val() == ''){
			 d_messages('请输入手机验证码',2);
			 $("div[name=mobile_codediv]").addClass("active");
			 return false;
		 }
		 if( smspassword.val() == ''){
			 d_messages('请输入密码',2);
			 $("div[name=smspassworddiv]").addClass("active");
			 return false;
		 }else if(smspassword.val().length != 6){
			 d_messages('密码只能为6位',2);
			 $("div[name=smspassworddiv]").addClass("active");
			 return false;
		 }
		 if( smspassword.val() != repassword.val()){
			 d_messages('两次密码输入不一致',2);
			 $("div[name=smspassworddiv]").addClass("active");
			 $("div[name=repassworddiv]").addClass("active");
			 return false;
		 }
	 })
</script>
</block>
