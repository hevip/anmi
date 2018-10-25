<extend name="Base/common1" />

{// css样式区 }
<block name="link">

<style type="text/css">
	.thumbUp{width: 100%;height: auto;overflow: hidden;margin-top: 1.2rem;}
	.thumbUp .fingerBox{width: 100%;min-height:4rem;overflow: hidden;position: relative;}
	.thumbUp .fingerBox > em{position: absolute;display:block;width: 100%;height: 0;border-bottom: 1px #F3E22B solid;left: 0;top: 50%}
	.thumbUp .fingerBox > span{position: absolute;display: block;width: 5rem;height: 5rem;top:50%;margin-top:-2.5rem;left: 50%;margin-left: -2.5rem;background: #FFF;}
	.thumbUp .fingerBox > span > i{display: block;position:absolute;width: 4rem;height: 4rem;left: 0.5rem;top: 0.5rem;background: #F3E22B;color: #FFF;line-height: 4rem;text-align: center;border-radius: 4rem;overflow: hidden;font-size: 2.5rem;}
	.thumbUp p.statistical{width: 100%;height: 2rem;line-height: 2rem;font-size: 1.2rem;text-align: center;overflow: hidden;margin: 10px 0 0;}
	.thumbUp p.statistical > span{margin: 0 4px;color: #EC5151;}
	.btnop{text-align: center;position: fixed;bottom: 0px;width: 94%;
	 background-color: #FFF;border-top: 1px solid #ccc;left: 0px;padding: 0.2rem 3%;} 	
	.btnop a{width:40%;margin: 10px 5%;border-radius: 5px;float: left;height: 3rem;line-height: 3rem;}
	.btnop a.setlage{background-color:#2577e3;color:#FFF;    font-size: 1.4rem;}
	.btnop a.buyA_{background:#EC5151;overflow: hidden;}
	.btnop a i{vertical-align: middle;color: #FFF;font-size: 1.6rem}
	.btnop a span{vertical-align: middle;color: #FFF;margin-left: 6px;font-size: 1.4rem}
	.backblak{display:none; width:100%;height:100%;background-color:rgba(0,0,0,0.7);position:fixed;top:0px;left:0px;z-index:120;}
	.backblak .import{background-color:#FFF;border-top:1px solid #ededed; z-index:125; height:110px;position:fixed;bottom:0%;left:0px;display:inline-block;width:96%;line-height:90px;padding:0px 2%;}
	.backblak .clocs{width:100%;height:100%;z-index:122;top:0px;left:0px;position:fixed;}
	.backblak .import input{border:1px solid rgba(0,0,0,0.3);line-height:30px; width:64%;padding:0 2%;font-size:0.85em;color:#666;border-radius:3px;margin-top: 30px;}
	.backblak .import a{background-color:#f85f48;line-height:30px;height:30px;float:right;margin-top:30px;font-size:0.75em;color:#FFF;padding:0px 16px;border-radius:3px;}
	.details .revert{background-color:#FFF;width:100%;}
	.details >h4{line-height:5rem;font-size:2rem;margin-top:1rem;background-color:#ededed;color: #f1363f;text-align: center;font-weight: 600;}
	.details .revert .single{width:96%;border-top:1px solid #ededed;padding:6px 2% 0px;}
	.details .revert .single .wb14{width:14%;display:inline-table;text-align:center;float:left;}
	.details .revert .single .wb14 img{width:3rem;height:3rem;border-radius:12px;}
	.details .revert .single .wb86{display:inline-table;width:86%;}
	.details .revert .single .wb86 h5{width:100%;line-height:18px;font-size:0.75em;}
	.details .revert .single .wb86 h5 span{color:#28aef5;margin:0px 4px;}
	.details .revert .single .wb86 p{padding:6px 0px;font-size:0.75em;color:#333;line-height: 18px;}
	.details .revert .single div{width:100%;line-height:30px;height:30px;}
	.details .revert .single div em{font-size:0.75em;color:#999;}
	.details .revert .single div i{font-size:1em;color:#999;float:right;}
	.details .revert .interior{width:100%;}
	.details .revert .interior li{width:86%;border-top:1px solid #ededed;padding:8px 0px 0px 14%;}
	
	/* ajax执行之前动画start */
	.load-container-ajax
	{width: 100%; height: 100%; position: fixed; top: 0; left: 0; z-index: 999; background: rgba(0,0,0,0.5);}
	.load4 .loader 
	{position: absolute; top: 50%; font-size: 10px; margin-top: -0.5em; left: 50%; margin-left: -0.5em;
	width: 1em; height: 1em; border-radius: 50%; -webkit-animation: load4 1.3s infinite linear;
	animation: load4 1.3s infinite linear;}
	@-webkit-keyframes load4 {
	  0%,
	  100% {
	    box-shadow: 0em -3em 0em 0.2em #ffffff, 2em -2em 0 0em #ffffff, 3em 0em 0 -0.5em #ffffff, 2em 2em 0 -0.5em #ffffff, 0em 3em 0 -0.5em #ffffff, -2em 2em 0 -0.5em #ffffff, -3em 0em 0 -0.5em #ffffff, -2em -2em 0 0em #ffffff;
	  }
	  12.5% {
	    box-shadow: 0em -3em 0em 0em #ffffff, 2em -2em 0 0.2em #ffffff, 3em 0em 0 0em #ffffff, 2em 2em 0 -0.5em #ffffff, 0em 3em 0 -0.5em #ffffff, -2em 2em 0 -0.5em #ffffff, -3em 0em 0 -0.5em #ffffff, -2em -2em 0 -0.5em #ffffff;
	  }
	  25% {
	    box-shadow: 0em -3em 0em -0.5em #ffffff, 2em -2em 0 0em #ffffff, 3em 0em 0 0.2em #ffffff, 2em 2em 0 0em #ffffff, 0em 3em 0 -0.5em #ffffff, -2em 2em 0 -0.5em #ffffff, -3em 0em 0 -0.5em #ffffff, -2em -2em 0 -0.5em #ffffff;
	  }
	  37.5% {
	    box-shadow: 0em -3em 0em -0.5em #ffffff, 2em -2em 0 -0.5em #ffffff, 3em 0em 0 0em #ffffff, 2em 2em 0 0.2em #ffffff, 0em 3em 0 0em #ffffff, -2em 2em 0 -0.5em #ffffff, -3em 0em 0 -0.5em #ffffff, -2em -2em 0 -0.5em #ffffff;
	  }
	  50% {
	    box-shadow: 0em -3em 0em -0.5em #ffffff, 2em -2em 0 -0.5em #ffffff, 3em 0em 0 -0.5em #ffffff, 2em 2em 0 0em #ffffff, 0em 3em 0 0.2em #ffffff, -2em 2em 0 0em #ffffff, -3em 0em 0 -0.5em #ffffff, -2em -2em 0 -0.5em #ffffff;
	  }
	  62.5% {
	    box-shadow: 0em -3em 0em -0.5em #ffffff, 2em -2em 0 -0.5em #ffffff, 3em 0em 0 -0.5em #ffffff, 2em 2em 0 -0.5em #ffffff, 0em 3em 0 0em #ffffff, -2em 2em 0 0.2em #ffffff, -3em 0em 0 0em #ffffff, -2em -2em 0 -0.5em #ffffff;
	  }
	  75% {
	    box-shadow: 0em -3em 0em -0.5em #ffffff, 2em -2em 0 -0.5em #ffffff, 3em 0em 0 -0.5em #ffffff, 2em 2em 0 -0.5em #ffffff, 0em 3em 0 -0.5em #ffffff, -2em 2em 0 0em #ffffff, -3em 0em 0 0.2em #ffffff, -2em -2em 0 0em #ffffff;
	  }
	  87.5% {
	    box-shadow: 0em -3em 0em 0em #ffffff, 2em -2em 0 -0.5em #ffffff, 3em 0em 0 -0.5em #ffffff, 2em 2em 0 -0.5em #ffffff, 0em 3em 0 -0.5em #ffffff, -2em 2em 0 0em #ffffff, -3em 0em 0 0em #ffffff, -2em -2em 0 0.2em #ffffff;
	  }
	}
	@keyframes load4 {
	  0%,
	  100% {
	    box-shadow: 0em -3em 0em 0.2em #ffffff, 2em -2em 0 0em #ffffff, 3em 0em 0 -0.5em #ffffff, 2em 2em 0 -0.5em #ffffff, 0em 3em 0 -0.5em #ffffff, -2em 2em 0 -0.5em #ffffff, -3em 0em 0 -0.5em #ffffff, -2em -2em 0 0em #ffffff;
	  }
	  12.5% {
	    box-shadow: 0em -3em 0em 0em #ffffff, 2em -2em 0 0.2em #ffffff, 3em 0em 0 0em #ffffff, 2em 2em 0 -0.5em #ffffff, 0em 3em 0 -0.5em #ffffff, -2em 2em 0 -0.5em #ffffff, -3em 0em 0 -0.5em #ffffff, -2em -2em 0 -0.5em #ffffff;
	  }
	  25% {
	    box-shadow: 0em -3em 0em -0.5em #ffffff, 2em -2em 0 0em #ffffff, 3em 0em 0 0.2em #ffffff, 2em 2em 0 0em #ffffff, 0em 3em 0 -0.5em #ffffff, -2em 2em 0 -0.5em #ffffff, -3em 0em 0 -0.5em #ffffff, -2em -2em 0 -0.5em #ffffff;
	  }
	  37.5% {
	    box-shadow: 0em -3em 0em -0.5em #ffffff, 2em -2em 0 -0.5em #ffffff, 3em 0em 0 0em #ffffff, 2em 2em 0 0.2em #ffffff, 0em 3em 0 0em #ffffff, -2em 2em 0 -0.5em #ffffff, -3em 0em 0 -0.5em #ffffff, -2em -2em 0 -0.5em #ffffff;
	  }
	  50% {
	    box-shadow: 0em -3em 0em -0.5em #ffffff, 2em -2em 0 -0.5em #ffffff, 3em 0em 0 -0.5em #ffffff, 2em 2em 0 0em #ffffff, 0em 3em 0 0.2em #ffffff, -2em 2em 0 0em #ffffff, -3em 0em 0 -0.5em #ffffff, -2em -2em 0 -0.5em #ffffff;
	  }
	  62.5% {
	    box-shadow: 0em -3em 0em -0.5em #ffffff, 2em -2em 0 -0.5em #ffffff, 3em 0em 0 -0.5em #ffffff, 2em 2em 0 -0.5em #ffffff, 0em 3em 0 0em #ffffff, -2em 2em 0 0.2em #ffffff, -3em 0em 0 0em #ffffff, -2em -2em 0 -0.5em #ffffff;
	  }
	  75% {
	    box-shadow: 0em -3em 0em -0.5em #ffffff, 2em -2em 0 -0.5em #ffffff, 3em 0em 0 -0.5em #ffffff, 2em 2em 0 -0.5em #ffffff, 0em 3em 0 -0.5em #ffffff, -2em 2em 0 0em #ffffff, -3em 0em 0 0.2em #ffffff, -2em -2em 0 0em #ffffff;
	  }
	  87.5% {
	    box-shadow: 0em -3em 0em 0em #ffffff, 2em -2em 0 -0.5em #ffffff, 3em 0em 0 -0.5em #ffffff, 2em 2em 0 -0.5em #ffffff, 0em 3em 0 -0.5em #ffffff, -2em 2em 0 0em #ffffff, -3em 0em 0 0em #ffffff, -2em -2em 0 0.2em #ffffff;
	  }
	}
	/* ajax执行之前动画end */
</style>
</block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/jquery.scrollUp.min.js "></script>
	<!--script type="text/javascript" src="__JS__/article_show.js "></script-->
	<script>
	var xmlHttpRequest;
		$( function() {
			var login = jsObj.is_login;
			
			// 点赞
			$( ".goodJob" ).bind('click', function() {	
					if(login < 1){
						d_messages('您还未登陆');
						window.location.href = jsObj.login_url;
					}
					var id = $('.theId').val();
					var $this = $(this);
				//	$.post(jsObj['root']+'/Article/goodjob',{id:id},function(data){alert(6);
				//			d_messages(data.info);
				//			if(data.url){
				//				window.location.href = data.url;
					//		}
					//		$this.removeClass('ing');
				//	});
				
					$.ajax({
					url : jsObj.root+"/Article/goodjob/rnd/" + Math.random(),
					data : {id:id},
					type : 'POST',
					async : true,
					success : function( data ) {
						d_messages(data.info);
						if(data.url){
							window.location.href = data.url;
						}
						if(data.status == 1){
							totalRatting = $('.totalRatting').html();
							 $('.totalRatting').html(totalRatting*1 + 1);
						}
						$this.removeClass('ing');
					},
					error : function (data){
					}
				});
			} );
		} );
	</script>
	<script src="__JS__/article_comment.js"></script>
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
		<div class="news-con">
		
			<div class="news-con-tit">
				<if condition="$dataInfo['recommend']">
					<span class="put-top">置顶</span>
				</if>
				<span class="news-title">您的位置-小桥网 - <a href="{:U('Article/index',array('pid'=>$thisSort['id']))}">{$thisSort['title']}</a></span>
			</div>
			
			<div class="news-con-time">
				<div class="fl view-num">
				<!--<i class="iconfont">&#xe658;</i>
					<span>1200</span> -->
				</div>
				<div class="fl time">
					<i class="iconfont">&#xe63a;</i>
					<span>{$dataInfo['create_time']|date="Y/m/d",###}</span>
				</div>

				<div class="fr">
				<i class="iconfont">&#xe668;</i>
					<span>{$dataInfo['visit']}</span> 
				</div>

			</div>
			<input class="theId" value="{$dataInfo['id']}" type="hidden" />
			<div class="news-con-txt">
				{$dataInfo['content']}
			</div>

			<!-- 后续添加点赞 -->
			<div class="thumbUp">
				<div class="fingerBox goodJob"><em></em><span><i class="iconfont">&#xe6ed;</i></span></div>
				<p class="statistical">已有<span class="totalRatting">{$totalratting}</span>赞 ~</p>
				
			</div>
			<div class="btnop">
				<if condition="$dataInfo['btn_link']">
					<a class="buyA_" href="{$dataInfo['btn_link']}"><i class="iconfont">&#xe6ff;</i><span>购买商品</span></a>
				</if>
				<a class="setlage"><i class="iconfont">&#xe6d2;</i><span>评价</span></a>
			</div>
			<input type="hidden" class="myname" value="{$member['wx_name']?$member['wx_name']:$member['nickname']}"/>
			<if condition="$member['face']">
				<img style="display:none;" class="figureimg" src="__ROOT__/{$member['face']}">
			<else />
				<img style="display:none;" class="figureimg" src="__IMAGES__/head.jpg">
			</if>
			<div class="details">
				<h4>评论展示</h4>
		        <div class="revert">
		            <ul class="outermost">
		            	<volist name="commentList" id="volist">
		            		<li class="single">
			                    <div class="wb14"><img src="__ROOT__/{$volist['face']}"></div>
			                    <div class="wb86">
		                    		<input type="hidden" class="name" value="{$volist['wx_name']?json_decode($volist['wx_name']):$volist['nickname']}">
			                        <h5 class="name"><span>{$volist['wx_name']?json_decode($volist['wx_name']):$volist['nickname']}</span></h5>
			                        <p>{$volist['content']}</p>
			                        <div><em>{$volist['create_time']|date='m-d H:i',###}</em><i class="iconfont" reply_id="{$volist['id']}" theme_id="{$volist['id']}">&#xe61f;</i></div>
			                    </div>
			                    <ul class="interior">
			                    	<volist name="volist['child']" id="child">
				                    	<li>
				                            <div class="wb14"><img src="__ROOT__/{$child['face']}"></div>
				                            <div class="wb86">
				                                <input type="hidden" class="name" value="{$child['wx_name']?json_decode($child['wx_name']):$child['nickname']}">	
				                                <h5 class="name">
				                                	<span>
				                                		{$child['wx_name']?json_decode($child['wx_name']):$child['nickname']}
				                                	</span>回复
				                                	<span>
				                                		{$child['reply_wx_name']?json_decode($child['reply_wx_name']):$child['reply_nickname']}
				                                	</span>
				                                </h5>
				                                <p>{$child['content']}</p>
				                                <div>
				                                	<em>{$child['create_time']|date='m-d H:i',###}</em>
				                                	<i class="iconfont" reply_id="{$child['id']}" theme_id="{$volist['id']}">&#xe61f;</i>
				                                </div>
				                            </div>
				                        </li>
			                        </volist>
			                    </ul>
			                </li>
		            	</volist>
		            
		            	<!--<li class="single">
		                    <div class="wb14"><img src="__IMAGES__/1.png"></div>
		                    <div class="wb86">
		                    	<input type="hidden" class="name" value="浪多多">
		                        <h5 class="name"><span>浪多多1</span></h5>
		                        <p>拼车阔以，便宜嘛，专车就不划算！</p>
		                        <div><em>10-30 19:30</em><i class="iconfont">&#xe61f;</i></div>
		                    </div>
		                    <ul class="interior">
		                    	<li>
		                            <div class="wb14"><img src="__IMAGES__/1.png"></div>
		                            <div class="wb86">
		                                <input type="hidden" class="name" value="刘大大">	
		                                <h5 class="name"><span>刘大大2</span>回复<span>浪多多</span></h5>
		                                <p>拼车阔以，便宜嘛，专车就不划算！</p>
		                                <div><em>10-30 19:30</em><i class="iconfont">&#xe61f;</i></div>
		                            </div>
		                        </li>
		                    	<li>
		                            <div class="wb14"><img src=""></div>
		                            <div class="wb86">
		                                <input type="hidden" class="name" value="刘大大">	
		                                <h5 class="name"><span>刘大大2</span>回复<span>浪多多</span></h5>
		                                <p>拼车阔以，便宜嘛，专车就不划算！</p>
		                                <div><em>10-30 19:30</em><i class="iconfont">&#xe61f;</i></div>
		                            </div>
		                        </li>
		                    </ul>
		                </li>-->
		            </ul>
		        </div>
	        </div>
			<div style="height:5rem;"></div>
			
	        <div class="backblak">
	        	<div class="clocs"></div>
	        	<div class="import">
	        		<input type="text" id="remarktext" placeholder="评价两句" maxlength="200"/>
					<a class="addComments" article_id="{$dataInfo['id']}" reply_id="0" theme_id="0">评论</a>
	        	</div>
	        </div>
			<!--  -->


		</div>
<!--	<a href="{:U('Article/show',array('id'=>$nextPre['prev']['id']))}"><上一页>{$nextPre['prev']['title']}</a><br/>
	<a href="{:U('Article/show',array('id'=>$nextPre['next']['id']))}"><下一页>{$nextPre['next']['title']}</a> -->
	</div>
</block>