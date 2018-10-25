<?php
namespace Admin\Controller;

/*
 * 新闻动态
 */
class ArticleController extends CommController {
    public function _initialize() {
        parent::_initialize ();
        // 模型
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
            $dataList[$k]['content'] = mb_substr($v['content'],0,90,'utf-8');
        }
        // 注入变量
        $this->assign( 'search', $search );
        $this->assign( 'cid', $this->user['company_id']);
        $this->assign( 'dataList', $dataList );
        // 渲染模版
        $this->display();
    }
    function add()
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
    function del(){
        $res = D('Article')->where('id='.$_GET['id'])->delete();
        if($res){
            $this->redirect('guide');
        }
    }
    function edit(){
        if($_POST){
//            dump($_POST);exit;
            $res = D('Article')->where('id='.$_POST['id'])->save($_POST);
            if($res){
                $this->redirect('guide');
            }
        }
//        if($this->user['auth'] == 1){
//            $company = D('company')->field('id,companyname')->select();
//            $this->assign('company',$company);
//        }
        $res = D('Article')->where('id='.$_GET['id'])->find();
        $this->assign('dataInfo',$res);
        $this->display();
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
        $dataList = $article->where($condition)->select();
        foreach($dataList as $k=>$v){
            $dataList[$k]['companyname'] = D('company')->where(array('id'=>$v['cid']))->getField('companyname');
            $dataList[$k]['content'] = mb_substr($v['content'],0,90,'utf-8');
        }
        // 注入变量
        $this->assign( 'search', $search );
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
            if($res){
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
    * 显示编辑页面
    */
    public function edits() {
           $id = I ( 'get.id' );
           $model = D ('Article');
           $return = $model->getCommOne ( $id );
           //获取顶级权限名称
           $condtion['is_delete'] = 0;
           $condtion['status'] = 0;
           $condtion['pid'] = $return['info']['auth'];
           //无限查询出他的父级，直到父级为0
           $this->getLastList($return['info']['auth']);
           $dataList = $this->authArr;
           $firstList = D('MemberRole')->where($condtion)->select();
           if ($return ['status']) {
                   $this->assign ( 'dataInfo', $return ['info'] );
           } else {
                   die ( $return ['info'] );
           }
           krsort($dataList);//将得到的数组倒序排列
           $this->assign( 'role', D('MemberRole')->getMultiSelect(0,0,$return['info']['auth']) );
           $this->assign('dataList',$dataList);
           $this->assign ( 'firstList', $firstList );
           $this->display ();
    }
    /*
     * 添加
     */
    public function _before_create(){
		$_POST['create_time'] = time();
        $_POST['cid'] = $this->getUserCompany()['id'];
    }
    /*
     * 编辑前
     */
    public function _before_update(){
        if($_POST['role']){
            $auth = '|';
            foreach ($_POST['role'] as $v){
                $auth .= $v.'|';
            }
            $_POST['auth'] = $auth;
        }
        
    }
    /*
     * 无限级分类查询。直到为最低级
     */
    public $ids = array();
    public function getLowEst($id){
        $is_exits = D('Category')->where(array('pid'=>$id,'is_delete'=>0,'status'=>0))->select();
        if($is_exits){
            foreach ($is_exits as $val){
                $this->getLowEst($val['id']);
            }    
        }else{
            $this->ids[] = $id;
        }
    }
    /*
     * 根据ID获取会员下级信息
     */
    public function getNextList(){
        $pid = I('post.pid');
        if($pid){
        $condtion['is_delete'] = 0;
        $condtion['status'] = 0;
        $condtion['pid'] = $pid;
        $dataList = D('MemberRole')->where($condtion)->select();
        if(!$dataList){
            $dataList = 0 ;
        }
        echo json_encode($dataList);
        }else{
            echo json_encode('0');
        }
    }
    /*
     * 无限查询出所有父级
     */
    public $authArr = array();
    protected function getLastList($auth){
        $condtion['is_delete'] = 0;
        $condtion['status'] = 0;
        $condtion['id'] = $auth;
        $dataInfo = D('MemberRole')->where($condtion)->find();
        if($dataInfo){
            $newCondition['is_delete'] = 0;
            $newCondition['status'] = 0;
            $newCondition['pid'] = $dataInfo['pid'];
            $dataList = D('MemberRole')->where($newCondition)->select();//得到他的同级信息
            foreach ($dataList as $key=>$val){
                $dataList[$key]['this'] = $dataInfo['id'];
            }
            $this->authArr[] = $dataList;
            $this->getLastList($dataInfo['pid']);
        }
    }
}