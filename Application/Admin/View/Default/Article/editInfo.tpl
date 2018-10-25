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
	<!--<script type="text/javascript" src="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.min.js"></script>-->
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
		<form action="{:U('editInfo')}" method="post" class="form form-horizontal" id="formValidform">
			<div class="panel panel-default">
			<input type="hidden" name="id" value="{$info['id']}" />
		    	<div class="panel-body">
				    <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>资讯标题：
						</label>
						<div class="formControls col-9">
							<input type="text" name="title" value="{$info['title']}" datatype="*" nullmsg="标题不能为空" placeholder="文章标题" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<!--<div class="row cl">
						<label class="form-label col-1">封面图：</label>
						<div class="formControls col-9">
							<if condition="$info['picture'] neq ''">
								<div class="singleImageShow">
									<img src="__ROOT__/{$info['picture']}" width="100" />
								</div>
							</if>
							<div class="uploader-thum-container">
								<div id="fileList" class="uploader-list"></div>
								<div id="filePicker">选择图片</div>
								<input type="hidden" name="picture" value="{$info['picture']}" id="singleImageUpload" datatype="*" nullmsg="请上传商品封面图" />
								<input type="button" id="btn-star" class="btn btn-default btn-uploadstar radius ml-10" value="开始上传" />
							</div>
						</div>
						<div class="col-2"> </div>
					</div>
                   <!--  <div class="row cl">
                        <label class="form-label col-1">网站标题：</label>
                        <div class="formControls col-9">
                            <input type="text" name="web_title" value="{$dataInfo['web_title']}" class="input-text radius" />
                        </div>
                        <div class="col-2"> </div>
                    </div>
                    <div class="row cl">
                        <label class="form-label col-1">网站关键字：</label>
                        <div class="formControls col-9">
                            <input type="text" name="web_keywords" value="{$dataInfo['web_keywords']}" class="input-text radius" />
                        </div>
                        <div class="col-2"> </div>
                    </div>
                    <div class="row cl">
                        <label class="form-label col-1">网站描述：</label>
                        <div class="formControls col-9">
                            <input type="text" name="web_description" value="{$dataInfo['web_description']}" class="input-text radius" />
                        </div>
                        <div class="col-2"> </div>
                    </div> -->
					<!--<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>是否置顶：
						</label>
						<div class="formControls col-9 skin-minimal">
							<div class="radio-box">
								<if condition="$dataInfo['recommend'] eq 1">
									<input type="radio" name="recommend" value="1" checked="checked" id="recommend-1" datatype="*" nullmsg="请选择是否置顶" />
								<else />
									<input type="radio" name="recommend" value="1" id="recommend-1" datatype="*" nullmsg="请选择是否置顶" />
								</if>
								<label for="recommend-1">是</label>
							</div>
							<div class="radio-box">
								<if condition="$dataInfo['recommend'] eq 0">
									<input type="radio" name="recommend" value="0" checked="checked" id="recommend-2" />
								<else />
									<input type="radio" name="recommend" value="0" id="recommend-2" />
								</if>
								<label for="recommend-2">否</label>
							</div>
						</div>
						<div class="col-2"> </div>
					</div>
				<!-- 	<div class="row cl">
                        <label class="form-label col-1">按钮链接：</label>
                        <div class="formControls col-9">
                            <input type="text" name="btn_link" value="{$dataInfo['btn_link']}" class="input-text radius" />
                        </div>
                        <div class="col-2"> </div>
                    </div> -->
					<!--<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>排序：
						</label>
						<div class="formControls col-9">
							<input type="text" name="sort" value="{$dataInfo['sort']}" datatype="n" nullmsg="排序值不能为空" placeholder="排序" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>-->
					<div class="row cl">
						<label class="form-label col-1">
							资讯详情：
						</label>
						<div class="formControls col-9">
							<script id="editor" name="content" type="text/plain" style="width:100%;height:400px;">{$info['content']}</script>
						</div>
						<div class="col-2"> </div>
					</div>
				</div>
			</div>
			<div class="row cl">
				<div class="col-9 col-offset-9">
					<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
					<a href="{:U('Article/main')}" style="    background: #5a98de;
    color: #fff;
    padding: 5px 17px 9px 17px;
    border-radius: 4px;
    font-size: 13px;">返回</a>
				</div>
			</div>
		</form>
	</div>
</block>