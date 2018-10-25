<extend name="Base/common" />
<block name="main">
  

<body>
	<section id="BiaoD">
		<div class="Jl_list">
			<ul>
				<if condition="$count eq 0">
					<div style="color: #ada7a7; text-align: center;">暂无记录</div>
				<else />
					<volist name="car" id="vo">
						<li>
							<a href="{:U( 'Service/carRecordRead',array('id'=>$vo['id']))}">
								<em >
								<if condition="$vo.status eq 1" >已通过
								<elseif condition="$vo.status eq 2" />已拒绝
								</if>
								</em>
								<img src="__ROOT__/{$face}"/>
								<span>
									{$vo.car_num}
									<b>{$vo.addtime|date='Y-m-d H:i:s',###}</b>
								</span>
							</a>
						</li>
					</volist>
					<volist name="leaveList" id="vo">
						<li>
							<a href="{:U( 'Service/leaveRecordRead',array('id'=>$vo['id']))}">
								<em >
									<if condition="$vo.status eq 0">审批中
										<elseif condition="$vo.status eq 1" />已通过
										<elseif condition="$vo.status eq 2" />已拒绝
									</if>
								</em>
								<img src="__ROOT__/{$face}"/>
								<span>
									{$vo.leave_reason}
									<b>{$vo.addtime|date='Y-m-d H:i:s',###}</b>
								</span>
							</a>
						</li>
					</volist>
				</if>
			</ul>
		</div>
		
	</section>
	
</body>
<script src="__JS__/laydate.js"></script> <!-- 改成你的路径 -->
<script>
lay('#version').html('-v'+ laydate.v);

//执行一个laydate实例
laydate.render({
	elem: '#test1', //指定元素
//	type: 'datetime',
});
laydate.render({
	elem: '#test2', //指定元素
//	type: 'datetime'

});
</script>

<script>
  $( function() {


    {*var formObj = $( '#search' );*}
    {*formObj.on( 'submit', function() {*}
    	{*$arr1 = [];*}
    	{*$arr2 = [];*}
    	{*$('.status .DianJ_xis').each(function(i){*}
    		{*$arr1.push($(this).data('status'));*}
    	{*})*}
    	{*$('.cate .DianJ_xis').each(function(i){*}
    		{*$arr2.push($(this).data('cate'));*}
    	{*})*}
    	{*$('.status').attr('value',$arr1.join(','));*}
    	{*$('.cate').attr('value',$arr2.join(','));*}
        {*var radio = $('radio').is(':checked');*}
        {*if ( radio) {*}
            {*alert( '请选择是否通过审核' );*}
            {*return false;*}
        {*}*}
        {*var json = $( this ).serialize();*}
        {*$.ajax({*}
            {*url : '{:U('leaveRecord')}',*}
            {*data : json,*}
            {*type : 'POST',*}
            {*async : true,*}
            {*dataType : 'json',*}

            {*success : function( data ) {*}
                {*if ( data['status']==1 ) {*}

	                  {*var msg   = data['data'];*}
	                  {*var html  =  '';*}

	                  {*for(i in msg ){*}
	                  	{*var value = msg[i];*}
	                  	{*var dayTime = getTime(value['addtime']);*}
	                  	{*var url = "{:U( 'Service/leaveRecordRead')}"+"?id="+value['id'];*}
	                    {*html +=  '<li>';*}
                        {*html +=      '<a href="'+url+'">';*}
                        {*html +=      '<em>';*}
                        {*switch(value['status'])*}
						{*{*}
						{*case '1':*}
						   	{*html +=  '已通过';*}
						{*break;*}
						{*case '2':*}
						  	{*html +=  '已拒绝';*}
						{*break;*}
						{*default:*}
						 	{*html +=  '审批中';*}
						{*break;*}
						{*}*}
                        {*html +=      '</em>';*}
                        {*html +=      '<img src="'+'/'+value["face"]+'"/>';*}
                        {*html +=      '<span>';*}
                        {*html +=      ''+value["title"]+'';*}
                        {*html +=      '<b>'+dayTime+'</b>';*}
                        {*html +=      '</span>';*}
                        {*html +=      '</a>';*}
                        {*html +=      '</li>';*}
	                  {*}*}
	                {*$('.Jl_list ul').html(html);*}
                {*} else {*}
                   {*alert(data['info']);*}

                {*}*}
            {*}*}
        {*});*}
        {*return false;*}
    {*} );*}

    function getTime(time){
    	var time =time;
     	var date = new Date(time*1000);
     	return date.getFullYear()+ '-' + (date.getMonth() + 1)+ '-' + date.getDate()+ ' ' +date.getHours()+ ':' +date.getMinutes()+ ':' +date.getSeconds();
    }

 } );

    {*$( function() {*}

        {**}
    {*var formObj = $( '#time-search' );*}
    {*formObj.on( 'submit', function() {*}
        {*// $arr1 = [];*}
        {*// $arr2 = [];*}
        {*// $('.status .DianJ_xis').each(function(i){*}
        {*//     $arr1.push($(this).data('status'));*}
        {*// })*}
        {*// $('.cate .DianJ_xis').each(function(i){*}
        {*//     $arr2.push($(this).data('cate'));*}
        {*// })*}
        {*// $('.status').attr('value',$arr1.join(','));*}
        {*// $('.cate').attr('value',$arr2.join(','));*}
        {*// var radio = $('radio').is(':checked');*}
        {*var leave_start_time = $(" input[ name='leave_start_time' ] ").val();*}
        {*var leave_end_time = $(" input[ name='leave_end_time' ] ").val();*}
        {*if ( leave_start_time=='') {*}
            {*alert( '请选择开始时间' );*}
            {*return false;*}
        {*}*}
        {*if ( leave_end_time=='') {*}
            {*alert( '请选择结束时间' );*}
            {*return false;*}
        {*}*}
        {**}

        {*var json = $( this ).serialize();*}
        {*$.ajax({*}
            {*url : '{:U('leaveRecord')}',*}
            {*data : json,*}
            {*type : 'POST',*}
            {*async : true,*}
            {*dataType : 'json',*}
         {**}
            {*success : function( data ) {*}
                {*if ( data['status']==1 ) {*}

                      {*var msg   = data['data'];*}
                      {*var html  =  '';*}

                      {*for(i in msg ){*}
                        {*var value = msg[i];             *}
                        {*var dayTime = getTime(value['addtime']);*}
                        {*var url = "{:U( 'Service/leaveRecordRead')}"+"?id="+value['id'];*}
                        {*html +=  '<li>';*}
                        {*html +=      '<a href="'+url+'">';*}
                        {*html +=      '<em>';*}
                        {*switch(value['status'])*}
                        {*{*}
                        {*case '1':*}
                            {*html +=  '已通过';*}
                        {*break;*}
                        {*case '2':*}
                            {*html +=  '已拒绝';*}
                        {*break;*}
                        {*default:*}
                            {*html +=  '审批中';*}
                        {*break;*}
                        {*}*}
                        {*html +=      '</em>';*}
                        {*html +=      '<img src="'+'/'+value["face"]+'"/>';*}
                        {*html +=      '<span>';*}
                        {*html +=      ''+value["title"]+'';*}
                        {*html +=      '<b>'+dayTime+'</b>';*}
                        {*html +=      '</span>';*}
                        {*html +=      '</a>';*}
                        {*html +=      '</li>';*}
                      {*}*}
                    {*$('.Jl_list ul').html(html);*}
                {*} else {*}
                   {*alert(data['info']);*}
                 {**}
                {*}*}
            {*}*}
        {*});*}
        {*return false;*}
    {*} );*}

    {*function getTime(time){*}
        {*var time =time;*}
        {*var date = new Date(time*1000);*}
        {*return date.getFullYear()+ '-' + (date.getMonth() + 1)+ '-' + date.getDate()+ ' ' +date.getHours()+ ':' +date.getMinutes()+ ':' +date.getSeconds();*}
    {*}*}

 {*} );*}
</script>

</block>