<extend name="Base/common1" />

{// css样式区 }
<block name="link">
	<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
	<style type="text/css">
	.login_get_integral
	{width:100%;height:auto;overflow:hidden;text-align:center;padding:30px 0px;}
	.login_get_integral a
	{width:30%;height:30px;line-height:30px;display:inline-block;font-size:1.5rem;color:#fff;background:#ec5151;
	 border-radius:15px;}
	</style>
</block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/member_sign.js"></script>
</block>
<block name="main">

<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>积分商城</h3>
        <a href="__ROOT__/"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		<if condition="$isLogin">
			<!-- 积分余额 签到 -->
			<section class="integral-head">
				<div class="dis-box">
					<div class="integral-head-img">
					<if condition="$member['face'] eq ''">
						<img src="__IMAGES__/head.jpg">
					<else />
						<img src="__ROOT__/{$member['face']}">
					</if>
						
					</div>
					<div class="integral-head-num box-flex">
						<h3>{$member['integral']}<small>积分</small></h3>
						<p>累计获得{$member['integral']+$member['use_integral']}积分</p>
					</div>
					<div class="integral-head-sign">
						<if condition="$isPastOK">
							<a href="javascript:void(0);">已签到</a>
						<else />
							<a href="javascript:void(0);" class="goToPast">今日签到+{$integral_rule_past}</a>
						</if>
					</div>
				</div>
			</section>
		<else />
			<div class="login_get_integral">
				<a href="{:U('Login/login')}">登录领取积分</a>
			</div>
		</if>
		
		<!-- 菜单 -->
		<section class="integral-nav">
			<ul>
				<li><a href="{:U('detail')}">
					<i class="iconfont">&#xe6d0;</i>
					<p>积分明细</p>
				</a></li>
				<li><a href="{:U('recode')}">
					<i class="iconfont">&#xe6d1;</i>
					<p>兑换记录</p>
				</a></li>
				<li><a href="{:U('integral_intro')}">
					<i class="iconfont">&#xe6d4;</i>
					<p>积分规则</p>
				</a></li>
			</ul>
		</section>
		
		<!-- 积分商品 -->
		<section class="integral-pro">
			<div class="integral-pro-tit">积分兑好礼</div>
			
			<div class="integral-pro-list">
				<ul>
				<volist name="goodslist" id="vo">
					<li><a href="{:U('show',array('id'=>$vo['id']))}">
						<img src="__ROOT__/{$vo.picture}" class="integral-pro-img">
						<h4 class="integral-pro-name">{$vo.title}</h4>
						<p class="integral-pro-price"><i class="iconfont">&#xe692;</i>{$vo.integral}</p>
					</a></li>
				</volist>
				</ul>
			</div>
		</section>
		
		
	</div>

</block>
