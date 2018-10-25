<?php
namespace Admin\Controller;
use think\Request;

/**
 * 会员控制器
 * 
 * @author BoBo
 *
 */
class MemberController extends CommController {
    
    /**
     * 构造函数
     */
    public function _initialize() {
        parent::_initialize();
        // 模型
        $this->model = D( 'Member' );
    }
	function import()
	{
		$this->display();
	}
	/**
	 * 导入excel
	 */
	public function importExcel(){
		if (!empty($_FILES)){
			$upload = new \Think\Upload();
			$upload->maxSize   =     10485760 ;
			$upload->exts      =     array('xls','xlsx');
			$upload->rootPath  =     './Uploads/';
			$upload->savePath  =     '/excel/'; // 设置附件上传（子）目录
			$upload->autoSub   = false;          // 将自动生成以photo后面加时间的形式文件夹，关闭
			$info   =   $upload->upload();// 上传文件
			$exts   = $info['file']['ext'];// 获取文件后缀
			$filename = $upload->rootPath.'excel/'.$info['file']['savename'];        // 生成文件路径名
			if(!$info) {                                                     // 上传错误提示错误信息
				$this->error($upload->getError());
			}else{
				vendor("PHPExcel.PHPExcel");                              // 导入PHPExcel类库
				$PHPExcel = new \PHPExcel();                                 // 创建PHPExcel对象，注意，不能少了\
				if ($exts == 'xls') {                                        // 如果excel文件后缀名为.xls，导入这个类
					vendor("PHPExcel.PHPExcel.Reader.Excel5");
					$PHPReader = new \PHPExcel_Reader_Excel5();
				} elseif ($exts == 'xlsx') {
						vendor("PHPExcel.PHPExcel.Reader.Excel2007");
						$PHPReader = new \PHPExcel_Reader_Excel2007();
					}
				$PHPExcel=$PHPReader->load($filename);
				$currentSheet = $PHPExcel->getSheet(0);                      // 获取表中的第一个工作表，如果要获取第二个，把0改为1，依次类推
				$allColumn = $currentSheet->getHighestColumn();              // 获取总列数
				$allRow = $currentSheet->getHighestRow();                    // 获取总行数
				$data=array();
				for($j=1;$j<=$allRow;$j++){
					for($k='A';$k<=$allColumn;$k++){	//从A列读取数据
						$data[$j][]=$PHPExcel->getActiveSheet()->getCell("$k$j")->getValue();// 读取单元格
					}
				}
				for ($i = 2; $i <= $allRow; $i++){
					$data_p['username'] =$PHPExcel->getActiveSheet()->getCell("A" . $i)->getValue();
					$data_p['nickname'] =$PHPExcel->getActiveSheet()->getCell("B" .$i)->getValue();
					$data_p['password'] =$PHPExcel->getActiveSheet()->getCell("C" .$i)->getValue();
					$data_p['auth'] =$PHPExcel->getActiveSheet()->getCell("D" .$i)->getValue();
					$data_p['cid'] =$PHPExcel->getActiveSheet()->getCell("E" .$i)->getValue();
					$data_p['department_id'] =$PHPExcel->getActiveSheet()->getCell("F" .$i)->getValue();
					$data_p['personal_code'] =$PHPExcel->getActiveSheet()->getCell("G" .$i)->getValue();
					$data_p['status'] =$PHPExcel->getActiveSheet()->getCell("H" .$i)->getValue();
					$data_p['create_time'] =time();
//					$data_p['lifetime'] =intval(($PHPExcel->getActiveSheet()->getCell("C" .$i)->getValue()-25569)* 3600 * 24);//此处时间之所以这样处理，是因为excel表格日期导入数据库不是正确的时间戳
					if(D('member')->where('username='.$data_p['username'])->find()){
						echo "<script language=\"JavaScript\">\r\n";
						echo " alert('手机号".$data_p['username']."已经存在');\r\n";
						echo " history.back();\r\n";
						echo "</script>";
						return false;
					}
					if(D('member')->where(array('personal_code'=>$data_p['personal_code']))->find()){
						echo "<script language=\"JavaScript\">\r\n";
						echo " alert('代号".$data_p['personal_code']."已经存在');\r\n";
						echo " history.back();\r\n";
						echo "</script>";
						return false;
					}
					$ex = D('member')->add($data_p);
				}
				if($ex){
					echo "<script language=\"JavaScript\">\r\n";
					echo " alert('导入成功');\r\n";
					echo "</script>";
					$this->redirect('index');
//					$this->success("导入成功");
				}else{
					$this->error("导入失败，原因可能是excel表中格式错误","5");// 提示错误
				}
			}
		}else {
			$this->display();
		}

	}
	/**
	 * 导出到excel
	 */
	public function excelImport(){
		if($this->user['auth'] != 1){
			$map['cid'] = $this->user['company_id'];
		}
		$data= D('member')->alias('m')
			->join('left join db_company as c on c.id = m.cid')
			->join('left join db_department as d on d.id = m.department_id')
			->field('m.personal_code,m.username,m.nickname,c.companyname,d.department_name')
			->where($map)
			->select();
		vendor("PHPExcel.PHPExcel");
		error_reporting(E_ALL);//错误级别
		date_default_timezone_set('Europe/London');//时间
		$objPHPExcel = new \PHPExcel();//实例化对象
		vendor("PHPExcel.PHPExcel.Reader.Excel5");
		// /*设置excel的属性*/ 可有可无
//		$objPHPExcel->getProperties()->setCreator("Admin")//创建人
//		->setLastModifiedBy("A")//最后修改人
//		->setTitle("产品EXCEL导出")//标题
//		->setSubject("产品EXCEL导出")//题目
//		->setDescription("产品")//描述
//		->setKeywords("excel")//关键字
//		->setCategory("result file");//种类
		//第一行数据
		$objPHPExcel->setActiveSheetIndex(0)
			->setCellValueExplicit('A1', '个人代号')
			->setCellValueExplicit('B1', '手机号')
			->setCellValueExplicit('C1', '昵称')
			->setCellValueExplicit('D1', '所属单位')
			->setCellValueExplicit('E1', '所属部门');
//			->setCellValueExplicit('F1', '部门ID')
//			->setCellValueExplicit('G1', '个人代号');
		$objActSheet=$objPHPExcel->getActiveSheet();
		foreach($data as $k => $v){
			$k=$k+1;
			$num=$k+1;//数据从第二行开始录入
			$objActSheet
				//Excel的第A列，查出数组的键值，下面以此类推
				->setCellValueExplicit('A'.$num, $v['personal_code'],\PHPExcel_Cell_DataType::TYPE_STRING)
				->setCellValueExplicit('B'.$num, $v['username'],\PHPExcel_Cell_DataType::TYPE_STRING)
				->setCellValueExplicit('C'.$num, $v['nickname'],\PHPExcel_Cell_DataType::TYPE_STRING)
				->setCellValueExplicit('D'.$num, $v['companyname'],\PHPExcel_Cell_DataType::TYPE_STRING)
				->setCellValueExplicit('E'.$num, $v['department_name'],\PHPExcel_Cell_DataType::TYPE_STRING);
//				->setCellValueExplicit('F'.$num, $v['department_id'],\PHPExcel_Cell_DataType::TYPE_STRING)
//				->setCellValueExplicit('G'.$num, $v['personal_code'],\PHPExcel_Cell_DataType::TYPE_STRING);


			//设置单元格宽度自动 以下设置宽度可有可无
//			$objActSheet->getColumnDimension('B')->setAutoSize(true);
//			$objActSheet->getColumnDimension('C')->setAutoSize(true);
//			$objActSheet->getColumnDimension('D')->setAutoSize(true);
//			$objActSheet->getColumnDimension('E')->setAutoSize(true);
//			$objActSheet->getColumnDimension('F')->setAutoSize(true);
//			$objActSheet->getColumnDimension('G')->setAutoSize(true);
//			$objActSheet->getColumnDimension('H')->setAutoSize(true);
//			$objActSheet->getColumnDimension('I')->setAutoSize(true);
//			$objActSheet->getColumnDimension('J')->setAutoSize(true);
//			$objActSheet->getColumnDimension('K')->setAutoSize(true);
		}
		$objPHPExcel->setActiveSheetIndex(0);
		header('Content-Type: application/vnd.ms-excel');
		header('Content-Disposition: attachment;filename="'.time().'.xls"');
		header('Cache-Control: max-age=0');
		$objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
		$objWriter->save('php://output');
		exit;
	}
	/**
     * 会员信息列表
     */
    public function index() {
        // 获取参数
//        $this->paramter['username'] = I( 'post.username', '' );
//        $this->paramter['nickname'] = I( 'post.nickname', '' );
//        $this->paramter['level'] = I( 'post.level', '' );
//        $this->paramter['referral_code'] = I( 'post.referral_code', '' );
//        $this->paramter['recommended_code'] = I( 'post.recommended_code', '' );
        // 用户名
        if ($_POST['personal_code']) {
            $condition['personal_code'] = array( 'like', "%{$_POST['personal_code']}%" );
        }
        // 姓名
        if ( $_POST['tel']) {
            $condition['username'] = array( 'like', "%{$_POST['tel']}%" );
        }
        // 设置查询条件
        $condition['m.is_delete'] = 0;
        if($_GET['id']){
			$condition['department_id'] = $_GET['id'];
		}
		if($_GET['cid']){
			$condition['cid'] = $_GET['cid'];
		}
		$field = 'm.id,m.username,m.nickname,m.auth,m.personal_code,m.status,m.create_time,c.companyname,d.department_name,m.is_delete';
//        $dataList = $this->model->getList( $condition, $field,array( 'begin' => 0, 'num' => 0 ),"sort desc" );
		if($this->user['auth'] != 1){
			$condition['cid'] = $this->user['company_id'];
		}
		$dataList = D('member')->alias('m')->join('left join db_company as c on m.cid = c.id')
			->join('left join db_department as d on m.department_id = d.id')
			->field($field)
			->where($condition)
			->order('cid')
			->select();
		foreach($dataList as $k=>$v){
			if($v['auth'] == 1){
				$dataList[$k]['auth'] = '一级审批人';
			}elseif($v['auth'] == 2){
				$dataList[$k]['auth'] = '二级审批人';
			}elseif($v['auth'] == 5){
				$dataList[$k]['auth'] = '人力资源';
			}elseif($v['auth'] == 4){
				$dataList[$k]['auth'] = '抄送人';
			}elseif($v['auth'] == 0){
				$dataList[$k]['auth'] = '普通人员';
			}elseif($v['auth'] == 3){
				$dataList[$k]['auth'] = '三级审批人';
			}
		}
		if($this->user['auth'] != 1){
			$des = D('department')->field('id,department_name')->where(array('companyid'=>$this->user['company_id']))->select();
			$this->assign( "department", $des);
		}else{
			$com = D('company')->field('id,companyname')->select();
			$this->assign( "company", $com);
		}
        $this->assign( "dataList", $dataList );
        $this->display();
    }

