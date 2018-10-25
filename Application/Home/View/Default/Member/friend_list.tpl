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
		<a href="__ROOT__/"><i class="iconfont">&#xe621;</i></a>
	</header>

	<!-- 主题内容 -->
	<div class="main">
		<section class="user-wallet-detail">
			<div class="fans-bar">
				<if condition="$total neq 0">
				<i class="iconfont">&#xe6d2;</i>
				<span>亲，你的社圈已经达到{$total}人！</span>
				</if>
			</div>
			<if condition="$onelist neq 0">
			<ul>

				<li class="dis-box">
					<span class="box-flex distribution-level">大当家</span>
					<span class="distribution-num">{$onelist}人</span>
				</li>
				<if condition="$twolist neq 0">
				<li class="dis-box">
					<span class="box-flex distribution-level">二当家</span>
					<span class="distribution-num">{$twolist}人</span>
				</li>
				</if>
				<if condition="$threelist neq 0">
				<li class="dis-box">
					<span class="box-flex distribution-level">三当家</span>
					<span class="distribution-num">{$threelist}人</span>
				</li>
				</if>
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