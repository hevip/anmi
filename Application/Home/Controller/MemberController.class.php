<?php
namespace Home\Controller;

/**
 * 会员中心
 *
 * @author BoBo
 *        
 */
class MemberController extends CommController {

	/**
	 * 构造函数
	 */
	public function _initialize() {
		parent::_initialize ();
		// if (strpos ( '|app|recommend|edit_pass|', '|' . ACTION_NAME . '|' ) === false) {
		// 	$this->checkLogin ();
		// }
		// if(ACTION_NAME=='recommend'){
		// 	session('recommend_url','recommend');
			$this->checkLogin ();
	}

	/**
	 * 最新消息公用方法
	 */
	private function comm_newsInfo() {
		$user = $this->member;
		$user_create_time = $user ['create_time'];
		// 查询出从会员开始注册到现在管理员所发的消息
		$data ['create_time'] = $user_create_time;
		$data ['status'] = 1;
		$dataList = D ( 'MemberNews' )->where ( $data )->select ();
		// 查询出会员阅读了哪些消息
		$isShow = D ( 'MemberIsshow' )->where ( 'member_id=' . $user ['id'] )->find ();
		if ($isShow == null) { // 如果会员未阅读过咋、则全标示为新消息
			$newShow = count ( $dataList );
		} else {
			$arrayId = array ();
			$array = explode ( ',', $isShow ['is_new'] );
			$newShow = 0;
			foreach ( $dataList as $key => $val ) {
				if (! in_array ( $val ['id'], $array )) { // 假如该消息未阅读过，则长度+1
					$newShow ++;
				}
			}
		}
		// 计算出消费额，根据所有的订单来计算
		$dataInfo = D ( 'Order' )->where ( 'uid=' . $user ['id'] . ' and is_pay=1' )->select ();
		$totlalPrice = 0;
		if ($dataInfo) {
			foreach ( $dataInfo as $val ) {
				$totlalPrice += $val ['price'];
			}
		}
		$this->assign ( 'totlalPrice', $totlalPrice );
		$this->assign ( 'newShow', $newShow );
	}

