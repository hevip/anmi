<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/jquery.scrollUp.min.js "></script>
</block>

<block name="main">

<body class="">

	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>设置新密码</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>
    
    <!-- 主题内容 -->
	<div class="main" style="background:#fff;">
	
		<section class="user-center user-login user-forget-tel">
			<form id="formid" action="{:U('reset_pass')}" method="post">
				<div class="text-all dis-box j-text-all">
					<div class="input-text input-check box-flex">
						<input class="j-input-text" type="password" name="password" placeholder="请输入新密码">
						<i class="iconfont is-null j-is-null">&#xe669;</i>
					</div>
					<i class="iconfont is-yanjing j-yanjing disabled">&#xe668;</i>
				</div>
				
				<button type="button" onclick="forget()" class="btn-submit">确认修改</button>
				<input type="hidden" name="uid" value="">
			</form>
		</section>
		
	</div>
	
<!---------------仅设置新密码调用--------------->
<script>
    function forget(){
    document.getElementById("formid").submit();
    }
</script>
</block>