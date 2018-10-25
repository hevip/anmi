<volist name="dataList" id="vo">
	<a class="select-title padding-all  j-menu-select">
		<label class="fl">{$vo['city']}</label>
		<span class="fr t-jiantou j-t-jiantou" id="j-t-jiantou">
			<i class="iconfont ts-2">&#xe664;</i>
		</span>
	</a>
	<ul class="padding-all j-sub-menu" style="display:none;">
	<volist name="vo.son" id="v">
		<li class="ect-select">
			<label data-id="{$v['id']}" class="ts-1">{$v['area']}<i class="fr iconfont icon-gou ts-1"></i></label>
		</li>
	</volist>
	</ul>
</volist>