	function add(){
		if($_POST){
			if(!is_numeric($_POST['username']) || strlen($_POST['username']) != 11){
				echo "<script language=\"JavaScript\">\r\n";
				echo " alert('手机号格式不正确');\r\n";
				echo " history.back();\r\n";
				echo "</script>";
				return false;
			}
			if(D('member')->where('username='.$_POST['username'])->find()){
				echo "<script language=\"JavaScript\">\r\n";
				echo " alert('手机号".$_POST['username']."已经存在');\r\n";
				echo " history.back();\r\n";
				echo "</script>";
				return false;
			}
			if(D('member')->where(array('personal_code'=>$_POST['personal_code']))->find()){
				echo "<script language=\"JavaScript\">\r\n";
				echo " alert('代号".$_POST['personal_code']."已经存在');\r\n";
				echo " history.back();\r\n";
				echo "</script>";
				return false;
			}
			if(!is_numeric(substr($_POST['personal_code'],2)) || strlen(substr($_POST['personal_code'],2)) != 8){
				echo "<script language=\"JavaScript\">\r\n";
				echo " alert('代号".$_POST['personal_code']."不合法');\r\n";
				echo " history.back();\r\n";
				echo "</script>";
				return false;
			}
			$_POST['status'] = 0;
			$_POST['create_time'] = time();
			$_POST['password'] = sha1($_POST['password']);
			if($this->user['auth'] != 1){
				$_POST['cid'] = $this->user['company_id'];
			}
			$res = D('member')->add($_POST);
			if($res){
				$this->redirect('index');
			}
		}
		if($this->user['auth'] == 1){
			$com = D('company')->field('id,companyname')->select();
			$this->assign('company',$com);
			$de = D('department')->field('id,department_name')->select();
			$this->assign('department',$de);
		}else{
			$de = D('department')->where(array('companyid'=>$this->user['company_id']))->field('id,department_name')->select();
			$this->assign('department',$de);
		}
		$this->display();
	}
	function edit(){
		$id = $_GET['id'];
		if($_POST){
			$id = $_POST['id'];
			$cid = $_POST['cid'];
			if($_POST['auth'] == 1){
				$auth1 = D('member')->where(array('auth'=>1,'cid'=>$cid))->getField('range_time');
				$_POST['range_time'] = empty($auth1) ? 24 : $auth1;
			}elseif($_POST['auth'] == 2){
				$auth2 = D('member')->where(array('auth'=>2,'cid'=>$cid))->getField('range_time');
				$_POST['range_time'] = empty($auth2) ? 48 : $auth2;
			}elseif($_POST['auth'] == 3){
				$auth3 = D('member')->where(array('auth'=>3,'cid'=>$cid))->getField('range_time');
				$_POST['range_time'] = empty($auth3) ? 72 : $auth3;
			}else{
				$_POST['range_time'] = 0;
			}
			$res = D('member')->where('id='.$id)->save($_POST);
			if($res){
				$this->redirect('index');
			}
		}
		$res = D('member')->where('id='.$id)->find();
		$res['company'] = D('company')->where('id='.$res['cid'])->getField('companyname');
		$res['department'] = D('department')->where('id='.$res['department_id'])->getField('department_name');
		$department = D('department')->where(array('companyid'=>$res['cid']))->field('id,department_name')->select();
		foreach($department as $k=>$v){
			if($v['department_name'] == $res['department']){
				unset($department[$k]);
			}
		}
//		dump($res);die;
//		if($this->user['auth'] == 1){
//			$company = D('company')->field('id,companyname')->select();
//			foreach($company as $k=>$v){
//				if($v['companyname'] == $res['company']){
//					unset($company[$k]);
//				}
//			}
//			$this->assign('company',$company);
//		}
		$this->assign('department',$department);
		$this->assign('res',$res);
		$this->display();

	}
	function status()
	{
		$id = $_GET['id'];
		$status['status'] = $_GET['status'];

		$res = D('member')->where('id='.$id)->save($status);
		if($res){
			$this->redirect('index');
		}
	}
    function delete()
    {
        $id = $_GET['id'];
        $res = D('member')->where('id='.$id)->delete();
        if($res){
            $this->redirect('index');
        }
    }

