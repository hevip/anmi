<extend name="Base/common" />

<block name="main">
<body>
    <section id="BiaoD">
        <div class="XianS">
            <h1><span>请假人员</span><b>{$dataList['personal_code']}</b></h1>
            <h1><span>请假类型</span><b>{$dataList['leave_cate']}</b></h1>
            <h1><span>请假时间</span><b>{$dataList['hour']}小时</b></h1>
            <h1><span>开始时间</span><b>{$dataList['leave_start_time']}</b></h1>
            <h1><span>结束时间</span><b>{$dataList['leave_end_time']}</b></h1>
            <h1><span>申请理由</span><b>{$dataList['leave_reason']}</b></h1>
            <h1><span>附件内容</span><b><img style="width: 100%; margin-bottom: 1rem;" src="{$dataList['picture']}" alt="没有附件"></b></h1>
        </div> 
        <div class="clear"></div>
        <form action="" method="post" id ="auditorsAdd">

        <div class="tianxie_bd">
            <!--<p><span>*按照当前单位规定需要1级审核人员审批</span></p>-->
            <h1>请选择当前部门一级审批人</h1>
            <ul>
            <if condition="$chargeList eq ''">
                <span style="color: #afadad;font-size: 1.1rem;">还未设置审批人</span>
            <else />
            <volist name="chargeList" id="vo" key='k'>
                <li>
                    <input type="checkbox" class="male-b" value="{$vo['personal_code']}" name="firstCharge[]" id="male{$k+1}">
                    <label for="male{$k+1}"><span class="female-custom"></span>{$vo['personal_code']}</label>
                </li>
            </volist>
            </if>
            </ul>
            <!--<p><span>*按照当前单位规定需要选择抄送人员</span></p>-->
            <h1>请选择抄送人员</h1>
            <ul>
                <if condition="$cc neq ''">
                        <li>
                            <input type="checkbox" class="male-b" value="{$HR}" name="hr" >
                            <label for="male1" style="color: #a09999;"><span class="female-custom active"></span>{$HR}</label>
                        </li>
                        <volist name="cc" id="vo" key='k'>
                            <li>
                                <input type="checkbox" class="male-b" value="{$vo['personal_code']}" name="cc[]" id="male1{$k+1}">
                                <label for="male1{$k+1}"><span class="female-custom"></span>{$vo['personal_code']}</label>
                            </li>
                       </volist>
                <else />
                    <span style="color: #afadad;font-size: 1.1rem;">还未设置抄送人</span>
                </if>
            </ul>
            <input class="btn-th" type="submit" value="提交申请"/>
            </div>
        </form>
        
    </section>
    
</body>

<block name="jscript">
<script src="__JS__/XuanZe.js" type="text/javascript"></script>


<script>
  $(document).ready(function(){
    var formObj = $( '#auditorsAdd' );
    $("form").submit(function(e){
        if (check()) {
            var json = $( this ).serialize();
            $.ajax({
                url : '{:U('auditorsAdd')}',
                data : json,
                type : 'POST',
                async : true,
                dataType : 'json',
                success : function( data ) {
                    if ( data['status']==1 ) {
                        alert( data['info'] );
                      window.location.href = "{:U('Service/index')}";
                      // console.log(123);
                    } else {
                       alert(data['info']);
                    }
                }
            });
        }
        return false;
    } );


  

 } );
    function check() {
//         var firstCharge = $( 'input:radio[name="firstCharge"]:checked' );
         var firstCharge = $( 'input[type="checkbox"]' );
//        if ( !firstCharge.val() ) {
        if ( !firstCharge.is(':checked') ) {
            alert( '请选择审批人员' );
            firstCharge.focus();
            return false;
        }else{
            return true;
        }
        var cc = $( "input[type='checkbox']" );
        if ( !cc.is(':checked') ) {
            alert( '请选择抄送人员' );
            cc.focus();
            return false;
        }else{
            return true;
        }
    }
</script>
</block>
</block>