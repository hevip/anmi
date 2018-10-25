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
		<form action="{:U('add')}" method="post" class="form form-horizontal" id="formValidform">
			<div class="panel panel-default">
		    	<div class="panel-body">
				    <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>部门名称：
						</label>
						<div class="formControls col-9">
							<input type="text" name="department_name" value="" datatype="*" nullmsg="不能为空" placeholder="部门名称" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					 <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>部门代号：
						</label>
						<div class="formControls col-9">
							<input type="text" name="shorthandname" value="" datatype="*" nullmsg="不能为空" placeholder="部门代号" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<if condition="$res neq ''">
						<div class="row cl">
							<label class="form-label col-1">
								<span class="c-red">*</span>所属单位：
							</label>
							<div class="formControls col-5">
								<select name="companyid" id="" style="width: 30%;">
									<volist name="res" id="vo">
										<option value="{$vo.id}">{$vo.companyname}</option>
									</volist>
								</select>
							</div>
							<div class="col-2"> </div>
						</div>
					</if>
					 <!--<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>部门索引字母：
						</label>
						<div class="formControls col-9">

							<input type="text" name="index_name" value="" datatype="*" nullmsg="不能为空" placeholder="部门索引字母" class="input-text radius" onkeyup="this.value=this.value.replace(/[^a-z]/g,'')" />
						</div>
						<div class="col-2"> </div>
					</div>-->
					<!--<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>部门状态：
						</label>
						<div class="formControls col-9 skin-minimal">
							<div class="radio-box">
								<input type="radio" name="status" value="1"  id="shelves-1" datatype="*" nullmsg="请选择是否禁用" />
								<label for="shelves-1">禁用</label>
							</div>
							<div class="radio-box">
								<input type="radio" name="status" value="0" checked="checked" id="shelves-2" />
								<label for="shelves-2">启用</label>
							</div>
						</div>
						<div class="col-2"> </div>
					</div>
				<!-- 	<div class="row cl">
						<label class="form-label col-1">封面图：</label>
						<div class="formControls col-9">
							<div class="uploader-thum-container">
								<div id="fileList" class="uploader-list"></div>
								<div id="filePicker">选择图片</div>
								<input type="hidden" name="picture" value="" id="singleImageUpload" />
								<input type="button" id="btn-star" class="btn btn-default btn-uploadstar radius ml-10" value="开始上传" />
							</div>
						</div>
						<div class="col-2"> </div>
					</div> -->
					<!--<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>排序：
						</label>
						<div class="formControls col-9">
							<input type="text" name="sort" value="0" datatype="n" nullmsg="排序值不能为空" placeholder="排序" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<!-- <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>部门负责人：
						</label>
						<div class="formControls col-9">
							<?php foreach ($classification as $k => $v): ?>
								<dl class="permission-list">
									<dt>
										<label>
											<font style="vertical-align: inherit;">
												<font style="vertical-align: inherit;">
													<?php echo $v['nickname'];?>
												</font>
											</font>
										</label>
									</dt>
									<dd>
									    <dl class="cl permission-list2">
											<dt>
						                    	<?php foreach ($v['child'] as $ke => $va): ?>
													<label class="">
														<input type="checkbox"  datatype="*" nullmsg="请选择部门负责人{$v['title']}" value="{$va['id']}" name="class-{$va['pid']}[]">
														<font style="vertical-align: inherit;">
															<font style="vertical-align: inherit;">
																<?php echo $va['title'];?>
															</font>
														</font>
													</label>
						                    	<?php endforeach ?>
											</dt>
										</dl>
									</dd>
								</dl>
		                    <?php endforeach ?>
						</div>
						<div class="col-2"> </div>
					</div> -->
					<!-- <div class="row cl">
						<label class="form-label col-1">
							部门详情：
						</label>
						<div class="formControls col-9">
							<script id="editor" name="content" type="text/plain" style="width:100%;height:400px;"></script>
						</div>
						<div class="col-2"> </div>
					</div> -->
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