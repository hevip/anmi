<?php

namespace Admin\Controller;

/**
 * 会员个人消费
 * 
 * @author Administrator
 *        
 */
class MemberUpgradeController extends CommController {
	
	// 显示数据列表
	public function index() {
		// 设置查询条件
		$condition = array();
		$order_id = I( 'post.order_id', '' );
		$condition['is_delete'] = 0;
		if ( !empty( $order_id ) ) {
			$condition['order_id'] = D( 'Order' )->where( array( 'order_id' => $order_id ) )->getField( 'id' );
		}
		// 下单会员
		$search['username'] = I( 'post.username', '' );
		if ( $search['username'] != '' ) {
			$member = D ( 'Member' );
			$condition['mid'] = $member->where( array( 'username' => $search['username'] ) )->getField( 'id' );
		}
		// 设置数据列表
		$model = D ( 'MemberUpgrade' );
		$dataList = $model->format ( $this->getList ( $model, $condition, 20, "create_time desc" ) );
		$this->assign ( "dataList", $dataList );
		$this->assign ( "order_id", $order_id );
		$this->assign ( "search", $search );
		
		// 渲染模板
		$this->display ();
	}
	/**
	 * 导出积分奖励
	 */
	public function indexexcel(){
		$xlsName = '个人成长值统计';//表头
		$xlsCell  = array(
				array('nickname','得奖励用户幸运号'),
				array('source_nickname','订单来源用户幸运号'),
				array('order_id','来源订单'),
				array('upgrade','成长值分数'),
				array('upgrade_source','成长值来源'),
				array('create_time','创建时间'),
		);
		$model = D ( 'MemberUpgrade' );
		$map['is_delete'] = 0;
		$dataList = $model->format($model->where($map)->order('create_time desc')->select());
		$categoryModel = D('Category');
		$xlsData = array();
		foreach ($dataList as $key=>$val){
			$xlsData[$key]['nickname'] = $val['nickname'];
			$xlsData[$key]['source_nickname'] = $val['source_nickname'];
			$xlsData[$key]['order_id'] = D('order')->where(array('id'=>$val['order_id']))->getField('order_id');
			$xlsData[$key]['upgrade'] = $val['upgrade'];
			$xlsData[$key]['upgrade_source'] = $categoryModel->where( array( 'id' => $val['type'] ) )->getField( 'title' );
			$xlsData[$key]['create_time'] = $val['create_time'];
		}
		$xlsWidth = array(45,20,30,15,20,20,20,20,20);
		exportExcel($xlsName,$xlsCell,$xlsData,$xlsWidth);
	}
	
}