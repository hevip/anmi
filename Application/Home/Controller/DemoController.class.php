<?php

namespace Home\Controller;

use Think\Controller;

/**
 * 测试
 * Class DemoController
 * 
 * @package Home\Controller
 */
class DemoController extends Controller {
	
	public function test() {

		/* $model = D( 'Category' );
		$condition[ 'status' ] = 0;
		$condition[ 'is_delete' ] = 0;
		$condition[ 'pid' ] = 1;
		$levelList = $model->getList( $condition, "id,title", array( 'begin' => 0, 'num' => 0 ), 'sort asc' );
		$levelMark = array();
		$j = 0;
		for ( $i = count( $levelList ) - 1; $i >= 0; $i -- ) {
			$rows = $levelList[$i];
			$rows['level'] = $j;
			$rows['status'] = $j == 3 ? 'yes' : 'no';
			$j ++;
			$levelMark[] = $rows;
		}
		
		$level = 0;
		$theMember = array('level'=>4);
		if ( $theMember['level'] > $level && $levelMark[ $theMember['level'] ]['status'] == 'no' ) {
			$theA = 0;
			foreach ( $levelMark as $rows ) {
				if ( $rows['status'] == 'yes' ) {
					$thePercent = $rows['level'];
				}
			}
			echo 'thePercent：' . $theA;
		}
		
		echo "<br /><br /><pre>";
		print_r($levelMark); */
		
		
		/* // 获取会员等级
		$model = D( 'Category' );
		$condition[ 'status' ] = 0;
		$condition[ 'is_delete' ] = 0;
		$condition[ 'pid' ] = 1;
		$this->levelList = $model->getList( $condition, "id,title", array( 'begin' => 0, 'num' => 0 ), 'sort asc' );
		$levelList = $this->levelList;
		$member = D('Member')->getOne(13);
		$config = D('Config')->getOne(1);
		$config['grown'] = array_merge( array_filter( explode( '|', $config['grown'] ) ) );

		echo '<pre>';
		//print_r($config['grown']);
		print_r($levelList);
		krsort($config['grown']);
		$config['grown'] = array_merge($config['grown']);
		// 设置等级
		$nowLevel = 0;
		for ( $i = 0, $size = count( $levelList ); $i < $size; $i ++ ) {
			if ( $member['grown'] >= $config['grown'][$i] ) {
				$nowLevel = $levelList[$i]['id'];
				break;
			}
		}
		print_r($config['grown']);
		echo '<br />grown：'.$member['grown'].'<br />nowLevel：'.$nowLevel; */
		
		/* $config = D('Config')->getOne(1);
		$config['reward_recommend'] = array_merge( array_filter( explode( '|', $config['reward_recommend'] ) ) );
		$reward_recommend = $config['reward_recommend'];
		for ( $i = 0, $size = count( $reward_recommend ); $i < $size; $i ++ ) {
			$reward_recommend[$i] = $reward_recommend[$i] / 100;
		}
		echo '<pre>';
		print_r( $reward_recommend ); */
		
		/* $config = D('Config')->getOne(1);
		$config['reward_team'] = array_merge( array_filter( explode( '|', $config['reward_team'] ) ) );
		$reward_team = $config['reward_team'];
		echo '<pre>';
		print_r( $reward_team ); */
		
		$model = D( 'Category' );
		$condition[ 'status' ] = 0;
		$condition[ 'is_delete' ] = 0;
		$condition[ 'pid' ] = 1;
		$levelList = $model->getList( $condition, "id,title", array( 'begin' => 0, 'num' => 0 ), 'sort desc' );
		echo "<pre>";
		print_r($levelList);
		echo $model->where($condition)->order('sort desc')->getField('id');
		
	}
	
	
	// 支付
	public function WXPay() {
		$model = D( 'Member' );
		print_r( $model->where( '1=1' )->select() );
	}
	// 测试微信
	public function demo() {
		$result = D ( 'Demo' )->update ();
		echo $result;
	}
	// 批量生成二维码
	public function batchCreate_erweima() {
		//$map = "username in(13550343136,13551233349,18200420497,18628247280,15982138187,18508160112,15349691578,13980826903,18030870939,18328319257,18980897280)";
		$map = "1=1";
		$memberList = D( 'Member' )->where( $map )->select();
		for ( $i = 0, $size = count( $memberList ); $i < $size; $i ++ ) {
			// 会员专用二维码
			//if ( $i == 0 ) {
				$code = $memberList[$i]['recommend'];
				$filename = "Uploads/erweima/$code.png";
				$url = "http://" . $_SERVER['HTTP_HOST'] . U( 'Login/register/code/'.$code );
				$this->create_erweima( $filename, $url );
				echo  "$code.png create sucess!<br />";	
			//}
		}
	}
	
	// 测试服务器发短信
	public function faduanxin() {
		header( "Content-type:text/html; charset=utf-8" );
		//die( PHP_VERSION );
		$result = YunTongXun_Send_Template_SMS2( "18328319257", array( '123456', '5' ), '33491' );
		print_r( $result );
	}
	
	// 生成会员专用二维码
	private function create_erweima( $filename, $url ) {
		//if ( !file_exists( $filename ) ) {
			vendor( 'phpqrcode.phpqrcode' );
			$errorCorrectionLevel = "L";
			$matrixPointSize = "6";
			\QRcode::png( $url, $filename, $errorCorrectionLevel, $matrixPointSize, 1 );
			// 读取背景图片
			$groundImage = 'Public/Home/Images/shouzhiyin_03.png';
			if ( !empty ( $groundImage ) && file_exists ( $groundImage ) ) {
				// 获取图片大小
				$ground_info = getimagesize( $groundImage );
				// 宽
				$ground_w = $ground_info[0];
				// 高
				$ground_h = $ground_info[1];
				//
				$ground_im = imagecreatefrompng( $groundImage );
			}
			// 读取二维码图片
			$codeImage = $filename;
			if ( !empty ( $codeImage ) && file_exists ( $codeImage ) ) {
				// 获取图片大小
				$code_info = getimagesize( $codeImage );
				// 宽
				$code_w = $code_info[0];
				// 高
				$code_h = $code_info[1];
				//
				$code_im = imagecreatefrompng( $codeImage );
			}
			// 设定图像的混色模式
			imagealphablending ( $ground_im, true );
			// 拷贝二维码到目标文件
			imagecopy( $ground_im, $code_im, 20, 15, 0, 0, $code_w, $code_h);
			imagepng ( $ground_im, $codeImage );
	
			if (isset ( $code_info )) {
				unset ( $code_info );
			}
			if (isset ( $code_im )) {
				imagedestroy ( $code_im );
			}
			unset ( $ground_info );
			imagedestroy ( $ground_im );
		//}
	}
}