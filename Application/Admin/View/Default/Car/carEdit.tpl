<extend name="Base/common" />

<block name="link">
	<link href="__PLUGIN_H-ui__/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
	<link href="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />
</block>

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
		$(function(){
			var ue = UE.getEditor('editor');
		});
	</script>
	<!-- kindeditor编辑器结束 -->
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/icheck/jquery.icheck.min.js"></script> 
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.min.js"></script> 
	<script type="text/javascript" src="__JS__/commodity.js"></script>
	<script type="text/javascript">
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
		<form action="{:U('update')}?id={$carInfo['id']}" method="post" class="form form-horizontal" id="formValidform">
			<div class="panel panel-default">
				<div class="panel-body">
				    <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>单位名称：
						</label>
						<div class="formControls col-9">
							<input type="text" name="companyname" value="{$carInfo['companyname']}" readonly="readonly"  placeholder="单位名称" class="input-text radius" />
							<input type="hidden" value="{$carInfo['company_id']}" name="company_id" />
							<input type="hidden" value="{$carInfo['id']}" name="id" />
						</div>
						<div class="col-2"> </div>
					</div>
				</div>
		    	<div class="panel-body">
				    <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>车牌号：
						</label>
						<div class="formControls col-9">
					
							<input type="text" name="car_num" value="{$carInfo['car_num']}" datatype="*" nullmsg="不能为空" placeholder="车牌号" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
				</div>
				<div class="panel-body">
				    <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>车辆使用状态：
						</label>
						<div class="formControls col-9">
					
							<input type="radio" name="status" value="{$carInfo['status']}" <if condition="$carInfo['status'] eq 0">checked</if>/>未使用
							<input type="radio" name="status" value="{$carInfo['status']}"<if condition="$carInfo['status'] eq 1">checked</if> />使用中
							<input type="radio" name="status" value="{$carInfo['status']}"<if condition="$carInfo['status'] eq 2">checked</if>  />不可使用
						</div>
						<div class="col-2"> </div>
					</div>
				</div>
				<div class="panel-body">
				    <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>备注信息：
						</label>
						<div class="formControls col-9">
					
							<input type="text" name="information" value="{$carInfo['information']}" datatype="*" nullmsg="不能为空" placeholder="备注信息" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
				</div>
			
			</div>
			<div class="row cl">
				<div class="col-9 col-offset-9">
					<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
				</div>
			</div>
		</form>
	</div>
</block>