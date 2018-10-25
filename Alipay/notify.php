<?php
/* *
 * 功能：支付宝服务器异步通知页面
 * 版本：3.3
 * 日期：2012-07-23
 * 说明：
 * 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 * 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。


 *************************页面功能说明*************************
 * 创建该页面文件时，请留心该页面文件中无任何HTML代码及空格。
 * 该页面不能在本机电脑测试，请到服务器上做测试。请确保外部可以访问该页面。
 * 该页面调试工具请使用写文本函数logResult，该函数已被默认关闭，见alipay_notify_class.php中的函数verifyNotify
 * 如果没有收到该页面返回的 success 信息，支付宝会在24小时内按一定的时间策略重发通知
 */
// 全局变量[支付宝配置参数]
global $alipay_config;

// 引入支付宝类
require_once("../ThinkPHP/Library/Vendor/Alipay/alipay.config.php");
require_once("../ThinkPHP/Library/Vendor/Alipay/lib/alipay_notify.class.php");

//商户的私钥（后缀是.pen）文件相对路径
$alipay_config['private_key_path']	= '../ThinkPHP/Library/Vendor/Alipay/key/rsa_private_key.pem';

//支付宝公钥（后缀是.pen）文件相对路径
$alipay_config['ali_public_key_path']= '../ThinkPHP/Library/Vendor/Alipay/key/alipay_public_key.pem';

// 计算得出通知验证结果
$alipayNotify = new \AlipayNotify( $alipay_config );
$verify_result = $alipayNotify->verifyNotify();

// 验证成功
if( $verify_result ) {
	//商户订单号
	$out_trade_no = $_POST['out_trade_no'];
	
	//支付宝交易号
	$trade_no = $_POST['trade_no'];
	
	//交易状态
	$trade_status = $_POST['trade_status'];
	
	// 交易完成(TRADE_FINISHED)或付款成功(TRADE_SUCCESS)
	if( $_POST['trade_status'] == 'TRADE_FINISHED' || $_POST['trade_status'] == 'TRADE_SUCCESS' ) {
		// 实例化
		$PayObj = new PayCommission( $out_trade_no );
		$PayObj->Init();
		$PayObj->createLog( var_export( $_POST, true ), '付款成功', '支付宝' );
	}

	// 输出结果[必须输出，不能删除]
	echo "success";
} else {
	//验证失败
	echo "fail";
	// 实例化
	$PayObj = new PayCommission( $out_trade_no );
	$PayObj->createLog( var_export( $_POST, true ), '付款失败', '支付宝' );
}

// 会员提成类
class PayCommission {
	/**
	 * 订单编号
	 * @var string
	 */
	public $out_trade_no;
	
	/**
	 * 构造函数
	 * @param string $out_trade_no 订单编号
	 */
	public function __construct( $out_trade_no ) {
		$this->out_trade_no = $out_trade_no;
		
		// 连接数据库
		define ( 'conn', mysql_connect ( "localhost", "db_xiaoqiaowang", "zGzQMw&GsPWboH1#" ) );
		mysql_select_db ( "db_xiaoqiaowang", conn );
		mysql_query ( "SET NAMES 'utf8'" );
		date_default_timezone_set ( "PRC" );
	}
	
