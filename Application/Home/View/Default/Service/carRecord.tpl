<extend name="Base/common" />
<block name="main">
  

<body>
	<!--遮盖层 start-->
	<div class="mask_a"></div>
	<section id="TaChuang">
		<!--<div class="btn_Qr">
			<input type="reset" class="Qx_Cz btn_Qr_sty" name="" id="" value="取消" />
			<input type="submit" class="Qr_sx btn_Qr_sty" name="" id="" value="确认" />
		</div>-->
		<div class="TanC_con">
			<h1>审批结果筛选</h1>
			<ul class="status">
				<li>
					<a href="{:U('carRecord')}?lab=0" data-status="0">审批中</a>
				</li>
				<li>
					<a href="{:U('carRecord')}?lab=1" data-status="1">已通过</a>
				</li>
				<li>
					<a href="{:U('carRecord')}?lab=2" data-status="2">已拒绝</a>
				</li>
			</ul>
		</div>
	</section>
	<!--遮盖层 end-->
	
	<section id="BiaoD">		
		<div class="Top_saiX">
			<div class="Top_saiX_con">
				<div class="Top_saiX_L">
					<a href="#" class="Sx_start"><i class="iconfont">&#xe626;</i>筛选</a>
				</div>
				<div class="Top_saiX_R">
					<form action="" method="post" id="search">
						<input type="text" name="personal_code" placeholder="人员代码" style="border: 1px solid #827b7b;" />
						<input type="hidden" name="status" id="" value="" class="status" />
						<input type="hidden" name="cate" id="" value="" class="cate" />
						<input type="submit" value="搜索" style="font-size: 1.35rem; background: #f3eded; color: #666; margin-top: 1.2rem;  margin-right: 1.2rem;"/>
					</form>
					<!--<a href="#">搜索</a>-->
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$(function(){
				var hei_al = $(window).height();
				var Top_hei=$('.Top_saiX').height();
				var Tc_Hei=hei_al-Top_hei;
				var mask_a =$('.mask_a');
				var TaChuang =$('#TaChuang');
				TaChuang.css('height',Tc_Hei-1+'px');
				mask_a.css('height',hei_al+'px');				
				$('.TanC_con ul li a').click(function(){
				    $(this).toggleClass('DianJ_xis');
				});	
				
				$('.Qx_Cz,.Qr_sx').click(function(){
					closeNav();
				})
				mask_a.click(function(){
					 closeNav();
				});
				$('.Sx_start').click(function(){
					openNav();
				})
				function openNav(){
					TaChuang.addClass('transform-0');
			   		mask_a.addClass('transform-0');
			   		$('body').css({"overflow":"hidden",'height':'100%'});
				}
				function closeNav(){
					TaChuang.removeClass('transform-0');
			   		mask_a.removeClass('transform-0');
			   		$('body').css({"overflow":"auto",'height':'auto'});
				}
			})
			
		</script>
		<form action="" method="post" id="time-search">
			<div class="tianxie_bd">
				<div class="xuze_sa_time">
					<p>
						<label for="test1"><i class="iconfont">&#xe678;</i></label>
						<input placeholder="开始时间" type="text" name="car_start_time" id="test1" value="" />
					</p>
					<span>-</span>
					<p>
						<label for="test2"><i class="iconfont">&#xe678;</i></label>
						<input placeholder="结束时间" type="text" name="car_end_time" id="test2" value="" />
					</p>
					<div><input class="btn-th" type="submit" value="确认"/></div>
				</div>			
			</div>	
		</form>
		<div class="Jl_list">
			<ul>
				<if condition="$carAppList eq ''">
					<div style="color: #ada7a7; text-align: center;">暂无记录</div>
					<else />
						<volist name="carAppList" id="vo">
							<li>
								<a href="{:U( 'Service/carRecordRead',array('id'=>$vo['id']))}">
									<em>
									<if condition="$vo.status eq 0">审批中
									<elseif condition="$vo.status eq 1" />已通过
									<elseif condition="$vo.status eq 2" />已拒绝
									</if>
									</em>
									<img src="/{$member['face']}"/>
									<span>
										{$vo.car_num}
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
  elem: '#test1'
});
laydate.render({
  elem: '#test2'

});
</script>

