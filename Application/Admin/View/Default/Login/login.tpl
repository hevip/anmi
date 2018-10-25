<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$config['web_title']}</title>
    <meta name="keywords" content="{$config['web_keywords']}">
    <meta name="description" content="{$config['web_description']}">
    <link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" href="__PLUGIN__/hplus/css/bootstrap.min.css?v=3.3.5">
    <link rel="stylesheet" href="__PLUGIN__/hplus/css/font-awesome.min.css?v=4.4.0">
    <link rel="stylesheet" href="__PLUGIN__/hplus/css/animate.min.css">
    <link rel="stylesheet" href="__PLUGIN__/hplus/css/style.min.css?v=4.0.0">
    <link href="__PLUGIN__/hplus/css/plugins/toastr/toastr.min.css" rel="stylesheet">
    <link rel="stylesheet" href="__STYLE__/login.css">
<script>if(window.top !== window.self){ window.top.location = window.location;}</script>
</head>

<body  onresize="aa()" onload="aa()">
        <div class="wra" id="ac">
            <div class="header">
                <span>欢迎登录后台管理界面平台</span>
                <!-- <ul>
                    <li><a href="#">回首页</a></li>
                    <li><a href="#">帮助</a></li>
                    <li><a href="#">关于</a></li>
                </ul> -->
            </div>
            <div class="logo">
                <a href="#"><img src="__IMAGES__/logo2.png"/></a>
            </div>
            <div class="login">
                <div class="login_l left"></div>
                <div class="login_r left">
                    <div class="login_r_con">
                        <h1>用户登录<span>User Login</span></h1>
                        <div class="form">
                            <form class="form-horizontal m-t form-login" id="signupForm" action="{:U('/Admin/login')}">
                            {__TOKEN__}
                                <div style="height: 60px; ">
                                    <input style="padding-left:45px;background-image: url(__IMAGES__/login_03.png);background-repeat: no-repeat;background-position: 18px center;background-color: #cde7fe; " type="text" name="username" value="" title="用户名" placeholder="用户名" />
                                </div>
                                <div style="height: 60px;">
                                    <input style="padding-left:45px;background-image: url(__IMAGES__/login_06.png);background-repeat: no-repeat;background-position: 18px center;background-color: #cde7fe; " type="password" name="password" value="" placeholder="密码" />
                                </div>
                                <div style="height: 60px;">
                                    <input style="padding-left:45px;background-image: url(__IMAGES__/login_06.png);background-repeat: no-repeat;background-position: 18px center;background-color: #cde7fe;width: 170px !important;float: left;" type="text" name="verify" value="" class="codeyzm" placeholder="验证码" />
                                <img src="{:U('/Admin/verify')}" class="imgyzm" width="170px" height="36px" style="border: 1px #cde7fe solid;float: right">
                                </div>
                                <div class="sub">
                                    <input type="submit" value="登录" class="">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script type="text/javascript">
            function aa(){
                var total = document.documentElement.clientHeight;
                document.getElementById("ac").style.height=total+"px";
            }
            var imgyzm_url = "{:U('/Admin/verify')}";
            var loginsuccess_url = "{:U('/Admin/index')}";
    </script>
    <script src="__PLUGIN__/hplus/js/jquery.min.js?v=2.1.4"></script>
    <script src="__PLUGIN__/hplus/js/bootstrap.min.js?v=3.3.5"></script>

    <!-- 表单验证 -->
    <script src="__PLUGIN__/hplus/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="__PLUGIN__/hplus/js/plugins/validate/messages_zh.min.js"></script>
    <script src="__JS__/jquery-validate-set_default.js"></script>

    <!-- 提示框插件 -->
    <script src="__PLUGIN__/hplus/js/plugins/toastr/toastr.min.js"></script>

    <!-- 自定义插件 -->
    <script src="__JS__/plugins.js"></script>

    <!-- 登录验证 -->
    <script src="__JS__/login.js"></script>
</html>