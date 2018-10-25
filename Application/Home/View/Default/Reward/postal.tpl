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
        <h3>申请提现</h3>
        <a href="__ROOT__/"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		
		<section class="my-nav-box">
			<a href="{:U('Reward/my_coins_withdraw')}" class="dis-box">
				<h3 class="box-flex text-all-span my-u-title-size"><i class="iconfont blue">&#xe646;</i>提现到银行卡</h3>
				<span class="t-jiantou"><i class="iconfont icon-jiantou jian-top">&#xe664;</i></span>
			</a>
			<a href="{:U('Reward/my_coins_wechat')}" class="dis-box">
				<h3 class="box-flex text-all-span my-u-title-size"><i class="iconfont green">&#xe6c3;</i>提现到微信</h3>
				<span class="t-jiantou"><i class="iconfont icon-jiantou jian-top">&#xe664;</i></span>
			</a>
		</section>	

	</div>

</block>
