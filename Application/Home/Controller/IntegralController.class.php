<?php

namespace Home\Controller;

/**
 * 会员积分逻辑层
 *
 * @author Administrator
 *        
 */
class IntegralController extends CommController {
	public function _initialize() {
		parent::_initialize();
		if ( strpos( '|index|show|', '|'.ACTION_NAME.'|') === false ) {
			$this->checkLogin();
		}
	}
	// 积分申请提现
	public function index() {
		if ( !empty( $this->member ) ) {
			// 签到一次所得积分
			$integral_rule = json_decode( $this->config['integral_rule'], true );
			$this->assign( 'integral_rule_past', $integral_rule['past'] );
			// 是否已签到
			$isPastOK = false;
			$todaytime = strtotime(date('Y-m-d'));
			$nameval = tmpl_upgrade(2);
			$isPast = D('MemberUpgrade')->where(array('mid'=>$this->member['id'],'record'=>$nameval))->order('create_time desc')->find();
			if($isPast && $isPast['create_time'] > $todaytime){
				$isPastOK = true;
			}
			$this->assign( 'isPastOK', $isPastOK );
			$this->assign( 'isLogin', true );
		} else {
			$this->assign( 'isLogin', false );
		}
		// 兑换商品
		$GoodsModel=D('Goods');
		$map['is_delete'] = 0;
		$map['status'] = 0;
		$list=$GoodsModel->where($map)->order('sort desc')->select();
		$this->assign('goodslist',$list);
		
		// 栏目名称
		$this->assign( 'columnTitle', '积分商城' );
		
		// 渲染视图
		$this->display();
	}
	/**
	 * 积分商品详情
	 */
	public function show(){
		$id = I('get.id');
		$map['is_delete'] = 0;
		$map['is_delete'] = 0;
		$map['id'] = $id;
		$dataInfo = D('Goods')->where($map)->find();

		$this->assign( 'dataInfo', $dataInfo );
		
		// 渲染视图
		$this->display();
		
	}

	/**
	 * 兑换商品
	 */
	public function changegoods(){
		if (IS_AJAX && $_POST) {
			$MemberModel = D('Member');
			$Member=$MemberModel->where(array('id'=>$this->member['id']))->find();
			
			if ($Member['integral']>=$_POST['integral']) {
				$ChangeOrderModel=D('change_order');
				$thisOrderId = date('YmdHis').rand(10000000,99999999);
				$data=array(
						'user_id'=>$this->member['id'],
						'order_id'=>$thisOrderId,//生成订单编号,
						'goods_id'=>$_POST['id'],
						'add_time'=>time()
				);
				$thisId = $ChangeOrderModel->add($data);
				$map['mid'] = $this->member['id'];
				$map['create_time'] = time();
				$map['order_id'] = $thisId;
				$map['integral'] = $_POST['integral'];
				$map['record'] = '33';
				$map['sign'] = '2';
				D( 'MemberIntegral' )->add($map);
				$MemberModel->where('id='.$this->member['id'])->setField('use_integral',$Member['use_integral']+$_POST['integral']);
				$MemberModel->where('id='.$this->member['id'])->setField('integral',$Member['integral']-$_POST['integral']);
				$return['status'] = 1;
				$this->ajaxReturn( $return );
			}else{
				$return['status'] = 0;
				$this->ajaxReturn( $return );
			}
	
		}else{
			$this->error('非法操作!');
		}
	}
	/**
	 * 积分明细
	 */
	public function detail(){
		// 设置查询字段
		$field = "a.order_id,a.integral,a.create_time";
		$field .= ",b.title as type_name";
		$field .= ",c.order_id as order_name";
		// 设置查询条件
		$sql = "select $field from db_member_integral as a";
		$sql .= " left join db_category as b on b.id = a.type";
		$sql .= " left join db_order as c on c.id = a.order_id";
		$sql .= " where a.is_delete = 0 and a.mid = {$this->member['id']}";
		// 设置排序条件
		$order .= "a.create_time desc";

		// 读取数据
		$this->dataList = D( 'MemberIntegral' )->getSQLList( $sql, array( 'begin' => 0, 'num' => 0 ), $order );
		$this->assign( 'dataList', $this->dataList );

		// 渲染视图
		$this->display();
	}
	/**
	 * 兑换记录
	 */
	public function recode(){
		$recode = D('change_order')->where(array('user_id'=>$this->member['id']))->order('add_time desc')->select();
		foreach ($recode as $k=>$v){
			$model =  D('Goods');
			$recode[$k]['showtitle'] = $model->where(array('id'=>$v['goods_id']))->getField('title');
			$recode[$k]['picture'] = $model->where(array('id'=>$v['goods_id']))->getField('picture');
			$recode[$k]['integral'] = $model->where(array('id'=>$v['goods_id']))->getField('integral');
		}
		$this->assign( 'dataList', $recode );
		$this->display();
	}
	/**
	 * 积分使用说明
	 */
	public function integral_intro(){
		$dataInfo = D('WebIntroduce')->where(array('id'=>3))->find();
		$this->assign ( 'dataInfo', $dataInfo );
		// 渲染视图
		$this->display ();
	}
}