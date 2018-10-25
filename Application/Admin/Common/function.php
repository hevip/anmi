<?php

/**
 * +-------------------------------------------------
 * + 获取商品的层级分类[商品列表处使用]
 * +-------------------------------------------------
 * + @param number $pid 商品所属分类ID
 * + @return string
 * +-------------------------------------------------
 */
function tmpl_commodityClassLevel($pid, $level = "") {
	$model = D ( 'CommodityClass' );
	if (! empty ( $pid )) {
		$tempInfo = $model->getOne ( $pid );
		$level = empty( $level ) ? "" : "/$level";
		$level = $tempInfo['title'] . $level;
		if ($tempInfo ['pid'] > 0) {
			return tmpl_commodityClassLevel( $tempInfo['pid'], $level );
		} else {
			return "商品分类：" . $level;
		}
	}
}

/**
 * +-------------------------------------------------
 * + 获取会员名称
 * +-------------------------------------------------
 * + @param number $id 会员ID
 * + @return string
 * +-------------------------------------------------
 */
function tmpl_getMemberName( $id ) {
	if ( is_number( $id ) ) {
		return '无';
	}
	$username = D( 'Member' )->getOne( $id, 'id', false, 'username' );
	return empty( $username ) ? '无' : $username;
}
/**
 +----------------------------------------------------------
 * 导出
 * @param $expTitle     string 文件名称
 * $expCellName         array  表头
 * @param $expTableData array  保存数据
 +----------------------------------------------------------
 */
function exportExcel($expTitle,$expCellName,$expTableData,$expWidth = array()){
	@ini_set('OUTPUT_ENCODE', false);
	$xlsTitle = iconv('utf-8', 'gb2312', $expTitle);//文件名称
	$fileName = $expTitle;//or $xlsTitle 文件名称可根据自己情况设定
	$cellNum = count($expCellName);
	$dataNum = count($expTableData);
	vendor( 'PHPExcel.Classes.PHPExcel' );
	$objPHPExcel = new \PHPExcel();
	$cellName = array('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','AA','AB','AC','AD','AE','AF','AG','AH','AI','AJ','AK','AL','AM','AN','AO','AP','AQ','AR','AS','AT','AU','AV','AW','AX','AY','AZ');
	foreach ($cellName as $k=>$v){
		$objPHPExcel->getActiveSheet()->getStyle($v)->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);//所有居中
		if(!empty($expWidth) && $expWidth[$k]){
			$objPHPExcel->getActiveSheet()->getColumnDimension($v)->setWidth($expWidth[$k]);//每列长度
		}
		$objPHPExcel->getActiveSheet()->getRowDimension($k + 2)->setRowHeight(22);//设置行高
	}
	//对表头进行特殊处理
	$objPHPExcel->getActiveSheet()->getRowDimension(1)->setRowHeight(30);//设置行高
	$objPHPExcel->getActiveSheet()->getStyle(1)->getFont()->setSize(15);
	$objPHPExcel->getActiveSheet()->getStyle(1)->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);//所有居中
	$objPHPExcel->getActiveSheet(0)->mergeCells('A1:'.$cellName[$cellNum-1].'1');//合并单元格
	$objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', $expTitle.'  导出时间 : '.date('Y-m-d H:i:s'));
	for($i=0;$i<$cellNum;$i++){
		$objPHPExcel->setActiveSheetIndex(0)->setCellValue($cellName[$i].'2', $expCellName[$i][1]);
	}
	// Miscellaneous glyphs, UTF-8
	for($i=0;$i<$dataNum;$i++){
		for($j=0;$j<$cellNum;$j++){
			$objPHPExcel->getActiveSheet(0)->setCellValue($cellName[$j].($i+3), $expTableData[$i][$expCellName[$j][0]]);
		}
	}

	header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
	header('Content-Disposition: attachment;filename="'.$xlsTitle.'.xls"');
	header('Cache-Control: max-age=0');
	$objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
	$objWriter->save('php://output');
	exit;
}