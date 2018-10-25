<extend name="Base/common1" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">

	<!-- 仅我的订单调用 -->
	<script type="text/javascript" src="__JS__/myOrder.js"></script>
</block>
<block name="main"> 
<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>我的订单</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">

		<!-- 订单状态导航 -->
		<ul class="orderNav">
			<li onclick="redirect('')">全部</li>
			<li onclick="redirect(0)">待付款</li>
			<li onclick="redirect(1)">待发货</li>
			<li onclick="redirect(2)">待收货</li>
			<li onClick="window.location.href='{:U('Order/comments')}'" class="click">待评价</li>
		</ul>

		<!--订单列表-->
		<div class="switchPool">
		<volist name="dataList" id="volist">
			<div class="itemBox show">
				<ul class="itemUl">
					<li>
						<a class="proDetail clearfix" href="{:U('Commodity/show/id/'.$volist['pro_id'])}">
							<dl>
								<dt><img src="__ROOT__/{$volist['picture']}" alt="pro"></dt>
								<dd class="nam">{$volist['title']}</dd>
							</dl>
							<span class="price">
								<em class="currentPrice">¥<label>
								{$volist['member_price']}</label></em>
								<em class="pastPrice">¥<label>{$volist['market_price']}</label></em>
								<em class="num">x<label>{$volist['num']}</label></em>
							</span>
						</a>
						<p class="totalInfo">合计：¥<font>{$volist['price']}</font><label>（含运费<em></em>{$volist['freight']}）</label></p>
						<div class="btnBox">
							<a class="details payNow" href="{:U('Order/toComments/id/'.$volist['id'])}">去评价</a>
						</div>
					</li>
				</ul>
			</div>
		</volist>
		<!-- 没有订单时显示 -->
		<?php if(count($dataList)<1){?>
		<div class="noOrder">
			<div class="icon">
				<i class="iconfont">&#xe66d;</i>
			</div>
			<p class="tip01">您还没有需要评论的商品</p>
		</div>
		<?php }?>
	</div>
<script type="text/javascript">
	function redirect(id){
	if(id ===''){
		window.location.href = jsObj.root+'/Home/Order/index.html';
	}else{
		window.location.href = jsObj.root+'/Home/Order/index/type/'+id+'.html';
	}
		
	}
</script>
</block>
