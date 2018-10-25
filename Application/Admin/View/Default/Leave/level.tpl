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
    <!-- <script type="text/javascript" src="__JS__/jquery-1.7.2.js"></script> -->
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
     <!--    <div class="text-c">
            <form action="" method="post">
                <input type="text" name="title" value="{$search['title']}" placeholder="输入标题" class="input-text radius width-200" />
                <button type="submit" class="btn btn-success radius relative" id="" name="">
                    <i class="Hui-iconfont">&#xe665;</i>&nbsp;查询
                </button>
            </form>
        </div> -->
        
        <!-- 操作 -->
       <!-- <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <a href="{:U('addcate')}" class="btn btn-primary radius">
					<i class="Hui-iconfont">&#xe600;</i>&nbsp;添加
				</a>
                <!--a href="javascript:void(0);" class="btn btn-danger radius BatchRemove">
                    <i class="Hui-iconfont">&#xe6e2;</i>&nbsp;批量删除
                </a-->
        <!-- </span>
            <span class="r">共有数据：<strong>{$dataList|count}</strong> 条</span>
        </div>-->
        
        <!-- 列表 -->
        <div class="mt-20">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <!--<th width="2%">
                            <input type="checkbox" name="" value="">
                        </th>-->
                        <th width="2%">编号</th>
                        <th width="5%">一级审批</th>
                        <th width="5%">二级审批</th>
                        <th width="5%">三级审批</th>
                        <th width="5%">所属单位</th>
                        <th width="1%">操作</th>
                    </tr>
                </thead>
                <tbody>
                   <!-- <volist name="auth" id="volist" key="k">-->
                        <tr class="text-c">
                           <!-- <td>
                                <input type="checkbox" value="{$volist['id']}" name="dataId">
                            </td>-->
                            <td>1</td>
                            <if condition="$auth eq ''">
                                <td style="color: red;">还未设置审批人</td>
                            <else />
                                <volist name="auth" id="vo">
                                <td>{$auth['range_time']}小时</td>
                                </volist>
                            </if>
                            <if condition="$auth2 eq ''">
                                <td style="color: red;">还未设置审批人</td>
                            <else />
                                <volist name="auth2" id="vo">
                                <td>{$auth2['range_time']}小时</td>
                                </volist>
                            </if>
                            <if condition="$auth3 eq ''">
                                <td style="color: red;">还未设置审批人</td>
                            <else />
                                <volist name="auth3" id="vo">
                                <td>{$auth3['range_time']}小时</td>
                                </volist>
                            </if>
                            <volist name="companyname" id="vo">
                                <td>{$companyname['companyname']}</td>
                            </volist>
                            <td class="td-manage">
                                <!--<a href="javascript:void(0);" onclick="layer_full('编辑分类','__URL__/edit/id/{$volist['id']}','','');" title="编辑分类" class="ml-5">
                                    <i class="Hui-iconfont">&#xe6df;</i>
                                </a>-->
                                <a href="{:U('leave/editLevel')}" title="修改" class="ml-5">
                                    <i class="Hui-iconfont">&#xe6df;</i>
                                </a>
                            </td>
                        </tr>
                   <!--</volist>-->
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // function() {
        window.onload=function(){
            $(".cateRemove").click(function(){
             
             
                var _this = $( this );
                var _id = _this.attr( 'data-id' );
                layer.confirm('确认要删除吗？',function(index){
                    $.ajax({
                        url : 'cateremove.html',
                        data : {id:_id},
                        type : 'POST',
                        async : true,
                        dataType : 'json',
                        beforeSend : function() {
                            layer.msg('正在处理……',{icon: 3,time:100000});
                        },
                        success : function( data ) {
                            if ( data['status'] == 0 ) {
                                layer.msg(data['info'],{icon: 5,time:1000});
                            } else {
                                _this.parents("tr").remove();
                                layer.msg('已删除!',{icon:6,time:1000});
                            }
                        }
                    });
                });
             
            });
            
        };
    </script>
</block>
