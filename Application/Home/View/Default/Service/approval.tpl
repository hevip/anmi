<extend name="Base/common" />
<block name="main">

<body>
	<section id="Sp_List_tj">
		<p>
			<a href="{:U('unapprovallist')}">
				<i class="iconfont">&#xe6a7;</i>
				<span class="iconfont"><if condition="$unapprovalCount gt 0"><b></b></if>&#xe66c;</span>未审批({$unapprovalCount})
			</a>
		</p>
		<p>
			<a href="{:U('approvallist')}">
				<i class="iconfont">&#xe6a7;</i>
				<span class="iconfont">&#xe61c;</span>已审批
			</a>
		</p>
	</section>
</body>
</block>