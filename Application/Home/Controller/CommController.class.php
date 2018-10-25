<?php
/**
 * 公用控制器
 *
 * @author BoBo
 *        
 */
namespace Home\Controller;

use Think\Controller;

class CommController extends Controller {

	/**
	 * 用于存储会员信息
	 *
	 * @var array
	 */
	protected $member;
	
	/**
	 * 模型
	 * 
	 * @var model
	 */
	protected $model;

	/**
	 * 网站基础配置
	 *
	 * @var array
	 */
	protected $config;

	/**
	 * 构造函数
	 */
	protected function _initialize() {
		// 判断终端
		// $this->judgingTerminal();
		// 获取网站基本信息
		$this->setConfig ();
		// 会员信息
		$this->getUserInfo ();
		// 设置url
		$this->setLocationUrl ();
		// 设置注册/登录[之前要求加上，后面运行了段时间觉得不太妥当，就又取消了]
		//$this->setRegOrLogin();
		// 页面关键字
//		$this->formatKeyword ( null );
		// 设置在线会员
		$this->memberLine ();
		// 设置js-sdk
//		$this->js_sdk ();
//		$this->keywordSearch();
		if($this->member['auth'] == 1){
			$map['status'] = 0;
			$map['cid'] = $this->member['cid'];
			$leave = D('leave')->where($map)->select();
			$car = D('car_application')->where($map)->select();
			$hon = count($this->fore($leave)) + count($this->fore($car));
			$this->assign ( 'auth',1);
		}
		if($this->member['auth'] == 2){
			$map['second_charge'] = $this->member['personal_code'];
			$map['status'] = 0;
			$map['cid'] = $this->member['cid'];
			$leave = D('leave')->where($map)->count();
			$car = D('car_application')->where($map)->count();
			$hon = $leave + $car;
			$this->assign ( 'auth',1);
		}
		if($this->member['auth'] == 0){
			$map['personal_code'] = $this->member['personal_code'];
			$map['cid'] = $this->member['cid'];
			$map['status'] = array('neq',0);
			$leave = D('leave')->where($map)->count();
			$car = D('car_application')->where($map)->count();
			$hon = $leave + $car;
			$this->assign ( 'auth', 0);
		}
		if($this->member['auth'] == 5){
			$map['cid'] = $this->member['cid'];
			$map['status'] = array('neq',0);
			$leave = D('leave')->where($map)->count();
			$car = D('car_application')->where($map)->count();
			$hon = $leave + $car;
			$this->assign ( 'auth',1);
		}
		$this->assign ( 'hon', $hon);
	}
	function fore($leave){
		foreach($leave as $k=>$v){
//			if(($v['first_charge'] == $this->member['personal_code'] && $v['second_charge'] != '') || (in_array($this->member['personal_code'],explode(',',$v['cc'])) && $v['second_charge'] != '')){
//				unset($leave[$k]);
//			}
//			if($v['first_charge'] != $this->member['personal_code'] && !in_array($this->member['personal_code'],explode(',',$v['cc']))){
//				unset($leave[$k]);
//			}
			if(!in_array($this->member['personal_code'],explode(',',$v['first_charge'])) || $v['second_charge'] != ''){
				unset($leave[$k]);
			}
		}
		return $leave;
	}
	/**
	 * 获取数据列表
	 *
	 * @param $model Model
	 * @param $condition 查询条件
	 * @param int $pageSize 每页显示条数
	 * @return array
	 */
	protected function getPdList($model, $condition, $pagesize, $field = '*', $order = "") {
		// 默认查询条件
		$condition ['status'] = 0;
		$condition ['is_delete'] = 0;
		// 默认排序
		$order ['sort'] = 'desc';
		// 获取总条数
		$total = $model->where ( $condition )->count ();
		// 实例化分页类
		$pd = new \Think\Page ( $total, $pagesize );
		$pd->setConfig ( 'prev', '上一页' );
		$pd->setConfig ( 'next', '下一页' );
		$pd->setConfig ( 'first', '首页' );
		$pd->setConfig ( 'last', '末页' );
		if (I ( 'get.p' ) > $pd->totalPages) {
			$this->error ( '请勿非法操作!' );
		}
		// 写入模版
		$this->assign ( 'page', $pd->show () );
		// 返回数据
		return $model->where ( $condition )->field ( $field )->order ( $order )->limit ( $pd->firstRow, $pd->listRows )->select ();
	}

