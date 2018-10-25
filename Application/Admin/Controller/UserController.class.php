<?php
namespace Admin\Controller;

/**
 * 管理员控制器
 * 
 * @author BoBo
 *        
 */
class UserController extends CommController {
	
	/**
	 * 构造函数
	 */
	public function _initialize() {
		parent::_initialize();
		// 模型
		$this->model = D( 'User' );
		// 参数
		$this->paramter['auth'] = I( 'post.auth', 0 );
		// 权限群组
		$this->getRoleList();
	}
	
	/**
	 * 管理员列表
	 */
	public function index() {
		// 获取参数
//		$this->paramter['username'] = I( 'post.username', '' );
//		$this->paramter['nickname'] = I( 'post.nickname', '' );
//		$this->paramter['start_time'] = I( 'post.start_time', '' );
//		$this->paramter['end_time'] = I( 'post.end_time', '' );
//		// 设置查询条件
//		$field = "a.id,a.username,a.nickname,a.intro,a.status,a.create_time,a.last_login_time,a.last_login_ip,a.sort";
//		$field .= ",b.title as auth_title";
//
//		$sql = "select $field from db_user as a";
//		$sql .= " left join db_user_role as b on a.auth = b.id";
//		$sql .= " where 1=1 and a.id <> 1 and a.is_delete = 0 ";
//		// 群组
//		if ( !empty( $this->paramter['auth'] ) ) {
//			$sql .= " and a.auth = {$this->paramter['auth']}";
//		}
//		// 用户名
//		if ( !empty( $this->paramter['username'] ) ) {
//			$sql .= " and a.username like '%{$this->paramter['username']}%'";
//		}
//		// 真实姓名
//		if ( !empty( $this->paramter['nickname'] ) ) {
//			$sql .= " and a.nickname like '%{$this->paramter['nickname']}%'";
//		}
//		// 日期范围
//		if ( !empty( $this->paramter['start_time'] ) || !empty( $this->paramter['end_time'] ) ) {
//			$sql .= " and a.create_time between ".strtotime($this->paramter['start_time'])." and ".strtotime($this->paramter['end_time'])."";
//		} else if ( !empty( $this->paramter['start_time'] ) ) {
//			$start_time = strtotime( $this->paramter['start_time'] );
//			$end_time = strtotime( date( $this->paramter['start_time'], strtotime('+1 day') ) ) - 1;
//			$sql .= " and a.create_time between $start_time and $end_time";
//		} else if ( !empty( $this->paramter['end_time'] ) ) {
//			$start_time = strtotime( $this->paramter['end_time'] );
//			$end_time = strtotime( date( $this->paramter['end_time'], strtotime('+1 day') ) ) - 1;
//			$sql .= " and a.create_time between $start_time and $end_time";
//		}
//
//		// 读取数据
//		$this->dataList = $this->model->getSQLList( $sql, array( 'begin' => 0, 'num' => 0 ) );
//		dump($this->dataList );exit;
		// 注入数据
		if($_POST['nickname']){
			$map['nickname'] = $_POST['nickname'];
		}
		$map['company_id'] = array('gt',0);
		$field = 'u.id,u.username,u.password,u.nickname,u.address,u.create_time,u.phone,u.last_login_time,u.last_login_ip,c.companyname';
		$user = D('user')->alias('u')->join('left join db_company as c on c.id = u.company_id')->field($field)->where($map)->select();
		$this->assign( "paramter", $this->paramter);
		$this->assign( "dataList", $user);
		// 渲染视图
		$this->display ();
	}
	function del(){
		$res = D('user')->where('id='.$_GET['id'])->delete();
		if($res){
			D('company')->where('admin='.$_GET['id'])->save(array('admin'=>0));
			$this->redirect('index');
		}
	}
	function add(){
		if($_POST){
			if(empty($_POST['company_id'])){
				echo "<script language=\"JavaScript\">\r\n";
				echo " alert('请选择单位');\r\n";
				echo " history.back();\r\n";
				echo "</script>";
				return false;
			}
			$_POST['auth'] = 9;
			$_POST['create_time'] = time();
			$_POST['password'] = sha1($_POST['password']);
			$res = D('user')->add($_POST);
			if($res){
				D('company')->where('id='.$_POST['company_id'])->save(array('admin'=>$res));
				$this->redirect('index');
			}
		}
		$res = D('company')->where('admin=0')->field('id,companyname')->select();
		$this->assign('roleList',$res);
		$this->display();
	}


