<extend name="Base/common" />
<block name="main">
 
<body>
	<section id="BiaoD">
		<div class="XianS">
			<h1><span>请假人员</span><b>{$approvalInfo['personal_code']}</b></h1>
			<h1><span>请假类型</span><b>{$approvalInfo['leave_cate']}</b></h1>
			<h1><span>请假时长</span><b>{$approvalInfo['hour']}小时</b></h1>
			<h1><span>开始时间</span><b>{$approvalInfo['leave_start_time']}</b></h1>
			<h1><span>结束时间</span><b>{$approvalInfo['leave_end_time']}</b></h1>
			<h1><span>申请理由</span><b>{$approvalInfo['leave_reason']}</b></h1>
			<h1><span>附件内容</span><b><img src="{$approvalInfo['picture']}" alt="没有附件"></b></h1>
		</div> 
		<if condition="$authority neq 1" >
		<form action="{:U('addApproval')}" method="POST" id="addApproval">
		<input type="hidden" name="id" value="{$approvalInfo['id']}">
		<div class="tianxie_bd">
			<h1 style="color: #999999;">审批意见</h1>
			<ul>
				<li>
		            <input type="radio" class="male-a" name="status" id="male" value="1">
		            
					<label for="male"><span class="female-custom"></span>同意</label> 
				</li>
				<li>
		            <input type="radio" class="male-a" name="status" id="male1" value="2">
		            
					<label for="male1"><span class="female-custom"></span>不同意</label> 
				</li>
			</ul>
			<!--<p class="dj_xz">
            <volist name="phraseList" id="vo">
				<a href="javascript:void(0);" data-id="{$vo.content}">{$vo.content}</a>
            </volist>
			</p>-->
			<textarea placeholder="{$phraseList}" name="remind" rows="" cols="" class="text"></textarea>
			<input class="btn-th" type="submit" value="提交审核"/>
			</div>
		</form>
		<else />
		<form action="{:U('addApproval')}" method="post" id ="addNextCharge">
			<input type="hidden" name="id" value="{$approvalInfo['id']}">
        	<div class="tianxie_bd">
            <p><span>*按照当前单位规定需要上一级审核人员审批</span></p>
            <h1>请选择当前部门上一级审批人员</h1>
            <ul>
            <volist name="nextChargeList" id="vo" key='k'>
                <li>
                   <!-- <input type="radio" class="male-a" value="{$vo.id}" name="{$nextLevel}" id="male{$k+1}">
                    <label for="male{$k+1}"><span <if condition="$nextLevelCharge eq $vo['id']"> class="female-custom active"<else />class="female-custom"</if>></span>{$vo['personal_code']}</label>-->
					<input type="radio" class="male-a cod" value="{$vo['personal_code']}" name="nextCharge" id="male{$k+1}">

					<label for="male{$k+1}"><span class="female-custom"></span>{$vo['personal_code']}</label>
                </li>
            </volist>
            </ul>
           <!--<if condition="$nextLevelCharge eq NULL">-->
            <input class="btn-th next" type="submit" value="提交上一级"/>
            <!--</if>-->
            </div>
        </form>
		</if>
	</section>
	
</body>
<script type="text/javascript">
	$('.dj_xz a').click(function(){
		$(this).toggleClass('a_xz');
	})
</script>
<script src="__JS__/XuanZe.js" type="text/javascript"></script>
<script>
  $( function(){
    {*var formObj = $( '#addNextCharge' );*}
    {*formObj.on( 'submit', function() {*}
        {*var radio = $('radio').is(':checked');*}
        {*if ( radio) {*}
            {*alert( '请选择审批人员' );*}
            {*return false;*}
        {*}*}

        {*var json = $( this ).serialize();*}
        {*$.ajax({*}
            {*url : '{:U('addNextCharge')}',*}
            {*data : json,*}
            {*type : 'POST',*}
            {*async : true,*}
            {*dataType : 'json',*}
            {*success : function( data ) {*}
                {*if ( data['status']==1 ) {*}
                    {*alert( data['info'] );*}
                  {*window.location.href = "{:U('Service/index')}";*}


                {*} else {*}
                   {*alert(data['info']);*}

                {*}*}
            {*}*}
        {*});*}
        {*return false;*}
    {*} );*}

    {*var formObj2 = $( '#addApproval' );*}
    {*formObj2.on( 'submit', function() {*}
    	{*$arr = [];*}
    	{*$('.dj_xz .a_xz').each(function(i){*}
    		{*$arr.push($(this).data('id'));*}
    	{*})*}
    	{*if($arr == ''){*}
    		{*alert('请选择1111');return false;*}
    	{*}*}
    	{*$('.type').attr('value',$arr.join(','));*}
        {*var radio = $('radio').is(':checked');*}
        {*if ( radio) {*}
            {*alert( '请选择是否通过审核' );*}
            {*return false;*}
        {*}*}
        {*var json = $( this ).serialize();*}
        {*$.ajax({*}
            {*url : '{:U('addApproval')}',*}
            {*data : json,*}
            {*type : 'POST',*}
            {*async : true,*}
            {*dataType : 'json',*}
            {*success : function( data ) {*}
                {*if ( data['status']==1 ) {*}
                    {*alert( data['info'] );*}
                  {*window.location.href = "{:U('Service/index')}";*}
                  {*// console.log(123);*}
                {*} else {*}
                   {*alert(data['info']);*}
                {*}*}
            {*}*}
        {*});*}
        {*return false;*}
    {*} );*}
 } );
</script>
</block>