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
        <h3>我的奖金</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		
		<section class="bonus-header-box">
			<ul>
				<li>
					<h3>{$member['reward']}</h3>
					<p>奖金余额</p>
				</li>
				<li>
					<h3>{$member['reward']+$member['use_reward']}</h3>
					<p>累计返现</p>
				</li>
				<li>
					<h3>{$count}</h3>
					<p>交易量</p>
				</li>
			</ul>
		</section>
		
		<section class="my-bonus-nav">
			<a href="{:U('goPackage')}" class="dis-box">
				<i class="iconfont">&#xe6cb;</i>
				<p>转账到钱包</p>
			</a>
			<a href="{:U('postal')}" class="dis-box">
				<i class="iconfont">&#xe6c7;</i>
				<p>申请提现</p>
			</a>
			<a href="{:U('details')}" class="dis-box">
				<i class="iconfont">&#xe6c8;</i>
				<p>查看明细</p>
			</a>
			<a href="{:U('recode')}" class="dis-box">
				<i class="iconfont">&#xe635;</i>
				<p>交易记录</p>
			</a>
			<a href="{:U('reward_intro')}" class="dis-box">
				<i class="iconfont">&#xe6c5;</i>
				<p>规则说明</p>
			</a>
			<a href="#" class="dis-box"></a>
			<a href="#" class="dis-box"></a>
			<a href="#" class="dis-box"></a>
		</section>
		
	</div>

</block>
