<?php
namespace Admin\Controller;

/*
 * 新闻动态
 */
class WebIntroduceController extends CommController {
    /*
     * 帮助指南
     */
    public function index() {
    	// 设置模型
        $article = D( 'WebIntroduce' );
        $search = array();
        $condition['is_delete'] = 0;
        $condition['pid'] = 16;
        if(I('post.title')){
        	$search['title'] = I('post.title');
        	$condition['title'] = array('like','%'.$search['title'].'%');
        }
        // 获取数据
        $dataList = $article->format( $this->getPageList( $article, $condition, 20 ) );
        // 注入变量
        $this->assign( 'search', $search );
        $this->assign( 'dataList', $dataList );

        // 渲染模版
        $this->display();
    }
	
    /*
     * 添加
     */
    public function _before_create(){
		$_POST['create_time'] = time();
    }
}