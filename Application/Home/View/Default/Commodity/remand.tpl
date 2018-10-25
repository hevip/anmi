<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>
<link rel="stylesheet" type="text/css" href="__STYLE__/prompt.css" />
<block name="jscript">
<script type="text/javascript" src="__JS__/jquery.scrollUp.min.js "></script>
<script type="text/javascript" src="__JS__/lefttime.js"></script>
<script type="text/javascript" src="__JS__/swiper-3.2.5.min.js"></script>
</block>

<block name="main"> 	
    <!-- 倒计时 -->
    <script type="text/javascript">
        var gmt_end_time = 1513295040;
        var day = '<em class="color-whie hour">';
        var hour = '</em> : <em class="color-whie mini">';
        var minute = '</em> : <em class="color-whie sec">';
        var second = '</em>';
        var end = '';
        onload = function(){
            try {onload_leftTime();}
            catch (e) {}
        }
    </script>
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
		    			$this.removeClass('ing');
		    		}
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
	                    <a href="###">
	                    	<i class="iconfont">&#xe64d;</i>
	                        <p>签到</p>
	                    </a>
	                </div>
	                <!-- 搜索 -->
	                <div class="input-text box-flex">
	                    <a class="a-search-input j-search-input" href="#open_search"></a>
	                    <i class="iconfont">&#xe652;</i>
	                    <input type="text" placeholder="商品搜索">
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
	<volist name="dataList" id="v">
		<div class="index-box">
			<div class="box-title1">
				<span>{$v.title}</span>
				<a href="{:U('Commodity/clist/id/'.$v['id'])}">更多<i class="iconfont">&#xe664;</i></a>
			</div><!-- 标题 结束  -->
			
			<div class="box-con">
				<ul class="recom-list">
				<volist name="v.children" id="vo">
					<li>
						<a href="{:U('Commodity/show',array('id'=>$vo['id']))}">
							<img src="__ROOT__/{$vo['picture']}">
							<p class="recom-tag">精品</p>
							<p class="recom-name">{$vo['title']}</p>
							<p class="recom-price">
                                <font style="float:left;">¥{$vo['member_price']}</font>
                                <del style="float:right;">¥{$vo['market_price']}</del>
                            </p>
						</a>
					</li>
				</volist>
				</ul>
			</div><!-- 内容 结束  -->
			
		</div><!-- 预售专区 结束  --> 
		</volist>
	</div>
</block>