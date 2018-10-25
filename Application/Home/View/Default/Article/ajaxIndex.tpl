<volist name="dataList" id="vo">
				<li>
					<a href="{:U('Article/show',array('id'=>$vo['id']))}">
						<div class="news-row1">
							<span class="news-title">{$vo['title']}</span>
						</div>
						<div class="news-row2">
							<div class="fl view-num">
							<if condition="$vo['recommend']">
								<span class="put-top">置顶</span>
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