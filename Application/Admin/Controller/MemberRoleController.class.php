<?php
namespace Admin\Controller;

/**
 * 后台管理-会员群组控制器
 * 
 * @author Administrator
 *        
 */
class MemberRoleController extends CommController {
	
	public function _initialize() {
		parent::_initialize();
		// 模型
		$this->model = D( 'MemberRole' );
		// 参数
		$this->paramter['pid'] = I( 'get.pid', 0 );
	}
	
	/**
	 * 管理员群组列表
	 */
	public function index() {		
		// 获取参数
		$this->paramter['parent_id'] = $this->model->getOne ( $this->paramter['pid'], 'id', false, 'pid' );
		
		// 设置查询条件
		$field = "a.id,a.pid,a.title,a.intro,a.create_time,a.status,a.sort";
		$field .= ",b.title as parent_title";
		
		$sql = "select $field from db_member_role as a";
		$sql .= " left join db_member_role as b on a.pid = b.id";
		$sql .= " where 1=1";
		$sql .= " and a.pid = {$this->paramter['pid']} and a.is_delete = 0";
		
		// 读取数据
		$this->dataList = $this->getPageSQLList( $this->model, $sql );
		
		// 注入数据
		$this->assign( "paramter", $this->paramter );
		$this->assign( "dataList", $this->dataList );
		
		// 渲染视图
		$this->display ();
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
		$auth = $this->model->getOne( $theId, 'id', false, 'auth' );
		// 群组id
		$this->assign( "id", I( 'get.id', 0 ) );
		// 获取节点
		$this->assign( 'nodeList', D( 'MemberNode' )->authNodeList( $auth ) );
		// 渲染视图
		$this->display ();
	}
	
	/**
	 * 设置授权
	 */
	public function auth_save() {
		$_POST['auth'] = empty( $_POST['auth'] ) ? "" : ",". implode( ",", $_POST['auth'] ) .",";
		$return = $this->model->auth_save ( $_POST );
		$this->dwzSuccess ( $return ['info'], $return ['status'], 'userrole', 'refreshClose' );
	}
}