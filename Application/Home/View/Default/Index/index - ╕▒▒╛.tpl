<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>
<link rel="stylesheet" type="text/css" href="__STYLE__/prompt.css" />
<block name="jscript">
<script type="text/javascript" src="__JS__/jquery.scrollUp.min.js "></script>
<script type="text/javascript" src="__JS__/lefttime.js"></script>
<script type="text/javascript" src="__JS__/swiper-3.2.5.min.js"></script>

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
    <!-- 轮播 -->
	<script type="text/javascript ">
		$(function($) {
		    var mySwiper = new Swiper('.banner-first', {
		        autoplay: 4000,
		        pagination: '.banner-first-pagination'
		    });
		    var mySwiper = new Swiper('.banner-second', {
		        autoplay: 5000,
		        pagination: '.banner-second-pagination'
		    });
		    var mySwiper = new Swiper('.banner-third', {
		        autoplay: 5000,
		        pagination: '.banner-third-pagination'
		    });
		    var mySwiper = new Swiper('.recom-container', {
		        pagination: '.recom-pagination',
		        slidesPerView: 1,
		        paginationClickable: true
		    });
		    var mySwiper = new Swiper('.brand-container', {
		        pagination: '.brand-pagination',
		        slidesPerView: 1,
		        paginationClickable: true
		    });
		    var mySwiper = new Swiper('.hot-container', {
		        slidesPerView: 4,
		        paginationClickable: true,
		        nextButton: '.swiper-button-next',
		        prevButton: '.swiper-button-prev'
		    });
		    $('.goToPast').click(function(){
		    	if(jsObj.is_login==0){
		    		d_messages('您还未登录',2);
		    		window.location.href = jsObj.login_url;
		    		return fale;
		    	}
		    	var $this = $(this);
		    	if($this.hasClass('ing'))return false;
		    	$this.addClass('ing');
		    	$.post(jsObj.root+'/Index/past','',function(data){
		    		if(data.status == 1){
		    			d_messages(data.message,2);
		    		}else{
		    			d_messages(data.message,2);
		    		}
	    			$this.removeClass('ing');
		    	});
		    });
		});
	</script>
</head>

