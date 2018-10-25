<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>

<block name="jscript">
</block>

<block name="main">
	<include file="Public/top" />
    
    <div class="main">
    	<!-- 享豆余额 -->
    	<div class="main_row01">
			<div class="row01_top">
				<p style="font-size:1em;">我的余额</p>
                <p style="font-size:3em; color:#ffff00;">69000</p>
			</div>
			<div class="row01_btn">
				<a href="javascript:void(0)" style="background:#398cfd;">查看明细</a>
				<a href="#main_row03" style="background:#52c147;">奖励规则</a>
				<a href="#main_row05" style="background:#ff5959;">兑换礼品</a>
			</div>
		</div>
    	<!-- 享豆奖励 -->
    	<div class="main_row02" id="main_row02">
				<div class="row02_title">
                	<em></em>
					<span>积分奖励</span>
				</div>
                <div class="row02_con">
                	<table>
                    	<tbody>
                        	<tr>
                            	<td class="td_01"></td>
                            	<td class="td_01">成交额</td>
                            	<td class="td_01">订单数</td>
                            	<td class="td_01">享豆</td>  
                            </tr>
                        	<tr>
                            	<td class="td_01">推荐会员</td>
                            	<td class="td_02">{$monthInfo['chuji_price']}</td>
                            	<td class="td_02">{$monthInfo['chuji_order']}</td>
                            	<td class="td_02">{$monthInfo['chuji_jifen']}</td>  
                            </tr>
                        	<tr>
                            	<td class="td_01">分享宣传</td>
                            	<td class="td_02">{$monthInfo['gaoji_price']}</td>
                            	<td class="td_02">{$monthInfo['gaoji_order']}</td>
                            	<td class="td_02">{$monthInfo['gaoji_jifen']}</td>  
                            </tr>
                        	<tr>
                            	<td class="td_01">引荐产品</td>
                            	<td class="td_02">{$monthInfo['product_price']}</td>
                            	<td class="td_02">{$monthInfo['product_order']}</td>
                            	<td class="td_02">{$monthInfo['product_jifen']}</td>  
                            </tr>
                        	<tr>
                            	<td class="td_01">总计</td>
                            	<td class="td_02"><!--{$monthInfo['product_price'] + $monthInfo['gaoji_price'] + $monthInfo['chuji_price']}--></td>
                            	<td class="td_02"><!--{$monthInfo['product_order'] + $monthInfo['gaoji_order'] + $monthInfo['chuji_order']}--></td>
                            	<td class="td_02">{$monthInfo['product_jifen'] + $monthInfo['gaoji_jifen'] + $monthInfo['chuji_jifen']}</td>  
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
    	<!-- 奖励规则 -->
    	<div class="main_row03" id="main_row03">
				<div class="row03_title">
                	<em></em>
					<span>奖励规则</span>
				</div>
                <div class="row03_con">
                	<p class="row03_con_tit">1、“推荐会员”奖励：</p>
                    <p>①我的直接粉丝消费，我将获得1倍享豆奖励；</p>
                    <p>即直接粉丝消费了100元，我得100个享豆。</p>
                    <p>②我的间接粉丝消费，我将获得0.5倍享豆奖励；</p>
                    <p>即间接粉丝消费了100元，我得50个享豆。</p>
                	<p class="row03_con_tit">2、“推荐会员”奖励：</p>
                    <p>①我朋友圈中的任何一个朋友消费，我将获得0.1-0.8倍的享豆奖励。</p>
                    <p>②分享宣传”奖励，将按会员级别从低到高进行分配，奖励总和不超过0.8倍。</p>
                    <p class="row03_con_tit">3、积分奖励表</p>
                    <table>
                    	<tbody>
                        	<tr>
                            	<td class="td_01">会员级别</td>
                            	<td class="td_01">推荐会员</td>
                            	<td class="td_01">分享宣传</td>
                            </tr>
                        	<tr>
                            	<td class="td_01">钻石会员</td>
                            	<td class="td_02">1倍、0.5倍</td>
                            	<td class="td_02">无</td>
                            </tr>
                        	<tr>
                            	<td class="td_01">皇冠会员</td>
                            	<td class="td_02">1倍、0.5倍</td>
                            	<td class="td_02">0.1倍</td>
                            </tr>
                        	<tr>
                            	<td class="td_01">分享牛人</td>
                            	<td class="td_02">1倍、0.5倍</td>
                            	<td class="td_02">0.2倍</td>
                            </tr>
                        	<tr>
                            	<td class="td_01">分享名人</td>
                            	<td class="td_02">1倍、0.5倍</td>
                            	<td class="td_02">0.4倍</td>
                            </tr>
                        	<tr>
                            	<td class="td_01">分享达人</td>
                            	<td class="td_02">1倍、0.5倍</td>
                            	<td class="td_02">0.8倍</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- 会员级别 -->
            <div class="main_row04" id="main_row04">
                <div class="row04_title">
                    <em></em>
                    <span>会员级别</span>
                </div>
                <div class="row04_con">
                	<ul>
                    	<li>
                        	<div class="row04_fl" style="background:#349de1;">VIP</br>会员</div>
                            <div class="row04_fr">
                            	注册即成为VIP会员
                            </div>
                        </li>
                    	<li>
                        	<div class="row04_fl" style="background:#fba714;">钻石</br>会员</div>
                            <div class="row04_fr">
                            	累计消费达到980元
                            </div>
                        </li>
                    	<li>
                        	<div class="row04_fl" style="background:#3ccabc;">皇冠</br>会员</div>
                            <div class="row04_fr">
                            	累计消费达到9800元
                            </div>
                        </li>
                    	<li>
                        	<div class="row04_fl" style="background:#c846f3;">分享</br>牛人</div>
                            <div class="row04_fr">
                            	直接粉丝中钻石与皇冠会员数量达到10人或朋友圈数量达到100人
                            </div>
                        </li>
                    	<li>
                        	<div class="row04_fl" style="background:#74db5b;">分享</br>名人</div>
                            <div class="row04_fr">
                            	直接粉丝中钻石与皇冠会员数量达到50人或朋友圈数量达到500人
                            </div>
                        </li>
                    	<li>
                        	<div class="row04_fl" style="background:#fa5a5a;">分享</br>达人</div>
                            <div class="row04_fr">
                            	直接粉丝中钻石与皇冠会员数量达到100人或朋友圈数量达到1000人
                            </div>
                        </li> 
                    </ul>
                </div>
            </div>
            <!-- 兑换礼品 -->
            <div class="main_row05" id="main_row05">
                <div class="row05_title">
                    <em></em>
                    <span>兑换礼品</span>
                </div>
                <div class="row05_con">
                	<table>
                    	<tbody>
                        	<tr>
                            	<td class="td_01">礼品</td>
                            	<td class="td_01">享豆</td>
                            	<td class="td_01">操作</td>
                            </tr>
                            <tr>
                            	<td class="td_02">罗技（Logitech）无线鼠标</td>
                            	<td class="td_02">6800</td>
                            	<td class="td_02"><a href="#">立即兑换</a></td>
                            </tr>
                            <tr>
                            	<td class="td_02">摩米士（MOMAX）充电宝</td>
                            	<td class="td_02">12800</td>
                            	<td class="td_02"><a href="#">立即兑换</a></td>
                            </tr>
                            <tr>
                            	<td class="td_02">飞利浦（Philips）咖啡机</td>
                            	<td class="td_02">19800</td>
                            	<td class="td_02"><a href="#">立即兑换</a></td>
                            </tr>
                            <tr>
                            	<td class="td_02">九阳（Joyoung）榨汁机</td>
                            	<td class="td_02">30000</td>
                            	<td class="td_02"><a href="#">立即兑换</a></td>
                            </tr>
                            <tr>
                            	<td class="td_02">格兰仕（Galanz）微波炉</td>
                            	<td class="td_02">50000</td>
                            	<td class="td_02"><a href="#">立即兑换</a></td>
                            </tr>
                            <tr>
                            	<td class="td_02">海尔（Haier）洗衣机</td>
                            	<td class="td_02">100000</td>
                            	<td class="td_02"><a href="#">立即兑换</a></td>
                            </tr>
                            <tr>
                            	<td class="td_02">美的（Midea）冰箱</td>
                            	<td class="td_02">180000</td>
                            	<td class="td_02"><a href="#">立即兑换</a></td>
                            </tr>
                            <tr>
                            	<td class="td_02">苹果（Apple）智能手表</td>
                            	<td class="td_02">280000</td>
                            	<td class="td_02"><a href="#">立即兑换</a></td>
                            </tr>
                            <tr>
                            	<td class="td_02">苹果（IPad2）平板电脑</td>
                            	<td class="td_02">480000</td>
                            	<td class="td_02"><a href="#">立即兑换</a></td>
                            </tr>
                            <tr>
                            	<td class="td_02">苹果（IPhone6 Plus）手机</td>
                            	<td class="td_02">680000</td>
                            	<td class="td_02"><a href="#">立即兑换</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</block>