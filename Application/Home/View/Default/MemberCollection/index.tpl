<extend name="Base/common" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">
<script type="text/javascript" src="__JS__/membercollection.js"></script>
</block>
<block name="main"> 
<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>我的收藏</h3>
        <a href="__ROOT__/"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		<section class="collect-list">
			<ul>
			<if condition="$dataList|count gt 0">
			<volist name="dataList" id="vo">
				<li>
					<div class="product-div">
						<a href="{:U('Commodity/show',array('id'=>$vo['pro']['id']))}">
							<img class="product-list-img" src="__ROOT__/{$vo['pro']['picture']}">
						</a>
						<div class="product-text">
							<a href="{:U('Commodity/show',array('id'=>$vo['pro']['id']))}"><h4>{$vo['pro']['title']}</h4></a>
							<p class="dis-box p-t-remark"><span class="box-flex">库存:{$vo['pro']['stock']}</span></p>
							<p><span class="p-price t-first ">¥{$vo['pro']['member_price']}</span></p>
							<a href="javascript:;" data-id="{$vo['id']}" class="delete a-accessories-clear"><i class="iconfont icon-xiao10 fr">&#xe666;</i></a>
						</div>								
					</div>					  
				</li>
				</volist>
				
			</ul>
			<else />
			<!-- 没有数据的样式 -->
			<div class="no-div-message">
				<i class="iconfont icon-biaoqingleiben">&#xe676;</i>
				<p>亲，还没有收藏商品哦～！</p>
			</div>
			</if>
		</section>
		
	</div>
</block>