<script>
  $( function() {

  		
    var formObj = $( '#search' );
    formObj.on( 'submit', function() {
    	$arr1 = [];
    	$arr2 = [];
    	$('.status .DianJ_xis').each(function(i){
    		$arr1.push($(this).data('status'));
    	})
    	$('.cate .DianJ_xis').each(function(i){
    		$arr2.push($(this).data('cate'));
    	})
    	$('.status').attr('value',$arr1.join(','));
    	$('.cate').attr('value',$arr2.join(','));
        var radio = $('radio').is(':checked');
        if ( radio) {
            alert( '请选择是否通过审核' );
            return false;
        }
     	

        var json = $( this ).serialize();
        $.ajax({
            url : '{:U('carRecord')}',
            data : json,
            type : 'POST',
            async : true,
            dataType : 'json',
         
            success : function( data ) {
                if ( data['status']==1 ) {

	                  var msg   = data['data'];
	                  var html  =  '';

	                  for(i in msg ){
	                  	var value = msg[i];	            
	                  	var dayTime = getTime(value['addtime']);
	                  	var url = "{:U( 'Service/carRecordRead')}"+"?id="+value['id'];
	                    html +=  '<li>';
                        html +=      '<a href="'+url+'">';
                        html +=      '<em>';
                        switch(value['status'])
						{
						case '1':
						   	html +=  '已通过';
						break;
						case '2':
						  	html +=  '已拒绝';
						break;
						default:
						 	html +=  '审批中';
						break;
						}
                        html +=      '</em>';
                        html +=      '<img src="'+'/'+value["face"]+'"/>';
                        html +=      '<span>';
                        html +=      ''+value["car_num"]+'';
                        html +=      '<b>'+dayTime+'</b>';
                        html +=      '</span>';
                        html +=      '</a>';
                        html +=      '</li>';
	                  }
	                $('.Jl_list ul').html(html);
                } else {
                   alert(data['info']);
                 
                }
            }
        });
        return false;
    } );

    function getTime(time){
    	var time =time;
     	var date = new Date(time*1000);
     	return date.getFullYear()+ '-' + (date.getMonth() + 1)+ '-' + date.getDate()+ ' ' +date.getHours()+ ':' +date.getMinutes()+ ':' +date.getSeconds();
    }

 } );

    $( function() {

        
    var formObj = $( '#time-search' );
    formObj.on( 'submit', function() {
        // $arr1 = [];
        // $arr2 = [];
        // $('.status .DianJ_xis').each(function(i){
        //     $arr1.push($(this).data('status'));
        // })
        // $('.cate .DianJ_xis').each(function(i){
        //     $arr2.push($(this).data('cate'));
        // })
        // $('.status').attr('value',$arr1.join(','));
        // $('.cate').attr('value',$arr2.join(','));
        // var radio = $('radio').is(':checked');
        var car_start_time = $(" input[ name='car_start_time' ] ").val();
        var car_end_time = $(" input[ name='car_end_time' ] ").val();
        if ( car_start_time=='') {
            alert( '请选择开始时间' );
            return false;
        }
        if ( car_end_time=='') {
            alert( '请选择结束时间' );
            return false;
        }
        

        var json = $( this ).serialize();
        $.ajax({
            url : '{:U('carRecord')}',
            data : json,
            type : 'POST',
            async : true,
            dataType : 'json',
         
            success : function( data ) {
                if ( data['status']==1 ) {

                      var msg   = data['data'];
                      var html  =  '';

                      for(i in msg ){
                        var value = msg[i];             
                        var dayTime = getTime(value['addtime']);
                        var url = "{:U( 'Service/carRecordRead')}"+"?id="+value['id'];
                        html +=  '<li>';
                        html +=      '<a href="'+url+'">';
                        html +=      '<em>';
                        switch(value['status'])
                        {
                        case '1':
                            html +=  '已通过';
                        break;
                        case '2':
                            html +=  '已拒绝';
                        break;
                        default:
                            html +=  '审批中';
                        break;
                        }
                        html +=      '</em>';
                        html +=      '<img src="'+'/'+value["face"]+'"/>';
                        html +=      '<span>';
                        html +=      ''+value["car_num"]+'';
                        html +=      '<b>'+dayTime+'</b>';
                        html +=      '</span>';
                        html +=      '</a>';
                        html +=      '</li>';
                      }
                    $('.Jl_list ul').html(html);
                } else {
                   alert(data['info']);
                 
                }
            }
        });
        return false;
    } );

    function getTime(time){
        var time =time;
        var date = new Date(time*1000);
        return date.getFullYear()+ '-' + (date.getMonth() + 1)+ '-' + date.getDate()+ ' ' +date.getHours()+ ':' +date.getMinutes()+ ':' +date.getSeconds();
    }

 } );
</script>

</block>