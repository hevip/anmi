<extend name="Base/common1" />

{// css样式区 }
<block name="link">

<style type="text/css">

	#mustRob{
	width: 100%;
    box-sizing: border-box;
    overflow: hidden;
    background: #FEBCBC;
    padding: 1rem;
    display:none;
	}
	#mustRob > i{
		font-size: 2rem;
		color: #E90327;
		vertical-align: middle;
	}
	#mustRob > span{
		font-size: 1.4rem;
		color: #777;
		vertical-align: middle;	
	}
	#mustRob .colockbox{
	float: right;
    /*width: 100%;*/
    height: 2.2rem;
    overflow: hidden;
    /*margin-top: 10px;*/
    color: #333;
	}
	#mustRob .colockbox >em{
	    font-style: normal;
	    font-size: 1.2rem;
	    color: #333;
	    /*margin-left: 2px;*/
	}
	#mustRob .colockbox>span{
		display: inline-block;
	    vertical-align: middle;
	    height: 1.4rem;
	    width: 1.4rem;
	    text-align: center;
	    line-height: 1.4rem;
	    color: #FFF;
	    /* border-radius: 3px; */
	    background: #000;
	    font-size: 1rem;
	}
	#mustRob .colockbox>span.hour{
		margin-left: -6px;
	}

</style>

</block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/swiper-3.2.5.min.js"></script>
	<script type="text/javascript" src="__JS__/jquery.json.js"></script>
	<script type="text/javascript" src="__JS__/xiangqing.js"></script>

	<script type="text/javascript">
	$(function(){
	    /*倒计时*/
	    countDown("2016/11/11 10:00:00","#colockbox1");
	    countDown("2016/11/11 09:00:00","#colockbox2");
	    countDown("2016/11/11 08:00:00","#colockbox3");
	});

	function countDown(time,id){
	    var day_elem = $(id).find('.day');
	    var hour_elem = $(id).find('.hour');
	    var minute_elem = $(id).find('.minute');
	    var second_elem = $(id).find('.second');
	    var end_time = new Date(time).getTime(),//月份是实际月份-1
	        sys_second = (end_time-new Date().getTime())/1000;
	    var timer = setInterval(function(){
	        if (sys_second > 1) {
	            sys_second -= 1;
	            var day = Math.floor((sys_second / 3600) / 24);
	            var hour = Math.floor((sys_second / 3600) % 24);
	            var minute = Math.floor((sys_second / 60) % 60);
	            var second = Math.floor(sys_second % 60);
	            day_elem && $(day_elem).text(day);//计算天
	            $(hour_elem).text(hour<10?"0"+hour:hour);//计算小时
	            $(minute_elem).text(minute<10?"0"+minute:minute);//计算分钟
	            $(second_elem).text(second<10?"0"+second:second);//计算秒杀
	        } else {
	            clearInterval(timer);
	        }
	    }, 1000);
	}
</script>

</block>

<block name="main">

