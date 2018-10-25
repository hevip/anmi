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
	</script>
	<!-- kindeditor编辑器结束 -->
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/icheck/jquery.icheck.min.js"></script> 
	<!--<script type="text/javascript" src="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.min.js"></script> -->
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
							<span class="c-red">*</span>单位代号：
						</label>
						<div class="formControls col-9">
							<input type="text" name="shorthandname" value="{$dataInfo['shorthandname']}" datatype="*" nullmsg="单位代号不能为空" placeholder="单位代号" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
				    <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>单位名称：
						</label>
						<div class="formControls col-9">
							<input type="text" name="companyname" value="{$dataInfo['companyname']}" datatype="*" nullmsg="单位名称不能为空" placeholder="单位名称" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							单位地址：
						</label>
						<div class="formControls col-9">
							<input type="text" name="address" value="{$dataInfo['address']}" datatype="*" nullmsg="单位地址不能为空" placeholder="单位地址" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							单位电话：
						</label>
						<div class="formControls col-9">
							<input type="text" name="tel" value="{$dataInfo['tel']}" datatype="*" nullmsg="单位电话不能为空" placeholder="单位电话" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							单位邮箱：
						</label>
						<div class="formControls col-9">
							<input type="text" name="email" value="{$dataInfo['email']}" datatype="*" nullmsg="单位邮箱不能为空" placeholder="单位邮箱" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<!--<div class="row cl">
						<label class="form-label col-1">logo：</label>
						<div class="formControls col-9">
							<if condition="$dataInfo['logo_url'] neq ''">
								<div class="singleImageShow">
									<img src="__ROOT__/{$dataInfo['logo_url']}" width="100" />
								</div>
							</if>
							<div class="uploader-thum-container">
								<div id="fileList" class="uploader-list"></div>
								<div id="filePicker">选择图片</div>
								<input type="hidden" name="logo_url" value="{$dataInfo['logo_url']}" id="singleImageUpload" datatype="*" nullmsg="请上传logo" />
								<input type="button" id="btn-star" class="btn btn-default btn-uploadstar radius ml-10" value="开始上传" />
							</div>
						</div>
						<div class="col-2"> </div>
					</div>-->
				
					<!--<div class="row cl">
						<label class="form-label col-1">
							单位管理员：
						</label>
						<div class="formControls col-9">
							<div class="classList" style="display:inline;">
									<span class="select-box radius width-130">
								    	<select name="admin" class="select pid-select select-class" datatype="*" nullmsg="请选择">
							                <option value="{$data['id']}" selected="selected">{$data['nickname']}</option>
							                <volist name="classList" id="volist">
												<option value="{$volist['id']}" {$volist['selected']}>{$volist['nickname']}</option>
							                </volist>
							            </select>
									</span>
							</div>
						</div>
						<div class="col-2"> </div>
					</div>
					<!-- <div class="row cl">
						<label class="form-label col-1">
							文章详情：
						</label>
						<div class="formControls col-9">
							<script id="editor" name="content" type="text/plain" style="width:100%;height:400px;">{$dataInfo['content']}</script>
						</div>
						<div class="col-2"> </div>
					</div> -->
				</div>

			</div>
			<div class="row cl">
				<div class="col-9 col-offset-9">
					<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
					<a href="{:U('company/index')}" style="    background: #5a98de;
    color: #fff;
    padding: 5px 17px 9px 17px;
    border-radius: 4px;
    font-size: 13px;">返回</a>
				</div>
			</div>
		</form>
	</div>
</block>