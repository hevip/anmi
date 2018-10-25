<div class="geren">
    <ul>
        <li>
            <div class="li_div" onclick="LocationUrl('{:U('Member/news')}');">
				<img src="__IMAGES__/user_icon01.png" />
				<a class="li_div_name">最新消息</a>
				<if condition="$newShow gt 0">
	                <a class="li_div_fr">
	                	<span>{$newShow}</span>
					</a>
				</if>
                <a class="iconfont1">&#xf007f;</a>
            </div>
        </li>
		<if condition="$member['username'] eq ''">
	        <li>
	            <div class="li_div" onclick="LocationUrl('{:U('Member/phone_bind')}');">
					<img src="__IMAGES__/user_icon01.png" />
					<a class="li_div_name">手机号码</a>
	                <a class="iconfont1">未绑定&#xf007f;</a>
	            </div>
	        </li>
		<else />
	        <li>
	            <div class="li_div" onclick="LocationUrl('{:U('Member/phone')}');">
					<img src="__IMAGES__/user_icon10.png" />
					<a class="li_div_name">手机号码</a>
	                <a class="iconfont1">{$member['username']}&nbsp;&nbsp;&#xf007f;</a>
	            </div>
	        </li>
		</if>
        <li>
            <div class="li_div" onclick="LocationUrl('{:U('Member/recommend/code/'.$member['referral_code'])}');">
				<img src="__IMAGES__/user_icon02.png" />
				<a class="li_div_name">我的二维码</a>
				<a class="iconfont1">&#xf007f;</a>
	    	</div>
        </li>
        <li>
            <div class="li_div">
				<img src="__IMAGES__/user_icon03.png" />
				<a class="li_div_name">我的消费额</a>
				<a class="li_div_fr">（共计{$totlalPrice}元）</a>
	    	</div>
        </li>
        <li>
            <div class="li_div" onclick="LocationUrl('{:U('Member/my_account')}');">
				<img src="__IMAGES__/user_icon04.png" />
				<a class="li_div_name">我的享豆</a>
                <a class="iconfont1">&#xf007f;</a>
                
            </div>
        </li>
        <li class="border_li">
            <div class="li_div" onclick="LocationUrl('{:U('Member/my_account#main_row05')}');">
				<img src="__IMAGES__/user_icon05.png" />
            	<a class="li_div_name">兑换礼品</a>
				<a class="iconfont1">&#xf007f;</a>
	    	</div>
         </li>
        <li>
            <div class="li_div" onclick="LocationUrl('{:U('Member/my_account#main_row04')}');">
				<img src="__IMAGES__/user_icon06.png" />
				<a class="li_div_name">我的级别</a>
                <a class="li_div_fr">（{$member['level']|tmpl_memberLevel}）</a>
                <a class="iconfont1">&#xf007f;</a>
            </div>
        </li>
        <li>
            <div class="li_div" onclick="javascript:void(0)">
				<img src="__IMAGES__/user_icon07.png" />
				<a class="li_div_name">我要贷款</a>
                <a class="iconfont1">&#xf007f;</a>
            </div>
        </li>
        <li class="border_li">
            <div class="li_div" onclick="LocationUrl('{:U('Member/me_fenshi')}');">
            	<img src="__IMAGES__/user_icon08.png" />
				<a class="li_div_name">我的直接粉丝({$me_fenshi})</a>
				<a class="iconfont1">&#xf007f;</a>
			</div>
        </li>
		<li class="border_li">
	        <div class="li_div">
	        	<img src="__IMAGES__/user_icon09.png" />
				<a class="li_div_name">我的朋友圈({$fenshi})</a>
			</div>
	   	</li>
		<li class="border_li" style="border:none;" onclick="LocationUrl('__ROOT__/LMSQ/');">
	        <div class="li_div">
	        	<img src="__IMAGES__/user_icon09.png" />
				<a class="li_div_name">联盟商圈</a>
			</div>
	   	</li>
    </ul>
</div>
<div style="clear: both"></div>