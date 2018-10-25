<extend name="Base/common" />

<block name="link">
	<link href="__PLUGIN_H-ui__/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
	<link href="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />
</block>

<block name="jscript">
	<!-- ueditor编辑器开始 -->
	<script type="text/javascript" src="__PLUGIN__/ueditor/1.4.3/ueditor.config.js"></script>
	<script type="text/javascript" src="__PLUGIN__/ueditor/1.4.3/ueditor.all.min.js"> </script>
	<script type="text/javascript" src="__PLUGIN__/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
	<script>
		$(function(){
			var ue = UE.getEditor('editor');
		});
	</script>
	<!-- ueditor编辑器结束 -->
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
		<form action="{:U('add')}" method="post" class="form form-horizontal" id="formValidform">
			<input type="hidden" name="type" value="{$type}">
			<div class="panel panel-default">
		    	<div class="panel-body">
				    <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>产品名称：
						</label>
						<div class="formControls col-9">
							<input type="text" name="title" value="" datatype="*" nullmsg="不能为空" placeholder="产品名称" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>功能用途：
						</label>
						<div class="formControls col-9">
							<input type="text" name="intro" value="" datatype="*" nullmsg="不能为空" placeholder="功能用途，20字以内" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>产品分类：
						</label>
						<div class="formControls col-5">
							<select name="type" id="" style="width: 30%;">
									<option value="管理软件">管理软件</option>
									<option value="营门营区">营门营区</option>
									<option value="国防仓库">国防仓库</option>
									<option value="枪弹物资">枪弹物资</option>
									<option value="人车管理">人车管理</option>
									<option value="手机管控">手机管控</option>
									<option value="安全保密">安全保密</option>
									<option value="训练教育">训练教育</option>
									<option value="信息产品">信息产品</option>
							</select>
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">产品封面图：</label>
						<div class="formControls col-9">
							<div class="uploader-thum-container">
								<div id="fileList" class="uploader-list"></div>
								<div id="filePicker">选择图片</div>
								<input type="hidden" name="picture" value="" id="singleImageUpload" datatype="*" nullmsg="请上传产品封面图" />
								<input type="button" id="btn-star" class="btn btn-default btn-uploadstar radius ml-10" value="开始上传" />
							</div>
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							产品详情：
						</label>
						<div class="formControls col-9">
							<script id="editor" name="content" type="text/plain" style="width:100%;height:400px;"></script>
						</div>
						<div class="col-2"> </div>
					</div>
				</div>
			</div>
			<div class="row cl">
				<div class="col-9 col-offset-9">
					<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
					<a href="{:U('goods/index')}" style="    background: #5a98de;
    color: #fff;
    padding: 5px 17px 9px 17px;
    border-radius: 4px;
    font-size: 13px;">返回</a>
				</div>
			</div>
		</form>
	</div>
</block>