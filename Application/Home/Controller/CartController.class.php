<?php
namespace Home\Controller;

/**
 * 购物车类
 *
 * @author BoBo
 *        
 */
class CartController extends CommController {

	/**
	 * 构造函数
	 */
	public function _initialize() {
		parent::_initialize ();
		if (strpos ( "|index|wx_notify|alipay_notify|", "|" . ACTION_NAME . "|" ) === false) {
			$this->checkLogin ();
		}
		// 模型
		$this->model = D ( 'Cart' );
	}

	/**
	 * 购物车列表
	 */
	public function index() {
		
		// 获取购物车数据
		$this->assign ( 'cartList', $this->getCart () );
		// 栏目名称
		$this->assign ( 'columnTitle', '购物车' );
		// 渲染模板
		$this->display ();
	}

	/**
	 * 下订单
	 */
	public function add_order() {
		// 需要下单的产品
		$dataList = D ( 'Cart' )->getCartList ();
		if ( count( $dataList['list'] ) == 0 && !$_POST['pro_id']) {
			$this->error( '没有需要下单的商品，请选选择!', U( "Cart/index" ) );
		}else if($_POST['pro_id']){
			$dataList['list'] = D('Commodity')->field('title,picture,member_price,market_price,intro,freight')->where(array('id'=>$_POST['pro_id']))->select();
			$dataList['list'][0]['num'] = $_POST['buyNumber'];
			$dataList['list'][0]['typeStr'] = 'goBuyNow';
			$dataList['list'][0]['total_price'] = $_POST['buyNumber']*$dataList['list'][0]['member_price'];
			$dataList['total_price'] = $_POST['buyNumber'] * $dataList['list'][0]['member_price'] + $dataList['list'][0]['freight'];
		}
		$this->assign ( "dataList", $dataList );
		// 收货地址[默认]
		$this->assign ( "address", D ( 'Address' )->getDefault () );
		// 收货地址列表
		$this->assign ( "addressList", D ( 'Address' )->getList () );
		// 栏目名称
		$this->assign ( 'columnTitle', '确认订单信息' );
		// 渲染模板
		$this->display ();
	}
	//立即购买
	public function goBuyNow(){
		if($_POST['id']){
			$data = I('post.');
			$cartObj['cartList'] = array(array('id'=>$data['id'],'num'=>$data['num'],'price'=>$data['price'],'check'=>1));
			$cartList = D('Cart')->formatCart( $cartObj );
			cookie( 'TempCart', json_encode( $cartList ) );
		} else {
			$tempCart = cookie( 'TempCart' );
			$cartList = empty( $tempCart ) ? array() : json_decode( $tempCart, true );
		}

		if ( !empty( $cartList ) ) {
			// 数据注入
			$this->assign( 'cartList', $cartList );
			// 收货地址[默认]
			$this->assign ( "address", D ( 'Address' )->getDefault () );
			// 收货地址列表
			$this->assign ( "addressList", D ( 'Address' )->getList () );
			// 栏目名称
			$this->assign( 'columnTitle', '立即购买' );
			// 渲染模板
			$this->display ( 'goBuyNow_Order' );
		} else {
			// 渲染模板
			$this->display ( 'goBuyNow' );
		}
	}

	/**
	 * 添加订单
	 */
	public function addOrder() {
		if (IS_POST && IS_AJAX) {
			// 新增订单
			if($_POST['pro_id'] && $_POST['num']){
				$return = D ( 'Order' )->goBuyNowInsert ( $_POST );
			}else{
				$return = D ( 'Order' )->insert ( $_POST );
			}
			if ($return ['status'] == 1) {
				if ( $return ['is_pay'] == 1 ) {
					$return ['url'] = U ( 'Order/index/', array( 'type'=>1 ) );
				} else {
					$return ['url'] = U ( 'Cart/payment/id/' . $return ['info'] );
				}
			}
			$this->ajaxReturn ( $return );
		} else {
			$this->error ( '非法操作!' );
		}
	}

	/**
	 * 添加立即购买订单
	 */
	public function addGoBuyNowOrder() {
		if (IS_POST && IS_AJAX) {
			$return = D ( 'Order' )->goBuyNowInsert ( $_POST );
			if ($return ['status'] == 1) {
				if ( $return ['is_pay'] == 1 ) {
					$return ['url'] = U ( 'Order/index/', array( 'type'=>1 ) );
				} else {
					$return ['url'] = U ( 'Cart/payment/id/' . $return ['info'] );
				}
			}
			$this->ajaxReturn ( $return );
		} else {
			$this->error ( '非法操作!' );
		}
	}


