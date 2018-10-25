<?php
namespace Admin\Controller;

/**
 * 后台管理-管理员群组控制器
 * 
 * @author Administrator
 *        
 */
class UserRoleController extends CommController {
	
	public function _initialize() {
		parent::_initialize();
		// 模型
		$this->model = D( 'UserRole' );
		// 参数
		$this->paramter['pid'] = I( 'request.pid', 0 );
	}
	
	/**
	 * 管理员群组列表
	 */
	public function index() {		
		// 获取参数
//		$this->paramter['parent_id'] = $this->model->getOne ( $this->paramter['pid'], 'id', false, 'pid' );
//		$this->paramter['title'] = I( 'post.title', '' );
//
//		// 设置查询条件
//		$field = "a.id,a.pid,a.title,a.intro,a.create_time,a.status,a.sort";
//		$field .= ",b.title as parent_title";
//
//		$sql = "select $field from db_user_role as a";
//		$sql .= " left join db_user_role as b on a.pid = b.id";
//		$sql .= " where 1=1";
//		$sql .= " and a.pid = {$this->paramter['pid']} and a.is_delete = 0";
//		// 群组名称
//		if ( !empty( $this->paramter['title'] ) ) {
//			$sql .= " and a.title like '%{$this->paramter['title']}%'";
//		}
//
//		// 读取数据
//		$this->dataList = $this->model->getSQLList( $sql, array( 'begin' => 0, 'num' => 0 ) );
		if($_POST['personal_code']){
			$map['personal_code'] = $_POST['personal_code'];
		}
		if($_POST['tel']){
			$map['username'] = $_POST['tel'];
		}
		$map['auth'] = array('gt',0);
		if($this->user['auth'] != 1){
			$map['cid'] = $this->getUserCompany()['company_id'];
		}
		$field = 'id,username,nickname,cid,department_id,personal_code,auth,status,create_time';
		$dataList = D('member')->where($map)->field($field)->order('create_time desc')->select();
		foreach($dataList as $k=>$v){
			$dataList[$k]['cid'] = D('company')->where('id='.$v['cid'])->getField('companyname');
			$dataList[$k]['department_id'] = D('department')->where('id='.$v['department_id'])->getField('department_name');
			if($v['auth'] == 1){
				$dataList[$k]['auth'] = '一级审批人';
			}elseif($v['auth'] == 2){
				$dataList[$k]['auth'] = '二级审批人';
			}elseif($v['auth'] == 5){
				$dataList[$k]['auth'] = '人力资源';
			}elseif($v['auth'] == 4){
				$dataList[$k]['auth'] = '抄送人';
			}
		}
//		dump($dataList);exit;
		$this->assign('dataList',$dataList);
		// 注入数据
//		$this->assign( "paramter", $this->paramter );
//		$this->assign( "dataList", $this->dataList );
		
		// 渲染视图
		$this->display ();
	}
	function edit(){
		$id = $_GET['id'];
		if($_POST){
			$id = $_POST['id'];
			if($_POST['auth'] == 0){
				$_POST['range_time'] = 0;
			}elseif($_POST['auth'] == 1){
				$_POST['range_time'] = 24;
			}elseif($_POST['auth'] == 2){
				$_POST['range_time'] = 48;
			}elseif($_POST['auth'] == 3){
				$_POST['range_time'] = 72;
			}
			$res = D('member')->where('id='.$id)->save($_POST);
			if($res){
				$this->redirect('index');
			}
		}
		$res = D('member')->where('id='.$id)->find();
		$res['company'] = D('company')->where('id='.$res['cid'])->getField('companyname');
		$res['department'] = D('department')->where('id='.$res['department_id'])->getField('department_name');
		$company = D('company')->field('id,companyname')->select();
		$department = D('department')->field('id,department_name')->select();
		$this->assign('company',$company);
		$this->assign('department',$department);
		$this->assign('res',$res);
		$this->assign('id',$id);
		$this->display();

	}
	function update(){
		$id = $_POST['id'];
		$level = $_POST['level'];
//		dump($id);
		D('member')->where('id='.$id)->save(array('auth'=>$level));
	}
	function del()
	{
		$res = D('member')->where('id='.$_GET['id'])->delete();
		if($res){
			$this->redirect('index');
		}
	}
	function status()
	{
		$id = $_GET['id'];
		$status['status'] = $_GET['status'];
		$res = D('member')->where('id='.$id)->save($status);
		if($res){
			$this->redirect('index');
		}
	}
	/**
	 * 添加管理员群组-前置
	 */
	public function _before_add() {
		$this->assign( "paramter", $this->paramter );
	}
	
	/**
	 * 权限列表
	 */
	public function auth() {
		$theId = I( 'get.id', 0 );
		$authInfo = $this->model->getOne( $theId, 'id' );
		// 群组id
		$this->assign( "authInfo", $authInfo );
		// 获取节点
		$nodeList = D( 'UserNode' )->authNodeList( $authInfo['auth'] );
		/* print_r( $nodeList );
		die(); */
		$this->assign( 'nodeList', json_encode( $nodeList ) );
		// 渲染视图
		$this->display ();
	}
	
	/**
	 * 设置授权
	 */
	public function auth_save() {
		$returnMsg = $this->model->auth_save ( $_POST );
		$this->HuiMsg( $returnMsg );
	}
}