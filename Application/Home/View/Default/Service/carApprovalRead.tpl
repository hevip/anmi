<extend name="Base/common" />
<block name="main">
 
<body>
	<section id="BiaoD">
		<div class="XianS">
			 <h1><span>车辆类型</span><b>{$approvalInfo['car_num']}</b></h1>
            <h1><span>用车人员</span><b>{$approvalInfo['personal_code']}</b></h1>
            <h1><span>用车单位</span><b>{$approvalInfo['companyname']}</b></h1>
            <h1><span>带车干部</span><b>{$approvalInfo['cadres']}</b></h1>
            <h1><span>用车里程</span><b>{$approvalInfo['mileage']}公里</b></h1>
            <h1><span>用车用途</span><b>{$approvalInfo['caruse']}</b></h1>
            <h1><span>用车时长</span><b>{$approvalInfo['duration']}小时</b></h1>
            <h1><span>开始用车</span><b>{$approvalInfo['car_start_time']}</b></h1>
            <h1><span>结束用车</span><b>{$approvalInfo['car_end_time']}</b></h1>
		</div> 
		<if condition="$authority neq 1" >
		<form action="{:U('addCarApproval')}" method="post" id="addApproval">
		<input type="hidden" name="id" value="{$approvalInfo['id']}">
		<input type="hidden" name="car_num" value="{$approvalInfo['car_num']}">
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
            <!-- 注意事项 -->
			<!--<div class="dj_xz">
            <volist name="phraseList" id="vo">
				<a href="javascript:void(0);" data-id="{$vo.content}">{$vo.content}</a>
            </volist>
			</div>-->
			<textarea placeholder="{$phraseList}" name="remind" rows="" cols=""></textarea>
			<input class="btn-th" type="submit" value="提交审核"/>
			</div>
		</form>
		<else />
		<form action="{:U('addCarApproval')}" method="post" id ="addNextCharge">
			<input type="hidden" name="id" value="{$id}">
        <div class="tianxie_bd">
            <p><span>*按照当前单位规定需要上一级审核人员审批</span></p>
            <h1>请选择当前部门上一级审批人员</h1>
            <ul>
            <volist name="nextChargeList" id="vo" key='k'>
                <li>
                    <!--<input type="radio" class="male-a" value="{$vo.id}" name="{$nextLevel}" id="male{$k+1}">
                    
                    <label for="male{$k+1}"><span <if condition="$nextLevelCharge eq $vo['id']"> class="female-custom active"<else />class="female-custom"</if>></span>{$vo['personal_code']}</label>-->
					<input type="radio" class="male-a cod" value="{$vo['personal_code']}" name="nextCharge" id="male{$k+1}">

					<label for="male{$k+1}"><span class="female-custom"></span>{$vo['personal_code']}</label>
                </li>
            </volist>
   
            </ul>
           <if condition="$nextLevelCharge eq NULL">
            <input class="btn-th" type="submit" value="提交上一级"/>
            </if>
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
  {*$( function() {*}
    {*var formObj = $( '#addNextCharge' );*}
    {*formObj.on( 'submit', function() {*}
        {*var radio = $('radio').is(':checked');*}
        {*if ( radio) {*}
            {*alert( '请选择审批人员' );*}
            {*return false;*}
        {*}*}
      {**}
        {*var json = $( this ).serialize();*}
        {*$.ajax({*}
            {*url : '{:U('addCarNextCharge')}',*}
            {*data : json,*}
            {*type : 'POST',*}
            {*async : true,*}
            {*dataType : 'json',*}
         {**}
            {*success : function( data ) {*}
                {*if ( data['status']==1 ) {*}
                    {*alert( data['info'] );*}
                  {*window.location.href = "{:U('Service/index')}";*}
                   {**}
                    {**}
                {*} else {*}
                   {*alert(data['info']);*}
                 {**}
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
    		{*alert('请选择审批意见');return false;*}
    	{*}*}

    	{*$('.type').attr('value',$arr.join(','));*}
        {*var radio = $('radio').is(':checked');*}
        {*if ( radio) {*}
            {*alert( '请选择是否通过审核' );*}
            {*return false;*}
        {*}*}
      	{**}
        {*var json = $( this ).serialize();*}
        {*$.ajax({*}
            {*url : '{:U('addCarApproval')}',*}
            {*data : json,*}
            {*type : 'POST',*}
            {*async : true,*}
            {*dataType : 'json',*}
         {**}
            {*success : function( data ) {*}
                {*if ( data['status']==1 ) {*}
                    {*alert( data['info'] );*}
                  {*window.location.href = "{:U('Service/index')}";*}
                  {*// console.log(123);*}
                   {**}
                    {**}
                {*} else {*}
                   {*alert(data['info']);*}
                 {**}
                {*}*}
            {*}*}
        {*});*}
        {*return false;*}
    {*} );*}

    

// } );
</script>
</block>