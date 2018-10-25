<?php
namespace Admin\Controller;

/**
 * 后台首页
 *
 * @author Administrator
 *        
 */
class LeaveController extends CommController {


    protected $departments='';
  /**
     * 构造函数
     */
    public function _initialize() {
        parent::_initialize();
        // 模型
        $this->departments = D('Department');
        $this->leaveModel = D('Leave');
    }

	/**
	 * 首页显示
	 */
	public function index() {
//        $memberList = D('User')->alias('a')
//                               ->field('a.id as uid,a.company_id,b.id')
//                               ->join('left join db_member AS b ON b.cid = a.company_id')
//                               ->where('a.company_id='.$this->getUserCompany()['company_id'])
//                               ->select();
//        // $data = [];
//        foreach ($memberList as $k => $v) {
//
//            $data[] = $v['id'];
//        }
//        if (!empty($data)) {
//            $approvalInfo  = $this->leaveModel
//                              ->alias('a')
//                              ->field('a.id,a.user_id,a.addtime,a.leave_cate,a.status,a.leave_start_time,a.leave_end_time,a.leave_reason,a.picture,a.cc,a.first_charge,a.second_charge,a.third_charge,b.face,b.personal_code,c.title as leave_str')
//                              ->join('left join db_member AS b ON b.id = a.user_id')
//                              ->join('left join db_leave_cate AS c ON c.id = a.leave_type_id')
//                              // ->where('a.user_id = '.$memberList['id'])
//                              ->where(['a.user_id' =>['IN',$data],'a.is_delete'=>0])
//                              ->select();
//            foreach ($approvalInfo as $k => $v) {
//                $jetLag = intval(strtotime($v['leave_end_time'])-strtotime($v['leave_start_time']))/3600;
//                $shicha = $this->shicha($v['leave_start_time'],$v['leave_end_time']);
//                $approvalInfo[$k]['shicha'] = $shicha['day'].'天'.$shicha['hour'].'小时'.$shicha['min'].'分钟'.$shicha['sec'].'秒';
//
//            }
//
//               // print_r($approvalInfo);die;
//            $this->assign('dataList',$approvalInfo);
//        }

        if($_POST['personal_code']){
            $map['personal_code'] = $_POST['personal_code'];
        }
        if($_POST['leave_start_time'] && $_POST['leave_end_time']){
            $map['leave_start_time'] = array('between',array($_POST['leave_start_time'],$_POST['leave_end_time']));
        }
        $field = 'id,cid,personal_code,leave_reason,leave_start_time,leave_end_time,addtime,status,cc,first_charge,second_charge';
        if($this->user['auth'] == 1){
            $approvalInfo = D('leave')->field($field)->where($map)->order('addtime desc')->select();
        }else{
            $map['cid'] = $this->user['company_id'];
            $approvalInfo = D('leave')->where($map)->field($field)->order('addtime desc')->select();
        }
        foreach($approvalInfo as $k=>$v){
            $approvalInfo[$k]['hour'] = intval((strtotime($v['leave_end_time']) - strtotime($v['leave_start_time']))/3600);
            $approvalInfo[$k]['companyname'] = D('company')->where('id='.$v['cid'])->getField('companyname');
        }
        $this->assign('dataList',$approvalInfo);
		$this->display ();
	}
    function del()
    {
        $res = D('leave')->where('id='.$_GET['id'])->delete();
        if($res){
            $this->redirect('index');
        }
    }
	public function leave_cate(){
		$leavecateModel = D('leave_cate');
		$leavecateCondition['is_delete'] = 0;
		$leavecateCondition['status'] = 0;
        if($this->user['auth'] != 1){
            $leavecateCondition['cid'] = $this->user['company_id'];
        }
		$leave_cate = $leavecateModel->where($leavecateCondition)->select();
        foreach($leave_cate as $k=>$v){
            $leave_cate[$k]['companyname'] = D('company')->where('id='.$v['cid'])->getField('companyname');
        }
		$this->assign('dataList',$leave_cate);
		$this->display();
	}
	public function addcate(){
        if($_POST) {
            if($this->user['auth'] == 1){
                $map['cid'] = $_POST['cid'];
            }else{
                $map['cid'] = $this->user['company_id'];
                $_POST['cid'] = $this->user['company_id'];
            }
            $map['title'] = $_POST['title'];
            $car = D('LeaveCate')->where($map)->find();
            if ($car) {
                echo "<script language=\"JavaScript\">\r\n";
                echo " alert('请假类已经存在');\r\n";
                echo " history.back();\r\n";
                echo "</script>";
                return false;
            }
            $returnMsg = D('LeaveCate')->commInsert($_POST);
            if ($returnMsg) {
                $this->redirect('leave_cate');
            }
        }
        if($this->user['auth'] == 1){
            $res = D('company')->field('id,companyname')->select();
            $this->assign('company',$res);
        }
		$this->display();
	}
    function delete(){
        $id = $_GET['id'];
        $res = D('LeaveCate')->where('id='.$id)->delete();
        if($res){
            $this->redirect('leave_cate');
        }
    }
	public function cateremove() {
		$idList = I ( 'post.id' );
		$returnMsg = D ( 'LeaveCate' )->commRemove ( $idList );
		$this->HuiMsg( $returnMsg );
	}

