<extend name="Base/common" />

<block name="link"></block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/member_withdraw.js"></script>
	<script>
		$(function(){
			$.Showmsg('aaa');
		})
	
	</script>
</block>

<block name="main">
	<div class="pd-20">
		<a id="RefreshButton" href="javascript:void(0);"></a>
		
		<!-- 订单详情 -->
		<table class="table table-border table-bordered table-hover table-bg table-sort">
			<thead>
		        <tr>
		            <th colspan="4">提现信息</th>
		        </tr>
			</thead>
			<tbody>
				<tr>
					<td width="10%">用户名</td>
					<td width="40%">{$dataInfo['member_username']}</td>
					<td width="10%">提现类型</td>
					<td width="40%">{$dataInfo['type_name']}</td>
				</tr>
				<tr>
					<td>幸运号</td>
					<td>{$dataInfo['referral_code']}</td>
					<td>提现金额</td>
					<td style="color:red;font-weight:bold;">￥{$dataInfo['price']}元</td>
				</tr>
				<tr>
					<td>微信昵称</td>
					<td>{:json_decode($dataInfo['wx_name'])}</td>
					<td>申请状态</td>
					<td>
						<if condition="$dataInfo['status'] eq 2">
							<span class="color_green">已打款</span>
						<elseif condition="$dataInfo['status'] eq 1" />
							<span class="color_red">未打款</span>
						<else />
							<span>未知状态</span>
						</if>
					</td>
				</tr>
				<tr>
					<td>申请时间</td>
					<td>{$dataInfo['create_time']|date='Y-m-d H:i:s',###}</td>
					<td></td>
					<td></td>
				</tr>
				<if condition="$dataInfo['status'] eq 1">
					<tr>
						<td>操作</td>
						<td colspan="3">
							<if condition="$dataInfo['type'] eq 26">
								<a href="{:U('MemberWithdraw/handleWebchat',array('id'=>$dataInfo['id']))}" class="color_blue">提到用户微信钱包</a>
							<elseif condition="$dataInfo['type'] eq 28" />
								<a href="javascript:void(0);" class="handleBank color_blue" data-id="{$dataInfo['id']}">设为已打款</a>
							<else />
								未知的处理方式
							</if>
						</td>
					</tr>
				</if>
			</tbody>
		</table>

		<if condition="$dataInfo['type'] eq 28">
			<!-- 银行信息 -->
			<table class="table table-border table-bordered table-hover table-bg table-sort mt-20">
		    	<thead>
			        <tr>
			            <th colspan="4">银行信息</th>
			        </tr>
				</thead>
				<tbody>
					<tr>
						<td width="10%">户名</td>
						<td width="40%">{$dataInfo['bank_name']}</td>
						<td width="10%">开户行</td>
						<td width="40%">{$dataInfo['bank_type']}</td>
					</tr>
					<tr>
						<td width="10%">卡号</td>
						<td width="40%">{$dataInfo['bank_id']}</td>
						<td width="10%">开户网点</td>
						<td width="40%">{$dataInfo['bank_hang']}</td>
					</tr>
				</tbody>
			</table>
		</if>
	</div>
</block>