	/**
	 * 显示验证码
	 */
	public function verify() {
		$verify = new \Think\Verify ( array ("length" => 4,"codeSet" => "0123456789" ) );
		$verify->entry ( 1 );
	}

	/**
	 * 格式化网站关键字，利于优化
	 *
	 * @param array $dataArray 网站关键字数组
	 * @param string $tempArray 网站关键字数组
	 */
	protected function formatKeyword($dataArray, $tempArray = null) {
		$theWebName = 'web_title';
		$theWebKeywords = 'web_keywords';
		$theWebInfo = 'web_description';
		$this->config ['imgUrl'] = 'http://'. $_SERVER['HTTP_HOST'] . __ROOT__ .'/Public/Home/Images/xqw_logo.png';
		if (empty ( $dataArray ) || empty ( $dataArray [$theWebName] ) && empty ( $dataArray [$theWebKeywords] ) && empty ( $dataArray [$theWebInfo] )) {
			if (empty ( $tempArray ) || empty ( $tempArray [$theWebName] ) && empty ( $tempArray [$theWebKeywords] ) && empty ( $tempArray [$theWebInfo] )) {
				$this->config [$theWebInfo] = $this->config [$theWebInfo];
				$this->config [$theWebKeywords] = $this->config [$theWebKeywords];
				$this->config [$theWebName] = $this->config [$theWebName];
				if ( $dataArray ['picture'] ) {
					$this->config ['imgUrl'] = 'http://'. $_SERVER['HTTP_HOST'] . __ROOT__ . '/' .$dataArray ['picture'];
				}
			} else {
				$this->config [$theWebName] = $tempArray [$theWebName];
				$this->config [$theWebKeywords] = $tempArray [$theWebKeywords];
				$this->config [$theWebInfo] = $tempArray [$theWebInfo];
				if ( !empty( $tempArray ['picture'] ) ) {
					$this->config ['imgUrl'] = 'http://'. $_SERVER['HTTP_HOST'] . __ROOT__ . '/' .$tempArray ['picture'];
				}
			}
		} else {
			$this->config [$theWebName] = $dataArray [$theWebName];
			$this->config [$theWebKeywords] = $dataArray [$theWebKeywords];
			$this->config [$theWebInfo] = $dataArray [$theWebInfo];
				if ( !empty( $dataArray ['picture'] ) ) {
					$this->config ['imgUrl'] = 'http://'. $_SERVER['HTTP_HOST'] . __ROOT__ . '/' .$dataArray ['picture'];
				}
		}
		$this->assign ( "config", $this->config );
	}

	/**
	 * 读取当前会员信息
	 */
	private function getUserInfo() {
		$session = session ( 'member_auth' );
		$memberModel = D ( 'Member' );
		$tempArray = array ();
		if ($session) {
			$this->member = $memberModel->getOne ( $session ['id'] );
			// 如果密码为空，则必须修改密码
			if (empty ( $this->member ['password'] ) && ACTION_NAME != 'edit_pass') {
				$this->redirect ( 'Member/edit_pass' );
			}
		} else {
			if ( isWeChat() ) {
				$this->member = array ();
			} else {
				// 自动登录
				$cookie = json_decode ( cookie ( 'member_auto_login' ), ture );
				if (! empty ( $cookie ) && ! empty ( $cookie ['username'] ) && ! empty ( $cookie ['password'] )) {
					$data ['username'] = encrypt ( $cookie ['username'], 'D', 'nowamagic' );
					$data ['password'] = encrypt ( $cookie ['password'], 'D', 'nowamagic' );
					$user = $memberModel->where ( $data )->find ();
					if (count ( $user ) > 0) {
						// 写入登录信息
						$update = array (
								'id' => $user ['id'],
								'last_login_time' => time (),
								'last_login_ip' => get_client_ip ( 1 )
						);
						$memberModel->save ( $update );
						// 更新登录日志
						$memberModel->addLog ( $data ['username'], $data ['password'], $update ['last_login_time'], '登录成功' );
						// 升级
						$config = D ( 'Config' )->where ( array ('id' => 1 ) )->find ();
						$upgradeConsumer = explode ( "|", $config ['upgrade_consumer'] ); // 会员升级规则
						D ( 'Order' )->upgrade ( $user ['id'], 0, $upgradeConsumer );
						// 写入到session
						$auth = array (
								'id' => $update ['id'],
								'username' => $data ['username'],
								'recommend' => $data ['recommend'],
								'last_login_time' => $update ['last_login_time'],
								'last_login_ip' => $update ['last_login_ip']
						);
						session ( 'member_auth', $auth );
						$this->member = $user;
						// 登陆时存cookie商品进数据库
						setCartCookie ();
					}
				}
			}
		}
		// 设置weixin_name
		if (! empty ( $this->member ['wx_name'] )) {
			$this->member ['wx_name'] = json_decode ( $this->member ['wx_name'] );
		}
		$this->assign ( 'member', $this->member );
	}

