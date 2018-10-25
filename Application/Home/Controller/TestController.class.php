<?php 

namespace Home\Controller;

use Think\Controller;

class TestController extends CommController {

  public function _initialize() {
    parent::_initialize ();
 
  }
  public function index()
  {

      $a = 'aaa';
      $b = 12365478;
      $c = 12365478;
      $d = 12365478;
      $e = 12365478;

      exec('java -jar /etc/alternatives/jre/lib/ext/XXTEACAI.jar '.$a.' '.$b.' '.$c.' '.$d.' '.$e,$output);

      $encode = mb_detect_encoding(current(array_filter($output)), array("ASCII","UTF-8","GB2312","GBK","BIG5"));
      $string = iconv("UTF-8","ASCII",current(array_filter($output))); 
        
          // print_r($this->member['personal_code']);
          // // print_r($output);
          // die;
          // return $string;
      $code = $this->member['personal_code'];
    $filename = "Uploads/erweima/$code.png";
    $this->create_erweima ( $filename, $string );

    // print_r($filename);die;
    echo "<img src='$filename'>";
    
  }

  function toString() { return "hello PHP from Java!"; }

  private function create_erweima($filename, $url) {
    if (file_exists ( $filename )) {
      vendor ( 'phpqrcode.phpqrcode' );
      $errorCorrectionLevel = "L";
      $matrixPointSize = "5.5";
      \QRcode::png ( $url, $filename, $errorCorrectionLevel, $matrixPointSize, 2 );
      // 读取背景图片
      $groundImage = 'Public/Home/Images/shouzhiyin_03.png';
      if (! empty ( $groundImage ) && file_exists ( $groundImage )) {
        // 获取图片大小
        $ground_info = getimagesize ( $groundImage );
        // 宽
        $ground_w = $ground_info [0];
        // 高
        $ground_h = $ground_info [1];
        //
        $ground_im = imagecreatefrompng ( $groundImage );
      }
      // 读取二维码图片
      $codeImage = $filename;
      if (! empty ( $codeImage ) && file_exists ( $codeImage )) {
        // 获取图片大小
        $code_info = getimagesize ( $codeImage );
        // 宽
        $code_w = $code_info [0];
        // 高
        $code_h = $code_info [1];
        //
        $code_im = imagecreatefrompng ( $codeImage );
      }
      // 设定图像的混色模式
      imagealphablending ( $ground_im, true );
      // 拷贝二维码到目标文件
      imagecopy ( $ground_im, $code_im, 9, 9, 0, 0, $code_w, $code_h );
      imagepng ( $ground_im, $codeImage );
      if (isset ( $code_info )) {
        unset ( $code_info );
      }
      if (isset ( $code_im )) {
        imagedestroy ( $code_im );
      }
      unset ( $ground_info );
      imagedestroy ( $ground_im );
    }
  }
   
}