<?php
namespace Admin\Controller;

/**
 * 后台管理-前台菜单分组控制器
 * 
 * @author Administrator
 *        
 */
class MemberGroupController extends CommController {
	
	public function _initialize() {
		parent::_initialize();
		// 模型
		$this->model = D( 'MemberGroup' );
		// 参数
		$this->paramter['pid'] = I( 'get.pid', 0 );
	}
	
	/**
	 * 菜单分组列表
	 */
	public function index() {		
		// 获取参数
		$this->paramter['parent_id'] = $this->model->getOne ( $this->paramter['pid'], 'id', false, 'pid' );
		
		// 设置查询条件
		$field = "a.id,a.pid,a.title,a.name,a.intro,a.inherit,a.icon,a.create_time,a.status,a.sort";
		$field .= ",b.title as parent_title";
		
		$sql = "select $field from db_member_group as a";
		$sql .= " left join db_member_group as b on a.pid = b.id";
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
	 * 添加菜单分组-前置
	 */
	public function _before_add() {
		$this->assign( "paramter", $this->paramter );
	}
}