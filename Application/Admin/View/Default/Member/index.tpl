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
    $(function(){
    	plugins.walletRecharge({
    		'clickObj' : '.walletRecharge',
    		'url' : '__URL__/walletRecharge'
    	});
    });
    </script>
</block>

<block name="main">
	
	<!-- 面包屑导航 -->
    <nav class="breadcrumb">
        <i class="Hui-iconfont">&#xe67f;</i>&nbsp;首页
        <span class="c-gray en">&gt;</span>&nbsp;人员列表
        <!--   <span class="c-gray en">&gt;</span>&nbsp;会员列表
      -   <a class="btn btn-success radius r mr-20" id="RefreshButton" href="javascript:void(0);" title="刷新">
              <i class="Hui-iconfont">&#xe68f;</i>
          </a> -->
    </nav>
    
    <div class="pd-20">
    	
    	<!-- 条件查询 -->
        <div class="text-c" style="text-align: left">
            <form action="" method="post">
                <!-- 用户名 -->
                <input type="text" name="personal_code" value="" placeholder="输入个人代号" class="input-text radius width-200" />
                <!-- 姓名 -->
               <input type="text" name="tel" value="" placeholder="输入手机号" class="input-text radius width-200" />
            
                <!-- 开始日期 -->
                <!--<input type="text" name="start_time" value="{$paramter['start_time']}" id="datemin" placeholder="开始日期" class="input-text radius Wdate width-200">
                -
                <!-- 结束日期 -->
                <!--<input type="text" name="end_time" value="{$paramter['end_time']}" id="datemax" placeholder="结束日期" class="input-text radius Wdate width-200">
                <!-- 搜索按钮 -->
                <button type="submit" class="btn btn-success radius relative" id="" name="">
                    <i class="Hui-iconfont">&#xe665;</i>&nbsp;查询
                </button>
            </form>
        </div>
        <!-- 操作 -->
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <a href="{:U('member/index')}" class="btn btn-success radius">
                    <i class="Hui-iconfont">&#xe68f;</i>&nbsp;全部用户
                </a>
                <if condition="$department neq ''">
                    <volist name="department" id="vo">
                        <a href="{:U('member/index')}?id={$vo.id}" style="border-radius: 5px; margin-left: 10px; color: #fff; padding: 1px 3px 2px 1px; background: #5eb95e;">{$vo.department_name}</a>
                    </volist>
                <else />
                    <volist name="company" id="vo">
                        <a href="{:U('member/index')}?cid={$vo.id}" style="border-radius: 5px; margin-left: 10px; color: #fff; padding: 1px 3px 2px 1px; background: #5eb95e;">{$vo.companyname}</a>
                    </volist>
                </if>
            </span>
            <div style="width: 21%; float: right;">
                <a href="{:U('add')}" style="color: #fff; margin-top: -3%; border-radius: 6px; background: #5eb95e; border: 7px solid #5eb95e;">添加人员</a>
                <a href="{:U('import')}" style="color: #fff; margin-top: -3%; border-radius: 6px; background: #5eb95e; border: 7px solid #5eb95e;">批量导入</a>
                <a href="{:U('member/excelImport')}" style="color: #fff;  border-radius: 6px; background: #5eb95e; border: 7px solid #5eb95e;">批量导出</a>
            </div>
        </div>
        <!-- 列表 -->
        <div class="mt-20">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">

                       <th width="5%">序号</th>
                        <th width="5%">个人代号</th>
                        <th width="10%">昵称</th>
                        <th width="8%">联系电话</th>
                        <th width="10%">所属单位</th>
                        <th width="8%">所属部门</th>
                        <th width="5%">用户类型</th>
                        <th width="10%">创建时间</th>
                        <th width="5%">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <volist name="dataList" id="volist" key="k">
                        <tr class="text-c">
                            <td>{$k}</td>
                            <td>{$volist['personal_code']}</td>
                            <td>{$volist['nickname']}</td>
                            <td>{$volist['username']}</td>
                            <td>{$volist['companyname']}</td>
                            <td>{$volist['department_name']}</td>
                            <td>{$volist['auth']}</td>
                            <td>{$volist.create_time|date='Y-m-d H:i:s',###}</td>
                            <td class="td-manage">
                                <if condition="$volist['status'] eq 0">
                                    <a href="{:U('status')}?id={$volist['id']}&status=1"  title="已开启" class="ml-5 ">
                                        <i class="Hui-iconfont">&#xe6e1;</i>
                                    </a>
                                <else />
                                    <a href="{:U('status')}?id={$volist['id']}&status=0"  title="已禁用" class="ml-5 ">
                                        <i class="Hui-iconfont">&#xe631;</i>
                                    </a>
                                </if>
                                <a href="{:U('member/edit')}?id={$volist['id']}"  title="修改" class="ml-5">
                                    <i class="Hui-iconfont">&#xe6df;</i>
                                </a>
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
<script>
    $(function(){
        $('#auth').click(function(){
            alert(444);
        })
        $('#auth').change(function(){
            alert(333);
        })
    })
</script>