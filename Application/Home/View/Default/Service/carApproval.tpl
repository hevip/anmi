<extend name="Base/common" />
<block name="main">

<body>
	<section id="Sp_List_tj">
		<p>
			<a href="{:U('carUnapprovallist')}">
				<i class="iconfont">&#xe6a7;</i>
				<span class="iconfont"><if condition="$carUnapprovalCount gt 0"><b></b></if>&#xe66c;</span>未审批({$carUnapprovalCount})
			</a>
		</p>
		<p>
			<a href="{:U('carApprovallist')}">
				<i class="iconfont">&#xe6a7;</i>
				<span class="iconfont">&#xe61c;</span>已审批
			</a>
		</p>
	</section>
</body>
</block>