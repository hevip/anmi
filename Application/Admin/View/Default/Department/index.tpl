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
        <!--<div class="text-c" style="text-align: left">
            <form action="" method="post">

                <input type="text" name="title" value="{$search['title']}" placeholder="输入部门名称" class="input-text radius width-200" />
                <button type="submit" class="btn btn-success radius relative" id="" name="">
                    <i class="Hui-iconfont">&#xe665;</i>&nbsp;查询
                </button>
            </form>
        </div>-->
        
        <!-- 操作 -->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <a href="{:U('add')}" onclick="" class="btn btn-primary radius">
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
                        <!--<th width="2%">
                            <input type="checkbox" name="" value="">
                        </th>-->
                        <th width="2%">序号</th>
                        <!-- <th width="5%">排序</th> -->
                        <th width="3%">部门代号</th>
                        <th width="3%">部门名称</th>
                        <th width="2%">部门ID</th>
                        <th width="5%">所属单位</th>
                        <th width="2%">单位ID</th>
                        <th width="3%">一级审批人</th>
                        <th width="3%">二级审批人</th>
                        <th width="3%">三级审批人</th>
                        <th width="3%">抄送人</th>
                        <th width="5%">创建时间</th>
                        <th width="5%">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <volist name="dataList" id="volist" key="k">
                        <tr class="text-c">
                           <!-- <td>
                                <input type="checkbox" value="{$volist['id']}" name="dataId">
                            </td>
                            <!--<td>{:( $page['pageNum'] - 1 ) * $page['numperpage'] + ( $key + 1 )}</td>-->
                            <!-- <td>
                                <input type="text" name="Sequence" value="{$volist['sort']}" class="input-text text-c">
                            </td> -->
                            <td>{$k}</td>
                            <td>{$volist['shorthandname']}</td>
                            <td>{$volist['department_name']}</td>
                            <td>{$volist['id']}</td>
                            <td>{$volist['companyname']}</td>
                            <td>{$volist['companyid']}</td>
                            <if condition="$volist['auth1'] eq ''">
                                <td style="color: red">未设置</td>
                            <else />
                                <td>{$volist['auth1']}</td>
                            </if>
                            <if condition="$volist['auth2'] eq ''">
                                <td style="color: red">未设置</td>
                                <else />
                                <td>{$volist['auth2']}</td>
                            </if>
                            <if condition="$volist['auth3'] eq ''">
                                <td style="color: red">未设置</td>
                                <else />
                                <td>{$volist['auth3']}</td>
                            </if>
                            <if condition="$volist['auth4'] eq ''">
                                <td style="color: red">未设置</td>
                                <else />
                                <td>{$volist['auth4']}</td>
                            </if>
                            <td>{$volist['modifytime']}</td>
                            <td class="td-manage">
                                <a href="{:U('edit')}?id={$volist['id']}"  title="修改" class="ml-5">
                                    <i class="Hui-iconfont">&#xe6df;</i>
                                </a>
                                <!--<a href="javascript:void(0);" onclick="layer_full('添加部门负责人','__URL__/chargeadd/id/{$volist['id']}','','');" title="添加部门负责人" class="ml-5">
                                    <i class="Hui-iconfont">&#xe653;</i>
                                </a>-->
                                <a href="{:U('delete')}?id={$volist['id']}" data-id="{$volist['id']}" title="删除" >
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
