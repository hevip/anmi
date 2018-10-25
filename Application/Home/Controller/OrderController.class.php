<?php
namespace Home\Controller;

/**
 * 订单管理控制器
 *
 * @author BoBo
 *        
 */
class OrderController extends CommController {

	/**
	 * 构造函数
	 */
	public function _initialize() {
		parent::_initialize ();
		$this->checkLogin ();
	}

	/**
	 * 我的订单
	 */
	public function index() {
		// 查询条件
		$condition ['uid'] = $this->member ['id'];
		// 待付款、待制作、制作中
		$type = I ( 'get.type');
		if($type || $type === '0'){
			$condition ['is_pay'] = empty ( $type ) ? 0 : 1;
		}
		$dataList = D ( 'Order' )->getList ( $condition, $type );
		$this->assign ( 'dataList', $dataList );
		$this->assign ( 'columnTitle', $column );
		// 渲染模板
		$this->display ();
	}

	/**
	 * 订单跟踪
	 */
	public function track() {
		$theId = I ( 'get.id', 0 );
		if (is_number ( $theId )) {
			$this->error ( '非法操作' );
		}
		$orderInfoModel = D ( 'OrderInfo' );
		$orderModel = D ( 'Order' );
		// 判断此订单是否存在
		$orderInfo = $orderInfoModel->getOne( $theId, 'id', true, 'id,order_id,pro_id,send_company,send_id' );
		if (empty ( $orderInfo )) {
			$this->error ( '没有此数据' );
		} else { // 判断是否已经付款
			$isPay = $orderModel->getOne( $orderInfo['order_id'], 'order_id', true, 'is_pay' );
			if ( empty( $isPay ) ) {
				$this->error ( '此订单还未付款，没有物流信息' );
			}
		}
		// 获取此订单的所有商品
		$orderInfo['picture'] = D( 'Commodity' )->getOne( $orderInfo['pro_id'], 'id', false, 'picture' );
		// 获取订单商品的物流信息
		$logisticsModel = D ( 'OrderLogistics' );
		$map['order_info_id'] = $theId;
		$map['status'] = 0;
		$map['is_delete'] = 0;
		$logistics = $logisticsModel->getList( $map, "intro,create_time", array( 'begin' => 0, 'num' => 0 ), "create_time desc");
		$this->assign ( 'logistics', $logistics );
		$this->assign ( 'orderInfo', $orderInfo );
		// 栏目名称
		$this->assign ( 'columnTitle', '订单跟踪' );
		// 渲染模板
		$this->display ();
	}

	/**
	 * 订单详情
	 */
	public function show() {
		$id = I ( 'get.id', 0 );
		if (is_number ( $id )) {
			$this->error ( '非法操作' );
		}
		// 读取订单信息
		$order = D ( 'Order' )->where ( array ('id' => $id ) )->find ();
		$orderInfo = D('OrderInfo')->where(array('order_id'=>$order['order_id']))->select();
		foreach($orderInfo as $key=>$val){
			$order['product'][$key] = D('Commodity')->getOne($val['pro_id']);
			$order['product'][$key]['num'] = $val['num'];
			$order['product'][$key]['total_money'] = $val['total_money'];
			
			$order['product'][$key]['freight'] = $val['freight'];
		}
		if (empty ( $order )) {
			$this->error ( '没有此数据' );
		}
		$this->assign ( 'order', $order );
		// 读取收货地址
		$this->assign ( 'address', D ( 'Address' )->getInfo ( $order ['address'] ) );
		// 栏目名称
		$this->assign ( 'columnTitle', '订单详情' );
		// 渲染模板
		$this->display ();
	}

	/**
	 * 添加订单
	 */
	public function add() {
		if (IS_POST) {
			// 获取购物车信息
			$cart = $this->getCart ();
			if (empty ( $cart )) {
				$this->error ( '购物车空空如也~~~~~请勿非法操作!' );
			}
			// 此处先跳过付款，等支付接口
			$return = D ( 'Order' )->order_add ( $cart );
			if ($return ['status']) {
				$this->success ( $return ['info'], U ( 'Order/no' ) );
			} else {
				$this->error ( $return ['info'] );
			}
		} else {
			$this->error ( '非法操作' );
		}
	}

