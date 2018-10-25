<extend name="Base/common" />

<block name="link"></block>

<block name="jscript">
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="__JS__/list-page.js"></script>
</block>

<block name="main">
	<nav class="breadcrumb">
	    <i class="Hui-iconfont">&#xe67f;</i>&nbsp;首页
		<span class="c-gray en">&gt;</span>&nbsp;管理员管理
		<span class="c-gray en">&gt;</span>&nbsp;审批人列表
		<a class="btn btn-success radius r mr-20" id="RefreshButton" href="javascript:void(0);" title="刷新">
			<i class="Hui-iconfont">&#xe68f;</i>
		</a>
	</nav>
	<div class="pd-20">
	    <div class="text-c" style="text-align: left">
	    	<!--<form action="" method="post">
	    		<input type="hidden" name="pid" value="{$paramter['pid']}" />
		    	<!-- 群组标题 -->
				<!--<input type="text" name="title" value="{$paramter['title']}" placeholder="输入群组名称" class="input-text radius width-200" />
				<!-- 搜索按钮 -->
		        <!--<button type="submit" class="btn btn-success radius" id="" name="">
		            <i class="Hui-iconfont">&#xe665;</i>&nbsp;搜群组
		        </button>
	    	</form>-->
			<form action="" method="post">
				<input type="text" name="personal_code" value="" placeholder="输入个人代号" class="input-text radius width-200" />
				<input type="text" name="tel" value="" placeholder="输入手机号" class="input-text radius width-200" />
				<button type="submit" class="btn btn-success radius relative" id="" name="">
					<i class="Hui-iconfont">&#xe665;</i>&nbsp;查询
				</button>
			</form>
	    </div>
	    <div class="cl pd-5 bg-1 bk-gray mt-20">
	        <span class="l">
	        	 <a href="" class="btn btn-success radius">
					 <i class="Hui-iconfont">&#xe68f;</i>&nbsp;全部用户
				 </a>
				<!--<a href="javascript:void(0);" onclick="layer_show('添加群组','__URL__/add/pid/{$paramter['pid']}','600','350')" class="btn btn-primary radius">
					<i class="Hui-iconfont">&#xe600;</i>&nbsp;添加审批人
				</a>-->
				<!--<a href="javascript:void(0);" id="BatchSequence" class="btn btn-secondary radius">
					<i class="Hui-iconfont">&#xe675;</i>&nbsp;排序
				</a>
	        	<a href="javascript:void(0);" class="btn btn-danger radius BatchRemove">
	        		<i class="Hui-iconfont">&#xe6e2;</i>&nbsp;批量删除
				</a>-->
			</span>
	        <span class="r">共有数据：<strong>{$dataList|count}</strong> 条</span>
	    </div>
	    <div class="mt-20">
	        <table class="table table-border table-bordered table-hover table-bg table-sort">
	            <thead>
	                <tr class="text-c">
	                   <!-- <th width="3%">
	                        <input type="checkbox" name="" value="">
	                    </th>-->
						<th width="3%">序号</th>
						<th width="5%">代号</th>
						<th width="10%">绑定电话</th>
						<th width="10%">昵称</th>
						<th width="10%">单位</th>
						<th width="10%">部门</th>
						<th width="10%">用户类型</th>
						<th width="10%">创建时间</th>
						<!--<th width="5%">状态</th>-->
						<th width="7%">操作</th>
	                </tr>
	            </thead>
	            <tbody>
			        <volist name="dataList" id="vo" key="k">
		                <tr class="text-c">
		                 <!--   <td>
		                        <input type="checkbox" value="{$volist['id']}" name="dataId">
		                    </td>-->
		                    <td>{$k}</td>
							<td>{$vo.personal_code}</td>
			                <td>{$vo.username}</td>
			                <td>{$vo.nickname}</td>
			                <td>{$vo.cid}</td>
			                <td>{$vo.department_id}</td>
			                <td>{$vo.auth}</td>
			                <td>{$vo.create_time|date='Y-m-d H:i:s',###}</td>
							<!--<td class="td-status">
				                <if condition="$vo.status eq 0">
				                	<span class="label label-success radius">已启用</span>
				                <else />
				                	<span class="label label-danger radius">已停用</span>
				                </if>
							</td>-->
		                    <td class="td-manage">
		                    	<if condition="$vo['status'] eq 1">
			                    	<a href="{:U('status')}?id={$vo['id']}&status=0"   data-status="0" title="已禁用">
			                    		<i class="Hui-iconfont">&#xe631;</i>
									</a>
								<else />
			                        <a href="{:U('status')}?id={$vo['id']}&status=1"   data-status="1" title="已启用">
			                        	<i class="Hui-iconfont">&#xe6e1;</i>
									</a>
								</if>
		                        <a href="{:U('userRole/edit')}?id={$vo['id']}"  title="修改" class="ml-5">
		                        	<i class="Hui-iconfont">&#xe6df;</i>
								</a>
		                      <!--<a href="javascript:void(0);" onclick="layer_show( '授权', '__URL__/auth.html?id={$volist['id']}', '350', '500' );" title="授权" class="ml-5">
		                        	<i class="Hui-iconfont">&#xe64b;</i>
								</a>-->
		                        <a href="{:U('del')}?id={$vo['id']}" data-id="{$vo['id']}" title="删除" class="ml-5 ">
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
