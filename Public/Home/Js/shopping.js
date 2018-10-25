function shopping(){
    this.buyNumber = $('.buyNumber'); // 购买商品的数量
    this.buyPrice = $('.buyPrice'); // 购买商品的价格
    this.totalPrice = $('.totalPrice'); // 购物车里单个商品的总价格
    this.shopTotal = $('.ShopTotal'); // 显示加入购物车的总商品数量
    this.cartList = {}; // 商品数组列表(产品id,数量,价格)
    this.shopNum = 0; // 商品总数量
    this.totalMoney = 0; // 商品总价格
}

shopping.prototype.initCart = function(){
    var thisCookie = this.getcookie();
	// alert(thisCookie);
    if (thisCookie != "") {
        var json = JSON.parse(thisCookie);
        this.cartList = json.cartList;
        this.shopNum = json.shopNum;
        this.totalMoney = json.totalMoney;
        this.shopTotal.html(this.shopNum);
    }
}

/**
 * 加入购物车
 * @param numer	theId		产品id
 */
shopping.prototype.addCart = function(theId){
    this.initCart();
    // 购物车当前栏目列表长度
    var tempLength = this.getObjectLength(this.cartList);
    // 获取数量、价格
    num = parseInt(this.buyNumber.val());
    num = num <= 0 ? 1 : num;
    price = parseFloat(this.buyPrice.html());
    // 当前新对象
    var theObj = {
        id: theId,
        num: num,
        price: price,
		check : 1
    };
    // 添加数据列表
    if (tempLength == 0) {
        this.cartList[tempLength] = theObj;
		// this.cartList = { tempLength : theObj };
    }
    else {
        var k = 0;
        for (var i in this.cartList) {
            if (this.cartList[i]['id'] == theId) {
                // 更新总商品个数、价格
                this.shopNum = parseFloat( this.jian( this.shopNum, this.cartList[i]['num'] ) );
                this.totalMoney = parseFloat( this.jian( this.totalMoney, this.cheng( this.cartList[i]['num'], price ) ) );
                // 更新当前商品个数
                this.cartList[i]['num'] = num;
                k += 1;
            }
        }
        if (k == 0) {
            this.cartList[tempLength] = theObj;
        }
    }
    this.shopNum = this.jia( this.shopNum, num );
    this.totalMoney = this.jia( this.totalMoney, this.cheng( num, price ) );
    this.updateCart();
	$('.out_div').toggle();
	
}

// 更新购物车
shopping.prototype.updateCart = function(){
    var tempArray = {
        shopNum: this.shopNum,
        totalMoney: this.totalMoney,
        cartList: this.cartList,
    };
	var jsonString = JSON.stringify(tempArray);
    this.setcookie('ShopCart', jsonString);
    this.shopTotal.html(this.shopNum);
	// 判断如果当前处理登录状态，则直接更新数据库
	this.ajaxUpdate( jsonString, true );
    // alert( this.getcookie() );
    // $('.out_div').slideUp();
}

// ajax更新购物车数据库
shopping.prototype.ajaxUpdate = function( jsonString ) {
	// 是否需要弹窗提醒
	var popup = '';
	if ( arguments[1] ) {
		popup = arguments[1];
	} else {
		popup = false;
	}
	if ( this.is_login() ) {
		var html = '<div class="popupBg" style="display:block;"></div>';
			html += '<div class="popupImg" style="display:block;">';
			html += '<img src="'+jsObj['images']+'/loading3.gif" />';
			html += '<p style="display:block;">数据交互中...</p>';
			html += '</div>';
		$.ajax({
			url : jsObj['root'] + "/Cart/updateCart/rnd/" + Math.random(),
			type : "POST",
			data : {'json' : jsonString},
			dataType : 'text',
			async : true,
			beforeSend : function(){
				$( 'body' ).append( html );
			},
			success : function( data ) {
				$( '.popupBg,.popupImg' ).fadeOut();
				setTimeout( function(){
					$( '.popupBg,.popupImg' ).remove()
					if ( data == "yes" ) {
						document.removeEventListener("touchmove", handler, false);
				        //商品属性
				        var get_text = '';
				        s_get_label = $(".show-goods-attr .s-g-attr-con").find("label.active"); //获取被选中label
				        if(s_get_label.length > 0){
				            s_get_label.each(function() {
				                get_text += $(this).text() + "、";
				            });
				        }
				        //商品数量显示
				        var goods_number = $("#goods_number").val();
				        goods_number = parseInt(goods_number) ? parseInt(goods_number) : 1;
				        get_text = get_text + goods_number + "个";
				        $(".j-goods-attr").find(".t-goods1").text(get_text);
						if($(".j-filter-show-div").hasClass("show")){
							$(".j-filter-show-div").removeClass("show");
							$(".mask-filter-div").removeClass("show");
							return false;
						}
						if($(".j-filter-show-list").hasClass("show")){
							$(".j-filter-show-list").removeClass("show");
							$(".mask-filter-div").removeClass("show");
							return false;
						}
						//if ( popup ) alert( '操作成功!' );
					} else {
						d_messages('操作失败!',2);
					}
				}, 500 );
			}
		});
	} else {
		//if ( popup ) alert( '操作成功!' );
	}
}

