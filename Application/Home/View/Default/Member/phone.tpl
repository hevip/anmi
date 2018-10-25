<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<title>{$keywordInfo.web_title}</title>
<meta name="keywords" content="{$keywordInfo.web_keywords}" />
<meta name="description" content="{$keywordInfo.web_description}" />

<link rel="stylesheet" href="__STYLE__/initital.css"/>
<link rel="stylesheet" href="__STYLE__/home.css"/>
<link rel="stylesheet" type="text/css" href="__STYLE__/bind_phone.css">
<script type="text/javascript" src="__JS__/jquery.min.js"></script>
<script type="text/javascript" src="__JS__/communal.js"></script>
<script type="text/javascript" src="__JS__/bind_phone.js"></script>
<script type="text/javascript">
var jsObj = {
	'root' : '__ROOT__',
	'images' : '__IMAGES__',
	'login_url' : '{:U('Login/login')}',
	'is_login' : '<if condition="session('member_auth')">1<else />0</if>',
};
</script>

</head>

<body>
	
	<!-- 顶部 -->
	<div id="dingdan">
	    <div class="dingdan_tol">
	        <ul>
	            <li style="width:20%;">
					<a class="iconfont dingdan_a" href="javascript:history.back();">&#xe643;</a>
				</li>
	            <li class="dingdan_size" style="width:60%;">手机号码</li>
	        </ul>
	    </div>
	</div>
	
	<!-- 内容 -->
	<div class="account_main">
		<form id="#mainForm1" class="mainForm mainForm1" action="{:U('Member/phone_bind')}">
	        <div class="promptCon">您已绑定手机号码。如果您的手机号发生变更，您可直接修改绑定的手机号码。</div>
	        <div class="normalInput">
	            <div class="phoneNumber">手机号码：{$member['username']}</div>
	        </div>
	        <div class="nextBtn">
				<input type="submit" value="修改绑定的手机号" class="submit" />
	        </div>
	    </form>
	</div>

</body>
</html>