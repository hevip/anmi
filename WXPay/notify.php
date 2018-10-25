<?php
/**
 * 微信异步返回处理订单状态及提成、积分计算
 */
// 连接数据库
define ( 'conn', mysql_connect ( "localhost", "db_xiaoqiaowang", "zGzQMw&GsPWboH1#" ) );
mysql_select_db ( "db_xiaoqiaowang", conn );
mysql_query ( "SET NAMES 'utf8'" );
date_default_timezone_set ( "PRC" );
// 获取提成及微信配置
$sql = "select * from db_config where id = 1";			
$config = _get( $sql );
// 微信配置[微信类才使用]
define( 'WX_APPID', $config['wx_app_id'] );
define( 'WX_APPSECRET', $config['wx_app_secret'] );
define( 'WX_PAY_MCHID', $config['wx_pay_mchid'] );
define( 'WX_PAY_PASS', $config['wx_pay_pass'] );
// 引入微信类
include_once("../ThinkPHP/Library/Vendor/WxPayPubHelper/WxPayPubHelper.php");
//使用通用通知接口
$notify = new Notify_pub();
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

if($notify->checkSign() == TRUE) {
	$out_trade_no = $notify->data['out_trade_no'];
	if ($notify->data["return_code"] == "FAIL") {
		//echo '通信出错';
		$status = '通信出错';
	} elseif ( $notify->data["result_code"] == "FAIL" ){
		//echo '业务出错';
		$status = '业务出错';
	} else {
		//echo '支付成功';
		$status = '支付成功';
		// 根据订单号获取订单信息
		$sql = "select * from db_order where order_id = '". $out_trade_no ."'";
		$OrderArray = _get( $sql );
		// 根据订单号获取订单详细信息
		$sql = "select * from db_order_info where order_id = '". $out_trade_no ."'";
		$OrderInfoArray = _get( $sql );
		if ( count( $OrderArray ) > 0 && $OrderArray['is_pay'] == 0 ) {
			// 更改订单状态
			$sql = "update db_order set is_pay = 1 where order_id = '" . $out_trade_no . "'";
			_update( $sql );
			// 添加会员消费记录
			$sql = "insert into db_member_consumption (uid,order_id,create_time) values (". $OrderArray['uid'] .",". $OrderArray['id'] .",". time() .")";
			_add( $sql );
			// ==================================下面是计算订单提成的代码===================================== 
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
			$order = _get( $sql );
			
			// 会员升级
			upgrade( $order['uid'], $order['price'], $upgradeConsumer );
			
			// 获取订单所包含的所有商品，并计算利润，如果商品不是官方直销，向推荐人提成(利润*0.4)
			$orderInfo = getProId( $order['order_id'] );
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
				_add( $sql );
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
			$user = _get( $sql );
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
			$result = commission( $commArray, $user['recommended'], $teamBuild, $teamManage, 1, 1, $levelMark );
		}
	}
	
	// 记录支付状态
	$content = file_get_contents( 'WXPay.log' ) . get_content( $xml, $status, $out_trade_no );
	file_put_contents( "WXPay.log", $content );
	
	//商户自行增加处理流程,
	//例如：更新订单状态
	//例如：数据库操作
	//例如：推送支付完成信息
}

// 设置记录支付状态内容
function get_content( $xml, $status, $orderId ) {
	$content = "\r\n+-------------------------------------------------\r\n";
	$content .= "+ 订单号：" . $orderId . "\r\n";
	$content .= "+ 微信返回时间：". date( "Y-m-d H:i:s" ) ."\r\n";
	$content .= "+ 微信返回码：" . $xml ."\r\n";
	$content .= "+ 状态：" . $status ."\r\n";
	$content .= "+-------------------------------------------------\r\n";
	return $content;
}

