<?php
namespace Admin\Controller;

/**
 * 订单管理控制器
 *
 * @author BoBo
 *        
 */
class OrderController extends CommController {

	public function _initialize() {
		parent::_initialize ();
		// 模型
		$this->model = D ( 'Order' );
	}

	/**
	 * 商品订单数据列表
	 */
	public function index() {
		// 获取参数
		$this->paramter ['pay_way'] = I ( 'post.pay_way', '' ); // 付款方式
		$this->paramter ['is_pay'] = I ( 'post.is_pay', '' ); // 订单状态
		$this->paramter ['order_id'] = I ( 'post.order_id', '' ); // 订单号
		$this->paramter ['start_time'] = I ( 'post.start_time', '' ); // 开始时间
		$this->paramter ['end_time'] = I ( 'post.end_time', '' ); // 结束时间
		// 设置查询条件
		$field = "a.id,a.create_time,a.order_id,a.price,a.pay_way,a.custom_price,a.is_pay";
		$field .= ",b.username as member_username,b.wx_name,b.nickname,b.referral_code";
		$sql = "select $field from db_order as a";
		$sql .= " left join db_member as b on a.uid = b.id";
		$sql .= " where 1=1 and a.is_delete = 0 and a.type = 0";
		// 付款方式
		if ( ! empty ( $this->paramter ['pay_way'] ) ) {
			$sql .= " and a.pay_way = '{$this->paramter['pay_way']}'";
		}
		// 付款方式
		if ( ! empty ( $this->paramter ['is_pay'] ) ) {
			$sql .= " and a.pay_way = '{$this->paramter['pay_way']}'";
		}
		// 订单号
		if ( ! empty ( $this->paramter ['order_id'] ) ) {
			$sql .= " and a.order_id like '%{$this->paramter['order_id']}%'";
		}
		// 日期范围
		if ( ! empty ( $this->paramter ['start_time'] ) && ! empty ( $this->paramter ['end_time'] ) ) {
			$start_time = strtotime ( $this->paramter ['start_time'] );
			$end_time = strtotime ( '+1 day', strtotime( $this->paramter ['end_time'] ) ) - 1;
			$sql .= " and a.create_time between $start_time and $end_time";
		} else if ( ! empty ( $this->paramter ['start_time'] ) ) {
			$start_time = strtotime ( $this->paramter ['start_time'] );
			$end_time = strtotime ( '+1 day', strtotime( $this->paramter ['start_time'] ) ) - 1;
			$sql .= " and a.create_time between $start_time and $end_time";
		} else if ( ! empty ( $this->paramter ['end_time'] ) ) {
			$start_time = strtotime ( $this->paramter ['end_time'] );
			$end_time = strtotime ( '+1 day', strtotime( $this->paramter ['end_time'] ) ) - 1;
			$sql .= " and a.create_time between $start_time and $end_time";
		}
		// 读取数据
		$this->dataList = $this->model->getSQLList ( $sql, array ( 'begin' => 0, 'num' => 0 ), "a.create_time desc" );
		$this->setDataList ();
		// 注入数据
		$this->assign ( "dataList", $this->dataList );
		$this->assign ( 'paramter', $this->paramter );
		// 渲染模板
		$this->display ();
	}
	/**
	 * 导出订单信息
	 */
	public function indexexcel(){
		$xlsName = '订单统计统计';//表头
		$xlsCell  = array(
				array('create_time','下单时间'),
				array('order_id','订单号'),
				array('pro_title','商品信息'),
				array('price','小计'),
				array('member_username','会员ID'),
				array('wx_name','微信名'),
				array('nickname','真实姓名'),
				array('referral_code','幸运号'),
				array('pay_way','支付方式'),
				array('is_send','订单状态'),
		);
		$model = $this->model;
		$map['is_delete'] = 0;
		$field = "a.id,a.create_time,a.order_id,a.price,a.pay_way,a.custom_price,a.is_pay";
		$field .= ",b.username as member_username,b.wx_name,b.nickname,b.referral_code";
		$sql = "select $field from db_order as a";
		$sql .= " left join db_member as b on a.uid = b.id";
		$sql .= " where 1=1 and a.is_delete = 0 and a.type = 0 order by a.create_time desc";
		$this->dataList = $this->model->query($sql);
		$this->setDataList ();
		$xlsData = array();
		foreach ($this->dataList as $key=>$val){
			$xlsData[$key]['create_time'] = date("Y-m-d H:i:s",$val['create_time']);
			$xlsData[$key]['order_id'] = $val['order_id'];
			$str = '';
			foreach($val['list'] as $k=>$v){
				$str = $v['pro_title'].'&nbsp;&nbsp;'.$v['pro_price'].'&nbsp;&nbsp;x'.$v['pro_num'];
			}
			$xlsData[$key]['pro_title'] = $str;
			$xlsData[$key]['price'] = $val['custom_price']>0 ? $val['custom_price'] : $val['price'] ;
			$xlsData[$key]['member_username'] = $val['member_username'];
			$xlsData[$key]['wx_name'] = json_decode($val['wx_name']);
			$xlsData[$key]['nickname'] = $val['nickname'];
			$xlsData[$key]['referral_code'] = $val['referral_code'];
			$payStr = $val['is_pay'] ? '已支付' : ($val['is_send'] ? ($val['is_send']== 1 ? '待发货' : ($val['is_send']== 2 ? '已发货' :'已收货')) :'未发货');
			$xlsData[$key]['is_send'] = $val['is_pay'] ? '已支付' : '未支付';
			$xlsData[$key]['pay_way'] = $payStr;
		}
		$xlsWidth = array(45,40,30,15,20,20,20,20,20);
		exportExcel($xlsName,$xlsCell,$xlsData,$xlsWidth);
	}
	/**
	 * 个性订单数据列表
	 */
	public function personality() {
		// 获取参数
		$this->paramter ['pay_way'] = I ( 'post.pay_way', '' ); // 付款方式
		$this->paramter ['is_pay'] = I ( 'post.is_pay', '' ); // 订单状态
		$this->paramter ['order_id'] = I ( 'post.order_id', '' ); // 订单号
		$this->paramter ['start_time'] = I ( 'post.start_time', '' ); // 开始时间
		$this->paramter ['end_time'] = I ( 'post.end_time', '' ); // 结束时间
		// 设置查询条件
		$field = "a.id,a.create_time,a.order_id,a.price,a.pay_way,a.custom_price,a.is_pay";
		$field .= ",b.username as member_username,b.wx_name,b.nickname,b.referral_code";
		$sql = "select $field from db_order as a";
		$sql .= " left join db_member as b on a.uid = b.id";
		$sql .= " where 1=1 and a.is_delete = 0 and a.type = 1";
		// 付款方式
		if ( ! empty ( $this->paramter ['pay_way'] ) ) {
			$sql .= " and a.pay_way = '{$this->paramter['pay_way']}'";
		}
		// 付款方式
		if ( ! empty ( $this->paramter ['is_pay'] ) ) {
			$sql .= " and a.pay_way = '{$this->paramter['pay_way']}'";
		}
		// 订单号
		if ( ! empty ( $this->paramter ['order_id'] ) ) {
			$sql .= " and a.order_id like '%{$this->paramter['order_id']}%'";
		}
		// 日期范围
		if ( ! empty ( $this->paramter ['start_time'] ) && ! empty ( $this->paramter ['end_time'] ) ) {
			$start_time = strtotime ( $this->paramter ['start_time'] );
			$end_time = strtotime ( '+1 day', strtotime( $this->paramter ['end_time'] ) ) - 1;
			$sql .= " and a.create_time between $start_time and $end_time";
		} else if ( ! empty ( $this->paramter ['start_time'] ) ) {
			$start_time = strtotime ( $this->paramter ['start_time'] );
			$end_time = strtotime ( '+1 day', strtotime( $this->paramter ['start_time'] ) ) - 1;
			$sql .= " and a.create_time between $start_time and $end_time";
		} else if ( ! empty ( $this->paramter ['end_time'] ) ) {
			$start_time = strtotime ( $this->paramter ['end_time'] );
			$end_time = strtotime ( '+1 day', strtotime( $this->paramter ['end_time'] ) ) - 1;
			$sql .= " and a.create_time between $start_time and $end_time";
		}
		// 读取数据
		$this->dataList = $this->model->getSQLList ( $sql, array ( 'begin' => 0, 'num' => 0 ), "a.create_time desc" );
		// 注入数据
		$this->assign ( "dataList", $this->dataList );
		$this->assign ( 'paramter', $this->paramter );
		// 渲染模板
		$this->display ();
	}
	/**
	 * 导出订单信息
	 */
	public function personalityexcel(){
		$xlsName = '订单统计统计';//表头
		$xlsCell  = array(
				array('create_time','下单时间'),
				array('order_id','订单号'),
				array('pro_title','商品信息'),
				array('price','小计'),
				array('member_username','会员ID'),
				array('wx_name','微信名'),
				array('nickname','真实姓名'),
				array('referral_code','幸运号'),
				array('pay_way','支付方式'),
				array('is_send','订单状态'),
		);
		$model = $this->model;
		$map['is_delete'] = 0;
		$field = "a.id,a.create_time,a.order_id,a.price,a.pay_way,a.custom_price,a.is_pay";
		$field .= ",b.username as member_username,b.wx_name,b.nickname,b.referral_code";
		$sql = "select $field from db_order as a";
		$sql .= " left join db_member as b on a.uid = b.id";
		$sql .= " where 1=1 and a.is_delete = 0 and a.type = 1 order by a.create_time desc";
		$this->dataList = $this->model->query($sql);
		$this->setDataList ();
		$xlsData = array();
		foreach ($this->dataList as $key=>$val){
			$xlsData[$key]['create_time'] = date("Y-m-d H:i:s",$val['create_time']);
			$xlsData[$key]['order_id'] = $val['order_id'];
			$xlsData[$key]['pro_title'] = '自定义商品';
			$xlsData[$key]['price'] = $val['custom_price']>0 ? $val['custom_price'] : $val['price'] ;
			$xlsData[$key]['member_username'] = $val['member_username'];
			$xlsData[$key]['wx_name'] = json_decode($val['wx_name']);
			$xlsData[$key]['nickname'] = $val['nickname'];
			$xlsData[$key]['referral_code'] = $val['referral_code'];
			$payStr = $val['is_pay'] ? '已支付' : ($val['is_send'] ? ($val['is_send']== 1 ? '待发货' : ($val['is_send']== 2 ? '已发货' :'已收货')) :'未发货');
			$xlsData[$key]['is_send'] = $val['is_pay'] ? '已支付' : '未支付';
			$xlsData[$key]['pay_way'] = $payStr;
		}
		$xlsWidth = array(45,40,30,15,20,20,20,20,20);
		exportExcel($xlsName,$xlsCell,$xlsData,$xlsWidth);
	}
	/**
	 * 设置数据列表
	 */
	private function setDataList() {
		$OrderInfo = D ( 'OrderInfo' );
		for ( $i = 0 , $size = count ( $this->dataList ); $i < $size; $i ++ ) {
			$rows = $this->dataList [$i];
			$field = "a.num as pro_num,a.is_send";
			$field .= ",b.title as pro_title,b.member_price as pro_price";
			$sql = "select $field from db_order_info as a";
			$sql .= " left join db_commodity as b on a.pro_id = b.id";
			$sql .= " where 1=1 and order_id = '{$rows[order_id]}'";
			$tempList = $OrderInfo->getSQLList ( $sql, array ( 'begin' => 0, 'num' => 0 ), 'a.id desc' );
			foreach ( $tempList as $theRows ) {
				if ( $theRows['is_send'] == 0 ) {
					$this->dataList [$i] ['is_send'] = 1;
					break;
				} else if ( $theRows['is_send'] == 1 ) {
					$this->dataList [$i] ['is_send'] = 2;
				} else if ( $theRows['is_send'] == 2 ) {
					$this->dataList [$i] ['is_send'] = 3;
				}
			}
			$this->dataList [$i] ['list'] = $tempList;
		}
	}

