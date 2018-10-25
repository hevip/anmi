<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/9/17
 * Time: 17:19
 */

namespace Home\Controller;


class ProductController extends CommController
{

    public function _initialize() {
        parent::_initialize ();
        $this->checkLogin ();
        $this->leaveModel = D('Leave');
        $this->leaveCateModel = D('LeaveCate');
        $this->leaveLevelModel = D('LeaveLevel');
        $this->carApplicationModel = D('CarApplication');
        $this->carLevelModel = D('CarLevel');
    }


    function index(){
        $slideList = D('link')->where(array('is_delete'=>0,'status'=>0,'company_id'=>$this->member['cid']))->field('picture')->select();
        $this->assign( 'slideList', $slideList );
        $this->display();
    }

    function detail(){
        $map['type'] = $_GET['title'];
        $res = D('goods')->where($map)->select();
        foreach($res as $k=>$v){
            $res[$k]['title'] = mb_substr($v['title'],0,10,'utf-8');
//            $res[$k]['content'] = mb_substr($v['content'],0,50,'utf-8');
        }
        $this->assign('list',$res);
        $this->display();
    }

    function details(){
        $res = D('goods')->where('id='.$_GET['id'])->find();
        $this->assign('list',$res);
        $this->display();
    }
}