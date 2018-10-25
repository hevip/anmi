<extend name="Base/common" />

{// css样式区 }
<block name="link">
	<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">
</block>

<block name="main">
	<!-- 头部 -->
	<header class="header-menu dis-box">
		<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
		<h3>{$columnTitle}</h3>
		<a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
	</header>

	<!-- 主题内容 -->
	<div class="main">
		<section class="my-setting">

			<!-- 头像 -->
			<a href="javascript:;">
				<div class="s-user-top ">
					<div class="dis-box s-xian-box s-user-top-1">
						<h3 class="box-flex my-u-title-size s-user-img">头像</h3>
						<div class="box-flex s-user-right">
							<div class="user-head-img-box-1">
								<img src="__ROOT__/{$user['face']}">
							</div>
						</div>
					</div>
				</div>
			</a>

			<!-- 用户名 -->
			<div class="s-user-top">
				<div class="dis-box s-xian-box s-user-top-1">
					<h3 class="box-flex my-u-title-size">用户名</h3>
					<div class="box-flex s-user-right">{$user['wx_name']}</div>
				</div>
			</div>

			<!-- 性别 -->
			<div class="s-user-top onclik-sex">
				<div class="dis-box s-xian-box s-user-top-1">
					<h3 class="box-flex my-u-title-size">性别</h3>
					<div id="sex" class="box-flex s-user-right">
						<if condition="$user['sex'] eq 0">无</if>
						<if condition="$user['sex'] eq 1">男</if>
						<if condition="$user['sex'] eq 2">女</if>
					</div>
					<span class="t-jiantou"><i class="iconfont">&#xe664;</i></span>
				</div>
			</div>

			<!-- 绑定手机 -->
			<a href="#">
				<div class="s-user-top onclik-admin">
					<div class="dis-box s-xian-box s-user-top-1">
						<h3 class="box-flex my-u-title-size">手机</h3>
						<div class="box-flex s-user-right">
							<if condition="$user['tel'] neq ''">
								{$user['tel']}
								<else />
								{$user['username']}
							</if>
						</div>
						<span class="t-jiantou"><i class="iconfont">&#xe664;</i></span>
					</div>
				</div>
			</a>

			<!-- 邮箱 -->
			<a href="{:U('Member/email')}">
				<div class="s-user-top onclik-admin">
					<div class="dis-box s-xian-box s-user-top-1">
						<h3 class="box-flex my-u-title-size">邮箱</h3>
						<div class="box-flex s-user-right">{$user['email']}</div>
						<span class="t-jiantou"><i class="iconfont">&#xe664;</i></span>
					</div>
				</div>
			</a>
		</section>

		<!-- 修改密码 -->
		<section class="my-setting">
			<a href="{:U('Member/edit')}">
				<div class="s-user-top onclik-admin">
					<div class="dis-box s-xian-box s-user-top-1">
						<h3 class="box-flex my-u-title-size">修改密码</h3>
						<span class="t-jiantou"><i class="iconfont">&#xe664;</i></span>
					</div>
				</div>
			</a>
		</section>

		<!-- 退出登录 -->
		<div style="padding:1rem;">
			<button type="submit" class="btn-submit">退出</button>
		</div>

		<!-- 性别选择 -->
		<div class="my-sex-box">
			<div class="flow-consignee">
				<ul class="user-nav-box g-s-i-title-3 dis-box">
					<li class="box-flex  sex-default-color">
						<a href="javascript:;" class="">
							<i class="iconfont my-sex-size">&#xe6d5;</i>
							<input type="radio" name="sex" value="1"><h4 class="ellipsis-one">男</h4>
						</a>
					</li>
					<li class="box-flex sex-default-color">
						<a href="javascript:;" class="sex-nv ">
							<i class="iconfont my-sex-size">&#xe6c9;</i>
							<input type="radio" name="sex" value="2"><h4 class="ellipsis-one">女</h4>
						</a>
					</li>
				</ul>

				<div class="ect-button-more dis-box updata-top my-sex-close">
					<button class="btn-submit box-flex" type="submit" value="submit">确定</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(function($) {
			$(".onclik-sex").click(function() {
				$(".my-sex-box").addClass("current");
			});
			$(".my-sex-close").click(function() {
				$(".my-sex-box").removeClass("current");
			});
		});
		$(function() {
			$('.sex-default-color').click(function() {
				for (var i = 0; i < $('.sex-default-color').size(); i++) {
					if (this == $('.sex-default-color').get(i)) {
						$('.sex-default-color').eq(i).children('a').addClass('active');
					} else {
						$('.sex-default-color').eq(i).children('a').removeClass('active');
					}
				}
			})
		})
	</script>

</block>