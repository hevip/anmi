<?php
namespace Home\Controller;

/**
 * 会员奖金控制器
 *
 * @author BoBo
 *        
 */
class RewardController extends CommController {

	/**
	 * 构造函数
	 */
	public function _initialize() {
		parent::_initialize ();
		$this->checkLogin ();
	}

	/**
	 * 奖金主页
	 */
	public function index(){
		//交易量的计算
		$data['uid'] = $this->member['id'];
		//分销提成交易
		$commission = D('MemberCommission')->where($data)->count();
		//消费提成交易
		$consume = D('MemberConsume')->where($data)->count();
		$this->assign('count',$consume+$commission);
		$this->display();
	}

	/**
	 * 奖金的支出 来源 明细：此处关联许多的表  现在暂时消费提成  分销提成2种收入 转入钱包 1种支出
	 */
	public function details_backup(){
		$data['uid'] = $this->member['id'];
		$commission = D('MemberCommission')->where($data)->select();//分销
		$consume = D('MemberConsume')->where($data)->select();//消费
		$package = D('RewardMoney')->where($data)->select();//转入钱包
		$showList = array();
		$i = 0 ;
		foreach ($commission as $key=>$val){
			$showList[$i] = $val;
			$showList[$i]['price'] = $val['build_price'];
			$showList[$i]['cate'] = $this->getCategoryById(22);
			$showList[$i]['sign'] = '+';
			$i++;
			$showList[$i] = $val;
			$showList[$i]['price'] = $val['manage_price'];
			$showList[$i]['cate'] = $this->getCategoryById(23);
			$showList[$i]['sign'] = '+';
			$i++;
		}
		foreach ($consume as $key=>$val){
			$showList[$i] = $val;
			$showList[$i]['price'] = $val['mission_price'];
			$showList[$i]['cate'] = $this->getCategoryById(25);
			$showList[$i]['sign'] = '+';
			$i++;
		}
		foreach ($package as $key=>$val){
			$showList[$i] = $val;
			$showList[$i]['cate'] = $this->getCategoryById(27);
			$showList[$i]['sign'] = '-';
			$i++;
		}
		//按时间排序
		$showList = $this->sortByKey($showList,'create_time');
		$nowWard = $this->member['reward'];
		foreach($showList as $key=>$val){
			
			if($key==0){
				$showList[$key]['end_price'] = $nowWard;
			}elseif($val['price'] <= 0){
				
				unset($showList[$key]);
			}else{
				if($showList[$key-1]['sign'] == '+'){
					$nowWard = $nowWard-$showList[$key-1]['price'];
					$showList[$key]['end_price'] = $nowWard;
				}else{
					$nowWard = $nowWard+$showList[$key-1]['price'];
					$showList[$key]['end_price'] = $nowWard;
				}
			}			
		}
		$this->assign('showList',$showList);
		$this->display();
	}

	/**
	 * 奖金明细记录
	 */
	public function details() {
		// 设置查询字段
		$field = "a.price,a.balance,a.create_time,a.status";
		$field .= ",b.title as type_name";
		// 设置查询条件
		$sql = "select $field from db_reward_money as a";
		$sql .= " left join db_category as b on b.id = a.type";
		$sql .= " where a.is_delete = 0 and a.uid = {$this->member['id']}";
		// 设置排序条件
		$order .= "a.create_time desc";

		// 读取数据
		$this->dataList = D( 'RewardMoney' )->getSQLList( $sql, array( 'begin' => 0, 'num' => 0 ), $order );
		$this->assign( 'dataList', $this->dataList );

		// 渲染视图
		$this->display();
	}


	/**
	 * 转账到钱包
	 */
	public function goPackage(){
		if(IS_AJAX){
			// 奖励转入钱包
			$outPut = array('status'=>0,'msg'=>'');
			$money = I('post.money', 0);
			if($money > $this->member['reward']){
				$outPut['msg'] = '没有足够的金额转入';
			}else{
				// 更新钱包和奖金信息
				$data['id'] = $this->member['id'];
				$data['reward'] = $this->member['reward'] - $money;
				$data['use_reward'] = $this->member['use_reward'] + $money;
				$data['money'] = $this->member['money'] + $money;
				$isMember = D('Member')->save($data);

				// 取得奖金余额
				$rewardBalance = $data['reward'];
				// 取得钱包余额
				$moneyBalance = $data['money'];

				//将转入钱包明细记入钱包明细表
				$data = array();
				$data['uid'] = $this->member['id'];
				$data['price'] = $money;
				$data['balance'] = $moneyBalance;
				$data['type'] = 34;
				$data['create_time'] = time();
				$isMemberMoneyRecord = D('MemberMoneyRecord')->add($data);

				//将转入钱包明细记入奖金明细表
				$data = array();
				$data['uid'] = $this->member['id'];
				$data['price'] = -$money;
				$data['balance'] = $rewardBalance;
				$data['type'] = 27;
				$data['status'] = 1;
				$data['create_time'] = time();
				$isRewardMoney = D('RewardMoney')->add($data);

				if( $isMember && $isMemberMoneyRecord && $isRewardMoney ){
					$outPut['status'] = 1;
					$outPut['msg'] = '金额转入成功';
				}else{
					$outPut['msg'] = '金额转入失败，请联系管理员';
				}
			}
			$this->ajaxReturn ( $outPut );
		}else{
			$this->display();
		}
	}