	/**
	 * 删除订单
	 */
	public function remove() {
		$return = array ('status' => 0,'info' => '非法操作!' );
		if (IS_POST && IS_AJAX) {
			$id = I ( 'post.id', 0 );
			$rnd = I ( 'get.rnd', 0 );
			if (! is_number ( $id )) {
				$order = D ( 'Order' )->where ( array ('id' => $id ) )->find ();
				if (! empty ( $order )) {
					$orderInfo = D ( 'OrderInfo' )->where ( array ('order_id' => $order ['order_id'] ) )->delete ();
					$order = D ( 'Order' )->where ( array ('id' => $id ) )->delete ();
					if ($orderInfo && $order) {
						$return ['status'] = 1;
						$return ['info'] = '删除成功!';
					}
				}
			}
		}
		$this->ajaxReturn ( $return );
	}

	/**
	 * 确认收货
	 */
	public function good() {
		$return = array ('status' => 0,'info' => '非法操作!' );
		if (IS_AJAX && IS_POST) {
			$id = I ( 'post.id', 0 );
			$rnd = I ( 'get.rnd', 0 );
			if (! is_number ( $id ) && ! is_number ( $rnd )) {
				$OrderInfoModel = D ( 'OrderInfo' );
				$orderInfo = $OrderInfoModel->where ( array ('id' => $id ) )->find ();
				if (! empty ( $orderInfo )) {
					if ($OrderInfoModel->save ( array ('id' => $id,'is_send' => 2 ) )) {
						// 判断此订单下的所有商品是否都已确认收货，如果全部都确认收货，那么，计算会员提成
						$flag = true;
						$AllCount = $OrderInfoModel->where( array( 'order_id' => $orderInfo['order_id'] ) )->count();
						$TheCount = $OrderInfoModel->where( array( 'order_id' => $orderInfo['order_id'], "is_send" => 2 ) )->count();
						if ( $AllCount == $TheCount ) {
							D('Order')->where( "order_id='{$orderInfo['order_id']}'" )->save( array('is_complete'=>1) );
						}
						$return ['status'] = 1;
						$return ['info'] = '收货成功!';
					}
				}
			}
		}
		$this->ajaxReturn ( $return );
	}

	public function notify() {
		header ( 'Content-type:text/html; charset=utf-8' );
		$orderModel = D ( 'Order' );
		$order_id = I ( 'get.order_id', '' );
		if ($order_id != '') {
			$return = $this->payment ( $order_id );
			if ($return == '付款成功') {
				header ( 'Location:/Member/index/type/1' );
			} else {
				echo '付款失败' . $order_id;
			}
		} else {
			echo '订单编号为空：' . $order_id;
		}
	}

