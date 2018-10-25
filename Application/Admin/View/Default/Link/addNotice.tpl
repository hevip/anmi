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
		<form action="{:U('addNotice')}" method="post" class="form form-horizontal" id="formValidform">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>公告标题：
						</label>
						<div class="formControls col-9">
							<!--<input type="hidden" name="pid" value="{$_GET['pid']}" />-->
							<input type="text" name="title" value="" datatype="*" nullmsg="标题不能为空" placeholder="公告标题" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<!--<if condition="$company neq ''">
						<div class="row cl">
							<label class="form-label col-1">
								<span class="c-red">*</span>所属公司：
							</label>
							<div class="formControls col-5">
								<select name="cid" id="" style="width: 50%">
									<volist name="company" id="vo">
										<option value="{$vo.id}">{$vo.companyname}</option>
									</volist>
								</select>
							</div>
							<div class="col-2"> </div>
						</div>
					</if>-->
					<div class="row cl">
						<label class="form-label col-1">
							公告详情：
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
					<a href="{:U('Link/notice')}" style="    background: #5a98de;
    color: #fff;
    padding: 5px 17px 9px 17px;
    border-radius: 4px;
    font-size: 13px;">返回</a>
				</div>
			</div>
		</form>
	</div>
</block>