	/**
	 * 检测会员是否登录
	 */
	protected function checkLogin() {
		if (D ( 'Member' )->checkLogin ()) {
			// if ( isWeChat() ) {
			// 	// $recommend = I ( 'get.recommend_code', 0 );
			// 	// $recommend_code = empty ( $recommend ) ? "" : "/recommend_code/$recommend";
			// 	$theUrl = "http://{$_SERVER ['HTTP_HOST']}/WeiXin/index";
			// 	// print_r($theUrl);die;
			// 	$this->assign ( "url", $theUrl );
			// 	$this->display ( "Login/loading" );
			// } else {
				$this->redirect (  'Login/login'  );
			// } 
		}
	}

	/**
	 * 获取购物车对象并转换成数组，登陆时数据库获取，未登陆时获取cookie中的购物车
	 *
	 * @return array
	 */
	protected function getCart() {
		if (empty ( $_COOKIE ['ShopCart'] )) {return null;}
		// model
		$model = D ( 'Cart' );
		// 把json转为数组
		$cartObj = json_decode ( $_COOKIE ['ShopCart'], true );
		// 格式化购物车列表
		return $model->formatCart ( $cartObj );
	}

	/**
	 * 设置在线会员
	 */
	protected function memberLine() {
		$model = D ( 'MemberLine' );
		// 在线统计
		$online = 0;
		// 判断是否登录
		$session = session ( 'member_auth' );
		if (! empty ( $session )) {
			$update = array ('uid' => $session ['id'],'login_time' => time (),'cookie' => session_id () );
			$model->insert ( $update );
		}
		$data = $model->getList ();
		$idList = "";
		// 如果5分钟之内没有刷新，则认定为已经离线
		for($i = 0, $size = count ( $data ); $i < $size; $i ++) {
			$time = (time () - $data [$i] ['login_time']) / 60;
			if ($time > 5) {
				$idList .= empty ( $idList ) ? $data [$i] ['id'] : "," . $data [$i] ['id'];
			} else {
				$online += 1;
			}
		}
		if (! empty ( $idList )) {
			$model->remove ( $idList );
		}
		// 注入在线统计
		$this->assign ( 'onlineMember', $online );
	}

	/**
	 * 判断终端
	 */
	private function judgingTerminal() {
		$host = $_SERVER ['HTTP_HOST'];
		if (isPcOrMobile ()) {
			if ($host == 'www.malldx.com') {
				die ( header ( 'Location:http://m.malldx.com' ) );
			}
		} else {
			if ($host == 'www.malldx.com') {
				die ( $this->display ( 'Index/pc' ) );
			} else {
				die ( header ( 'Location:http://www.malldx.com' ) );
			}
		}
	}

	/**
	 * 设置url跳转[为url附加上当前登录会员的推荐码]
	 */
	public function setLocationUrl() {
		if ( strpos( '|js_api_call|', '|'. ACTION_NAME .'|' ) !== false ) {
			return;
		}
		$url = 'http://' . $_SERVER ['HTTP_HOST'] . $_SERVER ['REQUEST_URI'];
		if (strpos ( $url, 'recommend_code' ) === false && ! IS_AJAX && ! IS_POST && isWeChat ()) {
			if (! empty ( $this->member ['referral_code'] )) {
				$tempUrl = "http://{$_SERVER ['HTTP_HOST']}";
				$tempUrl .= __ROOT__ == "/" ? __ROOT__ : __ROOT__ . "/";
				if ($url == $tempUrl) {
					$theUrl = $url . "Index/index/recommend_code/{$this->member ['referral_code']}";
				} else if (strpos ( $url, '.html' ) === false) {
					$theUrl = "$url/recommend_code/{$this->member ['referral_code']}";
				} else {
					$theUrl = "$url?recommend_code={$this->member ['referral_code']}";
				}
				header ( "Location:$theUrl" );
				die ();
			}
		}
	}
	
