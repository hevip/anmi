<extend name="Base/common" />
<block name="main">
    <script type="text/javascript">
    	
   		document.addEventListener('plusready', function(){
   			//console.log("所有plus api都应该在此事件发生后调用，否则会出现plus is undefined。"
   			
   		});
   		
    </script>


<body>
	<section id="person">
		<div class="person_Top">
			<a href="{:U('update')}">
				<i class="iconfont">&#xe6a7;</i>
				<em><img src="/{$member['face']}"/></em>
				<span>{$member['personal_code']}</span>
			</a>
		</div>
		<div class="clear"></div>
		<div class="person_con">
			<a href="{:U('update')}">
				<i class="iconfont" style="color: #1296db;">&#xe685;</i>
				我的信息
			</a>
			<div class="clear"></div>
		<!-- 	<a href="#">
				<i class="iconfont" style="color: #f49c2e;">&#xe684;</i>
				我要分享
			</a> -->
			<a href="{:U('edit_pass')}">
				<i class="iconfont" style="color: #1296db;">&#xe652;</i>
				修改密码
			</a>
			<div class="clear"></div>
			<a href="{:U('suggest')}">
				<i class="iconfont" style="color: #f49c2e;">&#xe686;</i>
				意见反馈
			</a>
			<a href="{:U('notice')}">
				<i class="iconfont" style="color: #e8541e;">&#xe658;</i>
				系统公告
			</a>
			<a href="{:U('Member/logout')}">
				<i class="iconfont" style="color: #e8541e;">&#xe687;</i>
				退出登录
			</a>
		</div>
	</section>
<!-- 	<div style="padding:1rem;">
			<button type="submit" class="btn-submit" onclick="window.location.href='{:U('Member/logout')}'" >退出</button>
		</div> -->
	

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