	/**
	 * 修改订单价格
	 */
	public function price_edit() {
		$theId = I ( 'request.id', 0 );
		if ( is_number ( $theId ) ) {
			die ( '参数错误：id' );
		}
		$tag = I ( 'get.tag', '' );
		if ( $tag == 'update' && IS_AJAX && IS_POST ) {
			$this->HuiMsg ( $this->model->price_edit ( $_POST ) );
		} else {
			$this->assign ( 'dataInfo', $this->model->getOne ( $theId ) );
			// 渲染模板
			$this->display ();
		}
	}

	/**
	 * 确认付款
	 * TODO 还有会员提成、升级等功能未开发
	 */
	/* public function confirmPay() {
		if ( IS_AJAX && IS_POST ) {
			//会员提成
			$id = I('post.id');
			global $config;
			require_once(VENDOR_PATH.'MicroDistribution/config.php');
			$order = D('Order')->where(array('id'=>$id))->find();
			$config['price'] = $order['price'];
			$config['mid'] = $order['uid'];
			$config['order_id'] = $order['order_id'];
			$config['reward_type'] = 25;
			//根据订单计算出利润
			$orderInfo = $this->getProId( $order['order_id'] );
			$profit = 0;
			foreach ($orderInfo as $val){
				$profit += $val['member_price']- $val['cost_price'];
			}
			//当没有商品时，就没有利润，无利润直接按照总价格计算
			$config['profit'] = $profit==0 ? $config['price'] : $profit;
			vendor('MicroDistribution.main');
			$alipaySubmit = new \MicroDistribution($config);
			$alipaySubmit->microDistribution();
			
			$this->HuiMsg ( $this->model->confirmPay ( $_POST ) );
		} else {
			$this->HuiMsg ( returnMsg () );
		}
	} */
	
