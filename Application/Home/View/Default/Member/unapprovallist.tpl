<extend name="Base/common" />
<block name="main">

<body>
	
	<section id="BiaoD">
		<div class="Jl_list">
			<ul>
				<if condition="$unapprovallist eq 0">
					<div style="color: #ada7a7; text-align: center;">暂无消息</div>
				<else />
					<if condition="$leave neq 0">
						<li style="font-size: 1.3rem; margin-left: 1%;  padding: 0.6rem 0;">
							<a href="{:U('Service/unapprovallist')}" style="    color: #546bc3;">你有新的请假申请需要审批！请尽快处理！</a>
						</li>
					</if>
					<if condition="$car neq 0">
						<li style="font-size: 1.3rem; margin-left: 1%;padding: 0.6rem 0;">
							<a href="{:U('Service/carUnapprovallist')}" style="    color: #546bc3;">你有新的用车申请需要审批！请尽快处理！</a>
						</li>
					</if>
				</if>
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