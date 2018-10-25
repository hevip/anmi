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
        <h3>交易记录</h3>
        <a href="__ROOT__/"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		<section class="user-wallet-detail">
		<if condition="$dataList|count gt 0">
			<ul>
			<volist name="dataList" id="vo">
				<li class="dis-box">
					<div class="record-img">
						<img src="__ROOT__/{$vo['face']}">
					</div>
					<div class="record-tit box-flex">
						<h3>{$vo['member']}-消费订单金额{$vo['orderprice']}</h3>
						<p>{$vo['showStr']}</p>
					</div>
					<div class="record-in">
						<h3>收入{$vo['my_price']}</h3>
						<p>{$vo['create_time']|date="Y-m-d H:i:s",###}</p>
					</div>
				</li>
			</volist>
			</ul>
			<else/>
			<!-- 没有数据的样式 -->
			<div class="no-div-message">
				<i class="iconfont icon-biaoqingleiben">&#xe676;</i>
				<p>亲，什么都没有哦～！</p>
			</div>
			</if>
		</section>
	</div>

</block>
