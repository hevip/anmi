<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>

<block name="jscript">
</block>

<block name="main">
	<include file="Public/top" />
	<!-- 分类-->
	<div class="div_table">
	    <form action="">
	        <table>
	            <tr>
	                <th>月份</th>
	                <th>状态</th>
	                <th>操作</th>
	            </tr>
				<volist name="dataList" id="volist">
		            <tr>
		                <td>{$volist['month']}</td>
						<if condition="$volist['status'] eq 0">
		                	<td class="green_td">未兑换</td>
						<elseif condition="$volist['status'] eq 1" />
		                	<td class="red_td">兑换中</td>
						<elseif condition="$volist['status'] eq 2" />
		                    <td class="black_td">已兑换</td>
						</if>
		                <td>
			                <if condition="$volist['status'] eq 0">
			                	<a class="white_a" href="{:U('Member/integral_show/id/'.$volist['id'])}">立即兑换</a>
							<else />
			                    <a class="bl_a" href="{:U('Member/integral_show')}">查看</a>
							</if>
						</td>
		            </tr>
				</volist>
	        </table>
	    </form>
	</div>
</block>