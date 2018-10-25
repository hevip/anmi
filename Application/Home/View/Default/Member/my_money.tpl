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
        <h3>我的钱包</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		
		<section class="purse-header-box">
			<p>可用余额（元）</p>
			<h2>{$member['money']}</h2>
		</section>
		
		<section class="my-nav-box">
			<a href="{:U('recharge')}" class="dis-box">
				<h3 class="box-flex text-all-span my-u-title-size"><i class="iconfont blue">&#xe6b6;</i>我要充值</h3>
				<span class="t-jiantou"><i class="iconfont icon-jiantou jian-top">&#xe664;</i></span>
			</a>
			<a href="javascript:;" class="dis-box moneyPass">
				<h3 class="box-flex text-all-span my-u-title-size"><i class="iconfont red">&#xe6bf;</i>密码管理</h3>
				<span class="t-jiantou"><i class="iconfont icon-jiantou jian-top">&#xe664;</i></span>
			</a>
			<a href="{:U('money_show')}" class="dis-box">
				<h3 class="box-flex text-all-span my-u-title-size"><i class="iconfont yellow">&#xe6c1;</i>账户明细</h3>
				<span class="t-jiantou"><i class="iconfont icon-jiantou jian-top">&#xe664;</i></span>
			</a>
			<a href="{:U('money_intro')}" class="dis-box">
				<h3 class="box-flex text-all-span my-u-title-size"><i class="iconfont green">&#xe6c0;</i>使用说明</h3>
				<span class="t-jiantou"><i class="iconfont icon-jiantou jian-top">&#xe664;</i></span>
			</a>
		</section>
		
	</div>
<script type="text/javascript" src="__JS__/layer.js"></script>
<script type="text/javascript">
$(function() {
	$('.moneyPass').click(function(){
		var member = '{$member['username']}';
		var oldHref = '{:U('money_pass')}';
		var newHref = '{:U('phone_bind')}';
		if(member){
			window.location.href = oldHref;
		}else{
			d_messages('您还未绑定手机号码',2);
			window.location.href = newHref;
		}
	});
})
</script>	

</block>
