<extend name="Base/common" />
<block name="jscript">
    <!-- kindeditor编辑器开始 -->
    <link rel="stylesheet" href="__PLUGIN__/kindeditor/themes/default/default.css" />
    <link rel="stylesheet" href="__PLUGIN__/kindeditor/plugins/code/prettify.css" />
    <script charset="utf-8" src="__PLUGIN__/kindeditor/kindeditor.js"></script>
    <script charset="utf-8" src="__PLUGIN__/kindeditor/lang/zh_CN.js"></script>
    <script charset="utf-8" src="__PLUGIN__/kindeditor/plugins/code/prettify.js"></script>
    <script type="text/javascript" src="__PLUGIN__/ueditor/1.4.3/ueditor.config.js"></script>
    <script type="text/javascript" src="__PLUGIN__/ueditor/1.4.3/ueditor.all.min.js"> </script>
    <script type="text/javascript" src="__PLUGIN__/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
    <script>
        KindEditor.ready(function(K) {
            K.create('#kindeditor', {
                pasteType : 2,
                allowFileManager : true
            });
        });
    </script>
    <!-- kindeditor编辑器结束 -->
    <script type="text/javascript" src="__PLUGIN_H-ui__/lib/icheck/jquery.icheck.min.js"></script> 
    <script type="text/javascript" src="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.min.js"></script> 
    <script type="text/javascript" src="__JS__/commodity.js"></script>
    <script type="text/javascript">
        $(function(){
            var ue = UE.getEditor('editor');
        });
        $(function(){
            // radio插件
            $('.skin-minimal input').iCheck({
                checkboxClass: 'icheckbox-blue',
                radioClass: 'iradio-blue',
                increaseArea: '20%'
            });
            // 单图上传
            plugins.singleImageUpload();
            
            // 表单验证
            plugins.Validform();
        });
    </script>
</block>

<block name="main">
	
	<form action="__URL__/addcharge" method="post" class="form form-horizontal" id="formValidform">
          <div class="row cl">
            <label class="form-label col-1">
                <span class="c-red">*</span>负责人：
            </label>
            
            <input type="hidden" value="{$field}" name="field">
            <div class="formControls col-9">
                <?php foreach ($dataList as $k => $v): ?>
                    <dl class="permission-list">
                        <dt>
                            <label>
                                    <font style="vertical-align: inherit;">
                                        <?php echo $v['department_name'];?>
                                    </font>
                            </label>
                        </dt>
                        <dd>
                            <dl class="cl permission-list2">
                                <dt>
                           
                                    <?php foreach ($v['memberList'] as $ke => $va): ?>

                                         <input type="checkbox"  datatype="*" nullmsg="请选择{$v['department_name']}负责人" value="{$va['id']}"  name="index[{$v['index_name']}][]" <?php if (in_array($v['index_name'].$va['id'],$keyarr)): ?> checked <?php endif ?> >

                                        <font style="vertical-align: inherit;">
                                                <?php echo $va['nickname'];?>
                                        </font>

                                    <?php endforeach ?>
                                </dt>
                            </dl>
                        </dd>
                    </dl>
                <?php endforeach ?>
            </div>
            <div class="col-2"> </div>
        </div>
        <div class="row cl">
                <div class="col-9 col-offset-9">
                    <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
                </div>
            </div>
    </form>

</block>
