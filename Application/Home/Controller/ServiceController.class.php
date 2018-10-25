<?php
namespace Home\Controller;

/**
 * 首页控制器
 *
 * @author 
 *        
 */
class ServiceController extends CommController {
	public function _initialize() {
		parent::_initialize ();
		$this->checkLogin ();
		$this->leaveModel = D('Leave');
		$this->leaveCateModel = D('LeaveCate');
		$this->leaveLevelModel = D('LeaveLevel');
		$this->carApplicationModel = D('CarApplication');
		$this->carLevelModel = D('CarLevel');
	}

	/**
	 * 首页显示
	 */
	public function index() {
		// 幻灯
		$slideCondition = array ('status' => 0,'is_delete' => 0 ,'company_id'=>$this->member['cid']);
//		$slideList = D ( 'Link' )->getList ( $slideCondition, 'title,picture,link' );
		$slideList = D ( 'Link' )->where($slideCondition)->field('id,title,picture,link')->select();
		$this->assign( 'slideList', $slideList );
//		$department_index_name = D('Department')->where('id='.$this->member['department_id'])->field('index_name')->find();
//		$where[] = "FIND_IN_SET('".$department_index_name['index_name'].$this->member['id']."',`first_charge`)";
//		$where[] = "FIND_IN_SET('".$department_index_name['index_name'].$this->member['id']."',`second_charge`)";
//		$where[] = "FIND_IN_SET('".$department_index_name['index_name'].$this->member['id']."',`third_charge`)";
//
//		$auth = $this->leaveLevelModel->where((implode(' OR ',$where)))->count();
//
//		$carauth = $this->carLevelModel->where((implode(' OR ',$where)))->count();
		if($this->member['auth'] == 0 ||  $this->member['auth'] == 4){
			$this->assign('auth',0);
		}
//		$this->assign('carauth',$carauth);

		// print_r($carauth);die;
	
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
	 * 请假申请
	 * @return [type] [description]
	 */
	public function application(){
//		$leavecateModel = D('LeaveCate');
//		$leavecateCondition['is_delete'] = 0;
//		$leavecateCondition['status'] = 0;
//		$leavecateCondition['cid'] = $this->getUserCompany()['cid'];
//		$leave_cate = $leavecateModel->where($leavecateCondition)->select();
//		$map['auth'] = 1;
//		$review = D('member')->where('auth','<>',0)->field('personal_code')->select();
//		dump($review);exit;
//		$this->assign('leave_cate',$leave_cate);
		$cate = D('leave_cate')->where(array('cid'=>$this->member['cid']))->field('title')->select();
		$this->assign('cate',$cate);
		$this->assign('member',$this->member);
//		$this->assign('review',$review);
		$this->display();
	}
	/**
	 * 审批人选择页面
	 */
	public function auditors(){
//		$leave_cate = D('LeaveCate')->where('id='.$_POST['leave_cate'])->field('title')->find();
		$duration = $this->shicha($_POST['leave_start_time'],$_POST['leave_end_time']);
		$dataList['hour'] = intval((strtotime($_POST['leave_end_time']) - strtotime($_POST['leave_start_time']))/3600);
		if($dataList['hour'] < 1){
			echo "<script language=\"JavaScript\">\r\n";
			echo " alert('请假时间太短');\r\n";
			echo " history.back();\r\n";
			echo "</script>";
		}
		$dataList['duration'] = $duration['day'].'天'.$duration['hour'].'小时'.$duration['min'].'分钟'.$duration['sec'].'秒';
		$dataList['leave_start_time'] = $_POST['leave_start_time'];
		$dataList['leave_end_time'] = $_POST['leave_end_time'];
		$dataList['leave_reason'] = $_POST['leave_reason'];//请假理由
		$dataList['personal_code'] = $_POST['personal_code'];//请假人代号
		$dataList['leave_cate'] = $_POST['leave_cate'];//事假或病假

		$upload = new \Think\Upload();// 实例化上传类
	    $upload->maxSize   =     10485760  ;// 设置附件上传大小
	    $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
	    $upload->rootPath  =     './Uploads/'; // 设置附件上传根目录
	    $upload->savePath  =     '/annex/'; // 设置附件上传（子）目录
	    if ($_FILES['picture']['error']==0) {
	    	 // 上传文件 
	   		 $info   =   $upload->upload();
		    if(!$info) {// 上传错误提示错误信息
		        $this->error($upload->getError());
		    }else{// 上传成功
				$dataList['picture'] = '/Uploads'.$info['picture']['savepath'].$info['picture']['savename'];
		    }
	    }
//		$res = D('leave')->insert($dataList);
//		if($res){
//			echo "<script language=\"JavaScript\">alert('申请成功');</script>";
//			$this->redirect('index');
//		}
		//查找一级负责人
//		$firstcondition['cid'] = $this->member['cid'];
//		$firstchargeStr = D('LeaveLevel')->where($firstcondition)->field('first_charge')->find();
//		$firstchargeArray = explode(',',$firstchargeStr['first_charge']);

		//查询到自己同部门的所有人
//		$sameDepartmentMember = D('Member')->where(['cid'=>$this->member['cid'],'department_id'=>$this->member['department_id'],'id'=>['neq',session('member_auth')['id']]])->field('id')->select();

//		 print_r($sameDepartmentMember);die;
		// print_r(session('member_auth')['id']);die;
//		$parIndexName = D('Department')->where(['companyid'=>$this->member['cid'],'id'=>$this->member['department_id']])->field('index_name')->find();
//
//		foreach ($sameDepartmentMember as $k => $v) {
//			$sameDepartmentMember[$k]['idStr'] = $parIndexName['index_name'].$v['id'];
//		}
//		foreach ($sameDepartmentMember as $ke => $val) {
//			for ($i=0; $i <count($firstchargeArray); $i++) {
//
//				if ($firstchargeArray[$i] == $val['idStr']) {
//					   $firstMemberIdList[] = $val['id'];
//				}
//			}
//		}
//		$firstChargeList = D('Member')->where(['id'=>['IN',$firstMemberIdList]])->select();
//
//		$this->assign('firstChargeList',$firstChargeList);
//		//查找抄送人
		
		
		// print_r($firstChargeList);die;

		//根据时长寻找审核负责人
		// $shicha = intval(strtotime($_POST['leave_end_time'])-strtotime($_POST['leave_start_time']))/3600;

		// $level_shicha = D('LeaveLevel')->where('cid='.$this->getUserCompany()['id'])->find();
	
		// $condition['cid'] = $this->member['cid'];
		// if ($shicha<$level_shicha['first_max']) {//一级、、查找一级负责人
		// 	$field = 'first_charge as charge';
		// }elseif($shicha>$level_shicha['second_min']&&$shicha>$level_shicha['second_max']){//二级
		// 	$field = 'second_charge as charge';
		// }elseif($shicha>$level_shicha['third_min']){//三级
		// 	$field = 'third_charge as charge';
		// }

		// $charge = D('LeaveLevel')->where($condition)->field($field)->find();
		// $parIndexName = D('Department')->where(['companyid'=>$this->member['cid'],'id'=>$this->member['department_id']])->field('index_name')->find();
	
		//根据查找到的负责人列表查找用户信息
//		$first = D('member')->where('auth=1')->limit(1)->getField('range_time');
//		$second = D('member')->where('auth=2')->limit(1)->getField('range_time');
//		$third = D('member')->where('auth=3')->limit(1)->getField('range_time');
//		if($dataList['hour'] <= $first){
		$map['cid'] = $this->member['cid'];
		$map['department_id'] = $this->member['department_id'];
		$map['auth'] = 1;
		$chargeList = D('member')->where($map)->field('personal_code')->select();
		if($this->member['auth'] == 1){
			$map['personal_code'] = array('neq',$this->member['personal_code']);
			$map['cid'] = $this->member['cid'];
			$map['department_id'] = $this->member['department_id'];
			$chargeList = D('member')->where($map)->field('personal_code')->select();
		}
		$HR = D('member')->where(array('auth'=>5,'cid'=>$this->member['cid']))->getField('personal_code');
		$cc = D('member')->where(array('auth'=>4,'cid'=>$this->member['cid'],'department_id'=>$this->member['department_id']))->field('personal_code')->select();
		S('dataList',$dataList,1800);
		$this->assign('HR',$HR);//hr
		$this->assign('cc',$cc);//抄送人
		$this->assign('dataList',$dataList);//请假信息
		$this->assign('chargeList',$chargeList);//一级审批人
		$this->display();
	}
	/**
	 * 提交申请
	 */
	public function auditorsAdd(){
		if(empty(I('post.firstCharge'))){
			echo "<script language=\"JavaScript\">\r\n";
			echo " alert('请选择审批人');\r\n";
			echo " history.back();\r\n";
			echo "</script>";
			return false;
		}
		$leaveModel = D('Leave');
		$row = S('dataList');
		$data['addtime'] = time();
		$data['leave_start_time'] = $row['leave_start_time'];
		$data['leave_end_time'] = $row['leave_end_time'];
		$data['leave_cate'] = $row['leave_cate'];
		$data['leave_reason'] = $row['leave_reason'];
		$data['personal_code'] = $row['personal_code'];
		$data['cid'] = $this->member['cid'];
		$data['picture'] = $row['picture'];
		$cc = I('post.cc');
		$HR = D('member')->where(array('auth'=>5,'cid'=>$this->member['cid']))->getField('personal_code');
		$firstCharge = I('post.firstCharge');
		array_push($cc,$HR);
		$data['cc'] = empty($cc) ? $HR : implode(',',$cc);
		$data['first_charge'] = implode(',',$firstCharge);
		$res = $leaveModel->add($data);
		if ($res ) {
			$return['status'] = 1;
    		$return['info'] = '提交成功';
		}else{
			$return['status'] = 0;
    	$return['info'] = '提交失败';
		}
    	$this->HuiMsg( $return );
	}
/**
 * 请假记录查询
 * @return [type] [description]
 */
	public function leaveRecord(){
		if ($_POST) {
				$personal_code = I('post.personal_code');
				$leave_start_time = I('post.leave_start_time');
				$leave_end_time = I('post.leave_end_time');
			    if ($leave_start_time &&$leave_end_time ) {
					$map['leave_start_time']  = array('between',array($leave_start_time,$leave_end_time));
				}
		}
	   if($_GET){
		   $leave_cate = I('get.lab');
		   $status = I('get.status');
		   if(!empty($leave_cate)){
			   $map['leave_cate'] = $leave_cate;
		   }
		   if(isset($status)){
			   $map['status'] = $status;
		   }
	   }
		$map['personal_code'] = $this->member['personal_code'];
		$map['cid'] = $this->member['cid'];
		$leaveList = D('leave')->where($map)->order('addtime desc')->limit(20)->select();
		$cate = D('leave_cate')->where(array('cid'=>$this->member['cid']))->field('title')->select();
        $this->assign('member',$this->member);
        $this->assign('cate',$cate);
        $this->assign('leaveList',$leaveList);
		$this->display();
	}
	/**
	 * 请假详情和二维码生成
	 *
	 */
	public function leaveRecordRead(){
		$id = I('get.id');
//		$leaveInfo = $this->leaveModel
//                    ->alias('a')
//                    ->field('a.user_id,a.leave_type_id,a.status,a.addtime,a.leave_reason,a.picture,a.leave_start_time,a.leave_end_time,a.picture,a.remind,a.tips,b.face,b.personal_code,c.title')
//                    ->join('left join db_member AS b ON b.id=a.user_id')
//                    ->join('right join db_leave_cate AS c ON c.id=a.leave_type_id')
//                    ->where('a.id='.$id)
//                    ->find();
//        $shicha = $this->shicha($leaveInfo['leave_start_time'],$leaveInfo['leave_end_time']);
//        $leaveInfo['shicha'] = $shicha['day'].'天'.$shicha['hour'].'小时'.$shicha['min'].'分钟'.$shicha['sec'].'秒';
		if(I('get.new') == 1){
			$leaveInfo = D('leave')->where(array('status'=>1,'personal_code'=>$this->member['personal_code']))->order('id desc')->limit(1)->find();
			if($leaveInfo == null){
				$this->assign('new',1);
			}
		}else{
			$leaveInfo = D('leave')->where('id='.$id)->find();
		}
		$leaveInfo['shicha'] = $this->shicha($leaveInfo['leave_start_time'],$leaveInfo['leave_end_time']);
        //根据类型查找Mac
		$map['is_delete'] = 0;
		$map['company_id'] = $this->member['cid'];
		$map['mac_type'] = 1;//0车辆1门禁
		$macs = '';
        $Mac = D('Mac')->where($map)->field('mac')->select();
        for($i = 0;$i < count($Mac);$i++){
        	$macs = $Mac[$i]['mac'].' '.$macs;
        }
        // dump($macs);die;
//        $Mac = D('Mac')->where(['is_delete'=>0,'company_id'=>$this->getUserCompany()['cid'],'mac_type'=>1])->getField('mac');
        //申请人personal_code
//        $apppersonal_code = D('Member')->where(['id'=>$leaveInfo['user_id']])->getField('personal_code');
        $apppersonal_code = substr($leaveInfo['personal_code'],2);
		$leaveCate = D('leave_cate')->where(array('title'=>$leaveInfo['leave_cate'],'cid'=>$this->member['cid']))->getField('id');
        //二维码
      	$a = '1'.sprintf ( "%02d",$leaveCate).mb_substr($leaveInfo['leave_reason'],0,5,'utf-8');
	    $b = $apppersonal_code;
	    $c = substr(date('YmdHis',strtotime($leaveInfo['leave_start_time'])),2);
	    $d = substr(date('YmdHis',strtotime($leaveInfo['leave_end_time'])),2);
	    $e = $macs;
	  // dump($leaveCate);die;
	    exec('java -jar /etc/XXTEACAI.jar '.$a.' '.$b.' '.$c.' '.$d.' '.$e,$output);
	    $encode = mb_detect_encoding(current(array_filter($output)), array("ASCII","UTF-8","GB2312","GBK","BIG5"));
	    $string = iconv("UTF-8","ASCII",current(array_filter($output)));

	    $code = $this->member['personal_code'];
		$filename = "Uploads/erweima/$code.png";
		$this->create_erweima ( $filename, $string );
        $this->assign('erweima',$filename);
		$this->assign('leaveInfo',$leaveInfo);
		$this->display();
	}
/**
 * 审核页面，统计未审核数量
 * @return [type] [description]
 */
	public function approval(){
//		$unapprovallist = $this->getAllApprovalList(0);
//		$unapprovalCount = count($unapprovallist);
//		$this->assign('unapprovalCount',$unapprovalCount);
		if($this->member['auth'] == 1){
			$unapprovalCount = D('leave')->where(array('status'=>0,'cid'=>$this->member['cid']))->field('id,first_charge,second_charge')->select();
			foreach($unapprovalCount as $k=>$v){
				if(!in_array($this->member['personal_code'],explode(',',$v['first_charge'])) || $v['second_charge'] != ''){
					unset($unapprovalCount[$k]);
				}
			}
			$unapprovalCount = count($unapprovalCount);
		}
		if($this->member['auth'] == 2){
			$map['second_charge'] = $this->member['personal_code'];
			$map['cid'] = $this->member['cid'];
			$map['status'] = 0;
			$unapprovalCount = D('leave')->where($map)->count();
		}
		if($this->member['auth'] == 5){
			$unapprovalCount = D('leave')->where(array('status'=>0,'cid'=>$this->member['cid']))->count();
		}
		$this->assign('unapprovalCount',$unapprovalCount);
		$this->display();
	}

	/**
	 * 获取所有级别的负责人
	 * @param  [type] $cid [description]
	 * @return [type]      [description]
	 */
	public function getAllChargeMember($cid){

		$allChargeMember = $this->leaveLevelModel->where('cid='.$cid)->field('first_charge,second_charge,third_charge')->find();
		return $allChargeMember;
	}
	/**
	 * 未审批列表
	 * @return [type] [description]
	 */
	public function unapprovallist(){
		if($this->member['auth'] == 1){
			$map['status'] = 0;
			$map['cid'] = $this->member['cid'];
			$field = 'id,cid,personal_code,addtime,leave_cate,first_charge,cc,second_charge';
			$unapprovallist = D('leave')->where($map)->field($field)->order('addtime desc')->select();
			foreach ($unapprovallist as $k => $v) {
				$code['personal_code'] = $v['personal_code'];
				$code['cid'] = $v['cid'];
				$unapprovallist[$k]['face'] = D('Member')->where($code)->getField('face');
				if (!in_array($this->member['personal_code'], explode(',', $v['first_charge'])) || $v['second_charge'] != '') {
					unset($unapprovallist[$k]);
				}
			}
			if(!$unapprovallist){
				$this->redirect('approval');
			}
		}
		if($this->member['auth'] == 2){
			$map['second_charge'] = $this->member['personal_code'];
			$map['status'] = 0;
			$map['cid'] = $this->member['cid'];
			$unapprovallist = D('leave')->where($map)->field('id,cid,personal_code,addtime,leave_cate')->order('addtime desc')->select();
			foreach ($unapprovallist as $k => $v) {
				$code['personal_code'] = $v['personal_code'];
				$code['cid'] = $v['cid'];
				$unapprovallist[$k]['face'] = D('Member')->where($code)->getField('face');
			}
			if(!$unapprovallist){
				$this->redirect('approval');
			}
		}
		if($this->member['auth'] == 5){
			$unapprovallist = D('leave')->where(array('status'=>0,'cid'=>$this->member['cid']))->select();
			foreach ($unapprovallist as $k => $v) {
				$code['personal_code'] = $v['personal_code'];
				$code['cid'] = $v['cid'];
				$unapprovallist[$k]['face'] = D('Member')->where($code)->getField('face');
			}
			if(!$unapprovallist){
				$this->redirect('approval');
			}
		}
		$this->assign('unapprovallist',$unapprovallist);
		$this->display();
	}

	/**
	 * 获取所有请假列表
	 * @param  [type] $status [description]
	 * @return [type]         [description]
	 */
	public function getAllApprovalList($status){
		$department_index_name = D('Department')->where('id='.$this->member['department_id'])->field('index_name')->find();
		$allChargeMember = $this->getAllChargeMember($this->member['cid']);
		$level = '';
		foreach ($allChargeMember as $k => $v) {
			if (in_array($department_index_name['index_name'].$this->member['id'],explode(',',$v))) {
				$level = $k;
			}
		}

		$condition['status'] = $status;
		$condition[$level] = $this->member['id'];
		$approvalList = $this->leaveModel->where($condition)->order('id desc')->select();

		return $approvalList;

	}


	/**
	 * 判断是否需要上一级审批
	 */
	public function approvalRead(){
		$id = I('get.id');
//        $this->assign('id',$id);//当前请假id
//		$approvalInfo  = $this->leaveModel
//							  ->alias('a')
//							  ->field('a.id,a.user_id,a.leave_type_id,a.status,a.leave_start_time,a.leave_end_time,a.leave_reason,a.picture,a.cc,a.first_charge,a.second_charge,a.third_charge,b.face,b.personal_code,c.title as leave_str')
//							  ->join('left join db_member AS b ON b.id = a.user_id')
//							  ->join('left join db_leave_cate AS c ON c.id = a.leave_type_id')
//							  ->where('a.id = '.$id)
//							  ->find();
//		$jetLag = intval(strtotime($approvalInfo['leave_end_time'])-strtotime($approvalInfo['leave_start_time']))/3600;
//		$shicha = $this->shicha($approvalInfo['leave_start_time'],$approvalInfo['leave_end_time']);
//        $approvalInfo['shicha'] = $shicha['day'].'天'.$shicha['hour'].'小时'.$shicha['min'].'分钟'.$shicha['sec'].'秒';
//
//        //判断审核人是否有权限审核，若没有及提交给下一级审核
//        if ($jetLag > $this->checkAuthority()[1]) {
//        	$nextLevel = $this->getNextLevel();
//        	$nextChargeList = $this->getChargeList($nextLevel);
//
//        	$this->assign('authority',1);//提交审核到下一级
//        	$this->assign('nextChargeList',$nextChargeList);//提交审核到下一级
//        	$this->assign('nextLevel',$nextLevel);//提交审核到下一级
//        	$this->assign('id',$id);//当前请假id
//
//        	$nextLevelCharge =$this->leaveModel->where('id='.$id)->getField($nextLevel);//获取下一级的负责人id
//        	$this->assign('nextLevelCharge',$nextLevelCharge);
//        }
//        //查找审批短语
//        $phraseList = D('Phrase')->where(['cid'=>$this->member['cid'],'is_delete'=>0,'type'=>1])->select();

		$approvalInfo = D('leave')->where('id='.$id)->find();
		$approvalInfo['hour'] = intval((strtotime($approvalInfo['leave_end_time']) - strtotime($approvalInfo['leave_start_time'])) / 3600);
		if($approvalInfo['hour'] >= $this->member['range_time']){
			if($this->member['auth'] == 2){
				$three = D('member')->where(array('cid'=>$this->member['cid'],'department_id'=>$this->member['department_id'],'auth'=>3))->field('personal_code')->select();
				if($three){
					$this->assign('authority',1);
					$this->assign('nextChargeList',$three);
				}else{
					$this->assign('authority',0);
				}
			}
			if($this->member['auth'] == 1){
				$map['auth'] = 2;
				$map['cid'] = $this->member['cid'];
				$map['department_id'] = $this->member['department_id'];
				$map['personal_code'] = array('neq',$this->member['personal_code']);
				$nextChargeList = D('member')->where($map)->field('personal_code')->select();
				$this->assign('authority',1);
				$this->assign('nextChargeList',$nextChargeList);
			}
		}
		$this->assign('phraseList','同意请假，注意安全！');
		$this->assign('approvalInfo',$approvalInfo);
		$this->display();
	}
/**
 * 
 * 获取当前会员的下一级
 * @return [type] [description]
 */
	public function getNextLevel()
	{
		$department_index_name = D('Department')->where('id='.$this->member['department_id'])->field('index_name')->find();
		$allChargeMember = $this->getAllChargeMember($this->member['cid']);
		$level = '';
		foreach ($allChargeMember as $k => $v) {
			if (in_array($department_index_name['index_name'].$this->member['id'],explode(',',$v))) {
				$level = $k;
			}
		}
		switch ($level) {
			case 'first_charge':
				$nextLevel = 'second_charge';
				break;
			case 'second_charge':
				$nextLevel = 'third_charge';
				break;
		}

		return $nextLevel;
		
	}
/**
 * 判断审核人权限
 * @return [type] [description]
 */
	public function checkAuthority(){

		$department_index_name = D('Department')->where('id='.$this->member['department_id'])->field('index_name')->find();
		$allChargeMember = $this->getAllChargeMember($this->member['cid']);
		$timeInterval = $this->leaveLevelModel->where('cid='.$this->member['cid'])->field('first_min,first_max,second_min,second_max,third_min,third_max')->find();

		$level = '';
		foreach ($allChargeMember as $k => $v) {
			if (in_array($department_index_name['index_name'].$this->member['id'],explode(',',$v))) {
				$level = $k;
			}
		}
		switch ($level) {
			case 'first_charge':
				$timeMin = $timeInterval['first_min'];
				$timeMax = $timeInterval['first_max'];
				break;
			case 'second_charge':
				$timeMin = $timeInterval['second_min'];
				$timeMax = $timeInterval['second_max'];
				break;
			case 'third_charge':
				$timeMin = $timeInterval['third_min'];
				$timeMax = $timeInterval['third_max'];
				break;
		}
		return array($timeMin,$timeMax);
	}

	public function getChargeList($levelStr)
	{
		$condition['cid'] = $this->member['cid'];
		$chargeStr = D('LeaveLevel')->where($condition)->field($levelStr)->find();
		$chargeArray = explode(',',$chargeStr[$levelStr]);

		//查询到自己同部门的所有人
		$sameDepartmentMember = D('Member')->where(['cid'=>$this->member['cid'],'department_id'=>$this->member['department_id']])->field('id')->select();
		$parIndexName = D('Department')->where(['companyid'=>$this->member['cid'],'id'=>$this->member['department_id']])->field('index_name')->find();
	
		foreach ($sameDepartmentMember as $k => $v) {
			$sameDepartmentMember[$k]['idStr'] = $parIndexName['index_name'].$v['id'];
		}
		foreach ($sameDepartmentMember as $ke => $val) {
			for ($i=0; $i <count($chargeArray); $i++) { 

				if ($chargeArray[$i] == $val['idStr']) {
					   $MemberIdList[] = $val['id'];
				}
			}
		}
		$ChargeList = D('Member')->where(['id'=>['IN',$MemberIdList]])->select();

		return $ChargeList;
	}
	/**
	 * 提交下一级审核人
	 */
	public function addNextCharge()
	{
		$res = D('Leave')->save($_POST);
		if ($res ) {
			$return['status'] = 1;
    		$return['info'] = '提交成功';
		}else{
			$return['status'] = 0;
    	$return['info'] = '提交失败';
		}
    	$this->HuiMsg( $return );
	}
	/**
	 * 提交审核结果或者提交到下一级
	 */
	public function addApproval()
	{
		$id['id'] = $_POST['id'];
		if(!empty($_POST['nextCharge'])){
			$map['second_charge'] = $_POST['nextCharge'];
			$res = D('leave')->where($id)->save($map);
			if($res){
				echo "<script language=\"JavaScript\">alert('提交成功');</script>";
				$this->redirect('unapprovallist');
			}
		}
		if(empty($_POST['status'])){
			echo "<script language=\"javascript\">alert('请选择');window.history.back(-1);</script>";
			return false;
		}
		if($_POST['status'] == 2 && empty($_POST['remind'])){
			echo "<script language=\"javascript\">alert('请输入拒绝理由');window.history.back(-1);</script>";
			return false;
		}
		$map['status'] = $_POST['status'];
		$map['passtime'] = time();
		$map['remind'] = $_POST['remind']?$_POST['remind']:'同意请假，注意安全！';
		$res = D('leave')->where($id)->save($map);
		if ($res ) {
			echo "<script language=\"JavaScript\">alert('审批完成');</script>";
			$this->redirect('unapprovallist');
		}else{
			echo "<script language=\"javascript\">alert('网络错误');window.history.back(-1);</script>";
			return false;
		}
	}
	/**
	 * 请假已审核列表
	 * @param  string $value [description]
	 * @return [type]        [description]
	 */
	public function approvallist()
	{
//		$department_index_name = D('Department')->where('id='.$this->member['department_id'])->field('index_name')->find();
	
		// $condition['status'] = ['IN',[1,2]];
		// $condition['first_charge'] = $this->member['id'];
		// $condition['second_charge'] = $this->member['id'];
		// $condition['third_charge'] = $this->member['id'];
		// $condition['_logic'] = 'OR';
//		$condition['status'] = ['IN',[1,2]];
//		$sql = " first_charge = ".$this->member['id'] . ' OR ';
//		$sql .= " second_charge = ".$this->member['id'] . ' OR ';
//		$sql .= " third_charge = ".$this->member['id'];
//		$approvalList = $this->leaveModel->where($condition)->where($sql)->order('id desc')->select();
//		foreach ($approvalList as $k => $v) {
//			$approvalList[$k]['face'] = D('Member')->where('id='. $v['user_id'])->getField('face');
//			$approvalList[$k]['leave_str'] = D('LeaveCate')->where('id='. $v['leave_type_id'])->getField('title');
//		}
// print_r($approvalList);die;
		// foreach ($unapprovallist as $k => $v) {
		// 	$unapprovallist[$k]['face'] = D('Member')->where('id='. $v['user_id'])->getField('face');
		// 	$unapprovallist[$k]['leave_str'] = D('LeaveCate')->where('id='. $v['leave_type_id'])->getField('title');
		// }

		if($this->member['auth'] == 1){
			$map['status'] = array('neq',0);
			$map['cid'] = $this->member['cid'];
			$approvalList = D('leave')->where($map)->field('id,cid,personal_code,first_charge,cc,second_charge,addtime,passtime,leave_cate')->select();
			foreach($approvalList as $k=>$v){
				$code['personal_code'] = $v['personal_code'];
				$code['cid'] = $v['cid'];
				$approvalList[$k]['face'] = D('Member')->where($code)->getField('face');
					if(!in_array($this->member['personal_code'],explode(',',$v['first_charge'])) || $v['second_charge'] != ''){
						unset($approvalList[$k]);
					}
			}
		}
		if($this->member['auth'] == 2){
			$map['second_charge'] = $this->member['personal_code'];
			$map['cid'] = $this->member['cid'];
			$map['status'] = array('neq',0);
			$approvalList = D('leave')->where($map)->field('id,cid,personal_code,first_charge,cc,addtime,passtime,leave_cate')->select();
			foreach($approvalList as $k=>$v){
				$code['personal_code'] = $v['personal_code'];
				$code['cid'] = $v['cid'];
				$approvalList[$k]['face'] = D('Member')->where($code)->getField('face');
			}
		}
		if($this->member['auth'] == 5){
			$map['status'] = array('neq',0);
			$map['cid'] = $this->member['cid'];
			$approvalList = D('leave')->where($map)->select();
			foreach($approvalList as $k=>$v){
				$code['personal_code'] = $v['personal_code'];
				$code['cid'] = $v['cid'];
				$approvalList[$k]['face'] = D('Member')->where($code)->getField('face');
			}
		}
		$this->assign('approvalList',$approvalList);
		$this->display();
	}

	/**
	 * 用车申请
	 * 1、查找可用的车辆
	 * @return [type] [description]
	 */
	public function carApplication(){
		$carModel = D('Car');
		$carCondition['is_delete'] = 0;
		$carCondition['status'] = 0;
		$carCondition['company_id'] = $this->member['cid'];
		$carList = $carModel->where($carCondition)->select();
		$this->assign('carList',$carList);
		$this->member['companyname'] = $this->getUserCompany()['companyname'];
		$this->assign('member',$this->member);
		$this->display();
	}


	/**
	 * 用车审批人选择
	 */
	public function carAuditors(){
		$duration = $this->shicha($_POST['car_start_time'],$_POST['car_end_time']);
		$dataList['car_num'] = $_POST['car_num'];
		$dataList['hour'] = intval((strtotime($_POST['car_end_time']) - strtotime($_POST['car_start_time']))/3600);
		if($dataList['hour'] < 1){
			echo "<script language=\"JavaScript\">\r\n";
			echo " alert('时间太短');\r\n";
			echo " history.back();\r\n";
			echo "</script>";
			return false;
		}
		$dataList['duration'] = $duration['day'].'天'.$duration['hour'].'小时'.$duration['min'].'分钟'.$duration['sec'].'秒';
		$dataList['car_start_time'] = $_POST['car_start_time'];
		$dataList['car_end_time'] = $_POST['car_end_time'];
		$dataList['personal_code'] = $_POST['personal_code'];
		$dataList['companyname'] = $_POST['companyname'];//单位
     	$dataList['cadres'] = $_POST['cadres'];//干部
     	$dataList['mileage'] = $_POST['mileage'];//里程
     	$dataList['caruse'] = $_POST['caruse'];//用途
		//查找一级负责人
//		$firstcondition['cid'] = $this->member['cid'];
//		$firstchargeStr = D('CarLevel')->where($firstcondition)->field('first_charge')->find();
//		$firstchargeArray = explode(',',$firstchargeStr['first_charge']);
//
//		//查询到自己同部门的所有人
//		$sameDepartmentMember = D('Member')->where(['cid'=>$this->member['cid'],'department_id'=>$this->member['department_id'],'id'=>['neq',session('member_auth')['id']]])->field('id')->select();
//
//		// print_r($sameDepartmentMember);die;
//		// print_r(session('member_auth')['id']);die;
//		$parIndexName = D('Department')->where(['companyid'=>$this->member['cid'],'id'=>$this->member['department_id']])->field('index_name')->find();
//
//		foreach ($sameDepartmentMember as $k => $v) {
//			$sameDepartmentMember[$k]['idStr'] = $parIndexName['index_name'].$v['id'];
//		}
//		foreach ($sameDepartmentMember as $ke => $val) {
//			for ($i=0; $i <count($firstchargeArray); $i++) {
//
//				if ($firstchargeArray[$i] == $val['idStr']) {
//					   $firstMemberIdList[] = $val['id'];
//				}
//			}
//		}
//		$firstChargeList = D('Member')->where(['id'=>['IN',$firstMemberIdList]])->select();

//		$this->assign('firstChargeList',$firstChargeList);
		//查找一级审批人
		$map['cid'] = $this->member['cid'];
		$map['department_id'] = $this->member['department_id'];
		$map['auth'] = 1;
		$chargeList = D('member')->where($map)->field('personal_code')->select();
		if($this->member['auth'] == 1){
			$map['personal_code'] = array('neq',$this->member['personal_code']);
			$chargeList = D('member')->where($map)->field('personal_code')->select();
		}
		$HR = D('member')->where(array('auth'=>5,'cid'=>$this->member['cid']))->getField('personal_code');
		$cc = D('member')->where(array('auth'=>4,'cid'=>$this->member['cid'],'department_id'=>$this->member['department_id']))->field('personal_code')->select();
		S('dataList',$dataList,1800);
		$this->assign('HR',$HR);//人事
		$this->assign('cc',$cc);//抄送人
		$this->assign('dataList',$dataList);//申请信息
		$this->assign('chargeList',$chargeList);//审批人和抄送人
		$this->display();
	}

	/**
	 * 提交用车申请
	 */
	public function carAuditorsAdd(){
		if(empty(I('post.firstCharge'))){
			echo "<script language=\"JavaScript\">\r\n";
			echo " alert('请选择审批人');\r\n";
			echo " history.back();\r\n";
			echo "</script>";
			return false;
		}
		$carApplicationModel = D('CarApplication');
		$row = S('dataList');
		$row['addtime'] = time();
		$row['cid'] = $this->member['cid'];
		$row['duration'] = $row['hour'];
		$row['first_charge'] = I('post.firstCharge');
		$cc = I('post.cc');
		$firstCharge = I('post.firstCharge');
		$HR = D('member')->where(array('auth'=>5,'cid'=>$this->member['cid']))->getField('personal_code');
		array_push($cc,$HR);
		$row['cc'] = empty($cc) ? $HR : implode(',',$cc);
		$row['first_charge'] = implode(',',$firstCharge);
		if ($carApplicationModel->create($row)) {
			$res = $carApplicationModel->add($row);
			if ($res ) {
				D('car')->where(array('car_num'=>$row['car_num']))->save(array('status'=>2));
				$return['status'] = 1;
	    		$return['info'] = '提交成功';
			}else{
				$return['status'] = 0;
	    	    $return['info'] = '提交失败';
			}
		}else{
				$return['status'] = 0;
	    	    $return['info'] = '提交失败';
		}

    	$this->HuiMsg( $return );
	}

	/**
	 * 用车申请记录查询
	 * @return [type] [description]
	 */
	public function carRecord(){
//		$page = array();
//		$page['pageNum'] = 20;
//		if ( IS_AJAX && IS_POST ) {
//			$page['page'] = I( 'post.page', 1 );
//		} else {
//			$page['page'] = 1;
//			$page['recordTotal'] = $this->leaveModel->getListCount( $condition );
//		}
//		$begin = ( $page['page'] - 1 ) * $page['pageNum'];
//		$carApplicationModel = D('CarApplication');
//        $carAppList = $carApplicationModel->alias('a');
//         $carAppList =  $carAppList->field('a.*,b.face,b.personal_code');
//        $carAppList =  $carAppList->join('left join db_member AS b ON b.id=a.user_id');
//        $carAppList =  $carAppList->where('a.user_id='.$this->member['id']);
//        $carAppList =  $carAppList->order('addtime desc');
//		if ($_POST) {
//				$leave_type_id = array_filter(explode(',',I('post.cate')));
//				$personal_code = I('post.personal_code');
//				$car_start_time = I('post.car_start_time');
//				$car_end_time = I('post.car_end_time');
				// print_r($car_start_time);die;
//				$state = I('post.status');
//				$car_status = $state!='' ? explode(',',I('post.status')) : [];
//
//		        if (!empty($car_type_id )) {
//
//			        $carAppList =  $carAppList->where(array('a.car_type_id'=>['IN',$car_type_id]));
//			    }
//			    if (!empty($car_status )) {
//			        $carAppList =  $carAppList->where(array('a.status'=>['IN',$car_status]));
//			    }
//			    if ($personal_code ) {
//			    	$user_id = D('Member')->where(['personal_code'=>$personal_code])->getField('id');
//			      	$carAppList =  $carAppList->where(['a.user_id'=>$user_id]);
//			    }
//			    if ($car_start_time && $car_end_time ) {
//					$map['car_start_time']  = array('between',array($car_start_time,$car_end_time));
//			    }
			    // if ($car_end_time ) {
			    //   	$carAppList =  $carAppList->where(['a.car_end_time'=>['like','%'.$car_end_time.'%']]);
			    // }
//		    $carAppList =  $carAppList->limit ( $begin, $page['pageNum'] )->select();
			   // print_r($this->carModel->getLastSql());die;

//		    echo json_encode(['status' => 1 , 'info' => '查询成功' , 'data' => $carAppList]);die;
//		}
//     	$carAppList =  $carAppList->limit ( $begin, $page['pageNum'] )->select();
//        $this->assign('carAppList',$carAppList);
        // //请假类型
        // $carCateList = $this->carCateModel->where(['cid'=>$this->member['cid'],'is_delete'=>0,'status'=>0])->select();
//        $this->assign('page',$page);
		if($_POST){
			$car_start_time = I('post.car_start_time');
			$car_end_time = I('post.car_end_time');
			if ($car_start_time && $car_end_time ) {
				$map['car_start_time']  = array('between',array($car_start_time,$car_end_time));
			}
		}
		if($_GET){
			$status = I('get.lab');
			if(isset($status)){
				$map['status'] = $status;
			}
		}
		$map['personal_code'] = $this->member['personal_code'];
		$map['cid'] = $this->member['cid'];
		$field = 'id,car_num,personal_code,status,addtime';
		$carAppList = D('car_application')->where($map)->field($field)->order('addtime desc')->limit(20)->select();
        $this->assign('member',$this->member);
        $this->assign('carAppList',$carAppList);
		$this->display();

	}

	/**
	 *用车审核通过详情页面
	 */
	public function carRecordRead(){
		$id = I('get.id');
		if(I('get.new') == 1){
			$carInfo = $this->carApplicationModel->where(array('status'=>1,'personal_code'=>$this->member['personal_code']))->order('id desc')->limit(1)->find();
			if($carInfo == null){
				$this->assign('new',1);
			}
		}else{
			$carInfo = $this->carApplicationModel
				->alias('a')
				->field('a.*,b.face,b.personal_code')
				->join('left join db_member AS b ON b.personal_code=a.personal_code')
				->where('a.id='.$id)
				->find();
		}
        $shicha = $this->shicha($carInfo['car_start_time'],$carInfo['car_end_time']);
        $carInfo['shicha'] = $shicha['day'].'天'.$shicha['hour'].'小时'.$shicha['min'].'分钟'.$shicha['sec'].'秒';
//        // $carInfo['tips'] = explode(',',$carInfo['tips']);
       // dump($carInfo);die;
//        //根据类型查找Mac
		$map['is_delete'] = 0;
		$map['company_id'] = $this->member['cid'];
		$map['mac_type'] = 0;//0车辆1门禁
		$macs = '';
		$Mac = D('Mac')->where($map)->field('mac')->select();
		 for($i = 0;$i < count($Mac);$i++){
        	$macs = $Mac[$i]['mac'].' '.$macs;
        }
//        $Mac = D('Mac')->where(['is_delete'=>0,'company_id'=>$this->getUserCompany()['cid'],'mac_type'=>0,'car_num'=>$carInfo['car_num']])->getField('mac');
//        //申请人personal_code
		// $apppersonal_code = substr($carInfo['personal_code'],2);
//        $apppersonal_code = D('Member')->where(['id'=>$carInfo['user_id']])->getField('personal_code');
		$car_id = D('car')->where(array('car_num'=>$carInfo['car_num']))->getField('car_id');
      	$a = '2'.sprintf ( "%02d",00).mb_substr($carInfo['caruse'],0,5,'utf-8');
	    $b = $car_id;
	    $c = substr(date('YmdHis',strtotime($carInfo['car_start_time'])),2);
	    $d = substr(date('YmdHis',strtotime($carInfo['car_end_time'])),2);
	    $e = $macs;
	    // dump($e);die;
	    exec('java -jar /etc/XXTEACAI.jar '.$a.' '.$b.' '.$c.' '.$d.' '.$e,$output);

	    $encode = mb_detect_encoding(current(array_filter($output)), array("ASCII","UTF-8","GB2312","GBK","BIG5"));
	    $string = iconv("UTF-8","ASCII",current(array_filter($output)));
//
//	        // print_r($leaveInfo['leave_start_time']);
//	        // print_r(substr(date('YmdHis'),2));
//	    // print_r(sprintf ( "%02d",$leaveInfo['leave_type_id']));
//	        // print_r($a);
//	        // die;
//	        // return $string;
	    $code = $this->member['personal_code'];
		$filename = "Uploads/erweima/$code.png";
		$this->create_erweima ( $filename, $string );
        $this->assign('erweima',$filename);
        $this->assign('carInfo',$carInfo);
		$this->display();
	}
	/**
	 * 派车已审核，未审核页面
	 * @return [type] [description]
	 */
	public function carApproval(){
		if($this->member['auth'] == 1){
			$unapprovalCount = D('car_application')->where(array('status'=>0,'cid'=>$this->member['cid']))->field('id,first_charge,second_charge')->select();
			foreach($unapprovalCount as $k=>$v){
					if(!in_array($this->member['personal_code'],explode(',',$v['first_charge'])) || $v['second_charge'] != ''){
						unset($unapprovalCount[$k]);
					}
			}
			$unapprovalCount = count($unapprovalCount);
		}
		if($this->member['auth'] == 2){
			$map['second_charge'] = $this->member['personal_code'];
			$map['cid'] = $this->member['cid'];
			$map['status'] = 0;
			$unapprovalCount = D('car_application')->where($map)->count();
		}
		if($this->member['auth'] == 5){
			$unapprovalCount = D('car_application')->where(array('status'=>0,'cid'=>$this->member['cid']))->count();
		}
		$this->assign('carUnapprovalCount',$unapprovalCount);
		$this->display();
	}

	/**
	 * 获取所有派车列表
	 * @param  [type] $status [description]
	 * @return [type]         [description]
	 */
	public function getAllCarApprovalList($status){
		$department_index_name = D('Department')->where(['id'=>$this->member['department_id'],'companyid'=>$this->member['cid']])->field('index_name')->find();
		$allChargeMember = $this->getAllCarChargeMember($this->member['cid']);
		$level = '';
		foreach ($allChargeMember as $k => $v) {
			if (in_array($department_index_name['index_name'].$this->member['id'],explode(',',$v))) {
				$level = $k;
			}
		}

		$condition['status'] = $status;
		$condition[$level] = $this->member['id'];
		$approvalList = $this->carApplicationModel->where($condition)->order('id desc')->select();

		return $approvalList;

	}

	/**
	 * 获取所有级别的负责人
	 * @param  [type] $cid [description]
	 * @return [type]      [description]
	 */
	public function getAllCarChargeMember($cid){

		$allChargeMember = $this->carLevelModel->where('cid='.$cid)->field('first_charge,second_charge,third_charge')->find();
		return $allChargeMember;
	}

	/**
	 * 未审批列表
	 * @return [type] [description]
	 */
	public function carUnapprovallist(){

//		$unapprovallist = $this->getAllCarApprovalList(0);

//		foreach ($unapprovallist as $k => $v) {
//			$unapprovallist[$k]['face'] = D('Member')->where('id='. $v['user_id'])->getField('face');
//			// $unapprovallist[$k]['leave_str'] = D('LeaveCate')->where('id='. $v['leave_type_id'])->getField('title');
//		}
//		$map['first_charge'] = $this->member['personal_code'] ;
//		$map['status'] = 0;
//		$unapprovallist = D('car_application')->where($map)->field('id,status,addtime,car_num,personal_code')->select();
//		foreach($unapprovallist as $k=>$v){
//			$face['personal_code'] = $v['personal_code'];
//			$unapprovallist[$k]['face'] = D('Member')->where($face)->getField('face');
//		}
//		if(!$unapprovallist){
//			$this->redirect('carApproval');
//		}
		if($this->member['auth'] == 1){
			$map['status'] = 0;
			$map['cid'] = $this->member['cid'];
			$field = 'id,cid,personal_code,car_num,addtime,first_charge,cc,second_charge';
			$unapprovallist = D('car_application')->where($map)->field($field)->order('addtime desc')->select();
			foreach ($unapprovallist as $k => $v) {
				$code['personal_code'] = $v['personal_code'];
				$code['cid'] = $v['cid'];
				$unapprovallist[$k]['face'] = D('Member')->where($code)->getField('face');
				if(!in_array($this->member['personal_code'],explode(',',$v['first_charge'])) || $v['second_charge'] != ''){
					unset($unapprovallist[$k]);
				}
			}
			if(!$unapprovallist){
				$this->redirect('carApproval');
			}
		}
		if($this->member['auth'] == 2){
			$map['second_charge'] = $this->member['personal_code'];
			$map['cid'] = $this->member['cid'];
			$map['status'] = 0;
			$unapprovallist = D('car_application')->where($map)->field('id,cid,personal_code,addtime,car_num')->order('addtime desc')->select();
			foreach ($unapprovallist as $k => $v) {
				$code['personal_code'] = $v['personal_code'];
				$code['cid'] = $v['cid'];
				$unapprovallist[$k]['face'] = D('Member')->where($code)->getField('face');
			}
			if(!$unapprovallist){
				$this->redirect('carApproval');
			}
		}
		if($this->member['auth'] == 5){
			$unapprovallist = D('car_application')->where(array('status'=>0,'cid'=>$this->member['cid']))->field('id,cid,personal_code,addtime,car_num')->order('addtime desc')->select();
			foreach ($unapprovallist as $k => $v) {
				$code['personal_code'] = $v['personal_code'];
				$code['cid'] = $v['cid'];
				$unapprovallist[$k]['face'] = D('Member')->where($code)->getField('face');
			}
			if(!$unapprovallist){
				$this->redirect('carApproval');
			}
		}
		$this->assign('unapprovallist',$unapprovallist);
		$this->display();
	}
	/**
	 * 用车审批，判断是否需要上一级
	 * @return [type] [description]
	 */
	public function carApprovalRead(){
		$id = I('get.id');
//        $this->assign('id',$id);//当前请假id
//		$approvalInfo  = $this->carApplicationModel
//							  ->alias('a')
//							  ->field('a.*,b.face,b.personal_code')
//							  ->join('left join db_member AS b ON b.id = a.user_id')
//							  ->where('a.id = '.$id)
//							  ->find();
//		$jetLag = intval(strtotime($approvalInfo['car_end_time'])-strtotime($approvalInfo['car_start_time']))/3600;
//		$shicha = $this->shicha($approvalInfo['car_start_time'],$approvalInfo['car_end_time']);
//        $approvalInfo['shicha'] = $shicha['day'].'天'.$shicha['hour'].'小时'.$shicha['min'].'分钟'.$shicha['sec'].'秒';
//
//
//        //判断审核人是否有权限审核，若没有及提交给下一级审核
//        if ($jetLag > $this->checkCarAuthority()[1]) {
//        	$nextLevel = $this->getNextCarLevel();
//        	$nextChargeList = $this->getCarChargeList($nextLevel);
//		// print_r(1);die;
//
//
//        	$this->assign('authority',1);//提交审核到下一级
//        	$this->assign('nextChargeList',$nextChargeList);//提交审核到下一级
//        	$this->assign('nextLevel',$nextLevel);//提交审核到下一级
//        	$this->assign('id',$id);//当前请假id
//
//        	$nextLevelCharge =$this->carLevelModel->where('id='.$id)->getField($nextLevel);//获取下一级的负责人id
//        	$this->assign('nextLevelCharge',$nextLevelCharge);
//
//
//        }
//
//        //查找审批短语
//        $phraseList = D('Phrase')->where(['cid'=>$this->member['cid'],'is_delete'=>0,'type'=>2])->select();
//		$approvalInfo = D('car_application')->where('id='.$id)->find();

		$approvalInfo = D('car_application')->where('id='.$id)->find();
		$approvalInfo['hour'] = intval((strtotime($approvalInfo['car_end_time']) - strtotime($approvalInfo['car_start_time'])) / 3600);
		if($approvalInfo['hour'] >= $this->member['range_time']){
			$map['auth'] = 2;
			$map['cid'] = $this->member['cid'];
			$map['department_id'] = $this->member['department_id'];
			$map['personal_code'] = array('neq',$this->member['personal_code']);
			$nextChargeList = D('member')->where($map)->field('personal_code')->select();
			$this->assign('authority',1);
			$this->assign('id',$id);
			$this->assign('nextChargeList',$nextChargeList);
		}
        $this->assign('phraseList','同意批假，外出注意安全！');
		$this->assign('approvalInfo',$approvalInfo);
		$this->display();
	}
/**
 * 获取当前会员的下一级
 * @return [type] [description]
 */
	public function getNextCarLevel()
	{
		$department_index_name = D('Department')->where(['id'=>$this->member['department_id'],'companyid'=>$this->member['cid']])->field('index_name')->find();
		$allChargeMember = $this->getAllCarChargeMember($this->member['cid']);
		$level = '';
		foreach ($allChargeMember as $k => $v) {
			if (in_array($department_index_name['index_name'].$this->member['id'],explode(',',$v))) {
				$level = $k;
			}
		}
		switch ($level) {
			case 'first_charge':
				$nextLevel = 'second_charge';
				break;
			case 'second_charge':
				$nextLevel = 'third_charge';
				break;
		}

		return $nextLevel;
		
	}

	/**
 * 判断审核人权限
 * @return [type] [description]
 */
	public function checkCarAuthority(){

		$department_index_name = D('Department')->where(['id'=>$this->member['department_id'],'companyid'=>$this->member['cid']])->field('index_name')->find();
		$allChargeMember = $this->getAllCarChargeMember($this->member['cid']);
		$timeInterval = $this->carLevelModel->where('cid='.$this->member['cid'])->field('first_min,first_max,second_min,second_max,third_min,third_max')->find();

		$level = '';
		foreach ($allChargeMember as $k => $v) {
			if (in_array($department_index_name['index_name'].$this->member['id'],explode(',',$v))) {
				$level = $k;
			}
		}
		switch ($level) {
			case 'first_charge':
				$timeMin = $timeInterval['first_min'];
				$timeMax = $timeInterval['first_max'];
				break;
			case 'second_charge':
				$timeMin = $timeInterval['second_min'];
				$timeMax = $timeInterval['second_max'];
				break;
			case 'third_charge':
				$timeMin = $timeInterval['third_min'];
				$timeMax = $timeInterval['third_max'];
				break;
		}
		return array($timeMin,$timeMax);
	}
/**
 * 获取负责人列表
 * @param  [type] $levelStr [description]
 * @return [type]           [description]
 */
	public function getCarChargeList($levelStr)
	{
		$condition['cid'] = $this->member['cid'];
		$chargeStr = D('LeaveLevel')->where($condition)->field($levelStr)->find();
		$chargeArray = explode(',',$chargeStr[$levelStr]);

		//查询到自己同部门的所有人
		$sameDepartmentMember = D('Member')->where(['cid'=>$this->member['cid'],'department_id'=>$this->member['department_id']])->field('id')->select();
		$parIndexName = D('Department')->where(['companyid'=>$this->member['cid'],'id'=>$this->member['department_id']])->field('index_name')->find();
	
		foreach ($sameDepartmentMember as $k => $v) {
			$sameDepartmentMember[$k]['idStr'] = $parIndexName['index_name'].$v['id'];
		}
		foreach ($sameDepartmentMember as $ke => $val) {
			for ($i=0; $i <count($chargeArray); $i++) { 

				if ($chargeArray[$i] == $val['idStr']) {
					   $MemberIdList[] = $val['id'];
				}
			}
		}
		$ChargeList = D('Member')->where(['id'=>['IN',$MemberIdList]])->select();

		return $ChargeList;
	}

	/**
	 * 提交下一级审核人
	 */
	public function addCarNextCharge()
	{
		$res = D('CarApplication')->save($_POST);

		if ($res ) {
			$return['status'] = 1;
    		$return['info'] = '提交成功';
		}else{
			$return['status'] = 0;
    	$return['info'] = '提交失败';
		}

    	$this->HuiMsg( $return );

	}

	/**
	 * 提交审核结果或上一级
	 */
	public function addCarApproval()
	{
		$id['id'] = $_POST['id'];
		if(!empty($_POST['nextCharge'])){
			$map['second_charge'] = $_POST['nextCharge'];
			$res = D('car_application')->where($id)->save($map);
			if($res){
				echo "<script language=\"javascript\">alert('提交成功');</script>";
				$this->redirect('carUnapprovallist');
			}
		}
		if(empty($_POST['status'])){
			echo "<script language=\"javascript\">alert('请选择');window.history.back(-1);</script>";
			return false;
		}
		$map['status'] = $_POST['status'];
		$map['passtime'] = time();
		$map['remind'] = $_POST['remind']?$_POST['remind']:'同意请假，外出注意安全！';
		if($_POST['status'] == 2 && empty($_POST['remind'])){
			echo "<script language=\"javascript\">alert('请输入拒绝理由');window.history.back(-1);</script>";
			return false;
		}
		$res = D('car_application')->where($id)->save($map);
		if ($res ) {
			if($_POST['status'] == 1){
				D('car')->where(array('car_num'=>$_POST['car_num']))->save(array('status'=>1));
			}
			if($_POST['status'] == 2){
				D('car')->where(array('car_num'=>$_POST['car_num']))->save(array('status'=>0));
			}
			$this->redirect('carUnapprovallist');
		}else{
			echo "<script language=\"javascript\">alert('网络错误');window.history.back(-1);</script>";
			return false;
		}
	}

	/**
 * 用车申请已审核列表
 * @param  string $value [description]
 * @return [type]        [description]
 */
	public function carApprovallist()
	{
//		$department_index_name = D('Department')->where('id='.$this->member['department_id'])->field('index_name')->find();
	
//		$condition['status'] = ['IN',[1,2]];
		// $condition['first_charge'] = $this->member['id'];
		// $condition['second_charge'] = $this->member['id'];
		// $condition['third_charge'] = $this->member['id'];
		// $condition['_logic'] = 'OR';

//		$sql = " first_charge = ".$this->member['id'] . ' OR ';
//		$sql .= " second_charge = ".$this->member['id'] . ' OR ';
//		$sql .= " third_charge = ".$this->member['id'];

		// $condition[$level] = $this->member['id'];
//		$carapprovalList = $this->carApplicationModel->where($condition)->where($sql)->order('id desc')->select();
//		foreach ($carapprovalList as $k => $v) {
//			$carapprovalList[$k]['face'] = D('Member')->where('id='. $v['user_id'])->getField('face');
//		}
// print_r($approvalList);die;
		// foreach ($unapprovallist as $k => $v) {
		// 	$unapprovallist[$k]['face'] = D('Member')->where('id='. $v['user_id'])->getField('face');
		// 	$unapprovallist[$k]['leave_str'] = D('LeaveCate')->where('id='. $v['leave_type_id'])->getField('title');
		// }
//		$this->assign('carapprovalList',$carapprovalList);

		// print_r($this->carApplicationModel->getLastSql());die;
//		$map['first_charge'] = $this->member['personal_code'];
//		$carapprovalList = D('car_application')->where($map)->where('status','<>',0)->field('id,car_num,addtime,passtime,personal_code')->select();
//		foreach($carapprovalList as $k=>$v){
//			$face['personal_code'] = $v['personal_code'];
//			$carapprovalList[$k]['face'] = D('Member')->where($face)->getField('face');
//		}
		if($this->member['auth'] == 1){
			$map['stauts'] = array('neq',0);
			$map['cid'] = $this->member['cid'];
			$approvalList = D('car_application')->where($map)->field('id,cid,personal_code,first_charge,second_charge,cc,addtime,passtime,car_num')->select();
			foreach($approvalList as $k=>$v){
				$code['personal_code'] = $v['personal_code'];
				$code['cid'] = $v['cid'];
				$approvalList[$k]['face'] = D('Member')->where($code)->getField('face');
				if(!in_array($this->member['personal_code'],explode(',',$v['first_charge'])) || $v['second_charge'] != ''){
					unset($approvalList[$k]);
				}
			}
		}
		if($this->member['auth'] == 2){
			$map['second_charge'] = $this->member['personal_code'];
			$map['status'] = array('neq',0);
			$map['cid'] = $this->member['cid'];
			$approvalList = D('car_application')->where($map)->field('id,cid,personal_code,first_charge,cc,addtime,passtime,car_num')->select();
			foreach($approvalList as $k=>$v){
				$code['personal_code'] = $v['personal_code'];
				$code['cid'] = $v['cid'];
				$approvalList[$k]['face'] = D('Member')->where($code)->getField('face');
			}
		}
		if($this->member['auth'] == 5){
			$map['status'] = array('neq',0);
			$map['cid'] = $this->member['cid'];
			$approvalList = D('car_application')->where($map)->field('id,cid,personal_code,first_charge,cc,addtime,passtime,car_num')->select();
			foreach($approvalList as $k=>$v){
				$code['personal_code'] = $v['personal_code'];
				$code['cid'] = $v['cid'];
				$approvalList[$k]['face'] = D('Member')->where($code)->getField('face');
			}
		}
		$this->assign('carapprovalList',$approvalList);
		$this->display();
	}

	// public function getQR()
	// {
	// 	$a = 'aaa';
	//    $b = 12365478;

	//     try {
	//         exec('java -jar /etc/alternatives/jre/lib/ext/XXTEACAI.jar '.$a.' '.$b,$output);

	//         $encode = mb_detect_encoding(current(array_filter($output)), array("ASCII","UTF-8","GB2312","GBK","BIG5"));
	//         $string = iconv("UTF-8","ASCII",current(array_filter($output))); 
	      
	//         // print_r($string);
	//         // // print_r($output);
	//         // die;
	//         // return $string;
	//         // $this->assign('string',$string);
	//         // $this->display();
	//         // 
	//         vendor( 'phpqrcode.phpqrcode' );
	// 	      $value = $string; //二维码内容 
	// 	      $errorCorrectionLevel = 'L';//容错级别 
	// 	      $matrixPointSize = 6;//生成图片大小 
	// 	      //生成二维码图片 
	// 	      \QRcode::png($value, 'qrcode.png', $errorCorrectionLevel, $matrixPointSize, 2); 
	// 	      $logo = 'logo.png';//准备好的logo图片 
	// 	      $QR = 'qrcode.png';//已经生成的原始二维码图 
		        
	// 	      if ($logo !== FALSE) { 
	// 	          $QR = imagecreatefromstring(file_get_contents($QR)); 
	// 	          $logo = imagecreatefromstring(file_get_contents($logo)); 
	// 	          $QR_width = imagesx($QR);//二维码图片宽度 
	// 	          $QR_height = imagesy($QR);//二维码图片高度 
	// 	          $logo_width = imagesx($logo);//logo图片宽度 
	// 	          $logo_height = imagesy($logo);//logo图片高度 
	// 	          $logo_qr_width = $QR_width / 5; 
	// 	          $scale = $logo_width/$logo_qr_width; 
	// 	          $logo_qr_height = $logo_height/$scale; 
	// 	          $from_width = ($QR_width - $logo_qr_width) / 2; 
	// 	          //重新组合图片并调整大小 
	// 	          imagecopyresampled($QR, $logo, $from_width, $from_width, 0, 0, $logo_qr_width,  
	// 	          $logo_qr_height, $logo_width, $logo_height); 
	// 	      } 
	// 	      //输出图片 
	// 	        imagepng($QR, 'helloweba.png');
	// 	      //   // Header("Content-type: image/png");
	// 	      // echo '<img src="helloweba.png" alt="11">'; die;

	//     } catch (JavaException $ex) {
	//       echo "An exception occured: "; echo $ex; echo "<br>\n";
	//     }
	// }


	private function create_erweima($filename, $url) {
		if (file_exists ( $filename )) {
			unlink($filename);
		}
		if ( !file_exists ( $filename )) {
			vendor ( 'phpqrcode.phpqrcode' );
			$errorCorrectionLevel = "L";
			$matrixPointSize = "5.5";
			\QRcode::png ( $url, $filename, $errorCorrectionLevel, $matrixPointSize, 2 );
			// 读取背景图片
			$groundImage = 'Public/Home/Images/shouzhiyin_03.png';
			if (! empty ( $groundImage ) && file_exists ( $groundImage )) {
				// 获取图片大小
				$ground_info = getimagesize ( $groundImage );
				// 宽
				$ground_w = $ground_info [0];
				// 高
				$ground_h = $ground_info [1];
				//
				$ground_im = imagecreatefrompng ( $groundImage );
			}
			// 读取二维码图片
			$codeImage = $filename;
			if (! empty ( $codeImage ) && file_exists ( $codeImage )) {
				// 获取图片大小
				$code_info = getimagesize ( $codeImage );
				// 宽
				$code_w = $code_info [0];
				// 高
				$code_h = $code_info [1];
				//
				$code_im = imagecreatefrompng ( $codeImage );
			}
			// 设定图像的混色模式
			imagealphablending ( $ground_im, true );
			// 拷贝二维码到目标文件
			imagecopy ( $ground_im, $code_im, 9, 9, 0, 0, $code_w, $code_h );
			imagepng ( $ground_im, $codeImage );
			if (isset ( $code_info )) {
				unset ( $code_info );
			}
			if (isset ( $code_im )) {
				imagedestroy ( $code_im );
			}
			unset ( $ground_info );
			imagedestroy ( $ground_im );
		}
	}





}