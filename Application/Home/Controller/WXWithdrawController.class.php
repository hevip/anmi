<?php

namespace Home\Controller;

/**
 * 微信提现支付
 *
 * @author Administrator
 *        
 */
class WXWithdrawController extends CommController {

	/**
     * 构造函数
     */
    public function _initialize() {
        parent::_initialize ();
        $this->checkLogin ();
    }


    /**
     * 提到用户微信钱包
     */
    public function handleWebchat() {
        // 获取配置参数
        $config = $this->config;
        // 获取微信的账户信息
        define ( 'WX_APPID', $config ['wx_app_id'] );
        define ( 'WX_APPSECRET', $config ['wx_app_secret'] );
        define ( 'WX_PAY_MCHID', $config ['wx_pay_mchid'] );
        define ( 'WX_PAY_PASS', $config ['wx_pay_pass'] );
        // 引入微支付类
        vendor ( 'WxPayPubHelper.WxPayPubHelper' );
        // 使用jsapi接口
        $jsApi = new \jsApi_pub ();
        if (! isset ( $_GET ['code'] )) {
            // 参数获取
            $theId = I( 'get.id', 0 );
            if ( is_number( $theId ) ) {
                $this->error( '参数传递错误！', U('Reward/my_coins_wechat') );
            }
            // 查看数据是否存在
            $theArray = D('MemberWithdraw')->where("id = $theId")->find();
            if ( empty( $theArray ) ) {
                $this->error( '数据不存在！', U('Reward/my_coins_wechat') );
            }
            // 触发微信返回code码
            $url = $jsApi->createOauthUrlForCode ( 'http://'.$_SERVER['HTTP_HOST'].'/WXWithdraw/handleWebchat' );
            $state = json_encode( array(
                        'id' => $theArray['id'],        // 提现记录ID
                        'total_fee' => $theArray['price'],      // 支付金额
                        'desc' => '会员微信提现',     // 描述
                    ));
            $url = str_replace( 'STATE', $state, $url );
            Header ( "Location: $url" );
        } else {
            // 获取code
            $code = $_GET ['code'];
            $jsApi->setCode ( $code );
            // 获取openid
            $openid = $jsApi->getOpenId ();
            // 获取参数
            $state = array_merge( array_filter( explode( '/', $_GET['state'] ) ) );
            $state = json_decode( $state[0], true );
            $price = $state['total_fee'];
            $desc = $state['desc'];
            $partner_trade_no = sha1( $state['id'] );
            $ip = $_SERVER["REMOTE_ADDR"];
            //接口参数数组
            $suijishu = md5(time().rand(10000,99999));
            $param = array();
            $param['mch_appid'] = $config ['wx_app_id'];
            $param['mchid'] = $config ['wx_pay_mchid'];
            $param['nonce_str'] = $suijishu ;
            $param['partner_trade_no'] = $partner_trade_no;
            $param['openid'] = $openid;
            $param['check_name'] = 'NO_CHECK';
            $param['amount'] = $price * 100;
            $param['desc'] = $desc;
            $param['spbill_create_ip'] = $ip;
            //生成签名
            $sign = $this->getSign($param);
            //发起商家付款接口
            $requesexml = "<xml>
                                <mch_appid>{$param['mch_appid']}</mch_appid>
                                <mchid>{$param['mchid']}</mchid>
                                <nonce_str>".$suijishu."</nonce_str>
                                <partner_trade_no>".$partner_trade_no."</partner_trade_no>
                                <openid>".$openid."</openid>
                                <check_name>NO_CHECK</check_name>
                                <amount>".$price."</amount>
                                <desc>".$desc."</desc>
                                <spbill_create_ip>".$ip."</spbill_create_ip>
                                <sign>".$sign."</sign>
                            </xml>";
            //使用curl  访问提现接口
            $return = $this->curl_post('https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers',$requesexml);
            //解析返回的数据   进行处理
            $data = $this->xmltoarray($return);
            if($data['return_code']=='SUCCESS' && $data['result_code']=='SUCCESS'){
                // 更新提现状态
                $isWithdraw = D('MemberWithdraw')->where( array( 'id' => $state['id'] ) )->setField( 'status', 2 );
                // 更新资金明细表状态
                $isRewardMoney = D( 'RewardMoney' )->where( array( 'withdraw_id' => $state['id'] ) )->setField( 'status', 1 );
                // 判断是否成功
                if ( $isWithdraw && $isRewardMoney ) {
                    $this->success( '提现成功，请查看你的微信零钱!', U('Reward/index') );
                } else {
                    $this->error( '更新数据信息失败!', U('Reward/my_coins_wechat') );
                }
            }else{
                $this->error( '提现失败!', U('Reward/my_coins_wechat') );
            }
        }
    }

    //生成签名
    private function getSign($Obj){
        $Parameters = array();
        foreach ($Obj as $k => $v) {
            $Parameters[$k] = $v;
        }
        //签名步骤一：按字典序排序参数
        ksort($Parameters);
        $String = $this->formatBizQueryParaMap($Parameters, false);
        //签名步骤二：在string后加入KEY
        $String = $String."&key=d805b62bfe5889999ad1a6dd2b63c41c";
        //签名步骤三：MD5加密
        $String = md5($String);
        //签名步骤四：所有字符转为大写
        $result_ = strtoupper($String);
        return $result_;
    }

    private function formatBizQueryParaMap($paraMap, $urlencode){
        $buff = "";
        ksort($paraMap);
        foreach ($paraMap as $k => $v)
        {
            if($urlencode)
            {
                $v = urlencode($v);
            }
            $buff .= $k . "=" . $v . "&";
        }
        $reqPar;
        if (strlen($buff) > 0)
        {
            $reqPar = substr($buff, 0, strlen($buff)-1);
        }
        return $reqPar;
    }

    //xml文档 转换成数组
    private function xmltoarray($xml){
        libxml_disable_entity_loader(true);
        $xmlstring = simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA);
        $val = json_decode(json_encode($xmlstring),true);

        return $val;
    }

    // curl
    private function curl_post($gateway,$requesexml) {
        $zs1 = getcwd()."/ThinkPHP/Library/Vendor/WxPayPubHelper/cacert/apiclient_cert.pem";
        $zs2 = getcwd()."/ThinkPHP/Library/Vendor/WxPayPubHelper/cacert/apiclient_key.pem";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST,"POST");
        curl_setopt($ch, CURLOPT_SSLCERT,$zs1);
        curl_setopt($ch, CURLOPT_SSLKEY,$zs2);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false ); // 信任任何证书  
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false ); // 检查证书中是否设置域名  
        curl_setopt( $ch, CURLOPT_URL,$gateway );
        curl_setopt($ch, CURLOPT_POSTFIELDS,$requesexml);
        curl_setopt( $ch,  CURLOPT_HEADER, 0 );
        curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
        curl_setopt( $ch, CURLOPT_CONNECTTIMEOUT, 10 );
        $data = curl_exec($ch);
        if($data){
            curl_close($ch);
            return $data;
        } else { 
            $error = curl_errno($ch);
            echo "call faild, errorCode:$error\n"; 
            curl_close($ch);
            return false;
        }
    }



}