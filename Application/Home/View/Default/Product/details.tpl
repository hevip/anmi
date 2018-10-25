<extend name="Base/common" />
<block name="main">
	<style type="text/css">
		.pro_con{
			width: 90%;
			margin: 0 auto;
			min-height: 200px;
		}
		.pro_con h1{
			font-size: 1.1rem;
			color: #333333;
			line-height: 1.6rem;
			text-align: center;
			color: #005aad;
			margin: 1rem 0 1.4rem 0;
		}
		.pro_con a{
			display: block;
			overflow: hidden;
			width: 100%;
			height: 2.6rem;
			line-height: 2.6rem;
			background: #eee;
			color: #666666;
			margin-top: 2rem;
			font-size: 1rem;
			text-align: center;
		}
		p img{
			width: 100%;
			height: auto;
		}
		.pro_con img{
			width: 100%;
			height: auto;
		}
	</style>
<body>
	<div class="pro_con">
		<h1>{$list['title']}</h1>
		<!--<span style="color: #9e9c9c;">{$list['ctime']|date='Y-m-d',###}</span>-->
		<p>{$list['content']}</p>
	</div>
</body>
</block>