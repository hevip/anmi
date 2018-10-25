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
        <span class="c-gray en">&gt;</span>&nbsp;提现管理
        <span class="c-gray en">&gt;</span>&nbsp;提现列表
        <a class="btn btn-success radius r mr-20" id="RefreshButton" href="javascript:void(0);" title="刷新">
            <i class="Hui-iconfont">&#xe68f;</i>
        </a>
    </nav>
    
    <div class="pd-20">
    	
    	<!-- 条件查询 -->
        <div class="text-c">
            <form action="" method="post">
                <!-- 用户名 -->
                <input type="text" name="username" value="{$paramter['username']}" placeholder="输入用户名" class="input-text radius width-200" />
                <!-- 幸运号 -->
                <input type="text" name="referral_code" value="{$paramter['referral_code']}" placeholder="输入幸运号" class="input-text radius width-200" />
                <!-- 开始日期 -->
                <input type="text" name="start_time" value="{$paramter['start_time']}" id="datemin" placeholder="开始日期" class="input-text radius Wdate width-200">
                -
                <!-- 结束日期 -->
                <input type="text" name="end_time" value="{$paramter['end_time']}" id="datemax" placeholder="结束日期" class="input-text radius Wdate width-200">
                <!-- 搜索按钮 -->
                <button type="submit" class="btn btn-success radius relative" id="" name="">
                    <i class="Hui-iconfont">&#xe665;</i>&nbsp;查询
                </button>
            </form>
        </div>
        
        <!-- 操作 -->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <a href="" class="btn btn-success radius">
                    <i class="Hui-iconfont">&#xe68f;</i>&nbsp;全部用户
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
                        <th width="2%">
                            <input type="checkbox" name="" value="">
                        </th>
                        <th width="5%">编号</th>
                        <th width="13%">用户名</th>
                        <th width="10%">幸运号</th>
                        <th width="15%">微信昵称</th>
                        <th width="10%">提现金额</th>
                        <th width="10%">提现类型</th>
                        <th width="15%">申请时间</th>
                        <th width="10%">状态</th>
                        <th width="10%">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <volist name="dataList" id="volist">
                        <tr class="text-c">
                            <td>
                                <input type="checkbox" value="{$volist['id']}" name="dataId">
                            </td>
                            <td>{:( $page['pageNum'] - 1 ) * $page['numperpage'] + ( $key + 1 )}</td>
                            <td>{$volist['member_username']}</td>
                            <td>{$volist['referral_code']}</td>
                            <td>{:json_decode($volist['wx_name'])}</td>
                            <td>{$volist['price']}</td>
                            <td>
                                <if condition="$volist['type_name'] neq ''">
                                    {$volist['type_name']}
                                <else />
                                    未知
                                </if>
                            </td>
                            <td>{$volist['create_time']|date='Y-m-d H:i:s',###}</td>
                            <td>
                                <if condition="$volist['status'] eq 1">
                                    <span class="color_red">未打款</span>
                                <elseif condition="$volist['status'] eq 2" />
                                    <strong class="color_green">已打款</strong>
                                <else />
                                    未知
                                </if>
                            </td>
                            <td class="td-manage">
                                <a href="javascript:void(0);" onclick="layer_full('提现记录详情','__URL__/show/id/{$volist['id']}','','');" data-title="查看信息" title="查看信息" class="ml-5">
                                    <i class="Hui-iconfont">&#xe695;</i>
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
