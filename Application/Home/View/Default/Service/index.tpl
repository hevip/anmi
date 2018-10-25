<extend name="Base/common" />
<block name="main">
  

<body>
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
	<section id="GongNeng">
		<h1>请假管理</h1>
		<ul>
			<li>
				<a href="{:U('application')}">
					<i class="iconfont" style="background: #55dd72;">&#xe628;</i>
					请假申请
				</a>
			</li>
			<if condition="$auth neq 0">
			<li>
				<a href="{:U('approval')}">
					<i class="iconfont" style="background: #60c0ff;">&#xe688;</i>
					请假审批
				</a>
			</li>
			<else />
			<li>
				<a href="javascript:;" onClick="return alert('您没有审批权限');">
					<i class="iconfont" style="background: #60c0ff;">&#xe688;</i>
					请假审批
				</a>
			</li>
			</if>
			<li>
				<a href="{:U('leaveRecord')}">
					<i class="iconfont" style="background: #ffc327;">&#xe67f;</i>
					请假记录
				</a>
			</li>
			<li>
				<a href="{:U('leaveRecordRead')}?new=1">
					<i class="iconfont" style="background: #ff6d9e;">&#xe601;</i>
					我的请假
				</a>
			</li>
		</ul>
		<h1>用车管理</h1>
		<ul>
			<li>
				<a href="{:U('carApplication')}">
					<i class="iconfont" style="background: #3f6de0;">&#xe696;</i>
					用车申请
				</a>
			</li>
			<if condition="$auth neq 0">
			<li>
				<a href="{:U('carApproval')}">
					<i class="iconfont" style="background: #60c0ff;">&#xe69b;</i>
					用车审批
				</a>
			</li>
			<else />
			<li>
				<a href="javascript:;" onClick="return alert('您没有审批权限');">
					<i class="iconfont" style="background: #60c0ff;">&#xe69b;</i>
					用车审批
				</a>
			</li>
			</if>
			<li>
				<a href="{:U('carRecord')}">
					<i class="iconfont" style="background: #ff801a;">&#xe68e;</i>
					用车记录
				</a>
			</li>
			<li>
				<a href="{:U('carRecordRead')}?new=1">
					<i class="iconfont" style="background: #7174eb;">&#xe689;</i>
					我的用车
				</a>
			</li>
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