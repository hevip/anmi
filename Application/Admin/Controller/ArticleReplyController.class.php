<?php

namespace Admin\Controller;

/**
 * [文章评论] 控制器
 *
 * @author BoBo
 *        
 */
class ArticleReplyController extends CommController {
	/**
	 * 构造函数
	 */
	public function _initialize() {
		parent::_initialize();
		// 设置模型
		$this->model = D( 'ArticleReply' );
	}
	
	/**
	 * 评论列表
	 */
	public function index() {
		$theId = I( 'get.theId', 0 );
		if (is_number( $theId )  ) {
			die( '参数缺失：theId' );
		}
		
		// 获取文章信息
		$dataInfo = array();
		$dataInfo['article_title'] = D( 'Article' )->where( "id = {$theId}" )->getField( 'title' );
		
		// 设置sql
		$field = "a.id,a.evaluate_id,a.reply_id,a.content,a.create_time,";
		$field .= "b.nickname,b.wx_name,b.face";
		$sql = "select $field from db_article_reply as a";
		$sql .= " left join db_member as b on a.evaluate_id = b.id";
		$sql .= " where a.article_id = {$theId} and a.is_delete = 0";
		$sql .= " order by a.create_time desc";
		$commentList = D( 'ArticleReply' )->query( $sql );
		$this->assign( 'dataList', $commentList );
		$this->assign( 'dataInfo', $dataInfo );
		
		// 渲染视图
		$this->display();
	}
}