	/**
	 * 提成计算方法
	 * @param string $out_trade_no 订单编号
	 */
	public function Init() {
		$out_trade_no = $this->out_trade_no;
		// 根据订单号获取订单信息
		$sql = "select * from db_order where order_id = '". $out_trade_no ."'";
		$OrderArray = $this->_get( $sql );
		// 根据订单号获取订单详细信息
		$sql = "select * from db_order_info where order_id = '". $out_trade_no ."'";
		$OrderInfoArray = $this->_get( $sql );
		if ( count( $OrderArray ) > 0 && $OrderArray['is_pay'] == 0 ) {
			// 更改订单状态
			$sql = "update db_order set is_pay = 1 where order_id = '" . $out_trade_no . "'";
			$this->_update( $sql );
			// 添加会员消费记录
			$sql = "insert into db_member_consumption (uid,order_id,create_time) values (". $OrderArray['uid'] .",". $OrderArray['id'] .",". time() .")";
			$this->_add( $sql );
			// ==================================下面是计算订单提成的代码=====================================
			// 获取提成配置
			$sql = "select * from db_config where id = 1";
				
			$config = $this->_get( $sql );
			$love = $config['love'];			// 爱心基金
			$tax = $config['tax'] / 100;		// 税
			$market = 0;						// 售价
			$cost = 0;							// 成本
			$profit = 0;						// 利润
			$award = 0;							// 奖( 利润 * 0.6 )
			$teamBuild = $config['team_build'] / 100;		// 团队建设奖( 奖 * 0.8  )
			$teamManage = $config['team_manage'] / 100;		// 团队管理奖( 奖 * 0.2  )
			$shopRecommend = $config['recommend'] / 100;	// 商品推荐人提成百分比
			$profitPercent = $config['profit'] / 100;		// 利润百分比
			$upgradeConsumer = explode( "|", $config['upgrade_consumer'] );	// 会员升级规则
				
			// 格式化1~8层百分比
			$begin = explode( "|", $config['begin'] );
			for ( $i = 0, $size = count( $begin ); $i < $size; $i ++ ) {
				$begin[$i] = $begin[$i] / 100;
			}
				
			// 格式化(中、高、特、钻)百分比
			$high = explode( "|", $config['high'] );
			for ( $i = 0, $size = count( $high ); $i < $size; $i ++ ) {
				$high[$i] = $high[$i] / 100;
			}
				
			// 读取订单信息
			$sql = "select * from db_order where order_id = '". $out_trade_no ."'";
			$order = $this->_get( $sql );
				
			// 会员升级
			$this->upgrade( $order['uid'], $order['price'], $upgradeConsumer );
				
			// 获取订单所包含的所有商品，并计算利润，如果商品不是官方直销，向推荐人提成(利润*0.4)
			$orderInfo = $this->getProId( $order['order_id'] );
			$tempList = array();
			for ( $i = 0, $size = count( $orderInfo ); $i < $size; $i ++ ) {
				if ( !empty( $orderInfo[$i]['uid'] ) ) {
					$tempProfit = $orderInfo[$i]['member_price'] * ( 1 - $tax ) - $orderInfo[$i]['cost_price'] - $love;
					$tempProfit = $tempProfit * $orderInfo[$i]['num'] * $shopRecommend;
					$tempList[] = array(
							'uid' => $orderInfo[$i]['uid'],
							'pro_id' => $orderInfo[$i]['id'],
							'order_id' => $order['id'],
							'num' => $orderInfo[$i]['num'],
							'price' => $tempProfit,// 计算提成
							'create_time' => time(),
					);
				}
				// 计算商品的总销售额和成本
				$market += $orderInfo[$i]['member_price'] * $orderInfo[$i]['num'];
				$cost += $orderInfo[$i]['cost_price'] * $orderInfo[$i]['num'];
			}
			// 添加会员推荐商品提成
			if ( count( $tempList ) > 0 ) {
				$sql = "insert into db_member_product (uid,pro_id,order_id,num,price,create_time) values ";
				$j = 0;
				foreach ( $tempList as $rows ) {
					$j ++;
					$sql .= "({$rows['uid']},{$rows['pro_id']},{$rows['order_id']},{$rows['num']},{$rows['price']},{$rows['create_time']})";
					$sql .= $j < count( $tempList ) ? "," : "";
				}
				$this->_add( $sql );
			}
			
			// 会员团队提成(具体详情见开发文档)
			// 利润
			$profit = $market * ( 1 - $tax ) - $cost - $love;
			// 奖
			$award = $profit * $profitPercent;
			// 团队建设奖
			$teamBuild = $award * $teamBuild;
			// 团队管理奖
			$teamManage = $award * $teamManage;
			// 进行会员提成
			$sql = "select * from db_member where id = {$order['uid']}";
			$user = $this->_get( $sql );
			// 级别提成标记
			$levelMark = array(
					2 => 'no',
					3 => 'no',
					4 => 'no',
					5 => 'no',
			);
			$commArray['from_id'] = $user['id'];
			$commArray['order_id'] = $order['id'];
			$commArray['begin'] = $begin;
			$commArray['high'] = $high;
			$result = $this->commission( $commArray, $user['recommended'], $teamBuild, $teamManage, 1, 1, $levelMark );
		}
	}
	
	/**
	 * 支付宝支付日志记录
	 * @param array $post 支付宝POST返回的数据
	 * @param string $status 支付状态
	 * @param string $apiType 支付接口名称
	 */
	public function createLog( $post, $status, $apiType ) {
		$content = file_get_contents( 'log.txt' ) . $this->get_content( $post, $status, $this->out_trade_no, $apiType );
		file_put_contents( "log.txt", $content );
	}
	
