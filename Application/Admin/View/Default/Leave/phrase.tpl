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
   
        
        <!-- 操作 -->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <a href="javascript:void(0);" onclick="layer_full('添加文章','__URL__/addPhrase','','');" class="btn btn-primary radius">
					<i class="Hui-iconfont">&#xe600;</i>&nbsp;添加短语
				</a>
            </span>
            <span class="r">共有数据：<strong>{$dataList|count}</strong> 条</span>
        </div>
        
        <!-- 列表 -->
        <div class="mt-20">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                    <!--     <th width="2%">
                            <input type="checkbox" name="" value="">
                        </th> -->
                        <th width="5%">编号</th>
                        <th width="50%">短语</th>
                        <th width="10%">创建时间</th>
                        <th width="10%">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <volist name="dataList" id="volist">
                        <tr class="text-c">
                            <!-- <td>
                                <input type="checkbox" value="{$volist['id']}" name="dataId">
                            </td> -->
                            <td>{:( $page['pageNum'] - 1 ) * $page['numperpage'] + ( $key + 1 )}</td>
                         
                            <td>{$volist['content']}</td>
                          
                            <td>{$volist['create_time']}</td>
                            <td class="td-manage">
                            <!--     <a href="javascript:void(0);" onclick="layer_full('编辑文章','__URL__/edit/id/{$volist['id']}','','');" title="编辑文章" class="ml-5">
                                    <i class="Hui-iconfont">&#xe6df;</i>
                                </a> -->
                                <a href="javascript:void(0);" data-id="{$volist['id']}" title="删除" class="ml-5 phraseRemove">
                                    <i class="Hui-iconfont">&#xe6e2;</i>
                                </a>
                            </td>
                        </tr>
                    </volist>
                </tbody>
            </table>
        </div>
    </div>

    <script>



    
    $(".phraseRemove").click(function(){
        var url = "{:U('phraseRemove')}";
        var _this = $( this );
        var _id = _this.attr( 'data-id' );
        layer.confirm('确认要删除吗？',function(index){
            $.ajax({
                url : url + '?rnd=' + Math.random(),
                data : {id:_id},
                type : 'POST',
                async : true,
                dataType : 'json',
                beforeSend : function() {
                    layer.msg('正在处理……',{icon: 3,time:100000});
                },
                success : function( data ) {
                    console.log(data);
                    if ( data['status'] == 0 ) {
                        layer.msg(data['info'],{icon: 5,time:1000});
                    } else {
                        _this.parents("tr").remove();
                        layer.msg('已删除!',{icon:6,time:1000});
                    }
                }
            });
        });
    } );
  

       
    </script>
</block>
