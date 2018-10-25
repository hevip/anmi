<extend name="Base/common1" />

{// css样式区 }
<block name="link">

</block>

<block name="jscript">

</block>
<block name="main">

<body>
    <section id="person_ziliao">
        <ul>
            <li>
                <h1><a href="{:U('chengeHead')}"><b><!-- <i class="iconfont">&#xe6a7;</i> --><img style="border-radius:100%;" src="/{$member['face']}"/></b><span>头像</span></a></h1>
            </li>
            <li>
                <p><b>{$member['personal_code']}</b><span>个人代号</span></p>
            </li>
            <li>
                <p><a href="{:U('nickname')}"><b>{$member['nickname']}</b><span>昵称</span></a></p>
            </li>
            <li>
                <p><b><if condition="$member['sex']">
                            <if condition="$member['sex']==1">男<else/>女</if>
                        <else/>
                            未填写
                        </if>
                    </b>
                        <span>性别</span>
                </p>
            </li>
            <li>
                <p><a href="{:U('phone_bind')}"><b>{$member['username']}</b><span>注册手机</span></a></p>
            </li>
            <li>
                <p><b>{$member['companyname']}</b><span>所属单位</span></p>
            </li>
            <li>
                <p><b>{$member['department']}</b><span>所属部门</span></p>
            </li>
        </ul>
    </section>
    
</body>
    
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
					$('.sex-default-color').eq(i).children('a').find('input[name="sex"]').attr('checked','checked');
				} else {
					$('.sex-default-color').eq(i).children('a').removeClass('active');
					$('.sex-default-color').eq(i).children('a').find('input[name="sex"]').attr('checked',false);
				}
			}
		})
		$('.changeSex').click(function(){
			var sex = $('input[name="sex"]:checked').val();
			var obj = {
				sex:sex
			};
			$.post('{:U('sex')}',obj,function(data){
				if(data==1){
					d_messages('设置成功',2);
					history.go(0);
				}else{
					d_messages('设置失败',2);
					return false;
				}
			});
		});
	})
</script>
</block>
