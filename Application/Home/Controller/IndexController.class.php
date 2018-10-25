<?php
namespace Home\Controller;

/**
 * 首页控制器
 *
 * @author 
 *        
 */
class IndexController extends CommController {
	public function _initialize() {
		parent::_initialize ();
		$this->checkLogin ();

	}

	/**
	 * 首页显示
	 */
	public function index() {
		// $this->redirect("http://{$_SERVER ['HTTP_HOST']}/WeiXin/index");
//		$page = array();
//		$page['pageNum'] = 1;
//		if ( IS_AJAX && IS_POST ) {
//			$page['page'] = I( 'post.page', 1 );
//		} else {
//			$page['page'] = 1;
//			$page['recordTotal'] = D("Article")->getListCount( $condition );
//		}
//		$begin = ( $page['page'] - 1 ) * $page['pageNum'];
//		// 幻灯
//		$slideCondition = array ('status' => 0,'is_delete' => 0 );
//		$slideList = D ( 'Link' )->getList ( $slideCondition, 'title,picture,link' );
//		$this->assign( 'slideList', $slideList );
//		//根据登录的人判断所属单位查看相关资讯
//		// $articleCondition['cid'] =
//		$articleCondition['is_delete'] = 0;
//		$articleCondition['status'] = 0;
//		$articleCondition['pid'] = 16;
//		$order['sort'] = 'desc';
//		$order['create_time'] = 'desc';
//		$order['recommend'] = 'desc';
//
//		if (IS_AJAX&&IS_POST) {
//			$articleList = D("Article")->where($articleCondition)->limit ( $begin, $page['pageNum'] )->order($order)->select();
//			echo json_encode(['status' => 1 , 'info' => '查询成功' , 'data' => $articleList]);die;
//		}
//		$articleList = D("Article")->where($articleCondition)->limit ( $begin, $page['pageNum'] )->order($order)->select();
		$slideList = D('link')->where(array('is_delete'=>0,'status'=>0,'company_id'=>$this->member['cid']))->field('picture')->select();
		$this->assign( 'slideList', $slideList );//轮播图片
		$articleList = D('Article')->where(array('pid'=>16,'cid'=>$this->member['cid']))->order('create_time desc')->limit(5)->select();
		$map['id'] = $this->member['cid'];
		$shorthandname = D('company')->where($map)->getField('shorthandname');
		$this->assign('shorthandname',$shorthandname);
		$this->assign('articleList',$articleList);

		//单位通知
		// $articleCondition['cid'] = 
		$noticeCondition['is_delete'] = 0;
		$noticeCondition['status'] = 0;
		$noticeCondition['pid'] = 15;
		$noticeCondition['cid'] = $this->member['cid'];
		$order['sort'] = 'desc';
		$order['create_time'] = 'desc';
		$order['recommend'] = 'desc';
		$noticeList = D("Article")->where($noticeCondition)->order($order)->limit(3)->select();

		$this->assign('noticeList',$noticeList);
		

		// 渲染视图
		$this->display ();
	}
	/**
	 * 清除搜索记录
	 */
	public function clear_history(){
		cookie('keyword',null);
		echo 1;
	}
	/**
	 * 签到
	 */
	
}