	/**
	 * 确认付款
	 */
	public function confirmPay() {
		if ( IS_AJAX && IS_POST ) {
			// 获取参数
			$id = I( 'post.id', 0 );
			$return = returnMsg();
			// 判断参数
			if ( is_number( $id ) ) {
				$return['info'] = "参数id错误！";
				$this->HuiMsg( $return );
			}
			// 判断数据是否存在
			$order = $this->model->getOne( $id, 'id', true, "*" );
			if ( empty( $order ) ) {
				$return['info'] = "数据不存在！";
				$this->HuiMsg( $return );
			} else if ( $order['is_pay'] ) {
				$return['info'] = "订单已付款，请勿再次支付！";
				$this->HuiMsg( $return );
			}
			// 配置参数
			$config = array();
			$config['order_id'] = $id;
			// 处理订单提成
			vendor('MicroDistribution.main');
			$handle = new \MicroDistribution($config);
			$return = $handle->microDistribution();
			$this->HuiMsg( $return );
		} else {
			$this->HuiMsg ( returnMsg () );
		}
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
	/**
	 * 获取订单信息表的所有id
	 */
	public function getOrderInfoIdList() {
		if ( IS_AJAX && IS_POST ) {
			$order_id = $this->model->getOne( I( 'post.id', 0 ), 'id', false, 'order_id' );
			$this->HuiMsg ( D( 'OrderInfo' )->getOrderInfoIdList( $order_id ) );
		} else {
			$this->error( '没有数据' );
		}
	}

	/**
	 * 订单详情
	 */
	public function show() {
		$theId = I ( 'get.id', 0 );
		if ( is_number ( $theId ) ) {
			$this->error ( '参数错误：id' );
		}
		// 获取订单信息
		$dataInfo = $this->model->getOne ( $theId );
		if ( empty ( $dataInfo ) ) {
			die ( '数据未找到!' );
		}
		// 订单商品模型
		$orderInfoModel = D ( 'OrderInfo' );
		// 获取下单人ID
		$dataInfo ['nickname'] = D ( 'Member' )->getOne ( $dataInfo ['uid'], 'id', false, 'username' );
		// 获取收货地址信息
		$dataInfo ['addressInfo'] = D ( 'Address' )->getInfo ( $dataInfo ['address'] );
		// 获取订单包含的产品
		$dataInfo ['product'] = $orderInfoModel->getList ( $dataInfo ['order_id'] );
		// 统计商品个数 
		$dataInfo ['num'] = $orderInfoModel->countPro ( $dataInfo ['product'] );
		$this->assign ( 'dataInfo', $dataInfo );
		// 渲染模板
		$this->display ();
	}

	/**
	 * 发货
	 */
	public function deliver_goods() {
		$orderInfoModel = D ( 'OrderInfo' );
		// 判断是更新还是显示
		if ( I ( 'get.tag', '' ) == 'update' ) {
			$this->HuiMsg ( $orderInfoModel->deliver_goods ( $_POST ) );
		} else {
			// 获取参数
			$theId = I ( 'get.id', 0 );
			if ( empty ( $theId ) ) {
				die ( '参数错误：id' );
			}
			$infoList = $orderInfoModel->getProList ( $theId );
			if ( count ( $infoList ) > 0 ) {
				// 注入数据
				$this->assign ( 'theId', $theId );
				$this->assign ( 'infoList', $infoList );
				// 渲染视图
				$this->display ();
			} else {
				die ( '没有需要发货的商品' );
			}
		}
	}

	/**
	 * 物流跟踪/查看物流
	 */
	public function logistics() {
		// 模型
		$logisticsModel = D ( 'OrderLogistics' );
		// 判断是新增物流还是查看物流
		if ( I ( 'get.tag', '' ) == 'create' ) {
			// 新增物流信息
			$this->HuiMsg ( $logisticsModel->insert ( $_POST ) );
		} else {
			// 查看物流
			$condition ['order_info_id'] = I ( 'get.order_info_id', 0 );
			if ( empty ( $condition ['order_info_id'] ) ) {
				die ( "参数传递有误：order_info_id" );
			}
			// 获取当前订单商品详情
			$orderInfo = D ( 'OrderInfo' )->getOne ( $condition ['order_info_id'] );
			$this->assign ( 'orderInfo', $orderInfo );
			// 获取当前订单商品的物流信息
			$condition ['status'] = 0;
			$condition ['is_delete'] = 0;
			$logisticsList = $logisticsModel->getList ( $condition, "create_time,intro", array ( 'begin' => 0, 'num' => 0 ), "create_time desc" );
			$this->assign ( 'logisticsList', $logisticsList );
			// 渲染视图
			$this->display ();
		}
	}
}