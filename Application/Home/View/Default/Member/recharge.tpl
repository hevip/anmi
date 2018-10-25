<extend name="Base/common1" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">
<script>
$(function(){
	$('#rechangeForm').submit(function(){
		var PriceNumber = $('.PriceNumber').val();
		if(PriceNumber < 1){
			d_messages('请输入至少1元的充值金额');
			return false;
		}
	});
	
})
</script>
</block>
<block name="main"> 

<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>充值</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
	
		<form method="post" id="rechangeForm" action="{:U('Cart/adddirect')}">
			<div class="user-recharge">
				<!-- 充值金额输入 -->
				<section>
					<div class="text-all dis-box j-text-all">
						<label class="t-remark">充值金额</label>
						<div class="box-flex input-text">
							<input class="j-input-text PriceNumber" type="number" placeholder="请输入充值金额" name="price">
						</div>
					</div>
				</section>
				<!-- 充值方式选择 -->
				<section  class="padding-lr j-show-div j-show-get-val">
					<div class="text-all dis-box ">
						<label class="t-remark">充值方式</label>
						<div class="box-flex t-goods1">
							<span></span>
						</div>         
						<span class="t-jiantou"><i class="iconfont icon-jiantou">&#xe664;</i></span>
					</div>
					<!-- 充值方式弹出 -->
					<div class="show-time-con ts-3 j-filter-show-div">
						<section class="goods-show-title">
							<h3 class="fl g-c-title-h3">充值方式</h3>
							<i class="iconfont icon-guanbi1 show-div-guanbi fr">&#xe63b;</i>
						</section>
						
						<section class="s-g-list-con swiper-scroll swiper-container-vertical swiper-container-free-mode">
							<div class="swiper-wrapper">
								<div class="swiper-slide select-two">
									<ul class="j-get-one">
										<li class="ect-select">																									
											<label class="ts-1" onclick="show(9)">
												<dd>
													<span><i class="iconfont green">&#xe6c3;</i><font>微信支付</font></span>
												</dd>
												<i class="fr iconfont icon-gou ts-1">&#xe612;</i>
											</label>
										</li>
										<li class="ect-select">																									
											<label class="ts-1" onclick="show(9)">
												<dd>
													<span><i class="iconfont blue">&#xe6c3;</i><font>支付宝支付</font></span>
												</dd>
												<i class="fr iconfont icon-gou ts-1">&#xe612;</i>
											</label>
										</li>
																																				
									</ul>
								</div>
								<div class="swiper-scrollbar"></div>
							</div>
						</section>
					</div>
				</section>
			</div>
			
			<!-- 立即充值按钮 -->
			<div class="user-recharge-btn">
				<button type="submit" class="btn-submit" name="submit" value="sub">立即充值</button>
			</div>
			
			<div class="mask-filter-div"></div>
			
		</form>
		
	</div>
	
</block>
