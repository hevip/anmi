<extend name="Base/common1" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">
<script language="javascript" type="text/javascript">
$( function() {
	var formObj = $( '#withdrawCoins' );
	formObj.on( 'submit', function() {
		var commitBtn = $( this ).find('.btn-submit');
		if(commitBtn.hasClass('commiting'))return false;
		commitBtn.addClass( 'commiting' );
		var price = $( this ).find( 'input[name="price"]' );
		var postal_price = {$config['postal_low_price']};
		if ( price.val() < postal_price ) {
			d_messages( '每次提现金额最低'+postal_price+'元' );
			price.focus();
			commitBtn.removeClass('commiting');
			return false;
		}
		var postal_high_price = {$config['postal_high_price']};
		if ( price.val() > postal_high_price ) {
			d_messages( '每次提现金额最高'+postal_high_price+'元' );
			price.focus();
			commitBtn.removeClass('commiting');
			return false;
		}
		/*var html = '<div class="popupBg" style="display:block;"></div>';
			html += '<div class="popupImg" style="display:block;">';
			html += '<img src="'+jsObj['images']+'/loading3.gif" />';
			html += '<p style="display:block;">数据交互中...</p>';
			html += '</div>';
		var TheUrl = $( this ).attr( 'action' ) + '?rnd=' + Math.random();
		var json = $( this ).serialize();
		$.ajax({
			url : TheUrl + Math.random(),
			data : json,
			type : 'POST',
			async : true,
			dataType : 'json',
			beforeSend : function() {
				$( 'body' ).append( html );
			},
			success : function( data ) {
				if ( data['status'] ) {
					d_messages( data['info'] );
					setTimeout(function () {
						location.href = "{:U('Reward/index')}";
					}, 1000);
					
				} else {
					$( '.popupBg,.popupImg' ).fadeOut();
					setTimeout( function(){ 
						$( '.popupBg,.popupImg' ).remove()
						alert( data['info'] );
					}, 500 );
				}
			}
		});
		return false;*/
	} );
} );
</script>
</block>
<block name="main"> 

<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>申请提现</h3>
        <a href="__ROOT__/"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		
		<form method="post" action="{:U('Reward/WXWithdraw')}" id="withdrawCoins">
			<if condition="$member['wx_open_id'] eq ''">
				<div class="bind-webchat no-div-message">
					<i class="iconfont icon-biaoqingleiben">&#xe676;</i>
					<p>亲，你还未绑定微哦~！</p>
					<if condition="$isWebChat">
						<!-- 微信端才显示立即绑定 -->
						【<a href="{:U('Member/bindWebchat')}">立即绑定</a>】
					<else />
						【<a href="javascript:history.go(-1);">返回</a>】
					</if>
				</div>
			<else />
				<div class="user-recharge">
					<!-- 微信号 -->
					<div class="wechat-info">
						<img src="__ROOT__/{$member['face']}">
						<span>微信号：{$member['wx_name']}</span>
					</div>
					<!-- 金额输入 -->
					<div class="text-all dis-box j-text-all">
						<label>金额</label>
						<div class="box-flex input-text">
							<input onkeyup="value=value.replace(/[^\d]/g,'');" onpaste="return false" name="price" id="txtNumber" class="j-input-text" type="number" placeholder="本次最高可提现{$member['reward']}">
							<input type="hidden" value="26" name="type">
							<i class="iconfont is-null j-is-null">&#xe669;</i>
						</div>
					</div>
				</div>
					
				<!-- 确定按钮 -->
				<div class="user-recharge-btn">
					<if condition="$member['reward'] gt 0">
						<button type="submit" class="btn-submit" name="submit" value="sub">确认提现</button>
					<else />
						<button type="submit" class="btn-submit" name="submit" value="sub" disabled="true" style="background:#999;border-color:#999;">确认提现</button>
					</if>
				</div>
			</if>
		</form>
	</div>

</block>
