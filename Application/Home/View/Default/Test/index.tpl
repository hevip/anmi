<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>

<block name="main">

<div id="output"></div>
<img src="" id="qrcodeImg" alt="">

<script type="text/javascript" src="__JS__/jquery.qrcode.min.js"></script>
<script>
jQuery(function(){
	jQuery('#output').qrcode("{$string}");
})


// $(function() {
            
//                     var qrcode = $('#output').qrcode({
//                          render: "canvas", //也可以替换为table
//                          width: 120,
//                          height: 120,
//                          text: "{$string}"/*可以通过ajax请求动态设置*/
 
//                      }).hide();
//                      //将生成的二维码转换成图片格式
//                      var canvas = qrcode.find('canvas').get(0);
//                      $('#qrcodeImg').attr('src', canvas.toDataURL('image/jpg'));
// });
 
           
</script>

</block>