	/**
	 * 会员付款
	 * 1.改变订单的付款状态
	 * 2.添加会员消费记录
	 * 3.如果商品不是官方直销，向推荐人提成(具体详情见开发文档)
	 * 4.会员团队提成(具体详情见开发文档)
	 * 设：利润为$profit，售价为$market，成本为$cost，税为$tax，爱心基金为：$love
	 * $profit = $market * ( 1 - $tax ) - $cost - $love
	 */
	public function payment($order_id) {
		// 获取提成配置
		$config = D ( 'Config' )->where ( array ('id' => 1 ) )->find ();
		$love = $config ['love']; // 爱心基金
		$tax = $config ['tax'] / 100; // 税
		$market = 0; // 售价
		$cost = 0; // 成本
		$profit = 0; // 利润
		$award = 0; // 奖( 利润 * 0.6 )
		$teamBuild = $config ['team_build'] / 100; // 团队建设奖( 奖 * 0.8 )
		$teamManage = $config ['team_manage'] / 100; // 团队管理奖( 奖 * 0.2 )
		$shopRecommend = $config ['recommend'] / 100; // 商品推荐人提成百分比
		$profitPercent = $config ['profit'] / 100; // 利润百分比
		$upgradeConsumer = explode ( "|", $config ['upgrade_consumer'] ); // 会员升级规则
		if ($order_id == '') {return 'order_id为空';}
		// 格式化1~8层百分比
		$begin = explode ( "|", $config ['begin'] );
		for($i = 0, $size = count ( $begin ); $i < $size; $i ++) {
			$begin [$i] = $begin [$i] / 100;
		}
		// 格式化(中、高、特、钻)百分比
		$high = explode ( "|", $config ['high'] );
		for($i = 0, $size = count ( $high ); $i < $size; $i ++) {
			$high [$i] = $high [$i] / 100;
		}
		// 模型
		$orderModel = D ( 'Order' );
		$memberConsumptionModel = D ( 'MemberConsumption' );
		$orderInfoModel = D ( 'orderInfo' );
		$memberProductModel = D ( 'memberProduct' );
		$memberModel = D ( 'Member' );
		$productModel = D ( 'Commodity' );
		// 读取订单信息
		$order = $orderModel->where ( array ('order_id' => $order_id ) )->find ();
		// 会员升级
		$orderModel->upgrade ( $order ['uid'], $order ['price'], $upgradeConsumer );
		// 添加会员消费记录
		$consumption ['uid'] = $order ['uid'];
		$consumption ['order_id'] = $order ['id'];
		$consumption ['create_time'] = time ();
		if ($memberConsumptionModel->insert ( $consumption )) {
			// 获取订单所包含的所有商品，并计算利润，如果商品不是官方直销，向推荐人提成(利润*0.4)
			$orderInfo = $orderInfoModel->getProId ( $order ['order_id'] );
			$tempList = array ();
			for($i = 0, $size = count ( $orderInfo ); $i < $size; $i ++) {
				if (! empty ( $orderInfo [$i] ['uid'] )) {
					$tempProfit = $orderInfo [$i] ['member_price'] * (1 - $tax) - $orderInfo [$i] ['cost_price'] - $love;
					$tempProfit = $tempProfit * $orderInfo [$i] ['num'] * $shopRecommend;
					$tempList [] = array ('uid' => $orderInfo [$i] ['uid'],'pro_id' => $orderInfo [$i] ['id'],'order_id' => $order ['id'],'num' => $orderInfo [$i] ['num'],'price' => $tempProfit,					// 计算提成
					'create_time' => time () );
				}
				// 增加产品销量
				$update ['id'] = $orderInfo [$i] ['id'];
				$update ['hit'] = $orderInfo [$i] ['hit'] + $orderInfo [$i] ['num'];
				$productModel->save ( $update );
				// 计算商品的总销售额和成本
				$market += $orderInfo [$i] ['member_price'] * $orderInfo [$i] ['num'];
				$cost += $orderInfo [$i] ['cost_price'] * $orderInfo [$i] ['num'];
			}
			if (count ( $tempList ) > 0) {
				if (! $memberProductModel->addAll ( $tempList )) {return '会员推荐商品提成添加失败';}
			}
			// 会员团队提成(具体详情见开发文档)
			// 利润
			$profit = $market * (1 - $tax) - $cost - $love;
			// 奖
			$award = $profit * $profitPercent;
			// 团队建设奖
			$teamBuild = $award * $teamBuild;
			// 团队管理奖
			$teamManage = $award * $teamManage;
			// 进行会员提成
			$user = $memberModel->where ( array ('id' => $order ['uid'] ) )->find ();
			// 级别提成标记
			$levelMark = array (2 => 'no',3 => 'no',4 => 'no',5 => 'no' );
			$commArray ['from_id'] = $user ['id'];
			$commArray ['order_id'] = $order ['id'];
			$commArray ['begin'] = $begin;
			$commArray ['high'] = $high;
			$result = $this->commission ( $commArray, $user ['recommended'], $teamBuild, $teamManage, 1, 1, $levelMark );
			return '付款成功';
		} else {
			return '会员消费记录添加失败';
		}
	}

