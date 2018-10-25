<?php
namespace Admin\Controller;

/**
 * 后台首页
 *
 * @author Administrator
 *        
 */
class CompanyController extends CommController {
	public function _initialize() {
		parent::_initialize ();
		// 模型
		$this->model = D ( 'Company' );
		
	
	}

	/**
	 * 首页显示
	 */
	public function index() {
		$companyModel = D('Company');
		$userModel = D('User');
		$companyList = $companyModel
					->alias('c')
					->field('c.*,u.nickname')
					->join('left join db_user AS u ON u.company_id=c.id')
					->where('c.is_delete = 0')
					->select();
//		 dump($companyList);die;
		$this->assign('dataList',$companyList);
		// 渲染视图
		$this->display ();
	}

	public function aedit(){

		$id = I ( 'get.id', 0 );

		// 获取信息
		$dataInfo = $this->model->getOne ( $id );
		if ( $dataInfo['admin'] > 0 ) {
			$dataInfo['charge'] = D( 'User' )->getOne( $dataInfo['admin'], 'id', true, '*' );
	    }
		// 获取负责人
		if ( !empty( $dataInfo['admin'] ) ) {
			$classList = $this->getSelectClassList ( $dataInfo ['admin'] );
			$this->assign( 'classList', $classList );
		}else{
			$classList = $this->getSelectClassList (  );
			$this->assign( 'classList', $classList );
		}
		$this->assign ( 'dataInfo', $dataInfo );
		// 渲染视图
		$this->display();
	}
	function add(){
		if($_POST){
			if(D('company')->where(array('companyname'=>$_POST['companyname']))->find()){
				echo "<script language=\"JavaScript\">\r\n";
				echo " alert('公司已经存在');\r\n";
				echo " history.back();\r\n";
				echo "</script>";
				return false;
			}
			$_POST['addtime'] = time();
			$_POST['admin'] = 0;
			$add = D('company')->add($_POST);
			if($add){
				$id = D('company')->order('addtime desc')->find();
				D('user')->where(array('id'=>$_POST['admin']))->save(array('company_id'=>$id['id']));
				$this->redirect('index');
			}
		}
		$map['auth'] = 9;
//		$map['company_id'] = 0;
		$user = D('user')->where($map)->field('id,username,nickname')->select();
		$this->assign ( 'classList', $user );
		$this->display();
	}


	function edit(){
		if($_POST){
			$res = D('company')->where(array('id'=>$_POST['id']))->save($_POST);
			if($res){
					$this->redirect('index');
			}
		}
		$map['auth'] = 9;
		$user = D('user')->where($map)->field('id,username,nickname')->select();
		$com = $this->model->getOne ( $_GET['id'] );
		$data = D('user')->where('id='.$com['admin'])->field('id,username,nickname')->find();
		$this->assign ( 'classList', $user );//单位
		$this->assign ( 'data', $data );//
		$this->assign ( 'dataInfo', $com );
		$this->display();
	}

	function delete(){
		$res = D('company')->where('id='.$_GET['id'])->delete();
		if($res){
			$this->redirect('index');
		}
	}
	 /*
     * 编辑前
     */
    public function _before_update(){
        //更新用户表中单位id
        //
        
        
    }

	private function getSelectClassList( $admin ) {
		global $dataList;
		$tempInfo = D('User')->where(['is_delete'=>0])->getOne( $admin );
		// print_r($tempInfo);die;

		if ( count( $tempInfo ) == 0 ) {
			return D('User')->getList ( );
		}
		$tempList = D('User')->getList ( );
		for ( $i = 0, $size = count( $tempList ); $i < $size; $i ++ ) {
			$tempList[$i]['selected'] = $tempList[$i]['id'] == $admin ? ' selected="selected"' : '';
		}
	
		krsort( $tempList );
		return array_merge( $tempList );
	}


}