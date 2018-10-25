<?php
namespace Admin\Controller;
/**
 * 产品管理
 * @author zmh
 *
 */

class GoodsController extends CommController{

	public function _initialize() {
		parent::_initialize ();
		// 模型
//		$this->model = D ( 'goods' );
	}
	
	/**
	 * 列表页面
	 */
	function index(){
//		$GoodsModel=D('Goods');
//		$Goodslist=$this->getList($GoodsModel, '1=1');
//		$this->assign('dataList',$Goodslist);
//		$this->display();
		if($_POST['title']){
			$condition['title'] = array( 'like', "%{$_POST['title']}%" );
		}
		$condition['is_delete'] = 0;
		$res = D('goods')->where($condition)->order('type desc')->select();
		foreach($res as $k=>$v){
			$res[$k]['content'] = mb_substr(strip_tags($v['content']),0,190,'utf-8');
		}
		$this->assign('dataList',$res);
		$this->display();
	}
	function add(){
		if($_POST){
			$_POST['ctime'] = time();
			$_POST['cid'] = 8;
			$res = D('goods')->add($_POST);
			if($res){
				$this->redirect('index');
			}
		}
		$this->display();
	}
	function del(){
		$res = D('goods')->where('id='.$_GET['id'])->delete();
		if($res){
			$this->redirect('index');
		}
	}
	function edit(){
		if($_POST){
			$res = D('goods')->where('id='.$_POST['id'])->save($_POST);
			if($res || !empty($_POST['id'])){
				$this->redirect('index');
			}
		}
		$res = D('goods')->where('id='.$_GET['id'])->find();
		$this->assign('dataInfo',$res);
		$this->display();
	}
}