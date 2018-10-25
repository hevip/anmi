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
        <h3>积分明细</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		<section class="user-wallet-detail">
		<if condition="$dataList|count gt 0">
			<ul>
			<volist name="dataList" id="vo">
				<li>
					<div class="wallet-detail-div">
                        <h3 class="fl detail-title">
                        <if condition="$vo.order_id eq 0">
                       		{$vo.type_name}
                       	<else />
                       		订单{$vo.order_name}
                       	</if>
                        </h3>
                        <if condition="$vo.integral gt 0">
							<span class="fr detail-money green">
								<i class="iconfont">&#xe692;</i>+{$vo['integral']}
							</span>
						<else />
							<span class="fr detail-money yellow">
								<i class="iconfont">&#xe692;</i>{$vo['integral']}
							</span>
						</if>
					</div>
					<div class="wallet-detail-div">
						<span class="fl detail-way">{$vo['create_time']|date="Y-m-d H:i:s",###}</span>
						<span class="fr detail-time">{$vo['type_name']}</span>
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
