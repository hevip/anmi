<!-- kindeditor编辑器开始 -->
<link rel="stylesheet" href="__PLUGIN__/kindeditor/themes/default/default.css" />
<link rel="stylesheet" href="__PLUGIN__/kindeditor/plugins/code/prettify.css" />
<script charset="utf-8" src="__PLUGIN__/kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="__PLUGIN__/kindeditor/lang/zh_CN.js"></script>
<script charset="utf-8" src="__PLUGIN__/kindeditor/plugins/code/prettify.js"></script>
<script>
    KindEditor.ready(function(K) {
		K.create('#kindeditor', {
            pasteType : 2,
			allowFileManager : true
		});
	});
</script>
<!-- kindeditor编辑器结束 -->

<form action="__URL__/update" method="post" class="form form-horizontal" id="formValidform_configInfo">
	<input type="hidden" name="id" value="{$dataInfo['id']}" />

    <div class="panel panel-default mt-10">
    	<div class="panel-header">提现配置</div>
    	<div class="panel-body">
			<div class="row cl">
				<label class="form-label col-1">
					<span class="c-red"></span>每日提现次数：
				</label>
	        	<div class="formControls col-5">
					<input type="text" name="postal_number" value="{$dataInfo['postal_number']}" class="input-text config_upgrade_input" />
					<span style="color:red;">次</span>
					<span style="color:green;">（0则不受次数限制）</span>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-1">
					<span class="c-red"></span>提现最低金额：
				</label>
	        	<div class="formControls col-8">
					<input type="text" name="postal_low_price" value="{$dataInfo['postal_low_price']}" class="input-text config_upgrade_input" />
					<span style="color:red;">元</span>
					<span style="color:green;">（0则不受金额限制）</span>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-1">
					<span class="c-red"></span>提现最高金额：
				</label>
	        	<div class="formControls col-8">
					<input type="text" name="postal_high_price" value="{$dataInfo['postal_high_price']}" class="input-text config_upgrade_input" />
					<span style="color:red;">元</span>
					<span style="color:green;">（0则不受金额限制）</span>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-1">
					<span class="c-red"></span>是否开启提现审核：
				</label>
	        	<div class="formControls col-8">
	        		<select name="is_postal_check" class="input-text config_upgrade_input">
	        			<option <if condition="$dataInfo['is_postal_check'] == '1'">selected="selected"</if>    value="1">是</option>
	        			<option <if condition="$dataInfo['is_postal_check'] == '0'">selected="selected"</if>    value="0">否</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row cl">
		<div class="col-9 col-offset-10">
			<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
		</div>
	</div>
</form>