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
</block>

<block name="main">
	
	<!-- 面包屑导航 -->
    <nav class="breadcrumb">
        <i class="Hui-iconfont">&#xe67f;</i>&nbsp;首页
        <span class="c-gray en">&gt;</span>&nbsp;会员管理
        <span class="c-gray en">&gt;</span>&nbsp;钱包充值明细
        <a class="btn btn-success radius r mr-20" id="RefreshButton" href="javascript:void(0);" title="刷新">
            <i class="Hui-iconfont">&#xe68f;</i>
        </a>
    </nav>
    
    <div class="pd-20">
    	
    	<!-- 条件查询 -->
        <div class="text-c">
            <form action="" method="post">
                <!-- 查询功能 -->
                <!-- 搜索按钮 -->
                <button type="submit" class="btn btn-success radius relative" id="" name="">
                    <i class="Hui-iconfont">&#xe665;</i>&nbsp;查询
                </button>
            </form>
        </div>
        
        <!-- 操作 -->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <!-- 操作按钮 -->
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
                        <th width="5%">编号</th>
                        <th width="15%">会员账号</th>
                        <th width="10%">真实姓名</th>
                        <th width="10%">幸运号</th>
                        <th width="10%">钱包收支</th>
                        <th width="10%">钱包金额</th>
                        <th width="10%">钱包余额</th>
                        <th width="15%">记录时间</th>
                        <th width="25%">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <volist name="dataList" id="volist">
                        <tr class="text-c">
                            <td>
                                <input type="checkbox" value="{$volist['id']}" name="dataId">
                            </td>
                            <td>{:( $page['pageNum'] - 1 ) * $page['numperpage'] + ( $key + 1 )}</td>
                            <td>{$volist['username']}</td>
                            <td>{$volist['nickname']}</td>
                            <td>{$volist['referral_code']}</td>
                            <td>{$volist['type_name']}</td>
                            <td>
                            	<if condition="$volist['price'] gt 0">
									<span class="fr detail-money color_green">+{$volist['price']}元</span>
								<else />
									<span class="fr detail-money color_red">{$volist['price']}元</span>
								</if>
                            	
                            </td>
                            <td>{$volist['balance']}</td>
                            <td>{$volist['create_time']|date='Y-m-d H:i:s',###}</td>
                            <td class="td-manage"></td>
                        </tr>
                    </volist>
                </tbody>
            </table>
        </div>
    </div>
</block>
