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
    <!--     <div class="text-c">
            <form action="" method="post">
                <input type="text" name="title" value="{$search['title']}" placeholder="输入文章标题" class="input-text radius width-200" />
                <button type="submit" class="btn btn-success radius relative" id="" name="">
                    <i class="Hui-iconfont">&#xe665;</i>&nbsp;查询
                </button>
            </form>
        </div> -->
        
        <!-- 操作 -->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <a href="{:U('add')}"  class="btn btn-primary radius">
					<i class="Hui-iconfont">&#xe600;</i>&nbsp;添加
				</a>
                <!--a href="javascript:void(0);" class="btn btn-danger radius BatchRemove">
                    <i class="Hui-iconfont">&#xe6e2;</i>&nbsp;批量删除
                </a-->
            </span>
            <span class="r">共有数据：<strong>{$dataList|count}</strong> 条</span>
        </div>
        
        <!-- 列表 -->
        <div class="mt-20">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                      
                        <th width="5%">编号</th>
                    
                        <th width="5%">设备状态</th>
                        <th width="10%">设备名称</th>
                        <th width="10%">设备区分</th><!-- 车辆或者门 -->
                        <th width="10%">车牌号</th><!-- 车辆或者门 -->
                        <th width="10%">MAC后六位</th>
                        <th width="10%">所属单位</th>
                        <th width="4%">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <volist name="dataList" id="volist">
                        <tr class="text-c">
                           
                            <td>{:( $page['pageNum'] - 1 ) * $page['numperpage'] + ( $key + 1 )}</td>
                            <td><if condition="$volist['mac_stuts'] == 0">启用<else />禁用</if></td>
                            <td>{$volist['mac_name']}</td>
                            <td>
                            <if condition="$volist['mac_type'] eq 0" id="vo">
                            车辆
                            <else />
                            门
                            </if>
                            </td>
                            <td>
                                <if condition="$volist['car_num'] eq ''" id="vo">

                                    <else />
                                   {$volist.car_num}
                                </if>
                            </td>
                            <td>{$volist['mac']}</td>
                            <td>{$volist['companyname']}</td>
                            <td class="td-manage">
                                <a href="{:U('edit')}?id={$volist['id']}"  title="编辑" class="ml-5">
                                    <i class="Hui-iconfont">&#xe6df;</i>
                                </a>
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
