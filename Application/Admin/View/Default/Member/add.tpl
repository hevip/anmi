<extend name="Base/common" />

<block name="link">
	<link href="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />
</block>

<block name="jscript">
	<!--<script type="text/javascript" src="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.min.js"></script> -->
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
		<form action="{:U('add')}" method="post" class="form form-horizontal" id="formValidform">
			<div class="row cl">
				<label class="form-label col-3">
					<span class="c-red"></span><span class="c-red">*</span>个人代号：
				</label>
				<div class="formControls col-5" style="width: 30%">
					<input type="text" name="personal_code" value="" datatype="*" nullmsg="代号不能为空" placeholder="2位英文+8位数字"  class="input-text radius" />
				</div>
				<div class="col-4"> </div>
			</div>
			<div class="row cl">
				<label class="form-label col-3">
					<span class="c-red"></span><span class="c-red">*</span>密码：
				</label>
				<div class="formControls col-5" style="width: 30%">
					<input type="password" name="password" value="" datatype="*" nullmsg="密码不能为空" placeholder="密码"  class="input-text radius" />
				</div>
				<div class="col-4"> </div>
			</div>
			<div class="row cl">
				<label class="form-label col-3">
					<span class="c-red"></span><span class="c-red">*</span>昵称：
				</label>
				<div class="formControls col-5" style="width: 30%">
					<input type="text" name="nickname" value=""  datatype="*" nullmsg="昵称不能为空" placeholder="昵称" class="input-text radius" />
				</div>
				<div class="col-4"> </div>
			</div>
			<div class="row cl">
				<label class="form-label col-3">
					<span class="c-red"></span><span class="c-red">*</span>手机号：
				</label>
				<div class="formControls col-5" style="width: 30%">
					<input type="text" name="username" value="" datatype="*" nullmsg="手机不能为空" placeholder="手机号" class="input-text radius" />
				</div>
				<div class="col-4"> </div>
			</div>
			<if condition="$company neq ''">
				<div class="row cl">
					<label class="form-label col-3">
						<span class="c-red">*</span>所属单位：
					</label>
					<div class="formControls col-5" style="width: 30%">
						<select name="cid" id="company" style="width: 100%">
							<volist name="company" id="vo">
							<option value="{$vo.id}">{$vo.companyname}</option>
							</volist>
						</select>
					</div>
					<div class="col-4"> </div>
				</div>
			</if>
			<div class="row cl">
				<label class="form-label col-3">
					<span class="c-red">*</span>所属部门：
				</label>
				<div class="formControls col-5" style="width: 30%">
					<select name="department_id" id="department" style="width: 100%">
					    <volist name="department" id="vo">
							<option value="{$vo.id}" >{$vo.department_name}</option>
						</volist>
					</select>
				</div>
				<div class="col-4"></div>
			</div>
			<div class="row cl">
				<label class="form-label col-3">
					<span class="c-red">*</span>用户类型：
				</label>
				<div class="formControls col-5" style="width: 30%">
					<select name="auth" id="" style="width: 100%">
						<option value="0">普通用户</option>
						<option value="5">人力资源</option>
						<option value="4">抄送人</option>
						<option value="1">一级审批人</option>
						<option value="2">二级审批人</option>
						<option value="3">三级审批人</option>
					</select>
				</div>
				<div class="col-4"> </div>
			</div>
			<div class="row cl">
				<div class="col-9 col-offset-3" style="margin-top: 5%">
					<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
					<a href="{:U('member/index')}" style="background: #5a98de;
    border-radius: 5px;
    padding: 5px 19px 8px;
    color: #fff;">返回</a>
				</div>
			</div>
		</form>
	</div>
</block>
<!--<script>
	$('#company').change(function () {
		var company_id = $('#company option:selected').val();
		$.ajax({
					url: "{:U('member/getDepartment')}",
					type: 'POST',
					dataType: 'json',
					data: {id: company_id}
				})
				.done(function(msg) {
					$('#department option').remove();
					// var dataObj=eval("("+data+")");
					if (msg !=null) {
						$.each(msg,function(i,data){
							$('#department').append("<option value='"+data.id+"'>"+data.department_name+"</option>");
						});
					}else{
						$('#department').append("<option value='' disabled='disabled'>该单位没有部门</option>");
					}
				})



	})
</script>