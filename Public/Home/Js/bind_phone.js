$(function(){
	
	//文本框失去焦点
	$(".mainForm input").blur(function(){
		$("#mz_Float").css("top","");
	});
	
	//手机号栏失去焦点
	$(".phone").blur(function(){
		reg= /^13[0-9]{9}|17[0-9]{9}|14[0-9]{9}|15[0-9]{9}|18[0-9]{9}$/;//验证手机正则(输入前7位至11位)

		if( $(".phone").val()=="")
		{ 
			$(".error1").html("请输入手机号");
			$(".error1").css("display","block");
		}
		else if($(".phone").val().length<11)
        {   
        	$(".phone").parent().addClass("errorC");
            $(".error1").html("手机号长度有误！");
            $(".error1").css("display","block");
        }
        else if(!reg.test($(".phone").val()))
        {   
        	$(".phone").parent().addClass("errorC");
            $(".error1").html("逗我呢吧，你确定这是你的手机号!");
            $(".error1").css("display","block");
        }
	});
	
	// 点击下一步
	$( '.submit' ).click( function() {
		reg= /^13[0-9]{9}|17[0-9]{9}|14[0-9]{9}|15[0-9]{9}|18[0-9]{9}$/;//验证手机正则(输入前7位至11位)

		if( $(".phone").val()=="")
		{ 
			$(".error1").html("请输入手机号");
			$(".error1").css("display","block");
			return false;
		}
		else if($(".phone").val().length<11)
        {   
        	$(".phone").parent().addClass("errorC");
            $(".error1").html("手机号长度有误！");
            $(".error1").css("display","block");
			return false;
        }
        else if(!reg.test($(".phone").val()))
        {   
        	$(".phone").parent().addClass("errorC");
            $(".error1").html("逗我呢吧，你确定这是你的手机号!");
            $(".error1").css("display","block");
			return false;
        }
	} );

});

//短信验证
$(function  () {
	//获取短信验证码
	var validCode=true;
	$(".msgs").click (function  () {
		var time=30;
		var code=$(this);
		if (validCode) {
			validCode=false;
			code.addClass("msgs1");
		var t=setInterval(function  () {
			time--;
			code.html(time+"秒");
			if (time==0) {
				clearInterval(t);
			code.html("重新获取");
				validCode=true;
			code.removeClass("msgs1");

			}
		},1000)
		}
	})
})
