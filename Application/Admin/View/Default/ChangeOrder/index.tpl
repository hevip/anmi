<extend name="Base/common" />

<block name="link"></block>

<block name="jscript">
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/My97DatePicker/WdatePicker.js"></script> 
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="__JS__/list-page.js"></script>
	<script type="text/javascript" src="__JS__/order.js"></script>
</block>

<block name="main">
	
	<!-- 面包屑导航 -->
	<nav class="breadcrumb">
	    <i class="Hui-iconfont">&#xe67f;</i>&nbsp;首页
		<span class="c-gray en">&gt;</span>&nbsp;积分商城
		<span class="c-gray en">&gt;</span>&nbsp;兑换订单
		<a class="btn btn-success radius r mr-20" id="RefreshButton" href="javascript:void(0);" title="刷新">
			<i class="Hui-iconfont">&#xe68f;</i>
		</a>
	</nav>
	
	<div class="pd-20">
		<!-- 条件查询 -->
	    <div class="text-c">
	    	<form action="" method="post">
		    	<!-- 商品名称 -->
				<input type="text" name="order_id" value="{$paramter['order_id']}" placeholder="输入订单编号" class="input-text radius width-200" />
		    	<!-- 开始日期 -->
				<input type="text" name="start_time" value="{$paramter['start_time']}" id="datemin" placeholder="开始日期" class="input-text radius Wdate width-200">
				-
		    	<!-- 结束日期 -->
				<input type="text" name="end_time" value="{$paramter['end_time']}" id="datemax" placeholder="结束日期" class="input-text radius Wdate width-200">
				<!-- 搜索按钮 -->
		        <button type="submit" class="btn btn-success radius" id="" name="">
		            <i class="Hui-iconfont">&#xe665;</i>&nbsp;查询
		        </button>
	    	</form>
	    </div>
	    
	    <!-- 操作 -->
	    <div class="cl pd-5 bg-1 bk-gray mt-20">
	        <span class="l">
				<a href="javascript:void(0);" onclick="layer_show('发货','__URL__/edit/id/{sid_user}','','510')" class="btn btn-primary radius">
					<i class="Hui-iconfont">&#xe600;</i>&nbsp;发货
				</a>
			</span>
	        <span class="r">共有数据：<strong>{$dataList|count}</strong> 条</span>
	    </div>
	    
	    <!-- 列表 -->
	    <!-- 列表 -->
	    <div class="mt-20">
	        <table class="table table-border table-bordered table-hover table-bg table-sort">
	            <thead>
	                <tr class="text-c">
	                    <th width="3%">
	                        <input type="checkbox" name="" value="">
	                    </th>
			            <th width="8%">编号</th>
			            <th width="15%">订单号</th>
			            <th width="10%">兑换人</th>
			            <th width="30%">兑换商品</th>
			            <th width="12%">兑换时间</th>
			            <th width="13%">运单号</th>
			            <th width="15%">发货状态</th>
	                </tr>
	            </thead>
	            <tbody>
			        <volist name="dataList" id="volist">
		                <tr class="text-c">
	                    <td class="txtMid"><input name="id" value="{$volist['id']}" type="checkbox"></td>
	                    <td>{$volist.id}</td>
	                    <td>{$volist.order_id}</td>
	                    <td>{$volist.username}</td>
	                    <td>{$volist.goodsname}</td>
	                    <td>{$volist.add_time|date='Y-m-d H:i:s',###}</td>
	                    <td>{$volist.send_id}</td>
	                    <td><if condition="$volist['is_send'] == 0">
		                        <span style="color:red;" class="span_green" >未发货</span>
		                    </if>
		                    <if condition="$volist['is_send'] == 1">
		                        <span style="color:green;" class="span_green" >已发货</span>
		                    </if>
	                    </td>
		                </tr>
			        </volist>
	            </tbody>
	        </table>
	    </div>
	</div>
</block>