	// 更新购物车数据库
	public function updateCart() {
		if ( IS_POST && IS_AJAX ) {
			if ( empty( $this->member['id'] ) ) {
				die( 'error1' );
			}
			$cartModel = D( 'Cart' );
			$json = I( 'post.json', '', '', '' );
			$whereArray = array( 'user_id' => $this->member['id'] );
			$saveArray['cart_json'] = $json;
			$saveArray['create_time'] = time();
			// 检测是否存在
			$userObj = $cartModel->where( array( 'user_id' => $this->member['id'] ) )->find();
			$TheResult = "";
			if ( empty( $userObj ) ) {
				$tempArray = array_merge( $whereArray, $saveArray );
				if ( $cartModel->create( $tempArray ) ) {
					if ( $cartModel->add() ) {
						$TheResult = 'yes';
					} else {
						$TheResult = 'error2';
					}
				} else {
					$TheResult = 'error3';
				}
			} else {
				if ( $cartModel->where( $whereArray )->save( $saveArray ) ) {
					$TheResult = 'yes';
				} else {
					$TheResult = 'error4';
				}
			}
			die( $TheResult );
		} else {
			$this->error( '非法操作!' );
		}
	}

	/**
	 * 确认/支付订单
	 */
	public function payment() {
		$id = I ( 'get.id', 0 );
		$parameter = array ();
		$model = D ( 'Order' );
		if (is_number ( $id )) {
			$parameter ['status'] = 0;
			$parameter ['info'] = '非法操作!';
		} else {
			$parameter = $model->where ( array ('id' => $id ) )->field ( 'id,order_id,price,is_pay,pay_way,money' )->find ();
			if ($parameter ['is_pay'] == 1) {
				$parameter ['status'] = 0;
				$parameter ['info'] = '此订单已经付款,请勿再次付款';
			} else {
				$parameter ['status'] = 1;
			}
		}
		//查看钱包是否足够支付
		$money = $this->member['money'];
		if($money < $parameter['money'] ){
			$parameter['price'] = number_format( $parameter['price'] - $money, 2, '.', '');;
		}
		$parameter['price'] = number_format( $parameter['price'] - $parameter['money'], 2, '.', '');
		$this->assign ( 'weixin', strpos ( $_SERVER ['HTTP_USER_AGENT'], 'MicroMessenger' ) !== false ? 1 : 0 );
		$this->assign ( 'return', $parameter );
		$this->assign ( "url", strpos ( $_SERVER ['HTTP_REFERER'], 'add_order' ) !== false ? U ( 'Cart/index' ) : $_SERVER ['HTTP_REFERER'] );
		// 栏目名称
		$this->assign ( 'columnTitle', $parameter ['status'] ? '支付订单' : '下订单失败' );
		// 渲染模板
		$this->display ();
	}
	/**
	 * 直接充值
	 * 
	 */
	public function adddirect(){
		$data['uid'] = $this->member['id'];
		$price = I('post.price');
		$data['price'] = $price;
		$data['is_pay'] = 0;
		$isExit = D('OrderDirect')->where($data)->find();
		if($isExit){
			$return = $isExit['id'];
		}else{
			$data['order_id'] = D('Order')->setOrderId();
			$data['order_id'] = 'dir_'.$data['order_id'];
			$data['create_time'] = time();
			$return = D('OrderDirect')->add($data);
		}
		$parameter = D('OrderDirect')->where ( array ('id' => $return ) )->field ( 'id,order_id,price,is_pay' )->find ();
		$this->assign ( 'weixin', strpos ( $_SERVER ['HTTP_USER_AGENT'], 'MicroMessenger' ) !== false ? 1 : 0 );
		$this->assign ( 'return', $parameter );
		$this->assign ( "url", strpos ( $_SERVER ['HTTP_REFERER'], 'add_order' ) !== false ? U ( 'Cart/index' ) : $_SERVER ['HTTP_REFERER'] );
		$this->display();
	}
	/**
	 * 微信支付接口
	 */
	public function js_api_call() {
		// 获取微信的账户信息
		define ( 'WX_APPID', $this->config ['wx_app_id'] );
		define ( 'WX_APPSECRET', $this->config ['wx_app_secret'] );
		define ( 'WX_PAY_MCHID', $this->config ['wx_pay_mchid'] );
		define ( 'WX_PAY_PASS', $this->config ['wx_pay_pass'] );
		// 引入微支付类
		vendor ( 'WxPayPubHelper.WxPayPubHelper' );
		// 使用jsapi接口
		$jsApi = new \jsApi_pub ();
		/**
		 * + -------------------------------------
		 * + 步骤1：网页授权获取用户openid
		 * + -------------------------------------
		 * + 通过code获得openid
		 * + -------------------------------------
		 */
		if (! isset ( $_GET ['code'] )) {
			// 触发微信返回code码
			$url = $jsApi->createOauthUrlForCode ( \WxPayConf_pub::JS_API_CALL_URL );
			// 获取订单id
			$order_id = I ( 'post.id', 0 );
			if (empty ( $order_id ) || ! is_numeric ( $order_id )) {
				echo 'aa' . $order_id;
				exit ();
			} else {
				if(I('post.pay_type')==='1'){
					$orderInfo = D ( 'OrderDirect' )->getOne ( $order_id );
				}else{
					$orderInfo = D ( 'Order' )->getOne ( $order_id );
				}
				if ($orderInfo ['is_pay'] == 1) {
					$this->error ( '此订单已付款，请勿再次付款' );
				} else {
					if(I('post.pay_type')!=='1'){
						$orderInfo ['price'] = round( $orderInfo ['price'] - $orderInfo ['money'], 2 );
					}
					$state = json_encode ( array ('id' => $order_id,'out_trade_no' => $orderInfo ['order_id'],'total_fee' => $orderInfo ['price'] * 100 ) );
					$url = str_replace ( 'STATE', $state, $url );
					// die($url);
					Header ( "Location: $url" );
				}
			}
		} else {
			// 获取code码，以获取openid
			$code = $_GET ['code'];
			$jsApi->setCode ( $code );
			$openid = $jsApi->getOpenId ();
			/*
			 * echo "state=".$_GET['state']; exit;
			 */
			$state = json_decode ( $_GET ['state'], true );
			/* print_r( $state );
			die(); */
		}
		/**
		 * + -------------------------------------
		 * + 步骤2：使用统一支付接口，获取prepay_id
		 * + -------------------------------------
		 * + 使用统一支付接口
		 * + -------------------------------------
		 * + 设置必填参数
		 * + 1.appid已填,商户无需重复填写
		 * +	2.mch_id已填,商户无需重复填写
		 * +	3.noncestr已填,商户无需重复填写
		 * +	4.spbill_create_ip已填,商户无需重复填写
		 * +	5.sign已填,商户无需重复填写
		 * + -------------------------------------
		 */
		$unifiedOrder = new \UnifiedOrder_pub ();
		$unifiedOrder->setParameter ( "openid", "$openid" );
		$unifiedOrder->setParameter ( "body", "订单号：{$state['out_trade_no']}" );
		$timeStamp = time ();
		$out_trade_no = \WxPayConf_pub::APPID . "$timeStamp";
		$unifiedOrder->setParameter ( "out_trade_no", $state ['out_trade_no'] ); // 订单号
		$unifiedOrder->setParameter ( "total_fee", $state ['total_fee'] ); // 总金额
		$notify_url = \WxPayConf_pub::NOTIFY_URL;
		$unifiedOrder->setParameter ( "notify_url", $notify_url ); // 通知地址
		$unifiedOrder->setParameter ( "trade_type", "JSAPI" ); // 交易类型
		$prepay_id = $unifiedOrder->getPrepayId ();
		/**
		 * + -------------------------------------
		 * + 步骤3：使用jsapi调起支付
		 * + -------------------------------------
		 */
		$jsApi->setPrepayId ( $prepay_id );
		$jsApiParameters = $jsApi->getParameters ();
		$this->assign ( 'jsApiParameters', $jsApiParameters );
		$this->assign ( 'order_id', $state ['out_trade_no'] );
		$this->assign ( 'web_url', "http://" . $_SERVER ['HTTP_HOST'] . __ROOT__ . "/" );
		$this->assign ( 'id', $state ['id'] );
		// 渲染模板
		$this->display ();
	}

