/**
 * Created by Administrator on 2015/7/3.
 */
$(function(){
    $(".max_div").css({"height":$(window).height()});
    $(".max_div").css({"width":$(window).width()});
    $('.span_img').click(function(){
        if($('.max_div').css("display") == 'none'){
            $('.max_div').slideDown(function(){
                ($('.max_div').css({
                position:'fixed',
                top:'0'
            }))
        });
        }else{
            $('.max_div').slideUp();
        }
        $('.per_d_a').click(function(){
            $('.max_div').slideUp();
        });
    });
//        1
    $('.switch').click(function(){
        if($('.swi_div').css("display") == 'none'){
            $('.swi_div').fadeIn(200,function(){
            });
        }else{
            $('.swi_div').fadeOut();
        }
    });
    //switch2
    $('.switch1').click(function(){
        if($('.swi_div1').css("display") == 'none'){
            $('.swi_div1').fadeIn(200,function(){
            });
        }else{
            $('.swi_div1').fadeOut();
        }
    });
    //switch3
    $('.switch2').click(function(){
        if($('.swi_div2').css("display") == 'none'){
            $('.swi_div2').fadeIn(200,function(){
            });
        }else{
            $('.swi_div2').fadeOut();
        }
    });
//   ÒøÐÐ
$('.bank_s').click(function(){
    var bank =$(".bank_div");
    bank.css({"height":$(window).height()});
    bank.css({"width":$(window).width()});
    if(bank.css("display") == 'none'){
        bank.slideDown(function(){
            (bank.css({
                position:'fixed',
                top:'0'
            }));
        });
    }
    if(bank.css("display") == 'block'){
        $('.bank_a').click(function(){
            bank.slideUp();
        });
    }
    // bank1
    $('.span_bank1').click(function(){
        if($('.bank_swi1').css("display") == 'none'){
            $('.bank_swi1').fadeIn(200,function(){
            });
        }else{
            $('.bank_swi1').fadeOut();
        }
    });
    //bank2
    $('.span_bank2').click(function(){
        if($('.bank_swi2').css("display") == 'none'){
            $('.bank_swi2').fadeIn(200,function(){
            });
        }else{
            $('.bank_swi2').fadeOut();
        }
    });
    //bank3
    $('.span_bank3').click(function(){
        if($('.bank_swi3').css("display") == 'none'){
            $('.bank_swi3').fadeIn(200,function(){
            });
        }else{
            $('.bank_swi3').fadeOut();
        }
    });
});
});