<body class="">

	<!-- 回到顶部 -->
	<div class="filter-top" id="scrollUp">
		<i class="iconfont">&#xe623;</i>
	</div>
	
	<div class="main">  
	
		<!-- 幻灯片 -->
		<div class="index-banner swiper-container banner-first">
			<div class="swiper-wrapper">
				<volist name="slideList" id="volist">
				<div class="swiper-slide">
					<a href="{$volist['link']}"><img src="__ROOT__/{$volist['picture']}"></a>
				</div>
				</volist>
			</div>
			<div class="swiper-pagination banner-first-pagination"></div>
			
			<!-- 搜索 -->
	        <section class="banner-search">
	            <div class="banner-search-con">
	            	<!-- 签到 -->
	                <div class="search-left search-text goToPast">
	                    <a href="javascript:;">
	                    	<i class="iconfont">&#xe64d;</i>
	                        <p>签到</p>
	                    </a>
	                </div>
	                <!-- 搜索 -->
	                <div class="input-text box-flex">
	                    <a class="a-search-input j-search-input" href="#open_search"></a>
	                    <i class="iconfont">&#xe652;</i>
	                    <input type="text" placeholder="商品搜索" style="background:none;">
	                </div>
	                <!-- 登录 -->
	                <div class="search-right search-text">
	                	
	                	<if condition="$_SESSION['member_auth']['id']">
		                	<a href="{:U('Member/index')}">
		                		<i class="iconfont">&#xe651;</i>
		                		<p>已登录</p>
	                		</a>
	                	<else />
		                    <a href="{:U('Login/login')}">
		                    	<i class="iconfont">&#xe651;</i>
		                        <p>登录</p>
		                    </a>
	                    </if>
	                </div>
	            </div>
	        </section><!-- 搜索 结束  -->
	        <div class="linear"></div>
		</div><!-- 幻灯片 结束   -->
		
		<!-- 菜单 -->
		<nav class="index-nav">
			<ul>
				<li>
					<a href="{:U('Commodity/clist')}">
						<i class="iconfont index-nav-icon1">&#xe6ff;</i>
						<p>全部商品</p>
					</a>
				</li>
				<li>
					<a href="{:U('Article/index',array('pid'=>15))}">
						<i class="iconfont index-nav-icon2">&#xe71d;</i>
						<p>真情讲述</p>
					</a>
				</li>
				<li>
					<a href="{:U('Integral/index')}">
						<i class="iconfont index-nav-icon3">&#xe703;</i>
						<p>积分商城</p>
					</a>
				</li>
				<li>
					<a href="{:U('Article/index',array('pid'=>16))}">
						<i class="iconfont index-nav-icon4">&#xe6dd;</i>
						<p>帮助指南</p>
					</a>
				</li>
			</ul>
		</nav>
		
		<!-- 精品礼盒 -->
		<div class="index-box">
			<!-- 标题 -->
			<div class="box-title1">
				<span>精品礼盒</span>
				<span class="text-min">送亲人，送朋友，送老师，送领导</span>
				<a href="{:U('Commodity/remand')}">更多<i class="iconfont">&#xe664;</i></a>
			</div>
			<!-- 标题 结束  -->
			
			<!-- 内容 -->
			<div class="box-con">
				<ul class="recom-list">
				<volist name="recmandList" id="vo">
					<li>
						<div class="recom-pic">
							<a href="{:U('Commodity/show',array('id'=>$vo['id']))}">
								<img src="__ROOT__/{$vo['picture']}">
							</a>
						</div>
						<div class="recom-right">
							<p class="recom-tit">
								<a href="{:U('Commodity/show',array('id'=>$vo['id']))}">
									{$vo['title']}
								</a>
							</p>
							<p class="recom-pric">
								<font>¥{$vo['member_price']}</font>
								<del>¥{$vo['market_price']}</del>
							</p>
							<div class="recom-buy">
								<span>182人关注</span>
								<a href="{:U('Commodity/show',array('id'=>$vo['id']))}">立即抢购</a>
							</div>
						</div>


						<!-- <a href="{:U('Commodity/show',array('id'=>$vo['id']))}">
							<img src="__ROOT__/{$vo['picture']}">

							<p class="recom-tag">热销</p>

							<p class="recom-name">{$vo['title']}</p>
							<p class="recom-price">
								<font style="float:left;">¥{$vo['member_price']}</font>
								<del style="float:right;">¥{$vo['market_price']}</del>
							</p>
						</a> -->
					</li>
				</volist>
				</ul>
			</div>
			<!-- 内容 结束  -->
		</div>
		<!-- 精品推荐 结束  -->


		<!--  ---------------------------添加部分开始------------------------- -->

		<!-- 必抢 -->
		<div class="mustRob">
			<i class="iconfont">&#xe6f0;</i>
			<span>限时限量 疯狂抢购</span>
			<a href="#">更多<i class="iconfont">&#xe664;</i></a>
		</div>
		<div class="mustRobCon">
			<img src="__PUBLIC__/Home/Images/mustRob.png">
			<p class="title">限时购</p>
			<p class="tip">精选商品 每天底价开抢</p>
			<ul class="list clearfix">
				<li>
					<a href="#">
						<span class="pic" style="background-image:url('__PUBLIC__/Home/Images/slipper_.png')"></span>
						<div class="shutDownTm">
							<!--倒计时-->
                            <div class="colockbox" id="colockbox1">
                                <!-- <span class="day">00</span><em>天</em> -->
                                <em>仅剩：</em>
                                <span class="hour">00</span>:
                                <span class="minute">00</span>:
                                <span class="second">00</span>
                            </div>
						</div>
						<p class="price_"><font>¥665.00</font><del>¥700.00</del></p>
					</a>
				</li>
				<li>
					<a href="#">
						<span class="pic" style="background-image:url('__PUBLIC__/Home/Images/slipper_.png')"></span>
						<div class="shutDownTm">
							<!--倒计时-->
                            <div class="colockbox" id="colockbox2">
                                <!-- <span class="day">00</span><em>天</em> -->
                                <em>仅剩：</em>
                                <span class="hour">00</span>:
                                <span class="minute">00</span>:
                                <span class="second">00</span>
                            </div>
						</div>
						<p class="price_"><font>¥665.00</font><del>¥700.00</del></p>
					</a>
				</li>
				<li>
					<a href="#">
						<span class="pic" style="background-image:url('__PUBLIC__/Home/Images/slipper_.png')"></span>
						<div class="shutDownTm">
							<!--倒计时-->
                            <div class="colockbox" id="colockbox3">
                                <!-- <span class="day">00</span><em>天</em> -->
                                <em>仅剩：</em>
                                <span class="hour">00</span>:
                                <span class="minute">00</span>:
                                <span class="second">00</span>
                            </div>
						</div>
						<p class="price_"><font>¥665.00</font><del>¥700.00</del></p>
					</a>
				</li>
			</ul>
		</div>

		<!--  ---------------------------添加部分结束------------------------- -->
		
		<!-- 横幅广告图 -->
		<div class="index-box">
		<if condition="$digList[0]['link']">
		<a href="{$digList[0]['link']}"><img src="__ROOT__/{$digList[0]['picture']}"></a>
		<else />
		<img src="__ROOT__/{$digList[0]['picture']}">
		</if>
			
		</div><!-- 横幅广告图 结束  -->
		

		
		<!-- 商品分类 -->
		<!-- <div class="index-box">
			<div class="box-title1">
				<span>主题精选</span>
				<span class="text-min">精选主题尽收眼底赶快行动吧</span>
				<a href="{:U('Commodity/sort')}">更多<i class="iconfont">&#xe664;</i></a>
			</div>
			
			
			<div class="box-con" style="background:none;">
				<ul class="classification">
				<volist name="categoryList" id="vo">
					<li>
						<a href="{:U('Commodity/clist',array('id'=>$vo['id']))}">
							<img src="__ROOT__/{$vo['picture']}">
						</a>
					</li>
				</volist>	
				</ul>
			</div>
		</div> -->


				<!-- 微商专区 -->
		<div class="index-box">
			<!-- 标题 -->
			<div class="box-title1">
				<span>微商专区</span>
				<span class="text-min">朋友圈优质货源，放心任购！</span>
				<a href="{:U('Commodity/clist/id/31')}">更多<i class="iconfont">&#xe664;</i></a>
			</div><!-- 标题 结束  -->
			
			<!-- 内容 -->
			<div class="box-con">
				<ul class="recom-list">
				<volist name="sealList" id="vo">
					<li style="width: 50%!important;float:left!important;">
						<a href="{:U('Commodity/show',array('id'=>$vo['id']))}">
							<img src="__ROOT__/{$vo['picture']}">
							<!--p class="recom-tag">微商</p-->
							<p class="recom-name">{$vo['title']}</p>
							<p class="recom-price">
								<font style="float:left;">¥{$vo['member_price']}</font>
								<del style="float:right; font-size:14px;">¥{$vo['market_price']}</del>
							</p>
						</a>
					</li>
				</volist>
				</ul>
			</div><!-- 内容 结束  -->
		</div><!-- 微商专区 结束  -->
		
		<!-- 横幅广告图 -->
		<div class="index-box">
			<if condition="$digList[1]['link']">
				<a href="{$digList[1]['link']}"><img src="__ROOT__/{$digList[1]['picture']}"></a>
				<else />
				<img src="__ROOT__/{$digList[1]['picture']}">
			</if>
		</div>
		
		<volist name="categoryList" id="volist">
			{// 列表开始 }
			<div class="index-box">
				{// 一级分类图片 开始 }
	            <div class="district">
	            	<a href="{:U('Commodity/clist',array('id'=>$volist['id']))}" title="{$volist['title']}">
	                	<img src="__ROOT__/{$volist['picture']}" alt="{$volist['title']}"/>
	                </a>
	            </div>
				{// 一级分类图片 结束 }
				{// 内容 }
				<div class="box-con">
					<ul class="recom-list recom-list2">
					<volist name="volist['list']" id="sublist">
						<li>
							<a href="{:U('Commodity/show',array('id'=>$sublist['id']))}" title="{$sublist['title']}">
								<img src="__ROOT__/{$sublist['picture']}" alt="{$sublist['title']}">
								<p class="recom-name">{$sublist['title']}</p>
								<p class="recom-price">
									<font>￥{$sublist['member_price']}</font>
								</p>
							</a>
						</li>
					</volist>
					</ul>
				</div>
	            {// 内容结束  }
			</div>
	        {// 列表结束  }
        </volist>

		<!-- 最新商品 -->
		<!-- <div class="index-box">
			<div class="box-title2">
				<span>最新商品</span>
			</div>
			
			<section class="product-list j-product-list product-list-medium">
				<ul>
				<volist name="newList" id="vo">
					<if condition="$key%2 == 0">
						<li>
		                	<div class="product-div">
		                    	<a href="{:U('Commodity/show',array('id'=>$vo['id']))}" class="product-div-link"></a>
		                        <img src="__ROOT__/{$vo['picture']}" class="product-list-img">
		                        <div class="product-text">
		                        	<h4>{$vo['title']}</h4>
		                            <p class="p-price">
										<font style="float:left;">¥{$vo['member_price']}</font>
										<del style="float:right; font-size:14px;">¥{$vo['market_price']}</del>
									</p>
		                        </div>
		                    </div>
						</li>
					</if>
				</volist>	
				</ul>
				<ul>
				<volist name="newList" id="vo">
					<if condition="$key%2 == 1">
						<li>
	                    	<div class="product-div">
	                        	<a href="{:U('Commodity/show',array('id'=>$vo['id']))}" class="product-div-link"></a>
	                            <img src="__ROOT__/{$vo['picture']}" class="product-list-img">
	                            <div class="product-text">
	                            	<h4>{$vo['title']}</h4>
	                                <p class="p-price">
										<font style="float:left;">¥{$vo['member_price']}</font>
										<del style="float:right; font-size:14px;">¥{$vo['market_price']}</del>
									</p>
	                            </div>
	                        </div>
						</li>
					</if>
				</volist>	
				</ul>
			</section>
		</div> -->
	</div>
</block>