<extend name="Base/common" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">
</block>
<block name="main"> 
<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>订单详情</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">

		<!-- 收货信息 -->
		<a class="address" href="">
			<dl>
				<dt><i class="iconfont">&#xe65f;</i></dt>
				<dd class="nam"><span>收货人：<em>{$address['nickname']}</em></span><label>{$address['tel']}</label></dd>
				<dd class="toAddress"><span>{$address['provinceString']}-{$address['cityString']}-{$address['areaString']}-{$address['intro']}</span></dd>
			</dl>
		</a>
		
		<!-- 订单商品 -->
		<div class="mainBox">
		<volist name="order.product" id="vo">
			<a class="pro" href="{:U('Commodity/show',array('id'=>$vo['id']))}">
				<dl>
					<dt><img src="__ROOT__/{$vo['picture']}" alt="pro"></dt>
					<dd class="nam">{$vo['title']}</dd>
				</dl>
				<span class="price">
					<em class="currentPrice">¥<label>{$vo['member_price']}</label></em>
					<em class="pastPrice">¥<label>{$vo['market_price']}</label></em>
					<em class="num">x<label>{$vo['num']}</label></em>
				</span>
				<p class="totalInfo">合计：¥<font>{$vo['total_money']}</font><label>（含运费<em></em>{$vo['freight']}）</label></p>
			</a>
		</volist>
		</div>
		
		<!-- 订单基本信息 -->
		<ul class="basicInfo">
			<li><span>订单编号：</span><em>{$order['order_id']}</em></li>
			<li><span>创建时间：</span><em>{$order['create_time']|date='Y-m-d H:i:s',###}</em></li>
			<li><span>支付方式：</span><em>{$order['pay_way']}</em></li>
			<if condition="$order['send_time'] neq 0">
			<li><span>付款时间：</span><em>{$order['pay_time']|date='Y-m-d H:i:s',###}</em></li>
			</if>
			<li><span>发票信息：</span><em>{$order['invoice_intro']}</em></li>
			<if condition="$order['send_time'] neq 0">
			<li><span>发货时间：</span><em>{$order['send_time']|date='H:i:s',###}</em></li>
			</if>
			<li><span>订单总额：</span><em style="color:#EC5151; font-size:1.6rem;">¥{$order['price']}</em></li>
		</ul>
		
		<!-- 操作按钮 -->
		<div style="height:5rem; line-height:5rem; clear:both;"></div>
		<div class="btnBox" style="position:fixed; bottom:0;">
			<span>待收货</span>
			<a class="ensureGet" href="#">确认收货</a>
			<a class="details" href="#">查看物流</a>
		</div>
		
	</div>
</block>
