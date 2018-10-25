<?php

namespace Admin\Controller;

/**
 * 会员消费记录控制器
 * 
 * @author Administrator
 *        
 */
class MemberConsumptionController extends CommController {
	
	// 显示数据列表
	public function index() {
		// 设置查询条件
		$condition = array();
		$order_id = I( 'post.order_id', '' );
		if ( !empty( $order_id ) ) {
			$condition['order_id'] = D( 'Order' )->where( array( 'order_id' => $order_id ) )->getField( 'id' );
		}
		$username = I( 'post.username', '' );
		if ( !empty( $username ) ) {
			$condition['uid'] = D( 'Member' )->where( array( 'username' => $username ) )->getField( 'id' );
		}
		
		
		// 设置数据列表
		$model = D ( 'MemberConsumption' );
		$dataList = $model->format ( $this->getList ( $model, $condition, 20, "create_time desc" ) );
		$this->assign ( "dataList", $dataList );
		$this->assign ( "order_id", $order_id );
		$this->assign ( "usrename", $usrename );
		
		// 渲染模板
		$this->display ();
	}
}