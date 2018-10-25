<?php

namespace Home\Controller;

/**
 * 收货地址管理类
 * 
 * @author Administrator
 *        
 */
class AddressController extends CommController {
	
	// 初始化
	public function _initialize() {
		parent::_initialize ();
		$this->checkLogin ();
	}
	public function index(){
		$map['is_delete'] = 0;
		$map['uid'] = $_SESSION['member_auth']['id'];
		$dataList = D('Address')->where($map)->select();
		foreach ($dataList as $key=>$val){
			$province = D ( 'HatProvince' )->where(array('province_id'=>$val['province']))->getField('province');
			$city = D ( 'HatCity' )->where(array('city_id'=>$val['city']))->getField('city');
			$area = D ( 'HatArea' )->where(array('area_id'=>$val['area']))->getField('area');
			$dataList[$key]['str'] = $province.'-'.$city.'-'.$area.'-'.$val['intro'];
		}
		$this->assign('dataList',$dataList);
		$this->display();
	}
	// 新增地址
	public function add() {
		if (IS_POST && IS_AJAX) {
			$data = $_POST;
			$http_referer = $data['http_referer'];
			$areaId = I('post.areaId');
			$area =  D ( 'HatArea' )->where(array('id'=>$areaId))->find();
			$city =  D ( 'HatCity' )->where(array('city_id'=>$area['father']))->find();
			$province =  D ( 'HatProvince' )->where(array('province_id'=>$city['father']))->find();
			$data['area'] = $area['area_id'];
			$data['city'] = $city['city_id'];
			$data['province'] = $province['province_id'];
			$data['uid'] = $_SESSION['member_auth']['id'];
			$isExit['uid'] = $_SESSION['member_auth']['id'];
			$isExit['is_delete'] =0;
			$isExit['is_default'] = 1;
			$isExits = D( 'Address' )->where($isExit)->select();
			if(!D( 'Address' )->where($isExit)->select()){
				$data['is_default'] = 1;
			}
			// 判断是否默认，如果此条地址为默认，则把其它的地址全部修改为非默认
			if ( $data['is_default'] == 1 ) {
				D( 'Address' )->where( array( 'mid' => $this->member['id']) )->save( array( "is_default" => 0 ) );
			}
			$return = D( 'Address' )->insert( $data );
			$outPut = array('status'=>0,'msg'=>'');
			
			if ( $return['status'] ) {
				$theLink = strpos( $http_referer, "add_order" ) !== false || strpos( $http_referer, "goBuyNow" ) !== false ? $http_referer : U( 'Address/index' );
				$outPut['status'] = 1;
				$outPut['msg'] = $theLink;
			} else {
				$outPut['msg'] = '添加地址失败';
			}
			$this->ajaxReturn ( $outPut );
		} else {
			// 获取省列表
			$this->assign ( 'province', D ( 'HatProvince' )->getList () );
			
			// 渲染模板
			$this->display ();
		}
	}
	
	// 编辑地址
	public function edit() {
		if (IS_POST) {
			$data = $_POST;
			$http_referer = $data['http_referer'];
			$areaId = I('post.areaId');
			$area =  D ( 'HatArea' )->where(array('id'=>$areaId))->find();
			$city =  D ( 'HatCity' )->where(array('city_id'=>$area['father']))->find();
			$province =  D ( 'HatProvince' )->where(array('province_id'=>$city['father']))->find();
			$data['area'] = $area['area_id'];
			$data['city'] = $city['city_id'];
			$data['id'] = I('post.id');
			$data['province'] = $province['province_id'];
			$data['uid'] = $_SESSION['member_auth']['id'];
			$isExit['uid'] = $_SESSION['member_auth']['id'];
			$isExit['is_delete'] =0;
			$isExit['is_default'] = 1;
			$isExits = D( 'Address' )->where($isExit)->select();
			if(!D( 'Address' )->where($isExit)->select()){
				$data['is_default'] = 1;
			}
			// 判断是否默认，如果此条地址为默认，则把其它的地址全部修改为非默认
			if ( $data['is_default'] == 1 ) {
				D( 'Address' )->where( array( 'mid' => $this->member['id']) )->save( array( "is_default" => 0 ) );
			}
			$return = D( 'Address' )->save( $data );
			$outPut = array('status'=>0,'msg'=>'');
			
			if ( $return ) {
				$theLink = strpos( $http_referer, "add_order" ) !== false || strpos( $http_referer, "goBuyNow" ) !== false ? $http_referer : U( 'Address/index' );
				$outPut['status'] = 1;
				$outPut['msg'] = $theLink;
			} else {
				$outPut['msg'] = '修改地址失败';
			}
			$this->ajaxReturn ( $outPut );
		} else {
			$id = I( 'get.id', 0 );
			if ( empty( $id ) || !is_numeric( $id ) ) {
				$this->error( '非法操作' );
			}
			$dataInfo = D( 'Address' )->getOne( $id );
			$dataInfo['area'] = D ( 'HatArea' )->where(array('area_id'=>$dataInfo['area']))->find();
			$dataInfo['city'] = D ( 'HatCity' )->where(array('city_id'=>$dataInfo['city']))->find();
			$dataInfo['province'] = D ( 'HatProvince' )->where(array('province_id'=>$dataInfo['province']))->find();
			// 获取省列表
			$this->assign ( 'province', D ( 'HatProvince' )->getList () );
			// 当前数据
			$this->assign( 'dataInfo',$dataInfo );			
			// 渲染模板
			$this->display ();
		}
	}
	