<body class="">
	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>商品详情</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>
    
    <!-- 主题内容 -->
	<div class="main">
			<!-- 商品相册 -->
			<div class="goods-photo j-show-goods-img">
				<span class="goods-num" id="goods-num">
					<span id="g-active-num">1</span>/<span id="g-all-num">1</span>
				</span>
				<ul class="swiper-wrapper">
				<volist name="figureList" id="vo">
					<li class="swiper-slide tb-lr-center"><img src="__ROOT__/{$vo['picture']}"></li>
				</volist>
				</ul>
				<div class="swiper-pagination"></div>
			</div>

			<!-- ---------------------------必抢倒计时---------------------------------------------- -->

			<div id="mustRob">
				<i class="iconfont">&#xe6f0;</i>
				<span>疯狂抢购中</span>
				<!--倒计时-->
				<div class="colockbox" id="colockbox1">
					<!-- <span class="day">00</span><em>天</em> -->
					<em>仅剩：</em>
					<span class="hour">00</span>:
					<span class="minute">00</span>:
					<span class="second">00</span>
				</div>
			</div>

			<!-- ---------------------------必抢倒计时---------------------------------------------- -->


			
			<!-- 商品标题 -->
			<div class="goods-title">
				<span class="name box-flex">{$dataInfo['title']}</span>
				<span class="heart j-heart collection" data-id="{$dataInfo['id']}" id="ECS_COLLECT">
					<i class="iconfont">&#xe615;</i>
				<em style=" font-size: 1.2rem;"><if condition="$collect">已收藏<else />未收藏</if></em>
				</span>
			</div>
			
			<!-- 商品价格 -->
			<div class="goods-price">
				<p class="p-price">
					<span id="ECS_SHOPPRICE">¥{$dataInfo['member_price']}</span>
					<em class="em-promotion">{$dataInfo['discount']}折</em>
				</p>
				<p class="p-market">
					市场价格：
					<del id="ECS_MARKETPRICE">¥{$dataInfo['market_price']}</del>
				</p>
				<p class="g-p-tthree dis-box">
					<span class="text-left box-flex">销量{$dataInfo['sale_volume']}</span>
					<span class="text-center box-flex">库存{$dataInfo['stock']}</span>
				</p>
			</div>
			
			<!-- 运费信息 -->
			<div class="goods-attr">
				<div class="dis-box">
					<label class="t-remark g-t-temark">运费信息</label>
					<span class="box-flex t-goods1"><if condition="$dataInfo['freight'] gt 0">{$dataInfo['freight']}<else />包邮</if></span>
				</div>
			</div>
			
			<!-- 数量选择 -->
			<div class="goods-attr j-goods-attr j-show-div">
				<div class="dis-box">
					<label class="t-remark g-t-temark">已选</label>
					<span class="box-flex t-goods1">1个</span>
					<span class="t-jiantou"><i class="iconfont">&#xe664;</i></span>
				</div>
				<div class="mask-filter-div"></div>
				
				<!--商品属性弹出层star-->
				<div class="show-goods-attr j-filter-show-div ts-3">
					<form action="{:U('Cart/goBuyNow')}" method="post" class="box-flex">
						<section class="s-g-attr-title product-list-small">
							<div class="product-div">
								<img class="product-list-img" src="__ROOT__/{$dataInfo['picture']}">
								<div class="product-text">
									<div class="dis-box" style="position:relative;">
										<h4 class="box-flex">{$dataInfo['title']}</h4>
										<i class="iconfont icon-guanbi1 show-div-guanbi">&#xe63b;</i>
									</div>
									<p><span class="p-price t-first" id="ECS_GOODS_AMOUNT">¥<span class="buyPrice">{$dataInfo['member_price']}</span></span></p>
									<p class="dis-box p-t-remark"><span class="box-flex buyStock" stock="{$dataInfo['stock']}">库存:{$dataInfo['stock']}</span></p>
								</div>
							</div>	
						</section>
						
						<section class="s-g-attr-con swiper-scroll">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<h4 class="t-remark">数量</h4>
									<div class="div-num dis-box">
										<a class="num-less" onClick="changePrice('1')"></a>
										<input class="box-flex buyNumber" type="text" value="1" onblur="changePrice('2')" name="num" id="goods_number" />
										<a class="num-plus" onClick="changePrice('3')"></a>
									</div>
								</div>
							</div>
							<div class="swiper-scrollbar"></div>
						</section>
						
						<section class="ect-button-more dis-box">
							<a class="btn-cart box-flex add-to-cart" href="javascript:;" onclick="ShopCart.addCart({$dataInfo['id']})" >加入购物车</a>
									<input name="id" type="hidden" value="{$dataInfo['id']}">
									<input name="price" type="hidden" value="{$dataInfo['member_price']}">
									<input class="btn-submit box-flex add-to-cart" type="submit" value="立即购买" >
						</section>
					</form>	
				</div>
			</div>
			
			<!-- 用户评价 -->
			<div class="goods-evaluation">
				<a href="{:U('CommodityComment/index',array('id'=>$dataInfo['id']))}">
					<div class="dis-box g-evaluation-title">
						<label class="t-remark g-t-temark">用户评价</label>
						<div class="box-flex t-goods1">
							好评率
							<em class="t-first">{$commentObj['percent']}%</em>
						</div>
						<div class="t-goods1">
							<em class="t-first">{$commentObj['count']}</em>
							<span class="t-jiantou">人评价<i class="iconfont">&#xe664;</i></span>
						</div>
					</div>
				</a>
			</div>
			
			<!-- 图文详情 -->
			<div class="goods-info">
				<div class="title">商品描述</div>
				<div class="con">
					{$dataInfo['content']}
				</div>
			</div>
		</form>
        
        <!-- 悬浮按钮 -->
		<div style="height:5.5rem; line-height:5.5rem; clear:both;"></div>
        <div class="filter-btn dis-box">
        	<a href="http://cs.ecqun.com/mobile/?id=493286&handle=talk&scheme=0" class="filter-btn-kefu filter-btn-a">
            	<i class="iconfont">&#xe658;</i>
                <em>客服</em>
            </a>
        	<a href="{:U('Cart/index')}" class="filter-btn-flow filter-btn-a">
            	<i class="iconfont">&#xe61d;</i>
                <sup class="cart-num ShopTotal">0</sup>
                <em>购物车</em>
            </a>
        	<a href="javascript:;" onclick="ShopCart.addCart({$dataInfo['id']})" class="btn-cart box-flex add-to-cart">
            	<span>加入购物车</span>
            </a>
        	<a href="javascript:;" class="btn-submit box-flex click-show-attr add-to-cart">
            	<span>立即购买</span>
            </a>
        </div>
    </div>
	
<!-- 仅商品详情调用 -->
<script type="text/javascript">
	/*商品详情相册切换*/
	var swiper = new Swiper('.goods-photo', {
	paginationClickable: true,
	onInit: function(swiper) {
		document.getElementById("g-active-num").innerHTML = swiper.activeIndex + 1;
		document.getElementById("g-all-num").innerHTML = swiper.slides.length;
	},
	onSlideChangeStart: function(swiper) {
		document.getElementById("g-active-num").innerHTML = swiper.activeIndex + 1;
	}
	});

	$(function(){
	changePrice();
	//商品详情属性弹出层
	$(".click-show-attr").click(function(){
		$(".show-goods-attr").addClass("show");
		$(".mask-filter-div").addClass("show");
	});
	})
	/**
	* 点选可选属性或改变数量时修改商品价格的函数
	*/
	function changePrice(type)
	{
	var max_number = -1;
	var min_number = 1;
	var qty = $("#goods_number").val();
	var buyStock = $(".buyStock").attr('stock');
	if(type == 1){
		if(qty > min_number){
			qty--;
		}
	}
	if(type == 3){
		/*if(max_number == -1){
			max_number = $(".goods_attr_num").html() ? parseInt($(".goods_attr_num").html()) : 1;
		}
		if(qty <= max_number){
			qty++;
		}*/
		qty ++;
		if ( qty > buyStock ) {
			d_messages('库存不足！',2);
			qty --;
		}
		
	}
	$("#goods_number").val(qty);
	}
</script>
	<script type="text/javascript" src="__JS__/shopping.js"></script>
</block>