<?php
namespace Admin\Controller;

/*
 * 新闻动态
 */
class DepartmentController extends CommController {
    public function _initialize() {
        parent::_initialize ();
    
    }

    public function index(){
//        $departmentModel = D('Department');
//        $userModel = D('User');
//        $departmentList = $departmentModel
//                    ->alias('c')
//                    ->field('c.id,c.department_name,c.modifytime,u.nickname')
//                    ->join('left join db_user AS u ON u.company_id=c.id')
//                    ->where(['c.companyid='.$this->getUserCompany()['company_id'],'c.is_delete'=>0])
//                    ->select();
        // print_r($departmentList);die;
        $field = 'd.department_name,d.id,d.companyid,d.shorthandname,d.modifytime,c.companyname';
        if($this->user['auth'] == 1){
            $departmentList = D('department')->alias('d')
                ->join('left join db_company AS c ON d.companyid=c.id')
//                ->join('left join db_member as m on d.id=m.department_id')
                ->order('companyname desc')
                ->field($field)
                ->select();
            foreach($departmentList as $k=>$v){
                $departmentList[$k]['auth1'] = D('member')->where(array('auth'=>1,'department_id'=>$v['id']))->field('personal_code')->select();
                $departmentList[$k]['auth1'] = implode(',',array_column($departmentList[$k]['auth1'],'personal_code'));
                $departmentList[$k]['auth2'] = D('member')->where(array('auth'=>2,'department_id'=>$v['id']))->field('personal_code')->select();
                $departmentList[$k]['auth2'] = implode(',',array_column($departmentList[$k]['auth2'],'personal_code'));
                $departmentList[$k]['auth3'] = D('member')->where(array('auth'=>3,'department_id'=>$v['id']))->field('personal_code')->select();
                $departmentList[$k]['auth3'] = implode(',',array_column($departmentList[$k]['auth3'],'personal_code'));
                $departmentList[$k]['auth4'] = D('member')->where(array('auth'=>4,'department_id'=>$v['id']))->field('personal_code')->select();
                $departmentList[$k]['auth4'] = implode(',',array_column($departmentList[$k]['auth4'],'personal_code'));
            }
//            dump($departmentList);die;
        }else{
            $map['companyid'] = $this->user['company_id'];
            $departmentList = D('department')->where($map)->field('id,department_name,shorthandname,modifytime')->select();
            foreach($departmentList as $k=>$v){
                $where['department_id'] = $v['id'];
                $where['cid'] = $this->user['company_id'];
                $departmentList[$k]['auth1'] = D('member')->where($where)->where('auth=1')->field('personal_code')->select();
                $departmentList[$k]['auth1'] = implode(',',array_column($departmentList[$k]['auth1'],'personal_code'));
                $departmentList[$k]['auth2'] = D('member')->where($where)->where('auth=2')->field('personal_code')->select();
                $departmentList[$k]['auth2'] = implode(',',array_column($departmentList[$k]['auth2'],'personal_code'));
                $departmentList[$k]['auth3'] = D('member')->where($where)->where('auth=3')->field('personal_code')->select();
                $departmentList[$k]['auth3'] = implode(',',array_column($departmentList[$k]['auth3'],'personal_code'));
                $departmentList[$k]['auth4'] = D('member')->where($where)->where('auth=4')->field('personal_code')->select();
                $departmentList[$k]['auth4'] = implode(',',array_column($departmentList[$k]['auth4'],'personal_code'));
            }
//            dump($departmentList);die;
            foreach($departmentList as $k=>$v){
                $departmentList[$k]['companyname'] = D('company')->where(array('id'=>$this->user['company_id']))->getField('companyname');
                $departmentList[$k]['companyid'] = $this->user['company_id'];
            }
        }

//        dump($this->getUserCompany());exit;
        $this->assign('dataList',$departmentList);
        $this->display();
    }
    function add(){
        if($_POST){
            $_POST['create_time'] = time();
            $map['department_name'] = $_POST['department_name'];
            if($this->user['auth'] != 1){
                $map['companyid'] = $this->user['company_id'];
                $_POST['companyid'] = $this->user['company_id'];
            }else{
                $map['companyid'] = $_POST['companyid'];
            }
            if(D('department')->where($map)->find()){
                echo "<script language=\"JavaScript\">\r\n";
                echo " alert('部门已经存在');\r\n";
                echo " history.back();\r\n";
                echo "</script>";
                return false;
            }
            $res = D('department')->add($_POST);
            if($res){
                $this->redirect('index');
            }
        }
        if($this->user['auth'] == 1){
            $res = D('company')->field('id,companyname')->select();
            $this->assign('res',$res);
        }
        $this->display();
    }
    function edit(){
        if($_POST){
            $res = D('department')->where('id='. $_POST['id'])->save($_POST);
            if($res || !empty($_POST['id'])){
                $this->redirect('index');
            }
        }
        $res = D('department')->where('id='.$_GET['id'])->find();
        $this->assign('dataInfo',$res);
        $this->display();
    }
    function delete(){
        $id = $_GET['id'];
        $res = D('department')->where('id='.$id)->delete();
        if($res){
            $this->redirect('index');
        }
    }
    public function chargeadd(){
        if (IS_POST) {
            $data['charge'] = implode(",", $_POST['id']);
            $data['id'] = $_POST['department_id'];
            D('Department')->save($data);


            $return ['info'] = '添加成功';
            $return ['state'] = 1;
            return $return;
        }else{
            $memberModel = D('Member');
            $memberCondition['cid'] = $this->getUserCompany()['company_id'];
            $memberCondition['department_id'] = $_GET['id'];
            $memberCondition['is_delete'] = 0;
            $memberCondition['status'] = 0;

            $memberList = $memberModel->where($memberCondition)->select();
            $charge = D('Department')->where('id='.$_GET['id'])->field('charge')->find();
            // $second_charge = D('Department')->where('id='.$_GET['id'])->field('second_charge')->find();
            // $third_charge = D('Department')->where('id='.$_GET['id'])->field('third_charge')->find();
            // print_r(explode(',',$first_charge['first_charge']));die;
            $this->assign('charge',explode(',',$charge['charge']));
            // $this->assign('second_charge',explode(',',$second_charge['second_charge']));
            // $this->assign('third_charge',explode(',',$third_charge['third_charge']));
            
            $this->assign('department_id',$_GET['id']);
            $this->assign('memberList',$memberList);



            $this->display();
        }
        
    }

    function update(){
        $id = $_POST['id'];
        $data['department_name'] = $_POST['department_name'];
        $data['shorthandname'] = $_POST['shorthandname'];
        $res = D('department')->where('id='.$id)->save($data);
        if($res){
            $this->redirect('index');
        }
    }

    public function _before_create(){
        $_POST['companyid'] = $this->getUserCompany()['id'];
        $_POST['operatinguser'] = session('userAuth')['id'];
    }


}