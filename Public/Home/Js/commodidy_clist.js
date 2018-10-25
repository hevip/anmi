
	var search = $('.search').val();
	var id = $('.id').val();
	var key = $('.key').val();
	var displays = $('.display').val();
	var obj = {search:search,id:id,page:1,key:key,display:displays};
	var isEnd = false;
	var product_ul = displays == "picture" ? "#product_ul" : "#product_ul1";
	//运行AJAX
    function goAjax(){
    	if(isEnd){
    		return false;
    	}
    	$.get(jsObj.root+'/Commodity/clist',obj,function(data){
    		if(!data==''){
    			if(obj.page>1){
    				//加载页面,直接在ui添加
    				var arr = data.split('<li>');
    				$.each(arr,function(i,v){
    					if(i%2 == 0){
    						$('#product_ul_1').append('<li>'+v);
    					}else{
    						$('#product_ul_2').append('<li>'+v);
    					}
    				});
    			}else{
    				//覆盖
    				$(product_ul).html(data);
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
                $(".nodata").show().html("——没有更多宝贝了——");
        }
	function pageScroll(){ 
			window.scrollBy(0,-100); 
		    scrolldelay = setTimeout('pageScroll()',30); 
			var sTop=document.documentElement.scrollTop+document.body.scrollTop; 			
			if(sTop==0) clearTimeout(scrolldelay); 
		} 
