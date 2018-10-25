<extend name="Base/common" />
<block name="main">
 
<body>
	<section id="BiaoD">
		<if condition="$new eq 1">
			<p style="text-align: center;font-size: 1rem;color: #9c9a9a;margin-top: 2%;">暂无请假记录</p>
		<else />
			<div class="XianS">
				<h1><span>请假人员</span><b>{$leaveInfo['personal_code']}</b></h1>
				<h1><span>请假类型</span><b>{$leaveInfo['leave_cate']}</b></h1>
				<h1><span>请假天数</span><b>{$leaveInfo['shicha']['day']}天{$leaveInfo['shicha']['hour']}小时</b></h1>
				<h1><span>开始时间</span><b>{$leaveInfo['leave_start_time']}</b></h1>
				<h1><span>结束时间</span><b>{$leaveInfo['leave_end_time']}</b></h1>
				<h1><span>申请理由</span><b>{$leaveInfo['leave_reason']}</b></h1>
				<if condition="$leaveInfo['picture'] neq ''">
					<h1><span>附件内容</span><b><img style="width: 100%; margin-bottom: 1rem;" src="{$leaveInfo['picture']}" alt="没有附件"></b></h1>
				</if>
				<h1><span>审批状态</span><b><if condition="$leaveInfo.status eq 0">待审批
							<elseif condition="$leaveInfo.status eq 1" />已通过
							<elseif condition="$leaveInfo.status eq 2" />已拒绝
						</if></b></h1>
				<h1><span>审批内容</span><b>{$leaveInfo['tips']}{$leaveInfo['remind']}</b></h1>
				<if condition="$leaveInfo.status eq 1">
					<div class="ErWM">
						<a href="/{$erweima}">
							<img src="/{$erweima}"/>
						</a>
						请假二维码
					</div>
				</if>
			</div>
		</if>
	</section>
	
</body>
<script type="text/javascript" src="__JS__/jquery.qrcode.min.js"></script>
<script src="__JS__/XuanZe.js" type="text/javascript"></script>

<script>
// jQuery(function(){
// 	jQuery('#output').qrcode("{$string}");
// })

 // jQuery('#output').qrcode({
 //      render    : "canvas",
 //         text    : "{$string}",
 //         width : "200",               //二维码的宽度
 //                 height : "200",              //二维码的高度
 //                 background : "#ffffff",       //二维码的后景色
 //                 foreground : "#000000",        //二维码的前景色  
 //     });   
</script>

</block>