<extend name="Base/common" />

{// css样式区 }
<block name="link">
	<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
    <link rel="stylesheet" type="text/css" href="__STYLE__/proDetails.css" />
    <link rel="stylesheet" type="text/css" href="__STYLE__/venobox.css" />
    <style type="text/css">
        *{font-size: 1.3rem;}
    </style>
</block>

<block name="jscript">
    <script type="text/javascript" src="__JS__/jquery.mobile-1.4.5.min.js"></script>
    <script type="text/javascript" src="__JS__/venobox.min.js"></script>
    <script type="text/javascript" src="__JS__/details.page.js"></script>
    <script type="text/javascript" src="__JS__/proDetails.js"></script>
</block>

<block name="main">
	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="{:U('Commodity/show',array('id'=>$theId))}"><i class="iconfont">&#xe636;</i></a>
        <h3>{$columnTitle}</h3>
        <a href="__ROOT__/"><i class="iconfont">&#xe621;</i></a>
    </header>

    <!-- 主题内容 -->
	<div class="main">



            <!-- 图片展示 -->
            <div class="switchPool">
      

                <div class="item estimate show">
                    <ul class="nav">
                        <li <eq name="type" value="all">class="click"</eq> data-id="{$theId}" data-type="all">
                        	<span><i class="iconfont">&#xe6e0;</i></span>
                        	<label>全部</label>
                        </li>
                        <li <eq name="type" value="haopin">class="click"</eq> data-id="{$theId}" data-type="haopin">
                        	<span><i class="iconfont">&#xe6e0;</i></span>
                        	<label>好评</label>
                        </li>
                        <li <eq name="type" value="zhongpin">class="click"</eq> data-id="{$theId}" data-type="zhongpin">
                        	<span><i class="iconfont">&#xe6e0;</i></span>
                        	<label>中评</label>
                        </li>
                        <li <eq name="type" value="chapin">class="click"</eq> data-id="{$theId}" data-type="chapin">
                        	<span><i class="iconfont">&#xe6e0;</i></span>
                        	<label>差评</label>
                        </li>
                        <li <eq name="type" value="youtu">class="click"</eq> data-id="{$theId}" data-type="youtu">
                        	<span><i class="iconfont">&#xe6e0;</i></span>
                        	<label>有图</label>
                        </li>
                    </ul>
                    <div class="switchPond">
                        <ul class="detailItem show">
                        <volist name="dataList" id="volist">
                            <li>
                                <div class="personInfo">
                                    <label>
                                    <if condition="$volist['face'] eq ''">
                                    	<img src="__IMAGES__/get_avatar.png" alt="头像">
                                    <else />
                                    	<img src="__ROOT__/{$volist['face']}" alt="头像">
                                    </if>
                                    </label>
                                    <span class="nickNam">
									<if condition="$volist['wx_name'] neq ''">
										{:json_decode($volist['wx_name'])}
									<elseif condition="$volist['nickname'] neq ''" />
										{$volist['nickname']}
									<else />
										{$volist['username']}
									</if>
									</span>
                                    <em class="time">{$volist['create_time']|date='Y-m-d H:i:s',###}</em>
                                </div>
                                <p class="text">
                                	<span>{$volist['content']}</span>
                                </p>
                                <?php $volist['picture'] = empty($volist['picture']) ? array() : array_merge(explode('|',$volist['picture'])); ?>
								<if condition="$volist['picture']|count gt 0">
									<!--产品相册图片-->
	                                <div class="bed_img">
	                                <volist name="volist['picture']" id="list">
	                                    <img src="__ROOT__/{$list}" />
	                                </volist>
	                                </div>
	
	                                <!--弹出图片-->
	                                <div class="pop_bedimg">
	                                    <div class="bedimg_field">
	                                        <ul>
                                			<volist name="volist['picture']" id="list">
	                                            <li><img src="__ROOT__/{$list}" /></li>
	                                        </volist>
	                                        </ul>
	                                        <!--提示框-->
	                                        <div class="nomore_box"></div>
	                                    </div>
	                                    <!--图片数-->
	                                    <div class="begimg_num"><span class="current">1</span>/<span class="total"></span></div>
	                                </div>
								</if>
                            </li>
                        </volist>
                        </ul>
                    </div>

                </div>
            </div>

            <!-- 没有数据的样式 -->
            
            <if condition="$dataList == false">
				<div class="no-div-message">
					<i class="iconfont icon-biaoqingleiben">&#xe676;</i>
					<p>亲，小编正在整理资料哦～！</p>
				</div>
			</if>
		
	</div>
	
	
</block>