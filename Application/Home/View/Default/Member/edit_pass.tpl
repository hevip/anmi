﻿<extend name="Base/common1" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">

</block>
<block name="main">

<body>
	<section id="BiaoD" style="margin-top: 7.2rem;">
		<form action="" method="post" onsubmit="return check()">
		<div class="tianxie_bd">
			<p>
				<input placeholder="请输入旧密码" type="password" name="oldpass" id="oldpass" value="" />
			</p>
			<p>
				<input placeholder="请输入新密码" type="password"  name="password" value="" />
			</p>
			<p>
				<input placeholder="请再次输入新密码" type="password" name="notpassword" value="" />
			</p>
		</div>			
			<input style="margin-bottom: .6rem;" class="btn-th" type="button" value="确认修改"/>
		</form>
	</section>
	
</body>
	
<script>
$(function () {

	$("#oldpass").blur(function(){
		var oldpass = $("input[name=oldpass]");
		$.ajax({
			url: '{:U('Member/checkOldPass')}',
			type: 'POST',
			dataType: 'json',
			data: {oldpass: oldpass.val()},
			success:function (data) {
				if (data.status == 0) {
					layer.open({
                        content: data.info
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
					oldpass.focus();
					return;
				}
				
			}
		})

		

	  
	});
	$(".btn-th").click(function() {
		$.ajax({
			url: '{:U('Member/edit_pass')}',
			type: 'POST',
			dataType: 'json',
			data: {password: $("input[name=password]").val(),repassword:$("input[name=notpassword]").val()},
		})
		.done(function(data) {
			if (data.status == 1) {
				layer.open({
                        content: data.info
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
				window.location.href = "index";
			}else{
				layer.open({
                        content: data.info
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
				return;
			}
		})
	


	})
	function check(){
		var word      =$("input[name=password]");
		var word2     =$("input[name=notpassword]");
		if(word.val().length <6){
			 layer.open({
                        content: '新密码不能小于六位'
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
			word.focus();
			 return false;
		 }
		if(word.val() != word2.val()){
			 layer.open({
                        content: '两次密码不一致'
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
			 word2.focus();
			 return false;
		 }
	   
   }

})
</script>
</block>
