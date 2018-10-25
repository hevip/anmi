<div class="pageContent">
    <form method="post" action="__URL__/update/" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone)">
        <input type="hidden" name="id" value="{$dataInfo['id']}" />
        <div class="pageFormContent" layoutH="68">
        	
			<div class="unit">
				<label>分组标题：</label>
				<input type="text" name="title" value="{$dataInfo['title']}" class="required" />
			</div>
			<div class="unit">
				<label>分组名称：</label>
				<input type="text" name="name" value="{$dataInfo['name']}" class="required" />
			</div>
			<div class="unit">
				<label>简介：</label>
				<input type="text" name="intro" value="{$dataInfo['intro']}" class="required" />
			</div>
			<div class="unit">
				<label>图标代码：</label>
				<input type="text" name="icon" value="{$dataInfo['icon']}" class="required" />
			</div>
			<if condition="$dataInfo['pid'] gt 0">
			<div class="unit">
				<label>是否继承父级：</label>
				<label style="width:auto;">
				<if condition="$dataInfo['inherit'] eq 1">
					<input type="radio" name="inherit" value="1" class="required" checked="checked" />&nbsp;&nbsp;是
				<else />
					<input type="radio" name="inherit" value="1" class="required" />&nbsp;&nbsp;是
				</if>
				</label>
				<label style="width:auto;">
				<if condition="$dataInfo['inherit'] eq 0">
					<input type="radio" name="inherit" value="0" class="required" checked="checked" />&nbsp;&nbsp;否
				<else />
					<input type="radio" name="inherit" value="0" class="required" />&nbsp;&nbsp;否
				</if>
				</label>
			</div>
			</if>
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