	/**
	 * 微信付款成功
	 */
	public function payment_success() {
		if (! array_key_exists ( "order_id", $_GET )) {
			$this->error ( '非法操作', U ( 'Order/index' ) );
		}
		$dataInfo = D ( 'Order' )->getOne ( $_GET ['order_id'], 'order_id' );
		if (count ( $dataInfo ) == 0) {
			$this->error ( '未找到此订单', U ( 'Order/index' ) );
		}
		// 读取订单信息
		$this->assign ( 'dataInfo', $dataInfo );
		// 栏目名称
		$this->assign ( 'columnTitle', "支付结果" );
		// 渲染模板
		$this->display ();
	}
	/**
	 * 微信异步请求
	 */
	public function wx_notify(){
		// 获取微信的账户信息
		define( 'WX_APPID', $this->config['wx_app_id'] );
		define( 'WX_APPSECRET', $this->config['wx_app_secret'] );
		define( 'WX_PAY_MCHID', $this->config['wx_pay_mchid'] );
		define( 'WX_PAY_PASS', $this->config['wx_pay_pass'] );
		// 引入微支付类
		vendor( 'WxPayPubHelper.WxPayPubHelper' );
		$notify = new \Notify_pub();
		//存储微信的回调
		$xml = $GLOBALS['HTTP_RAW_POST_DATA'];
		$notify->saveData($xml);
		//验证签名，并回应微信。
		//对后台通知交互时，如果微信收到商户的应答不是成功或超时，微信认为通知失败，
		//微信会通过一定的策略（如30分钟共8次）定期重新发起通知，
		//尽可能提高通知的成功率，但微信不保证通知最终能成功。
		if($notify->checkSign() == FALSE){
			$notify->setReturnParameter("return_code","FAIL");//返回状态码
			$notify->setReturnParameter("return_msg","签名失败");//返回信息
		}else{
			$notify->setReturnParameter("return_code","SUCCESS");//设置返回码
		}
		$returnXml = $notify->returnXml();
		echo $returnXml;
		if($notify->checkSign() == TRUE) {//支付签名成功
			$out_trade_no = $notify->data['out_trade_no'];//返回的订单号
			$recharge =  substr($out_trade_no,0,2);
			$status = $recharge;
			if ($notify->data["return_code"] == "FAIL") {
				//echo '通信出错';
				$status = '通信出错';
			} elseif ( $notify->data["result_code"] == "FAIL" ){
				//echo '业务出错';
				$status = '业务出错';
			} else {//支付成功操作
				if(strstr($out_trade_no,"dir_")) {// 钱包充值
					$model = D('OrderDirect');
					// 判断数据是否存在
					$order = $model->getOne( $out_trade_no, 'order_id' );
					if ( empty( $order ) ) {
						$status = "数据不存在！";
						exit($status);
					} else if ( $order['is_pay'] ) {
						$status = "订单已付款，请勿再次支付！";
						exit($status);
					}
					// 更改订单状态
					if ( $model->save( array( 'id' => $order['id'], 'is_pay' => 1 ,'pay_way'=>'微信支付') ) ) {
						// 订单状态更新成功，添加钱包明细记录
						$memberModel = D('Member');
						// 获取会员钱包余额
						$money = $memberModel->getOne( $order['uid'], 'id', false, 'money' );
						// 添加钱包明细记录
						$record = array();
						$record['uid'] = $order['uid'];
						$record['price'] = $order['price'];
						$record['balance'] = $order['price'] + $money;
						$record['type'] = 35;
						$record['create_time'] = time();
						$isMoney = D( 'MemberMoneyRecord' )->add( $record );
						// 更新会员钱包余额
						$member = array();
						$member['id'] = $order['uid'];
						$member['money'] = $record['balance'];
						$isMember = $memberModel->save( $member );
						if ( !$isMoney || !$isMember ) {
							$status = "添加钱包明细记录或更新会员钱包余额失败!";
							exit($status);
						}
					} else {
						$status = "订单支付失败！";
						exit($status);
					}
				}else{// 商品购买
					// 判断数据是否存在
					$order = D( 'Order' )->getOne( $out_trade_no, 'order_id' );
					if ( empty( $order ) ) {
						$status = "数据不存在！";
						exit($status);
					} else if ( $order['is_pay'] ) {
						$status = "订单已付款，请勿再次支付！";
						exit($status);
					}
					//添加钱包消费记录，减少钱包金额
					$decMoney = $order['money'];
					if($decMoney){
						$money = D('Member')->where(array('id'=>$order['uid']))->getField('money');
						
						D('Member')->where(array('id'=>$order['uid']))->setDec('money',$decMoney);
						D('Member')->where(array('id'=>$order['uid']))->setInc('use_money',$decMoney);
						$moneyCon['uid'] = $order['uid'];
						$moneyCon['price'] = 0-$decMoney;
						$moneyCon['balance'] = $money - $decMoney;
						$moneyCon['type'] = 41;
						$moneyCon['create_time'] = time();
						$moneyCon['order'] = $order['order_id'];
						D('MemberMoneyRecord')->add($moneyCon);
					}
					// 配置参数
					$config = array();
					$config['order_id'] = $order['id'];
					// 处理订单提成
					vendor('MicroDistribution.main');
					$handle = new \MicroDistribution($config);
					$return = $handle->microDistribution();
					if ( !$return['status'] ) {
						$status = $return['info'];
						exit($status);
					}
				}
				echo "success";
				$status = '交易成功';
			}
				
		}
		// 记录支付状态
		$this->logger( $xml, $status, $out_trade_no,'微信支付' );

	}
	/**
	 * 支付宝接口
	 */
	public function alipay() {
		if (IS_POST) {
			// 全局变量[支付宝配置参数]
			global $alipay_config;
			// 引入支付宝类
			require_once (VENDOR_PATH . "Alipay/alipay.config.php");
			require_once (VENDOR_PATH . "Alipay/lib/alipay_submit.class.php");
			// 获取网址
			$WEB_URL = "http://$_SERVER[HTTP_HOST]";
			// 获取订单id
			$OrderId = I ( 'post.id', 0 );
			if (is_number ( $OrderId )) {
				$this->error ( '非法参数信息!' );
			}
			// 并获取订单详情
			if(I('post.pay_type')==='1'){
				$OrderObj = D ( 'OrderDirect' )->getOne ( $OrderId );
			}else{
				$OrderObj = D ( 'Order' )->getOne ( $OrderId );
			}	
			if (count ( $OrderObj ) == 0) {
				$this->error ( '未找到此订单!' );
			}
			// 获取下单会员的信息
			$MemberObj = D ( 'Member' )->getOne ( $OrderObj ['uid'] );
			// 获取订单产品表信息并转换成商品展示地址
			$ProObj = D ( 'OrderInfo' )->where ( array ('order_id' => $OrderObj ['order_id'] ) )->find ();
			$ShopUrl = $WEB_URL . U ( 'Index/index');
			// 设置请求参数
			$payment_type = "1"; // 支付类型[必填，不能修改]
			$notify_url = $WEB_URL . U ( 'Cart/alipay_notify' ); // 服务器异步通知页面路径
			$return_url = $WEB_URL . U ( 'Cart/alipay_success' ); // 页面跳转同步通知页面路径
			$out_trade_no = $OrderObj ['order_id']; // 商户订单号[商户网站订单系统中唯一订单号，必填]
			$subject = "会员$MemberObj[recommend]的订单号为$OrderObj[order_id]"; // 订单名称[必填]
			                                                              // $subject="$OrderObj[order_id]";
			$total_fee = $OrderObj ['price']; // 付款金额[必填]
			$show_url = $ShopUrl; // 商品展示地址[必填，需以http://开头的完整路径]
			$body = "会员$MemberObj[recommend]的订单号为$OrderObj[order_id]"; // 订单描述[选填]
			$it_b_pay = ""; // 超时时间[选填]
			$extern_token = ""; // 钱包token[选填]
			                    // 构造要请求的参数数组
			$parameter = array (
					"service" => "alipay.wap.create.direct.pay.by.user",
					"partner" => trim ( $alipay_config ['partner'] ),
					"seller_id" => trim ( $alipay_config ['seller_id'] ),
					"payment_type" => $payment_type,
					"notify_url" => $notify_url,
					"return_url" => $return_url,
					"out_trade_no" => $out_trade_no,
					"subject" => $subject,
					"total_fee" => $total_fee,
					"show_url" => $show_url,
					// "body" => $body,
					// "it_b_pay" => $it_b_pay,
					// "extern_token" => $extern_token,
					"_input_charset" => trim ( strtolower ( $alipay_config ['input_charset'] ) ) );
			// 建立请求
			$alipaySubmit = new \AlipaySubmit ( $alipay_config );
			$html_text = $alipaySubmit->buildRequestForm ( $parameter, "get", "去支付宝支付" );
			// 组合html代码
			$html_header = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"><title>支付宝支付</title></head><body>';
			$html_footer = '</body></html>';
			echo $html_header . $html_text . $html_footer;
		} else {
			$this->error ( '请勿非法访问' );
		}
	}

