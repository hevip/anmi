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
        <div class="text-c" style=" text-align: left;">
            <form action="" method="post">
                <!-- 用户名 -->
                <input type="text" name="title" value="{$search['title']}" placeholder="输入标题" class="input-text radius width-200" />
                <button type="submit" class="btn btn-success radius relative" id="" name="">
                    <i class="Hui-iconfont">&#xe665;</i>&nbsp;查询
                </button>
            </form>
        </div>
        
        <!-- 操作 -->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <a href="{:U('add')}"  class="btn btn-primary radius">
					<i class="Hui-iconfont">&#xe600;</i>&nbsp;添加
				</a>
                <!--<a href="javascript:void(0);" class="btn btn-danger radius BatchRemove">
                    <i class="Hui-iconfont">&#xe6e2;</i>&nbsp;批量删除
                </a>-->
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
                        <th width="5%">编号</th>
                        <!--<th width="5%">排序</th>-->
                        <th width="5%">资讯标题</th>
                        <th width="10%">封面图</th>
                        <th width="10%">资讯详情</th>
                        <th width="5%">创建时间</th>
                        <th width="5%">所属单位</th>
                        <th width="4%">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <volist name="dataList" id="volist" key="k">
                        <tr class="text-c">
                            <!--<td>
                                <input type="checkbox" value="{$volist['id']}" name="dataId">
                            </td>-->
                            <td>{$k}</td>
                            <!--<td>
                                <input type="text" name="Sequence" value="{$volist['sort']}" class="input-text text-c">
                            </td>-->
                            <td>{$volist['title']}</td>
                            <td>
								<if condition="$volist['picture'] neq ''">
									<a  rel="image-viewer" title="{$volist['title']}">
										<img src="__ROOT__/{$volist['picture']}" height="100" class="radius" />
									</a>
								<else />
									无
								</if>
							</td>
                            <td>{$volist['content']}</td>
                            <td>{$volist['create_time']|date='Y-m-d H:i:s',###}</td>
                            <td>{$volist['companyname']}</td>
                            <td class="td-manage">
                                <!--<if condition="$volist['status'] eq 0">
                                    <a href="javascript:void(0);" data-id="{$volist['id']}" data-status="1" data-field="status" title="禁用" class="ml-5 updateStatus">
                                        <i class="Hui-iconfont">&#xe631;</i>
                                    </a>
                                <else />
                                    <a href="javascript:void(0);" data-id="{$volist['id']}" data-status="0" data-field="status" title="启用" class="ml-5 updateStatus">
                                        <i class="Hui-iconfont">&#xe6e1;</i>
                                    </a>
                                </if>-->
                                <a href="{:U('edit')}?id={$volist['id']}"  title="修改" class="ml-5">
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
