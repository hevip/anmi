<extend name="Base/common1" />

{// css样式区 }
<block name="link">

<style type="text/css">
	.popUpBg1{width: 100%;height: 100%;background: rgba(0,0,0,0.5);z-index: 999;position: fixed;top: 0;left: 0}
	.popUpBg1 > .contentPool{width: 220px;height: 150px;background: #FFF;position: absolute;top: 50%;margin-top: -75px;left: 50%;margin-left: -110px;}
	.popUpBg1 > .contentPool > p.close{height: 30px;width: 100%;overflow: hidden;}
	.popUpBg1 > .contentPool > p.close > i{float: right;height: 30px;width: 30px;line-height: 30px;text-align: center;color: #333;font-size: 20px;}
	.popUpBg1 > .contentPool > p.tip{width: 96%;height: 20px;color: #333;text-align: center;line-height: 20px;overflow: hidden;margin: 0 2%;font-size: 14px;}
	#pswW{width: 160px;height: 30px;display: block;margin: 10px auto;box-sizing:border-box;padding: 0 10px;border-radius: 5px;border: 1px #DBDBDB solid}
	.popUpBg1 > .contentPool > .btnBox_{width: 160px;height: 30px;display: block;margin: 10px auto 0;}
	.popUpBg1 > .contentPool > .btnBox_ > .fgtPsw{float: left;height: 30px;line-height: 30px;font-size: 14px;color: #666;}
	.popUpBg1 > .contentPool > .btnBox_ > .sure_{float: right;text-align: right;height: 30px;line-height: 30px;font-size: 14px;color: #666}
</style>

</block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/new_cart.js"></script>
	<script type="text/javascript">
$(function() {
		$(".popUpBg1 > .contentPool > p.close > i").click(function(){
			$(".popUpBg1").fadeOut("fast");
		})
		$(".walletBalance > .clickBox").click(function(){
			$(this).find("i").toggleClass("light_");
			if(!$(this).find("i").hasClass('light_')){
				$('input[name="money"]').val(0);
			}
			// $(this).find("input").toggle
		});

		$(".popUpBg1 > .contentPool > p.close > i").click(function(){
			$(".popUpBg1").fadeOut("fast");
		});

		/*单选*/
	    $('label').click(function(){
			var radioId = $(this).attr('name');
			$("label[name='"+radioId+"']").removeAttr('class') && $(this).attr('class', 'checked');
			//$('input[type="radio"]').removeAttr('checked') && $('.' + radioId).attr('checked', 'checked');
			$( "input[name="+radioId+"]" ).val( $( this).find('span').html() );
	    });
    $(".clickBox").click(function(){
    	var isPassH = $('.isPassH').val();
    	if(isPassH == 0){
    		$.popup({
                type:1,
                color:'#3EBB2B',
                text:"您还未设置密码",
                href:jsObj.root+'/Member/mymoney',
                btnTxt:"前往设置"
    		})
    	}
        var price = {$cartList['paymentMoney']};//订单价
        var packages = {$member['money']};
        var $iemHTML = price>packages ? packages : price;  //可钱包抵价
        var $i = $('.clickBox i');
        if($i.hasClass('light_')){
            $('.shifukuan').html((price - parseFloat($iemHTML)).toFixed(2));
            $('input[name="money"]').val(parseFloat($iemHTML));
        }else{
             $('.shifukuan').html(parseFloat(price).toFixed(2));
             $('input[name="money"]').val(0);
            
        }   
	});
})
</script>
</block>

<block name="main">
<body class="">
	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>填写订单</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <div class="popUpBg1" style="display:none;">
		<form class="contentPool">
			<p class="close"><i class="iconfont">&#xe60a;</i></p>
			<p class="tip">请输入钱包支付密码！</p>
			<input id="pswW" type="password" value="" />
			<div class="btnBox_">
				<a class="fgtPsw" href="{:U('Member/money_pass')}">忘记密码？</a>
				<a class="sure_ passwordCheck" href="javascript:;">确认</a>
			</div>
		</form>
	</div>

		<!--收货地址-->
		<div class="step1">
			<!--收货人信息-->
			<if condition="count($address) gt 0">
				<a href="javascript:void(0);" class="addressListObjBtn">
			<else />
				<a href="{:U('Address/add')}">
			</if>
				<if condition="count($address) gt 0">
					<input type="hidden" name="address" value="{$address['id']}" />
					<div class="step1_info step1_info_object">
						<p class="new_info">
							<span class="new_name">{$address['nickname']}</span>
							<span class="new_phone">{$address['tel']}</span>
						</p>
						<p class="new_info_address">
							<if condition="$address['is_default'] eq 1">
								<i class="sitem_tip">默认</i>
							</if>
							{$address['provinceString']}
							{$address['cityString']}
							{$address['areaString']}
							{$address['intro']}
						</p>
					</div>
					<span class="step1_more">&gt;</span>
				<else />
					<input type="hidden" name="address" value="0" />
					<p style="text-align:center;padding:1.3rem; font-size:1.5rem;">还没有收货地址，点击添加</p>
				</if>
				<b class="borderB"></b>
			</a>
		</div>

		<!--支付方式-->
		<div class="step2">
			<span class="step2_T">支付方式</span>
			<div class="step2_fun">
				<span class="step2_btn_df payWay">
					<label class="checked" name="pay_way">
						<i class="j-select-btn"></i>
						<span class="box-flex">在线支付</span>
					</label>
				</span>
				<!--span class="step2_btn_df payWay">
					<label class="default" name="pay_way">
						<i class="j-select-btn"></i>
						<span class="box-flex">线下支付</span>
					</label>
				</span-->
			</div>
			<input type="hidden" name="pay_way" value="线下支付" />
		</div>

		<!--发票信息-->
		<div class="step3">
			<span class="step3_T">发票信息</span>
			<div class="step3_fun">
				<div class="step3_type">
					<span class="step3_title">发票类型：</span>
					<span class="step3_btn_df">
						<label class="fp" name="invoice_type">
							<i class="j-select-btn"></i>
							<span class="box-flex">普通发票</span>
						</label>
					</span>
					<span class="step3_btn_df">
						<label class="checked" name="invoice_type">
							<i class="j-select-btn"></i>
							<span class="box-flex">不用发票</span>
						</label>
					</span>
					<input type="hidden" name="invoice_type" value="不要发票" />
				</div>

				<div class="step3_type">
					<span class="step3_title">发票抬头：</span>
					<span class="step3_btn_df">
						<label class="type" name="invoice_top">
							<i class="j-select-btn"></i>
							<span class="box-flex">个人</span>
						</label>
					</span>
					<span class="step3_btn_df">
						<label class="type" name="invoice_top">
							<i class="j-select-btn"></i>
							<span class="box-flex">单位</span>
						</label>
					</span>
					<input type="hidden" name="invoice_top" value="" />

					<input type="text" name="invoice_top_company" class="fp_title" placeholder="请输入发票抬头" />
				</div>

				<div class="step3_type">
					<span class="step3_title">发票内容：</span>

					<input type="text" name="invoice_intro" class="fp_title" placeholder="请输入发票内容"/>
				</div>

			</div>

		</div>

		<!--留言-->
		<div class="step3">
			<span class="step3_T">买家留言（50字）</span>
			<div class="step3_fun">
				<textarea name="content" maxlength="50" placeholder="选填"></textarea>
			</div>
		</div>


		<!--商品信息-->
		<div class="step4">
			<span class="step4_T">商品信息</span>

			<div class="shop_info">
				<ul>
				<volist name="cartList['cartList']" id="volist">
					<li>
						<div class="shop_pic">
							<a href="{$volist['url']}" title="{$volist['title']}" target="_blank">
								<img src="__ROOT__/{$volist['picture']}" alt="{$volist['title']}" />
							</a>
						</div>
						<input class="num" type="hidden" value="{$volist['num']}">
						<input class="id" type="hidden" value="{$volist['id']}">
						<div class="shop_title">
							<a href="{$volist['url']}" title="{$volist['title']}" target="_blank">
								{$volist['title']}
							</a>
						</div>

						<div class="shop_num">
							<font>{$volist['num']}</font>件商品
						</div>

						<div class="shop_price">
							<p>总价：<font>¥</font><font>{$volist['total_price']}</font></p>
							<p>运费：<font>¥</font><font>{$volist['freight']}</font></p>
						</div>
					</li>
				</volist>
				</ul>
			 </div>
		</div>
				
		<div class="step4">
			<div class="walletBalance">
				<label>钱包余额</label>
				<i>剩余<span>¥</span><span>{$member['money']}</span></i>
				<div class="clickBox">
					<i class="iconfont">&#xe66c;</i>
				<input style="display:none" class="checkbox" type="checkbox"  style="appearance:checkbox;-webkit-appearance: checkbox;vertical-align: middle;">
				</div>
				<input class="isPassH" value="1" type="hidden">
				<input name="money" value="0" type="hidden">
			</div>
				
			<div class="actual_price">
				实际付款：<span>¥</span><span><font class="shifukuan">{$cartList['paymentMoney']}</font></span>
			</div>

			<div class="actual_price">
				<a href="javascript:void(0);" class="add_order_send">提交订单</a>
			</div>
			<script type="text/javascript" src="__JS__/goBuyNow_Order.js"></script>
		</div>
	</div>
	
	<!-- 选中地址列表 -->
	<script type="text/javascript">
	$( function() {
		$( ".addressListObjBtn" ).click( function() {
			$( ".addressListObj" ).show();
		} );
		$( ".addressListObj ul.receiving_add li .receiving_info_add" ).click( function() {
			var theId = $( this ).attr( "data-id" );
			var theInfo = $( this ).html();
			$( '.step1_info_object' ).html( theInfo );
			$( 'input[name="address"]' ).val( theId );
			$( ".addressListObj" ).hide();
		} );
		$( ".addressListObj .close" ).click( function() {
			$( ".addressListObj" ).hide();
		} );
	} );
	</script>
	<div class="main addressListObj" style="display:none;height:100%;position:fixed;left:0px;top:0px;">
		<ul class="receiving_add">
		<volist name="addressList" id="volist">
			<li>
				<if condition="$volist['is_default'] eq 1">
				<!--选中-->
				<div class="cl_add"></div>
				</if>
				<!--收货人信息-->
				<div class="receiving_info_add" data-id="{$volist['id']}">
					<p class="new_info">
						<span class="new_name">{$volist['nickname']}</span>
						<span class="new_phone">{$volist['tel']}</span>
					</p>
					<p class="new_info_address">
						<if condition="$volist['is_default'] eq 1">
							<i class="sitem_tip">默认</i>
						</if>
						{$volist['provinceString']}
						{$volist['cityString']}
						{$volist['areaString']}
						{$volist['intro']}
					</p>
				</div>
				<!--修改-->
				<a class="bj_info" href="{:U('Address/edit/id/'.$volist['id'])}"><span></span></a>
			</li>
		</volist>
		</ul>
		
		<div class="ect-button-more dis-box filter-btn padding-all">
			<a class="btn-submit box-flex" href="{:U('Address/add')}">+新建地址</a>
			<a class="btn-submit box-flex close" href="javascript:void(0);">关闭</a>
		</div>
	</div>
	
</block>