<extend name="Base/common" />

<!--<block name="link">
	<link href="__PLUGIN_H-ui__/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
	<link href="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />
</block>-->

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
	<!--<script type="text/javascript" src="__PLUGIN_H-ui__/lib/icheck/jquery.icheck.min.js"></script>
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.min.js"></script> -->
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
	<div class="pd-20">
		<form action="{:U('edit')}" method="post" class="form form-horizontal" id="formValidform">
			<div class="panel panel-default">
			<input type="hidden" name="id" value="{$dataInfo['id']}" />
		    	<div class="panel-body">
				    <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>部门名称：
						</label>
						<div class="formControls col-9">
							<input type="text" name="department_name" value="{$dataInfo['department_name']}" datatype="*" nullmsg="单位名称不能为空" placeholder="单位名称" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
				
					<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>部门代号：
						</label>
						<div class="formControls col-9">
						
							<input type="text" name="shorthandname" value="{$dataInfo['shorthandname']}" datatype="*" nullmsg="不能为空" placeholder="部门代号" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<!--<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>部门状态：
						</label>
						<div class="formControls col-9 skin-minimal">
							<div class="radio-box">
								<if condition="$dataInfo['status'] eq 1">
									<input type="radio" name="status" value="1" checked="checked" id="shelves-1" datatype="*" nullmsg="请选择是否上架" />
								<else />
									<input type="radio" name="status" value="1" id="shelves-1" datatype="*" nullmsg="请选择是否上架" />
								</if>
								<label for="shelves-1">禁用</label>
							</div>
							<div class="radio-box">
								<if condition="$dataInfo['status'] eq 0">
									<input type="radio" name="status" value="0" checked="checked" id="shelves-2" />
								<else />
									<input type="radio" name="status" value="0" id="shelves-2" />
								</if>
								<label for="shelves-2">启用</label>
							</div>
						</div>
						<div class="col-2"> </div>
					</div>
					<!--<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>排序：
						</label>
						<div class="formControls col-9">
							<input type="text" name="sort" value="0" datatype="n" nullmsg="排序值不能为空" placeholder="排序" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>-->
				</div>

			</div>
			<div class="row cl">
				<div class="col-9 col-offset-9">
					<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
					<a href="{:U('department/index')}" style="    background: #5a98de;
    color: #fff;
    padding: 5px 17px 9px 17px;
    border-radius: 4px;
    font-size: 13px;">返回</a>
				</div>
			</div>
		</form>
	</div>
</block>