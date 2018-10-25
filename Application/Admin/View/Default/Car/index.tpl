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
		<span class="c-gray en">&gt;</span>&nbsp;用车申请
        <a class="btn btn-success radius r mr-20" id="RefreshButton" href="javascript:void(0);" title="刷新">
            <i class="Hui-iconfont">&#xe68f;</i>
        </a>
    </nav>
    
    <div class="pd-20">
    	
    	<!-- 条件查询 -->
        <div class="text-c" style="    text-align: left;">
            <form action="{:U('index')}" method="post">
                <!-- 用户名 -->
                <input type="text" name="personal_code" value="" placeholder="根据代号查询" class="input-text radius width-200" />
                <!-- 开始日期 -->
                <input type="text" name="car_start_time" value="" id="datemin" placeholder="开始日期" class="input-text radius Wdate width-200">
                -
                <!-- 结束日期 -->
                <input type="text" name="car_end_time" value="" id="datemax" placeholder="结束日期" class="input-text radius Wdate width-200">


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
            </span>
        </div>
        <!-- 操作 -->
      <!--   <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <a href="javascript:void(0);" onclick="layer_full('添加文章','__URL__/add/pid/16','','');" class="btn btn-primary radius">
					<i class="Hui-iconfont">&#xe600;</i>&nbsp;添加文章
				</a>
            </span>
            <span class="r">共有数据：<strong>{$dataList|count}</strong> 条</span>
        </div> -->
        
        <!-- 列表 -->
        <div class="mt-20">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                       <!-- <th width="2%">
                            <input type="checkbox" name="" value="">
                        </th>-->
                        <th width="3%">编号</th>
                        <th width="5%">用车人员</th>
                        <th width="5%">所属单位</th>
                        <th width="5%">车牌号</th>
                        <th width="10%">用车原因</th>
                        <th width="5%">用车单位</th>
                        <th width="5%">带车干部</th>
                        <th width="5%">用车时长</th>
                        <th width="8%">申请时间</th>
                        <th width="5%">审批人</th>
                       <th width="3%">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <volist name="dataList" id="volist" key="k">
                        <tr class="text-c">
                           <!-- <td>
                                <input type="checkbox" value="{$volist['id']}" name="dataId">
                            </td>
                            <td>{:( $page['pageNum'] - 1 ) * $page['numperpage'] + ( $key + 1 )}</td>-->
                            <td>{$k}</td>
                            <td>{$volist['personal_code']}</td>
                            <td>{$volist['companyname']}</td>
                            <td>{$volist['car_num']}</td>
                            <td>{$volist['caruse']}</td>
                            <td>{$volist['companyname']}</td>
                            <td>{$volist['cadres']}</td>
                            <td>{$volist['duration']}小时</td>
                            <td>{$volist['addtime']|date='Y-m-d H:i:s',###}</td>
                            <td>{$volist['first_charge']}</td>
                            <td class="td-manage">
                                <!--<a href="javascript:void(0);" onclick="layer_full('编辑文章','__URL__/edit/id/{$volist['id']}','','');" title="编辑文章" class="ml-5">
                                    <i class="Hui-iconfont">&#xe6df;</i>
                                </a>-->
                                <a href="{:U('del')}?id={$volist['id']}" data-id="{$volist['id']}" title="删除" class="ml-5 ">
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
