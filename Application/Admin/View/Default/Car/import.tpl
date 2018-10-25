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
		<form style="width: 30%;height: 200px;margin-left: 5%" method="post" action="{:U('car/importExcel')}" name="theForm" id="uploadForm" enctype="multipart/form-data">
			<input type="file" class="se2" name="file" id="file" size="45" style=""/>
			<div style="">仅限excel文件</div>
			<div style="width: 100%;margin-top: 5%;">
				<input class="se1" type="submit" value="导入数据" style="cursor: pointer;
    background: #5eb95e;
    border: 6px solid #5eb95e;
    border-radius: 5px;color: #fff;
}"/>
			<a href="{:U('car/carlist')}" style="cursor: pointer;
    background: #5eb95e;
    padding: 5px 15px 7px 15px;
    border-radius: 5px;
    color: #fff;
    font-size: 12px;
    text-decoration: none;">返回</a></div>
		</form>
	</div>
</block>
<script>
	function checkField(val)
	{
		UpladFile();
		changev();
	}
	function UpladFile() {
		var fileObj = document.getElementById("file").files[0]; // 获取文件对象
		var FileController = "{:U('member/import')}";     // 接收上传文件的后台地址
		// FormData 对象
		var form = new FormData();
		form.append("author", "hooyes");      // 可以增加表单数据
		form.append("file", fileObj);       // 文件对象
		// XMLHttpRequest 对象
		var xhr = new XMLHttpRequest();
		xhr.open("post", FileController, true);
		xhr.onload = function () {
			alert('上传完成!');
		};
		xhr.send(form);
	}
	function changev(){
		$('#file').attr('value','');
	}
</script>
