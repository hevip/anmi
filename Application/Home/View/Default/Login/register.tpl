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
    </style>
<body>
	<section id="BiaoD" style="margin-top: 7.2rem;">
		<form action="" method="post">
		<div class="tianxie_bd">
			<p>
				<select name="" id="company">
					<option value="" selected="selected" disabled="disabled">选择单位代号</option>
					<volist name="companyList" id="vo">
					<option value="{$vo.id}">{$vo.shorthandname}</option>
					</volist>
				</select>
				<b>*请联系单位管理员提供</b>
			</p>
			<p>
				<select name="" id="department">
					<option value="" selected="selected" disabled="disabled">选择部门代号</option>
				</select>
				<b>*请联系单位管理员提供</b>
			</p>
			<p>
				<input placeholder="请输入手机号码" type="text" name="username" value="" />
				<b>*请输入您的手机号码</b>
			</p>
			<p>
				<a href="javascript:void(0);" id="sendsms" >获取验证码</a>
				<small>
					<input placeholder="请输入验证码" type="text" name="smscode" value="" />
				</small>
			</p>
			<ul>
				<li style="width: 100%;">
		            <input type="radio" class="male-a" name="agreement" id="male">		            
					<label for="male"><span style="width:1.2rem;height:1.2rem;border-radius: 100%;" class="female-custom"></span></label>同意并接受<a style="color: #0064BE;" href="#">《安全用户协议》</a>及安全隐私权保护声明 
				</li>
			</ul>
			<!-- <script src="js/XuanZe.js" type="text/javascript"></script> -->
		</div>			
			<input style="margin-bottom: .6rem;" class="btn-th" type="button" value="下一步"/>
		</form>
		<script src="__JS__/XuanZe.js" type="text/javascript"></script>
		<div class="wj_jz">
			<a href="{:U('login')}">已有账号，去登陆</a>

		</div>
	</section>
	
</body>
<script>
$('#company').change(function () {
	var company_id = $('#company option:selected').val();
	$.ajax({
		url: 'getDepartment',
		type: 'POST',
		dataType: 'json',
		data: {id: company_id},
	})
	.done(function(msg) {
		$('#department option').remove();
		// var dataObj=eval("("+data+")");
		if (msg !=null) {
			$.each(msg,function(i,data){
				$('#department').append("<option value='"+data.id+"'>"+data.shorthandname+"</option>");
			});
		}else{
				$('#department').append("<option value='' disabled='disabled'>该单位没有部门</option>");
		}
	})

	
 
})
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
		if(checkPhone() == 0){
			return;
		}
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
				if(data['status'] == 0){
					alert('手机号已被注册');return;
				} else{
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
				}
//				else {
//					$( '.popupBg,.popupImg' ).hide();
//				}
			}
		});
	})

	$(".btn-th").click(function() {
		// console.log($("input[name=agreement]").is(":checked"));return;
		var company = $("#company option:selected");
		var department = $("#department option:selected");
		if (!$("input[name=agreement]").is(":checked")) {
			layer.open({
				content: '必须同意用户安全协议'
				,skin: 'msg'
				,time: 2 //2秒后自动关闭
			});
			flag = 0;
			return false;
		}
			$.ajax({
				url: 'registerFirst',
				type: 'POST',
				dataType: 'json',
				data: {username: username.val(),code:smscode.val(),cid:company.val(),department_id:department.val()},
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
					return false;
				}
				if (data.status == 1) {
				window.location.href = 'registerSecond';
				}
			})
	})

	function checkPhone() {
		var state =1;
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
		if ($("#company option:selected").val()==null) {
			layer.open({
	            content: '请选择单位代号'
	            ,skin: 'msg'
	            ,time: 2 //2秒后自动关闭
	        });
			flag = 0;
			return flag;
		}
		if ($("#department option:selected").val()==null) {
			layer.open({
	            content: '请选择部门代号'
	            ,skin: 'msg'
	            ,time: 2 //2秒后自动关闭
	        });
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
		if(username.val().length != 11){
			layer.open({
				content: '手机号格式不正确'
				,skin: 'msg'
				,time: 2 //2秒后自动关闭
			});
			username.focus();
			flag = 0;
			return flag;
		}
//		$.ajax({
//			url: '/Verification/checkPhone.html?rnd=' + Math.random(),
//			type: 'POST',
//			dataType: 'json',
//			data: {
//				username: username.val()
//			},
//			async:false,
//		})
//		.done(function(data) {
//			if (data.status == 0) {
//				layer.open({
//                        content: data.info
//                        ,skin: 'msg'
//                        ,time: 2 //2秒后自动关闭
//                      });
//				username.focus();
//				state = 0;
//			}
//		})

		return state;
	
		
	}
	function checkSMS() {
		var state = 1;
		var smscode = $("input[name=smscode]");
		if (!$("input[name=agreement]").is(":checked")) {
			layer.open({
                        content: '必须同意用户安全协议'
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
			flag = 0;
			return flag;
		}
		$.ajax({
			url: '/Verification/checkSMS.html?rnd=' + Math.random(),
			type: 'POST',
			dataType: 'json',
			data: {code: smscode.val(),phone:username.val()},
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
				return state;
			}
		})
		return state;
	}


})
		
</script>
	
</block>