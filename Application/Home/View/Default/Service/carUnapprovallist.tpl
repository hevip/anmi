<extend name="Base/common" />
<block name="main">

<body>
	<!--遮盖层 start-->
<!-- 	<div class="mask_a"></div>
	<section id="TaChuang">
		<div class="btn_Qr">
			<input type="reset" class="Qx_Cz btn_Qr_sty" name="" id="" value="取消" />
			<input type="submit" class="Qr_sx btn_Qr_sty" name="" id="" value="确认" />
		</div>
		<div class="TanC_con">
			<h1>请假类型筛选</h1>
			<ul>
				<li>
					<a href="#">请假类型A</a>
				</li>
				<li>
					<a href="#">请假类型B</a>
				</li>
				<li>
					<a href="#">请假类型C</a>
				</li>
				<li>
					<a href="#">请假类型D</a>
				</li>
				<li>
					<a href="#">请假类型E</a>
				</li>
			</ul>
			<h1>审批结果筛选</h1>
			<ul>
				<li>
					<a href="#">审批中</a>
				</li>
				<li>
					<a href="#">已通过</a>
				</li>
				<li>
					<a href="#">已拒绝</a>
				</li>
			</ul>
		</div>
	</section> -->
	<!--遮盖层 end-->
	
	<section id="BiaoD">		
		<!-- <div class="Top_saiX">
			<div class="Top_saiX_con">
				<div class="Top_saiX_L">
					<a href="#" class="Sx_start"><i class="iconfont">&#xe626;</i>筛选</a>
				</div>
				<div class="Top_saiX_R">
					<form action="" method="post">
						<input type="text" name="" id="" value="" />
						<input type="submit" value="搜索"/>
					</form>
				</div>
			</div>
		</div> -->
		<script type="text/javascript">
			// $(function(){
			// 	var hei_al = $(window).height();
			// 	var Top_hei=$('.Top_saiX').height();
			// 	var Tc_Hei=hei_al-Top_hei;
			// 	var mask_a =$('.mask_a');
			// 	var TaChuang =$('#TaChuang');
			// 	TaChuang.css('height',Tc_Hei-1+'px');
			// 	mask_a.css('height',hei_al+'px');				
			// 	$('.TanC_con ul li a').click(function(){
			// 	    $(this).toggleClass('DianJ_xis');
			// 	});	
				
			// 	$('.Qx_Cz,.Qr_sx').click(function(){
			// 		closeNav();
			// 	})
			// 	mask_a.click(function(){
			// 		 closeNav();
			// 	});
			// 	$('.Sx_start').click(function(){
			// 		openNav();
			// 	})
			// 	function openNav(){
			// 		TaChuang.addClass('transform-0');
			//    		mask_a.addClass('transform-0');
			//    		$('body').css({"overflow":"hidden",'height':'100%'});
			// 	}
			// 	function closeNav(){
			// 		TaChuang.removeClass('transform-0');
			//    		mask_a.removeClass('transform-0');
			//    		$('body').css({"overflow":"auto",'height':'auto'});
			// 	}
			// })
			
		</script>
		<!-- <form action="" method="post">
			<div class="tianxie_bd">
				<div class="xuze_sa_time">
					<p>
						<label for="test1"><i class="iconfont">&#xe678;</i></label>
						<input placeholder="2018-05-25" type="text" name="" id="test1" value="" />
					</p>
					<span>-</span>
					<p>
						<label for="test2"><i class="iconfont">&#xe678;</i></label>
						<input placeholder="2018-05-25" type="text" name="" id="test2" value="" />
					</p>
					<div><input class="btn-th" type="submit" value="确认"/></div>
				</div>			
			</div>	
		</form> -->
		<div class="Jl_list">
			<ul>
				<volist name="unapprovallist" id="vo">

				<li>
					<a href="{:U('carApprovalRead',array('id'=>$vo['id']))}">
						<em>未审批</em>
						<img src="/{$vo.face}"/>
						<span>
							{$vo.car_num}
							<b>{$vo.addtime|date='Y-m-d H:i:s',###}</b>
						</span>
					</a>
				</li>
			</volist>
			</ul>
		</div>
		
	</section>
	
</body>
<script src="js/laydate.js"></script> <!-- 改成你的路径 -->
<script>
lay('#version').html('-v'+ laydate.v);

//执行一个laydate实例
laydate.render({
  elem: '#test1'
});
laydate.render({
  elem: '#test2'

});
</script>
</block>