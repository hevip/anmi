<extend name="Base/common" />

{// css样式区 }
<block name="link">
<style type="text/css">
	/*排序方式*/

#product_ul1 li {
	display: inline-block;
	background: white;
	    padding:1rem;
}

#product_ul1 li:nth-child(n+2) {
	margin-top: .1rem;
}

#product_ul1 li div {
	
	float: left;
	display: inline-block;
}

#product_ul1 li div:first-child {
	width: 33%;
	padding-left: 0.5rem;
}

#product_ul1 li div:last-child {
	width: 60%;
}
.product-text1  {
	padding-left: 1rem;
}

.product-text1 h4 {
	display: -webkit-box;
	line-height: 2rem;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
	text-overflow: ellipsis;
	overflow: hidden;
	font-size: 1.2rem;
}
.product-text1 p{
	padding: 2.5rem 0;
	font-size: 1.6rem;
	color: #e90327;
	clear: both;
}
.icon-list{
	font-size: 2rem;
	position: relative;
	top:-0.2rem
}

/*end~~~~~~~~排序方式*/
	
</style>
</block>

<block name="jscript">
	<script type="text/javascript" src="__JS__/jquery.scrollUp.min.js "></script>
	
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
    	<!-- 排序 -->
		<section class="product-sequence dis-box">
            <if condition="$search['search'] eq ''">
        	   <a href="{:U('Commodity/clist',array('id'=>$search['id']))}" class="box-flex active">综合</a>
            <else />
                <a href="{:U('Commodity/clist',array('id'=>$search['id']))}" class="box-flex">综合</a>
            </if>

            <if condition="$search['search'] eq 'news'">
        	   <a href="{:U('Commodity/clist'.$search['key'],array('search'=>'news','id'=>$search['id']))}" class="box-flex active">新品</a>
            <else />
                <a href="{:U('Commodity/clist'.$search['key'],array('search'=>'news','id'=>$search['id']))}" class="box-flex">新品</a>
            </if>

            <if condition="$search['search'] eq 'ascsale' || $search['search'] eq 'descsale'">
                <a href="{:U('Commodity/clist'.$search['key'],array('search'=>$search['sale_volume'],'id'=>$search['id']))}" class="box-flex active">销量
                    <if condition="$search['search'] eq 'ascsale'">
                        <i class="iconfont icon-xiajiantou">&#xe622;</i>
                    <else />
                        <i class="iconfont icon-xiajiantou">&#xe625;</i>
                    </if>
                </a>
            <else />
                <a href="{:U('Commodity/clist'.$search['key'],array('search'=>$search['sale_volume'],'id'=>$search['id']))}" class="box-flex">
					销量
                    <i class="iconfont icon-xiajiantou">&#xe625;</i>
                </a>
            </if>

            <if condition="$search['search'] eq 'ascprice' || $search['search'] eq 'descprice'">
        	   <a href="{:U('Commodity/clist'.$search['key'],array('search'=>$search['price'],'id'=>$search['id']))}" class="box-flex active">
					价格
                    <if condition="$search['search'] eq 'ascprice'">
                        <i class="iconfont icon-xiajiantou">&#xe622;</i>
                    <else />
                        <i class="iconfont icon-xiajiantou">&#xe625;</i>
                    </if>
                </a>
            <else />
                <a href="{:U('Commodity/clist'.$search['key'],array('search'=>$search['price'],'id'=>$search['id']))}" class="box-flex">
					价格
                    <i class="iconfont icon-xiajiantou">&#xe625;</i>
                </a>
            </if>
			
			<if condition="$search['display'] eq 'picture'">
	            <a href="{:U('Commodity/clist'.$search['key'],array('display'=>'list','id'=>$search['id']))}" class="box-flex">
	                <i class="iconfont" style="font-size:2rem;">&#xe6fb;</i>
	            </a>
			<else />
	            <a href="{:U('Commodity/clist'.$search['key'],array('id'=>$search['id']))}" class="box-flex">
	                <i class="iconfont" style="font-size:2rem;">&#xe6fe;</i>
	            </a>
			</if>
        </section>
        
        <!-- 商品列表 -->
        <if condition="$search['display'] eq 'picture'">
	        <section class="product-list j-product-list product-list-medium">
		        <input class="id" type="hidden" value="{$_GET['id']}">
		        <input class="search" type="hidden" value="{$_GET['search']}">
		        <input class="display" type="hidden" value="{$search['display']}">
		        <input class="key" type="hidden" value="{$_GET['key']}">
		        <script type="text/javascript" src="__JS__/commodidy_clist.js "></script>
				<div style="width:100%; overflow:hidden;">
					<ul id="product_ul_1">
						<volist name="dataList" id="volist">
							<if condition="$key%2 == 0">
								<li>
									<div class="product-div">
										<a href="{:U('Commodity/show/id/'.$volist['id'])}" class="product-div-link"></a>
										<img src="__ROOT__/{$volist['picture']}" class="product-list-img">
										<div class="product-text">
											<h4>{$volist['title']}</h4>
											<p class="p-price">
												<font style="float:left;">¥{$volist['member_price']}</font>
												<del style="float:right;">¥{$volist['market_price']}</del>
											</p>
										</div>
									</div>
								</li>
							</if>
						</volist>
					</ul>
					
					<ul id="product_ul_2">
						<volist name="dataList" id="volist">
							<if condition="$key%2 == 1">
								<li>
									<div class="product-div">
										<a href="{:U('Commodity/show/id/'.$volist['id'])}" class="product-div-link"></a>
										<img src="__ROOT__/{$volist['picture']}" class="product-list-img">
										<div class="product-text">
											<h4>{$volist['title']}</h4>
											<p class="p-price">
												<font style="float:left;">¥{$volist['member_price']}</font>
												<del style="float:right;">¥{$volist['market_price']}</del>
											</p>
										</div>
									</div>
								</li>
							</if>
						</volist>
					</ul>
				</div>
				
	            <div class="nodata" style="text-align:center; font-size:1.2rem; padding:0.5rem 0; color:#888;"></div>
	        </section>
		<else />
			<section class="product-list1 j-product-list product-list-medium1">
		        <input class="id" type="hidden" value="{$_GET['id']}">
		        <input class="search" type="hidden" value="{$_GET['search']}">
		        <input class="display" type="hidden" value="{$search['display']}">
		        <input class="key" type="hidden" value="{$_GET['key']}">
		        <script type="text/javascript" src="__JS__/commodidy_clist.js "></script>
	            <ul id="product_ul1">
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
	            </ul>
	            <div class="nodata" style="text-align:center; font-size:1.2rem; padding:0.5rem 0; color:#888;"></div>
	        </section>
		</if>
    </div>
    
</block>