   public function level(){

   
//    $leaveLevelModel = D('LeaveLevel');
//
//    $dataInfo = $leaveLevelModel->where('cid='.$this->getUserCompany()['company_id'])->find();

    // print_r($this->getUserCompany());exit;

//    $keyarr   = explode(',', $dataInfo['first_charge']);
//    $keyarr   = explode(',', $dataInfo['first_charge']);
//    $keyarr   = explode(',', $dataInfo['first_charge']);
//
//
//    $row = $this->getDepartmentMember();
//
//    foreach ($row as $key => $value) {
//
//        foreach ($value['memberList'] as $ke => $val)
//        {
//            $getkey = $value['index_name']. $val['id'];
//
//            if(!in_array($getkey,$keyarr))
//            {
//                unset($row[$key]['memberList'][$ke]);
//            }
//        }
//    }
//	if (IS_POST) {
//		if (!$dataInfo) {
//    	$_POST['cid'] = $this->getUserCompany()['company_id'];
//    	$leaveLevelModel->add($_POST);
//    	$return['status'] = 1;
//    	$return['info'] = '更新成功';
//    	$this->HuiMsg( $return );
//    }else{
//    	// $data['cid'] = $this->getUserCompany()['id'];
//        $data['first_min'] = $_POST['first_min'];
//        $data['first_max'] = $_POST['first_max'];
//        $data['second_min'] = $_POST['second_min'];
//        $data['second_max'] = $_POST['second_max'];
//        $data['third_min'] = $_POST['third_min'];
//        $data['third_max'] = $_POST['third_max'];
//    	$leaveLevelModel->where('cid='.$this->getUserCompany()['company_id'])->save($data);
//    	$return['status'] = 1;
//    	$return['info'] = '更新成功';
//    	$this->HuiMsg( $return );
//    }
//   	}
//       $this->assign('dataInfo',$dataInfo);
       // if(IS_POST){
       //     $first['range_time'] = $_POST['first_max'];
       //     $second['range_time'] = $_POST['second_max'];
       //     $third['range_time'] = $_POST['third_max'];
       //     D('member')->where(array('auth'=>1,'cid'=>$this->user['company_id']))->save($first);
       //     D('member')->where(array('auth'=>2,'cid'=>$this->user['company_id']))->save($second);
       //     D('member')->where(array('auth'=>3,'cid'=>$this->user['company_id']))->save($third);
       //     echo "<script language=\"JavaScript\">\r\n";
       //     echo " alert('修改成功');\r\n";
       //     echo " history.back();\r\n";
       //     echo "</script>";
       //     $this->redirect('level');
       // }
       //  $auth1 = D('member')->where(array('auth'=>1,'cid'=>$this->user['company_id']))->limit(1)->getField('range_time');
       //  $auth2 = D('member')->where(array('auth'=>2,'cid'=>$this->user['company_id']))->limit(1)->getField('range_time');
       //  $auth3 = D('member')->where(array('auth'=>3,'cid'=>$this->user['company_id']))->limit(1)->getField('range_time');
       // $this->assign('dataInfo1',$auth1);
       // $this->assign('dataInfo2',$auth2);
       // $this->assign('dataInfo3',$auth3);

       if($this->user['auth'] != 1){
           $auth = D('member')->where(array('auth'=>1,'cid'=>$this->user['company_id']))->field('range_time')->find();
           $auth2 = D('member')->where(array('auth'=>2,'cid'=>$this->user['company_id']))->field('range_time')->find();
           $auth3 = D('member')->where(array('auth'=>3,'cid'=>$this->user['company_id']))->field('range_time')->find();
           $com = D('company')->where(array('id'=>$this->user['company_id']))->field('companyname')->find();
//           dump($auth2);die;
           $this->assign('auth',$auth);
           $this->assign('auth2',$auth2);
           $this->assign('auth3',$auth3);
           $this->assign('companyname',$com);
       }
        $this->display();
    }

