<extend name="Base/common" />

{// css样式区 }
<block name="link">
<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">
</block>
<block name="main"> 
<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>我要代言</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main" style="min-height:auto;">

		<section class="recommend">
		
			<img src="__IMAGES__/erweimabg.jpg" class="erweimabg">
			<div class="recommend-user">
				
				<!-- 头像 -->
				<if condition="$userObj['face'] eq ''">
				<img src="__IMAGES__/head.jpg" alt="头像" />
				<else />
				<img src="__ROOT__/{$userObj['face']}" alt="头像"/>
				</if>
				
				<!-- 昵称 -->
				<div class="recommend-txt">
					<p>我是
						<span class="nickname">
							<if condition="$member['wx_name'] neq ''">
								{$member['wx_name']}
							<elseif condition="$member['nickname'] neq ''" />
								{$member['nickname']}
							<else />
								{$member['username']}
							</if>
						</span>
					</p>
					<p>我为小桥网代言</p>
				</div>
			</div>
			
			<!-- 二维码 -->
			<div class="recommend-code">
				<img class="img-responsive" src="__ROOT__/{$erweima}" alt="" />
			</div>
			
		</section>
		
	</div>
	<if condition="$IsWx eq 1">
	<!-- jweixin JS-SDK -->
	<script type="text/javascript" src="__JS__/jweixin-1.0.0.js"></script>
	<script type="text/javascript">
		wx.config({
		    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		    appId: '{$WXAPIObj["appId"]}', // 必填，公众号的唯一标识
		    timestamp: {$WXAPIObj["timestamp"]}, // 必填，生成签名的时间戳
		    nonceStr: '{$WXAPIObj["nonceStr"]}', // 必填，生成签名的随机串
		    signature: '{$WXAPIObj["signature"]}',// 必填，签名，见附录1
		    jsApiList: [
	        	'checkJsApi',
				'onMenuShareAppMessage',
				'onMenuShareTimeline',
				'onMenuShareQQ'
			] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		});
		<if condition="$userObj['nickname'] eq ''">
			var share_title = '{$config["web_title"]}';
			var share_intro = '{$config["web_description"]}'
		<else />
			var share_title = '{$userObj["nickname"]}';	
			var share_intro = '{$userObj["nickname"]}的专属二维码'
		</if>
		var share_link = 'http://{$Think.server.HTTP_HOST}{$Think.server.REQUEST_URI}';
		<if condition="$userObj['head'] eq ''">
			var share_imgUrl = 'http://{$Think.server.HTTP_HOST}__IMAGES__/logo.png';
		<else />
			var share_imgUrl = 'http://{$Think.server.HTTP_HOST}/{$userObj["face"]}';	
		</if>
		wx.ready(function() {
			// 分享给朋友
			wx.onMenuShareAppMessage({
			    title: share_title, // 分享标题
			    desc: share_intro, // 分享描述
			    link: share_link, // 分享链接
			    imgUrl: share_imgUrl, // 分享图标
			    trigger: function (res) {
			        // alert('用户点击分享给朋友');
		      	},
		     	success: function (res) {
		        	// alert('已分享');
		      	},
		      	cancel: function (res) {
		        	// alert('已取消');
		      	},
		      	fail: function (res) {
		        	// alert(JSON.stringify(res)+'分享给朋友有问题');
		      	}
			});
			// 分享到朋友圈
			wx.onMenuShareTimeline({
			    title: share_title, // 分享标题
			    link: share_link, // 分享链接
			    imgUrl: share_imgUrl, // 分享图标
			    trigger: function (res) {
			        // alert('用户点击分享到朋友圈');
		      	},
		     	success: function (res) {
		        	// alert('已分享');
		      	},
		      	cancel: function (res) {
		        	// alert('已取消');
		      	},
		      	fail: function (res) {
		        	// alert(JSON.stringify(res)+'分享到朋友圈有问题');
		      	}
			});
			// 分享到QQ
			wx.onMenuShareQQ({
			    title: share_title, // 分享标题
			    desc: share_intro, // 分享描述
			    link: share_link, // 分享链接
			    imgUrl: share_imgUrl, // 分享图标
			    trigger: function (res) {
			        // alert('用户点击分享到QQ');
		      	},
		     	success: function (res) {
		        	// alert('已分享');
		      	},
		      	cancel: function (res) {
		        	// alert('已取消');
		      	},
		      	fail: function (res) {
		        	// alert(JSON.stringify(res)+'分享到QQ有问题');
		      	}
			});
		});
	</script>
</if>
	
</block>
