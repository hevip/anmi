<div class="pageContent">
    <form method="post" action="__URL__/update/" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone)">
        <input type="hidden" name="id" value="{$dataInfo['id']}" />
        <div class="pageFormContent" layoutH="68">
        	
			<!--div class="unit">
				<label>所属分组：</label>
				<select name="group_id" class="required">
					<option value="">请选择分组 </option>
					<volist name="groupList" id="volist">
					<if condition="$volist['id'] eq $dataInfo['group_id']">
						<option value="{$volist['id']}" selected="selected">{$volist['title']}</option>
					<else />
						<option value="{$volist['id']}">{$volist['title']}</option>
					</if>
					</volist>
				</select>
			</div-->
			<div class="unit">
				<label>分组标题：</label>
				<input type="text" name="title" value="{$dataInfo['title']}" class="required" />
			</div>
			<div class="unit">
				<label>分组名称：</label>
				<input type="text" name="name" value="{$dataInfo['name']}" class="required" />
			</div>
			<div class="unit">
				<label>是否显示为菜单项：</label>
				<label style="width:auto;">
				<if condition="$dataInfo['is_nav'] eq 1">
					<input type="radio" name="is_nav" value="1" class="required" checked="checked" />&nbsp;&nbsp;是
				<else />
					<input type="radio" name="is_nav" value="1" class="required" />&nbsp;&nbsp;是
				</if>
				</label>
				<label style="width:auto;">
				<if condition="$dataInfo['is_nav'] eq 0">
					<input type="radio" name="is_nav" value="0" class="required" checked="checked" />&nbsp;&nbsp;否
				<else />
					<input type="radio" name="is_nav" value="0" class="required" />&nbsp;&nbsp;否
				</if>
				</label>
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