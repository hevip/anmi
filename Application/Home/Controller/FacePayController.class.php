<?php

namespace Home\Controller;

/**
 * 当面支付类
 * 
 * @author BoBo
 *        
 */
class FacePayController extends CommController {
	
	// 初始化
	public function _initialize() {
		parent::_initialize ();
		$this->checkLogin ();
	}
	
	// 当面支付
	public function add() {
		$this->assign( 'columnTitle', '当面支付' );
		// 渲染模板
		$this->display ();
	}
	
	// 确认订单
	public function payOrder() {
		if ( IS_POST ) {
			// POST数据
			$this->assign( "post", $_POST );
			// 收货地址[默认]
			$this->assign( "address", D( 'Address' )->getDefault() );
			// 收货地址列表
			$addressList = D( 'Address' )->getList();
			if ( count( $addressList ) == 0 ) {
				$this->redirect( 'Address/add' );
			}
			$this->assign( "addressList", $addressList );
			// 栏目名称
			$this->assign( 'columnTitle', '当面支付' );
			// 渲染模板
			$this->display ();
		} else {
			$this->error( '非法操作' );
		}
	}
	
	// 添加订单
	public function addOrder() {
		if ( IS_POST && IS_AJAX ) {
			// 新增订单
			$_POST['uid'] = $this->member['id'];
			$return = D( 'Order' )->facePayInsert( $_POST );
			if ( $return['status'] == 1 ) {
				$return['url'] = U( 'Cart/payment/id/'.$return['info'] );
			}
			$this->ajaxReturn( $return );
		} else {
			$this->error( '非法操作!' );
		}
	}
}
