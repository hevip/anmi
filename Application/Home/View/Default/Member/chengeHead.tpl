<extend name="Base/common" />
<block name="main">

<link rel="stylesheet" type="text/css" href="__STYLE__/new_form.css"/>
<body>
	<section id="BiaoD" style="margin: 3rem 0 3rem 0;">
		<form action="chengeHead" method="post"  enctype="multipart/form-data">
		<div class="tianxie_bd">
			<div class="shangTu_wa" style="margin-bottom: 0">
			<div class="shangTu">
				<label for="shangchua"><div id="preview"><img style="width: 100%;height: 100%;" src="/{$member['face']}"/></div></label>
				<input type="file" name="face" id="shangchua" value="" onchange="preview(this)" />
			</div>
			点击头像修改
			</div>
            <span style="margin-left: 34%; color: #999999;">jpg,png格式,小于500K</span>
		</div>			
			<input style="margin-bottom: .6rem;" class="btn-th" type="submit" value="确定修改"/>
		</form>
	</section>
	
</body>
<script src="__JS__/laydate.js"></script> <!-- 改成你的路径 -->
<script>
lay('#version').html('-v'+ laydate.v);

//执行一个laydate实例
laydate.render({
  elem: '#test1', //指定元素
  type: 'datetime',
});
laydate.render({
  elem: '#test2', //指定元素
  type: 'datetime'

});
</script>
<script type="text/javascript">
    function preview(file) {
        var prevDiv = document.getElementById('preview');
        if (file.files && file.files[0]) {
            var reader = new FileReader();
            reader.onload = function(evt) {
                prevDiv.innerHTML = '<img class="chuan_tu" src="' + evt.target.result + '" />';
            }
            reader.readAsDataURL(file.files[0]);
        } else {
            prevDiv.innerHTML = '<div class="asd_img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
        }
    }
</script>
</block>