	/**
	 * 设置注册/登录
	 * 注：如果在微信端，没有登录的情况下，url地址存在推荐码[recommend_code]，那么跳转登录or注册
	 */
	public function setRegOrLogin() {
		// 是否是微信端[不在微信端，则返回]
		if ( !isWeChat() ) {
			return;
		}
		// 是否登录[已登录，则返回]
		if ( count( $this->member ) > 0 ) {
			return;
		}
		// 获取并判断推荐码[recommend_code]是否存在[不存在，则返回]
		$recommend_code = I( 'get.recommend_code', '' );
		if ( !is_numeric( $recommend_code ) ) {
			return;
		}
		
		// 推荐码[recommend_code]存在，跳转登录
		$root .= __ROOT__ == "/" ? __ROOT__ : __ROOT__ . "/";
		$theUrl = "http://" . $_SERVER ['HTTP_HOST'] . $root . "WeiXin/index/recommend_code/$recommend_code";
		$this->assign ( "url", $theUrl );
		$this->display ( "Login/loading" );
		die();
	}

	/**
	 * 网站基础配置
	 */
	public function setConfig() {
		$this->config = D ( 'Config' )->getOne ( 1 );
		$this->assign ( 'config', $this->config );
	}

	/**
	 * 设置js_sdk
	 */
	public function js_sdk() {
		$IsWx = 0;
		if (isWeChat ()) {
			$IsWx = 1;
			vendor ( 'WXAPI.WXAPI' );
			$filePath = VENDOR_PATH . "WXAPI/";
			$WX_JSSDK = new \JSSDK ( $this->config ['wx_app_id'], $this->config ['wx_app_secret'], $filePath );
			$this->assign ( 'WXAPIObj', $WX_JSSDK->getSignPackage () );
		}
		$this->assign ( 'IsWx', $IsWx );
	}
	/**
	 * 关键字全网搜索
	 */
	public function keywordSearch(){
		//关键字设置
		$maps['is_delete'] = 0;
		$maps['status'] = 0;
		$mapss['pid'] = 8;
		$kyeList = D('Category')->where($mapss)->order('sort desc,create_time desc')->limit(10)->select();
		$this->assign( 'kyeList', $kyeList );

		$cookie_keyword = cookie('keyword');
		$cookie_keyword = array_slice($cookie_keyword,-3,3);
		arsort($cookie_keyword);
		$this->assign( 'cookie_keyword', $cookie_keyword );
	}

	
	/**
	 *获取登录用户所属公司
	 * @return [type] [description]
	 */
	public function getUserCompany(){
		$companyModel = D('Company');
		$userModel = D('Member');
		$companyList = $companyModel
					->alias('c')
					->field('c.id,c.companyname,c.logo_url,u.username,u.nickname,u.department_id,u.cid,u.position_id')
					->join('left join db_member AS u ON u.cid=c.id')
					->where('u.id='.session('member_auth')['id'])
					->find();
		return $companyList;
	}
	/**
	 * 计算两个时间差
	 * @return [type] [description]
	 */
	public function shicha($startdate,$enddate){
	
		$timediff = strtotime($enddate) - strtotime($startdate);  
		  $days = intval( $timediff / 86400 );  
		  $remain = $timediff % 86400;  
		  $hours = intval( $remain / 3600 );  
		  $remain = $remain % 3600;  
		  $mins = intval( $remain / 60 );  
		  $secs = $remain % 60;  
		  $res = array( "day" => $days, "hour" => $hours, "min" => $mins, "sec" => $secs );  
		  return $res;  
	}

	/**
	 * 显示编辑页面
	 */
	public function read() {
		$id = I ( 'get.id' );
		$returnMsg = D ( 'Article' )->getCommOne ( $id );
		// print_r($returnMsg);die;

		$this->assign('articleInfo',$returnMsg['info']);
		$this->display ();
	}
}
?>