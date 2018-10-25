<?php
namespace Admin\Controller;

/**
 * 首页幻灯
 *
 * @author BoBo
 *        
 */
class LinkController extends CommController {
	
	/**
	 * 构造函数
	 */
	public function _initialize() {
		parent::_initialize();
		// 模型
		$this->model = D( 'Link' );
	}

	/**
	 * 幻灯列表
	 */
	public function index() {
		// 获取参数
//		$this->paramter ['title'] = I ( 'post.title', '' );
//		$this->paramter ['start_time'] = I ( 'post.start_time', '' );
//		$this->paramter ['end_time'] = I ( 'post.end_time', '' );
//		// 设置[默认]查询条件
//		$condition ['is_delete'] = 0;
//		// 标题
//		if (! empty ( $this->paramter ['title'] )) {
//			$condition ['title'] = array ("like","%{$this->paramter['title']}%" );
//		}
//		// 日期范围
//		if (! empty ( $this->paramter ['start_time'] ) || ! empty ( $this->paramter ['end_time'] )) {
//			$condition ['create_time'] = array ('between',array (strtotime ( $this->paramter ['start_time'] ),strtotime ( $this->paramter ['end_time'] ) ) );
//		} else if (! empty ( $this->paramter ['start_time'] )) {
//			$start_time = strtotime ( $this->paramter ['start_time'] );
//			$end_time = strtotime ( date ( $this->paramter ['start_time'], strtotime ( '+1 day' ) ) ) - 1;
//			$condition ['create_time'] = array ('between',array ($start_time,$end_time ) );
//		} else if (! empty ( $this->paramter ['end_time'] )) {
//			$start_time = strtotime ( $this->paramter ['end_time'] );
//			$end_time = strtotime ( date ( $this->paramter ['end_time'], strtotime ( '+1 day' ) ) ) - 1;
//			$condition ['create_time'] = array ('between',array ($start_time,$end_time ) );
//		}
		// 获取幻灯列表
//		$dataList = $this->model->getList ( $condition );
		if($this->user['auth'] != 1){
			$map['company_id'] = $this->user['company_id'];
		}
		$dataList = $this->model->where($map)->select();
		foreach($dataList as $k=>$v){
			$dataList[$k]['companyname'] = D('company')->where(array('id'=>$v['company_id']))->getField('companyname');
		}
		$this->assign ( 'dataList', $dataList );
		$this->assign ( 'cid', $this->user['company_id'] );
		// 渲染模板
		$this->display ();
	}
	function add(){
		if($_POST){
			if($this->user['auth'] != 1){
				$_POST['company_id'] = $this->user['company_id'];
			}
			$_POST['create_time'] = time();
			$res = D('link')->add( $_POST );
			if ($res) {
				$this->redirect('index');
			}
		}
		if($this->user['auth'] == 1){
			$company = D('company')->field('id,companyname')->select();
			$this->assign('company',$company);
		}
		$this->display();
	}
	function edit(){
		if($_POST){
			$res = D('link')->where('id='.$_POST['id'])->save($_POST);
			if($res || !empty($_POST['id'])){
				$this->redirect('index');
			}
		}
		$res = D('link')->where('id='.$_GET['id'])->find();
		$this->assign('dataInfo',$res);
		$this->display();
	}
	function del(){
		$res = D('link')->where('id='.$_GET['id'])->delete();
		if($res){
			$this->redirect('index');
		}
	}

	/*
   * 单位通知
   */
	public function main() {
		// 设置模型
		$article = D( 'Article' );
		$search = array();
		$condition['is_delete'] = 0;
		$condition['pid'] = 15;
		if($this->user['auth'] != 1){
			$condition['cid'] = $this->user['company_id'];
		}
		if(I('post.title')){
			$search['title'] = I('post.title');
			$condition['title'] = array('like','%'.$search['title'].'%');
		}
		// 获取数据
//        $dataList = $article->format( $this->getPageList( $article, $condition, 20 ) );
//        //得到每条信息的上级分类，拥有权限操作的会员
//        foreach ($dataList as $ke=>$val){
//            $dataList[$ke]['type'] = D('Category')->where(array('id'=>$val['pid']))->getField('title');
//        }
		$dataList = $article->where($condition)->order('create_time desc')->order('cid')->select();
		foreach($dataList as $k=>$v){
			$dataList[$k]['companyname'] = D('company')->where(array('id'=>$v['cid']))->getField('companyname');
			$dataList[$k]['content'] = mb_substr(strip_tags($v['content']),0,120,'utf-8');
		}
		// 注入变量
		$this->assign( 'search', $search );
		$this->assign( 'type', '单位通知');
		$this->assign( 'dataList', $dataList );

		// 渲染模版
		$this->display();
	}
	function addInfo()
	{
		if($_POST){
			$_POST['pid'] = 15;
			$_POST['create_time'] = time();
			if($this->user['auth'] != 1){
				$_POST['cid'] = $this->user['company_id'];
			}
			$res = D('Article')->add($_POST);
			if($res){
				$this->redirect('main');
			}
		}
		if($this->user['auth'] == 1){
			$company = D('company')->field('id,companyname')->select();
			$this->assign('company',$company);
		}
		$this->display();
	}
	function editInfo(){
		if($_POST){
			$res = D('Article')->where('id='.$_POST['id'])->save($_POST);
			if($res || !empty($_POST['id'])){
				$this->redirect('main');
			}
		}
		$res = D('Article')->where('id='.$_GET['id'])->find();
		$this->assign('info',$res);
		$this->display();
	}
	function delInfo(){
		$res = D('Article')->where('id='.$_GET['id'])->delete($_POST);
		if($res){
			$this->redirect('main');
		}
	}

