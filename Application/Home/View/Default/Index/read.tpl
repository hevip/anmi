<extend name="Base/common" />
<block name="main">
	<style>
		.div_box img{
			width: 100% !important;
			height: auto !important;
		}
		.div_box p span{
			width: auto !important;
		}
	</style>
<body style="background: #fff">
	<section id="news_word">
		<h1>{$articleInfo.title}</h1>
		<h2>发布时间：{$articleInfo.create_time|date='m-d H:i',###}</h2>
		<div class="div_box">
			{$articleInfo.content}
		</div>
	</section>
</body>
</block>