	function getDepartment()
	{
		if (IS_POST&&IS_AJAX) {
			$departmentList = D('Department')->where(['companyid'=>I('post.id')])->select();
			echo json_encode($departmentList);
		}
	}
    /**
     * 会员信息查看
     */
    public function details() {
        // 获取参数
        $theId = I( 'get.id', 0 );
        if ( is_number( $theId ) ) {
            die( '参数错误：id' );
        }
        $dataInfo = $this->model->getOne( $theId );
		
		// 获取等级
		$dataInfo['level_title'] = D('Category')->getOne( $dataInfo['level'], 'id', false, 'title' );
		
        //获取默认的收货信息
        $map['is_delete'] = 0;
        $map['uid'] = $dataInfo['id'];
        $map['is_default'] = 1;
        $address = D('Address')->where($map)->find();
        
        $dataInfo['address_nickname'] = $address['nickname'];
        $dataInfo['address_tel'] = $address['tel'];
        $province = D('HatProvince')->where(array('province_id'=>$address['province']))->getField('province');
        $this->assign( 'dataInfo', $dataInfo );
        
        // 数据统计[未统计完]
        // 直接粉丝人数
        $this->assign( 'direct_fans', $this->model->getFansCount( $dataInfo['referral_code'], 'direct' ) );
        // 直接粉丝人数
        $this->assign( 'indirect_fans', $this->model->getFansCount( $dataInfo['referral_code'], 'indirect' ) );
        // 渲染模板
        $this->display();
    }
    /**
     * 团推人数获取
     * @param number $recommend 推销号
     */
    protected $countList = 0;
    function getSubList( $recommend) {
    	$map['recommended_code'] = $recommend;
    	$map['is_delete'] = 0;
    	$map['status'] = 0;
    	$newArray = D('Member')->where( $map )->select();
    	for ( $i = 0, $size = count( $newArray ); $i < $size; $i ++ ) {
    		$this->countList ++;
    		$this->getSubList( $newArray[$i]['referral_code']);
    	}
    }
    
