<extend name="Base/common" />
<block name="main">
 
<body>
	<section id="BiaoD">
		<if condition="$new eq 1">
			<p style="text-align: center;font-size: 1rem;color: #9c9a9a;margin-top: 2%;">暂无用车记录</p>
		<else />
		<div class="XianS">
			<h1><span>车辆类型</span><b>{$carInfo['car_num']}</b></h1>
            <h1><span>用车人员</span><b>{$carInfo['personal_code']}</b></h1>
            <h1><span>用车单位</span><b>{$carInfo['companyname']}</b></h1>
            <h1><span>带车干部</span><b>{$carInfo['cadres']}</b></h1>
            <h1><span>用车里程</span><b>{$carInfo['mileage']}公里</b></h1>
            <h1><span>用车用途</span><b>{$carInfo['caruse']}</b></h1>
            <h1><span>用车时长</span><b>{$carInfo['duration']}小时</b></h1>
            <h1><span>开始用车</span><b>{$carInfo['car_start_time']}</b></h1>
            <h1><span>结束用车</span><b>{$carInfo['car_end_time']}</b></h1>
			<h1><span>审批状态</span><b><if condition="$carInfo.status eq 0">审批中
										<elseif condition="$carInfo.status eq 1" />已通过

										<elseif condition="$carInfo.status eq 2" />拒绝用车
										</if></b></h1>
			<h1><span>审批内容</span><b>{$carInfo['tips']}{$carInfo['remind']}</b></h1>
			<if condition="$carInfo.status eq 1">
			<div class="ErWM">
				<a href="/{$erweima}">
					<img src="/{$erweima}"/>
				</a>
				用车二维码
			</div>
			</if>
		</div> 
		</if>
	</section>
	
</body>
<script src="__JS__/XuanZe.js" type="text/javascript"></script>

</block>