<?php
namespace Home\Model;

/**
 * 商品分类模型
 *
 * @author 
 *        
 */
class CommodityClassModel extends CommModel {

	/**
	 * 递归获取所有分类
	 */
	public function getAllList($pid = 0) {
		$condition = array ('pid' => $pid,'status' => 0,'is_delete' => 0 );
		$dataList = $this->getList ( $condition, "id,pid,title,picture" );
		for($i = 0, $size = count ( $dataList ); $i < $size; $i ++) {
			$dataList [$i] ['children'] = $this->getAllList ( $dataList [$i] ['id'] );
		}
		return count ( $dataList ) > 0 ? $dataList : array ();
	}
	/**
	 * 返回数组的维度
	 * @param [type] $arr [description]
	 * @return [type] [description]
	 */
	function arrayLevel($arr){
		$al = array(0);
		function aL($arr,&$al,$level=0){
			if(is_array($arr)){
				$level++;
				$al[] = $level;
				foreach($arr as $v){
					aL($v,$al,$level);
				}
			}
		}
		aL($arr,$al);
		return max($al);
	}
	/**
	 * 返回当前分类下的所有子分类id
	 *
	 * @param int $theId
	 */
	public function returnChildId($theId=0) {
		$returnMsg = $this->query ( "CALL getChildId({$theId})" );
		return $returnMsg[0] ['child_id_list'];
	}
}