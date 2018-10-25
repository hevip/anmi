<?php

namespace Admin\Controller;

/**
 * 会员个人消费
 * 
 * @author Administrator
 *        
 */
class MemberConsumeController extends CommController {
	
	// 显示数据列表
	public function index() {
		// 设置查询条件
		$condition = array();
		$condition['is_delete'] = 0;
		$condition['status'] = 0;
		$order_id = I( 'post.order_id', '' );
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
		$model = D ( 'MemberConsume' );
		$dataList = $model->format ( $this->getList ( $model, $condition, 20, "create_time desc" ) );
		$this->assign ( "dataList", $dataList );
		$this->assign ( "order_id", $order_id );
		$this->assign ( "search", $search );
		
		// 渲染模板
		$this->display ();
	}
	
	// 删除提成
	public function remove() {
		$id = I( 'post.id' );
		$result = D( 'MemberConsume' )->where( array( 'id' => array( 'in', $id ) ) )->delete();
		if ( $result ) {
			$this->dwzSuccess( "删除成功!", 1, "memberconsume", "refreshThis" );
		} else {
			$this->dwzSuccess( "删除失败，请重新删除", 0, "memberconsume", "refreshThis" );
		}
	}
	/**
	 * 导出积分奖励
	 */
	public function indexexcel(){
		$xlsName = '个人消费统计';//表头
		$xlsCell  = array(
				array('nickname','消费用户幸运号'),
				array('order_id','来源订单'),
				array('consume_price','消费金额'),
				array('mission_price','提成金额'),
				array('create_time','创建时间'),
		);
		$model = D ( 'MemberConsume' );
		$map['is_delete'] = 0;
		$dataList = $model->format($model->where($map)->order('create_time desc')->select());
	
		$xlsData = array();
		foreach ($dataList as $key=>$val){
			$xlsData[$key]['nickname'] = $val['nickname'];
			$xlsData[$key]['order_id'] = D('order')->where(array('id'=>$val['order_id']))->getField('order_id');
			$xlsData[$key]['consume_price'] = $val['consume_price'];
			$xlsData[$key]['mission_price'] = $val['mission_price'];
			$xlsData[$key]['create_time'] = $val['create_time'];
		}
		$xlsWidth = array(45,20,30,15,20,20,20,20,20);
		exportExcel($xlsName,$xlsCell,$xlsData,$xlsWidth);
	}
}