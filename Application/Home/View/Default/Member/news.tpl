<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>

<block name="jscript">
</block>

<block name="main">
	<include file="Public/top" /> 
	<div class="news">
    	<ul >
    	<if condition="$dataList|count gt 0">
            <volist name="dataList" id="volist">
            <li>
            	<a href="{:U( 'Member/news_show',array('id'=>$volist['id']))}">
                	<div class="news_image">
                    	<img src="__ROOT__/{$volist['picture']}">
                    </div>
                    <div class="news_title">
                    	<h2>{$volist['title']}&nbsp;<if condition="$volist['isshow'] eq 1"><font style="color:red;">最新</font></if></h2>
                        <span>发布时间：{$volist['create_time']||date="Y-m-d H:i",###}</span>
                    </div>
                </a>
            </li>
            </volist>
        <else />
        	<li>
            	暂无更新信息，请继续关注
            </li>
        </if>
        </ul>
	</div>   
</block>