<extend name="Base/common" />

{// css样式区 }
<block name="link">
	<style type="text/css">
		.df_add{width:90%; height:auto; overflow:hidden; line-height:24px; margin:10px auto;}
		.df_add span{font-size:14px;color:#666;display:table-cell;width:75px;}
		.df_add div.text{float:left; width:auto;}
		.df_add div.text p{font-size:13px;color:#999;}
		.df_add div.text p span{color:#666;width:auto;}
		
		.df_add div.btn_default{float:right;text-align:center;}
		.df_add div.btn_default input.state{display:none;}
		.toggle {position: relative;display: block;margin: 8px 5px 0px auto;width:60px;height:24px;color: white;outline: 0;text-decoration: none;border-radius: 100px;border: 2px solid #dcdcdc;background-color:#fff;transition: all 500ms;-webkit-transition: all 500ms;-moz-transition: all 500ms;}
		.toggle:active {background-color: #f15350;}
		.toggle:hover:not(.toggle-moving):after {background-color: #fff;}
		.toggle:after {display: block;position: absolute;top: 1px;left:2px;width:18px;height:18px;text-align: center;text-transform: uppercase;font-size: 20px;color: white;background-color: #fff;border: 2px solid;transition: all 500ms;-webkit-transition: all 500ms;-moz-transition: all 500ms;}
		
		.toggle-on:after {content: '';border-radius: 50%;color: #dcdcdc;}
		.toggle-off{background:#f15350;}
		.toggle-off:after {content: '';border-radius: 50%;transform: translate(159%, 0);-webkit-transform: translate(159%, 0);-moz-transform: translate(159%, 0);right:0px;color: #f15350;}
		.toggle-moving { background-color: #f15350;}
		.toggle-moving:after {color:transparent;border-color: #dcdcdc;background-color: #fff;transition: color 0s, transform 500ms, border-radius 500ms,background-color 500ms;}
	</style>
</block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/address.js"></script>
</block>

<block name="main">
	<div class="bank_div">
		<form method="post" action="{:U('Address/add')}" id="address_form">
			<input type="hidden" name="http_referer" value="{$Think.server.HTTP_REFERER}" />
		    <ul>
		        <li>
		            <label class="input_size">&nbsp;&nbsp;公司名称
		                <input type="text" name="company" placeholder="请输入您的公司名称" />
		            </label>
		        </li>
		        <li>
		            <label class="input_size">&nbsp;&nbsp;联系人
		                <input type="text" name="nickname" placeholder="请输入联系人" />
		            </label>
		        </li>
		        <li>
		            <label class="input_size">手机号码
		                <input type="text" name="tel" placeholder="请输入您的手机号码" maxlength="11"/>
		            </label>
		        </li>
		        <li>
		            <label class="input_size">&nbsp;&nbsp;联系电话
		                <input type="text" name="contact" placeholder="请输入您的联系电话" />
		            </label>
		        </li>
		        <li>
		            <label class="input_size">
		            	所属省份
						<select name="province" id="province">
							<option value="">请选择</option>
							<volist name="province" id="volist">
								<option value="{$volist['province_id']}">{$volist['province']}</option>
							</volist>
						</select>
		            </label>
		        </li>
		        <li>
		            <label class="input_size">
		            	所在城市
						<select name="city" id="city">
							<option value="">请选择</option>
						</select>
		            </label>
		        </li>
		        <li>
		            <label class="input_size">
		            	所在区域
						<select name="area" id="area">
							<option value="">请选择</option>
						</select>
		            </label>
		        </li>
		        <li>
		            <label class="input_size">详细地址
		                <input type="text" name="intro" placeholder="请输入街道门牌信息" />
		            </label>
		        </li>
		        <li>
		            <label class="input_size">邮政编码
		                <input type="text" name="code" placeholder="请输入邮政编码" maxlength="6"/>
		            </label>
		        </li>
		    </ul>
		
			<div class="df_add">
				<div class="text">
					<p><span>设为默认地址</span></p>
					<p>注：每次下单时会使用该地址</p>
				</div>
				<div class="btn_default">
					<input class="state" type="hidden" name="is_default" value="0" />
					<a href="#" class="toggle toggle-on"></a>
				</div>
			</div>
		    <!-- button-->
		    <div class="input_div_b">
		        <form action="">
		            <div><input type="submit" value="保存"/></div>
		        </form>
		        <a href="javascript:history.go(-1);" class="per_d_a">取消</a>
		    </div>						
			<script type="text/javascript">
				$(document).ready(function(){
					$('.toggle').click(function(e) {
					    var toggle = this;
						var radio=$(".btn_default input.state");
						if(radio.val()==0){
							radio.val(1);
						}else{
							radio.val(0);
						}
					    e.preventDefault();
					    $(toggle).toggleClass('toggle-on').toggleClass('toggle-off').addClass('toggle-moving');
						setTimeout(function() {
							$(toggle).removeClass('toggle-moving');
					    }, 200)
					});
				});
			</script>
		</form>
	</div>
	<script type="text/javascript" src="__JS__/ExtendAreaClass.js"></script>
	<script type="text/javascript">
		
		jQuery(function() {
            jQuery.cityInit();
            jQuery.areaInit();
        });
		
	    $(function(){
            /*var banks =  $(".bank_div");
            banks.css({"height":$(window).height()});
            banks.css({"width":$(window).width()});
	        if(banks.css("display") == 'none'){
	            banks.fadeIn();
	        }*/
	        $('.per_d_a').click(function(){
	            if(banks.css("display") == 'block'){
	                banks.fadeOut();
	            }
	        });
	//       下拉
	        function ss(){
	            $('.span_bank1').click(function(){
	                if($('.bank_swi1').css("display") == 'none'){
	                    $('.bank_swi1').slideDown(500);
	                }else{
	                    $('.bank_swi1').slideUp(500);
	                }
	            });
	            $('.span_bank2').click(function(){
	                if($('.bank_swi2').css("display") == 'none'){
	                    $('.bank_swi2').slideDown(500);
	                }else{
	                    $('.bank_swi2').slideUp(500);
	                }
	            });
	            $('.span_bank3').click(function(){
	                if($('.bank_swi3').css("display") == 'none'){
	                    $('.bank_swi3').slideDown(500);
	                }else{
	                    $('.bank_swi3').slideUp(500);
	                }
	            });
	        }
	        ss();
	    });
	</script>
</block>