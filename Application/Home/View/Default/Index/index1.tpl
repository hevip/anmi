<extend name="Base/common" />

{// css样式区 }
<block name="link">
    <link rel="stylesheet" href="__STYLE__/flickity-docs.css" media="screen" />
</block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/index.js"></script>
</block>

<block name="main">    
	<!--header-->
	<div id="home-header">
	    <div id="dingdan">
	        <!-- toolbar-->
	        <div class="dingdan_tol">
	            <ul>
                	<!--li class="dingdan_logo" style="width:50%;">
                    	<img src="__IMAGES__/logo.png" alt="" width="auto" height="80%" style="margin-top:2%;" />
                    </li-->
	                <li class="dingdan_logo" style="width:50%; color:#fff; font-size:18px;">{$config['company']}</li>
	                <li class="li_a_col" style="text-align: right; width:50%;">
					<if condition="$user">
						<a href="{:U('Member/index')}">已登录</a>
					<else />
						<a href="{:U('Login/login')}" ><i class="iconfont">&#xe604</i></a>
						<!--a href="{:U('Login/register')}" style="background:rgba(255,255,255,0.3); padding:5px 15px; margin-left:10px;">注册</a-->
					</if>
					</li>
	            </ul>
	        </div>
	    </div>
	    <!-- lunbo-->
	    <div class="hero-gallery js-flickity swipe" id="mySwipe" style="margin:0 auto;">
	    	<div class="swipe-wrap">
	    		<volist name="slideList" id="volist">
					<div class="hero-gallery__cell hero-gallery__cell--{$key}">
						<a href="{$volist['link']}" title="{$volist['title']}" target="_blank">
							<img src="__ROOT__/{$volist['picture']}" alt="{$volist['title']}" width="100%" />
						</a>
					</div>
				</volist>
			</div>
	    </div>

		<script type="text/javascript" src="__JS__/swipe.min.js"></script>
		<script type="text/javascript">
		    var elem = document.getElementById('mySwipe');
		    window.mySwipe = Swipe(elem, {
		        startSlide: 0,
		        auto: 3000,
		        continuous: true,
		        disableScroll: true,
		        stopPropagation: true,
		        callback: function (index, element) { },
		        transitionEnd: function (index, element) { }
		    });
		</script>
		<!--online-->
	    <div class="h_online">

		<div class="h_on_3">
		    <form class="product_search" action="###">
			<p>
			    <input placeholder="请输入关键词" type="text"/>
			    <span><img src="__IMAGES__/icon111.png" alt=""></span>
			</p>
		    </form>
		</div>
	    </div>

	    <!-- 导航菜单 -->
        <div class="home_nav">
            <ul>
                <li>
					<a href="{:U('Article/show',array('theId'=>9))}"><i class="iconfont">&#xe650;</i></a>
					<div>关于我们</div>
				</li>
                <li>
					<a href="{:U('Article/show',array('theId'=>10))}"><i class="iconfont">&#xe64b;</i></a>
					<div>联系我们</div>
				</li>
                <li>
					<a href="{:U('Article/show',array('theId'=>11))}"><i class="iconfont">&#xe64c;</i></a>
					<div>会员须知</div>
				</li>
                <li>
					<a href="{:U('Article/show',array('theId'=>12))}"><i class="iconfont">&#xe651;</i></a>
					<div>购物指南</div>
				</li>
                <li>
					<a href="{:U('Article/index',array('theId'=>181))}"><i class="iconfont">&#xe645;</i></a>
					<div>新闻动态</div>
				</li>
            </ul>
        </div>
	</div>
	
	<!-- 面对面支付 --> 
	<div class="face_pay">
    	<a href="{:U('FacePay/add')}"><img src="__IMAGES__/img0123.jpg" alt="当面支付"></a>
    </div>

    <!-- gray-->

	<!--home content-->
	<div id="home_content">
	{// 首页产品类别列表循环开始}
	<volist name="commodityList" id="volist">
	    <div class="h_con_com">
	        <div class="h_con_tol">
	            <p>
			<em></em>
	                <a class="h_a_size" href="{:U('Commodity/clist/id/'.$volist['id'])}">{$volist['title']}</a>
	                <a class="h_move_a" href="{:U('Commodity/clist/id/'.$volist['id'])}">+MORE</a>
	            </p>
	        </div>
	        <!-- home show img-->
	        <div class="h_con_show">
	        {// 首页产品列表循环开始}
			<volist name="volist['list']" id="sublist">
	            <if condition="$key eq 0 || $key eq 2 || $key eq 4" >
					<div class="h-con-show-t">
	            <elseif condition="$key eq 1 || $key eq 3 || $key eq 5" />
					<div class="h-con-show-th">
				</if>
					<a href="{:U('Commodity/show/id/'.$sublist['id'])}" title="{$sublist['title']}">
						<img class="img-responsive" src="__ROOT__/{$sublist['picture']}" alt="{$sublist['title']}" />
					</a>
                    <p class="index_pro_tit">{$sublist['title']}</p>
					<p class="index_pro_price">
						<span>￥{$sublist['member_price']}</span>
						<del>￥{$sublist['market_price']}</del>
					</p>
				</div>
			</volist>
	        {// 首页产品列表循环结束}
	        </div>
	    </div>
	</volist>
	{// 首页产品类别列表循环结束}
	</div>
</block>