    function editLevel()
    {
        if($_POST){
            $auth1['range_time'] = $_POST['auth1'];
            $auth2['range_time'] = empty($_POST['auth2']) ? 0 : $_POST['auth2'];
            $auth3['range_time'] = empty($_POST['auth3']) ? 0 : $_POST['auth3'];
            D('member')->where(array('auth'=>1,'cid'=>$this->user['company_id']))->save($auth1);
            D('member')->where(array('auth'=>2,'cid'=>$this->user['company_id']))->save($auth2);
            D('member')->where(array('auth'=>3,'cid'=>$this->user['company_id']))->save($auth3);
            $this->redirect('level');
        }
        $auth = D('member')->where(array('auth'=>1,'cid'=>$this->user['company_id']))->getField('range_time');
        $auth2 = D('member')->where(array('auth'=>2,'cid'=>$this->user['company_id']))->getField('range_time');
        $auth3 = D('member')->where(array('auth'=>3,'cid'=>$this->user['company_id']))->getField('range_time');
        $this->assign('auth1',$auth);
        $this->assign('auth2',$auth2);
        $this->assign('auth3',$auth3);
        $this->display();
    }
    public function addcharge(){
        if (IS_POST) {
            $field = '';
            switch (I('post.field')) {
                case '1':
                   $field='first_charge';
                    break;
                case '2':
                   $field='second_charge';
                    break;
                case '3':
                   $field='third_charge';
                    break;
            }
            $departmentAll  = [];
            foreach ($_POST['index'] as $key => $value) 
            {
                foreach ($value as $ke => $va) 
                {
                    $departmentAll[]= $key.$va;
                }
            }
            D('LeaveLevel')->where(['cid'=>$this->getUserCompany()['company_id'],'status'=>0])->setField($field,join(',',$departmentAll));

            $return['status'] = 1;
            $return['info'] = '操作成功';
            $this->HuiMsg( $return );

        }

        $memberModel     = D('Member');
        $departmentModel = D('Department');
        $leavelevelModel = D('LeaveLevel');


        $departmentList = $departmentModel->where(['companyid'=>$this->getUserCompany()['company_id']])->select();
        foreach ($departmentList as $k => $v) {
            $departmentList[$k]['charge'] = explode(',',$v['charge']);
        }

        foreach ($departmentList as $k => $v) {
            $departmentList[$k]['memberList'] = $memberModel->where(['id'=>['IN',$v['charge']]])->field('id,nickname,personal_code')->select();
          
        }

        $leaveLevelModel = D('LeaveLevel');
        $dataInfo = $leaveLevelModel->where('cid='.$this->getUserCompany()['company_id'])->find();
         $field = '';
        switch (I('get.cate')) {
            case '1':
               $field='first_charge';
                break;
            case '2':
               $field='second_charge';
                break;
            case '3':
               $field='third_charge';
                break;
        }
        $keyarr   = explode(',', $dataInfo[$field]);


        $this->assign('dataList',$departmentList);
        $this->assign('keyarr',$keyarr);

        $this->assign('field', I('get.cate'));

       
        $this->display();
    }

    /**
     * 获取部门
     * @return [type] [description]
     */
    function getDepartment()
    {

        return $this->departments->where(['companyid'=>$this->getUserCompany()['company_id'],'status'=>0])->select();
    }

    function getDepartmentMember(){

        $memberModel = D('Member');
        $departmentModel = D('Department');
        $leavelevelModel = D('LeaveLevel');
        $departmentList = $departmentModel->where(['companyid'=>$this->getUserCompany()['company_id']])->select();
        foreach ($departmentList as $k => $v) {
            $departmentList[$k]['charge'] = explode(',',$v['charge']);
        }

        foreach ($departmentList as $k => $v) {
            $departmentList[$k]['memberList'] = $memberModel->where(['id'=>['IN',$v['charge']]])->field('id,nickname,personal_code')->select();
        }

        return $departmentList;
    }

    /**
     * 获取各级负责人
     */

    function getChargeList($cate){
        $leaveLevelModel = D('LeaveLevel');

        $dataInfo = $leaveLevelModel->where('cid='.$this->getUserCompany()['company_id'])->find();

         $field = '';
        switch ($cate) {
            case '1':
               $field='first_charge';
                break;
            case '2':
               $field='second_charge';
                break;
            case '3':
               $field='third_charge';
                break;
        }

        $keyarr   = explode(',', $dataInfo[$field]);


        $row = $this->getDepartmentMember();

        foreach ($row as $key => $value) {

            foreach ($value['memberList'] as $ke => $val) 
            {
                $getkey = $value['index_name']. $val['id'];

                if(!in_array($getkey,$keyarr))
                {
                    unset($row[$key]['memberList'][$ke]);
                }
            }
        }

        return $row;
    }

    /**
 * 短语
 * @return [type] [description]
 */
    public function phrase()
    {
        $phraseList = D('Phrase')->where(['cid'=>$this->getUserCompany()['company_id'],'is_delete'=>0,'type'=>1])->select();

        $this->assign('dataList',$phraseList);
        

        $this->display();
    }
    public function addPhrase()
    {
        $_POST['cid']=$this->getUserCompany()['company_id'];
        if (IS_POST) {
             if (D('Phrase')->create()) {
                D('Phrase')->add($_POST);
                $return['status'] = 1;
                $return['info'] = '操作成功';
                $this->HuiMsg( $return );
            }else{
                $return['status'] = 0;
                $return['info'] = '操作失败';
                $this->HuiMsg( $return );
            }
        }
       
        $this->display();
    }

    public function phraseRemove()
    {
       
        $condition ['id'] = I('post.id');
        $condition ['is_delete'] = 1;
        if ( D('phrase')->save ( $condition ) ) {
            $returnMsg ['info'] = '操作成功!';
            $returnMsg ['status'] = 1;
        } else {
            $returnMsg ['status'] = '0';
            $returnMsg ['info'] = '操作失败!';
        }
        $this->HuiMsg( $returnMsg );


    }

}