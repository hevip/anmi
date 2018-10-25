<extend name="Base/common" />

{// css样式区 }
<block name="link">
	<style type="text/css">
	.face_pay{width:90%; height:auto; padding:0 5%; margin:30px 0; background:none;}
	.face_pay form{width:100%; height:auto; overflow:hidden; margin-top:20px;}
	.face_pay form label{float:left; width:100%; height:auto; overflow:hidden; margin-bottom:10px; display:block;}
	.face_pay form label span{color:#333; font-size:16x; line-height:30px;}
	.face_pay form label input{width:94%; height:30px; padding:4px 6px; line-height:20px; background:#fff; border:1px solid #ccc; border-radius:3px; -webkit-box-shadow:inset 0 1px 1px rgba(0,0,0,0.075); box-shadow:inset 0 1px 1px rgba(0,0,0,0.075); margin-bottom:3px;}
	.face_pay form label textarea {width:94%; height:70px; padding:4px 6px; line-height:20px; background:#fff; border:1px solid #ccc; border-radius:3px; -webkit-box-shadow:inset 0 1px 1px rgba(0,0,0,0.075); box-shadow:inset 0 1px 1px rgba(0,0,0,0.075); margin-bottom:3px;}
	.face_pay form .submit{float:left; width:100px; height:40px; line-height:40px; color:#fff; font-size:16px; font-weight:bold; background:#FD5959; border:none; -webkit-appearance:none; border-radius:3px;}
	.face_pay form label ul li {width:100%; height:30px; line-height:30px;}
	.face_pay form label ul li input {width:20px; height:20px; padding:0; margin:0; position:relative; top:5px;}
	.face_pay form label ul li span {color:#666; font-size:14px;}
	</style>
</block>

<block name="jscript">
<script>
function checkNum(obj) {
	//检查是否是非数字值
	if (isNaN(obj.value)) {
		obj.value = "";
	}
	if (obj != null) {
		//检查小数点后是否对于两位
		if (obj.value.toString().split(".").length > 1 && obj.value.toString().split(".")[1].length > 2) {
			alert("小数点后多于两位！");
			obj.value = "";
		} else if ( obj.value <= 0 ) {
			alert("金额不能小于0！");
			obj.value = "";
		}
	}
};
$( function() {
	$( '#facePay_form' ).on( 'submit', function() {
		// 支付金额
		var money = $( this ).find( 'input[name="money"]' );
		if ( money.val() == '' || money.val() == 0 ) {
			alert( '请填写金额！' );
			money.focus().val('');
			return false;
		} else if ( isNaN( money.val() ) ) {
			alert( '金额必须为数字！' );
			money.focus().val('');
			return false;
		} else if ( money.val() != '' ) {
			var TheVal = money.val();
			//检查小数点后是否对于两位
			if ( TheVal.toString().split(".").length > 1 && TheVal.toString().split(".")[1].length > 2 ) {
				alert("小数点后多于两位！");
				money.focus().val('');
				return false;
			} else if ( TheVal <= 0 ) {
				alert("金额不能小于0！").val('');
				money.focus();
				return false;
			}
		}
		// 支付方式
		var pay_way = $( this ).find( 'input[name="pay_way"]:checked' );
		if ( pay_way.val() == undefined ) {
			alert( '请选择支付方式' );
			return false;
		}
		// 订单说明
		var content = $( this ).find( 'textarea[name="content"]' );
		if ( content.val() == '' ) {
			alert( '请填写订单说明' );
			content.focus();
			return false;
		}
	} );
} );
</script>
</block>

<block name="main">
	<include file="Public/top" />
    
    <div class="face_pay">
		<form action="{:U('FacePay/payOrder')}" method="post" id="facePay_form">
        	<label>
            	<span>订单金额（元）</span>
                <input type="text" name="money" value="0" onkeyup="checkNum(this)" />
            </label>
        	<label>
            	<span>支付方式</span>
                <ul>
                	<li>
                    	<input type="radio" id="radio-1-1" name="pay_way" value="现金/刷卡" class="regular-radio" checked />
                        <span>现金/刷卡</span>
                    </li>
                	<li>
                    	<input type="radio" id="radio-1-2" name="pay_way" value="网上支付" class="regular-radio" />
                        <span>网上支付</span>
                    </li>
                </ul>
            </label>
        	<label>
            	<span>订单说明</span>
                <textarea name="content" class="inputtxt"></textarea>
            </label>
            
            <input type="submit" name="commit" value="提交" data-disable-with="提交中..." class="submit" />  
        </form>
    </div>
	
</block>