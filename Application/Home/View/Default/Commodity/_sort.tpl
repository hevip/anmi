<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/jquery.scrollUp.min.js "></script>
</block>

<block name="main">

<body class="">
    <!-- 主题内容 -->
	<div class="main">
		<div class="category-top blur-div">
			<!-- 头部 -->
			<header class="header-menu dis-box">
				<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
				<h3>全部分类</h3>
				<a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
			</header>
		</div>
		<aside>
			<div class="menu-left" id="sidebar">
				<div class="swiper-scroll swiper-container-vertical swiper-container-free-mode">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<!-- 一级分类 -->
							<ul>
							<volist name="sortList" id="vo">
								<li <if condition="$key eq 0">class="active"</if> data="" data-id="{$key}">{$vo['title']}</li>
							</volist>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</aside>
		
		<section class="menu-right" style="padding:1.3rem;">
			<!-- loading -->
			<div class="loading" style="display: none;">
				<img src="__IMAGES__/loading.gif">
			</div>
			
			<!-- 右侧分类 -->
			<ul class="child_category">
				<volist name="sortList.0.children" id="v">
				<a href="{:U('Commodity/clist',array('id'=>$v['id']))}"><h5>{$v['title']}</h5></a>
				<ul>
				<volist name="v.children" id="vo">
					<li class="w-3"><a href="{:U('Commodity/clist',array('id'=>$vo['id']))}"></a><img src="__ROOT__/{$vo['picture']}" alt=""><span>{$vo['title']}</span></li>
				</volist>
				</ul>
				</volist>
			</ul>

			
			
			
		</section>
	</div>
 <!-- 仅商品分类调用 -->
<script type="text/javascript">
$(function(){
    var cat_id = 0;
    ajaxAction($("#sidebar li:first"), $("#sidebar li:first").attr("data"), $("#sidebar li:first").attr("data-id"));
    $("#sidebar li").click(function(){
        var li = $(this);
        var url = $(this).attr("data");
        var id = $(this).attr("data-id");
        var dataList = <?php echo json_encode($sortList);?>;
     	//var obj = jQuery.parseJSON(dataList);
     	var thisList = dataList[id];
     	var str = '';
		$.each(thisList['children'],function(i,v){
			str += '<a href="'+jsObj.root+'/Commodity/clist/id/'+v["id"]+'.html"><h5>'+v["title"]+'</h5></a><ul>';
     		str +='<ul>';
     		$.each(v['children'],function(i,vo){
     			if(!vo.picture){
     				vo.picture = 'Public/Home/Images/default.png';
     			}
     			str +='<li class="w-3"><a href="'+jsObj.root+'/Commodity/clist/id/'+vo["id"]+'.html"></a><img src="'+jsObj.root+'/'+vo.picture+'" alt=""><span>'+vo.title+'</span></li>';
     		});
     		str +='</ul>';
     	});
     	$('.child_category').html(str);
    });
    function ajaxAction(obj, url, id){
        if(cat_id != id){
            $.ajax({
                type: 'get',
                url: url,
                data: '',
                cache: true,
                async: false,
                dataType: 'json',
                beforeSend: function(){
                    $(".loading").show();
                },
                success: function(result){
                    if(typeof(result.code) == 'undefined'){
                        $(".child_category").animate({
                            scrollTop: 0
                        }, 0);
                        template.config('openTag', '<%');
                        template.config('closeTag', '%>');
                        var html = template('category', result);
                        $(".child_category").html(html);
                        //$(".child_category ul").html(result);
                        obj.addClass("active").siblings("li").removeClass("active");
                    }
                    else{
                        d_messages(result.message);
                    }
                },
                complete: function(){
                    $(".loading").hide();
                }
            });
            cat_id = id;
        }
    }
})
</script>
</block>