// 更新sql[修改一条记录]，并返回成功或失败[true|false]
function _update( $sql ) {
	return mysql_query( $sql, conn ) ? true : false;
}
// 新增sql[新增一条记录]，并返回成功或失败[true|false]
function _add( $sql ) {
	mysql_query( $sql, conn );
	return mysql_affected_rows( conn ) === 1 ? true : false;
}
// 查询sql[获取一条记录]，并返回数组
function _get( $sql, $IsOne = false ) {
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
// 查询sql[取某个数据表里的条件相等的某条数据,并返回想要的那个字段的值]
function _getField( $table, $where, $returnField ) {
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
function commission( $commArray, $recommend, $teamBuild, $teamManage, $layer, $level, $levelMark ) {
	if ( empty( $recommend ) ) {
		return;
	}
	$sql = "select * from db_member where recommend = '". $recommend ."'";
	$thisArray = _get( $sql );
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
			commission( $commArray, $thisArray['recommended'], $teamBuild, $teamManage, $layer, $thisArray['level'], $levelMark );
		} else {
			$sql = "insert into db_member_commission ";
			$sql .= "(from_id,order_id,uid,create_time,build_price,manage_price)";
			$sql .= "values ({$tempArray['from_id']},{$tempArray['order_id']},{$tempArray['uid']},";
			$sql .= "{$tempArray['create_time']},{$tempArray['build_price']},{$tempArray['manage_price']})";
			if ( _add( $sql ) ) {
				// 更新会员表的总积分
				$AllIntegral = $tempArray['manage_price'] + $tempArray['build_price'];
				// 先获取会员当前的积分
				$theIntegral = _getField( "db_member", "id = {$tempArray['uid']}", "integral" );
				// 更新会员的积分
				$totalIntegral = $AllIntegral + $theIntegral;
				$sql = "update db_member set integral = {$totalIntegral} where id = {$tempArray['uid']}";
				_update( $sql );				
				$layer ++;
				commission( $commArray, $thisArray['recommended'], $teamBuild, $teamManage, $layer, $thisArray['level'], $levelMark );
			}
		}
	}
}

/**
 * 根据订单编号 获得所属订单商品的属性
 * @param string $order_id
 * @return array
 */
function getProId( $order_id ) {
	$sql = "select pro_id,num from db_order_info where order_id = '". $order_id ."'";
	$listArray = _get( $sql, true );
	$newArray = array();
	for ( $i = 0, $size = count( $listArray ); $i < $size; $i ++ ) {
		$rows = $listArray[$i];
		$sql = "select id,uid,member_price,cost_price,hit from db_product where id = {$rows['pro_id']}";
		$theArray = _get( $sql );
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
function upgrade( $uid, $price, $upgrade ) {
	$sql = "select * from db_member where id = {$uid}";
	$user = _get( $sql );
	if ( empty( $user ) ) {
		return;
	}
	$sql = "select price from db_order where uid = {$user['id']} and is_pay = 1";
	$orderArray = _get( $sql, true );
	for ( $i = 0, $size = count( $orderArray ); $i < $size; $i ++ ) {
		$price += $orderArray[$i]['price'];
	}
	// 直推总数
	$push = getTeamList( $user['recommend'], 'push' );
	// 团队总数
	$team = getTeamList( $user['recommend'], 'team' );
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
		_update( $update_sql );
	}
}

// 统计团队人数
function getTeamList( $recommend, $type, $countList = 0 ) {
	if ( $type == "push" ) {
		$sql = "select * from db_member where recommended = '". $recommend ."' and level > 0";
		$dataArray = _get( $sql, true );
		return count( $dataArray );
	} else {
		$sql = "select * from db_member where recommended = '". $recommend ."'";
		$newArray = _get( $sql, true );
		if ( count( $newArray ) > 0 ) {
			for ( $i = 0, $size = count( $newArray ); $i < $size; $i ++ ) {
				if ( $newArray[$i]['level'] >= 1 ) {
					$countList ++;
				}
				return getTeamList( $newArray[$i]['recommend'], $type, $countList );
			}
		} else {
			return $countList;
		}
	}
}
die();
?>