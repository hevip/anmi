/**
 * Created by Administrator on 2015/7/3.
 */
$(function(){
	var html = '<div class="popupBg" style="display:block;"></div>';
		html += '<div class="popupImg" style="display:block;">';
		html += '<img src="'+jsObj['images']+'/loading3.gif" />';
		html += '<p style="display:block;">数据交互中...</p>';
		html += '</div>';
		
		
    $(".out_div").css({"height":$(document.body).height()});
    $(".out_div").css({"width":$(document.body).width()});
    $('.car-right').click(function(){
        if($('.out_div').css("display") == 'none'){
            document.body.style.overflow='hidden';
            $('.out_div').fadeIn()}
    });
    //class
    $( ".pro_div ul li").eq( 0).addClass( "active" );
    $( ".pro_div ul li").click( function() {
        var index = $(this).index();
        $(this).addClass( "active").siblings( ".active").removeClass( "active" )});

    function ss(){
        $('.p_d_po').click(function(){
            document.body.style.overflow='auto';
            $('.out_div').fadeOut();
        });
    }
    ss();

	/*切换*/
	$(".pro_show_title ul li").click(function(){
		$(this).addClass("on").siblings(".pro_show_title ul li").removeClass("on");
		if($(this).index()==0){
			$(".pro_show_con").show();
			$(".msg_show_con").hide();
		}else{
			$(".pro_show_con").hide();
			$(".msg_show_con").show();
		}
	});

	/*留言*/
	$(".reply_cl").click(function(){
		var li_con = $(this).parent().parent().parent().parent();
		var nickname=$(this).parent().parent().find("dd").children("a.first").html();

		var _label1 ="<div class='reply_con'><form><p class='reply_con_c'><textarea>回复  "+nickname+"：</textarea></p>";

		var _label2="<p class='reply_con_s'><input type='submit' value='发表' /></p></form></div>";

		if(li_con.find(".reply_con").length>0){
			li_con.find(".reply_con").empty();
			li_con.append(_label1+_label2);
		}else{
			li_con.append(_label1+_label2);
		}
	});


	/*我要留言*/
	$(".reply_new_a").click(function(){
		// 判断是否登录
		/*if ( jsObj['is_login'] == 0 ) {
			alert( "登录之后才能留言!" );
			return false;
		}*/
		$(this).next(".reply_con").toggle();
	});
	
	/* 提交留言信息 */
	$( "#message_form" ).submit( function() {
		// 判断是否登录
		/*if ( jsObj['is_login'] == 0 ) {
			alert( "登录之后才能留言!" );
			return false;
		}*/
		// 获取信息
		var url = $( this ).attr( "action" ) + "?rnd=" + Math.random();
		var json = $( this ).serialize();
		$.ajax({
			url : url,
			type : "POST",
			data : json,
			dataType : 'json',
			async : true,
			beforeSend : function(){
				$( 'body' ).append( html );
			},
			success : function( data ) {
				$( '.popupBg,.popupImg' ).fadeOut();
				if ( data['status'] == 1 ) {
					var tempHtml = '<li class="dtcmc_li">';
						tempHtml += '<div class="headimg_name">';
						tempHtml += '<span class="headimg"><img src="'+ jsObj['root'] + data['member_info']['head'] +'" /></span>';
						tempHtml += '<span class="nickname">'+ data['member_info']['nickname'] +'</span>';
						tempHtml += '<span class="date">'+ data['info']['create_time'] +'</span>';
						tempHtml += '</div>';
						tempHtml += '<div class="msg_con">'+ data['info']['intro'] +'</div>';
						tempHtml += '</li>';
					$( ".message_box" ).prepend( tempHtml );
					// 隐藏并清空表单信息
					$( ".reply_con" ).slideUp();
					$( ".reply_con textarea" ).val( '' );
				}				
				setTimeout( function(){
					$( '.popupBg,.popupImg' ).remove();
					if ( data['status'] == 0 ) {
						alert( data['info'] );
					}
				}, 500 );
			}
		});
		return false;
	} );
	$('.collection').click(function(){
		var $this = $(this);
		var id=$(this).attr('data-id');
		var str = $this.find('em').html();
		$.ajax({
			url : jsObj['root'] + '/MemberCollection/add/rnd/' + Math.random(),
			data : {
				id : id,
			},
			type : 'POST',
			async : false,
			dataType : 'json',
			beforeSend : function() {
				
			},
			success : function( data ) {
				if ( data['status']  == 1 ) {
					d_messages(data.info);
					if(str == '未收藏'){
						$this.find('em').html('已收藏');
					}else{
						$this.find('em').html('未收藏');
					}
				}else{
					
					if(data.url){
//						layer.confirm(data.info, {
//							  btn: ['去登陆','下次登陆'] //按钮
//							}, function(){
//							  
//							}, function(){
//							});
						d_messages(data.info);
						window.location.href = data.url;
					}else{
						d_messages(data.info);
					}
				}
			}
		});
	});
	
});