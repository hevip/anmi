<?php
namespace Home\Model;

/**
 * 订单产品模型
 * 
 * @author BoBo
 *        
 */
class OrderInfoModel extends CommModel {

	/**
	 * 根据订单编号 获得所属订单商品的属性
	 *
	 * @param string $order_id
	 * @return array
	 */
	public function getProId($order_id) {
		$listArray = $this->where ( array ('order_id' => $order_id ) )->field ( 'pro_id,num' )->select ();
		$newArray = array ();
		$productModel = D ( 'Commodity' );
		for($i = 0, $size = count ( $listArray ); $i < $size; $i ++) {
			$theArray = $productModel->where ( array ('id' => $listArray [$i] ['pro_id'] ) )->field ( 'id,uid,member_price,cost_price,hit' )->find ();
			$newArray [] = array ('id' => $theArray ['id'],'uid' => $theArray ['uid'],'hit' => $theArray ['hit'],'num' => $listArray [$i] ['num'],'member_price' => $theArray ['member_price'],'cost_price' => $theArray ['cost_price'] );
		}
		return $newArray;
	}
}