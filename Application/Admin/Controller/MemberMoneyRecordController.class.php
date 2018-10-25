<?php
namespace Admin\Controller;

/**
 * 钱包收支明细 控制器
 * 
 * @author BoBo
 *
 */
class MemberMoneyRecordController extends CommController {
    
    /**
     * 构造函数
     */
    public function _initialize() {
        parent::_initialize();
        // 模型
        $this->model = D( 'MemberMoneyRecord' );
    }

    /**
     * 会员信息列表
     */
    public function index() {
       // 设置查询字段
		$field = "a.price,a.balance,a.create_time,a.order";
		$field .= ",b.title as type_name";
		$field .= ",c.order_id";
		$field .= ",d.username,d.nickname,d.referral_code";
		// 设置查询条件
		$sql = "select $field from db_member_money_record as a";
		$sql .= " left join db_category as b on b.id = a.type";
		$sql .= " left join db_order as c on c.id = a.order";
		$sql .= " left join db_member as d on d.id = a.uid";
		$sql .= " where a.is_delete = 0";
		// 设置排序条件
		$order .= "a.create_time desc";

		// 读取数据
		$this->dataList = $this->model->getSQLList( $sql, array( 'begin' => 0, 'num' => 0 ), $order );
		$this->assign( 'dataList', $this->dataList );

		// 渲染视图
		$this->display();
    }
}