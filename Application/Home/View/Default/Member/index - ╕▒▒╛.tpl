<extend name="Base/common" />

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
        <h3>个人中心</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>
    
    <!-- 主题内容 -->
	<div class="main">
	
		<!-- 头像 -->
		<div class="headBox">
			<div class="headPicBox">
				<div class="innerBox">
					<if condition="$member['face'] eq ''">
					<img src="__IMAGES__/head.jpg" alt="头像" />
				    <else />
					<img src="__ROOT__/{$member['face']}" alt="头像"/>
				    </if>
				</div>
			</div>
			<p class="nickname">
					<if condition="$member['wx_name'] neq ''">
						{$member['wx_name']}
					<elseif condition="$member['nickname'] neq ''" />
						{$member['nickname']}
					<else />
						{$member['username']}
					</if>
			</p>
			<p class="introNum">
				幸运号：<span>{$member['referral_code']}</span>&nbsp;&nbsp;
                <span>等级：<font>{$data.levelStr}</font></span>
			</p>
			<ul class="twoBtn">
				<li><a href="{$config['wx_follow']}"><i class="iconfont">&#xe69d;</i><span>关注微信</span></a></li>
				<li><a href="http://downloadpkg.apicloud.com/app/download?path=http://7y3ia5.com1.z0.glb.clouddn.com/3ebc3ef7fedb607106cc8cb68b5d0f8f_d"><i class="iconfont">&#xe69e;</i><span>下载APP</span></a></li>
			</ul>
		</div>
		
		<!--  我的订单部分 -->
		<div class="myOrder">
			<a href="{:U('Order/index')}"><span>我的订单</span><i class="iconfont">&#xe664;</i><label>查看全部订单</label></a>
		</div>
		<ul class="orderItem">
			<li>
				<a href="{:U('Order/index/type/0')}">
					<span class="icon"><i class="iconfont">&#xe698;</i><if condition="$orderstatus['no_pay']"><em>{$orderstatus['no_pay']}</em></if></span>
					<label class="txt">待付款</label>
				</a>
			</li>
			<li>
				<a href="{:U('Order/index/type/1')}">
					<span class="icon"><i class="iconfont">&#xe696;</i><if condition="$orderstatus['no_send']"><em>{$orderstatus['no_send']}</em></if></span>
					<label class="txt">待发货</label>
				</a>
			</li>
			<li>
				<a href="{:U('Order/index/type/2')}">
					<span class="icon"><i class="iconfont">&#xe69a;</i><if condition="$orderstatus['is_send']"><em>{$orderstatus['is_send']}</em></if></span>
					<label class="txt">待收货</label>
				</a>
			</li>
			<li>
				<a href="{:U('Order/comments')}">
					<span class="icon"><i class="iconfont">&#xe69b;</i><if condition="$commentCount"><em>{$commentCount}</em></if></span>
					<label class="txt">待评价</label>
				</a>
			</li>
		</ul>
		
		<!-- 必备工具 -->
		<p class="toolTxt">必备工具</p>
		<ul class="necessaryTool">
			<li>
				<a href="{:U('recommend',array('code'=>$member['referral_code']))}">
					<span class="icon">
						<i class="iconfont red">&#xe6ad;</i>
						<label class="toolNam">我要代言</label>
					</span>
				</a>
			</li>
			<li>
				<a href="{:U('my_money')}">
					<span class="icon">
						<i class="iconfont blue">&#xe6b6;</i>
						<label class="toolNam">我的钱包</label>
						<em>{$member['money']}</em>
					</span>
				</a>
			</li>
			<li>
				<a href="{:U('Reward/index')}">
					<span class="icon">
						<i class="iconfont yellow">&#xe6b1;</i>
						<label class="toolNam">我的奖金</label>
						<em>{$member['reward']}</em>
					</span>
				</a>
			</li>
			<li>
				<a href="{:U('Integral/index')}">
					<span class="icon">
						<i class="iconfont blue">&#xe6ae;</i>
						<label class="toolNam">我的积分</label>
						<em>{$member['integral']}</em>
					</span>
				</a>
			</li>
			<li>
				<a href="{:U('Member/growup')}">
					<span class="icon">
						<i class="iconfont green">&#xe6aa;</i>
						<label class="toolNam">成长值</label>
					</span>
				</a>
			</li>
			<li>
				<a href="{:U('Member/me_fenshi')}">
					<span class="icon">
						<i class="iconfont red">&#xe6ba;</i>
						<label class="toolNam">我的直粉</label>
					</span>
				</a>
			</li>
			<li>
				<a href="{:U('Member/friend_list')}">
					<span class="icon">
						<i class="iconfont yellow">&#xe6a3;</i>
						<label class="toolNam">我的社圈</label>
					</span>
				</a>
			</li>
			<li>
				<a href="{:U('MemberCollection/index')}">
					<span class="icon">
						<i class="iconfont blue">&#xe6a2;</i>
						<label class="toolNam">我的收藏</label>
					</span>
				</a>
			</li>
			<li>
				<a href="{:U('update')}">
					<span class="icon">
						<i class="iconfont blue">&#xe6a9;</i>
						<label class="toolNam">我的资料</label>
					</span>
				</a>
			</li>
			<li>
				<a href="{:U('Address/index')}">
					<span class="icon">
						<i class="iconfont yellow">&#xe6b5;</i>
						<label class="toolNam">收货地址</label>
					</span>
				</a>
			</li>
			<li>
				<a href="{:U('suggest')}">
					<span class="icon">
						<i class="iconfont red">&#xe6b3;</i>
						<label class="toolNam">投诉建议</label>
					</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="icon">
						<i class="iconfont green">&#xe6a5;</i>
						<label class="toolNam">联盟商圈</label>
					</span>
				</a>
			</li>
		</ul>

		<!-- 退出登录 -->
		<div style="padding:1rem;">
			<button type="submit" class="btn-submit" onclick="window.location.href='{:U('Member/logout')}'" >退出</button>
		</div>
	</div>
	
</block>