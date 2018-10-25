<?php

namespace Admin\Controller;

/**
 * 消息发送控制器
 * 
 * @author Administrator
 *        
 */
class MemberNewsController extends CommController {
	public function index() {
		// 设置数据列表
//		$model = D ( 'MemberNews' );
//		$condition = array();
//		$dataList = $this->getList ( $model, $condition, 20, "create_time desc" );
//		$this->assign ( "dataList", $dataList );

		if($this->user['auth'] != 1){
			$map['s.cid'] = $this->user['company_id'];
		}
		$res = D('member_suggest')->alias('s')
			->join('left join db_company as c on c.id = s.cid')
			->join('left join db_department as d on d.id = s.department_id')
			->join('left join db_member as m on m.id = s.member_id')
			->field('s.id,s.content,m.personal_code,s.create_time,c.companyname,d.department_name')
			->where($map)
			->order('s.cid desc')
			->select();
//		dump($res);exit;
		$this->assign ( "dataList", $res );
		// 渲染模板
		$this->display ();
	}
	function del(){
		$res = D('member_suggest')->where('id='.$_GET['id'])->delete();
		if($res){
			$this->redirect('index');
		}
	}
	//添加消息
	public function addnews(){
		$model = D ( 'MemberNews' );
		if(IS_AJAX && IS_POST){
			if($_POST['id']){
				$dataList = $_POST;
				if($model->save($dataList)){
					$this->dwzSuccess( '操作成功', '1', 'membernews', 'refreshClose' );
				}else{
					$this->dwzSuccess( '操作失败', '0', 'membernews', 'refreshClose' );
				}
			}else{
				$dataList = array();
				$dataList = $_POST;
				$dataList['create_time'] =  time();
				if($model->add($dataList)){
					$this->dwzSuccess( '操作成功', '1', 'membernews', 'refreshClose' );
				}else{
					$this->dwzSuccess( '操作失败', '0', 'membernews', 'refreshClose' );
				}
			}
		}
		$id = I( 'get.id', 0 );
		if($id > 0){//编辑
			$dataInfo = D('MemberNews')->getOne($id);
			$this->assign ( "dataInfo", $dataInfo['info'] );
		}
		$this->display();
	}
	//删除消息
	public function delete(){
		$model = D ('MemberNews');
		$id = I( 'post.id', 0 );
		$outPut = array('status'=>0,'msg'=>'');
		if($id > 0){
			if($model->where('id='.$id)->delete()){
				$outPut['status'] = 1;
			}else{
				$outPut['msg'] = '删除失败';
			}
			$this->dwzSuccess( '删除成功', '1', 'membernews', 'refreshThis' );
		} else {
			$this->dwzSuccess( '删除失败', '0', 'membernews', 'refreshThis' );
		}
	}
	public function updatestatus(){
		$id = I( 'get.id', 0 );
		$type = I( 'get.type', 0 );
		$model = D('MemberNews');
		$outPut = array('status'=>0,'msg'=>'');
		$dataInfo = $model->where('id='.$id)->find();
		if($dataInfo[$type]==0){
			$dataInfo[$type] = 1;
		}else{
			$dataInfo[$type] = 0;
		}
		if($model->save($dataInfo)){
			$outPut['status']=1;
		}else{
			$outPut['msg']='操作失败';
		}
		echo json_encode($outPut);
	}
}