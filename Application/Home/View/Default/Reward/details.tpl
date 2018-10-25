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
        <h3>奖金明细</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		<section class="user-wallet-detail">
		<if condition="$dataList|count gt 0">
			<ul>
			<volist name="dataList" id="volist" >
			<if condition="$volist['price'] neq 0">
				<li>
					<div>
						<h3 class="fl detail-title">
							{$volist['type_name']}
							<if condition="$volist['status'] eq 0">
								<span class="review">等待审核</span>
							<elseif condition="$volist['status'] eq 1" />
								<span class="success">成功</span>
							<else />
								<span class="error">出错</span>
							</if>
						</h3>
						<if condition="$volist['price'] gt 0">
							<span class="fr detail-money green">+{$volist['price']}元</span>
						<else />
							<span class="fr detail-money yellow">{$volist['price']}元</span>
						</if>
					</div>
					<div>
						<span class="fl detail-way">
							{$volist['create_time']|date="Y-m-d H:i:s",###}
						</span>
						<span class="fr detail-time">
							余额：{$volist['balance']}
						</span>
					</div>
				</li>
			</if>	
			</volist>	
			</ul>
			<else/>
				<div class="no-div-message">
					<i class="iconfont icon-biaoqingleiben">&#xe676;</i>
					<p>亲，什么都没有哦～！</p>
				</div>
			</if>
		</section>
	</div>

</block>
