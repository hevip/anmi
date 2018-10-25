<extend name="Base/common" />
<block name="jscript">
    <script src="__JS__/laydate.js"></script> 

</block>
<block name="main">


<body>
    <section id="BiaoD">
        <form action="carAuditors" method="post" enctype="multipart/form-data" id="auditors">
        <div class="tianxie_bd">
             <h1>用车类型：</h1>
            <p>
                <select name="car_num">
                    <!-- <option value="" selected="selected" disabled="disabled">选择假期类型</option> -->
                    <volist name="carList" id="vo">
                    <option value="{$vo.car_num}">{$vo.car_num}</option>
                    </volist>
                </select>
            </p>
            <h1>用车人员：</h1>
            <p>
                <em>{$member['personal_code']}</em>
                <input type="hidden" name="personal_code" value="{$member['personal_code']}">
            </p>
             <h1>用车单位：</h1>
            <p>
                <em>{$member['companyname']}</em>
                <input type="hidden" name="companyname" value="{$member['companyname']}">
            </p>
             <h1>带车干部：</h1>
            <p>
              <input type="text" name="cadres" value="" placeholder="带车干部">
                
            </p>
             <h1>用车里程：</h1>
            <p>
                
                <input type="text" name="mileage" value="" placeholder="用车里程">
            </p>
             <h1>用车用途：</h1>
            <p>
               
                <input type="text" name="caruse" value="" placeholder="用车用途,最多10个字"maxlength="10" >
            </p>
 
            <h1>开始时间：</h1>
            <p>
                <label for="test1"><i class="iconfont">&#xe678;</i></label>
                <input placeholder="开始时间" type="text" name="car_start_time" id="test1" value="" readonly="readonly" />
            </p>
            <h1>结束时间：</h1>
            <p>
                <label for="test2"><i class="iconfont">&#xe678;</i></label>
                <input placeholder="结束时间" type="text" name="car_end_time" id="test2" value="" readonly="readonly" />
            </p> 
            </p>
      
        </div>          
            <input class="btn-th" type="submit" value="选择审核人员"/>
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
  $( function() {
    var formObj = $( '#auditors' );
    formObj.on( 'submit', function() {
      
        var leave_start_time = $( this ).find( 'input[name="leave_start_time"]' );
        if ( leave_start_time.val() == "" ) {

            alert( '请选择开始时间' );
            leave_start_time.focus();
            return false;
        }
        var leave_end_time = $( this ).find( 'input[name="leave_end_time"]' );
        if ( leave_end_time.val() == "" ) {
            alert( '请选择结束时间' );
            leave_end_time.focus();
            return false;
        } 
         var cadres = $( this ).find( 'input[name="cadres"]' );
        if ( cadres.val() == "" ) {
            alert( '请填写用车干部' );
            cadres.focus();
            return false;
        } 
         var mileage = $( this ).find( 'input[name="mileage"]' );
        if ( mileage.val() == "" ) {
            alert( '请填写用车里程' );
            mileage.focus();
            return false;
        } 
         var caruse = $( this ).find( 'input[name="caruse"]' );
        if ( caruse.val() == "" ) {
            alert( '请填写用车用途' );
            caruse.focus();
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