	
	var obj = {pid:0,page:1};
	var isEnd = false;
	//运行AJAX
    function goAjax(){
    	var pid = $('.pid').val();
    	obj.pid = pid;
    	if(isEnd){
    		return false;
    	}
    	$.get(jsObj.root+'/Article/ajaxIndex',obj,function(data){
    		if(!data==''){
    			if(obj.page>1){
    				//加载页面,直接在ui添加
    				$('#product_ul').append(data);
    			}else{
    				//覆盖
    				$('#product_ul').html(data);
    			}
    			
    		}else{
    			isEnd =  true;
    			if(obj.page > 1){
    				showEmpty();
    			}else{
    				$('#product_ul').html('占无信息');
    			}

    		}
    		
    	});
    }  
	$(window).scroll(function(){
		// 当滚动到最底部以上n像素时， 加载新内容  
	   if ($(document).scrollTop() >= $(document).height() - $(window).height()) { 			
			obj.page = obj.page+1;
			goAjax();					  
		} 
	   if( $(this).scrollTop() >600)
		    {
				$("#top").show();
			}
			if( $(this).scrollTop() <600)
			{
				$("#top").hide();
			}
	});					 
    function showEmpty() {
                $(".nodata").show().html("没有更多了");
        }
	function pageScroll(){ 
			window.scrollBy(0,-100); 
		    scrolldelay = setTimeout('pageScroll()',30); 
			var sTop=document.documentElement.scrollTop+document.body.scrollTop; 			
			if(sTop==0) clearTimeout(scrolldelay); 
		} 
