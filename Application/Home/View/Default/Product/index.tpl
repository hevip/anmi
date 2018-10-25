<extend name="Base/common" />
<block name="main">

    <script type="text/javascript">
   		document.addEventListener('plusready', function(){
   			//console.log("所有plus api都应该在此事件发生后调用，否则会出现plus is undefined。"
   		});
    </script>
<body>
	<section id="bane">
		<div class="swiper-container" id="banner">
		    <ul class="swiper-wrapper">
				<volist name="slideList" id="vo">
					<li class="swiper-slide">
						<a >
							<img src="__ROOT__/{$vo['picture']}" />
						</a>
					</li>
				</volist>
		    </ul>
		    <div class="swiper-pagination" style="text-align: center;"></div>
		</div>
	</section>	
	<section id="pro_fenl">
		<h1>产品分类</h1>
		<div class="fenl_list_t">
			<a href="{:U('detail')}?title=管理软件">
				<img src="__IMAGES__/profen_03.jpg"/>
			</a>
			<a href="{:U('detail')}?title=营门营区">
				<img src="__IMAGES__/profen_05.jpg"/>
			</a>
			<a href="{:U('detail')}?title=国防仓库">
				<img src="__IMAGES__/profen_08.jpg"/>
			</a>
		</div>
		<div class="fenl_list_b">
			<a href="{:U('detail')}?title=枪弹物资">
				<img src="__IMAGES__/profen_12.jpg"/>
			</a>
			<a href="{:U('detail')}?title=人车管理">
				<img src="__IMAGES__/profen_13.jpg"/>
			</a>
			<a href="{:U('detail')}?title=手机管控">
				<img src="__IMAGES__/profen_16.jpg"/>
			</a>
			<a href="{:U('detail')}?title=安全保密">
				<img src="__IMAGES__/profen_17.jpg"/>
			</a>
			<a href="{:U('detail')}?title=训练教育">
				<img src="__IMAGES__/profen_20.jpg"/>
			</a>
			<a href="{:U('detail')}?title=信息产品">
				<img src="__IMAGES__/profen_21.png"/>
			</a>
		</div>
	</section>

</body>
<script type="text/javascript">
	var swiper = new Swiper('#bane .swiper-container', {
        autoplay: 3000,//可选选项，自动滑动
		effect : 'fade',
		loop: true, 
		pagination : '.swiper-pagination',
		paginationClickable :true, 
		autoplayDisableOnInteraction : false,
    });
</script>
</block>