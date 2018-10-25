$(function(){
	$('.goToPast').click(function(){
    	if(jsObj.is_login==0){
    		d_messages('您还未登陆',2);
    		window.location.href = jsObj.login_url;
    		return fale;
    	}
    	var $this = $(this);
    	if($this.hasClass('pasting'))return false;
    	$this.addClass('pasting');
    	$.post(jsObj.root+'/Index/past','',function(data){
    		if(data.status == 1){
    			d_messages(data.message,2);
                	$this.removeClass('goToPast').html('已签到');
    		}else{
    			d_messages(data.message,2);
    			$this.removeClass('pasting');
    		}
    	});
    });
});