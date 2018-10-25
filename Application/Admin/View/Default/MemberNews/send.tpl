<div class="pageContent">
    <form method="post" action="__URL__/send" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone)" >
    	<input type="hidden" name="tag" value="add" />
        <div class="pageFormContent" layoutH="68">
        	<div class="unit">
                <label>消息标题：</label>
				<input type="text" name="title" value=""  class="required" />
            </div>
        	<div class="unit">
                <label>消息内容：</label>
				<textarea name="intro" class="intro2 required"></textarea>
            </div>
            <div class="unit">
                <label>选择接收组：</label>
				<div class="treeBox" style="width:70%;float:left;">
					{$role}
				</div>
            </div>
			
        </div>
        <div class="formBar">
            <ul>
                     <li>
                        <div class="buttonSave">
                            <div class="buttonSaveContent">
                                <button type="submit">
                            		<i class="iconfont">&#xe644;</i>发送
                                </button>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="buttonCancel">
                            <div class="buttonCancelContent">
                                <button type="button" class="close">
                                	<i class="iconfont">&#xe640;</i>取消
                                </button>
                            </div>
                        </div>
                    </li>
            </ul>
        </div>
    </form>
</div>