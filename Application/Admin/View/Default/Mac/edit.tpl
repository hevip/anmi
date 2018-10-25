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

	<!-- kindeditor编辑器结束 -->
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/icheck/jquery.icheck.min.js"></script> 
	<!--<script type="text/javascript" src="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.min.js"></script> -->
	<!-- <script type="text/javascript" src="__JS__/commodity.js"></script> -->
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
							<span class="c-red">*</span>设备名称：
						</label>
						<div class="formControls col-9">
							<!-- <input type="hidden" name="pid" value="{$_GET['pid']}" /> -->
							<input type="text" name="mac_name" value="{$dataInfo['mac_name']}" datatype="*" nullmsg="设备名称" placeholder="设备名称" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<!--  <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>设备MAC：
						</label>
						<div class="formControls col-9">
							<input type="hidden" name="pid" value="{$_GET['pid']}" />
							<input type="text" name="mac" value="{$dataInfo['mac']}" datatype="*" nullmsg="设备MAC" placeholder="设备MAC" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div> -->
					  <div class="row cl">
                        <label class="form-label col-1">
                            <span class="c-red">*</span>设备区分：
                        </label>
                        <div class="formControls col-9">
                            <input type="radio" name="mac_type" value="1" class="dianj" <if condition="$dataInfo['mac_type'] eq 1">checked</if>/>门禁
                            <input type="radio" name="mac_type" value="0" class="dianj" <if condition="$dataInfo['mac_type'] eq 0">checked</if>  />车辆
                        </div>
                        <div class="col-2"> </div>
                    </div>
				<!-- 	<div class="row cl">
						<label class="form-label col-1">
							设备区分：
						</label>
						<div class="formControls col-9">
							<div class="classList" style="display:inline;">
				    			<span class="select-box radius width-130">
							    	<select name="mac_type" class="select select-class" datatype="*" nullmsg="请选择设备区分">
									<option value="0" <if condition="$dataInfo['mac_type'] eq 0">selected</if>>车辆</option>
									<option value="1" <if condition="$dataInfo['mac_type'] eq 1">selected</if>>门禁</option>
						             
						            </select>
								</span>
							</div>
						</div>
						<div class="col-2"> </div>
					</div> -->
					<div class="row cl">
						<label class="form-label col-1">
							设备状态：
						</label>
						<div class="formControls col-9">
							<div class="classList" style="display:inline;">
				    			<span class="select-box radius width-130">
							    	<select name="mac_stuts" class="select select-class" datatype="*" nullmsg="请选择设备状态">
									<option value="0" <if condition="$dataInfo['mac_stuts'] eq 0">selected</if>>启用</option>
									<option value="1" <if condition="$dataInfo['mac_stuts'] eq 1">selected</if>>禁用</option>
						            </select>
								</span>
							</div>
						</div>
						<div class="col-2"> </div>
					</div>
					<if condition="$dataInfo['mac_type'] eq 1">
                        <div class="row cl">
                            <label class="form-label col-1">
                                <span class="c-red">*</span>设备MAC：
                            </label>
                            <div class="formControls col-9">
                                <input type="text" name="mac" value="{$dataInfo['mac']}"  nullmsg="设备MAC" placeholder="设备MAC" class="input-text radius" />
                            </div>
                            <div class="col-2"> </div>
                        </div>
                    <else />
                         <div class="row cl">
                            <label class="form-label col-1">
                                <span class="c-red">*</span>设备MAC：
                            </label>
                            <div class="formControls col-9">
                                <input type="text" name="mac" value="{$dataInfo['mac']}"  nullmsg="设备MAC" placeholder="设备MAC" class="input-text radius" />
                            </div>
                            <div class="col-2"> </div>
                        </div>
                        <div class="row cl">
                            <label class="form-label col-1">
                                <span class="c-red">*</span>车辆编号：
                            </label>
                            <div class="formControls col-9">
                                <input type="text" name="car_num" value="{$dataInfo['car_num']}" datatype="*" nullmsg="车牌号" placeholder="车牌号" class="input-text radius" />
                            </div>
                            <div class="col-2"> </div>
                        </div>
                        </if>
				</div>

			</div>
			<div class="row cl">
				<div class="col-9 col-offset-9">
					<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
					<a href="{:U('mac/index')}" style="    background: #5a98de;
    color: #fff;
    padding: 5px 17px 9px 17px;
    border-radius: 4px;
    font-size: 13px;">返回</a>
				</div>
			</div>
		</form>
	</div>
	 <script>
        $('.dianj').click(function(){
            $('.men,.che').toggle();
        })
    </script>
</block>