	/**
	 * 设置记录支付状态内容
	 * @param array $post 支付宝POST返回的数据
	 * @param string $status 支付状态
	 * @param unknown $orderId 订单编号
	 * @param string $apiType 支付接口名称
	 * @return string
	 */
	public function get_content( $post, $status, $orderId, $apiType ) {
		$content = "\r\n+-------------------------------------------------\r\n";
		$content .= "+ 订单号：" . $orderId . "\r\n";
		$content .= "+ ". $apiType ."返回时间：". date( "Y-m-d H:i:s" ) ."\r\n";
		$content .= "+ ". $apiType ."返回码：" . $post ."\r\n";
		$content .= "+ 状态：" . $status ."\r\n";
		$content .= "+-------------------------------------------------\r\n";
		return $content;
	}
	
	/**
	 * 更新sql[修改一条记录]，并返回成功或失败[true|false]
	 * @param string $sql sql语句
	 * @return boolean [true|false]
	 */
	public function _update( $sql ) {
		return mysql_query( $sql, conn ) ? true : false;
	}
	
	/**
	 * 新增sql[新增一条记录]，并返回成功或失败[true|false]
	 * @param string $sql sql语句
	 * @return boolean [true|false]
	 */
	public function _add( $sql ) {
		mysql_query( $sql, conn );
		return mysql_affected_rows( conn ) === 1 ? true : false;
	}
	
	/**
	 * 查询sql[获取一条记录]，并返回数组
	 * @param string $sql sql语句
	 * @param boolean $IsOne true二维数组(列表)|false一维数组(一条信息)
	 * @return array
	 */
	public function _get( $sql, $IsOne = false ) {
		if ( $IsOne ) {
			$result = mysql_query ( $sql, conn );
			$dataArray = array();
			if (mysql_num_rows($result) > 0){
				while (($row = mysql_fetch_array($result)) == true){
					$dataArray[] = $row;
				}
			}
			return $dataArray;
		} else {
			$result = mysql_query ( $sql, conn );
			return mysql_num_rows ( $result ) === 1 ? mysql_fetch_array ( $result ) : array();
		}
	}


	/**
	 * 查询sql[取某个数据表里的条件相等的某条数据,并返回想要的那个字段的值]
	 * @param string $table 表名
	 * @param string $where sql条件
	 * @param string $returnField 返回值的字段
	 * @return array
	 */
	public function _getField( $table, $where, $returnField ) {
		$sql = "select * from $table where $where";
		$result = mysql_query ( $sql, conn );
		if (mysql_num_rows ( $result ) === 1) {
			$tempArr = mysql_fetch_array ( $result );
			return $tempArr[$returnField];
		} else {
			return null;
		}
	}
	