	// 修改收货地址
	public function update() {
		$address = $_POST;
		if (! empty ( $address )) {
			$Address = D ( 'Address' );
			$address = $Address->update ( $address );
		}
		$this->assign ( 'address', $address );
		
		$this->redirect ( 'Address/index', array (
				'id' => $address ['user_id'] 
		) );
	}
	
	// 删除
	public function delete() {
		$id = $_GET ['id'];
		$outPut = array('status'=>0,'msg'=>'');
		if (empty ( $id ) || ! is_numeric ( $id )) {
			$outPut['msg']='请勿非法操作!';
		}else{
			if (! empty ( $id )) {
				$Address = D ( 'Address' );
				$up = $Address->remove ( $id );
				if($up){
					$outPut['status'] = 1;
					$outPut['msg'] = '操作成功';
				}else{
					$outPut['status'] = 0;
					$outPut['msg'] = '操作失败';
				}
			}
		}
		$this->ajaxReturn ( $outPut );
		// $this->display("index");
	}
	
	/**
	 * 获取联动市
	 */
	public function getCity() {
		$father = $_POST ['father'];
		$city = $_POST ['city'];
		if (empty ( $father )) {
			die ( "数据错误" );
		}
		$HatCityModel = D ( 'HatCity' );
		$theArray = $HatCityModel->GetTableList ( $father );
		foreach ($theArray as $key=>$val){
			$HatAreaModel = D ( 'HatArea' );
			$theArray[$key]['son'] = $HatAreaModel->GetTableList ( $val['city_id'] );
		}
		$this->assign ( 'dataList', $theArray );
		$this->display('_add');
	}
	
	/**
	 * 获取联动县/区
	 */
	public function getArea() {
		$father = $_POST ['father'];
		$area = $_POST ['area'];
		if (empty ( $father )) {
			die ( "<option value=''>数据读取错误</option>" );
		}
		$HatAreaModel = D ( 'HatArea' );
		$theArray = $HatAreaModel->GetTableList ( $father );
		for($i = 0, $length = count ( $theArray ); $i < $length; $i ++) {
			$default = $area == $theArray [$i] ['area_id'] ? " selected='selected'" : "";
			echo "<option value=\"{$theArray[$i]['area_id']}\"$default>{$theArray[$i]['area']}</option>";
		}
	}
	/**
	 * 设置默认
	 */
	public function is_default() {
		$id = $_GET ['id'];
		$outPut = array('status'=>0,'msg'=>'');
		if (empty ( $id ) || ! is_numeric ( $id )) {
			$outPut['msg']='请勿非法操作!';
		}else{
			if (! empty ( $id )) {
				$Address = D ( 'Address' );
				//全部设置为非默认
				D( 'Address' )->where( array( 'mid' => $this->member['id']) )->save( array( "is_default" => 0 ) );
				$data['id'] = $id;
				$data['is_default'] = 1;
				$up = $Address->save ( $data );
				if($up){
					$outPut['status'] = 1;
					$outPut['msg'] = '操作成功';
				}else{
					$outPut['status'] = 0;
					$outPut['msg'] = '操作失败';
				}
			}
		}
		$this->ajaxReturn ( $outPut );
		// $this->display("index");
	}
}
