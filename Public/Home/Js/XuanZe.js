$(".male-a").click( function () {
    $(this).parents("li").siblings("li").children('label').children("span").removeClass("active");
     $(this).parents("li").siblings("li").children("label").css('color','#0f0f0f');
	$(this).siblings("label").children('span').addClass("active");
	$(this).siblings('label').css('color','#1194f7');
});
$(".male-b").click( function (){
	if ($(this).is(':checked')){
		$(this).siblings("label").children('span').addClass("active");
		$(this).siblings('label').css('color','#1194f7');
	}else{
		$(this).siblings("label").children('span').removeClass("active");	
		$(this).siblings('label').css('color','#0f0f0f');		
	}
})

//倒计时

var starttime = new Date("2020/12/31 15:00");
			  setInterval(function () {
			    var nowtime = new Date();
			    var time = starttime - nowtime;
//			    var day = parseInt(time / 1000 / 60 / 60 / 24);
			    var hour = parseInt(time / 1000 / 60 / 60 % 24);
			    var minute = parseInt(time / 1000 / 60 % 60);
			    var seconds = parseInt(time / 1000 % 60);
			    $('.timespan').html("倒计时&nbsp;"+hour + ":" + minute + ":" + seconds );
			  }, 1000);