	/**
	 * 会员提成计算
	 * @param string $recommend 会员推荐码
	 * @param number $teamBuild	团队建设奖
	 * @param number $teamManage 团队管理奖
	 * @param number $layer 层数
	 * @param array $level 级别
	 * @param array $levelark 级别提成标记
	 */
	public function commission( $commArray, $recommend, $teamBuild, $teamManage, $layer, $level, $levelMark ) {
		if ( empty( $recommend ) ) {
			return;
		}
		$sql = "select * from db_member where recommend = '". $recommend ."'";
		$thisArray = $this->_get( $sql );
		if ( empty( $thisArray ) ) {
			return $layer;
		} else {
			if ( $layer > 8 && $level >= 5 ) {
				return $layer;
			}
			$tempArray['from_id'] = $commArray['from_id'];
			$tempArray['order_id'] = $commArray['order_id'];
			$tempArray['uid'] = $thisArray['id'];
			$tempArray['create_time'] = time();
			// 2层计算（团队建设奖）
			$tempArray['build_price'] = 0;
			switch ( $layer ) {
				case 1 :
					$tempArray['build_price'] = $teamBuild * $commArray['begin'][0];
					break;
				case 2 :
					$tempArray['build_price'] = $teamBuild * $commArray['begin'][1];
					break;
			}
			// 团队管理奖
			$tempArray['manage_price'] = 0;
			if ( $thisArray['level'] > $level && $levelMark[ $thisArray['level'] ] == "no" ) {
				switch ( $thisArray['level'] ) {
					case 2 : // 中级消费商5%
						$tempArray['manage_price'] = $teamManage * $commArray['high'][0];
						$levelMark[ $thisArray['level'] ] = 'yes';
						break;
					case 3 : // 高级消费商35%
						if ( $levelMark[ $thisArray['level'] - 1 ] == 'yes' ) {
							$percent = $commArray['high'][1] - $commArray['high'][0];
						} else {
							$percent = $commArray['high'][1];
						}
						$tempArray['manage_price'] = $teamManage * $percent;
						$levelMark[ $thisArray['level'] ] = 'yes';
						break;
					case 4 : // 特级消费商60%
						if ( $levelMark[ $thisArray['level'] - 1 ] == 'yes' ) {
							$percent = $commArray['high'][2] - $commArray['high'][1];
						} else if ( $levelMark[ $thisArray['level'] - 2 ] == 'yes' ) {
							$percent = $commArray['high'][2] - $commArray['high'][0];
						} else {
							$percent = $commArray['high'][2];
						}
						$tempArray['manage_price'] = $teamManage * $percent;
						$levelMark[ $thisArray['level'] ] = 'yes';
						break;
					case 5 : // 钻石消费商100%
						if ( $levelMark[ $thisArray['level'] - 1 ] == 'yes' ) {
							$percent = $commArray['high'][3] - $commArray['high'][2];
						} else if ( $levelMark[ $thisArray['level'] - 2 ] == 'yes' ) {
							$percent = $commArray['high'][3] - $commArray['high'][1];
						} else if ( $levelMark[ $thisArray['level'] - 3 ] == 'yes' ) {
							$percent = $commArray['high'][3] - $commArray['high'][0];
						} else {
							$percent = $commArray['high'][3];
						}
						$tempArray['manage_price'] = $teamManage * $percent;
						$levelMark[ $thisArray['level'] ] = 'yes';
						break;
				}
			} // 团队管理奖结束
	
			// 执行添加
			if ( $layer > 2 && $tempArray['manage_price'] == 0 ) {
				// 此条件下没有任何提成产生，不执行添加
				$this->commission( $commArray, $thisArray['recommended'], $teamBuild, $teamManage, $layer, $thisArray['level'], $levelMark );
			} else {
				$sql = "insert into db_member_commission ";
				$sql .= "(from_id,order_id,uid,create_time,build_price,manage_price)";
				$sql .= "values ({$tempArray['from_id']},{$tempArray['order_id']},{$tempArray['uid']},";
				$sql .= "{$tempArray['create_time']},{$tempArray['build_price']},{$tempArray['manage_price']})";
				if ( $this->_add( $sql ) ) {
					// 更新会员表的总积分
					$AllIntegral = $tempArray['manage_price'] + $tempArray['build_price'];
					// 先获取会员当前的积分
					$theIntegral = $this->_getField( "db_member", "id = {$tempArray['uid']}", "integral" );
					// 更新会员的积分
					$totalIntegral = $AllIntegral + $theIntegral;
					$sql = "update db_member set integral = {$totalIntegral} where id = {$tempArray['uid']}";
					$this->_update( $sql );
					$layer ++;
					$this->commission( $commArray, $thisArray['recommended'], $teamBuild, $teamManage, $layer, $thisArray['level'], $levelMark );
				}
			}
		}
	}
	
