<extend name="Base/common" />

<block name="link"></block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/order.js"></script>
</block>

<block name="main">
	<div class="pd-20">
		<a id="RefreshButton" href="javascript:void(0);"></a>
		<div id="speed">				
			<div class="line"></div>
			<if condition="$dataInfo['is_pay'] eq 1">
				<ul class="step2">
			<elseif condition="$dataInfo['is_complete'] eq 1" />
				<ul class="step3">
			<else />
				<ul class="step1">
			</if>
				<li>
					<span></span>
					<div class="step_line"></div>
					<div class="text">
						<p>买家下单</p>
						<p>{$dataInfo['create_time']?$dataInfo['create_time']|date='Y-m-d H:i:s',###:''}</p>
					</div>
				</li>
				<li>
					<span></span>
					<div class="step_line"></div>
					<div class="text">
						<p>付款成功</p>
						<p>{$dataInfo['pay_time']?$dataInfo['pay_time']|date='Y-m-d H:i:s',###:''}</p>
					</div>
				</li>
				<li>
					<span></span>
					<div class="step_line"></div>
					<div class="text">
						<p>已完成</p>
						<p>{$dataInfo['complete_time']?$dataInfo['complete_time']|date='Y-m-d H:i:s',###:''}</p>
					</div>
				</li>
			</ul>
		</div>
		<!-- 订单详情 -->
		<table class="table table-border table-bordered table-hover table-bg table-sort">
			<thead>
		        <tr>
		            <th colspan="4">订单详情</th>
		        </tr>
			</thead>
			<tbody>
				<tr>
					<td width="10%">订单编号</td>
					<td width="40%">{$dataInfo['order_id']}</td>
					<td width="10%">下单人</td>
					<td width="40%">{$dataInfo['nickname']}</td>
				</tr>
				<tr>
					<td>订单价格</td>
					<td>{$dataInfo['price']}</td>
					<td>商品个数</td>
					<td>{$dataInfo['num']}</td>
				</tr>
				<tr>
					<td>钱包支付</td>
					<td>{$dataInfo['money']}</td>
					<td>现金支付</td>
					<td>
						{$dataInfo['price'] - $dataInfo['money']}
					</td>
				</tr>
				<tr>
					<td>下单时间</td>
					<td>{$dataInfo['create_time']|date="Y-m-d H:i",###}</td>
					<td>付款方式</td>
					<td>{$dataInfo['pay_way']}</td>
				</tr>
				<tr>
					<td>买家留言</td>
					<td>{$dataInfo['content']}</td>
					<td>付款状态</td>
					<td>
						<if condition="$dataInfo['is_pay']">
							<span class="color_green">已付款</span>
						<else />
							<span class="color_red">未付款</span>
						</if>
					</td>
				</tr>
			</tbody>
		</table>
		
		<!-- 发票详情 -->
		<table class="table table-border table-bordered table-hover table-bg table-sort mt-20">
	    	<thead>
		        <tr>
		            <th colspan="4">发票详情</th>
		        </tr>
			</thead>
			<tbody>
				<tr>
					<td width="10%">发票类型</td>
					<td width="40%">{$dataInfo['invoice_type']}</td>
					<td width="10%">发票抬头</td>
					<td width="40%">
						<if condition="$dataInfo['invoice_top'] eq '单位'">
							{$dataInfo['invoice_top']}：{$dataInfo['invoice_top_company']}
						<else />
							{$dataInfo['invoice_top']}
						</if>
					</td>
				</tr>
				<tr>
					<td>发票内容</td>
					<td colspan="3">{$dataInfo['invoice_intro']}</td>
				</tr>
			</tbody>
		</table>
		
		<!-- 发货地址 -->
		<table class="table table-border table-bordered table-hover table-bg table-sort mt-20">
	    	<thead>
		        <tr>
		            <th colspan="4">发货地址</th>
		        </tr>
			</thead>
			<tbody>
				<tr>
					<td width="10%">收货人</td>
					<td width="40%">{$dataInfo['addressInfo']['nickname']}</td>
					<td width="10%">电话号码</td>
					<td width="40%">{$dataInfo['addressInfo']['tel']}</td>
				</tr>
				<tr>
					<td>邮政编码</td>
					<td>{$dataInfo['addressInfo']['code']}</td>
					<td>地址</td>
					<td>
						{$dataInfo['addressInfo']['provinceString']}-
						{$dataInfo['addressInfo']['cityString']}-
						{$dataInfo['addressInfo']['areaString']}-
						{$dataInfo['addressInfo']['intro']}
					</td>
				</tr>
			</tbody>
		</table>
		<!-- 商品详情 -->
		<table class="table table-border table-bordered table-hover table-bg table-sort mt-20">
	    	<thead>
		        <tr>
		            <th colspan="10">
		            	商品详情
		            	<if condition="$dataInfo['is_pay'] eq 1">
			            	<a href="javascript:void(0);" class="btn btn-primary radius BatchDeliverGoods" style="float:right;">
				        		<i class="Hui-iconfont">&#xe634;</i>&nbsp;批量发货
							</a>
						</if>
		            </th>
		        </tr>
				<tr class="center">
					<th class="text-c">
						<input type="checkbox" name="" value="">
					</th>
					<th>商品图片</th>
					<th>商品标题</th>
					<th>商品个数</th>
					<th>总价格</th>
					<th>快递名称</th>
					<th>快递单号</th>
					<th>发货时间</th>
					<th>是否发货</th>
				</tr>
			</thead>
			<tbody>
				<volist name="dataInfo['product']" id="volist">
					<tr class="center">
						<td class="text-c">
	                        <input type="checkbox" value="{$volist['id']}" name="dataId">
	                    </td>
	                    <if condition="$volist['pro_id'] gt 0">
							<td>
								<a href="{:U('/Commodity/show',array('id'=>$volist['pro_id']))}" target="_blank">
									<img src="__ROOT__/{$volist['pro_picture']}" height="30" style="margin:10px;" />
								</a>
							</td>
							<td>
								<a href="{:U('/Commodity/show',array('id'=>$volist['pro_id']))}" target="_blank" class="alink1">
									{$volist['pro_title']}
								</a>
							</td>
						<else />
							<td>
								<a href="javascript:alert('此商品为当面支付，没有详细可查看!');" target="_blank">
									<img src="__ROOT__/Public/Admin/Images/facepay.png" height="30" style="margin:10px;" />
								</a>
							</td>
							<td>
								<a href="javascript:alert('此商品为当面支付，没有详细可查看!');" target="_blank" class="alink1">
									当面支付
								</a>
							</td>
						</if>
						<td>{$volist['num']}</td>
						<td>{$volist['total_money']}</td>
						<td>{$volist['send_company'] ? $volist['send_company'] : '未知'}</td>
						<td>{$volist['send_id'] ? $volist['send_id'] : '未知'}</td>
						<td>
							<if condition="$volist['send_time']">
								{$volist['send_time']|date='Y-m-d H:i:s',###}
							<else />
								未知
							</if>
						</td>
						<td>
							<if condition="$volist['is_send'] eq 0">
								<span class="color_red">未发货</span>
								<if condition="$dataInfo['is_pay'] || $dataInfo['pay_way'] eq '货到付款'">
									<font>&nbsp;|&nbsp;</font>
									<a onclick="layer_show('发货','{:U('Order/deliver_goods',array('id'=>$volist['id']))}','600','350')" href="javascript:void(0);" class="color_blue">发货</a>
								</if>
							<elseif condition="$volist['is_send'] eq 1" />
								<span class="color_green">已发货</span>
								<font>&nbsp;|&nbsp;</font>
								<a onclick="layer_show('物流跟踪','{:U('Order/logistics',array('order_info_id'=>$volist['id']))}','600','350')" href="javascript:void(0);" class="color_blue">物流跟踪</a>
							<elseif condition="$volist['is_send'] eq 2" />
								<span class="color_green">已收货</span>
								<font>&nbsp;|&nbsp;</font>
								<a onclick="layer_show('查看物流','{:U('Order/logistics',array('order_info_id'=>$volist['id']))}','600','350')" href="javascript:void(0);" class="color_blue">查看物流</a>
							</if>
						</td>
					</tr>
				</volist>
			</tbody>
		</table>
	</div>
</block>