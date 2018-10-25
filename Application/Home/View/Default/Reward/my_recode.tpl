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
        <h3>交易记录</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		<section class="user-wallet-detail">
			<ul>
				<li class="dis-box">
					<div class="record-img">
						<img src="images/centerHeadPic.png">
					</div>
					<div class="box-flex record-tit">
						<h3>123456-消费订单99.99元</h3>
						<p>三级分销会员</p>
					</div>
					<div class="box-flex record-in">
						<h3>收入10.00</h3>
						<p>2016-08-30 12:00</p>
					</div>
				</li>
			</ul>
			
			<!-- 没有数据的样式 -->
			<div class="no-div-message">
				<i class="iconfont icon-biaoqingleiben">&#xe676;</i>
				<p>亲，什么都没有哦～！</p>
			</div>
			
		</section>
	</div>
</block>
