<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>

<block name="jscript">
</block>

<block name="main">
<style type="text/css">
        .tianxie_bd p{
            margin-bottom: 1rem !important;
        }
        .tianxie_bd p a{
            float: right;
            width: 28%;
            padding: 0;
            margin: 0;
            display: block;
            text-align: center;
            color: #0064BE;
            height: 4rem;
            line-height: 4rem;
            border: 0;
            overflow: hidden;
        }
        .tianxie_bd p a img{
            display: block;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        .tianxie_bd p small{
            display: block;
            float: left;
            width: 70%;
            overflow: hidden;
        }
        .tianxie_bd p b{
            display: block;
            font-weight: normal;
            color: #999999;
            font-size: 1rem;
            margin-top: .2rem;
        }
    </style>
<body>
	<section id="BiaoD" style="margin: 3rem 0 3rem 0;">
		<form action="" method="post"  enctype="multipart/form-data">
        <input type="hidden" name="cid" value="{$dataList['cid']}" />
        <input type="hidden" name="department_id" value="{$dataList['department_id']}" />
        <input type="hidden" name="username" value="{$dataList['username']}" />
		<div class="tianxie_bd">
			<div class="shangTu_wa">
			<div class="shangTu">
				<label for="shangchua"><div id="preview">+</div></label>
				<input type="file" name="face" id="shangchua" value="" onchange="preview(this)" />
			</div>
			*上传头像
                <span>jpg,png格式,小于500K</span>
			</div>
			<p>
				<input placeholder="请输入您的用户名或昵称" type="text" name="nickname"  />
				<b>*可以中文、英文、数字、符号</b>
			</p>
			<p>
				<input placeholder="请输入您的密码" type="password" name="password"  />
				<b>*6-16位英文、数字、符号</b>
			</p>
			<p>
				<input placeholder="请再次输入您的密码" type="password" name="password2"  />
				<b>*6-16位英文、数字、符号</b>
			</p>
			<p>
				<input placeholder="请输入您的代号" type="text" name="personal_code" value="" />
				<b>*请输入单位给您的代号，2位英文+8位数字</b>
			</p>
			<p>
				<select name="sex" id="sex">
					<option value="1">男</option>
					<option value="2">女</option>
				</select>
			</p>
			<script src="__JS__/XuanZe.js" type="text/javascript"></script>
		</div>			
			<input style="margin-bottom: .6rem;" class="btn-th" type="button" value="完成注册"/>
		</form>
		<div class="wj_jz">
			<a href="{:U('login')}">已有账号，去登陆</a>

		</div>
	</section>
	
</body>

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

<script>
    $( function() {
    var username = $("input[name=username]");
    var cid = $("input[name=cid]");    
    var department_id = $("input[name=department_id]");
    var face = $("input[name=face]");
    var nickname = $("input[name=nickname]");
    var password = $("input[name=password]");
    var password2 = $("input[name=password2]");
    var personal_code = $("input[name=personal_code]");
    var flag = 1;
    

    $(".btn-th").click(function() {
        // console.log(check());return;
        if (check() == 0) {
            return false;
            return;
        }
            var formData = new FormData();
            formData.append("face",document.getElementById("shangchua").files[0]);
            formData.append("cid",$("input[name=cid]").val());
            formData.append("department_id",$("input[name=department_id]").val());
            formData.append("username",$("input[name=username]").val());
            formData.append("nickname",$("input[name=nickname]").val());
            formData.append("password",$("input[name=password]").val());
            formData.append("personal_code",$("input[name=personal_code]").val());
            formData.append("sex",$("#sex option:selected").val());
            $.ajax({
                url : 'registerSecond.html?rnd=' + Math.random(),
                // data : {
                //     username : username.val(),
                //     cid : cid.val(),
                //     department_id : department_id.val(),
                //     face : face.val(),
                //     nickname : nickname.val(),
                //     password : password.val(),
                // },
                data :formData,
                type : 'POST',
                async : true,
                dataType : 'json',
                processData: false,
                contentType: false ,
                success : function( data ) {
                    if (data.status == 1) {
                        layer.open({
                            content: data.info
                            ,skin: 'msg'
                            ,time: 2 //2秒后自动关闭
                          });
                        window.location.href= 'sign';
                    }else{
                        layer.open({
                            content: data.info
                            ,skin: 'msg'
                            ,time: 2 //2秒后自动关闭
                          });
                        return;
                    }
                }
            });

        
    })

    function check() {
        var state =1;
         if (document.getElementById("shangchua").files[0] == undefined) {
             layer.open({
                        content: '请上传头像'
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
            flag = 0;
            return flag;
        }
        if (nickname.val() == '') {
            layer.open({
                        content: '昵称不能为空'
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
            username.focus();
            flag = 0;
            return flag;
        }
      
        if (password.val() == '') {
             layer.open({
                        content: '密码不能为空'
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
            password.focus();
            flag = 0;
            return flag;
        }
        if (password.val() !=password2.val()) {
             layer.open({
                        content: '两次密码不一致'
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
            password.focus();
            flag = 0;
            return flag;
        }
        if (password.val().length<6) {
             layer.open({
                        content: '密码不能少于六位'
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
            password.focus();
            flag = 0;
            return flag;
        }
       
        $.ajax({
            url: '/Verification/checkPersonalCode.html?rnd=' + Math.random(),
            type: 'POST',
            dataType: 'json',
            data: {personal_code: personal_code.val()},
            async:false,
        })
        .done(function(data) {
            if (data.status == 0) {
                 layer.open({
                        content: data.info
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
                personal_code.focus();
                state = 0;
                return state;
            }
            // username.focus();
            // console.log(data);return;
        })
        return state;
     
        
    }
})
</script>

</block>