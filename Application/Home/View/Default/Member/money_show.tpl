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
        <h3>钱包明细</h3>
        <a href="__ROOT__/"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		<section class="user-wallet-detail">
		<if condition="$dataList|count gt 0">
			<ul>
			<volist name="dataList" id="volist">
				<li>
					<div>
						<h3 class="fl detail-title">
							{$volist['type_name']}
						</h3>
						<if condition="$volist['price'] gt 0">
							<span class="fr detail-money green">+{$volist['price']}元</span>
						<else />
							<span class="fr detail-money yellow">{$volist['price']}元</span>
						</if>
					</div>
					<div>
						<span class="fl detail-time">
							{$volist['create_time']|date="Y-m-d H:i:s",###}
						</span>
						<span class="fr detail-way">
							余额：{$volist['balance']}
						</span>
					</div>
				</li>
			</volist>	
			</ul>
			<else />
				<div class="no-div-message">
					<i class="iconfont icon-biaoqingleiben">&#xe676;</i>
					<p>亲，什么都没有哦～！</p>
				</div>
			</if>
		</section>
	</div>
</block>
