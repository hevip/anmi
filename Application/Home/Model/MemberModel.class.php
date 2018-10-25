<?php

namespace Home\Model;

class MemberModel extends CommModel {
	protected $member='member';
	/**
	 * 自动验证
	 * 
	 * @var array
	 */
	protected $_validate = array(
		array( 'username', '/^1(3|5|7|8){1}[0-9]{9}/i', '电话号码填写有误!', self::EXISTS_VALIDATE ),
		array( 'password', '/^[\w]{6,20}/i', '密码填写有误!', self::EXISTS_VALIDATE ),
		array( 'nickname', '2,20', '姓名填写有误', self::EXISTS_VALIDATE, 'length' ),
		array( 'email', 'email', '邮箱格式填写有误', self::EXISTS_VALIDATE ),
		array( 'tel', '/^(13[0-9]|15[0-9]|18[0-9]|14[0-9])[0-9]{8}/i', '手机号码格式填写有误', self::EXISTS_VALIDATE ),
		array( 'checked', 'checkVerify', '验证码填写有误!', self::EXISTS_VALIDATE, 'function' )
	);
	
	/**
	 * 自动完成
	 * 
	 * @var array
	 */
	protected $_auto = array(
		array( 'password', 'sha1', self::MODEL_BOTH, 'function' )
	);
	
	/**
	 * 验证占用字段
	 * 
	 * @param array $condition 查询条件
	 * @param string $field 返回值的字段名称
	 * @return 返回字段值
	 */
	public function checkField( $condition, $field ) {
		return $this->where( $condition )->getField( $field );
	}
	
	/**
	 * 注册一个会员
	 * 
	 * @param array $data 数据
	 * @return array
	 */
	public function register( $data ) {
		$returnMsg = returnMsg();
		// 验证短信验证码
// 		if ( !checkSMSCode( $data['smscode'], $data['username'] ) ) {
// 			$returnMsg['info'] = "短信验证码有误!";
// 			return $returnMsg;
// 		}
		// 组合默认数据
		$data['create_time'] = time();
		$data['checked'] = $data['verify'];
		unset( $data['verify'] );

		if ( $this->create( $data ) ) {
		
			// 判断用户名是否被占用
			$isUsername = $this->checkField( array( 'username' => $data['username'], 'is_delete' => 0 ), "username" );
			if ( !empty( $isUsername ) ) {
				$returnMsg['info'] = "用户已被占用!";
			} else {
				// $levelMap = array();
				// $levelMap[ 'status' ] = 0;
				// $levelMap[ 'is_delete' ] = 0;
				// $levelMap[ 'pid' ] = 1;
				// $data['level'] = D('Category')->where( $levelMap )->order( 'sort desc' )->getField( 'id' );
				$returnMsg['status'] = $this->add($data) ? 1 : 0;
				if ( empty( $returnMsg['status'] ) ) {
					$returnMsg['info'] = "注册失败,请重新注册!";
				} else {
					$lastId = $this->getLastInsID();
					// 获取会员信息
					$user = D( 'Member' )->where( array( 'id' => $lastId ) )->find();
					
					
					
					// 写入登录信息
					$update = array(
						'id' => $lastId,
						'last_login_time' => time(),
						'last_login_ip' => get_client_ip( 1 ),
					);
					$this->save( $update );
					// 更新登录日志
					$this->addLog( $data['username'], $data['password'], $update['last_login_time'], '登录成功' );
					// 写入到session
//					$auth = array(
//						'id' => $lastId,
//						'username' => $data['username'],
//						'recommend' => $data['recommend'],
//						'last_login_time' => $update['last_login_time'],
//						'last_login_ip' => $update['last_login_ip'],
//					);
//					session( 'member_auth', $auth );
					// 写入cookie，实现自动登录，有效期30天
//					$member_auto_login = array(
//						'username' => encrypt( $user['username'], 'E' , 'nowamagic' ),
//						'password' => encrypt( $user['password'], 'E' , 'nowamagic' )
//					);
//					$option = array(
//						'expire' => 0,
//						'path' => '/',
//					);
//					cookie( 'member_auto_login', json_encode( $member_auto_login ), $option );
					$returnMsg['info'] = "注册成功!";
				}
			}
		} else {
			$returnMsg['info'] = $this->getError();
		}
		return $returnMsg;
	}
	
