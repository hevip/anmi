<div class="pageContent">
    <form method="post" action="__URL__/create/" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone)">
        <input type="hidden" name="pid" value="{$paramter['pid']}" />
        <div class="pageFormContent" layoutH="68">
        	
			<div class="unit">
				<label>分组标题：</label>
				<input type="text" name="title" value="" class="required" />
			</div>
			<div class="unit">
				<label>分组名称：</label>
				<input type="text" name="name" value="" class="required" />
			</div>
			<div class="unit">
				<label>简介：</label>
				<input type="text" name="intro" value="" class="required" />
			</div>
			<div class="unit">
				<label>图标代码：</label>
				<input type="text" name="icon" value="" class="required" />
			</div>
			<if condition="$paramter['pid'] gt 0">
			<div class="unit">
				<label>是否继承父级：</label>
				<label style="width:auto;">
					<input type="radio" name="inherit" value="1" class="required" checked="checked" />&nbsp;&nbsp;是
				</label>
				<label style="width:auto;">
					<input type="radio" name="inherit" value="0" class="required" />&nbsp;&nbsp;否
				</label>
			</div>
			</if>
			<div class="unit">
				<label>排　　序：</label>
				<input type="text" name="sort" value="0" class="required" />
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