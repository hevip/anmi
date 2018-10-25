<extend name="Base/common" />

{// css样式区 }
<block name="link">
	<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">
</block>

<block name="main">
	<!-- 头部 -->
	<header class="header-menu dis-box">
		<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
		<h3>{$columnTitle}</h3>
		<a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
	</header>

	<!-- 主题内容 -->
	<div class="main">
		<section class="user-wallet-detail">
			<div class="fans-bar">
				<if condition="$count neq 0">
				<i class="iconfont">&#xe6d2;</i>
				<span>亲，你的直接粉丝已经达到{$count}人！</span>
				</if>
			</div>
			<if condition="$dataList neq ''">
			<ul>
				<volist name="dataList" id="volist">
				<li class="dis-box">
					<div class="record-img">
						<img src="__ROOT__/{$volist['face']}">
					</div>
					<div class="record-tit box-flex">
						<h3>昵称：{$volist['wx_name']}</h3>
						<p>幸运号：{$volist['referral_code']}</p>
					</div>
					<div class="record-in">
						<h3>等级：{$volist['levelStr']}</h3>
						<p>朋友圈<span class="green">({$volist['friend_count']})</span></p>
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