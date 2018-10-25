<extend name="Base/common" />
<block name="main">
	<style>
		#news_word ul{
			width: 91%;
			margin: 0 auto;
		}
		#news_word ul li{
			width: 100%;
			font-size: 1.4rem;
			color: #333;
			margin-top: 3%;
			padding-bottom: 5px;
			border-bottom: 1px solid #dcdada;
		}

	</style>
<body style="background: #fff">
	<section id="news_word">

			<if condition="$notice eq ''">
				<span style="color: #a7a4a4;font-size: 1.2rem;margin-left: 42%;width: 20%">暂无公告</span>
			<else />
				<ul>
				<volist name="notice" id="vo">
					<li><a href="{:U('noticeDetail')}?id={$vo.id}"><?php echo mb_substr($vo['title'],0,18,'utf-8')?></a></li>
				</volist>
				</ul>
			</if>
	</section>
</body>
</block>