    /**
     * 会员钱包充值
     */
    public function walletRecharge() {
    	$id = I( 'get.id', 0 );
    	if ( empty( $id ) ) {
    		die('id不能为空！');
    	}
    	$this->assign( 'id', $id );
    	// 渲染模板
    	$this->display();
    }

    /**
     * 添加会员钱包充值记录
     */
    public function addWalletRecharge() {
    	$return = returnMsg();
    	$data = array();
    	$idlist = I( 'post.id', 0 );
    	$price = I( 'post.price', 0 );
    	if ( empty( $idlist ) ) {
    		$return['info'] = '没有选择需要充值的会员！';
    		$this->HuiMsg( $return );
    	}
    	if ( empty( $price ) ) {
    		$return['info'] = '充值金额填写有误！';
    		$this->HuiMsg( $return );
    	}
    	$memberModel = D('Member');
    	$moneyModel = D( 'MemberMoneyRecord' );
    	$idlist = array_merge( array_filter( explode( ",", $idlist ) ) );
    	$flag = true;
    	foreach ( $idlist as $key ) {
    		$balance = $memberModel->getOne( $key, 'id', false, 'money' );
    		$rows = array();
    		$rows['uid'] = $key;
	    	$rows['price'] = $price;
	    	$rows['balance'] = $balance + $price;
	    	$rows['type'] = 40;
	    	$rows['create_time'] = time();
    		$isMoney = $moneyModel->add( $rows );
    		// 更新会员钱包金额
    		$member = array();
    		$member['id'] = $key;
    		$member['money'] = $rows['balance'];
    		$isMember = $memberModel->save( $member );
    		if ( !$isMoney || !$isMember ) {
    			$flag = false;
    			$return['info'] = "id({$key})钱包明细或更新钱包余额失败!";
    			break;
    		}
    	}
    	
    	if ( $flag ) {
    		$return['status'] = 1;
			$return['info'] = "充值成功!";
    	}
    	$this->HuiMsg( $return );
    }

    /**
     * 生成1000x1000像素的二维码
     */
    public function erweima() {
    	$theId = I ( 'get.theId', 0 );
		$theMember = D ( 'Member' )->where ( array ('id' => $theId ) )->find ();
    	// 会员专用二维码
    	$filename = "Uploads/erweima/{$theMember['referral_code']}_1000x1000.png";
    	$url = 'http://m.xiaoqiaowang.com/Login/register/code/' . $theMember['referral_code'];
    	//if (! file_exists ( $filename )) {
    		vendor ( 'phpqrcode.phpqrcode' );
    		$errorCorrectionLevel = "L";
    		$matrixPointSize = "150";
    		\QRcode::png ( $url, $filename, $errorCorrectionLevel, $matrixPointSize, 2 );
    	//}
    	header( 'Location:http://'. $_SERVER ['HTTP_HOST'] . __ROOT__ . '/' . $filename );
    }
}