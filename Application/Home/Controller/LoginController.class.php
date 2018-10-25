<?php
namespace Home\Controller;

/**
 * 会员登录注册控制器
 *
 * @author BoBo
 *        
 */
class LoginController extends CommController {

	/**
	 * 构造函数
	 */
	public function _initialize() {
		parent::_initialize ();
		$session = session ( 'member_auth' );
		if (count ( $session ) > 0) {
			$this->redirect ( 'Member/index' );
		}
	}

	/**
	 * 登录
	 */
	public function login() {
		if (IS_POST) {
			 // print_r($_POST);die;
			$return = D ( "Member" )->login ( $_POST );
			if (empty ( $return ['status'] )) {
				// $return['status'] = 0;
				// $this->HuiMsg ( $return );
				$this->error ( $return ['info'] );
			} else {
				$history = $this->setHistory ( $_POST ['history'] );
				// 登陆时存cookie商品进数据库
				//setCartCookie ();
				$this->redirect (  $history );
			}
		}
		$this->display ();
		// else {
		// 	 if ( isWeChat() ) {
		// 		if (strpos ( $_SERVER ['HTTP_REFERER'], 'logout' ) !== false) {
		// 			$this->redirect ( 'Index/index' );
		// 		} else {
		// 			$recommend = I ( 'get.recommend_code', 0 );
		// 			$recommend_code = empty ( $recommend ) ? "" : "/recommend_code/$recommend";
		// 			$theUrl = "http://" . $_SERVER ['HTTP_HOST'] . "/WeiXin/index$recommend_code";
		// 			$this->assign ( "url", $theUrl );
		// 			$this->display ( "Login/loading" );
		// 		}
		// 	} else {

		// 	 } 
		// }
	}
	/**
	 * 注册1
	 */
	public function registerFirst() {
		if (IS_POST) {
			if(empty($_POST['cid']) || empty($_POST['department_id'])){
				$returnMsg['status'] = 0;
				$returnMsg['info'] = '请选择单位或部门！';
				$this->HuiMsg ( $returnMsg );
			}
			if (!checkSMSCode ( $_POST['code'], $_POST['username'])) {
				$returnMsg ['status'] = 0;
				$returnMsg ['info'] = '验证码有误！';
				$this->HuiMsg ( $returnMsg );
			}
				S('data',$_POST,300);
				$returnMsg['status'] = 1;
				$this->HuiMsg ( $returnMsg );
			} 
		}
	public function registerSecond()
	{
		if (IS_POST) {
		    $data = $_POST;
		    $data['password'] = sha1($_POST['password']);
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
			    }
		    }
		    $return = D ( 'Member' )->register ( $data );
			 if ($return['status'] == 1) {
			 	$returnMsg['status'] = 1;
			 	$returnMsg['info'] = '注册成功!';
			 } else {
			 	$returnMsg['status'] = 0;
			 	$returnMsg['info'] = '注册失败!';
			 }
//			if($return){
//				$returnMsg['status'] = 1;
//				$returnMsg['info'] = '注册成功!';
//			}
			$this->HuiMsg ( $returnMsg );
		}
		$dataList= S('data');
		if ($dataList == null) {
			$this->redirect('register');
		}
		$this->assign('dataList',$dataList);
		$this->display();
	}


	function sign(){

		$this->display();
	}
	/**
	 * 注册
	 */
	public function register() {
		if (IS_POST) {
			$return = D ( 'Member' )->register ( $_POST );
			if (empty ( $return ['status'] )) {
				$returnMsg['status'] = 0;
				$returnMsg['info'] = $return ['info'];
				// $this->error ( $return ['info'] );
			} else {
				$returnMsg['status'] = 0;
				$returnMsg['info'] = '注册成功!';
				// $this->success ( '注册成功!', U ( 'Member/edit_pass' ) );
			}
		} else {
			// $recommend = I ( 'get.code', '' );
			//  if (strpos ( $_SERVER ['HTTP_USER_AGENT'], 'MicroMessenger' ) !== false) {
			// 	$recommend_code = empty ( $recommend ) ? "" : "/recommend_code/$recommend";
			// 	$theUrl = "http://" . $_SERVER ['HTTP_HOST'] . "/WeiXin/index$recommend_code";
			// 	$this->assign ( "url", $theUrl );
			// 	$this->display ( "Login/loading" );
			// } else { 
			// 	$this->assign ( 'recommend', $recommend );
			// 	$this->display ();
			//  } 
			$companyList = D('Company')->where(['is_delete'=>0])->select();
			// print_r($companyList);die;

			$this->assign('companyList',$companyList);
			$this->display();
		}
	}

	public function getDepartment()
	{
		if (IS_POST&&IS_AJAX) {
			$departmentList = D('Department')->where(['companyid'=>I('post.id'),'is_delete'=>0])->select();
			echo json_encode($departmentList);
		}
	}

	/**
	 * 设置登录后跳转历史页面
	 * 
	 * @param unknown $url
	 * @return Ambigous <string, mixed>|unknown
	 */
	private function setHistory($url) {
		$defaultUrl = U ( 'Member/index' );
		if (strpos ( $url, "register" ) !== false) {
			return $defaultUrl;
		} else if (strpos ( $url, "login" ) !== false) {
			return $defaultUrl;
		} else if (strpos ( $url, "logout" ) !== false) {
			return $defaultUrl;
		} else {
			return $url;
		}
	}

	public function verify() {
		$verify = new \Think\Verify( array( "length"=>5 ) );
		$verify->entry( 1 );
	}

	public function forget(){


		$tel = D('Member')->where(['personal_code'=>I('get.personal_code')])->getField('username');
			// 渲染模板
		$this->assign('username',$tel);
		$this->display ();
		
	}

	/**
	 * 设置密码
	 */
	public function edit_pass() {
		// $GLOBALS['tel'] = I('get.tel');
		if (IS_POST&&IS_AJAX) {

			$data ['password'] = I ( 'post.password', '' );
			$data ['username'] = I ( 'post.username', '' );
	
				$theArray ['id'] = D('Member')->where(['username'=>$data ['username']])->getField('id');
				$theArray ['password'] = sha1 ( $data ['password'] );
			// print_r($theArray);die;
				if (D ( 'Member' )->save ( $theArray )) {
					$returnMsg['status'] = 1;
					$returnMsg['info'] = '修改成功';

				} else {
					$returnMsg['status'] = 0;
					$returnMsg['info'] = '修改失败';
				}
				echo json_encode($returnMsg);
		} else {
			$this->assign('username',I('get.tel'));
			// 渲染模板
			$this->display ();
		}
	}
}