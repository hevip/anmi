<extend name="Base/common1" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">
<script language="javascript" type="text/javascript">
function formatBankNo (BankNo){
    if (BankNo.value == "") return;
    var account = new String (BankNo.value);
    account = account.substring(0,23); /*帐号的总数, 包括空格在内 */
    if (account.match (".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}") == null){
        /* 对照格式 */
        if (account.match (".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" + ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" +
        ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" + ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}") == null){
            var accountNumeric = accountChar = "", i;
            for (i=0;i<account.length;i++){
                accountChar = account.substr (i,1);
                if (!isNaN (accountChar) && (accountChar != " ")) accountNumeric = accountNumeric + accountChar;
            }
            account = "";
            for (i=0;i<accountNumeric.length;i++){    /* 可将以下空格改为-,效果也不错 */
                if (i == 4) account = account + " "; /* 帐号第四位数后加空格 */
                if (i == 8) account = account + " "; /* 帐号第八位数后加空格 */
                if (i == 12) account = account + " ";/* 帐号第十二位后数后加空格 */ 
                if (i == 16) account = account + " ";/* 帐号第十六位后数后加空格 */
                account = account + accountNumeric.substr (i,1)
            }
        }
    }
    else
    {
        account = " " + account.substring (1,5) + " " + account.substring (6,10) + " " + account.substring (14,18) + "-" + account.substring(18,25);
    }
    if (account != BankNo.value) BankNo.value = account;
}
$( function() {
	var formObj = $( '#withdrawCoins' );
	formObj.on( 'submit', function() {
		var bank_name = $( this ).find( 'input[name="bank_name"]' );
		if ( bank_name.val() == "" ) {
			d_messages( '请填写收款人姓名' );
			bank_name.focus();
			return false;
		}
		var bank_id = $( this ).find( 'input[name="bank_id"]' );
		if ( bank_id.val() == "" ) {
			d_messages( '请填写卡号' );
			bank_id.focus();
			return false;
		} else if ( bank_id.val().length != 23 ) {
			d_messages( '卡号填写有误！' );
			bank_id.focus();
			return false;
		}
		var bank_type = $( this ).find( 'input[name="bank_type"]' );
		if ( bank_type.val() == "" ) {
			d_messages( '请填写开户行' );
			bank_type.focus();
			return false;
		}
		var bank_hang = $( this ).find( 'input[name="bank_hang"]' );
		if ( bank_hang.val() == "" ) {
			d_messages( '请填写开户网点' );
			bank_hang.focus();
			return false;
		}
		var price = $( this ).find( 'input[name="price"]' );
		if ( price.val() < 1 ) {
			d_messages( '请填写提现金额' );
			price.focus();
			return false;
		}
		var postal_price = {$config['postal_price']};
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
		var html = '<div class="popupBg" style="display:block;"></div>';
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
						location.href = "{:U('Reward/details')}";
					}, 1000);
					
				} else {
					$( '.popupBg,.popupImg' ).fadeOut();
					setTimeout( function(){ 
						$( '.popupBg,.popupImg' ).remove();
						d_messages(data['info']);
					}, 500 );
				}
			}
		});
		return false;
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
		
		<form method="post" action="{:U('Reward/tixian')}" id="withdrawCoins">
			<div class="user-recharge">
				<!-- 姓名 -->
				<div class="text-all dis-box j-text-all">
					<label>姓名</label>
					<div class="box-flex input-text">
						<input class="j-input-text" name="bank_name" type="text" placeholder="收款人开户姓名">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
				</div>
				
				<!-- 卡号 -->
				<div class="text-all dis-box j-text-all">
					<label>卡号</label>
					<div class="box-flex input-text">
						<input  class="j-input-text" onkeyup="formatBankNo(this)" onkeydown="formatBankNo(this)" name="bank_id" id="account" type="text" placeholder="收款人银行卡号">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
				</div>
				
				<!-- 银行 -->
				<div class="text-all dis-box j-text-all">
					<label>银行</label>
					<div class="box-flex input-text">
						<input class="j-input-text" type="text" name="bank_type" placeholder="开户银行">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
				</div>
				
				<!-- 网点 -->
				<div class="text-all dis-box j-text-all">
					<label>网点</label>
					<div class="box-flex input-text">
						<input class="j-input-text" type="text" name="bank_hang" placeholder="开户网点">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
				</div>
				
				<!-- 金额 -->
				<div class="text-all dis-box j-text-all">
					<label>金额</label>
					<div class="box-flex input-text">
						<input onkeyup="value=value.replace(/[^\d]/g,'');" onpaste="return false" name="price" id="txtNumber" class="j-input-text" type="number" placeholder="本次最高可提现{$member['reward']}">
						<input type="hidden" value="28" name="type">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
				</div>
			</div>
				
			<!-- 确定按钮 -->
			<div class="user-recharge-btn">
				<if condition="$member['reward'] gt 0">
					<button type="submit" class="btn-submit" data-disable-with="提交中..." name="submit" value="sub">确认提现</button>
				<else />
					<button type="submit" class="btn-submit" data-disable-with="提交中..." name="submit" value="sub" disabled="true" style="background:#999;border-color:#999;">确认提现</button>
				</if>
			</div>
		</form>
		
	</div>
</block>
