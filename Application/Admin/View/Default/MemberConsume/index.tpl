<extend name="Base/common" />

<block name="link">
    <style type="text/css">
        .input-text { margin-bottom:5px; }
        .relative,.select-box { position:relative; top:-3px; }
    </style>
</block>

<block name="jscript">
    <script type="text/javascript" src="__PLUGIN_H-ui__/lib/My97DatePicker/WdatePicker.js"></script> 
    <script type="text/javascript" src="__PLUGIN_H-ui__/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="__JS__/list-page.js"></script>
    <script type="text/javascript" src="__JS__/commodity.js"></script>
    <script type="text/javascript">
    $(function(){});
    </script>
</block>

<block name="main">
	
	<!-- 面包屑导航 -->
    <nav class="breadcrumb">
        <i class="Hui-iconfont">&#xe67f;</i>&nbsp;首页
        <volist name="crumb" id="crumb_v">
    		<span class="c-gray en">&gt;</span>&nbsp;{$crumb_v}
 		</volist>
        <a class="btn btn-success radius r mr-20" id="RefreshButton" href="javascript:void(0);" title="刷新">
            <i class="Hui-iconfont">&#xe68f;</i>
        </a>
    </nav>
    
    <div class="pd-20">
    	
    	<!-- 条件查询 -->
        <div class="text-c">
            <form action="" method="post">
                <!-- 用户名 -->
                <input type="text" name="username" value="{$search['username']}" placeholder="输入用户名" class="input-text radius width-200" />
                <!-- 姓名 -->
                <input type="text" name="order_id" value="{$order_id}" placeholder="订单编号" class="input-text radius width-200" />
                				<!-- 搜索按钮 -->
                <button type="submit" class="btn btn-success radius relative" id="" name="">
                    <i class="Hui-iconfont">&#xe665;</i>&nbsp;查询
                </button>
            </form>
        </div>
        
        <!-- 操作 -->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <a href="javascript:void(0);" class="btn btn-danger radius BatchRemove">
                    <i class="Hui-iconfont">&#xe6e2;</i>&nbsp;批量删除
                </a>
                <a href="__URL__/indexexcel" class="btn btn-danger radius">
                    <i class="Hui-iconfont">&#xe6e2;</i>&nbsp;导出消费
                </a>
            </span>
            <span class="r">共有数据：<strong>{$dataList|count}</strong> 条</span>
        </div>
        
        <!-- 列表 -->
        <div class="mt-20">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th width="2%">
                            <input type="checkbox" name="" value="">
                        </th>
                        <th width="3%">编号</th>
			            <th>消费用户幸运号</th>
			            <th>来源订单</th>
			            <th>消费金额</th>
			            <th>提成金额</th>
			            <th width="10%">创建时间</th>
                    </tr>
                </thead>
                <tbody>
        			<volist name="dataList" id="volist">
                        <tr class="text-c">
                            <td>
                                <input type="checkbox" value="{$volist['id']}" name="dataId">
                            </td>
                            <td>{:( $page['pageNum'] - 1 ) * $page['numperpage'] + ( $key + 1 )}</td>
                            <td>{$volist['nickname']}</td>
		                    <td>
		                    	<a href="{:U('Admin/Order/show/id/'.$volist['order']['id'])}" target="navTab" rel="ordershow" class="alink1" title="订单详情">
		                    		{$volist['order']['order_id']}
								</a>
							</td>
		                    <td>{$volist['consume_price']}</td>
		                    <td>{$volist['mission_price']}</td>
		                    <td>{$volist['create_time']}</td>
		                </tr>
                    </volist>
                </tbody>
            </table>
        </div>
    </div>
</block>
