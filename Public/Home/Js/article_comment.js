function box(){
	this.figure=0;	//当前评价的区域	1直接回复 。2回复评价 3回复评价后的评价 
	this.outerindex=0;//我层li的index
	this.withinidne=0;//内层li的index
	this.withinname=""
}
$(function(){
	// ajax全局设置
	$.ajaxSetup({
		type : 'POST',
		async : true,
		dataType : 'json',
		beforeSend : function() {
			$('body').append( '<div class="load-container-ajax load-container load4"><div class="loader"></div></div>' );
		},
		complete : function() {
			$( '.load-container-ajax' ).fadeOut( 'normal', function() {
				$( this ).remove();
			} );
		}
	});
	//交流详情
	//$("#remarktext").focus();
	$(".backblak .clocs").click(function(){
		$(".backblak").fadeOut(100);
		$(".backblak").find("input").val("");
		$( '.addComments' ).attr( 'reply_id', 0 );
		$( '.addComments' ).attr( 'theme_id', 0 );
	})
	var remarkprice="";
	$("a.setlage").click(function(){
		$(".backblak").fadeIn(100);
		$("#remarktext").focus();
		$("html,body").animate({scrollTop: $('.details').offset().top}, 1000);
		box.figure=1;
	})	
	$(".details .revert .single div i").click(function(){
		var reply_id = $( this ).attr( 'reply_id' );
		var theme_id = $( this ).attr( 'theme_id' );
		if($(this).parents(".wb86").parent().parent().prev().length==1){
			box.figure=3;
			box.outerindex=$(this).parents(".single").index();
			box.withinidne=$(this).parents(".wb86").parent("li").index()
			box.withinname=$(this).parent().siblings(".name").val();
		}else{
			box.figure=2;
			box.outerindex=$(this).parents(".single").index();
			box.withinname=$(this).parent().siblings(".name").val();
		}
		$( '.addComments' ).attr( 'reply_id', reply_id );
		$( '.addComments' ).attr( 'theme_id', theme_id );
		$(".backblak").fadeIn(100);
		$("#remarktext").focus();
	})
	
	
	$( '.addComments' ).on( 'click', function() {
		var article_id = $( this ).attr( 'article_id' );
		var reply_id = $( this ).attr( 'reply_id' );
		var theme_id = $( this ).attr( 'theme_id' );
		submits( article_id, reply_id, theme_id );
	} );
	
})

function submits( article_id, reply_id, theme_id ){
	if ( jsObj.is_login != 1 ) {
		d_messages( '请先登录' );
		window.location.href = jsObj.login_url;
		return false;
	}
	if ( isNaN( parseInt( article_id ) ) ) {
		d_messages( '参数有误' );
		return false;
	}
	
	var figureasrc=$(".figureimg").attr("src");	//头像
	var myname=$(".myname").val();	//自己的昵称
	var details=$(".backblak").find("input");//回复的内容
	
	if ( details.val() == '' ) {
		d_messages('请填写内容');
		details.focus();
		return false;
	}

	// 提交信息
	$.ajax({
		url : jsObj['root'] + '/Article/addComments.html?rnd=' + Math.random(),
		data : {
			article_id : article_id,
			reply_id : reply_id,
			theme_id : theme_id,
			content : details.val()
		},
		success : function(data) {
			if ( data['status'] ) {
				
			} else {
				d_messages(data['info']);
			}
		}
	});
	
	var details = details.val();
	if(box.figure==1){ //回复帖子
		 if(details!=""){
			$(".details .outermost").prepend("<li class='single'><div class='wb14'><img src='"+figureasrc+"'></div><div class='wb86'><input type='hidden'  class='name' value='"+myname+"'><h5 class='name'><span>"+myname+"</span></h5><p>"+details+"</p> <div><em>刚刚</em><i class='iconfont'>&#xe61f;</i></div></div><ul class='interior'></ul></li>")
			$(".backblak").fadeOut(100); 
		} 
	}
	if(box.figure==2){
		if(details!=""){
			$(".details .revert .outermost>li:eq("+box.outerindex+") ul").prepend("<li class='single'><div class='wb14'><img src='"+figureasrc+"'></div><div class='wb86'><input type='hidden'  class='name' value='"+myname+"'><h5 class='name'><span>"+myname+"</span>回复<span>"+box.withinname+"</span></h5><p>"+details+"</p> <div><em>刚刚</em><i class='iconfont'>&#xe61f;</i></div></div></li>")
			$(".backblak").fadeOut(100);
		}
	}
	if(box.figure==3){
		if(details!=""){
			$(".details .revert .outermost>li:eq("+box.outerindex+") ul>li:eq("+box.withinidne+")").after("<li><div class='wb14'><img src='"+figureasrc+"'></div><div class='wb86'><input type='hidden' class='name' value='"+myname+"'>	<h5 class='name'><span>"+myname+"</span>回复<span>"+box.withinname+"</span></h5><p>"+details+"</p><div><em>刚刚</em><i class='iconfont'>&#xe61f;</i></div></div></li>")
			$(".backblak").fadeOut(100);
	   }
	}
	
	$(".backblak").find("input").val("");
	$( '.addComments' ).attr( 'reply_id', 0 );
	$( '.addComments' ).attr( 'theme_id', 0 );
}