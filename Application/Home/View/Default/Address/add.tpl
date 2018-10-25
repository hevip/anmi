<extend name="Base/common1" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">
<script type="text/javascript" src="__JS__/address.js"></script>
</block>
<block name="main"> 

<body class="body">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>新增收货信息</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
	
		<form method="post" action="{:U('Address/add')}" id="address_form" onsubmit="return false;">
		
			<!-- 表单基本信息 -->
			<div class="flow-consignee margin-lr">
			
				<div class="text-all dis-box j-text-all">
					<label>收货人</label>
					<div class="box-flex input-text">
						<input name="nickname" class="j-input-text" type="text" placeholder="请输入收货人姓名">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
				</div>
				<input type="hidden" name="http_referer" value="{$Think.server.HTTP_REFERER}" />
				<div class="text-all dis-box j-text-all">
					<label>手机号码</label>
					<div class="box-flex input-text">
						<input name="tel" class="j-input-text" type="tel" placeholder="请输入联系电话">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
				</div>
				
				<section class="text-all j-filter-city">
					<label class="fl">所在地区</label>
					<span class="show-region text-all-span">请选择</span>
					<span class="t-jiantou fr"><i class="iconfont">&#xe664;</i></span>
					<input class="j-input-text" name="areaId" type="hidden">
				</section>
				
				<div class="text-all ">
					<label>详细信息</label>
					<div class="box-flex input-text">
						<input class="j-input-text" name="intro" type="text" value="" placeholder="详细地址">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
				</div>
				
				<div class="ect-button-more dis-box">
					<input type="submit" name="submit" class="btn-submit box-flex" value="保存">
				</div>
				
			</div>
			
			<!-- 弹出地址选择 -->
			<div class="filter-city-div ts-5 c-filter-div c-city-div">
				
				<!-- 关闭 -->
				<section class="close-filter-div j-close-filter-div">
					<div class="close-f-btn">
						<i class="iconfont icon-fanhui">&#xe63b;</i>
						<span>关闭</span>
					</div>
				</section>
				
				<section class="con-filter-div">
					<!-- 省、直辖市 -->
					<aside>
						<div class="menu-left j-city-left scrollbar-none" id="sidebar">
							<ul>
								<volist name="province" id="volist">
								<li class="Province" data-id="{$volist['province_id']}">{$volist['province']}</li>
								</volist>
							</ul>
						</div>
					</aside>
					
					<section class="menu-right  j-city-right">
						<div class="select-two j-get-city-one City">
						</div>
					</section>
				</section>
			</div>
		</form>
		
	</div>
</block>
