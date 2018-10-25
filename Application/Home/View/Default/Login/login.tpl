<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>

<block name="main">

    <style type="text/css">
    	.tianxie_bd p{
    		margin-bottom: 1.5rem !important;
    	}
    	.tianxie_bd p a{
    		float: right;
    		width: 28%;
    		padding: 0;
    		margin: 0;
    		display: block;
    		text-align: center;
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
    </style>
</head>
<body>
	<section id="BiaoD" style="margin-top: 7.2rem;">
		<form action="" method="post" class="user-login">
		<div class="tianxie_bd">
			<!--<p>
				<select name="">
					<option value="" selected="selected" disabled="disabled">选择单位代号</option>
					<option value="">1</option>
				</select>
			</p>-->
			<p>
				<input placeholder="请输入个人代号或手机号" type="text" name="personal_code" />
			</p>
			<p>
				<input placeholder="请输入密码" type="password" name="password" />
			</p>
			<p>
				<a href="javascript:void(0);" style="width: 38%"><img src="{:U('/Login/verify')}" class="yzm_img" onclick="this.src='{:U("/Login/verify")}?rnd='+Math.random();" /></a>
				<small style="width: 60%">
					<input placeholder="请输入验证码" type="text" name="verify"  />
				</small>
			</p>
		</div>			
			<input style="margin-bottom: .6rem;" class="btn-th" type="submit" value="登录"/>
		</form>
		<div class="wj_jz">
			<a href="{:U('register')}">我要注册</a>
			<a href="{:U('password')}">忘记密码</a>
		</div>
	</section>
	
</body>
<script src="__JS__/laydate.js"></script> <!-- 改成你的路径 -->
<script>
lay('#version').html('-v'+ laydate.v);

//执行一个laydate实例
laydate.render({
  elem: '#test1', //指定元素
  type: 'datetime',
});
laydate.render({
  elem: '#test2', //指定元素
  type: 'datetime'

});
</script>

<script type="text/javascript">

$( function() {

	// 表单验证
	$( '.user-login' ).submit( function() {
	
		// 图片验证码
		var verify = $( 'input[name="verify"]' );
		if ( verify.val().length != 5 ) {
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

	// 图片验证码
	function checkVerify( verify ) {
		var newArray = new Array();
		$.ajax({
			url : '/Verification/checkVerify.html?rnd=' + Math.random(),
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
	

	
} );
} );
</script>
</block>