<div class="page">
<script type="text/javascript" src="__JS__/twoLinkage.js"></script>

    <div class="pageContent">
        <form method="post" action="__URL__/update" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone)" >
        	<input type="hidden" name="id" value="{$dataInfo['id']}" />
		<if condition="$dataInfo|count gt 0">
            <div class="pageFormContent" layoutH="58">
            	<div class="unit">
	                <label>订单号：</label>
	                <input type="text" name="order_id" value="{$dataInfo['order_id']}" class="required" />
	            </div>
	            <div class="unit">
	                <label>运单号：</label>
	                <input type="text" name="send_id"  class="required" />
	            </div>
	            <div class="unit" style="display: none">
	                <label>发货时间：</label>
	                <input type="text" name="send_time"  class="required" value="<?php echo time();?>"/>
	            </div>
	            <div class="unit" style="display: none">
	                <label>发货状态：</label>
	                <input type="text" name="is_send"  class="required" value="1"/>
	            </div>
            </div>
            <div class="formBar">
                <ul>
                    <li>
                        <div class="buttonActive">
                            <div class="buttonContent">
                                <button type="submit">保存</button>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="button">
                            <div class="buttonContent">
                                <button type="button" class="close">取消</button>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            </if>
        </form>
    </div>
</div>