	/**
	 * 资讯列表
	 */
	public function guide() {
		// 设置模型
		$article = D( 'Article' );
		$search = array();
		$condition['is_delete'] = 0;
		$condition['pid'] = 16;
//        $condition['cid'] = $this->getUserCompany()['id'];
		if(I('post.title')){
			$search['title'] = I('post.title');
			$condition['title'] = array('like','%'.$search['title'].'%');
		}
		// 获取数据
//        $dataList = $article->format( $this->getPageList( $article, $condition, 20 ) );

		//得到每条信息的上级分类，拥有权限操作的会员
//        foreach ($dataList as $ke=>$val){
//            $dataList[$ke]['type'] = D('Category')->where(array('id'=>$val['pid']))->getField('title');
//        }
		if($this->user['auth'] != 1){
			$condition['cid'] = $this->user['company_id'];
		}
		$dataList = $article->where($condition)->select();
		foreach($dataList as $k=>$v){
			$dataList[$k]['companyname'] = D('company')->where(array('id'=>$v['cid']))->getField('companyname');
			$dataList[$k]['content'] = mb_substr(strip_tags($v['content']),0,90,'utf-8');
		}
		// 注入变量
		$this->assign( 'search', $search );
		$this->assign( 'type', '资讯列表');
		$this->assign( 'cid', $this->user['company_id']);
		$this->assign( 'dataList', $dataList );
		// 渲染模版
		$this->display();
	}
	function addGuide()
	{
		if($_POST){
			$_POST['pid'] = 16;
			if($this->user['auth'] != 1){
				$_POST['cid'] = $this->user['company_id'];
			}
			$_POST['create_time'] = time();
			$res = D('Article')->add( $_POST );
			if ($res) {
				$this->redirect('guide');
			}
		}
		if($this->user['auth'] == 1){
			$company = D('company')->field('id,companyname')->select();
			$this->assign('company',$company);
		}
		$this->display();
	}
	function delGuide(){
		$res = D('Article')->where('id='.$_GET['id'])->delete();
		if($res){
			$this->redirect('guide');
		}
	}
	function editGuide(){
		if($_POST){
			$res = D('Article')->where('id='.$_POST['id'])->save($_POST);
			if($res || !empty($_POST['id'])){
				$this->redirect('guide');
			}
		}
		$res = D('Article')->where('id='.$_GET['id'])->find();
		$this->assign('dataInfo',$res);
		$this->display();
	}

	function notice()
	{
		if(I('post.title')){
			$search['title'] = I('post.title');
			$condition['title'] = array('like','%'.$search['title'].'%');
		}
		$condition['pid'] = 17;
		$notice = D('Article')->where($condition)->select();
		$this->assign( 'notice', $notice );
		$this->display();
	}

	function addNotice()
	{
		if($_POST){
			$_POST['pid'] = 17;
			$_POST['cid'] = $this->user['company_id'];
			$_POST['create_time'] = time();
			$res = D('Article')->add( $_POST );
			if ($res) {
				$this->redirect('notice');
			}
		}
		if($this->user['auth'] == 1){
			$company = D('company')->field('id,companyname')->select();
			$this->assign('company',$company);
		}
		$this->display();
	}

	function editNotice(){
		if($_POST){
			$res = D('Article')->where('id='.$_POST['id'])->save($_POST);
			if($res || !empty($_POST['id'])){
				$this->redirect('notice');
			}
		}
		$res = D('Article')->where('id='.$_GET['id'])->find();
		$this->assign('info',$res);
		$this->display();
	}

	function delNotice(){
		$res = D('Article')->where('id='.$_GET['id'])->delete();
		if($res){
			$this->redirect('notice');
		}
	}
}