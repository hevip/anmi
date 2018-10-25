<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/jquery.scrollUp.min.js "></script>
	<script type="text/javascript" src="__JS__/article_index.js "></script>
</block>

<block name="main">

<body class="">

	<!-- 回到顶部 -->
	<div class="filter-top" id="scrollUp">
		<i class="iconfont">&#xe623;</i>
	</div>
	
	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>{$columnTitle}</h3>
        <a href="{:U('Index/index')}"><i class="iconfont">&#xe621;</i></a>
    </header>
    
    <!-- 主题内容 -->
	<div class="main">
		<div class="news-list">
		<input class="pid" value="{$_GET['pid']}" type="hidden" />
			<ul id="product_ul">
			<volist name="dataList" id="vo">
				<li>
					<a href="{:U('Article/show',array('id'=>$vo['id']))}">
						<div class="news-row1">
							<span class="news-title">{$vo['title']}</span>
						</div>
						<div class="news-row2">
							<div class="fl view-num">
							<if condition="$vo['recommend']">
								<span class="put-top" style="color:#fff;">置顶</span>
							</if>	
							<!--<i class="iconfont">&#xe658;</i>
								<span>1200</span> -->
							</div>
							<div class="fr time">
								<i class="iconfont">&#xe63a;</i>
								<span>{$vo['create_time']|date="Y/m/d",###}</span>
							</div>
						</div>
					</a>
				</li>
				</volist>
			</ul>
			<div class="nodata" style="text-align:center; font-size:1.2rem; padding:0.5rem 0; color:#888;"></div>
		</div>
	</div>
</block>