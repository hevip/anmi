<extend name="Base/common" />

{// css样式区 }
<block name="link">

</block>

<block name="jscript">

</block>
<block name="main"> 

<body>
    <section id="BiaoD">
        <form action="" method="post">
        <div class="tianxie_bd">
            <h1>您的意见：</h1>
            <p>
                <textarea name="content" id="content" rows="" cols="" placeholder="请写下您的意见，我们将用心聆听，做的更好！"></textarea>
            </p>
            <h1>联系方式（电话/邮箱/QQ选填）：</h1>
            <p>
                <input placeholder="请输入您的联系方式" type="text" name="contact" value="" />
            </p>
        </div>          
            <input class="btn-th" type="button" value="提交"/>
        </form>     
    </section>
    <footer>
        <div class="footer-con">
            <div class="CenNav">
                <a href="#">
                    <img src="img/secer_52.png"/>
                    服务
                </a>
            </div>
            <div class="lfrNav">
                <ul>
                    <li>
                        <a class="Nav_active" href="#">
                            <i class="iconfont">&#xe63f;</i>首页
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="iconfont">&#xe673;</i>产品
                        </a>
                    </li>
                    <li></li>
                    <li><a href="#"><i class="iconfont">&#xe8c0;</i>消息</a></li>
                    <li><a href="#"><i class="iconfont">&#xe60f;</i>我的</a></li>
                </ul>
            </div>
        </div>
    </footer>
</body>
	<script>
$(function () {
    $(".btn-th").click(function() {
       var content = $("#content");
       var contact = $("input[name=contact]");
       if (contact.val()== ''||content.val()== '') {
                    layer.open({
                        content: '不能为空'
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                      });
       }else{
              $.ajax({
                url: '{:U('Member/suggest')}',
                type: 'POST',
                dataType: 'json',
                data: {content: content.val(),contact:contact.val()},
            })
            .done(function(data) {
                if (data.status == 1) {
                    layer.open({
                            content: data.msg
                            ,skin: 'msg'
                            ,time: 2 //2秒后自动关闭
                          });
                    window.location.href = "index";
                }else{
                    layer.open({
                            content: data.msg
                            ,skin: 'msg'
                            ,time: 2 //2秒后自动关闭
                          });
                    return;
                }
            })
       }
      
    


    })   
})
    </script>
</block>
