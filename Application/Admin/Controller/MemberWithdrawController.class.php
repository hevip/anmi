<?php
namespace Admin\Controller;

/**
 * 后台管理-提现管理控制器
 * 
 * @author BoBo
 *        
 */
class MemberWithdrawController extends CommController {
	
	public function _initialize() {
		parent::_initialize();
		// 模型
		$this->model = D( 'MemberWithdraw' );
	}
	
	/**
	 * 提现列表
	 */
	public function index() {		
		// 设置查询字段
		$field = "a.id,a.uid,a.bank_type,a.bank_id,a.bank_hang,a.bank_name,a.price,a.type,a.create_time,a.status,a.sort";
		$field .= ",b.username as member_username,b.wx_name,b.referral_code";
		$field .= ",c.title as type_name";
		// 设置查询条件
		$sql = "select $field from db_member_withdraw as a";
		$sql .= " left join db_member as b on b.id = a.uid";
		$sql .= " left join db_category as c on c.id = a.type";
		$sql .= " where a.is_delete = 0";
		// 设置排序条件
		$order .= "a.create_time desc";
		// 读取数据
		$this->dataList = $this->model->getSQLList( $sql, array( 'begin' => 0, 'num' => 0 ), $order );
		
		// 注入数据
		//$this->assign( "paramter", $this->paramter );
		$this->assign( "dataList", $this->dataList );
		
		// 渲染视图
		$this->display ();
	}

	/**
	 * 提现记录详情
	 */
	public function show() {
		$theId = I( 'get.id', 0 );
		if ( is_number( $theId ) ) {
			die('<h1>请勿非法请求</h1>');
		}
		// 设置查询字段
		$field = "a.id,a.bank_type,a.bank_id,a.bank_hang,a.bank_name,a.price,a.type,a.create_time,a.status";
		$field .= ",b.username as member_username,b.wx_name,b.referral_code";
		$field .= ",c.title as type_name";
		// 设置查询条件
		$sql = "select $field from db_member_withdraw as a";
		$sql .= " left join db_member as b on b.id = a.uid";
		$sql .= " left join db_category as c on c.id = a.type";
		$sql .= " where a.id = $theId";
		$dataInfo = $this->model->query( $sql );
		if ( empty( $dataInfo ) ) {
			die('<h1>没有数据！</h1>');
		}
		$this->assign( 'dataInfo', $dataInfo[0] );

		// 渲染视图
		$this->display ();
	}

	/**
	 * 设为已打款（处理银行卡提现）
	 */
	public function handleBank() {
		if ( IS_AJAX && IS_POST ) {
			$return = returnMsg();
			$theId = I( 'post.id', 0 );
			// 参数获取
			if ( is_number( $theId ) ) {
				$return['info'] = '参数传递错误！';
				$this->HuiMsg ( $return );
			}
			// 查看数据是否存在
			$theArray = $this->model->getOne( $theId );
			if ( empty( $theArray ) ) {
				$return['info'] = '数据不存在！';
				$this->HuiMsg ( $return );
			}
			// 更新提现状态
			$isWithdraw = $this->model->where( array( 'id' => $theId ) )->setField( 'status', 2 );
			// 更新资金明细表状态
			$isRewardMoney = D( 'RewardMoney' )->where( array( 'withdraw_id' => $theId ) )->setField( 'status', 1 );
			// 判断是否成功
			if ( $isWithdraw && $isRewardMoney ) {
				$return['info'] = '设置成功！';
				$return['status'] = 1;
			} else {
				$return['info'] = '设置失败！';
			}
			$this->HuiMsg ( $return );
		} else {
			$this->error( '请勿非法请求' );
		}
	}
	/**
	 * 向会员返现
	 */
	public function handleWebchat(){
		$return = returnMsg();
		$id = I('post.id');
		$dataInfo = D('MemberWithdraw')->where(array('id'=>$id))->find();
		$member = D('Member')->where(array('id'=>$dataInfo['uid']))->find();
		if($dataInfo['status'] == 2){
			$return['info'] = '此用户订单已返现！';
			$this->HuiMsg ( $return );
		}
		$config = D('Config')->getOne(1);
		if(!$member['wx_open_id']){
			$return['info'] = '用户未绑定微信,不能返现！';
			$this->HuiMsg ( $return );
		}
		vendor ( 'WXAPI.WxPayPubHelper' );
		$this->mch_appid=$config['wx_app_id'];//公众账号appid
		$this->mchid=$config['wx_pay_mchid'];//商户号
		$this->openid= $member['wx_open_id'];//会员opid,就是微信号  一般会存进会员数据库
		$this->key = $config['wx_pay_pass'];//签名用key值
		/**
		 * 校验用户姓名选项，NO_CHECK：不校验真实姓名， FORCE_CHECK：强校验真实姓名（未实名认证的用户会校验失败，无法转账），
		 *OPTION_CHECK：针对已实名认证的用户才校验真实姓名（未实名认证用户不校验，可以转账成功）
		 **/
		$this->check_name='NO_CHECK';
		$this->nonce_str='qyzf'.rand(100000, 999999);//随机数
		/**
		 * 提现未生成订单号，就以改提现申请的申请时间加数据ID组成订单号（模拟的订单号）
		 */
		$this->partner_trade_no= $dataInfo['create_time'].'qyzf'.$dataInfo['id'];//商户订单号
		$this->re_user_name='小桥网会员';//用户姓名
		$this->amount=$dataInfo['price']*100;//企业金额，这里是以分为单位（必须大于100分）
		$this->desc='小桥网提现';//描述
		$this->spbill_create_ip= $_SERVER["REMOTE_ADDR"];//请求ip
		$ch = curl_init ();
	
		$MENU_URL="https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers";
		curl_setopt ( $ch, CURLOPT_URL, $MENU_URL );
		curl_setopt ( $ch, CURLOPT_CUSTOMREQUEST, "POST" );
		curl_setopt ( $ch, CURLOPT_SSL_VERIFYPEER, FALSE );
		curl_setopt ( $ch, CURLOPT_SSL_VERIFYHOST, FALSE );
		$data = $this->checkParam();
		//两个证书（必填，请求需要双向证书。）
		$filePath = VENDOR_PATH . "WxPayPubHelper/";
		$zs1=$filePath."cacert/apiclient_cert.pem";
		$zs2=$filePath."cacert/apiclient_key.pem";
		curl_setopt($ch,CURLOPT_SSLCERT,$zs1);
		curl_setopt($ch,CURLOPT_SSLKEY,$zs2);
		curl_setopt ( $ch, CURLOPT_FOLLOWLOCATION, 1 );
		curl_setopt ( $ch, CURLOPT_AUTOREFERER, 1 );
		curl_setopt ( $ch, CURLOPT_POSTFIELDS, $data );
		curl_setopt ( $ch, CURLOPT_RETURNTRANSFER, true );
	
		$info = curl_exec ( $ch );
		curl_close ( $ch );
		$data = $this->xmltoarray($info);
		if($data['return_code']=='SUCCESS' && $data['result_code']=='SUCCESS'){
			$orderid = $data['partner_trade_no'] ;  //返回的订单号
			$array = explode('qyzf',$orderid);
			//根据返回的订单号做处理
			//step1  订单字段改变
			$model = D('MemberWithdraw');
			$reflinfo = $model->where(array('id'=>$array[1]))->find();
			$map['id'] = $reflinfo['id'];
			$map['status'] = 2;
			$map['pay_time'] = time();
			$model->save($map);
			//step2  账户余额改变
			D('Member')->where(array('id'=>$member['id']))->setDec('reward',$dataInfo['price']);
			$return['info'] = '返现成功！';
			$return['status'] = 1;
			$this->HuiMsg ( $return );
		}else{
			$return['info'] = $data['return_msg'];
			$this->HuiMsg ( $return );
		}
	
	}
	//xml文档 转换成数组
	public function xmltoarray($xml){
		libxml_disable_entity_loader(true);
		$xmlstring = simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA);
		$val = json_decode(json_encode($xmlstring),true);
	
