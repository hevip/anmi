<!-- 添加 -->
<div class="pageContent">
<script type="text/javascript" src="__JS__/twoLinkage.js"></script>

    <form method="post" action="__URL__/create" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone)" >
        <div class="pageFormContent" layoutH="58">
            <div class="unit">
                <label>商品名称：</label>
                <input type="text" name="title" value="" class="required" />
            </div>
            <div class="unit">
                <label>封面图：</label>
                <input type="hidden" name="picture" value=""/>
                <input type="file" name="uploadify" id="picture" class="uploadify" />
                <div class="picture oneImage"></div>
            </div>
           	<div class="unit">
                <label>所需积分：</label>
                <input type="text" name="integral" value="0" class="required" />
            </div>
           
            <div class="unit">
                <label>排序：</label>
                <input type="text" name="sort" value="0" class="required" />
            </div>
            <div class="unit">
                <label>商品简介：</label>
                <textarea name="intro" style="height:80px;width:60%;" ></textarea>
            </div>
            <div class="unit">
                <label>商品详情：</label>
                <textarea name="content" class="kindeditor" tools="full" style="height:200px;width:80%;" ></textarea>
            </div>
            <div class="unit">
                <label>是否上架：</label>
                <label class="inline"><input name="status" checked="true" type="radio" value="0" />是</label>
                <label class="inline"><input name="status" type="radio" value="1" />否</label>
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
    </form>
</div>