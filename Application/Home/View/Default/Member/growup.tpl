<extend name="Base/common1" />

{// css样式区 }
<block name="link">
    <link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
</block>

<block name="jscript">

    <script type="text/javascript">
        $(function(){
			var group = '{$grownList}';
			var groupList = group.split('|');
			var length = groupList.length;
			//每个进度分得的百分比
			var setbacks = 100/length;
            function coreEdit(core){
            	$.each(groupList,function(i,v){
            		var lastV = i ? groupList[i-1] : 0;//上一个节点
            		//当成长值超过最大等级限制时
            		if(length == i+1 && core >= v){
            			core = parseInt(v);
            		}
            		if(core >= lastV && core <= v){
            			 for(var id=1; id<=i+1; id++){
            			 	$(".progreeBar ul.v_list li:nth-child("+id+")").addClass("light");
            			 	$(".progreeBar > .bar_ > .innerBar > li:nth-child("+id+")").addClass("light");
            			 	if(id == i+1){
            			 		var cur = (core-lastV)/(v-lastV);
            			 		setbacks = setbacks*cur;
            			 		$(".progreeBar > .bar_ > .innerBar > li:nth-child("+id+")").css('width',setbacks+'%');
            			 	}
            			 	
            			 }
            			 for(var ids =length; ids > id; ids--){
            			 	$(".progreeBar > ul.v_list > li:nth-child("+ids+")").removeClass("light");          			 	
                    		$(".progreeBar > .bar_ > .innerBar > li:nth-child("+ids+")").removeClass("light");
            			 }
            			 $(".progreeBar > p.txt > label").html(core);
                    	 $(".progreeBar > p.txt > span").html( parseFloat(v-core).toFixed(1) );
            		}
            	});           	            
            }
            var thisCore = {$data.grown};
            coreEdit(thisCore);

        });
    </script>

</block>

<block name="main">
    <!-- 头部 -->
    <header class="header-menu dis-box">
        <a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>{$columnTitle}</h3>
        <a href="__ROOT__/"><i class="iconfont">&#xe621;</i></a>
    </header>
    <!-- 主题内容 -->
    <div class="main">
        <!-- 基本信息 -->
        <section class="growth-head">
            <div class="tu">
            	<if condition="$member['face'] eq ''">
					<img src="__IMAGES__/head.jpg">
				<else />
					<img src="__ROOT__/{$data['face']}">
				</if>
            </div>
            <h3>
                <if condition="$data['wx_name'] neq ''">{$data.wx_name}<elseif condition="$data['nickname'] neq ''"/>{$data.nickname}<else/>{$data.username}</if>
            </h3>
            <p>
                <span>成长值：{$data.grown}</span><span>|</span>
                <span>等级：<font>
                        {$data.levelStr}
                    </font></span>
            </p>
        </section>

        <!-- 成长进度 -->
        <section class="growth-speed">
            <div class="growth-speed-tit">
                <span>我的会员</span>
                <a href="{:U('Member/grow_show')}"><span>会员攻略</span><i class="iconfont">&#xe664;</i></a>
            </div>

           <div class="progreeBar clearfix">
                <ul class="txtList">
                    <li>独木桥</li><li>石板桥</li><li>得心应手</li><li>能工巧匠</li><li>建造大师</li><li>现代鲁班</li>
                </ul>
                <div class="bar_"><ul class="innerBar"><li></li><li></li><li></li><li></li><li></li></ul></div>
                <ul class="v_list">
                    <li class="iconfont light">&#xe6f9;</li>
                    <li class="iconfont">&#xe6f3;</li>
                    <li class="iconfont">&#xe6f4;</li>
                    <li class="iconfont">&#xe6f5;</li>
                    <li class="iconfont">&#xe6f6;</li>
                    <li class="iconfont">&#xe6f7;</li>
                </ul>
                <p class="txt">当前成长值为<label></label>，据下一等级还需<span></span>成长值</p>
            </div>

        </section>

        <!-- 成长记录 -->
        <section class="growth-record user-wallet-detail">
            <div class="growth-record-tit">成长记录</div>
            <if condition="$record neq ''">
	            <ul class="growth-record-list">
	                <foreach name="record" item="v">
	                <li>
	                    <div class="wallet-detail-div">
	                        <h3 class="fl detail-title">
	                        <if condition="$v.order_id eq 0">
                        		{$v.type_name}
                        	<else />
                        		订单{$v.order_name}
                        	</if>
	                        </h3>
	                        <span class="fr detail-money green">+{$v.upgrade}<small>成长值</small></span>
	                    </div>
	                    <div class="wallet-detail-div">
	                        <span class="fl detail-way">{$v['create_time']|date="Y-m-d H:i",###}</span>
	                        <span class="fr detail-time">
	                            {$v.type_name}
	                        </span>
	                    </div>
	                </li>
	                </foreach>
	            </ul>
            <else/>
	            <div class="no-div-message">
	                <i class="iconfont icon-biaoqingleiben">&#xe676;</i>
	                <p>亲，什么都没有哦～！</p>
	            </div>
            </if>
        </section>
    </div>
</block>





