<?php
namespace Admin\Controller;

/**
 * 后台首页
 *
 * @author Administrator
 *        
 */
class MacController extends CommController {
	public function _initialize() {
        parent::_initialize ();
        // 模型
		$this->model = D('Mac');

    }

	/**
	 * 首页显示
	 */
	public function index() {
		if($this->user['auth'] == 1){
			$macList = $this->model->where(['is_delete'=>0])->order('mac_type desc')->select();
		}else{
			$macList = $this->model->where(['company_id'=>$this->user['company_id'],'is_delete'=>0])->order('mac_type desc')->select();
		}
		foreach($macList as $k=>$v){
			$macList[$k]['companyname'] = D('company')->where(array('id'=>$v['company_id']))->getField('companyname');
		}
		$this->assign('dataList',$macList);
		// 渲染视图
		$this->display ();
	}

	// public function _before_update()
	// {
	// 	$_POST['company_id'] = $this->getUserCompany()['company_id'];
	// }
	function add()
	{
		if($_POST){
			$_POST['company_id'] = ($this->user['auth'] != 1) ? $this->user['company_id'] : $_POST['company_id'];
			$_POST['department_id'] = 0;
				if(!empty($_POST['macs'])){
					$_POST['mac'] = $_POST['macs'];
					$res = D('mac')->add($_POST);
					if($res){
						$this->redirect('index');
					}
				}
			$res = D('mac')->add($_POST);
			if($res){
				$this->redirect('index');
			}
		}
		if($this->user['auth'] == 1){
			$company = D('company')->field('id,companyname')->select();
			$this->assign('company',$company);
		}
		$this->display();
	}
	function del()
	{
		$res =  D('mac')->where('id='.$_GET['id'])->delete();
		if($res){
			$this->redirect('index');
		}
	}

	function edit(){
		if($_POST){
			$map['id'] = $_POST['id'];
			$res = D('mac')->where($map)->save($_POST);
			if($res || !empty($_POST['id'])){
				$this->redirect('index');
			}
		}
		$res = D('mac')->where('id='.$_GET['id'])->find();
		$this->assign('dataInfo',$res);
		$this->display();
	}
	public function _before_create()
	{
		$_POST['company_id'] = $this->getUserCompany()['company_id'];
		// print_r($_POST);die;
	}


}