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
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/icheck/jquery.icheck.min.js"></script>
	<!--<script type="text/javascript" src="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.min.js"></script>-->
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
		<form action="__URL__/level" method="post" class="form form-horizontal" id="formValidform">
			<div class="panel panel-default">
		
		    	<div class="panel-body">
				    <div class="row cl">
						<label class="form-label col-1" >
							<span class="c-red">*</span>一级审批人：
						</label>
						<div class="formControls col-9">
							<!--<input type="number" name="first_min" value="0" datatype="*" nullmsg="最小时长" placeholder="小时" class="input-text radius" />小时-->
							<input type="number" name="first_max" value="{$dataInfo1}" datatype="*" nullmsg="最大时长" placeholder="小时" class="input-text radius" />小时以内
							<!--<a href="javascript:void(0);" onclick="layer_full('添加','__URL__/addcharge/cate/1','','');" class="btn btn-primary radius">
							<i class="Hui-iconfont">&#xe600;</i>&nbsp;添加审核人员
							</a>-->
						</div>
						<div class="col-2"> </div>
					</div>
				
					<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>二级审批人：
						</label>
						<div class="formControls col-9">
							<!--<input type="number" name="second_min" value="0" datatype="*" nullmsg="最小时长" placeholder="小时" class="input-text radius" />小时-->
							<input type="number" name="second_max" value="{$dataInfo2}" datatype="*" nullmsg="最大时长" placeholder="小时" class="input-text radius" />小时以内
							<!--<a href="javascript:void(0);" onclick="layer_full('添加','__URL__/addcharge/cate/2','','');" class="btn btn-primary radius">
							<i class="Hui-iconfont">&#xe600;</i>&nbsp;添加审核人员
							</a>-->
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>三级审批人：
						</label>
						<div class="formControls col-9">
							<!--<input type="number" name="third_min" value="0" datatype="*" nullmsg="最小时长" placeholder="小时" class="input-text radius" />小时-->
							<input type="number" name="third_max" value="{$dataInfo3}" datatype="*" nullmsg="最大时长" placeholder="小时" class="input-text radius" />小时以内及以上
							<!--<a href="javascript:void(0);" onclick="layer_full('添加','__URL__/addcharge/cate/3','','');" class="btn btn-primary radius">
							<i class="Hui-iconfont">&#xe600;</i>&nbsp;添加审核人员
							</a>-->
						</div>
						<div class="col-2"> </div>
					</div>
				</div>
			</div>
			<div class="row cl">
				<div class="col-9 col-offset-9" style="margin-left: 10%">
					<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
				</div>
			</div>
		</form>
	</div>
</block>