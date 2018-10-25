<extend name="Base/common" />

<block name="link"></block>

<block name="jscript">
	<script type="text/javascript">
		$(function(){
			// 表单验证
			plugins.Validform();
		});
	</script>
</block>

<block name="main">
	<div class="pd-20">
		<form action="__URL__/price_edit/tag/update" method="post" class="form form-horizontal" id="formValidform">
			<input type="hidden" name="id" value="{$dataInfo['id']}" />
			<div class="row cl">
				<label class="form-label col-3"><span class="c-red">*</span>订单价格：</label>
				<div class="formControls col-6">
					<if condition="$dataInfo['custom_price'] gt 0">
            			<input type="text" name="custom_price" value="{$dataInfo['custom_price']}" datatype="price"placeholder="订单价格" class="input-text radius" />
					<else />
						<input type="text" name="custom_price" value="{$dataInfo['price']}" datatype="price"placeholder="订单价格" class="input-text radius" />
					</if>
				</div>
				<div class="col-3"> </div>
			</div>
			<div class="row cl">
				<div class="col-9 col-offset-3">
					<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
				</div>
			</div>
		</form>
	</div>
</block>