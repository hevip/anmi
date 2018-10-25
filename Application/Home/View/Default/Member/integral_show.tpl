<extend name="Base/common" />

{// css样式区 }
<block name="link">
	<style type="text/css">
	.duihuan_sub span
	{ width:100%; line-height:30px; color:red; text-align:center; display:block; padding:10px; }
	.duihuan_sub span.blue
	{ color:blue; }
	.duihuan_sub span.green
	{ color:green; }
	</style>
</block>

<block name="jscript">
</block>

<block name="main">
	<include file="Public/top" />
	<!--详情-->
	<div class="duihuan">
	    {$dataInfo['month']}&nbsp;享豆汇总
	</div>
	<!-- table-->
	<div class="geren_d duihuan_div">
	    <!--table-->
	    <form action="">
	        <table>
	            <tr>
                        <td class="bg_td"></td>
                        <td>成交额</td>
                        <td>订单数</td>
                        <td>享豆</td>
                    </tr>
                    <tr>
                        <td>线上下单</td>
                        <td>{$monthInfo['chuji_price']}</td>
                        <td>{$monthInfo['chuji_order']}</td>
                        <td>{$monthInfo['chuji_jifen']}</td>
                    </tr>
                    <tr>
                        <td>分享宣传</td>
                        <td>{$monthInfo['gaoji_price']}</td>
                        <td>{$monthInfo['gaoji_order']}</td>
                        <td>{$monthInfo['gaoji_jifen']}</td>
                    </tr>
                    <tr>
                        <td>引荐产品</td>
                        <td>{$monthInfo['product_price']}</td>
                        <td>{$monthInfo['product_order']}</td>
                        <td>{$monthInfo['product_jifen']}</td>
                    </tr>
                    <tr>
                        <td>总计</td>
                        <td><!--{$monthInfo['product_price'] + $monthInfo['gaoji_price'] + $monthInfo['chuji_price']}--></td>
                        <td><!--{$monthInfo['product_order'] + $monthInfo['gaoji_order'] + $monthInfo['chuji_order']}--></td>
                        <td>{$monthInfo['product_jifen'] + $monthInfo['gaoji_jifen'] + $monthInfo['chuji_jifen']}</td>
                    </tr>
	        </table>
	        <div class="duihuan_sub">
				<if condition="$dataInfo['status'] eq 0">
		        	<if condition="$dataInfo['end'] lt $theTime">
		            	<input type="button" value="提交" class="integralSend" data="{$dataInfo['id']}" />
					<else />
						<span>非常抱歉，本月的享豆还不能兑换</span>
					</if>
				<elseif condition="$dataInfo['status'] eq 1" />
						<span class="blue">正在申请中...</span>
				<elseif condition="$dataInfo['status'] eq 2" />
					<span class="green">享豆已兑换</span>
				</if>
	        </div>
	    </form>
	</div>
	<script type="text/javascript" src="__JS__/integral_show.js"></script>
</block>