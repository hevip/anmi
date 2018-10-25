<?php
namespace Admin\Controller;
/**
 * 兑换商品管理
 * @author zmh
 *
 */

class ChangeOrderController extends CommController{
	
	/**
	 * 列表页面
	 */
	function index(){
		$ChangeOrderModel=D('ChangeOrder');
		$GoodsModel=D('Goods');
		$MemberModel=D('Member');
		$orderlist=$this->getList($ChangeOrderModel, '1=1',20,'');
		foreach ($orderlist as $k=>$v){
			$orderlist[$k]['goodsname']=$GoodsModel->where('id='.$v['goods_id'])->getField('title');
			$orderlist[$k]['username']=$MemberModel->where('id='.$v['user_id'])->getField('nickname');
		}
		$this->assign('dataList',$orderlist);
		$this->display();
	}
}

?>