	function edit(){
		if($_POST){
//			dump($_POST);exit;
			$res = D('user')->where('id='.$_POST['id'])->save($_POST);
			if($res){
				$this->redirect('index');
			}
		}
		$res = D('user')->where('id='.$_GET['id'])->find();
		$res['companyname'] = D('company')->where('id='.$res['company_id'])->getField('id,companyname');
		$com = D('company')->select();
		$this->assign('company',$com);
		$this->assign('dataInfo',$res);
		$this->display();
	}

	function pass()
	{
		if($_POST['id']){
			$data['password'] = sha1($_POST['password']);
			$res = D('user')->where(array('id'=>$_POST['id']))->save($data);
			if($res){
				echo "<script language=\"JavaScript\">\r\n";
				echo " alert('修改成功');\r\n";
				echo "</script>";
				$this->redirect('index');
			}
		}
		$this->assign('dataInfo',$_GET);
		$this->display();
	}
	/**
	 * 获取权限群组列表
	 */
	private function getRoleList() {
		$roleList = D( 'UserRole' )->getList( array( 'is_delete' => 0 ), "id,title" );
		$this->assign( "roleList", $roleList );
	}
	
	/**
	 * 密码修改
	 */
	public function passs() {
		$tag = I( 'get.tag', '' );
		if ( $tag == "update" ) {
			$returnMsg = $this->model->pass_edit ( $_POST );
			$this->HuiMsg( $returnMsg );
		} else {
			$theId = I( 'request.id', 0 );
			$return = $this->model->getCommOne ( $theId );
			if ($return ['status']) {
				$this->assign ( 'dataInfo', $return ['info'] );
			} else {
				die( $return['info'] );
			}
			$this->display (); 
		}
	}
	
	/**
	 * 修改个人密码
	 */
	public function uppwd() {
		if (IS_POST) {
			$returnMsg = returnMsg();
			if (sha1 ( $_POST ['oldpwd'] ) != $this->user ['password'] ){
//				$returnMsg['info'] = "旧密码填写有误!";
				echo "<script language=\"JavaScript\">\r\n";
				echo " alert('旧密码填写有误!');\r\n";
				echo " history.back();\r\n";
				echo "</script>";
				return false;
			} else if ( $_POST ['newpwd'] != $_POST ['confimpwd'] || empty ( $_POST ['newpwd'] ) || empty ( $_POST ['confimpwd'] ) ) {
//				$returnMsg['info'] = "新密码填写不一致!";
				echo "<script language=\"JavaScript\">\r\n";
				echo " alert('密码不一致!');\r\n";
				echo " history.back();\r\n";
				echo "</script>";
				return false;
			} else {
//				$newArray['id'] = $this->user['id'];
				$pass['password'] = sha1($_POST['newpwd']);
				$res = D('user')->where('id='.$this->user['id'])->save($pass);
//				$returnMsg = $this->model->uppwd( $newArray );
				$host ="http://".$_SERVER['HTTP_HOST']."/admin/login";
				if($res){
					echo "<script language=\"JavaScript\">\r\n";
					echo " alert('修改成功!');\r\n";
					echo "</script>";
					exit('<script language="JavaScript">top.location.href="'.$host.'"</script>');
				}
			}
			$this->HuiMsg( $returnMsg );
		}
		$this->display ();
	}
	
	/**
	 * 查看个人详情
	 */
	public function show() {
		$theId = I( 'get.id', 0 );
		if ( !empty( $theId ) ) {
			$this->user = $this->model->getOne( $theId, 'id' );
		}
		$this->user['authName'] = D( 'UserRole' )->getOne( $this->user['auth'], 'id', false, 'title' );
		$this->assign( 'userAuth', $this->user );
		// 渲染模板
		$this->display();
	}

	// public function _before_create(){
 //        $_POST['company_id'] = $this->getUserCompany()['id'];
 //    }
}