		return $val;
	}
	//生成签名
	public function checkSign(){
		$dataArr=array();
	
		$dataArr['amount']=$this->amount;
	
		$dataArr['check_name']=$this->check_name;
	
		$dataArr['desc']=$this->desc;
	
		$dataArr['mch_appid']=$this->mch_appid;
	
		$dataArr['mchid']=$this->mchid;
	
		$dataArr['nonce_str']=$this->nonce_str;
	
		$dataArr['openid']=$this->openid;
	
		$dataArr['partner_trade_no']=$this->partner_trade_no;
	
		$dataArr['re_user_name']=$this->re_user_name;
	
		$dataArr['spbill_create_ip']=$this->spbill_create_ip;
		$sign=$this->getSign($dataArr);
		return $sign;
	}
	/**
	 * 作用：生成签名
	 */
	function getSign($Obj)
	{
		foreach ($Obj as $k => $v)
		{
			$Parameters[$k] = $v;
		}
		//签名步骤一：按字典序排序参数
		ksort($Parameters);
		$String = $this->formatBizQueryParaMap($Parameters, false);//方法如下
		//echo '【string1】'.$String.'</br>';
		//签名步骤二：在string后加入KEY
		$String = $String."&key=".$this->key;
		//echo "【string2】".$String."</br>";
		//签名步骤三：MD5加密
		$String = md5($String);
		//echo "【string3】 ".$String."</br>";
		//签名步骤四：所有字符转为大写
		$result_ = strtoupper($String);
		//echo "【result】 ".$result_."</br>";
		return $result_;
	}
	/**
	 * 拼写xml参数
	 */
	public function checkParam(){
		$sign = $this->checkSign();
		$data="<xml>
	
		<mch_appid>".$this->mch_appid."</mch_appid>
	
		<mchid>".$this->mchid."</mchid>
	
		<nonce_str>".$this->nonce_str."</nonce_str>
	
		<partner_trade_no>".$this->partner_trade_no."</partner_trade_no>
	
		<openid>".$this->openid."</openid>
	
		<check_name>".$this->check_name."</check_name>
	
		<re_user_name>".$this->re_user_name."</re_user_name>
	
		<amount>".$this->amount."</amount>
	
		<desc>".$this->desc."</desc>
	
		<spbill_create_ip>".$this->spbill_create_ip."</spbill_create_ip>
	
		<sign>".$sign."</sign>
	
		</xml>";
		return $data;
	}
	/**
	 * 作用：格式化参数，签名过程需要使用
	 */
	function formatBizQueryParaMap($paraMap, $urlencode)
	{
	
		$buff = "";
		ksort($paraMap);
		foreach ($paraMap as $k => $v)
		{
			if($urlencode)
			{
				$v = urlencode($v);
			}
			//$buff .= strtolower($k) . "=" . $v . "&";
			$buff .= $k . "=" . $v . "&";
		}
		$reqPar;
		if (strlen($buff) > 0)
		{
			$reqPar = substr($buff, 0, strlen($buff)-1);
		}
	
		return $reqPar;
	}
}