	/**
	 * 钱包使用说明
	 */
	public function reward_intro(){
		$dataInfo = D('WebIntroduce')->where(array('id'=>2))->find();
		$this->assign ( 'dataInfo', $dataInfo );
		// 渲染视图
		$this->display ();
	}

	/**
	 *交易明细
	 */
	public function recode(){
		$data['uid'] = $this->member['id'];
		$commission = D('MemberCommission')->where($data)->select();//分销
		$consume = D('MemberConsume')->where($data)->select();//消费
		$i =0;
		foreach ($commission as $key=>$val){
			$showList[$i] = $val;
			$showList[$i]['price'] = $val['build_price'] + $val['manage_price'];
			$member = D('Member')->where(array('id'=>$val['from_id']))->find();
			$this->getNumberById($member['recommended_code']);
			$layer = $this->layer;
			$chinesenumber = $this->getChineseNumber($layer);
			$showList[$i]['showStr'] = $chinesenumber.'级分销会员';
			$showList[$i]['member'] = json_decode($member['wx_name'])?json_decode($member['wx_name']):$member['username'];
			$showList[$i]['orderprice'] = D('Order')->where(array('id'=>$val['order_id']))->getField('price');
			$showList[$i]['face'] = $member['face'];
			$showList[$i]['my_price'] = $val['build_price']+$val['manage_price'];
			$i++;
		}
		foreach ($consume as $key=>$val){
			$showList[$i] = $val;
			$showList[$i]['price'] = $val['mission_price'];
			$showList[$i]['showStr'] = '个人消费';
			$showList[$i]['member'] = $this->member['wx_name']?$this->member['wx_name']:$this->member['username'];
			$showList[$i]['orderprice'] = D('Order')->where(array('id'=>$val['order_id']))->getField('price');
			$showList[$i]['my_price'] = $val['mission_price'];
			$showList[$i]['face'] = $this->member['face'];
			$i++;
		}
		//按时间排序
		$showList = $this->sortByKey($showList,'create_time');
		$this->assign ( 'dataList', $showList );
		$this->display();
	}
	/**
	 * 根据id获取分类名称
	 */
	protected function getCategoryById($id){
		$title = D('Category')->where(array('id'=>$id))->getField('title');
		return $title;
	}
	/**
	 * 将数组按照某字段进行排序 
	 */
	protected function sortByKey($list,$keys){
		$id = $data = array();
		foreach($list as $key => $value){
		    $id[$key] = $value[$keys];
		}       
		array_multisort($id, SORT_DESC, $list);
		return $list;
	}
	/**
	 * 判断属于此会员的第几级分销
	 */
	public $layer = 0;
	protected function getNumberById($recommended_code,$layer = 1){
		$referral_code = $this->member['referral_code'];
		
		if($referral_code==$recommended_code){
			$this->layer = $layer;
			return  $this->layer;
		}else{
			$member = D('Member')->where(array('referral_code'=>$recommended_code))->find();
			$layer++;
			$this->getNumberById($member['recommended_code'],$layer);
		}
		
	}
	protected function getChineseNumber($num){
		$chiNum = array('零', '一', '二', '三', '四', '五', '六', '七', '八', '九');
		$chiUni = array('','十', '百', '千', '万', '亿', '十', '百', '千');
		$chiStr = '';
		$num_str = (string)$num;
		$count = strlen($num_str);
		$last_flag = true; //上一个 是否为0
		$zero_flag = true; //是否第一个
		$temp_num = null; //临时数字
		$chiStr = '';//拼接结果
		if ($count == 2) {//两位数
			$temp_num = $num_str[0];
			$chiStr = $temp_num == 1 ? $chiUni[1] : $chiNum[$temp_num].$chiUni[1];
			$temp_num = $num_str[1];
			$chiStr .= $temp_num == 0 ? '' : $chiNum[$temp_num];
		}else if($count > 2){
			$index = 0;
			for ($i=$count-1; $i >= 0 ; $i--) {
				$temp_num = $num_str[$i];
				if ($temp_num == 0) {
					if (!$zero_flag && !$last_flag ) {
						$chiStr = $chiNum[$temp_num]. $chiStr;
						$last_flag = true;
					}
				}else{
					$chiStr = $chiNum[$temp_num].$chiUni[$index%9] .$chiStr;
	
					$zero_flag = false;
					$last_flag = false;
				}
				$index ++;
			}
		}else{
			$chiStr = $chiNum[$num_str[0]];
		}
		return $chiStr;
	}

