<extend name="Base/common" />
<block name="main">
    <script type="text/javascript">
    	
   		document.addEventListener('plusready', function(){
   			//console.log("所有plus api都应该在此事件发生后调用，否则会出现plus is undefined。"
   			
   		});
   		
    </script>

	<style>
		.notice{    line-height: 2rem;
			font-size: 1.1rem;}
	</style>
<body>
	<section id="Header">
		<b><img src="__IMAGES__/Header-index_08.png"/></b>
		<a href="#">
			<img src="{$member['face']}"/>
		</a>
		<span style="margin-left: 1%;">个人代号:{$member['personal_code']}</span>
		<span style="margin-left: 1%;">单位代号:{$shorthandname}</span>
	</section>
	<section id="bane">
		<div class="swiper-container" id="banner">
		    <ul class="swiper-wrapper">
		    <volist name="slideList" id="volist">
		        <li class="swiper-slide">
		        	<a >
		        		<img src="__ROOT__/{$volist['picture']}" />
		        	</a>
		        </li>
		     </volist>
		    </ul>
		    <div class="swiper-pagination" style="text-align: center;"></div>
		</div>
	</section>
	<section id="Lun_word">
		<h1>单位通知</h1>
		<i class="iconfont">&#xe658;</i>
		<!--<marquee onMouseOver=this.stop() onMouseOut=this.start() scrollamount=1 scrolldelay=0 direction=up style="height: 3rem;line-height: 2rem;">
		<volist name="noticeList" id="vo">
			<p><a href="{:U('Index/read',['id'=>$vo['id']])}">{$vo.title}</a></p>
		</volist>
		</marquee>-->
			<ul style="width:93%;float: right">
				<volist name="noticeList" id="vo">
					<li class="notice"><a href="{:U('Index/read',['id'=>$vo['id']])}">{$vo.title}<p style="float: right">{$vo.create_time|date='H:i  m-d',###}</p></a></li>
				</volist>
			</ul>
	</section>
	<div class="clear"></div>
	<section id="List_News">
			<h1 style="width: 92.2%;margin: 0 auto;" class="tit_index">新闻资讯</h1>
			<ul>
			<volist name="articleList" id="vo">
				<li>
					<a href="{:U('Index/read',['id'=>$vo['id']])}">
						<div class="img_L fl">
							<img src="__ROOT__/{$vo.picture}"/>
						</div>
						<div class="Word_R fr">
							<h1>{$vo.title}</h1>
							<p>
								{$vo.create_time|date='m-d H:i',###}
							</p>
						</div>
					</a>
				</li>
			</volist>
			</ul>
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