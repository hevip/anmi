<?php
namespace Home\Controller;

use Think\Controller;

/**
 * 验证控制器
 *
 * @author BoBo
 *        
 */
class ForgetvertificationController extends Controller {

    /**
     * 检测当前手机号码是否被占用
     */
    public function checkPhone() {
        $returnMsg = returnMsg ( array ('status' => 1,'info' => '未被占用' ) );
        if (IS_AJAX && IS_POST) {
            $username = I ( 'post.username', '' );
            if (empty ( $username )) {
                $returnMsg ['status'] = 0;
                $returnMsg ['info'] = '非法操作!';
            } else {
                if(I('post.flag')=='forget'){
                    
                }else{
                    $map = array();
                    $map['is_delete'] = 0;
                    $map['username'] = $username;
                    $theUser = D ( 'Member' )->where( $map )->find();
                    if ( count( $theUser ) > 0 ) {
                        $returnMsg ['status'] = 0;
                        $returnMsg ['info'] = '电话号码已被占用';
                    }
                }
                
            }
        } else {
            $this->error ( '请勿非法操作！' );
        }
        $this->HuiMsg ( $returnMsg );
    }

    /**
     * 检测当前个人代号是否被占用
     */
    public function checkPersonalCode() {
        $returnMsg = returnMsg ( array ('status' => 1,'info' => '未被占用' ) );
        if (IS_AJAX && IS_POST) {
            $personal_code = I ( 'post.personal_code', '' );
            if (empty ( $personal_code )) {
                $returnMsg ['status'] = 0;
                $returnMsg ['info'] = '非法操作!';
            } else {
                if(I('post.flag')=='forget'){
                    
                }else{
                    $map = array();
                    $map['is_delete'] = 0;
                    $map['personal_code'] = $personal_code;
                    $theUser = D ( 'Member' )->where( $map )->find();
                    if ( count( $theUser ) > 0 ) {
                        $returnMsg ['status'] = 0;
                        $returnMsg ['info'] = '个人代号已被占用';
                    }
                }
                
            }
        } else {
            $this->error ( '请勿非法操作！' );
        }
        $this->HuiMsg ( $returnMsg );
    }

    /**
     * 检测图形验证码
     */
    public function checkVerify() {
        $returnMsg = returnMsg ();
        if (IS_AJAX) {
            $code = I ( 'post.code', '' );
            if (checkVerify ( $code )) {
                $returnMsg ['status'] = 1;
                $returnMsg ['info'] = '&nbsp;&nbsp;';
            } else {
                $returnMsg ['info'] = '验证码错误';
            }
        } else {
            $returnMsg ['info'] = '验证码错误';
        }
        $this->HuiMsg ( $returnMsg );
    }

    /**
     * 发送短信验证
     */
    public function sendSMS() {
            // 设置返回数据
        // $returnMsg = returnMsg ( array ('info' => $_POST ['phone'] ) );
        // 判断电话号码是否为空，若为空，就不执行
        if (! empty ( $_POST ['phone'] )) {
            // 获取电话号码
            $phone = $_POST ['phone'];
            // 创建短信验证码
            $verify = createRandomCode ();
            // 时间限制(分钟)
            $time = 5;
            // 短信模版编号
            $tempId = '345494';
            // 发送短信
            $msg = YunTongXun_Send_Template_SMS ( $phone, array ($verify,$time ), $tempId );
            // $msg = 1;
            if ($msg) {
                // 写入session[code验证码 | effective_time有效时间 | create_time创建时间 | phone电话号码]
                session ( 'smsInfo', array ('code' => $verify,'effective_time' => $time,'create_time' => time (),'phone' => $phone ) );
              
                // 发送状态
                $returnMsg ['status'] = 1;
                $returnMsg ['info'] = $verify;
            }
        }
        $this->HuiMsg( $returnMsg );
    }

    /**
     * 检测短信验证码是否正确
     */
    public function checkSMS() {
        $returnMsg = returnMsg ( array ( 'info' => '短信验证码错误' ) );
        if (IS_AJAX && IS_POST) {
            $phone = I ( 'post.phone', '' );
            $code = I ( 'post.code', '' );
            if (checkSMSCode ( $code, $phone )) {
                $returnMsg ['status'] = 1;
                $returnMsg ['info'] = '&nbsp;&nbsp;';
            }
        }
        $this->HuiMsg( $returnMsg );
    }
}