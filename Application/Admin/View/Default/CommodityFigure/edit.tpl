<extend name="Base/common" />

<block name="link">
	<link href="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />
</block>

<block name="jscript">
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.min.js"></script> 
	<script type="text/javascript">
		$(function(){
			// 单图上传
			plugins.singleImageUpload();
			// 表单验证
			plugins.Validform();
		});
	</script>
</block>

<block name="main">
	<div class="pd-20">
		<form action="__URL__/update" method="post" class="form form-horizontal" id="formValidform">
			<input type="hidden" name="id" value="{$dataInfo['id']}" />
			<div class="row cl">
				<label class="form-label col-3">
					<span class="c-red">*</span>图片标题：
				</label>
				<div class="formControls col-5">
					<input type="text" name="title" value="{$dataInfo['title']}" datatype="*2-16" nullmsg="图片标题不能为空" placeholder="图片标题" class="input-text radius" />
				</div>
				<div class="col-4"> </div>
			</div>
			<div class="row cl">
				<label class="form-label col-3">附图上传：</label>
				<div class="formControls col-8">
					<if condition="$dataInfo['picture'] neq ''">
						<div class="singleImageShow">
							<img src="__ROOT__/{$dataInfo['picture']}" width="100" />
						</div>
					</if>
					<div class="uploader-thum-container">
						<div id="fileList" class="uploader-list"></div>
						<div id="filePicker">选择图片</div>
						<input type="hidden" name="picture" value="{$dataInfo['picture']}" id="singleImageUpload" datatype="*" nullmsg="请上传商品附图" />
						<input type="button" id="btn-star" class="btn btn-default btn-uploadstar radius ml-10" value="开始上传" />
					</div>
				</div>
				<div class="col-1"> </div>
			</div>
			<div class="row cl">
				<label class="form-label col-3">
					<span class="c-red">*</span>排序：
				</label>
				<div class="formControls col-5">
					<input type="text" name="sort" value="{$dataInfo['sort']}" datatype="n" nullmsg="排序值不能为空" placeholder="排序值" class="input-text radius" />
				</div>
				<div class="col-4"> </div>
			</div>
			<div class="row cl">
				<div class="col-9 col-offset-3">
					<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
				</div>
			</div>
		</form>
	</div>
</block>