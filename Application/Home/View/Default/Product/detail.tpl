<extend name="Base/common" />
<block name="main">
	<script type="text/javascript">
		document.addEventListener('plusready', function(){
			//console.log("所有plus api都应该在此事件发生后调用，否则会出现plus is undefined。"
		});
	</script>

<body>
	<div class="Indx_tit">
		<h1  style="font-size: 1.4rem">产品展示</h1>
		<p>Product Show</p>
	</div>
	<section id="Pro_Show" class="jq22">
		<if condition="$list eq ''">
			<span style="color: #b6b6b6; margin-left: 43%;">暂无数据</span>
		<else />
			<ul class="hidden">
					<volist name="list" id="vo">
						<li>
							<a href="{:U('details')}?id={$vo.id}">
								<img src="__ROOT__/{$vo.picture}"/>
								<h1 class="aui-ellipsis-1" style="font-size: 1.2rem">{$vo.title}</h1>
								<p class="aui-ellipsis-2">{$vo.intro}</p>
								<span>更多 <b class="aui-iconfont aui-icon-right"></b></span>
							</a>
						</li>
					</volist>
			</ul>
			<ul class="list">数据加载中，请稍后...</ul>
			<div class="more_pub" style="text-align: center;">
				<a href="javascript:;" onClick="jq22.loadMore();" style="color:#7b7777">查看更多>></a>
			</div>
		</if>
	</section>
</body>
	<script>
		var _content = []; //临时存储li循环内容
		var jq22 = {
			_default:8, //默认显示图片个数
			_loading:6,  //每次点击按钮后加载的个数
			init:function(){
				var lis = $(".jq22 .hidden li");
				$(".jq22 ul.list").html("");
				for(var n=0;n<jq22._default;n++){
					lis.eq(n).appendTo(".jq22 ul.list");
				}
				lis.each(function(){
					$(this).attr('src',$(this).attr('realSrc'));
				})
				for(var i=jq22._default;i<lis.length;i++){
					_content.push(lis.eq(i));
				}
				$(".jq22 .hidden").html("");
			},
			loadMore:function(){
				var lis = $(".jq22 .hidden li");
				var mLis = lis.length;
				for(var i =0;i<jq22._loading;i++){
					var target = _content.shift();
					if(!target){
						$('.jq22 .more_pub').html("<p style='text-align: center;font-size: 0.9rem;color:#7b7777'>全部加载完毕...</p>");
						break;
					}
					$(".jq22 ul.list").append(target);
					lis.eq(mLis+i).each(function(){
						$(this).attr('src',$(this).attr('realSrc'));
					});
				}
			}
		}
		jq22.init();
	</script>
</block>