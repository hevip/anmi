<?php
namespace Home\Controller;
use Think\Controller;
use Think\Verify;

/**
 * 找回密码类
 * @author Administrator
 *
 */
class ForgetController extends Controller {
	
	// 构造函数
	public function _initialize() {
		$session = session( 'member_auth' );
		if ( count( $session ) > 0 ) {
			$this->redirect( 'Member/index' );
		}
	}
	
	// 验证码
	public function verify() {
		$verify = new Verify( array( "length"=>4 ) );
		$verify->entry( 1 );
	}
	
	// 找回密码
	public function index() {
		// 渲染模板
		$this->display();
	}
	
	// 重置密码
	public function reset() {
		$session = session( 'smsInfo' );
		
		if($session['code']===I('get.code') && $session['phone'] === I('get.phone')){
			$this->display();
		}else{
			$this->redirect( 'Forget/index' );
		}
		
	}
	
	// 修改密码
	public function reset_pass() {
		if ( IS_POST ) {
			// 获取session
			$session = session( 'smsInfo' );

			// 判断session是否过期
			$the_time = ( time() - intval( $session['create_time'] ) ) / 60;
			if ( $the_time > $session['effective_time']+100 ) {
				$this->error( "验证码已过期!", U( 'Forget/index' ) );
			}
			
			$data['password'] = I( 'post.password', '' );
			$username = $session['phone'];
			$condition = array( 'username' => $username ,'status'=>0,'is_delete'=>0);
			if(!D( 'Member' )->where( $condition )->find()){
				$this->error( '手机账号不存在!' );exit;
			}
			$setField = array( 'password' => sha1( $data['password'] ) );
			if ( D( 'Member' )->where( $condition )->save( $setField ) ) {
				$this->success( '重置成功', U( 'Login/login' ) );
			} else {
				$this->error( '重置密码失败!' );
			}		
		} else {
			// 渲染模板
			$this->redirect( 'Forget/reset' );
		}
	}
}