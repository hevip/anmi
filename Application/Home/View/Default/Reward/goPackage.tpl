<extend name="Base/common1" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">
</block>
<block name="main"> 

<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>转账到钱包</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		<form method="post" id = 'Package-form' action="{:U('goPackage')}" onsubmit="return false;" >
			<div class="user-recharge">
				<!-- 金额输入 -->
				<section>
					<div class="text-all dis-box j-text-all">
						<label class="t-remark">金额</label>
						<div class="box-flex input-text">
							<input class="j-input-text" type="number" placeholder="本次可转{$member['reward']}" name="money">
							<i class="iconfont is-null j-is-null">&#xe669;</i>
						</div>
					</div>
				</section>
			</div>
				
			<!-- 确定按钮 -->
			<div class="user-recharge-btn">
				<if condition="$member['reward'] gt 0">
					<button type="submit" class="btn-submit" name="submit" value="sub">确认转账</button>
				<else />
					<button type="submit" class="btn-submit" name="submit" value="sub" disabled="true" style="background:#999;border-color:#999;">确认提现</button>
				</if>
			</div>
		</form>
		
	</div>
	<script type="text/javascript">
		$( function() {
			$( '#Package-form' ).submit( function() {
				// 转账数目
				var money = $( 'input[name="money"]' );
				if ( money.val() == "") {
					d_messages('请输入转入数量',2);
					money.focus();
					return false;
				}
				if ( money.val() < 100 ) {
					d_messages('至少转入100元',2);
					money.focus();
					return false;
				}
				var action = $("#suggest-form").attr("action");
				$this = $(this);
				if($this.hasClass('ing'))return false;
				$this.addClass('ing');
				$.post(action,$('#Package-form').serialize(),function(data){
					if(data.status == 1){
						d_messages( '操作成功' ,2);
						window.location.href = "{:U('Member/my_money')}";
					}else{
						d_messages( data.msg ,2);
						$this.removeClass('ing');
					}
				});
			})
		})
	</script>
</block>
