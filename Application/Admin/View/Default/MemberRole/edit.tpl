<div class="pageContent">
    <form method="post" action="__URL__/update/" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone)">
        <input type="hidden" name="id" value="{$dataInfo['id']}" />
        <div class="pageFormContent" layoutH="68">
        	
			<div class="unit">
				<label>组名：</label>
				<input type="text" name="title" value="{$dataInfo['title']}" class="required" />
			</div>
			<div class="unit">
				<label>描述：</label>
				<textarea name="intro">{$dataInfo['intro']}</textarea>
			</div>
			<div class="unit">
				<label>排　　序：</label>
				<input type="text" name="sort" value="{$dataInfo['sort']}" class="required" />
			</div>
			
        </div>
        <div class="formBar">
            <ul>
                     <li>
                        <div class="buttonSave">
                            <div class="buttonSaveContent">
                                <button type="submit">
                            		<i class="iconfont">&#xe644;</i>保存
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