<extend name="Base/common" />

<block name="link"></block>

<block name="jscript">
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/My97DatePicker/WdatePicker.js"></script> 
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="__JS__/list-page.js"></script>
	<script type="text/javascript" src="__JS__/commodity.js"></script>
</block>

<block name="main">
	
	<!-- 面包屑导航 -->
	<nav class="breadcrumb">
	    <i class="Hui-iconfont">&#xe67f;</i>&nbsp;首页
		<span class="c-gray en">&gt;</span>&nbsp;积分商城
		<span class="c-gray en">&gt;</span>&nbsp;商品管理
		<a class="btn btn-success radius r mr-20" id="RefreshButton" href="javascript:void(0);" title="刷新">
			<i class="Hui-iconfont">&#xe68f;</i>
		</a>
	</nav>
	
	<div class="pd-20">
		<!-- 条件查询 -->
	    <div class="text-c">
	    	<form action="" method="post">
		    	<!-- 商品名称 -->
				<input type="text" name="tilte" value="{$paramter['title']}" placeholder="输入商品名称" class="input-text radius width-200" />
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
				<a href="" class="btn btn-success radius">
					<i class="Hui-iconfont">&#xe68f;</i>&nbsp;所有商品
				</a>
				<a href="javascript:void(0);" onclick="layer_full('添加商品','__URL__/add','','');" class="btn btn-primary radius">
					<i class="Hui-iconfont">&#xe600;</i>&nbsp;添加商品
				</a>
				<a href="javascript:void(0);" id="BatchSequence" class="btn btn-secondary radius">
					<i class="Hui-iconfont">&#xe675;</i>&nbsp;排序
				</a>
	        	<a href="javascript:void(0);" class="btn btn-danger radius BatchRemove">
	        		<i class="Hui-iconfont">&#xe6e2;</i>&nbsp;批量删除
				</a>
			</span>
	        <span class="r">共有数据：<strong>{$dataList|count}</strong> 条</span>
	    </div>
	    
	    <!-- 列表 -->
	    <div class="mt-20">
	        <table class="table table-border table-bordered table-hover table-bg table-sort">
	            <thead>
	                <tr class="text-c">
			            <th width="2%"><input type="checkbox" group="id" class="checkboxCtrl" ></th>
			            <th width="8%">编号</th>
			            <th width="35%">商品名称</th>
			            <th width="30%">封面图</th>
			            <th width="12%">所需积分</th>
			            <th width="8%">排序</th>
			            <th width="10%">操作</th>
	                </tr>
	            </thead> 
	            <tbody>
	            	<volist name="dataList" id="volist">
	            		<tr class="text-c">
		                    <td><input name="id" value="{$volist['id']}" type="checkbox"></td>
		                    <td>{$volist.id}</td>
		                    <td>{$volist.title}</td>
		                    <td><if condition="$volist['picture'] eq ''">
									无
								<else />
									<a href="__ROOT__/{$volist['picture']}" title="{$volist['title']}" target="_blank">
										<img src="__ROOT__/{$volist['picture']}" height="25" alt="{$volist['title']}" />
									</a>
		                    	</if></td>
		                    <td>{$volist.integral}</td>
		                    <td>{$volist.sort}</td>
		                    <td class="td-manage">
		                        <a href="javascript:void(0);" onclick="layer_full('编辑商品','__URL__/edit/id/{$volist['id']}','','');" title="编辑商品" class="ml-5">
		                        	<i class="Hui-iconfont">&#xe6df;</i>
								</a>
		                        <a href="javascript:void(0);" data-id="{$volist['id']}" title="删除" class="ml-5 singleRemove">
		                        	<i class="Hui-iconfont">&#xe6e2;</i>
								</a>
		                    </td>
	            		</tr>
	            	</volist>
	            </tbody>
	        </table>
	    </div>
	</div>
</block>