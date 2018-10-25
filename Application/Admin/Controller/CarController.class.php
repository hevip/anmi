<?php
namespace Admin\Controller;

/**
 * 后台首页
 *
 * @author Administrator
 *        
 */
class CarController extends CommController {

	public function _initialize() {
        parent::_initialize ();
        // 模型
		$this->model = D('Car');
    }

	/**
	 * 用车申请
	 */
	public function index() {
        if($_POST['personal_code']){
            $map['personal_code'] = $_POST['personal_code'];
        }
        if($_POST['car_start_time'] && $_POST['car_end_time']){
            $map['car_start_time'] = array('between',array($_POST['car_start_time'],$_POST['car_end_time']));
        }
        $field = 'id,cid,personal_code,car_num,duration,car_start_time,car_end_time,first_charge,addtime,companyname,cadres,caruse';
        if($this->user['auth'] == 1){
            $res = D('car_application')->field($field)->where($map)->order('addtime desc')->select();
        }else{
            $map['cid'] = $this->user['company_id'];
            $res = D('car_application')->field($field)->where($map)->order('addtime desc')->select();
        }
        foreach($res as $k=>$v){
            $res[$k]['companyname'] = D('company')->where('id='.$v['cid'])->getField('companyname');
        }
        $this->assign('dataList',$res);
		// 渲染视图
		$this->display ();
	}
    //删除
    function del()
    {
        $res = D('car')->where('id='.$_GET['id'])->delete();
        if($res){
            $this->redirect('index');
        }
    }