	/**
	 * 根据订单编号 获得所属订单商品的属性
	 * @param string $order_id
	 * @return array
	 */
	public function getProId( $order_id ) {
		$sql = "select pro_id,num from db_order_info where order_id = '". $order_id ."'";
		$listArray = $this->_get( $sql, true );
		$newArray = array();
		for ( $i = 0, $size = count( $listArray ); $i < $size; $i ++ ) {
			$rows = $listArray[$i];
			$sql = "select id,uid,member_price,cost_price,hit from db_product where id = {$rows['pro_id']}";
			$theArray = $this->_get( $sql );
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
	 * 会员升级
	 * @param number $uid 会员id
	 * @param number $price 订单价格
	 * @param array $upgradeConsumer 升级规则
	 */
	public function upgrade( $uid, $price, $upgrade ) {
		$sql = "select * from db_member where id = {$uid}";
		$user = $this->_get( $sql );
		if ( empty( $user ) ) {
			return;
		}
		$sql = "select price from db_order where uid = {$user['id']} and is_pay = 1";
		$orderArray = $this->_get( $sql, true );
		for ( $i = 0, $size = count( $orderArray ); $i < $size; $i ++ ) {
			$price += $orderArray[$i]['price'];
		}
		// 直推总数
		$push = $this->getTeamList( $user['recommend'], 'push' );
		// 团队总数
		$team = $this->getTeamList( $user['recommend'], 'team' );
		// 更新的sql语句
		$update_sql = "";
		switch ( $user['level'] ) {
			case 0:
				$return = explode( "-", $upgrade[2] );
				$reutrn2 = explode( "-", $upgrade[3] );
				$reutrn3 = explode( "-", $upgrade[4] );
				if ( $push >= $reutrn3[0] || $team >= $reutrn3[1] ) {
					$update_sql = "update db_member set level = 5 where id = {$uid}";
				} else if ( $push >= $reutrn2[0] || $team >= $reutrn2[1] ) {
					$update_sql = "update db_member set level = 4 where id = {$uid}";
				} else if ( $push >= $return[0] || $team >= $return[1] ) {
					$update_sql = "update db_member set level = 3 where id = {$uid}";
				} else if ( $price >= $upgrade[1] ) {
					$update_sql = "update db_member set level = 2 where id = {$uid}";
				} else if ( $price >= $upgrade[0] ) {
					$update_sql = "update db_member set level = 1 where id = {$uid}";
				}
				break;
			case 1:
				$return = explode( "-", $upgrade[2] );
				$reutrn2 = explode( "-", $upgrade[3] );
				$reutrn3 = explode( "-", $upgrade[4] );
				if ( $push >= $reutrn3[0] || $team >= $reutrn3[1] ) {
					$update_sql = "update db_member set level = 4 where id = {$uid}";
				} else if ( $push >= $reutrn2[0] || $team >= $reutrn2[1] ) {
					$update_sql = "update db_member set level = 3 where id = {$uid}";
				} else if ( $push >= $return[0] || $team >= $return[1] ) {
					$update_sql = "update db_member set level = 2 where id = {$uid}";
				} else if ( $price >= $upgrade[1] ) {
					$update_sql = "update db_member set level = 1 where id = {$uid}";
				}
				break;
			case 2:
				$return = explode( "-", $upgrade[2] );
				$reutrn2 = explode( "-", $upgrade[3] );
				$reutrn3 = explode( "-", $upgrade[4] );
				if ( $push >= $reutrn3[0] || $team >= $reutrn3[1] ) {
					$update_sql = "update db_member set level = 3 where id = {$uid}";
				} else if ( $push >= $reutrn2[0] || $team >= $reutrn2[1] ) {
					$update_sql = "update db_member set level = 2 where id = {$uid}";
				} else if ( $push >= $return[0] || $team >= $return[1] ) {
					$update_sql = "update db_member set level = 1 where id = {$uid}";
				}
				break;
			case 3:
				$return = explode( "-", $upgrade[3] );
				$reutrn2 = explode( "-", $upgrade[4] );
				if ( $push >= $reutrn2[0] || $team >= $reutrn2[1] ) {
					$update_sql = "update db_member set level = 2 where id = {$uid}";
				} else if ( $push >= $return[0] || $team >= $return[1] ) {
					$update_sql = "update db_member set level = 1 where id = {$uid}";
				}
				break;
			case 4:
				$return = explode( "-", $upgrade[4] );
				if ( $push >= $return[0] || $team >= $return[1] ) {
					$update_sql = "update db_member set level = 1 where id = {$uid}";
				}
				break;
			case 5:
				break;
		}
		if ( $update_sql != '' ) {
			$this->_update( $update_sql );
		}
	}
	
	/**
	 * 统计团队人数
	 * @param intval $recommend 会员幸运号
	 * @param string $type 类型
	 * @param number $countList 计数器
	 * @return number
	 */
	public function getTeamList( $recommend, $type, $countList = 0 ) {
		if ( $type == "push" ) {
			$sql = "select * from db_member where recommended = '". $recommend ."' and level > 0";
			$dataArray = $this->_get( $sql, true );
			return count( $dataArray );
		} else {
			$sql = "select * from db_member where recommended = '". $recommend ."'";
			$newArray = $this->_get( $sql, true );
			if ( count( $newArray ) > 0 ) {
				for ( $i = 0, $size = count( $newArray ); $i < $size; $i ++ ) {
					if ( $newArray[$i]['level'] >= 1 ) {
						$countList ++;
					}
					return $this->getTeamList( $newArray[$i]['recommend'], $type, $countList );
				}
			} else {
				return $countList;
			}
		}
	}
}
?>