	function unapprovallist()
	{
		if($this->member['auth'] == 1){
			$map['status'] = 0;
			$field = 'id,personal_code,addtime,leave_cate,first_charge,cc,second_charge';
			$leave = D('leave')->where($map)->field($field)->select();
			$car = D('car_application')->where($map)->field('id,car_num,status,addtime,cc,first_charge,second_charge')->select();
			$unapprovallist = count($this->fore($leave)) + count($this->fore($car));
			$this->assign('leave',count($this->fore($leave)));
			$this->assign('car',count($this->fore($car)));
		}
		if($this->member['auth'] == 2){
			$map['second_charge'] = $this->member['personal_code'];
			$map['status'] = 0;
			$leave = D('leave')->where($map)->count();
			$car = D('car_application')->where($map)->count();
			$unapprovallist = $leave + $car;
			$this->assign('leave',$leave);
			$this->assign('car',$car);
		}
		if($this->member['auth'] == 5){
			$leave = D('leave')->where('status=0')->count();
			$car = D('car_application')->where('status=0')->count();
			$unapprovallist = $leave + $car;
			$this->assign('leave',$leave);
			$this->assign('car',$car);
		}
		$this->assign('unapprovallist',$unapprovallist);
		$this->display();
	}
	function approvalRead(){
		$id = I('get.id');
		$approvalInfo = D('leave')->where('id='.$id)->find();
		$approvalInfo['hour'] = intval((strtotime($approvalInfo['leave_end_time']) - strtotime($approvalInfo['leave_start_time'])) / 3600);
		if($approvalInfo['hour'] >= $this->member['range_time']){
			$map['auth'] = 2;
			$map['cid'] = $this->member['cid'];
			$map['department_id'] = $this->member['department_id'];
			$map['personal_code'] = array('neq',$this->member['personal_code']);
			$nextChargeList = D('member')->where($map)->field('personal_code')->select();
			$this->assign('authority',1);
			$this->assign('nextChargeList',$nextChargeList);
		}
		$this->assign('phraseList','同意请假，注意安全！');
		$this->assign('approvalInfo',$approvalInfo);

		$this->display();
	}
	function addApproval()
	{
		$id['id'] = $_POST['id'];
		if(isset($_POST['nextCharge'])){
			$map['second_charge'] = $_POST['nextCharge'];
			$res = D('leave')->where($id)->save($map);
			if($res){
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
			$this->redirect('unapprovallist');
		}else{
			echo "<script language=\"javascript\">alert('网络错误');window.history.back(-1);</script>";
			return false;
		}
	}
	function leaveRecord()
	{
		$map['personal_code'] = $this->member['personal_code'];
		$leave = D('leave')->where('status','<>',0)->where($map)->order('addtime desc')->select();
		$car = D('car_application')->where('status','<>',0)->where($map)->order('addtime desc')->select();
		$this->assign ( 'leaveList', $leave);
		$this->assign ( 'car', $car);
		$this->assign ( 'count', count($leave)+count($car));
		$this->assign ( 'face', $this->member['face']);
		$this->display();
	}

	function notice(){
		$notice = D('Article')->where('pid=17')->order('create_time desc')->select();
		$this->assign('notice',$notice);
		$this->display();
	}
	function noticeDetail(){
		$notice = D('Article')->where('id='.$_GET['id'])->find();
		$this->assign('notice',$notice);
		$this->display();
	}
	function carApprovalRead(){
		$id = I('get.id');
		$approvalInfo = D('car_application')->where('id='.$id)->find();
		$approvalInfo['hour'] = intval((strtotime($approvalInfo['car_end_time']) - strtotime($approvalInfo['car_start_time'])) / 3600);
		if($approvalInfo['hour'] >= $this->member['range_time']){
			$map['auth'] = 2;
			$map['cid'] = $this->member['cid'];
			$map['department_id'] = $this->member['department_id'];
			$map['personal_code'] = array('neq',$this->member['personal_code']);
			$nextChargeList = D('member')->where($map)->field('personal_code')->select();
			$this->assign('authority',1);
			$this->assign('nextChargeList',$nextChargeList);
		}
		$this->assign('phraseList','同意批假，外出注意安全！');
		$this->assign('approvalInfo',$approvalInfo);

		$this->display();
	}
	function addCarApproval()
	{
		$id['id'] = $_POST['id'];
		if(isset($_POST['nextCharge'])){
//			$map['cc'] = '';
//			$map['first_charge'] = '';
			$map['second_charge'] = $_POST['nextCharge'];
			$res = D('car_application')->where($id)->save($map);
			if($res){
				$this->redirect('unapprovallist');
			}
		}
		if(empty($_POST['status'])){
			echo "<script language=\"javascript\">alert('请选择');window.history.back(-1);</script>";
			return false;
		}
		$map['status'] = $_POST['status'];
		$map['passtime'] = time();
		$map['remind'] = $_POST['remind']?$_POST['remind']:'同意请假，外出注意安全！';
		if($this->member['auth'] == 1){
			$map['first_charge'] = $this->member['personal_code'];
			$map['cc'] = '';
		}
		if($this->member['auth'] == 2){
			$map['second_charge'] = $this->member['personal_code'];
			$map['first_charge'] = '';
			$map['cc'] = '';
		}
		if($_POST['status'] == 2 && empty($_POST['remind'])){
			echo "<script language=\"javascript\">alert('请输入拒绝理由');window.history.back(-1);</script>";
			return false;
		}
		$res = D('car_application')->where($id)->save($map);
		if ($res ) {
			$this->redirect('unapprovallist');
		}else{
			echo "<script language=\"javascript\">alert('网络错误');window.history.back(-1);</script>";
			return false;
		}
//		$res = D('CarApplication')->save($_POST);
//		if ($res ) {
//			$return['status'] = 1;
//    		$return['info'] = '提交成功';
//		}else{
//			$return['status'] = 0;
//    	$return['info'] = '提交失败';
//		}
//    	$this->HuiMsg( $return );
	}
	/**
	 * 会员中心
	 */
	public function index() {


		$this->display ();
	}

	// protected $idList = '';

	// protected $fenshi = 0;

	public function getMemberList($recommend, $type) {
		$memberModel = D ( 'Member' );
		$newArray = $memberModel->where ( array ('recommended_code' => $recommend ) )->select ();
		for($i = 0, $size = count ( $newArray ); $i < $size; $i ++) {
			$this->fenshi += 1;
			if ($newArray [$i] ['level'] > 1 && $type == 1) {
				$this->idList .= empty ( $this->idList ) ? $newArray [$i] ['id'] : "," . $newArray [$i] ['id'];
			} else if ($newArray [$i] ['level'] == 1 && $type == 0) {
				$this->idList .= empty ( $this->idList ) ? $newArray [$i] ['id'] : "," . $newArray [$i] ['id'];
			}
			$this->getMemberList ( $newArray [$i] ['referral_code'], $type );
		}
		return $this->idList;
	}

	/**
	 * 会员消息列表页
	 */
	public function news() {
		$this->comm_newsInfo ();
		$model = D ( 'MemberNews' );
		$data ['status'] = 1;
		$dataList = $model->where ( $data )->group ( 'stick desc,create_time desc' )->select ();
		// 查询出会员阅读了哪些消息
		$session = session ( 'member_auth' );
		$isShow = D ( 'MemberIsshow' )->where ( 'member_id=' . $session ['id'] )->find ();
		if ($isShow == null) { // 如果会员未阅读过则全标示为新消息,并为会员增加一条阅读管理信息
			$data ['member_id'] = $session ['id'];
			D ( 'MemberIsshow' )->add ( $data );
			foreach ( $dataList as $key => $val ) {
				$dataList [$key] ['isshow'] = '1';
			}
		} else {
			$arrayId = array ();
			$array = explode ( ',', $isShow ['is_new'] );
			$newShow = 0;
			foreach ( $dataList as $key => $val ) {
				if (! in_array ( $val ['id'], $array )) { // 假如该消息未阅读过，则标记为新
					$dataList [$key] ['isshow'] = '1';
					$num [$key] = 1;
				} else {
					$dataList [$key] ['isshow'] = '0';
					$num [$key] = 0;
				}
			}
			array_multisort ( $num, SORT_NUMERIC, SORT_DESC, $dataList ); // 重新排序，将最新消息排在最前面，未读消息
		}
		$this->assign ( 'dataList', $dataList );
		$this->display ();
	}

	/**
	 * 会员信息展示页
	 */
	public function news_show() {
		$this->comm_newsInfo ();
		$model = D ( 'MemberNews' );
		$id = I ( 'get.id', '0' );
		if ($id > 0) {
			$dataInfo = $model->where ( 'id=' . $id )->find ();
			$session = session ( 'member_auth' );
			$isShow = D ( 'MemberIsshow' )->where ( 'member_id=' . $session ['id'] )->find ();
			$array = explode ( ',', $isShow ['is_new'] );
			if (! in_array ( $dataInfo ['id'], $array )) { // 假如该消息未阅读过
			                                               // 将这条消息标记为该用户一已读
				$str = $isShow ['is_new'] . $id . ',';
				$a = D ( 'MemberIsshow' )->where ( 'id=' . $isShow ['id'] )->save ( array ('is_new' => $str ) );
			}
			$this->assign ( 'dataInfo', $dataInfo );
		}
		$this->display ();
	}



	/**
	 * 更新个人信息
	 */
	public function update() {
		header ( 'Content-type: text/html; charset=utf-8' );
		if (IS_POST) {
			$return = D ( 'Member' )->update ( $_POST );
			if (empty ( $return ['status'] )) {
				$this->error ( $return ['info'] );
			} else {
				$this->success ( $return ['info'], U ( 'Member/update' ) );
			}
		} else {
			$this->member['companyname'] = D('Company')->where(['id'=>$this->member['cid']])->getField('companyname');
			$this->member['department'] = D('Department')->where(['id'=>$this->member['department_id']])->getField('department_name');
	
			$this->assign('member',$this->member);
			// 栏目名称
			$this->assign ( 'columnTitle', '更新个人信息' );
			// 渲染模板
			$this->display ();
		}
	}





	/**
	 * 取得两个日期之间月份
	 * 
	 * @param unknown $date1
	 * @param unknown $date2
	 * @return multitype:string
	 */
	private function diffdate($date1, $date2) {
		if (strtotime ( $date1 ) > strtotime ( $date2 )) {
			$ymd = $date2;
			$date2 = $date1;
			$date1 = $ymd;
		}
		list ( $y1, $m1, $d1 ) = explode ( '-', $date1 );
		list ( $y2, $m2, $d2 ) = explode ( '-', $date2 );
		$math = ($y2 - $y1) * 12 + $m2 - $m1;
		$my_arr = array ();
		if ($y1 == $y2 && $m1 == $m2) {
			if ($m1 < 10) {
				$m1 = intval ( $m1 );
				$m1 = '0' . $m1;
			}
			if ($m2 < 10) {
				$m2 = intval ( $m2 );
				$m2 = '0' . $m2;
			}
			$my_arr [] = $y1 . '-' . $m1 . '-01';
			$my_arr [] = $y2 . '-' . $m2 . '-01';
			return $my_arr;
		}
		$p = $m1;
		$x = $y1;
		for($i = 0; $i <= $math; $i ++) {
			if ($p > 12) {
				$x = $x + 1;
				$p = $p - 12;
				if ($p < 10) {
					$p = intval ( $p );
					$p = '0' . $p;
				}
				$my_arr [] = $x . '-' . $p;
			} else {
				if ($p < 10) {
					$p = intval ( $p );
					$p = '0' . $p;
				}
				$my_arr [] = $x . '-' . $p;
			}
			$p = $p + 1;
		}
		return $my_arr;
	}



	/**
	 * 电话号码
	 */
	public function phone() {
		// 渲染模板
		$this->display ();
	}
	// 设置qq码
	public function qq() {
		if ( IS_POST ) {
			$data['qq'] = I( 'post.qq', '' );
			$data['id'] = $this->member['id'];
			if ( D( 'Member' )->save( $data ) ) {
				$this->success( '修改成功', U( 'Member/update' ) );
			} else {
				$this->error( '设置失败!' );
			}
		} else {
			// 渲染模板
			$this->display();
		}
	}
	// 设置
	public function nickname() {
		if ( IS_POST ) {
			if(I('post.nickname') == ''){
				echo "<script language=\"JavaScript\">\r\n";
				echo " alert('请输入昵称');\r\n";
				echo " history.back();\r\n";
				echo "</script>";
				return false;
			}
			$data['nickname'] = I( 'post.nickname', '' );
			$data['id'] = $this->member['id'];
			if ( D( 'Member' )->save( $data ) ) {
				$this->redirect( 'update'  );
			} else {
				$this->redirect( 'update' );
			}
		} else {
			// 渲染模板
			$this->display();
		}
	}

	// 设置性别
	public function sex() {
		if ( IS_POST ) {
			$data['sex'] = I( 'post.sex', '' );
			$data['id'] = $this->member['id'];
			if ( D( 'Member' )->save( $data ) ) {
				echo 1;exit;
			} else {
				echo 2;exit;
			}
		}
	}
	/**
	 * 电话号码绑定
	 */
	public function phone_bind() {
		if (IS_POST) {
			// 手机号码验证
			$username = I ( 'post.username', '' );
			if (! preg_match ( '/^1[3|4|5|7|8][0-9]\d{8}$/', $username )) {
				$returnMsg['status'] = 0;
				$returnMsg['info'] = '手机号码填写有误';
				// $this->error ( '手机号码填写有误' );
			} else {
				if (D ( 'Member' )->checkField ( array ('username' => $username ), "id" )) {
					$returnMsg['status'] = 0;
					$returnMsg['info'] = '手机号码已经被占用，请仔细检查是否填写错误';
					// $this->error ( '手机号码已经被占用，请仔细检查是否填写错误' );
				}
			}
		
			
			// 所有数据正确,则更改电话号码
			$theArray ['username'] = $username;
			$theArray ['tel'] = $username;
			$theArray ['id'] = $this->member ['id'];
			if (D ( 'Member' )->save ( $theArray )) {
				$returnMsg['status'] = 1;
				$returnMsg['info'] = '修改成功';

			} else {
				// $this->error ( '手机号码修改失败' );
				$returnMsg['status'] = 1;
				$returnMsg['info'] = '手机号码修改失败';
			}

			$this->HuiMsg ( $returnMsg );
		} else {
			// 渲染模板
			$this->display ();
		}
	}
	/**
	 * 设置密码
	 */
	public function edit_pass() {
		if (IS_POST&&IS_AJAX) {
			$data ['password'] = I ( 'post.password');
			$data ['repassword'] = I ( 'post.repassword');
			if(strlen($data ['password']) < 6 || strlen($data ['password']) > 20){
				$returnMsg['status'] = 0;
				$returnMsg['info'] = '密码长度6-20个字符';
				echo json_encode($returnMsg);
				return false;
			}
			if($data ['password'] != $data ['repassword']){
				$returnMsg['status'] = 0;
				$returnMsg['info'] = '两次密码不一致';
				echo json_encode($returnMsg);
				return false;
			}
				$theArray ['id'] = $this->member ['id'];
				$theArray ['password'] = sha1 ( $data ['password'] );
				if (D ( 'Member' )->save ( $theArray )) {
					$returnMsg['status'] = 1;
					$returnMsg['info'] = '修改成功';

				} else {
					$returnMsg['status'] = 0;
					$returnMsg['info'] = '修改失败';
				}
				echo json_encode($returnMsg);
		} else {
			// 渲染模板
			$this->display ();
		}
	}

	/**
	 * 验证旧密码是否正确
	 * @return [type] [description]
	 */
	public function checkOldPass()
	{
			

		if (IS_AJAX&&IS_POST) {
			if (sha1(I('post.oldpass')) == $this->member['password']) {
				$returnMsg['status']= 1;
				$returnMsg['info']= '验证成功';
			}else{

				$returnMsg['status']= 0;
				$returnMsg['info']= '旧密码验证失败';
			}

			echo json_encode($returnMsg);
			

		}
	}




	/**
	 * 退出登录
	 */
	public function logout() {
		session ( 'member_auth', null );
		cookie ( 'member_auto_login', null );
		// $this->success ( '退出成功!', U ( 'Login/login' ) );
		$this->redirect('Login/login');
	}



	/**
	 * 投诉建议
	 */
	public function suggest(){
		if(IS_AJAX&&IS_POST){
			$data = $_POST;
			$data['create_time'] = time();
			$data['member_id'] = $this->member['id'];
			$data['cid'] = $this->member['cid'];
			$data['department_id'] = $this->member['department_id'];
			$outPut = array('status'=>0,'msg'=>'');
			if(D('MemberSuggest')->add($data)){
				$outPut['status'] = 1;
				$outPut['msg'] = '添加建议成功';
			}else{
				$outPut['msg'] = '添加建议失败';
			}
			$this->ajaxReturn ( $outPut );
		}else{
			$this->display();
		}
	}

	public function chengeHead()
	{
		if (IS_POST) {
			 if($_FILES['tmp_name'] == ''){
				 echo "<script language=\"JavaScript\">\r\n";
				 echo " alert('请选择头像');\r\n";
				 echo " history.back();\r\n";
				 echo "</script>";
				 return false;
			 }
			$upload = new \Think\Upload();// 实例化上传类
		    $upload->maxSize   =     10485760  ;// 设置附件上传大小
		    $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
		    $upload->rootPath  =     './Uploads/'; // 设置附件上传根目录
		    $upload->savePath  =     'head/'; // 设置附件上传（子）目录
		    if ($_FILES['face']['error']==0) {
		    	 // 上传文件 
		   		 $info   =   $upload->upload();
			    if(!$info) {// 上传错误提示错误信息
			        $this->error($upload->getError());
			    }
			    else{// 上传成功
					$data['face'] = 'Uploads/'.$info['face']['savepath'].$info['face']['savename'];
					D('Member')->where(['id'=>$this->member['id']])->save($data);
					$this->redirect('update');
			    }
		    }
		}else{
			$this->display();
		}
	}





}