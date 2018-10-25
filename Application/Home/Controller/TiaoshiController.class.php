<?php
namespace Home\Controller;

/**
 * 首页控制器
 *
 * @author BoBo
 *        
 */
class TiaoshiController extends CommController {

	/**
	 * 首页显示
	 */
	public function index() {
		// 幻灯
		$product = D('Commodity')->select();
		foreach($product as $key=>$val){
				var_dump($val['content']);
				$data['content'] = str_replace('/wfxnew/','/',$val['content']);
				$data['id'] = $val['id'];
				D('Commodity')->save($data);
		}
		$slideCondition = array ('status' => 0,'is_delete' => 0 );
		$slideList = D ( 'Link' )->getList ( $slideCondition, 'title,picture,link' );
		$this->assign( 'slideList', $slideList );

		//获取限时抢购商品
		$map['is_delete'] = 0;
		$map['status'] = 0;
		$map['pid'] = 30;
		$map['recommend'] = 1;
		$panicList = D('Commodity')->where($map)->order('sort desc,create_time desc')->limit(5)->select();

		$this->assign( 'panicList', $panicList );
		
		//预售商品
		$map['pid'] = 31;
		$sealList = D('Commodity')->where($map)->order('sort desc,create_time desc')->limit(5)->select();

		$this->assign( 'sealList', $sealList );
		

		//查询出所有的一级分类
		$map['pid'] = 0;
		$map['recommend'] = 1;
		$categoryList = D('CommodityClass')->where($map)->order('sort desc,create_time desc')->select();
		
		$this->assign( 'categoryList', $categoryList );
		
		//最新商品
		$maps['is_delete'] = 0;
		$maps['status'] = 0;
		$newList = D('Commodity')->where($maps)->order('sort desc,create_time desc')->limit(30)->select();
		
		$this->assign( 'newList', $newList );
		
		//首页通图
		$mapss['is_delete'] = 0;
		$mapss['status'] = 0;
		$digList = D('Digraph')->where($mapss)->order('sort desc,create_time desc')->limit(4)->select();
		$this->assign( 'digList', $digList );
		
		
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
	public function past (){
		$this->checkLogin ();
		$outPut = array('status'=>0,'message'=>'');
		$todaytime = strtotime(date('Y-m-d'));
		$nameval = tmpl_upgrade(2);
		$isPast = D('MemberUpgrade')->where(array('mid'=>$this->member['id'],'record'=>$nameval))->order('create_time desc')->find();
		if($isPast && $isPast['create_time'] > $todaytime){
			$outPut['message'] = '今天您已经签过到了';
		}else{
			$config = D('Config')->where(array('id'=>1))->find();
			$upgrade_rule = json_decode($config['upgrade_rule'],true);
			$data['upgrade'] = $upgrade_rule['past'];
			$data['mid'] = $this->member['id'];
			$data['from_id'] = $this->member['id'];
			$data['create_time'] = time();
			$data['record'] = tmpl_upgrade(2);
			if(D('MemberUpgrade')->add($data)){
				$outPut['status'] = 1;
				$outPut['message'] = '签到成功';
			}else{
				$outPut['message'] = '签到失败';
			}
		}
		$this->ajaxReturn ( $outPut );
	}
}