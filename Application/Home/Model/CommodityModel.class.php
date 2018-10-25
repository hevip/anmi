<?php
namespace Home\Model;

/**
 * 商品模型
 *
 * @author BoBo
 *        
 */
class CommodityModel extends CommModel {

	/**
	 * 获取每个主分类推荐商品[5个]列表
	 */
	public function getIndexList() {
		$tempCondition = array ('is_delete' => 0,'status' => 0,'pid' => 0 );
		$tempList = D ( 'CommodityClass' )->getList ( $tempCondition, 'id,title' );
		for($i = 0, $size = count ( $tempList ); $i < $size; $i ++) {
			$tempList [$i] ['list'] = $this->query ( "CALL getChildList({$tempList[$i]['id']},5)" );
		}
		return $tempList;
	}

	/**
	 * 返回当前分类下的所有子分类id
	 *
	 * @param int $theId
	 */
	public function returnChildId($theId) {
		$returnMsg = $this->query ( "CALL getChildId({$theId})" );
		return $returnMsg[0] ['child_id_list'];
	}
}