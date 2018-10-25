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
			<li onclick="redirect('')" <if condition="$_GET['type'] == ''">class="click"</if>>全部</li>
			<li onclick="redirect(0)" <if condition="$_GET['type'] == '0'">class="click"</if> >待付款</li>
			<li onclick="redirect(1)" <if condition="$_GET['type'] == '1'">class="click"</if> >待发货</li>
			<li onclick="redirect(2)" <if condition="$_GET['type'] == '2'">class="click"</if> >待收货</li>
			<li onClick="window.location.href='{:U('Order/comments')}'">待评价</li>
		</ul>

		<!--订单列表-->
		<div class="switchPool">
		<volist name="dataList" id="volist">
			<div class="itemBox show">
				<ul class="itemUl">
					<!-- 待付款 -->
					<volist name="volist['list']" id="list">
					<li>
						<div class="orderNum">
							<span class="num">订单编号：<em>{$list['order_id']}</em></span>
							<label class="state"></label>
						</div>
						<a class="proDetail clearfix" href="{:U('Commodity/show/id/'.$list['pro_id'])}">
							<dl>
								<dt><img src="__ROOT__/{$list['info']['picture']}" alt="pro"></dt>
								<dd class="nam">{$list['info']['title']}</dd>
							</dl>
							<span class="price">
								<em class="currentPrice">¥<label>
								{$list['info']['member_price']}</label></em>
								<em class="pastPrice">¥<label>{$list['info']['market_price']}</label></em>
								<em class="num">x<label>{$list['num']}</label></em>
							</span>
						</a>
						<div class="complete">
							<if condition="$list['is_send'] == 2">
								<i class="iconfont">&#xe678;</i>
							</if>
						</div>
						<input name="order_id" value="{$list['id']}" type="hidden" />
						<p class="totalInfo">合计：¥<font>{$list['total_money']}</font><label>（含运费<em></em>{$list['freight']}）</label></p>
						<div class="btnBox">
							<if condition="$volist['is_pay'] == '0'">
								<a class="payNow" href="{:U('Cart/payment/id/'.$volist['id'])}">立即支付</a>
								<a class="delete" rel="{$volist['id']}" href="javascript:;">删除订单</a>
							<else/>
								<if condition="$list['is_send'] == 1">
									<a class="ensureGet" href="javascript:;">确认收货</a>
								</if>
								<if condition="$list['is_send'] gt 0">
									<a class="" href="{:U('Order/track/id/'.$list['id'])}">物流查询</a>
								</if>
							</if>
							<a class="details" href="{:U('Order/show/id/'.$volist['id'])}">订单详情</a>
						</div>
					</li>
					</volist>
				</ul>
			</div>
			</volist>
		<!-- 没有订单时显示 -->
		<?php if(count($dataList)<1){?>
		<div class="noOrder">
			<div class="icon">
				<i class="iconfont">&#xe66d;</i>
			</div>
			<p class="tip01">您还没有相关订单</p>
			<p class="tip02">可以去看看有哪些想买的</p>
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
