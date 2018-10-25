<if condition="$search['display'] eq 'picture'">
	<volist name="dataList" id="volist">
		<li>
		    <div class="product-div">
		        <a href="{:U('Commodity/show/id/'.$volist['id'])}" class="product-div-link"></a>
		        <img src="__ROOT__/{$volist['picture']}" class="product-list-img">
		        <div class="product-text">
		            <h4>{$volist['title']}</h4>
		            <p class="p-price">
		                <font style="float:left;">¥{$volist['member_price']}</font>
		                <del style="float:right; font-size:14px;">¥{$volist['market_price']}</del>
		            </p>
		        </div>
		    </div>
		</li>
	</volist>
<else />
	<volist name="dataList" id="volist">
		 <li>
		    <div class="product-div">
		        <a href="{:U('Commodity/show/id/'.$volist['id'])}" class="product-div-link"></a>
		        <img src="__ROOT__/{$volist['picture']}" class="product-list-img">
		    </div>
		       <div class="product-text1">
		           <h4>{$volist['title']}</h4>
		           <p class="p-price1">
		               <font style="float:left;">¥{$volist['member_price']}</font>
		               <del style="float:right; font-size:14px;">¥{$volist['market_price']}</del>
		           </p>
		       </div>
		</li>
	</volist>
</if>