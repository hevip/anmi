<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection" content="telephone=no" />
    
    <meta name="description" content="{$config['web_description']}" />
    <meta name="keywords" content="{$config['web_keywords']}" />
    <title>{$config['web_title']}</title>   
     <link rel="stylesheet" type="text/css" href="__STYLE__/Pub.css"/>
    <script src="__JS__/jquery-2.1.3.min.js"></script>
    <script src="__JS__/swiper-3.4.1.min.js"></script>
    <script src="__JS__/layer.js"></script>
    <script src="__JS__/XuanZe.js"></script>
    <script src="__JS__/laydate.js"></script>
    <link rel="stylesheet" type="text/css" href="__STYLE__/swiper-3.4.1.min.css"/>
    <link rel="stylesheet" type="text/css" href="__STYLE__/index.css"/>
    <link rel="stylesheet" type="text/css" href="__STYLE__/layer.css"/>
    <link rel="stylesheet" type="text/css" href="__STYLE__/temelete.css"/>
    <link rel="stylesheet" type="text/css" href="__STYLE__/template.css"/>
    <!--<link rel="stylesheet" type="text/css" href="__STYLE__/xx.css"/>-->
    <link rel="stylesheet" type="text/css" href="__STYLE__/new_form.css"/>
	<script type="text/javascript">
		var jsObj = {
			'root' : '__ROOT__',
			'images' : '__IMAGES__',
			'login_url' : '{:U('Login/login')}',
			'is_login' : '<if condition="session('member_auth')">1<else />0</if>',
		};
	</script>
	<block name="jscript">
      <script type="text/javascript">
        
        document.addEventListener('plusready', function(){
            //console.log("所有plus api都应该在此事件发生后调用，否则会出现plus is undefined。"
            
        });
        
    </script>
	</block>