// 修改购物车数量
shopping.prototype.editCart = function(theId, num, price, index){
    this.initCart();
    // 临时总商品个数和总价格
    var tempShopNum = num;
    var tempTotalMoney = this.cheng( price, num );
	var globalTotalMoney = 0;
    // 更改购物车的商品属性
    for (var i in this.cartList) {
        if (this.cartList[i]['id'] == theId) {
            this.cartList[i]['num'] = this.jia( this.cartList[i]['num'], num );
            if (price < 0) {
                thePrice = Math.abs(price);
            }
            else {
                thePrice = price;
            }
			var total = this.cheng( this.cartList[i]['num'], thePrice );
            this.totalPrice.eq(index).html( total );
            tempShopNum = num;
            tempTotalMoney = price;
        }
		// 计算选中的商品的总价格
		if ( this.cartList[i]['check'] == 1 ) {
			globalTotalMoney += this.cheng( this.cartList[i]['num'], this.cartList[i]['price'] );
		}
    }
    // 更新总商品个数和总价格
    this.shopNum = this.jia( this.shopNum, tempShopNum );
    this.totalMoney = this.jia( this.totalMoney, tempTotalMoney );
    // 更新购物车
    var tempArray = {
        shopNum: this.shopNum,
        totalMoney: this.totalMoney,
        cartList: this.cartList,
    };
	var jsonString = JSON.stringify(tempArray);
    this.setcookie('ShopCart', jsonString);
	this.ajaxUpdate( jsonString );
    $( ".totalMoney" ).html( globalTotalMoney );
}

// 增加购物车里商品的数量
shopping.prototype.jiaShopNum = function(theId, index){
    var theBuyNumber = this.buyNumber.eq(index);
    var tempVal = parseInt(theBuyNumber.val()) + 1;
    var theBuyPrice = this.buyPrice.eq(index);
    var tempPrice = parseFloat(theBuyPrice.html());
    this.editCart(theId, 1, tempPrice, index);
    //theBuyNumber.val(tempVal);
}

// 减少购物车里商品的数量
shopping.prototype.jianShopNum = function(theId, index){
    var theBuyNumber = this.buyNumber.eq(index);
    var tempVal = parseInt(theBuyNumber.val()) - 1;
    var theBuyPrice = this.buyPrice.eq(index);
    var tempPrice = parseFloat(theBuyPrice.html());
    if (tempVal > 0) {
        this.editCart(theId, -1, -tempPrice, index);
    }
    //theBuyNumber.val(tempVal <= 0 ? 1 : tempVal);
}