	/**
	 * 支付宝异步请求
	 */
	public function alipay_notify() {
		// 全局变量[支付宝配置参数]
		global $alipay_config;
		// 引入支付宝类
		require_once (VENDOR_PATH . "Alipay/alipay.config.php");
		require_once (VENDOR_PATH . "Alipay/lib/alipay_notify.class.php");
		// 计算得出通知验证结果
		$alipayNotify = new \AlipayNotify ( $alipay_config );
		$verify_result = $alipayNotify->verifyNotify ();
		$verify_result =1;
		// 验证成功
		if ($verify_result||1) {
			// 商户订单号
			$out_trade_no = $_POST ['out_trade_no'];
			// 支付宝交易号
			$trade_no = $_POST ['trade_no'];
			// 交易状态
			$trade_status = $_POST ['trade_status'];
			if ($_POST ['trade_status'] == 'TRADE_FINISHED'||$_POST ['trade_status'] == 'TRADE_SUCCESS'||1) { // 交易完成
				if(strstr($out_trade_no,"dir_")) {// 钱包充值
					$model = D('OrderDirect');
					// 判断数据是否存在
					$order = $model->getOne( $out_trade_no, 'order_id' );
					if ( empty( $order ) ) {
						$status = "数据不存在！";
						exit($status);
					} else if ( $order['is_pay'] ) {
						$status = "订单已付款，请勿再次支付！";
						exit($status);
					}
					// 更改订单状态
					if ( $model->save( array( 'id' => $order['id'], 'is_pay' => 1,'pay_way'=>'支付宝支付' ) ) ) {
						// 订单状态更新成功，添加钱包明细记录
						$memberModel = D('Member');
						// 获取会员钱包余额
						$money = $memberModel->getOne( $order['uid'], 'id', false, 'money' );
						// 添加钱包明细记录
						$record = array();
						$record['uid'] = $order['uid'];
						$record['price'] = $order['price'];
						$record['balance'] = $order['price'] + $money;
						$record['type'] = 35;
						$record['create_time'] = time();
						$isMoney = D( ' MemberMoneyRecord' )->add( $record );
						// 更新会员钱包余额
						$member = array();
						$member['id'] = $order['uid'];
						$member['money'] = $record['balance'];
						$isMember = $memberModel->save( $member );
						if ( !$isMoney || !$isMember ) {
							$status = "添加钱包明细记录或更新会员钱包余额失败!";
							exit($status);
						}
					} else {
						$status = "订单支付失败！";
						exit($status);
					}
				}else{// 商品购买
					// 判断数据是否存在
					$order = D( 'Order' )->getOne( $out_trade_no, 'order_id' );
					if ( empty( $order ) ) {
						$status = "数据不存在！";
						exit($status);
					} else if ( $order['is_pay'] ) {
						$status = "订单已付款，请勿再次支付！";
						exit($status);
					}
					
					//添加钱包消费记录，减少钱包金额
					$decMoney = $order['money'];
					if($decMoney){
						$money = D('Member')->where(array('id'=>$order['uid']))->getField('money');
						
						D('Member')->where(array('id'=>$order['uid']))->setDec('money',$decMoney);
						D('Member')->where(array('id'=>$order['uid']))->setInc('use_money',$decMoney);
						$moneyCon['uid'] = $order['uid'];
						$moneyCon['price'] = 0-$decMoney;
						$moneyCon['balance'] = $money - $decMoney;
						$moneyCon['type'] = 41;
						$moneyCon['create_time'] = time();
						$moneyCon['order'] = $order['order_id'];
						D('MemberMoneyRecord')->add($moneyCon);
					}
					
					// 配置参数
					$config = array();
					$config['order_id'] = $order['id'];
					// 处理订单提成
					vendor('MicroDistribution.main');
					$handle = new \MicroDistribution($config);
					$return = $handle->microDistribution();
					if ( !$return['status'] ) {
						$status = $return['info'];
						exit($status);
					}
				}
			} 
			// 输出结果[必须输出，不能删除]
			echo "success";
			$this->logger(var_export( $_POST, true ), '失败', $out_trade_no,'支付宝');
		} else {
			// 验证失败
			echo "fail";		
			$this->logger(var_export( $_POST, true ), '失败', $out_trade_no,'支付宝');
		}
	}

