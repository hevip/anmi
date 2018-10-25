<extend name="Base/common1" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">
<script>
function changegoods(id,integral){
    if ( !confirm( '您确定要兑换此商品吗？' ) ) {
        return;
    }

	$.ajax({
		url:'{:U('changegoods')}',
		data:{id:id,integral:integral},
		type:'post',
		success:function(data){
			if(data['status']){
			 	setTimeout(window.location.href=jsObj.root+"/Member/index.html",1000)
				d_messages("兑换成功!");
			}else{
				d_messages( data['info'] );
			}
		}
	})
}
</script>
</block>
<block name="main">

<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>积分商品详情</h3>
        <a href="__ROOT__/"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">
		<section class="integral-info">
			<div class="integral-info-img">
				<h3>{$dataInfo['title']}</h3>
				<img src="__ROOT__/{$dataInfo['picture']}" class="integral-pro-img">
				<div class="transparent-bg"></div>
			</div>
			
			<div class="integral-info-price">
				<p class="t-first"><i class="iconfont">&#xe692;</i>{$dataInfo['integral']}</p>
			</div>
			
			<div class="integral-info-con">
				{$dataInfo['content']}
			</div>
			
			<!-- 按钮 -->
			<div class="dis-box filter-btn" style="background:#fff;">
				<button class="btn-submit box-flex" onclick="changegoods({$dataInfo.id},{$dataInfo.integral})" type="submit">兑换</button>
			</div>
		</section>
	</div>
</block>
