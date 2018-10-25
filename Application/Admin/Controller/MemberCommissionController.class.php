<?php

namespace Admin\Controller;

/**
 * 会员积分奖励(团队建设、团队管理)模型类
 * 
 * @author Administrator
 *        
 */
class MemberCommissionController extends CommController {
	
	// 显示数据列表
	public function index() {
		// 设置查询条件
		$condition = array();
		$order_id = I( 'post.order_id', '' );
		if ( !empty( $order_id ) ) {
			$condition['order_id'] = D( 'Order' )->where( array( 'order_id' => $order_id ) )->getField( 'id' );
		}
		// 下单会员
		$search['username'] = I( 'post.username', '' );
		if ( $search['username'] != '' ) {
			$member = D ( 'Member' );
			$condition['uid'] = $member->where( array( 'username' => $search['username'] ) )->getField( 'id' );
		}
		// 设置数据列表
		$model = D ( 'MemberCommission' );
		$dataList = $model->format ( $this->getList ( $model, $condition, 20, "create_time desc" ) );
		$this->assign ( "dataList", $dataList );
		$this->assign ( "order_id", $order_id );
		
		// 渲染模板
		$this->display ();
	}
	
	// 删除提成
	public function remove() {
		$id = I( 'post.id' );
		$result = D( 'MemberCommission' )->where( array( 'id' => array( 'in', $id ) ) )->delete();
		if ( $result ) {
			$this->dwzSuccess( "删除成功!", 1, "membercommission", "refreshThis" );
		} else {
			$this->dwzSuccess( "删除失败，请重新删除", 0, "membercommission", "refreshThis" );
		}
	}
	/**
	 * 导出积分奖励
	 */
	public function membercommissionexcel(){
		$xlsName = '分销奖励统计';//表头
		$xlsCell  = array(
				array('nickname','得奖用户幸运号'),
				array('source_nickname','来源用户幸运号'),
				array('order_id','来源订单'),
				array('build_price','团队建设奖'),
				array('manage_price','团队管理奖'),
				array('create_time','创建时间'),
		);
		$model = D ( 'MemberCommission' );
		$map['is_delete'] = 0;
		$dataList = $model->format($model->where($map)->order('create_time desc')->select());
		
		$xlsData = array();
		foreach ($dataList as $key=>$val){
			$xlsData[$key]['nickname'] = $val['nickname'];
			$xlsData[$key]['source_nickname'] = $val['source_nickname'];
			$xlsData[$key]['order_id'] = $val['order_id'];
			$xlsData[$key]['build_price'] = $val['build_price'];
			$xlsData[$key]['manage_price'] = $val['manage_price'];
			$xlsData[$key]['create_time'] = $val['create_time'];
		}
		$xlsWidth = array(45,20,30,15,20,20,20,20,20);
		exportExcel($xlsName,$xlsCell,$xlsData,$xlsWidth);
	}
}