$(function(){
	$('.fix_di a').click(function(){
	    if($('.fix_ul').css("display") == 'none'){
	        $('.fix_ul').fadeIn();
	    }else{
	        $('.fix_ul').fadeOut();
	    }
	});
	$(window).scroll(function(){  //jquery的scroll()方法
	    if($(this).scrollTop()>350){
	        $(".fix_di").fadeIn(1500);}  //jquery的fadeIn()显示方法
	    else{$(".fix_di").fadeOut(1000);}  //jquery的fadeIn()隐藏方法
	});
})

// 跳转url
function LocationUrl( url ) {
	location.href = url;
}

// 弹出提示窗口[显示]
function loadingShow() {
	$( "#commLoadingBg,#commLoading" ).show();
}

// 弹出提示窗口[显示]
function loadingClose( type, string ) {
	var time = arguments[2] ? arguments[2] : 1000;
	if ( time == 0 && type == "Success" ) {
		$( "#commLoadingBg,#commLoading" ).hide( 1, function() {
			$( "#commLoading" ).html( '交互进行中，请稍等...' ).removeClass( "commLoading" + type );
		} );
	} else {
		$( "#commLoading" ).addClass( 'commLoading' + type ).html( string );
		setTimeout( function() {
			$( "#commLoadingBg,#commLoading" ).hide( "sold", function() {
				$( "#commLoading" ).html( '交互进行中，请稍等...' ).removeClass( "commLoading" + type );
			} );
		}, time );
	}
}