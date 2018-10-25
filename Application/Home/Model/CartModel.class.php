<?php
namespace Home\Model;

/**
 * 购物车模型
 *
 * @author BoBo
 *        
 */
class CartModel extends CommModel {

	/**
	 * 更新购物车
	 *
	 * @param string $json 购物车数据[以json格式保存]
	 * @param array $member 会员信息
	 */
	public function updateCart( $json, $member = array() ) {
		$returnMsg = returnMsg ();
		if ( empty ( $member ['id'] ) ) {
			$returnMsg ['info'] = "会员信息有误!";
			return $returnMsg;
		}
		// 组合数据
		$dataArray ['user_id'] = $member ['id'];
		$dataArray ['cart_json'] = $json;
		$dataArray ['create_time'] = time ();
		// 检测是否存在
		$memberObj = $this->getOne ( $member ['id'], 'user_id' );
		if ( empty ( $memberObj ) ) {
			if ( $this->create ( $dataArray ) ) {
				if ( $this->add () ) {
					$returnMsg ['status'] = 1;
					$returnMsg ['info'] = "添加购物车成功!";
				} else {
					$returnMsg ['info'] = "添加购物车失败!";
				}
			} else {
				$returnMsg ['info'] = "添加购物车失败!";
			}
		} else {
			$whereCondition = array ( 'user_id' => $member ['id'] );
			if ( $this->where ( $whereCondition )->save ( $dataArray ) ) {
				$returnMsg ['status'] = 1;
				$returnMsg ['info'] = "添加购物车成功!";
			} else {
				$returnMsg ['info'] = "添加购物车失败!";
			}
		}
		return $returnMsg;
	}

	/**
	 * 格式化购物车列表
	 *
	 * @param array $cartObj 购物车数据
	 * @return array
	 */
	public function formatCart( $cartObj ) {
		$i = 0;
		$k = 0;
		$cartList = array ();
		$cartObj ['paymentMoney'] = 0;
		$cartArray = $cartObj ['cartList'];
		for ( $j = 0 , $size = count ( $cartArray ); $j < $size; $j ++ ) {
			$tempModel = D ( 'Commodity' );
			$theArray = array ();
			$field = "title,picture,member_price,market_price,intro,freight";
			$theArray = $tempModel->where ( array ( 'id' => $cartArray [$j] ['id'] ) )->field ( $field )->find ();
			$theArray ['url'] = U ( "Commodity/show/id/{$cartArray[$j]['id']}" );
			$theArray ['freight'] = $cartArray [$j] ['num'] * $theArray ['freight'];
			$theArray ['total_price'] = floatval ( $cartArray [$j] ['num'] * $theArray ['member_price'] ) + $theArray ['freight'];
			if ( $cartArray [$j] ['check'] == 1 ) {
				$cartObj ['paymentMoney'] += $theArray ['total_price'];
			}
			$cartList [$j] = array_merge ( $theArray, $cartArray [$j] );
		}
		$cartObj ['cartList'] = $cartList;
		return $cartObj;
	}

	/**
	 * 获取要下单的产品
	 */
	public function getCartList() {
		// 把json转为数组
		$cartObj = json_decode ( $_COOKIE ['ShopCart'], true );
		$tempList = $cartObj ['cartList'];
		$cartList = array ();
		$cartList ['list'] = array ();
		$cartList ['total_price'] = 0;
		$cartList ['total_send'] = 0;
		$cartList ['num'] = 0;
		$ProModel = D ( 'Commodity' );
		for ( $j = 0 , $len = count ( $tempList ); $j < $len; $j ++ ) {
			if ( $tempList [$j] ['check'] == 1 ) {
				$theArray = array ();
				$field = "title,picture,member_price,market_price,intro,freight";
				$theArray = $ProModel->where ( array ( 'id' => $tempList [$j] ['id'] ) )->field ( $field )->find ();
				$theArray ['url'] = U ( "Commodity/show/id/{$tempList[$j]['id']}" );
				$theArray ['freight'] = $theArray ['freight'] * $tempList [$j]['num'];
				$theArray ['total_price'] = $tempList [$j] ['num'] * $theArray ['member_price'] + $theArray ['freight'];
				$theArray ['send'] = empty ( $theArray ['freight'] ) ? '包邮' : $theArray ['freight'];
				$cartList ['list'] [] = array_merge ( $theArray, $tempList [$j] );
				$cartList ['total_send'] += $theArray ['freight'];
				$cartList ['total_price'] += $theArray ['total_price'];
				$cartList ['num'] += $tempList [$j] ['num'];
			}
		}
		return $cartList;
	}
}