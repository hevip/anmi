<extend name="Base/common" />

{// css样式区 }
<block name="link">
	<link rel="stylesheet" type="text/css" href="__STYLE__/new_cart.css" />
</block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/new_cart.js"></script>
	<script type="text/javascript">
	$(function() {
		/*单选*/
	    $('label').click(function(){
			var radioId = $(this).attr('name');
			$("label[name='"+radioId+"']").removeAttr('class') && $(this).attr('class', 'checked');
			//$('input[type="radio"]').removeAttr('checked') && $('.' + radioId).attr('checked', 'checked');
			$( "input[name="+radioId+"]" ).val( $( this).html() );
	    });

	});
</script>
</block>

<block name="main">
	<include file="Public/top" />
	<div class="main">

		<!--收货地址-->
		<div class="step1">
			<!--收货人信息-->
			<if condition="count($address) gt 0">
				<a href="javascript:void(0);" class="addressListObjBtn">
			<else />
				<a href="{:U('Address/add')}">
			</if>
				<b class="borderT"></b>
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
					<p style="text-align:center;padding:10px 0px;">还没有收货地址，点我添加收货地址</p>
				</if>
				<b class="borderB"></b>
			</a>
		</div>

		<!--支付方式-->
		<div class="step2">
			<span class="step2_T">支付方式</span>
			<div class="step2_fun">
				<span class="step2_btn_df">
					<if condition="$post['pay_way'] eq '现金/刷卡'">
						<label class="checked" name="pay_way">现金/刷卡</label>
					<else />
						<label class="default" name="pay_way">现金/刷卡</label>
					</if>
				</span>
				<span class="step2_btn_df">
					<if condition="$post['pay_way'] eq '网上支付'">
						<label class="checked" name="pay_way">网上支付</label>
					<else />
						<label class="default" name="pay_way">网上支付</label>
					</if>
				</span>
			</div>
			<input type="hidden" name="pay_way" value="{$post['pay_way']}" />
		</div>

		<!--发票信息-->
		<div class="step3">
			<span class="step3_T">发票信息</span>
			<div class="step3_fun">
				<div class="step3_type">
					<span class="step3_title">发票类型：</span>
					<span class="step3_btn_df">
						<label class="fp" name="invoice_type">普通发票</label>
					</span>
					<span class="step3_btn_df">
						<label class="checked" name="invoice_type">不要发票</label>
					</span>
					<input type="hidden" name="invoice_type" value="不要发票" />
				</div>

				<div class="step3_type">
					<span class="step3_title">发票抬头：</span>
					<span class="step3_btn_df">
						<label class="type" name="invoice_top">个人</label>
					</span>
					<span class="step3_btn_df">
						<label class="type" name="invoice_top">单位</label>
					</span>
					<input type="hidden" name="invoice_top" value="" />

					<input type="text" name="invoice_top_company" class="fp_title" />
				</div>

				<div class="step3_type">
					<span class="step3_title">发票内容：</span>

					<input type="text" name="invoice_intro" class="fp_title" />
				</div>

			</div>

		</div>

		<!--留言-->
		<div class="step3">
			<span class="step3_T">订单说明</span>
			<div class="step3_fun">
				<textarea name="content" style="width:100%;min-height:100px;resize:none;">{$post['content']}</textarea>
			</div>
		</div>

		<!--商品信息-->
		<div class="step4">
			<div class="shop_info" style="border-top:none">				
				<div class="actual_price">
					<input type="hidden" name="price" value="{$post['money']}" />
					实际付款：<span>{$post['money']}元</span>
				</div>

				<div class="actual_price">
					<a href="javascript:void(0);" class="add_order_send">提交订单</a>
				</div>
				<script type="text/javascript" src="__JS__/facePay.js"></script>
			</div>
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
		<p><br /></p>
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
				<!--a class="bj_info" href="{:U('Address/edit/id/'.$volist['id'])}"><span></span></a-->
			</li>
		</volist>
		</ul>
		<!--a class="add_address" href="{:U('Address/add')}">+新建地址</a>
		<a class="add_address close" href="javascript:void(0);">关闭</a-->
	</div>
	
</block>