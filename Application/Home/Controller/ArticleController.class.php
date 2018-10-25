<?php

namespace Home\Controller;

/**
 * 文章业务逻辑层
 *
 * @author Administrator
 *        
 */
class ArticleController extends CommController {
	protected  $pageSize = 10;
	// 列表
    public function index(){
    	// 设置模型
    	$categoryModel = D( 'Category' );
    	$articleModel = D( 'Article' );
    	
    	// 设置查询条件
    	$condition = array();
    	$condition['is_delete'] = 0;
    	$condition['status'] = 0;
    	// 设置搜索参数
    	$search = I( 'get.search', '' );
    	if ( $search != '' ) {
    		$condition['title'] = array( 'like', "%". urldecode( $search ) ."%" );
    	}
    	
    	// 判断并获取当前id的详细信息
    	$thisId = I('get.pid');
    	if ($thisId > 0) {
    		$condition['pid'] = $thisId;
    	}
    	
    	// 获取数据列表
    	$order = array('recommend'=>'desc','sort'=>'desc','create_time'=>'desc');
    	$this->dataList = $this->getPdList( $articleModel, $condition, $this->pageSize,'*',$order);
    	$this->thisSort = D( 'Category' )->where(array('id'=>$thisId))->find();
    	// 注入数据
    	$this->assign( 'thisSort', $this->thisSort );
    	$this->assign( 'dataList', $this->dataList );
    	$this->assign( 'columnTitle', $this->thisSort['title'] );
    	
    	// 渲染模板
    	$this->display();
    }
    
	// 详情显示
    public function show(){
    	// 实例化模型
    	$articleModel = D( 'Article' );
    	
    	// 判断id是否为空或不为数字
    	if ( I('get.id') < 1) {
    		$this->error( '非法操作!' );
    	}else{
    		$this->theId = I('get.id');
    	}
    	//添加访问量
    	$articleModel->where(array('id'=>$this->theId))->setInc('visit',1);
    	// 获取数据
    	$this->dataInfo = $articleModel->getOne( $this->theId );
    	$totalratting = D('ArticleRatting')->where(array('pid'=>$this->theId))->count();
    	// 判断数据是否存在
    	$totalratting = $totalratting ? $totalratting : 0;
    	if ( count( $this->dataInfo ) == 0 || !$this->dataInfo) {
    		$this->error( '数据不存在!' );
    	}   	
    	// 类别信息
    	$this->thisSort = D( 'Category' )->where(array('id'=>$this->dataInfo['pid']))->find();
    	$this->assign( 'thisSort', $this->thisSort );
    	
    	// SEO关键字
    	$this->formatKeyword( $this->dataInfo, $this->thisSort );
    	
    	// 获取文章评论
    	$field = "a.id,a.evaluate_id,a.reply_id,a.content,a.create_time,";
    	$field .= "b.nickname,b.wx_name,b.face";
    	$sql = "select $field from db_article_reply as a";
    	$sql .= " left join db_member as b on a.evaluate_id = b.id";
    	$sql .= " where a.article_id = {$this->dataInfo['id']} and a.reply_id = 0 and a.theme_id = 0 and a.status = 0 and a.is_delete = 0";
    	$sql .= " order by a.create_time desc";
    	$commentList = M( 'ArticleReply' )->query( $sql );
    	$field .= ",d.nickname as reply_nickname,d.wx_name as reply_wx_name,b.face as reply_face";
    	foreach ( $commentList as $key => $rows ) {
    		$sql = "select $field from db_article_reply as a";
    		$sql .= " left join db_member as b on a.evaluate_id = b.id";
    		$sql .= " left join db_article_reply as c on a.reply_id = c.id";
    		$sql .= " left join db_member as d on c.evaluate_id = d.id";
    		$sql .= " where a.article_id = {$this->dataInfo['id']} and a.theme_id = {$rows['id']} and a.reply_id > 0 and a.status = 0 and a.is_delete = 0";
    		$sql .= " order by a.create_time asc";
    		$commentList[$key]['child'] = M( 'ArticleReply' )->query( $sql );
    	}
    	/* echo "<pre>";
    	print_r($commentList);die(); */
    	$this->assign( 'commentList', $commentList );
    	
    	// 注入数据
    	$this->assign( 'dataInfo', $this->dataInfo );
    	$this->assign( 'totalratting', $totalratting );
    	$this->assign( 'columnTitle', $this->thisSort['title']);
    	
    	// 渲染模板
    	$this->display();
    }
    //异步加载新闻
    public function  ajaxIndex(){
    	$articleModel = D( 'Article' );
    	// 设置查询条件
    	$condition = array();
    	$condition['is_delete'] = 0;
    	$condition['status'] = 0;
    	// 判断并获取当前id的详细信息
    	$thisId = I('get.pid');
    	$page = I('get.page',1);
    	if ($thisId > 0) {
    		$condition['pid'] = $thisId;
    	}
    	 
    	// 获取数据列表
    	$order = array('recommend'=>'desc','sort'=>'desc','create_time'=>'desc');
    	$this->dataList = $articleModel->where($condition)->order($order)->limit(($page-1)*$this->pageSize.','.$this->pageSize)->select();
    	$this->assign( 'dataList', $this->dataList );
    	$this->display();
    }
    //点赞
    public function goodjob(){
    	$this->checkLogin ();
    	$outPut = array('status'=>0,'info'=>'','url'=>'');
    	$id = I('post.id');
    	$today = strtotime(date('Ymd'));
    	$data['mid'] = $this->member['id'];
    	$data['pid'] = $id;
    	$lastInfo = D('ArticleRatting')->where($data)->order('create_time desc')->find();
    	if($lastInfo['create_time'] > $today){
    		$outPut['info'] =  '今天您已经点过赞了。明天再来!';
    	}else{
    		$data['create_time'] = time();
    		if(D('ArticleRatting')->add($data)){
    			$outPut['info'] =  '点赞成功!';
    			$outPut['status'] = 1;
    		}else{
    			$outPut['info'] =  '点赞失败，请联系管理员';
    		}
    	}
    	$this->ajaxReturn($outPut);
    }
    
    /**
     * 提交文章回复/评论
     */
    public function addComments() {
    	$this->checkLogin();
    	if ( IS_AJAX && IS_POST ) {
    		$return = returnMsg();
    		$data = I( 'post.' );
    		$data['create_time'] = time();
    		$data['evaluate_id'] = $this->member['id'];
    		$model = M( 'ArticleReply' );
    		if ( $model->create( $data ) && $model->add( $data ) ) {
    			$return['status'] = 1;
    			$return['info'] = '评论成功';
    		} else {
    			$return['info'] = '评论失败';
    		}
    		$this->ajaxReturn( $return );
    	} else {
    		$this->error( '非法访问' );
    	}
    }
}