	/**
	 * 会员提成计算
	 *
	 * @param string $recommend 会员推荐码
	 * @param number $teamBuild
	 * @param number $teamManage 团队管理奖
	 * @param number $layer 层数
	 * @param array $level 级别
	 * @param array $levelark 级别提成标记
	 */
	public function commission($commArray, $recommend, $teamBuild, $teamManage, $layer, $level, $levelMark) {
		$memberModel = D ( 'Member' );
		$memberCommission = D ( 'MemberCommission' );
		$thisArray = $memberModel->where ( array ('recommend' => $recommend ) )->find ();
		if (empty ( $thisArray )) {
			return $layer;
		} else {
			if ($layer > 8 && $level >= 5) {return $layer;}
			$tempArray ['from_id'] = $commArray ['from_id'];
			$tempArray ['order_id'] = $commArray ['order_id'];
			$tempArray ['uid'] = $thisArray ['id'];
			$tempArray ['create_time'] = time ();
			// 2层计算（团队建设奖）
			$tempArray ['build_price'] = 0;
			switch ($layer) {
				case 1 :
					$tempArray ['build_price'] = $teamBuild * $commArray ['begin'] [0];
					break;
				case 2 :
					$tempArray ['build_price'] = $teamBuild * $commArray ['begin'] [1];
					break;
			}
			// 团队管理奖
			$tempArray ['manage_price'] = 0;
			if ($thisArray ['level'] > $level && $levelMark [$thisArray ['level']] == "no") {
				switch ($thisArray ['level']) {
					case 2 : // 中级消费商5%
						$tempArray ['manage_price'] = $teamManage * $commArray ['high'] [0];
						$levelMark [$thisArray ['level']] = 'yes';
						break;
					case 3 : // 高级消费商35%
						if ($levelMark [$thisArray ['level'] - 1] == 'yes') {
							$percent = $commArray ['high'] [1] - $commArray ['high'] [0];
						} else {
							$percent = $commArray ['high'] [1];
						}
						$tempArray ['manage_price'] = $teamManage * $percent;
						$levelMark [$thisArray ['level']] = 'yes';
						break;
					case 4 : // 特级消费商60%
						if ($levelMark [$thisArray ['level'] - 1] == 'yes') {
							$percent = $commArray ['high'] [2] - $commArray ['high'] [1];
						} else if ($levelMark [$thisArray ['level'] - 2] == 'yes') {
							$percent = $commArray ['high'] [2] - $commArray ['high'] [0];
						} else {
							$percent = $commArray ['high'] [2];
						}
						$tempArray ['manage_price'] = $teamManage * $percent;
						$levelMark [$thisArray ['level']] = 'yes';
						break;
					case 5 : // 钻石消费商100%
						if ($levelMark [$thisArray ['level'] - 1] == 'yes') {
							$percent = $commArray ['high'] [3] - $commArray ['high'] [2];
						} else if ($levelMark [$thisArray ['level'] - 2] == 'yes') {
							$percent = $commArray ['high'] [3] - $commArray ['high'] [1];
						} else if ($levelMark [$thisArray ['level'] - 3] == 'yes') {
							$percent = $commArray ['high'] [3] - $commArray ['high'] [0];
						} else {
							$percent = $commArray ['high'] [3];
						}
						$tempArray ['manage_price'] = $teamManage * $percent;
						$levelMark [$thisArray ['level']] = 'yes';
						break;
				}
			} // 团队管理奖结束
			  // 执行添加
			if ($layer > 2 && $tempArray ['manage_price'] == 0) {
				// 此条件下没有任何提成产生，不执行添加
				$this->commission ( $commArray, $thisArray ['recommended'], $teamBuild, $teamManage, $layer, $thisArray ['level'], $levelMark );
			} else {
				if ($memberCommission->insert ( $tempArray )) {
					$layer ++;
					$this->commission ( $commArray, $thisArray ['recommended'], $teamBuild, $teamManage, $layer, $thisArray ['level'], $levelMark );
				}
			}
		}
	}

	/**
	 * 订单商品评价
	 */
	public function comments() {
		// 设置查询字段
		$field = "a.price,a.freight,b.pro_id,b.id,b.num";
		$field .= ",c.picture,c.title,c.member_price,c.market_price";
		// 设置查询条件
		$sql = "select $field from db_order as a";
		$sql .= " left join db_order_info as b on b.order_id = a.order_id";
		$sql .= " left join db_commodity as c on c.id = b.pro_id";
		$sql .= " where a.is_delete = 0 and a.uid = {$this->member['id']} and a.is_pay = 1 and a.is_complete = 1 and b.is_send = 2 and b.is_comment = 0";
		// 设置排序条件
		$order .= "a.create_time desc";

		// 读取数据
		$this->dataList = D( 'Order' )->getSQLList( $sql, array( 'begin' => 0, 'num' => 0 ), $order );
		$this->assign( 'dataList', $this->dataList );
		
		// 渲染视图
		$this->display();
	}
	
	/**
	 * 去评论
	 */
	public function toComments() {
		$theId = I ( 'get.id', 0 );
		if (is_number ( $theId )) {
			$this->error ( '非法操作' );
		}
		$orderInfoModel = D ( 'OrderInfo' );
		// 判断此订单是否存在
		$orderInfo = $orderInfoModel->getOne( $theId, 'id', true, 'id,order_id,pro_id' );
		if (empty ( $orderInfo )) {
			$this->error ( '没有此数据' );
		}
		// 获取此订单的所有商品
		$orderInfo['picture'] = D( 'Commodity' )->getOne( $orderInfo['pro_id'], 'id', false, 'picture' );
		$this->assign( 'orderInfo', $orderInfo );
		
		$this->assign ( 'columnTitle', '商品评价' );
		// 渲染视图
		$this->display();
	}
	
}