// 光标离开放置购物数量（buyNumber）
shopping.prototype.moveoutNum = function(theId, index){
    this.initCart();
    var theBuyNumber = this.buyNumber.eq(index);
    var num = parseInt(theBuyNumber.val());
    var theBuyPrice = this.buyPrice.eq(index);
    var price = parseFloat(theBuyPrice.html());
    theBuyNumber.val(num <= 0 ? 1 : num);
    
    // 临时总商品个数和总价格
    var tempShopNum = num;
    var tempTotalMoney = this.cheng( price, num );
	var globalTotalMoney = 0;
    // 更改购物车的商品属性
    for (var i in this.cartList) {
        if (this.cartList[i]['id'] == theId) {
            // 更新总商品个数、价格
			this.shopNum = this.jian( this.shopNum, this.cartList[i]['num'] );
			this.totalMoney = this.jian( this.totalMoney, this.cheng( this.cartList[i]['num'], price ) );
            // 更新当前商品个数
            this.cartList[i]['num'] = num;
            var total = this.cheng( num, price );
            this.totalPrice.eq(index).html(total);
        }
		// 计算选中的商品的总价格
		if ( this.cartList[i]['check'] == 1 ) {
			globalTotalMoney += this.cheng( this.cartList[i]['num'], this.cartList[i]['price'] );
		}
    }
    // 更新总商品个数和总价格
    this.shopNum = this.jia( this.shopNum, num );
    this.totalMoney = this.jia( this.totalMoney, this.cheng( num, price ) );
    // 更新购物车
    var tempArray = {
        shopNum: this.shopNum,
        totalMoney: this.totalMoney,
        cartList: this.cartList,
    };
	var jsonString = JSON.stringify(tempArray);
    this.setcookie('ShopCart', jsonString);
	this.ajaxUpdate( jsonString );
	$( ".totalMoney" ).html( globalTotalMoney );
}

// 删除购物车产品
shopping.prototype.removeShop = function(theId, index){
    this.initCart();
    for (var i in this.cartList) {
        var tempLength = this.getObjectLength(this.cartList);
        if (this.cartList[i]['id'] == theId) {
            var tempObj = this.cartList[i];
            if (tempLength > 1) {
                delete this.cartList[i];
                $(".cartList").eq(index).slideUp("slow", function(){
                    $(".cartList" + index).remove();
                });
                // 重新排列
                var k = 0;
                var theObj = this.cartList;
                this.cartList = {};
                for (var j in theObj) {
                    this.cartList[k] = theObj[j];
                    k++;
                }
            }
            else {
                delete this.cartList;
                $(".cartList" + index).slideUp("slow", function(){
                    $(".cartList" + index).remove();
                    $(".nullCart").show();
                });
            }
            if (this.getObjectLength(this.cartList) == 0) {
                this.nullCart();
				this.ajaxUpdate( '' );
            }
            else {
                this.shopNum = this.jian( this.shopNum, tempObj['num'] );
                this.totalMoney = this.jia( this.totalMoney, this.cheng( tempObj['num'], -tempObj['price'] ) );
                var tempArray = {
                    shopNum: this.shopNum,
                    totalMoney: this.totalMoney,
                    cartList: this.cartList,
                };
                $('.totalMoney').html(this.totalMoney);
				var jsonString = JSON.stringify(tempArray);
                this.setcookie('ShopCart', jsonString);
				this.ajaxUpdate( jsonString );
            }
            break;
        }
    }
}

// 清空购物车
shopping.prototype.nullCart = function(){
    this.setcookie('ShopCart', '');
    location.href = location.href;
}

/**
 * 设置cookie
 * @param string	name	cookie名称
 * @param string	value	cookie值
 */
shopping.prototype.setcookie = function(name, value){
    var Days = 10;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
    //document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString()+";path=/";
    document.cookie = name + "=" + value + ";expires=" + exp.toGMTString() + ";path=/";
}

// 获取cookie
shopping.prototype.getcookie = function(){
    name = arguments[0] ? arguments[0] : 'ShopCart';
    var theArray = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
    if (theArray != null) {
        return unescape(theArray[2]);
    }
    return '';
}

// 获取对象的长度
shopping.prototype.getObjectLength = function(string){
    var type = typeof string;
    if (type == "string") {
        return string.length;
    }
    else 
        if (type == "object") {
            var count = 0;
            for (var i in string) {
                count++;
            }
            return count;
        }
    return 0;
}

// 判断会员是否登录
shopping.prototype.is_login = function(){
    if (jsObj['is_login'] == 0) {
        // location.href = jsObj['login_url'];
        return false;
    }
    return true;
}

