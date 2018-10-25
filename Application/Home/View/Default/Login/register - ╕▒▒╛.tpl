<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/register.js"></script>
</block>

<block name="main">

<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>注册</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>
    
    <!-- 主题内容 -->
	<div class="main" style="background:#fff;">
		<section class="user-center user-login">
			<form class="user-register" action="" method="post">
				<!-- 手机号 -->
				<div class="text-all dis-box j-text-all" name="mobilediv">
					<label>+86</label>
					<div class="box-flex input-text">
						<input class="j-input-text" id="mobile_phone" name="username" type="tel" placeholder="手机号">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
				</div>
				
				<!-- 验证码 -->
				<div class="text-all dis-box j-text-all" name="mobile_codediv">
					<div class="box-flex input-text">
						<input class="j-input-text" name="smscode" type="number" placeholder="请输入验证码">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
					<input type="button" value="发送验证码" class="ipt-check-btn sms_button send_smscode" id="sendsms" />
				</div>
				
				<!-- 幸运号 -->
				<div class="text-all dis-box j-text-all" name="referenceid">
					<div class="box-flex input-text">
						<input class="j-input-text" placeholder="推荐人幸运号（有则填写，无则不填写）" name="recommended" type="number" placeholder="请输入推荐人幸运号">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
				</div>
				
				<button class="btn-submit" type="submit">注册</button>
				
			</form>
			<a href="{:U('Login/login')}" class="a-first u-l-register">已注册直接登录</a>
		</section>
	</div>
	<div class="div-messages"></div>
	
<!-- 仅注册页面调用 -->
<!--script>
	$(":input").keyup(function(){
		   var box=this.name+"div";
		   var div=$("div[name="+box+"]");
		   var value=div.attr("class");
		   var value = value.indexOf("active")
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
		var mobile     =$("input[name=username]").val();
		var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
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
		$.post('', {mobile:mobile,flag:'register'}, function(json){
			json = eval('(' + json + ')');
			alert(json.msg);
		});
	 })
	 
	 function mobilecheck(){
		 var mobile     =$("input[name=mobile]");
		 var mobile_code=$("input[name=mobile_code]");
		 var smspassword=$("input[name=smspassword]");
		 var repassword =$("input[name=repassword]");
		 var sms_code   =$("input[name=sms_code]");
		 var return_code=$("input[name=return_code]").val();
		 var myreg = /^(?:13\d|15\d|18\d)\d{5}(\d{3}|\*{3})$/; 
		 if( mobile.val() == ''){
			 d_messages('请输入手机号',2);
			 $("div[name=mobilediv]").addClass("active");
			 return false;
		 }
		 if( mobile_code.val() == ''){
			 d_messages('请输入手机验证码',2);
			 $("div[name=mobile_codediv]").addClass("active");
			 return false;
		 }
		 if(codecheck){
			 d_messages('验证码错误');
			 return false;
		 }
		 
	 }
</script-->
</block>