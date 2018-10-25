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
        <!--<div class="text-c">
            <form action="" method="post">
                <input type="text" name="title" value="{$search['title']}" placeholder="输入单位名称" class="input-text radius width-200" />
                <button type="submit" class="btn btn-success radius relative" id="" name="">
                    <i class="Hui-iconfont">&#xe665;</i>&nbsp;查询
                </button>
            </form>
        </div>-->
        
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
                       <!-- <th width="2%">
                            <input type="checkbox" name="" value="">
                        </th>-->
                        <th width="3%">序号</th>
                        <th width="5%">单位代号</th>
                        <th width="5%">单位名称</th>
                        <th width="5%">单位管理员</th>
                        <th width="5%">单位地址</th>
                        <th width="5%">单位电话</th>
                        <th width="5%">单位邮箱</th>
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
                            <td>{:( $page['pageNum'] - 1 ) * $page['numperpage'] + ( $key + 1 )}</td>-->
                            <td>{$k}</td>
                            <td>{$volist['shorthandname']}</td>
                          <!--   <td>
                                <input type="text" name="Sequence" value="{$volist['sort']}" class="input-text text-c">
                            </td> -->
                            <td>{$volist['companyname']}</td>
                            <td>
								<if condition="$volist['nickname'] eq ''"><span style="color: red">未添加单位管理员</span><else />{$volist['nickname']}</if>
							</td>
                            <td>{$volist['address']}</td>
                            <td>{$volist['tel']}</td>
                            <td>{$volist['email']}</td>
                            <td>{$volist['modifytime']}</td>
                            <td class="td-manage">
                                <a href="{:U('edit')}?id={$volist['id']}"  title="编辑" class="ml-5">
                                    <i class="Hui-iconfont">&#xe6df;</i>
                                </a>
                                <if condition="$volist['nickname'] eq ''">
                                <a href="{:U('delete')}?id={$volist['id']}" data-id="{$volist['id']}" title="删除" class="ml-5 ">
                                    <i class="Hui-iconfont">&#xe6e2;</i>
                                </a>
                                </if>
                            </td>
                        </tr>
                    </volist>
                </tbody>
            </table>
        </div>
    </div>
</block>