// 选中要下单的产品
shopping.prototype.Is_Selected = function(){
    var checkbox_img = $('.checkbox_img');
    var checkbox_input = $('.checkbox_input');
    var _this = this;
    checkbox_img.click(function(){
        var index = checkbox_img.index(this);
        var ckObj = checkbox_input.eq(index);
        var cartJson = _this.getcookie();
        var cartObj = JSON.parse(cartJson);
        var cartList = cartObj.cartList;
        var totalMoney = parseFloat($('.totalMoney').html());
        var theId = ckObj.val(); 
        if (ckObj.prop('checked') == false) {
            ckObj.prop('checked', true);
            // 统计
            for (var i in cartList) {
                if (cartList[i]['id'] == theId) {
					cartList[i]['check'] = 1; 
					totalMoney = parseFloat( _this.jia( totalMoney, _this.cheng( cartList[i]['num'], cartList[i]['price'] ) ) );
                }
            }
        } else if (ckObj.prop('checked') == true) {
            ckObj.prop('checked', false);
            // 取消统计
            for (var i in cartList) {
                if (cartList[i]['id'] == theId) {
					cartList[i]['check'] = 0;
                    if (totalMoney > 0) {
						totalMoney = parseFloat( _this.jian( totalMoney, _this.cheng( cartList[i]['num'], cartList[i]['price'] ) ) );
                    }
                }
            }
        }
		cartObj.cartList = cartList;
		var jsonString = JSON.stringify(cartObj);
        $('.totalMoney').html(totalMoney);
		_this.setcookie('ShopCart', jsonString);
		_this.ajaxUpdate( jsonString );
    });
}

// 购物车提交订单
shopping.prototype.cart_form = function(formObj){
    var flag = false;
    $(formObj).find(".checkbox_input").each(function(){
        if ($(this).prop('checked') == true) {
            flag = true;
        }
    });
    if (flag) {
        return true;
    }
    else {
    	d_messages('请选择要下订单的商品!!!',2);
        return false;
    }
}


// 除法精确计算
shopping.prototype.chu = function (arg1, arg2){
    var t1 = 0, t2 = 0, r1, r2;
    try {
        t1 = arg1.toString().split(".")[1].length
    } 
    catch (e) {
    }
    try {
        t2 = arg2.toString().split(".")[1].length
    } 
    catch (e) {
    }
    with (Math) {
        r1 = Number(arg1.toString().replace(".", ""))
        r2 = Number(arg2.toString().replace(".", ""))
        return (r1 / r2) * pow(10, t2 - t1);
    }
}

// 乘法精确计算
shopping.prototype.cheng = function (arg1, arg2){
    var m = 0, s1 = arg1, s2 = arg2;
    try {
        m += s1.split(".")[1].length
    } 
    catch (e) {
    }
    try {
        m += s2.split(".")[1].length
    } 
    catch (e) {
    }
    return Number(s1) * Number(s2) / Math.pow(10, m)
}

// 加法精确计算
shopping.prototype.jia = function (arg1, arg2){
    var r1, r2, m;
    try {
        r1 = arg1.toString().split(".")[1].length
    } 
    catch (e) {
        r1 = 0
    }
    try {
        r2 = arg2.toString().split(".")[1].length
    } 
    catch (e) {
        r2 = 0
    }
    m = Math.pow(10, Math.max(r1, r2))
    return (arg1 * m + arg2 * m) / m
}

// 减法精确计算
shopping.prototype.jian = function (arg1, arg2){
    var r1, r2, m, n;
    try {
        r1 = arg1.toString().split(".")[1].length
    } 
    catch (e) {
        r1 = 0
    }
    try {
        r2 = arg2.toString().split(".")[1].length
    } 
    catch (e) {
        r2 = 0
    }
    m = Math.pow(10, Math.max(r1, r2));
    //动态控制精度长度
    n = (r1 >= r2) ? r1 : r2;
    return ((arg1 * m - arg2 * m) / m).toFixed(n);
}

ShopCart = new shopping();
ShopCart.initCart();
ShopCart.Is_Selected();

$(function(){
    /**
     * 商品详情页购物数量增减
     */
    // 数量对象
    var buyNumberObj = $('.buyNumber');
    // 减少数量
    $('.jianBuyNumber').click(function(){
        var theBuyNumber = parseInt(buyNumberObj.val());
        buyNumberObj.val(theBuyNumber - 1 <= 0 ? 1 : theBuyNumber - 1);
    });
    // 增加数量
    $('.jiaBuyNumber').click(function(){
        var theBuyNumber = parseInt(buyNumberObj.val());
        buyNumberObj.val(theBuyNumber + 1);
    });
    // 手动更改数量
    buyNumberObj.blur(function(){
        if (parseInt($(this).val()) <= 0) {
            $(this).val(1);
        }
    });
    
});






















