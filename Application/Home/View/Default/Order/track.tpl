<extend name="Base/common" />

{// css样式区 }
<block name="link">
	<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
	<link rel="stylesheet" type="text/css" href="__STYLE__/logistic.css" />

    <style type="text/css">
        *{font-size: 1.3rem;}
    </style>
</block>

<block name="jscript">
</block>

<block name="main">
	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>{$columnTitle}</h3>
        <a href="__ROOT__"><i class="iconfont">&#xe621;</i></a>
    </header>
	
	<a class="proBox" href="javascript:void(0);">
	    <dl class="pro">
	        <dt><img src="__ROOT__/{$orderInfo['picture']}" alt="pro"></dt>
	        <dd class="nam">物流公司：<span>{$orderInfo['send_company']}</span></dd>
	        <dd class="courierNumber">快递单号：<span>{$orderInfo['send_id']}</span></dd>
	        <dd class="tel">官方电话：<span>{$config['copyright']}</span></dd>
	    </dl>
	</a>
	
	<!-- 物流跟踪 -->
	<div class="logisticsFollow">
	    <p class="caption"><span></span><label>物流跟踪</label></p>
	    <ul class="followBox">
		<if condition="$logistics|count gt 0">
		    <volist name="logistics" id="list">
		    	<if condition="$key eq 0">
        			<li class="current">
        		<else />
        			<li>
        		</if>
		            <dl>
		                <dt><span><label></label><em></em></span></dt>
		                <dd class="address">{$list['intro']}</dd>
		                <dd class="time">{$list['create_time']|date='Y-m-d H:i:s',###}</dd>
		            </dl>
				</li>
			</volist>
		<else />
			<li><div class="geng_li">暂无物流信息</div></li>
		</if>
	    </ul>
	</div>
</block>