	// 登录
	public function login( $data ) {
		$return = returnMsg();
		if ( $this->create( $data ) ) {
			if(is_numeric($data['personal_code'] ) && strlen($data['personal_code']) == 11){
				$map['username'] = $data['personal_code'];
			}else{
				$map['personal_code'] = $data['personal_code'];
			}
			$user = $this->field( "id,username,personal_code,password,status" )->where( $map )->find();
			if ( count( $user ) == 0 ) {
				// 更新登录日志
				$this->addLog( $data['personal_code'], $data['password'], time(), '登录失败!' );
				// 设置返回信息
				$return['info'] = "未注册，请注册后登录";
			} else if ( $user['password'] == sha1( $data['password'] ) ) {
				// 是否被禁止登录
				if ( $user['status'] == 1 ) {
					// 更新登录日志
					$this->addLog( $user['personal_code'], $user['password'], time(), '登录失败，被禁登录' );
					$return['info'] = "此用户已被禁止登录";
				} else {
					// 写入登录信息
					$update = array(
						'id' => $user['id'],
						'last_login_time' => time(),
//						'last_login_ip' => get_client_ip( 1 ),
					);
					$this->save( $update );
					// 更新登录日志
					$this->addLog( $user['personal_code'], $user['password'], $update['last_login_time'], '登录成功' );
					// 更新登录在线记录
					$this->addMemberLine( $user['id'] );
					
					// 升级
					/* $config = D( 'Config' )->where( array( 'id' => 1 ) )->find();
					$upgradeConsumer = explode( "|", $config['upgrade_consumer'] );	// 会员升级规则
					D( 'Order' )->upgrade( $user['id'], 0, $upgradeConsumer ); */
					
					// 写入到session
					$auth = array(
						'id' => $user['id'],
						'personal_code' => $user['personal_code'],
						'referral_code' => $data['referral_code'],
						'last_login_time' => $update['last_login_time'],
						'last_login_ip' => $update['last_login_ip'],
					);
					session( 'member_auth', $auth );
					// 写入cookie，实现自动登录，有效期30天
					$member_auto_login = array(
						'personal_code' => encrypt( $user['personal_code'], 'E' , 'nowamagic' ),
						'password' => encrypt( $user['password'], 'E' , 'nowamagic' )
					);
					$option = array(
						'expire' => 0,
						'path' => '/',
					);
					cookie( 'member_auto_login', json_encode( $member_auto_login ), $option );
					// 设置返回信息
					$return['status'] = 1;
				}
			} else {
				// 更新登录日志
				$this->addLog( $data['personal_code'], $data['password'], time(), '登录失败!' );
				// 设置返回信息
				$return['info'] = "密码错误,如若忘记密码，可通过找回密码重新设置";
			}
		} else {
			// 更新登录日志
			$this->addLog( $data['personal_code'], $data['password'], time(), '登录失败!' );
			// 设置返回信息
			$return['info'] = $this->getError();
		}
		return $return;
	}
	
	// 新增登录日志
	public function addLog( $personal_code, $password, $lastTime, $remark ) {
		$log = array(
			'personal_code' => $personal_code,
			'password' => $password,
			'ip' => get_client_ip( 1 ),
			'create_time' => $lastTime,
			'system' => getSystem(),
			'browser' => getBrowser(),
			'remark' => $remark,
		);
		D( 'MemberLog' )->add( $log );
	}
	
	// 新增登录在线记录
	public function addMemberLine( $id ) {
		$data = array(
			'uid' => $id,
			'cookie' => session_id(),
			'login_time' => time()
		);
		D( 'MemberLine' )->insert( $data );
	}
	
	// 修改用户信息
	public function update( $data ) {
		// 如果密码为空，则删除
		if ( empty( $data['password'] ) ) {
			unset( $data['password'] );
		}
		$return = returnMsg( array ( 'status' => '0', 'info' => '修改失败!' ) );
		$data['id'] = $_SESSION['member_auth']['id'];
		$data['update_time'] = time();
		if ( $this->create( $data ) ) {
			$result = $this->getOne( $data['id'] );
			if ( $result ) {
				if ( $this->save( $data ) ) {
					$return['status'] = 1;
					$return['info'] = '修改成功';
				} else {
					$return['info'] = $this->getError();
				}
			} else {
				$return['info'] = $this->getError();
			}
		} else {
			$return['info'] = $this->getError();
		}
		return $return;
	}
	
	// 获取会员所有推荐码
	public function getAllRecommend() {
		$data = $this->where( "1=1" )->select();
		$string = "|";
		for ( $i = 0, $size = count( $data ); $i < $size; $i ++ ) {
			$string .= $data[$i]['referral_code'] . "|";
		}
		return $string;
	}
	
	// 获取推荐码
	public function getRecommend( $recommendString ) {
		$theRecommend = createRandomCode();
		if ( strpos( $recommendString, "|$theRecommend|") !== false ) {
			return  self::getRecommend( $recommendString );
		} else {
			return $theRecommend;
		}
	}
	
	// 检测用户是否登录
	public function checkLogin() {
		$session = session( 'member_auth' );
		if ( count( $session ) == 0 ) {
			return true;
		} else {
			$isLogin = $this->checkField( array( 'id'=> $session['id'] ), 'id' );
			if ( empty( $isLogin ) ) {
				session( 'member_auth', null );
				cookie( 'member_auto_login', null );
				return true;
			} else {
				return false;
			}
		}
	}

	// 统计团队人数
	protected $countList = 0;
	public function getSubList( $recommend, $type ) {
		if ( $type == "push" ) {
			return $this->where( array( 'recommended_code' => $recommend, 'level' => array( 'gt', 0 ) ) )->count();
		} else {
			$newArray = $this->where( array( 'recommended_code' => $recommend ) )->select();
			for ( $i = 0, $size = count( $newArray ); $i < $size; $i ++ ) {
				if ( $newArray[$i]['level'] >= 1 ) {
					$this->countList ++;
				}
				
				$this->getSubList( $newArray[$i]['referral_code'], $type );
			}
			return $this->countList;
		}
	}
	
}