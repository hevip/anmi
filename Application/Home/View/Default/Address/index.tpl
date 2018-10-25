<extend name="Base/common1" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">
<script type="text/javascript" src="__JS__/address.js"></script>
</block>
<block name="main"> 

<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>收货地址</h3>
        <a href="{:U('Member/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		
		<div class="flow-consignee-list j-get-consignee-one select-three">
		<volist name="dataList" id="vo">
			<section class="flow-checkout-adr">
				<div class="flow-set-adr">
					<!-- 设为默认 -->
					<div class="ect-select fl">
						<label class="dis-box seDefault <if condition="$vo['is_default'] eq 1">active</if>" data-id="{$vo['id']}" onclick="">
							<i class="select-btn"></i>
							<span class="t-first margin-lr">
								<a class="ml10 ftx-05 " href="javascript:void(0);">设为默认</a>
							</span>
						</label>
					</div>
					<!-- 操作按钮 -->
					<div class="fr">
						<a href="{:U('edit',array('id'=>$vo['id']))}"><i class="iconfont icon-bianji">&#xe619;</i>编辑</a>
						<a class="delete" data-id="{$vo['id']}" href="javascript:;"><i class="iconfont icon-xiao10">&#xe665;</i>删除</a>
					</div>
				</div>
				
				<!-- 地址信息 -->
				<div class="flow-have-adr padding-all">
					<p class="f-h-adr-title">
						<label>{$vo['nickname']}</label><span>{$vo['tel']}</span>
					</p>
					<p class="f-h-adr-con t-remark m-top04">{$vo['str']}</p>
				</div>
			</section>
		</volist>	
			<!-- 新增收货人 -->
			<div class="ect-button-more dis-box filter-btn">
				<a href="{:U('add')}" class="btn-submit box-flex">新增收货人信息</a>
			</div>
		</div>
	</div>
</block>
