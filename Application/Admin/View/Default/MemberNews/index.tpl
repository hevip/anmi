<extend name="Base/common" />

<block name="link"></block>

<block name="jscript">
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/My97DatePicker/WdatePicker.js"></script> 
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="__JS__/list-page.js"></script>
	<script type="text/javascript">
	$(function(){
		// 日期选择范围
		$( '#datemin' ).focus( function() {
			WdatePicker({});
		} );
		$( '#datemax' ).focus( function() {
			WdatePicker({});
		} );
	});
	</script>
</block>

<block name="main">
	
	<!-- 面包屑导航 -->
	<nav class="breadcrumb">
	    <i class="Hui-iconfont">&#xe67f;</i>&nbsp;首页
		<span class="c-gray en">&gt;</span>&nbsp;反馈意见
		<a class="btn btn-success radius r mr-20" id="RefreshButton" href="javascript:void(0);" title="刷新">
			<i class="Hui-iconfont">&#xe68f;</i>
		</a>
	</nav>
	
	<div class="pd-20">
		<!-- 条件查询 -->
		<!--<div class="text-c">
			<form action="" method="post">
				<!-- 消息来源 -->
		<!-- <span class="select-box radius width-130">
					<select name="source" class="select">
						<option value="">请选择</option>
						<volist name="sourceArray" id="volist">
		            		<option value="{$volist}"<if condition="$volist eq $paramter['source']">selected="selected"</if>>{$volist}</option>
						</volist>
	            	</select>
				</span>
		    	<!-- 开始日期 -->
		<!-- <input type="text" name="start_time" value="{$paramter['start_time']}" id="datemin" placeholder="开始日期" class="input-text radius Wdate width-200">
				-
		    	<!-- 结束日期 -->
		<!-- <input type="text" name="end_time" value="{$paramter['end_time']}" id="datemax" placeholder="结束日期" class="input-text radius Wdate width-200">
				<!-- 搜索按钮 -->
		<!--   <button type="submit" class="btn btn-success radius" id="" name="">
              <i class="Hui-iconfont">&#xe665;</i>&nbsp;查询
          </button>
      </form>
  </div>-->
		
		<!-- 操作 -->
		<!-- <div class="cl pd-5 bg-1 bk-gray mt-20">
	        <span class="l">
				<a href="javascript:void(0);" onclick="layer_show('添加','__URL__/send','','510')" class="btn btn-primary radius">
					<i class="Hui-iconfont">&#xe600;</i>&nbsp;添加
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
			            <!--<th width="4%" class="txtMid"><input type="checkbox" group="id" class="checkboxCtrl" ></th>-->
			            <th width="4%">序号</th>
			            <th width="10%">反馈人代号</th>
			            <th width="10%">反馈内容</th>
			            <th width="10%">所属单位</th>
			            <th width="10%">所属部门</th>
			            <!--<th width="24%">消息内容</th>-->
			            <th width="10%">反馈时间</th>
			            <th width="10%">操作</th>
			        </tr>
		        </thead>
		        
		        <tbody>
		       <!-- <if condition="$dataList|count gt 0">-->
		            <volist name="dataList" id="volist" key="k">
		                <tr target="sid_user" rel="{$volist['id']}" class="text-c">
		                    <!--<td class="txtMid"><input name="id" value="{$volist['id']}" type="checkbox"></td>
		                    <td class="txtMid">{$key+1}</td>-->
		                    <td>{$k}</td>
		                    <td>{$volist['personal_code']}</td>
		                    <td>{$volist['content']}</td>
		                    <td>{$volist['companyname']}</td>
		                    <td>{$volist['department_name']}</td>
		                    <!--<td>
		                    	<div class="txtBox">{$volist['intro']}</div>
		                    </td>-->
		                    <td>{$volist['create_time']|date='Y-m-d H:i:s',###}</td>
							<td class="td-manage">
								<a href="{:U('del')}?id={$volist['id']}" data-id="{$volist['id']}" title="删除" >
									<i class="Hui-iconfont">&#xe6e2;</i>
								</a>
							</td>
		                </tr>
		            </volist>
		        <!--<else />
		        	<tr><td colspan="10" style="text-align:center;">没有数据!!!</td></tr>
		        </if>-->
		        </tbody>  
			</table>
		</div>
	</div>
</block>



