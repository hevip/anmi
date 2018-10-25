<?php
namespace Home\Controller;

/**
 * 企业支付
 *
 * @author feton_xin
 *        
 */
class EnterprisepaymentController extends CommController {

	/**
	 * 构造函数
	 */
	public function _initialize() {
		parent::_initialize ();
		$this->mch_appid='wxe66923b6bbc9f43d';//公众账号appid
		$this->mchid='1370261802';//商户号
		$this->openid='ozk9cv98McLvl462McVjbh-0q3bI';//会员opid,就是微信号  一般会存进会员数据库
		$this->key = '1d52492656816b2d968fb5454a10ad1e';//签名用key值
		/**
		 * 校验用户姓名选项，NO_CHECK：不校验真实姓名， FORCE_CHECK：强校验真实姓名（未实名认证的用户会校验失败，无法转账），
		 *OPTION_CHECK：针对已实名认证的用户才校验真实姓名（未实名认证用户不校验，可以转账成功）
		**/
		$this->check_name='NO_CHECK';
		$this->nonce_str='qyzf'.rand(100000, 999999);//随机数

		$this->partner_trade_no='xx'.time().rand(10000, 99999);//商户订单号
		$this->re_user_name='测试';//用户姓名
		$this->amount=100;//企业金额，这里是以分为单位（必须大于100分）
		$this->desc='测试数据呀！！！';//描述
		$this->spbill_create_ip='118.123.12.63';//请求ip
		
	}
	/**
	 * 向企业付款
	 */
	public function payment(){
		$ch = curl_init ();
		
		$MENU_URL="https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers";
		curl_setopt ( $ch, CURLOPT_URL, $MENU_URL );
		curl_setopt ( $ch, CURLOPT_CUSTOMREQUEST, "POST" );
		curl_setopt ( $ch, CURLOPT_SSL_VERIFYPEER, FALSE );
		curl_setopt ( $ch, CURLOPT_SSL_VERIFYHOST, FALSE );
		$data = $this->checkParam();
		//两个证书（必填，请求需要双向证书。）		
		vendor ( 'WXAPI.WxPayPubHelper' );
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
		
		if (curl_errno ( $ch )) {
		
			echo 'Errno' . curl_error ( $ch );
		
		}		
		curl_close ( $ch );				
		print_r($info);		
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