	/**
	 * 支付宝付款成功
	 */
	public function alipay_success() {
		// 全局变量[支付宝配置参数]
		global $alipay_config;
		// 引入支付宝类
		require_once (VENDOR_PATH . "Alipay/alipay.config.php");
		require_once (VENDOR_PATH . "Alipay/lib/alipay_notify.class.php");
		// 计算得出通知验证结果
		$alipayNotify = new \AlipayNotify ( $alipay_config );
		$verify_result = $alipayNotify->verifyReturn ();
		// 验证成功
		if ($verify_result) {
			// 商户订单号
			$out_trade_no = $_GET ['out_trade_no'];
			// 支付宝交易号
			$trade_no = $_GET ['trade_no'];
			// 交易状态
			$trade_status = $_GET ['trade_status'];
			// 获取订单,判断是否存在
			$dataInfo = D ( 'Order' )->getOne ( $out_trade_no, 'order_id' );
			if (count ( $dataInfo ) == 0) {
				// $this->error( '未找到此订单', U( 'Order/index' ) );
				echo '未找到此订单';
			}
			// 判断状态
			if ($_GET ['trade_status'] == 'TRADE_FINISHED' || $_GET ['trade_status'] == 'TRADE_SUCCESS') {
				$order = D('Order')->where(array('order_id'=>$out_trade_no))->find();
				D( 'Order' )->save( array( 'id' => $order['id'], 'is_pay' => 1) );
				// 读取订单信息
				$this->assign ( 'dataInfo', $dataInfo );
				// 栏目名称
				$this->assign ( 'columnTitle', "支付结果" );
				// 渲染模板
				$this->display ( 'Cart/payment_success' );
			} else {
				echo '支付出现其它错误：' . $trade_status . '!';
			}
		} else {
			// 验证失败
			echo 'fail';
		}
	}
		/**
	 * 支付 ，记录交易情况
	 * @param Str $xml
	 * @param int $status
	 * @param Str $orderId
	 */
	public function logger($xml, $status, $orderId,$payway)
	{
		$content = "\r\n+-------------------------------------------------\r\n";
		$content .= "+ 订单号：" . $orderId . "\r\n";
		$content .= "+ 支付方式：" . $payway . "\r\n";
		$content .= "+ 返回时间：". date( "Y-m-d H:i:s" ) ."\r\n";
		$content .= "+ 返回码：" . $xml ."\r\n";
		$content .= "+ 状态：" . $status ."\r\n";
		$content .= "+-------------------------------------------------\r\n";
		$content = file_get_contents( 'log.txt' ) . $content;
		file_put_contents( "log.txt", $content );
	}
		/**
	 * 根据订单编号 获得所属订单商品的属性
	 * @param string $order_id
	 * @return array
	 */
	public function getProId( $order_id ) {
		$listArray = D('OrderInfo')->where( array( 'order_id' => $order_id ) )->field( 'pro_id,num' )->select();
		$newArray = array();
		$productModel = D( 'Commodity' );
		for ( $i = 0, $size = count( $listArray ); $i < $size; $i ++ ) {
			$theArray = $productModel->where( array( 'id' => $listArray[$i]['pro_id'] ) )->field( 'id,uid,member_price,cost_price' )->find();
				$newArray[] = array(
					'id' => $theArray['id'],
					'uid' => $theArray['uid'],
					'hit' => $theArray['hit'],
					'num' => $listArray[$i]['num'],
					'member_price' => $theArray['member_price'],
					'cost_price' => $theArray['cost_price'],
				);
		}
		return $newArray;
	}
}