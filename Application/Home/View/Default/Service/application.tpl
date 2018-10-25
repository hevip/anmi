<extend name="Base/common" />
<block name="main">
<body>
    <section id="BiaoD">
        <form action="auditors" method="post" enctype="multipart/form-data" id="auditors">
        <div class="tianxie_bd">
            <h1>请假人员：</h1>
            <p>
                <em>{$member['personal_code']}</em>
                <input type="hidden" name="personal_code" value="{$member['personal_code']}">
            </p>
            <h1>假期类型：</h1>
            <p>
                <select name="leave_cate" id="leave_cate">
                <option value="" selected="selected" disabled="disabled">选择假期类型</option>
                    <volist name="cate" id="vo">
                    <option value="{$vo.title}">{$vo.title}</option>
                    </volist>
                </select>
            </p>
            <h1>开始时间：</h1>
            <p>
                <label for="test1"><i class="iconfont">&#xe678;</i></label>
                <input placeholder="开始时间" type="text" name="leave_start_time" id="test1" value="" readonly="readonly" />
            </p>
            <h1>结束时间：</h1>
            <p>
                <label for="test2"><i class="iconfont">&#xe678;</i></label>
                <input placeholder="结束时间" type="text" name="leave_end_time" id="test2" value="" readonly="readonly" />
            </p> 
            </p>
            <h1>申请理由：</h1>
            <p>
                <textarea name="leave_reason" rows="1" cols="1"maxlength="100" placeholder="不超过100字" id="leave_reason"></textarea>
            </p>
            <h1>选择附件：</h1>
            <div class="shangT_ph">
                <div class="shangT_ph_tu">
                    <input type="file" name="picture" id="shangchua" value="" onchange="preview(this)" />
                    <label for="shangchua"><div id="preview"><span>+</span>  暂未选择任何文件</div></label>
                </div>
            <i>*仅限图片一张，如没有，可以不进行提交</i>
            </div>
        </div>
            <input class="btn-th" type="submit" value="选择审批人"/>
        </form>
        
    </section>
    
</body>
<!-- 改成你的路径 -->
<script>
lay('#version').html('-v'+ laydate.v);

//执行一个laydate实例
laydate.render({
  elem: '#test1', //指定元素
  type: 'datetime',
});
laydate.render({
  elem: '#test2', //指定元素
  type: 'datetime'

});
</script>
    <script>
        $(".male-a").click( function () {
            $(this).parents("li").siblings("li").children('label').children("span").removeClass("active");
            $(this).parents("li").siblings("li").children("label").css('color','#0f0f0f');
            $(this).siblings("label").children('span').addClass("active");
            $(this).siblings('label').css('color','#1194f7');
        });
        $(".male-b").click( function (){
            if ($(this).is(':checked')){
                $(this).siblings("label").children('span').addClass("active");
                $(this).siblings('label').css('color','#1194f7');
            }else{
                $(this).siblings("label").children('span').removeClass("active");
                $(this).siblings('label').css('color','#0f0f0f');
            }
        })
    </script>
<script>
  $( function() {
    var formObj = $( '#auditors' );
    formObj.on( 'submit', function() {
        var leave_cate = $( '#leave_cate' ).val( );
        if ( leave_cate == "" ) {
            alert( '请选择请假类别' );
            return false;
        } 
        var leave_start_time = $( this ).find( 'input[name="leave_start_time"]' );
        if ( leave_start_time.val() == "" ) {
            alert( '请选择开始时间' );
            return false;
        }
        var leave_end_time = $( this ).find( 'input[name="leave_end_time"]' );
        if ( leave_end_time.val() == "" ) {
            alert( '请选择结束时间' );
            return false;
        }
        var leave_reason = $( '#leave_reason' ).val(  );
        if ( leave_reason == "" ) {
            alert( '请输入请假理由' );
            return false;
        } 
        
     
    } );

 } );
</script>

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

</block>