    /**
     * 车辆列表
     */
	public function carlist()
	{
		if ($this->user['auth'] == 1) {
			$carList = $this->model
					->alias('a')
					->field('a.*,b.companyname')
					->join('left join db_company as b on b.id = a.company_id')
					->where(['a.is_delete'=>0])
                    ->order('addtime desc')
					->select();
		}else{
			$carList = $this->model->where(['company_id'=>$this->user['company_id']])->order('addtime desc')->select();
            foreach ($carList as $key => $value) {
				$carList[$key]['companyname'] = D('company')->where(array('id'=>$this->user['company_id']))->getField('companyname');
			}
		}
        $this->assign('carList',$carList);
		$this->display();
	}
    function add()
    {
        if($_POST){
            $_POST['department_id'] = 0;
            $_POST['status'] = 0;
            $_POST['addtime'] = time();
            if($this->user['auth'] != 1){
                $map['company_id'] = $this->user['company_id'];
                $_POST['company_id'] = $this->user['company_id'];
            }else{
                $map['company_id'] = $_POST['company_id'];
            }
            $map['car_num'] = $_POST['car_num'];
            $car = D('car')->where($map)->find();
            if($car){
                echo "<script language=\"JavaScript\">\r\n";
                echo " alert('车牌号已经存在');\r\n";
                echo " history.back();\r\n";
                echo "</script>";
                return false;
            }
            $res = D('car')->add($_POST);
            if($res){
                $this->redirect('carlist');
            }
        }
        if($this->user['auth'] == 1){
            $res = D('company')->field('id,companyname')->select();
            $this->assign('res',$res);
        }
        $this->display();
    }
    function delete()
    {
        $id = $_GET['id'];
        $res = D('car')->where('id='.$id)->delete();
        if($res){
            $this->redirect('carlist');
        }
    }
    function editCar(){
        if($_POST){
            $res = D('car')->where('id='.$_POST['id'])->save($_POST);
            if($res || !empty($_POST['id'])){
                $this->redirect('carlist');
            }
        }
        $res = D('car')->where('id='.$_GET['id'])->find();
        $this->assign('res',$res);
        $this->display();
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
                    $data_p['company_id'] =$PHPExcel->getActiveSheet()->getCell("A" . $i)->getValue();
                    $data_p['car_num'] =$PHPExcel->getActiveSheet()->getCell("B" .$i)->getValue();
                    $data_p['car_id'] =$PHPExcel->getActiveSheet()->getCell("C" .$i)->getValue();
//                    $data_p['cid'] =$PHPExcel->getActiveSheet()->getCell("D" .$i)->getValue();
//                    $data_p['department_id'] =$PHPExcel->getActiveSheet()->getCell("E" .$i)->getValue();
//                    $data_p['personal_code'] =$PHPExcel->getActiveSheet()->getCell("F" .$i)->getValue();
                    $data_p['addtime'] =time();
//					$data_p['lifetime'] =intval(($PHPExcel->getActiveSheet()->getCell("C" .$i)->getValue()-25569)* 3600 * 24);//此处时间之所以这样处理，是因为excel表格日期导入数据库不是正确的时间戳
                    if(D('car')->where(array('car_num'=>$data_p['car_num']))->find()){
                        echo "<script language=\"JavaScript\">\r\n";
                        echo " alert('车牌号".$data_p['car_num']."已经存在');\r\n";
                        echo " history.back();\r\n";
                        echo "</script>";
                        return false;
                    }
                    $ex = D('car')->add($data_p);
                }
                if($ex){
                    echo "<script language=\"JavaScript\">\r\n";
                    echo " alert('导入成功');\r\n";
                    echo "</script>";
                    $this->redirect('carlist');
//                    $this->success("导入成功");
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
            $map['company_id'] = $this->user['company_id'];
        }
        $data= D('car')->alias('d')
            ->join('left join db_company as c on c.id = d.company_id')
            ->field('c.companyname,d.car_num')
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
            ->setCellValueExplicit('A1', '单位名称')
            ->setCellValueExplicit('B1', '车牌号');
//            ->setCellValueExplicit('C1', '密码')
//            ->setCellValueExplicit('D1', '审批级别')
//            ->setCellValueExplicit('E1', '单位ID')
//            ->setCellValueExplicit('F1', '部门ID')
//            ->setCellValueExplicit('G1', '个人代号');
        $objActSheet=$objPHPExcel->getActiveSheet();
        foreach($data as $k => $v){
            $k=$k+1;
            $num=$k+1;//数据从第二行开始录入
            $objActSheet
                //Excel的第A列，查出数组的键值，下面以此类推
                ->setCellValueExplicit('A'.$num, $v['companyname'],\PHPExcel_Cell_DataType::TYPE_STRING)
                ->setCellValueExplicit('B'.$num, $v['car_num'],\PHPExcel_Cell_DataType::TYPE_STRING);
//                ->setCellValueExplicit('C'.$num, $v['password'],\PHPExcel_Cell_DataType::TYPE_STRING)
//                ->setCellValueExplicit('D'.$num, $v['auth'],\PHPExcel_Cell_DataType::TYPE_STRING)
//                ->setCellValueExplicit('E'.$num, $v['cid'],\PHPExcel_Cell_DataType::TYPE_STRING)
//                ->setCellValueExplicit('F'.$num, $v['department_id'],\PHPExcel_Cell_DataType::TYPE_STRING)
//                ->setCellValueExplicit('G'.$num, $v['personal_code'],\PHPExcel_Cell_DataType::TYPE_STRING);


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



	public function carAdd()
	{
		$userInfo = $this->getUserCompany();
		if (IS_POST) {
			if ($this->model->create()) {
				$result = $this->model->add($_POST);
				if ($result) {
						$return ['status'] = 1 ;
						$return ['info'] = "创建成功!";
				}
			}else {
				$return ['status'] = 0;
				$return ['info'] = "创建失败!";
			}
			$this->HuiMsg( $return );
		}

		$this->assign('userInfo',$userInfo);

		$this->display();
	}
	public function carEdit()
	{
		$id = I ( 'get.id' );

		$carInfo = $this->model
					->alias('a')
					->field('a.*,b.companyname,b.id as company_id')
					->join('left join db_company as b on b.id = a.company_id')
					->where(['a.is_delete'=>0,'a.id'=>$id])
					->find();

		// print_r($carInfo);die;
		$this->assign('carInfo',$carInfo);

		if (IS_POST) {
				$res = $this->model->where ( array ( 'id' =>$_POST['id'] ) )->find ();
				if ($res) {
					$this->model->save ( $_POST );
					$return ['status'] = 1;
					$return ['info'] = '操作成功!';
				}else{
					$return ['status'] = 0;
					$return ['info'] ='操作失败!';
				}
			$this->HuiMsg( $return );
		}
		$this->display ();
	}
/**
 * 派车负责人
 * @return [type] [description]
 */
	public function level(){
    $CarLevelModel = D('CarLevel');
   // if (!$this->isStaffMembers()) {
   //  $this->error('无权查看','/Config/index',1);
   // }
    $dataInfo = $CarLevelModel->where('cid='.$this->getUserCompany()['company_id'])->find();
    $keyarr   = explode(',', $dataInfo['first_charge']);
    $keyarr   = explode(',', $dataInfo['first_charge']);
    $keyarr   = explode(',', $dataInfo['first_charge']);
    $row = $this->getDepartmentMember();

    foreach ($row as $key => $value) {

        foreach ($value['memberList'] as $ke => $val) 
        {
            $getkey = $value['index_name']. $val['id'];

            if(!in_array($getkey,$keyarr))
            {
                unset($row[$key]['memberList'][$ke]);
            }
        }
    }

    // echo "<pre>";
    // print_r($row);exit;
   
    $this->assign('dataInfo',$dataInfo);

	if (IS_POST) {

		if (!$dataInfo) {
    	$_POST['cid'] = $this->getUserCompany()['company_id'];
    	$CarLevelModel->add($_POST);
    	$return['status'] = 1;
    	$return['info'] = '更新成功';
    	$this->HuiMsg( $return );
    }else{


    	// $data['cid'] = $this->getUserCompany()['id'];
        $data['first_min'] = $_POST['first_min'];
        $data['first_max'] = $_POST['first_max'];
        $data['second_min'] = $_POST['second_min'];
        $data['second_max'] = $_POST['second_max'];
        $data['third_min'] = $_POST['third_min'];
        $data['third_max'] = $_POST['third_max'];
    	$CarLevelModel->where('cid='.$this->getUserCompany()['company_id'])->save($data);
    	$return['status'] = 1;
    	$return['info'] = '更新成功';
    	$this->HuiMsg( $return );
    }
   	}
    $this->display();
    }

     /**
     * 获取部门
     * @return [type] [description]
     */
    function getDepartment()
    {

        return $this->departments->where(['companyid'=>$this->getUserCompany()['company_id'],'status'=>0])->select();
    }

    function getDepartmentMember(){

        $memberModel = D('Member');
        $departmentModel = D('Department');
        $carlevelModel = D('CarLevel');
        $departmentList = $departmentModel->where(['companyid'=>$this->getUserCompany()['company_id']])->select();
        foreach ($departmentList as $k => $v) {
            $departmentList[$k]['charge'] = explode(',',$v['charge']);
        }

        foreach ($departmentList as $k => $v) {
            $departmentList[$k]['memberList'] = $memberModel->where(['id'=>['IN',$v['charge']]])->field('id,nickname,personal_code')->select();
        }

        return $departmentList;
    }

    public function addcharge(){
        if (IS_POST) {
            $field = '';
            switch (I('post.field')) {
                case '1':
                   $field='first_charge';
                    break;
                case '2':
                   $field='second_charge';
                    break;
                case '3':
                   $field='third_charge';
                    break;
            }
            $departmentAll  = [];
            foreach ($_POST['index'] as $key => $value) 
            {
                foreach ($value as $ke => $va) 
                {
                    $departmentAll[]= $key.$va;
                }
            }
            D('CarLevel')->where(['cid'=>$this->getUserCompany()['company_id'],'status'=>0])->setField($field,join(',',$departmentAll));

            $return['status'] = 1;
            $return['info'] = '操作成功';
            $this->HuiMsg( $return );

        }

        $memberModel     = D('Member');
        $departmentModel = D('Department');
        $carlevelModel = D('CarLevel');


        $departmentList = $departmentModel->where(['companyid'=>$this->getUserCompany()['company_id']])->select();
        foreach ($departmentList as $k => $v) {
            $departmentList[$k]['charge'] = explode(',',$v['charge']);
        }

        foreach ($departmentList as $k => $v) {
            $departmentList[$k]['memberList'] = $memberModel->where(['id'=>['IN',$v['charge']]])->field('id,nickname,personal_code')->select();
          
        }

        $carLevelModel = D('CarLevel');
        $dataInfo = $carLevelModel->where('cid='.$this->getUserCompany()['company_id'])->find();
         $field = '';
        switch (I('get.cate')) {
            case '1':
               $field='first_charge';
                break;
            case '2':
               $field='second_charge';
                break;
            case '3':
               $field='third_charge';
                break;
        }
        $keyarr   = explode(',', $dataInfo[$field]);


        $this->assign('dataList',$departmentList);
        $this->assign('keyarr',$keyarr);

        $this->assign('field', I('get.cate'));

       
        $this->display();
    }
/**
 * 短语
 * @return [type] [description]
 */
    public function phrase()
    {
        $phraseList = D('Phrase')->where(['cid'=>$this->getUserCompany()['company_id'],'is_delete'=>0,'type'=>2])->select();

        $this->assign('dataList',$phraseList);
        

        $this->display();
    }
    public function addPhrase()
    {
        $_POST['cid']=$this->getUserCompany()['company_id'];
        if (IS_POST) {
             if (D('Phrase')->create()) {
                D('Phrase')->add($_POST);
                $return['status'] = 1;
                $return['info'] = '操作成功';
                $this->HuiMsg( $return );
            }else{
                $return['status'] = 0;
                $return['info'] = '操作失败';
                $this->HuiMsg( $return );
            }
        }
       
        $this->display();
    }

    public function phraseRemove()
    {
       
        $condition ['id'] = I('post.id');
        $condition ['is_delete'] = 1;
        if ( D('phrase')->save ( $condition ) ) {
            $returnMsg ['info'] = '操作成功!';
            $returnMsg ['status'] = 1;
        } else {
            $returnMsg ['status'] = '0';
            $returnMsg ['info'] = '操作失败!';
        }
        $this->HuiMsg( $returnMsg );


    }


}