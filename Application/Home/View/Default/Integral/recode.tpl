<extend name="Base/common1" />

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
        <h3>兑换记录</h3>
        <a href="__ROOT__/"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		<section class="integral-order-list">
		<if condition="$dataList|count gt 0">
			<ul>
			<volist name="dataList" id="vo">
				<li>
					<div class="order-list-div">
						<img class="product-list-img" src="__ROOT__/{$vo['picture']}">
						<div class="product-text">
							<h4>{$vo['showtitle']}</h4>
							<p>订单编号：{$vo['order_id']}</p>
							<p>兑换时间：{$vo['add_time']|date="Y-m-d H:i:s",###}</p>
							<p class="t-first"><i class="iconfont">&#xe692;</i>{$vo['integral']}</p>
						</div>								
					</div>					  
				</li>
				</volist>				
			</ul>
			<else />
			<!-- 没有数据的样式 -->
			<div class="no-div-message">
				<i class="iconfont icon-biaoqingleiben">&#xe676;</i>
				<p>亲，什么都没有哦～！</p>
			</div>
			</if>
		</section>
	</div>

</block>