	// 申请提现
	public function postal() {
		$this->display();
	}

	/**
	 * 申请提现-提到银行卡
	 */
	public function my_coins_withdraw() {
		$this->display();
	}

	/**
	 * 申请提现-提到微信
	 */
	public function my_coins_wechat() {
		$this->assign ( 'isWebChat', strpos ( $_SERVER ['HTTP_USER_AGENT'], 'MicroMessenger' ) !== false ? true : false );
		$this->display();
	}

	/**
	 * 银行卡提现
	 */
	public function tixian(){
		$integral=$this->member['reward'];
		$outPut = array('status'=>0,'info'=>'');
		$data = I('post.');
		if ($integral<$data['price']) {
			$outPut['info'] = '余额不足';
		}else{
			// 提交提现记录
			$data['uid']=$this->member['id'];
			$data['create_time']=time();
			$isMemberWithdraw = D('MemberWithdraw')->add($data);
			$withdrawId = D('MemberWithdraw')->getLastInsID();
			
			// 更新会员奖金余额
			$member['id'] = $this->member['id'];
			$member['reward'] = $this->member['reward'] - $data['price'];
			$member['use_reward'] = $this->member['use_reward'] + $data['price'];
			$isMember = D('Member')->save($member);

			// 将提现明细记入奖金明细表
			$reward = array();
			$reward['uid'] = $this->member['id'];
			$reward['price'] = -$data['price'];
			$reward['balance'] = $member['reward'];
			$reward['type'] = $data['type'];
			$reward['withdraw_id'] = $withdrawId;
			$reward['create_time'] = time();
			$isRewardMoney = D('RewardMoney')->add($reward);
			
			if ( $isMemberWithdraw && $isMember && $isRewardMoney ) {
				$outPut['status'] = 1;
				$outPut['info'] = '提现申请提交成功';
			}else{
				$outPut['info'] = '提现失败';
			}
		}
		$this->ajaxReturn ( $outPut );
	}

	/**
	 * 微信提现
	 */
	public function WXWithdraw() {
		$integral=$this->member['reward'];
		$outPut = array('status'=>0,'info'=>'');
		$data = I('post.');
		if ($integral<$data['price']) {
			$outPut['info'] = '余额不足';
		}else{
			if($this->config['is_postal_check']){
				//查看是否已经有提现得申请
				$withdrawIdCon['status'] = 1;
				$withdrawIdCon['uid'] = $this->member['id'];
				$is_exits = D('MemberWithdraw')->where($withdrawIdCon)->find();
				if($is_exits){
					$this->error('您上次提交得申请还未审核，请等待我们的审核');
				}
				$json = D('Member')->where(array('id'=>$this->member['id']))->getField('postal_times');
				$todayTime= strtotime(date('Ymd'));
				$array = json_decode($json,true);
				$postal_number = $this->config['postal_number'];
				$newArray = array();
				if($array['last_time']>$todayTime){
					if($array['times'] >= $postal_number){
						$this->error('您今天提交得申请次数已达到上限。请明天再来');exit;
					}else{
						$newArray['last_time'] = time();
						$newArray['times'] = $array['times']+1;
					}
				}else{
					$newArray['last_time'] = time();
					$newArray['times'] = 1;
				}
				D('Member')->where(array('id'=>$this->member['id']))->update(array('postal_times'=>json_encode($newArray)));
			}
			// 提交提现记录
			$data['uid']=$this->member['id'];
			$data['create_time']=time();
			$isMemberWithdraw = D('MemberWithdraw')->add($data);
			$withdrawId = D('MemberWithdraw')->getLastInsID();
			// 将提现明细记入奖金明细表
			$reward = array();
			$reward['uid'] = $this->member['id'];
			$reward['price'] = -$data['price'];
			$reward['balance'] = $member['reward'];
			$reward['type'] = $data['type'];
			$reward['withdraw_id'] = $withdrawId;
			$reward['create_time'] = time();
			$isRewardMoney = D('RewardMoney')->add($reward);
			
			if($this->config['is_postal_check']){
				//将提交申请做记录
				$this->success('提现申请提交成功，我们将在2个工作日内进行提现');exit;
			}else{
				// 更新会员奖金余额
				$member['id'] = $this->member['id'];
				$member['reward'] = $this->member['reward'] - $data['price'];
				$member['use_reward'] = $this->member['use_reward'] + $data['price'];
				$isMember = D('Member')->save($member);
			}
			if ( $isMemberWithdraw && $isMember && $isRewardMoney ) {
				$outPut['status'] = 1;
				$outPut['info'] = '提现申请提交成功';
			}else{
				$outPut['info'] = '提现失败';
			}
		}
		// 记录添加成功，执行转账操作
		if ( $outPut['status'] ) {
			header("Location:" . U( 'WXWithdraw/handleWebchat',array( 'id'=>$withdrawId ) ) );
		} else {
			$this->error( $outPut['info'] );
		}
	}

}